.include "src/includes/sound_defines.asm"
.include "src/includes/sound_macros.asm"

.BANK 2 SLOT 2
.ORG $0000
Bank2:

; =============================================================================
; Sound_Update()
; -----------------------------------------------------------------------------
;  Main sound driver entrypoint. Called once per frame (vblank).
; -----------------------------------------------------------------------------
;  In:
;    None.
;  Out:
;    None.
; -----------------------------------------------------------------------------
Sound_Update:       ; $8000
    ; check the reset trigger and intialise the PSG
    ; if required
    ld    hl, Sound_ResetTrg
    ld    a, (hl)
    or    a
    jr    z, +
    
    ; if MSB is reset the sound driver is disabled
    ret   p

    dec   (hl)
    jp    Sound_InitPSG

+:  ; read music trigger and copy to "current sound"
    call  Sound_CheckSoundTriggers
    
    ; adjust channels to the correct tempo
    call  Sound_AdjustForSpeed
    
    ; check to see if the current music/sfx needs
    ; to be faded out
    call  Sound_FadeOut
    
    ; check the trigger byte. if it has changed we
    ; need to load a new music/sfx module
    call  Sound_CheckLoadMusic
    
    ld    a, ($DE91)
    or    a
    jp    z, Sound_UpdateChannels
    
    ld    a, ($DE92)
    inc   a
    cp    $05
    jr    z, LABEL_802D_123
    ld    ($DE92), a
    
    jp    Sound_UpdateChannels

LABEL_802D_123:
    xor   a
    ld    ($DE92), a
    call  Sound_UpdateChannels
    call  Sound_UpdateChannels
    ret


; =============================================================================
; Sound_UpdateChannels()
; -----------------------------------------------------------------------------
;  Updates each active channel structure.
; -----------------------------------------------------------------------------
;  In:
;    None.
;  Out:
;    None.
; -----------------------------------------------------------------------------
Sound_UpdateChannels:       ; $8038
    ld    ix, Sound_Channel_Music_0
    Sound_IsChannelActive
    call  nz, Sound_UpdateToneChannel
    
    ld    ix, Sound_Channel_Music_1
    Sound_IsChannelActive
    call  nz, Sound_UpdateToneChannel
    
    ld    ix, Sound_Channel_Music_2
    Sound_IsChannelActive
    call  nz, Sound_UpdateToneChannel
    
    ld    ix, Sound_Channel_Music_Noise
    Sound_IsChannelActive
    call  nz, Sound_UpdateNoiseChannel
    
    ld    ix, Sound_Channel_SFX_0
    Sound_IsChannelActive
    call  nz, Sound_UpdateToneChannel
    
    ld    ix, Sound_Channel_SFX_1
    Sound_IsChannelActive
    call  nz, Sound_UpdateToneChannel
    
    ld    ix, Sound_Channel_SFX_2
    Sound_IsChannelActive
    call  nz, Sound_UpdateToneChannel
    
    ret


; =============================================================================
;  Sound_AdjustForSpeed()
; -----------------------------------------------------------------------------
;  Inserts extra ticks into each channel's note duration counter so that
;  the module plays at the correct tempo.
; -----------------------------------------------------------------------------
;  In:
;    None.
;  Out:
;    None.
;  Destroys:
;    A, B, DE, HL
; -----------------------------------------------------------------------------
Sound_AdjustForSpeed:       ; $8086
    ld    hl, Sound_SpeedCounter        ;decrement counter value
    
    ; return if the speed counter is 0
    ld    a, (hl)
    or    a
    ret   z
    
    ; decrement the counter
    dec   (hl)
    ret   nz

    ; if we get here, the counter is zero. 
    ; reset the counter and insert an extra tick into each channel
    
    ; restore counter value
    ld    a, (Sound_Speed)
    ld    (hl), a
    
    ; add an extra tick to each channel
    ld    hl, Sound_Channel_Music_0 + Sound_ChnlToneDuration
    ld    de, Sound_ChannelSize        ;for the 4 channels
    ld    b, 4
    
-:  inc   (hl)
    add   hl, de
    djnz  -

    ret


; =============================================================================
; Sound_CheckSoundTriggers
; -----------------------------------------------------------------------------
;  Checks each of the 3 trigger bytes for new module numbers and, if the
;  priority value allows, copies the module index into the main trigger byte
;  at $DD03.
; -----------------------------------------------------------------------------
;  In:
;    None.
;  Out:
;    None.
; -----------------------------------------------------------------------------
Sound_CheckSoundTriggers:        ; $809F
    ; load a pointer to the sound triggers
    ld    de, $DD04
    ; pointer to the current sound's priority
    ld    ix, Sound_Priority
    ; pointer to current sound number
    ld    iy, $DD03
    
    ; check each trigger
    call  Sound_CheckSoundTriggers_CheckTrigger
    call  Sound_CheckSoundTriggers_CheckTrigger
Sound_CheckSoundTriggers_CheckTrigger:
    ; fetch the trigger value
    ld    a, (de)
    and   $7F               ;ignore MSB
    
    ; jump if the trigger is 0 (no new module)
    jr    z, +
    
    ; fetch a priority value for the module number
    dec   a
    ld    hl, Sound_Data_Priorities
    ld    c, a
    ld    b, $00
    add   hl, bc
    ld    a, (hl)

    ; if the current sound's priority is greater than the
    ; new sound's don't bother changing anything...
    cp    (ix + 0)
    jr    c, +            ;jump if $DD0F < A

    ; ...otherwise, set the new priority...
    and   $7F
    ld    (ix + 0), a        ;DD0F
    
    ; ... and copy module number to the main trigger
    ld    a, (de)
    ld    (iy + 0), a        ;DD03

+:  ; reset the trigger
    xor   a
    ld    (de), a
    ; move to the next trigger byte
    inc   de
    
    ret


; =============================================================================
; Sound_FadeOut()
; -----------------------------------------------------------------------------
;  Fades the volume of the primary tone channels by increasing attenuation.
;  If any sound effect channels are active they will be disabled.
; -----------------------------------------------------------------------------
;  In:
;    None.
;  Out:
;    None.
;  Destroys:
;    A, BC, DE, HL
; -----------------------------------------------------------------------------
Sound_FadeOut:           ; $80D0
    ; check to see if the volume fadeout counter
    ; has been set
    ld    a, (Sound_FadeMajorCount)
    or    a
    ret   z

    ; check that none of the sfx channels are active.
    ; if they are they should be disabled and the correct
    ; primary channel reactivated.
    
    ; load HL with a pointer to the first SFX channel
    ld    hl, $DE00
    
    ; loop 3 times
    ld    b, $03
    
    ; this will be used to move the pointer to the next channel
    ld    de, $0030

-:  ; check to see if the channel is active
    bit   Sound_ChannelActiveBit, (hl)
    jp    z, Sound_FadeOut_LoopNext

    push  hl
    
    ; check the PSG channel number
    inc   hl
    ld    a, (hl)
    
    ; check for tone 1 channel
    cp    $A0
    ; jump if channel != tone 1
    jp    nz, +

    ; chear the primary tone 1 channel's suppress bit
    ld    hl, $DD70
    res   Sound_ChannelSuppressBit, (hl)
    jp    Sound_FadeOut_DisableSFXChannel

    
+:  ; check for the noise channel
    cp    $E0
    ; jump if channel != noise
    jp    nz, ++

    ; clear the noise channel's suppress bit
    ld    hl, $DDD0
    res   Sound_ChannelSuppressBit, (hl)


++: ; clear the primary tone 2 channel's suppress bit
    ld    hl, $DDA0
    res   Sound_ChannelSuppressBit, (hl)


Sound_FadeOut_DisableSFXChannel:            ; $8101
    pop   hl
    ; clear channel control byte
    xor   a
    ld    (hl), a

Sound_FadeOut_LoopNext:
    add   hl, de
    djnz  -

    ; decrement the fadeout minor count
    ld    a, (Sound_FadeMinorCount)
    dec   a
    ; if the minor count value is 0 we need to
    ; reset it and decrement the major count
    jr    z, +
    ld    (Sound_FadeMinorCount), a
    
    ret


+:  ; reset the minor count value
    ld    a, (Sound_FadeMinorReset)
    ld    (Sound_FadeMinorCount), a
   
    ; decrement the major countdown value
    ld    a, (Sound_FadeMajorCount)
    dec   a
    ld    (Sound_FadeMajorCount), a
    ; reset the psg when the counter == 0
    jp    z, Sound_ResetAll
    
    ; load a pointer to the first channel's volume value
    ld    hl, Sound_Channel_Music_0 + Sound_ChnlVolumeAdjust
    ; DE will be added to HL to move the pointer to the next channel
    ld    de, Sound_ChannelSize
    ; loop 3 times (3 tone channels)
    ld    b, 3
    
-:  ; check and attenuate as necessary
    call  Sound_FadeOut_IncreaseAttenuation
    add   hl, de
    djnz  -

    ; adjust the noise channel volume
    ld    hl, Sound_NoiseChnlVolume

Sound_FadeOut_IncreaseAttenuation:      ; $8132
    ; if attenuation < $0C then increase
    ld    a, (hl)
    inc   a
    ; return if value >= $0C
    cp    $0C
    ret   nc
    
    ; store attenuation value
    ld    (hl), a
    
    ret


; =============================================================================
; Sound_CheckLoadMusic()
; -----------------------------------------------------------------------------
;  Checks the main trigger at $DD03 for a value > $80. If it finds such a
;  value it loads the relevant music/sfx data.
; -----------------------------------------------------------------------------
;  In:
;    ($DD03) - Music/SFX trigger
;  Out:
;    None.
;------------------------------------------------------------------------------
Sound_CheckLoadMusic:       ; $8139
    ; load "current music" number into A
    ld    a, ($DD03)
    ; if value < $80 reset the channels
    bit   7, a
    jp    z, Sound_ResetAll
    
    ; check to see if value corresponds to music slot
    ; (i.e. jump if A < $9A)
    cp    SFX_FirstSlot
    jr    c, Sound_LoadMusicModule
    
    ; check to see if value corresponds to SFX slot
    ; (i.e. jump if A is between $9A and $C0)
    cp    $C0
    jp    c, Sound_LoadSFXModule
    
    ; if value >= $C4 then reset the PSG
    cp    $C4
    jp    nc, Sound_ResetAll

    ; value is between $C0 and $C3. use as an index
    ; into the jump table below
    sub   $C0
    ld    hl, DATA_8158
    call  Sound_CalcIndex_Int16
    jp    (hl)


DATA_8158:
.dw LABEL_8160
.dw Sound_ResetAll
.dw Sound_StopSFX
.dw $7000

LABEL_8160:
    ; fade out over 216 ticks
    ld    a, $0C
    ld    (Sound_FadeMajorCount), a
    ld    a, $12
    ld    (Sound_FadeMinorCount), a
    ld    (Sound_FadeMinorReset), a
    jp    Sound_SetActive


; =============================================================================
; Sound_StopSFX()
; -----------------------------------------------------------------------------
;  Causes each sound effect tone channel to execute a "stop" command with the
;  next tick.
; -----------------------------------------------------------------------------
;  In:
;    None.
;  Out:
;    None.
;  Destroys:
;    B, DE, HL, IY
; -----------------------------------------------------------------------------
Sound_StopSFX:      ; $8170
    ; load IY with a pointer to the first SFX channel
    ld    iy, Sound_Channel_SFX_0
    ; this will be added to IY with each iteration of the loop
    ; to move to the next channel structure
    ld    de, Sound_ChannelSize
    ; loop 3 times
    ld    b, 3
    
    ; this will be stored as the next sound command for the channel
    ld    hl, _Sound_StopSFX_command

-:  ; store the "next command" pointer
    ld    (iy + Sound_ChnlNextCommand), l
    ld    (iy + Sound_ChnlNextCommand + 1), h
    
    ; move to the next channel structure
    add   iy, de
    djnz  -

    ret

_Sound_StopSFX_command
    Stop


; =============================================================================
; Sound_LoadMusicModule(uint8 module_index)
; -----------------------------------------------------------------------------
;  Loads music module header data into the channel structures.
; -----------------------------------------------------------------------------
;  In:
;    A  - Module number.
;  Out:
;    None.
; -----------------------------------------------------------------------------
Sound_LoadMusicModule:        ; $8188
    ; First music slot is $81. Subtract $81 from the value 
    ; passed in A to get a zero-based index
    sub   Music_FirstSlot
    ; return if < $81
    ret   m
    
    ; reset all channel structures
    ex    af, af'
        call  Sound_ResetAll
    ex    af, af'
    
    
    ; fetch the tempo/speed value for the module
    ; FIXME: this is completely pointless as it is overwritten
    ;   further on in this subroutine by the value stored in 
    ;   the module header
    ld    hl, Sound_Data_MusicSpeeds
    
    ; put the module number into C for the call to 
    ; Sound_CalcIndex_Int8
    ld    c, a
    
    ex    af, af'
        call  Sound_CalcIndex_Int8
        ld    (Sound_SpeedCounter), a
        ld    (Sound_Speed), a
    ex    af, af'
    
    
    ; fetch a pointer to the music data
    ld    hl, Sound_Data_MusicPointers
    ; calculate the address of the module data
    call  Sound_CalcIndex_Int16
    
    ; skip past the volume envelope pointer
    inc   hl
    inc   hl
    
    ; get number of channels
    ld    b, (hl)

    ; skip the next byte
    inc   hl
    
    ; copy the channel's tempo modifier into the shadow accumulator
    inc   hl
    ld    a, (hl)
    ex    af, af'
    
    
    ; read the module's global speed modifier (note: this overwrites
    ; the value written earlier).
    inc   hl
    ld    a, (hl)
    ld    (Sound_SpeedCounter), a
    ld    (Sound_Speed), a


    ; load IY with a pointer to the sound channel numbers
    ; for each structure.
    ld    iy, Sound_Data_ChannelNumbers

    inc   hl

    ; initialise required number of channels
    ; starting with structure at $DD40
    ld    de, Sound_Channel_Music_0
-:  call  Sound_InitChannel
    djnz  -


; =============================================================================
; Sound_SetActive()
; -----------------------------------------------------------------------------
;  Marks the main trigger byte ($DD03) as active.
; -----------------------------------------------------------------------------
;  In:
;    None.
;  Out:
;    None.
; -----------------------------------------------------------------------------
Sound_SetActive:        ; $81C1
    ld    a, $80        
    ld    ($DD03), a
    ret


; =============================================================================
; Sound_LoadSFXModule(uint8 module_index)
; -----------------------------------------------------------------------------
;  Loads sound effect module header data into the channel structures. Will 
;  activate a secondary channel and suppress a primary channel.
; -----------------------------------------------------------------------------
;  In:
;    A  - Module number.
;  Out:
;    None.
; -----------------------------------------------------------------------------
Sound_LoadSFXModule:        ; $81C7
    ; store the sound effect value here
    ld    (Sound_SFXIndex), a
    
    ; subtract the index of the first SFX slot to
    ; get a zero-based offset value
    sub   SFX_FirstSlot
    
    ; calculate an index into the array at $8C0D
    ld    hl, Sound_Data_SFXPointers
    call  Sound_CalcIndex_Int16
    
    ; skip past the volume envelope pointer
    inc   hl
    inc   hl
    
    ld    a, (hl)
    inc   hl
    ex    af, af'
    
    ; fetch number of channels
    ld    b, (hl)
    inc   hl

    ; loop over each channel
-:  inc   hl
    ld    a, (hl)
    dec   hl

    ; determine which primary channel to suppress
    ; and which secondary channel to activate
    cp    Sound_PSG_Latch | Sound_PSG_Tone1
    jr    z, Sound_LoadSFXModule_PriT1_SecT0
    
    cp    Sound_PSG_Latch | Sound_PSG_Tone2
    jr    z, LABEL_81ED_114
    
    ; if we get here A == $E0  (i.e. noise channel)
    ld    de, Sound_Channel_SFX_2
    ld    iy, Sound_Channel_Music_Noise
    jr    LABEL_820F_115

LABEL_81ED_114:
    ld    iy, Sound_Channel_SFX_2
    bit   6, (iy + Sound_ChnlControl)
    jr    nz, Sound_LoadSFXModule_PriT2_SecT1

    set   Sound_ChannelSuppressBit, (iy + Sound_ChnlControl)
    ld    a, $FF            ;noise volume = off
    out   (Ports_PSG), a

Sound_LoadSFXModule_PriT2_SecT1:      ; $81FF
    ld    de, Sound_Channel_SFX_1
    ld    iy, Sound_Channel_Music_2
    jr    LABEL_820F_115

Sound_LoadSFXModule_PriT1_SecT0:      ; $8208
    ld    de, Sound_Channel_SFX_0
    ld    iy, Sound_Channel_Music_1

LABEL_820F_115:
    call  Sound_LoadSFXModule_InitChannel
    djnz  -

    jp    Sound_SetActive


Sound_LoadSFXModule_InitChannel:      ; $8217
    ; suppress psg writes for the primary channel
    set   Sound_ChannelSuppressBit, (iy + Sound_ChnlControl)
    
    ; initialise the secondary channel structure
    ld    c, Sound_ChannelSize + 6
    push  de
    pop   ix
    ldi
    ldi
    
    ex    af, af'
    ld    (de), a
    inc   de
    ex    af, af'
    
    xor   a
    ldi
    ldi
    ldi
    ldi
    
    ld    (de), a
    inc   de
    ld    (de), a
    inc   de
    
    ld    a, c
    ld    (de), a
    inc   de
    
    ; reset the channel's 3 loop counters
    xor   a
    ld    (ix + Sound_ChnlLoopCounter0), a
    ld    (ix + Sound_ChnlLoopCounter1), a
    ld    (ix + Sound_ChnlLoopCounter2), a
    
    inc   a
    ld    (de), a
    push  hl

    ld    hl, Sound_ChannelSize - $0A
    add   hl, de
    
    ex    de, hl
    pop   hl

    ret


; =============================================================================
; Sound_InitChannel(uint8 tempo, uint16 channel_ptr, uint16 source)
; -----------------------------------------------------------------------------
;  Initialise a channel structure with data from a module's channel header.
; -----------------------------------------------------------------------------
;  In:
;    A'  - Tempo
;    DE  - Pointer to channel structure.
;    HL  - Pointer to source header data.
;  Out:
;    DE  - Pointer to next channel structure (e.g. if DE was $DD40 on entry
;          it will be $DD70 on exit).
;    HL  - Pointer to data immediately after channel init data.
;  Destroys:
;    A, BC, IX, A'
; -----------------------------------------------------------------------------
Sound_InitChannel:        ;$824C
    ; load C with $34. C will be used to set the initial
    ; stack pointer for the channel. The stack pointer will 
    ; start at $30. 4 LDIs will decrement C to $30 before
    ; we set the stack pointer at (ix + 9)
    ld    c, Sound_ChannelSize + 4
    push  de
    pop   ix
    
    ; mark the channel as active
    ld    a, Sound_ChannelActive
    ld    (de), a
    inc   de
    
    ; fetch the PSG channel number and copy it into
    ; the structure
    ld    a, (iy + 0)
    ld    (de), a
    inc   de
    inc   iy

    ; fetch the tempo value from the shadow accumulator
    ex    af, af'
    ld    (de), a
    inc   de
    ex    af, af'

    ; copy 4 bytes into the channel starting at +$03 bytes
    ; (e.g. $DD43)
    xor   a
    ldi         ; first 2 bytes are command data pointer
    ldi
    ldi         ; next byte is tone adjustment
    ldi         ; next byte is volume attenuation
    
    ; reset tone effect flags
    ld    (de), a
    inc   de
    ; reset volume effect flags
    ld    (de), a
    inc   de

    ; set the default stack pointer for the channel
    ld    a, c
    ld    (de), a
    inc   de

    ; reset the channel's 3 loop counters
    xor   a
    ld    (ix + Sound_ChnlLoopCounter0), a
    ld    (ix + Sound_ChnlLoopCounter1), a
    ld    (ix + Sound_ChnlLoopCounter2), a
    
    ; set the tone duration counter to 1
    inc   a
    ld    (de), a

    ; move DE to the next channel structure
    push  hl
    ld    hl, Sound_ChannelSize - $0A
    add   hl, de
    ex    de, hl
    pop   hl
    
    ret

; these bytes are copied into the "channel number" byte
; of each channel structure (e.g. $DD41)
Sound_Data_ChannelNumbers:        ;$8284
.db Sound_PSG_Latch | Sound_PSG_Tone0, 
.db Sound_PSG_Latch | Sound_PSG_Tone1
.db Sound_PSG_Latch | Sound_PSG_Tone2
.db Sound_PSG_Latch | Sound_PSG_Noise


; =============================================================================
; Sound_LoadPitchBendData(uint16 channel_ptr)
; -----------------------------------------------------------------------------
;  Copies parameter values required by the pitch bend effect into the 
;  channel structure.
; -----------------------------------------------------------------------------
;  In:
;    IX  - Pointer to channel structure.
;  Out:
;    None.
; -----------------------------------------------------------------------------
Sound_LoadPitchBendData:        ; $8288
    ; return if the pitch bend bit is reset
    bit   Sound_ChnlPitchBendBit, (ix + Sound_ToneEffectFlags)
    ret   z

    ; bail out if we need to preserve effect state
    bit   Sound_ChnlKeepStateBit, (ix + Sound_ChnlControl)
    ret   nz

    ; load the pointer at (ix + $10) into DE
    ld    e, (ix + Sound_PitchBendDataPtr)
    ld    d, (ix + Sound_PitchBendDataPtr + 1)
    
    ; load the channel pointer into HL
    push  ix
    pop   hl
    
    ; adjust HL to IX+$14
    ld    b, $00
    ld    c, Sound_PitchBendCountdown & $FF
    add   hl, bc
    
    ; copy 3 bytes from the data pointer at (IX+$10)
    ; into the channel structure
    ex    de, hl
    ldi         ; pitch bend countdown
    ldi         ; pitch bend length
    ldi         ; pitch bend step size
    
    ; read the repeat count
    ld    a, (hl)
    ; divide by 2
    srl   a
    ; ...and store in the channel structure at (ix + $17)
    ld    (de), a
    
    ;clear the tone adjustment value
    xor   a
    ld    (ix + Sound_ChnlToneAdjustment), a
    ld    (ix + Sound_ChnlToneAdjustment + 1), a
    
    ret


LABEL_82B3_142:
    bit   Sound_VolPreserveBit, (ix + Sound_VolumeEffectFlags)
    ret   z

    bit   Sound_ChnlKeepStateBit, (ix + Sound_ChnlControl)
    ret   nz

    ; dont update if the "suppress updates" bit is set
    bit   7, (ix + $1D)
    ret   nz

    ; set volume attenuation to max
    ld    a, $FF
    ld    (ix + Sound_ChnlVolume), a
    and   $10
    or    (ix + $1E)
    ld    (ix + $1D), a
    ret


; =============================================================================
; Sound_ApplyToneEffect(uint16 channel_ptr)
; -----------------------------------------------------------------------------
;  Determins whether a tone effect is in place and adjusts the tone data
;  accordingly.
; -----------------------------------------------------------------------------
;  In:
;    IX  - Pointer to channel structure.
;  Out:
;    HL  - Tone data.
; -----------------------------------------------------------------------------
Sound_ApplyToneEffect:      ; $82D0
    ; read the tone value from the channel structure
    ld    l, (ix + Sound_ChnlToneData)
    ld    h, (ix + Sound_ChnlToneData + 1)

    ; should an effect be applied?
    ld    a, (ix + Sound_ToneEffectFlags)
    or    a
    ret   z

    ; jump if bit 7 is reset
    jp    p, Sound_ApplyPitchEnvelope

    ; msb was set - apply pitch bend
    
    ; decrement countdown value and return if != 0
    dec   (ix + Sound_PitchBendCountdown) 
    ret   nz

    inc   (ix + Sound_PitchBendCountdown)    ;ix+$14 = 1
    
    ; push the tone value to the stack
    push  hl
    
    ; fetch the tone adjustment
    ld    l, (ix + Sound_ChnlToneAdjustment)
    ld    h, (ix + Sound_ChnlToneAdjustment + 1)
    
    ; decrement the counter
    dec   (ix + Sound_PitchBendLength)
    jr    nz, +

    ; the counter is zero. we need to apply the effect
    ; and reset the counter value
    
    ; load the effect data pointer into IY
    ld    e, (ix + Sound_PitchBendDataPtr)
    ld    d, (ix + Sound_PitchBendDataPtr + 1)
    push  de
    pop   iy
    
    ; reset the step duration counter
    ld    a, (iy + $01)
    ld    (ix + Sound_PitchBendLength), a

    ; load the signed 8bit step value into the
    ; bc register pair
    ld    a, (ix + Sound_PitchBendStepValue)
    ld    c, a
    ; rotate MSB into carry flag
    and   $80
    rlca
    neg
    ld    b, a
    
    ; add to the current tone adjustment value
    add   hl, bc
    
    ; store the tone adjustment value
    ld    (ix + Sound_ChnlToneAdjustment), l
    ld    (ix + Sound_ChnlToneAdjustment + 1), h

+:  ; pop the tone value into BC
    pop   bc

    ; apply the effect to the tone value
    add   hl, bc

    ; decrement the repeat counter
    dec   (ix + Sound_PitchBendRepeat)
    ret   nz

    ; restore the effect repeat counter
    ld    a, (iy + $03)
    ld    (ix + Sound_PitchBendRepeat), a
    
    ; negate the effect step value
    ld    a, (ix + Sound_PitchBendStepValue)
    neg
    ld    (ix + Sound_PitchBendStepValue), a
    ret


Sound_ApplyPitchEnvelope:       ; $8326
    dec   a
    ; put the tone data into the DE register pair
    ex    de, hl
    ; fetch a pointer to the effect data
    ld    hl, Sound_Data_PitchEnvelopes
    call  Sound_CalcIndex_Int16
    jr    Sound_PitchEnvelope_GetAdjustment


Sound_PitchEnvelope_SetIndex:     ; $8330
    ld    (ix + Sound_PitchEnvlpIndex), a


Sound_PitchEnvelope_GetAdjustment:        ; $8333
    ; read a value from the effect data array
    push  hl
    ld    c, (ix + Sound_PitchEnvlpIndex)
    call  Sound_CalcIndex_Int8
    pop   hl
    
    ; if the value < $80 add it to the tone data
    bit   7, a
    jr    z, Sound_PitchEnvelope_CalculateTone
    
    ; if the value == $83 it is a "set index" command
    cp    $83
    jr    z, Sound_PitchEnvelope_ReadIndex
    
    ; if the value is > $83 it is a negative adjustment
    ; value. sign extend and add to the tone data
    jr    nc, Sound_PitchEnvelope_SignExtend
    
    ; if the value == $80 it is a "reset index" command
    cp    $80
    jr    z, Sound_PitchEnvelope_ResetIndex
    
    ; value == $81 or $82
    set   5, (ix + Sound_ChnlControl)
    pop   hl
    ret

Sound_PitchEnvelope_ReadIndex:     ; $834F
    ; read the index from the effect data
    inc  de
    ld   a, (de)
    jr   Sound_PitchEnvelope_SetIndex


Sound_PitchEnvelope_ResetIndex:       ; $8353
    xor  a
    jr   Sound_PitchEnvelope_SetIndex


Sound_PitchEnvelope_SignExtend:       ; $8356
    ld   h, $FF
    jr   +

Sound_PitchEnvelope_CalculateTone:        ; $835A
    ld   h, $00
    
+:  ld   l, a
    ; add the effect data to the tone data
    add  hl, de
    
    ; increment the index value
    inc  (ix + Sound_PitchEnvlpIndex)
    ret


; =============================================================================
; Sound_ReadChannelStream(uint16 channel_ptr)
; -----------------------------------------------------------------------------
;  Updates a channel by reading from the module's sound command data.
; -----------------------------------------------------------------------------
;  In:
;    IX  - Channel pointer.
;  Out:
;    None.
; -----------------------------------------------------------------------------
Sound_ReadChannelStream:        ; $8362
    ;clear some flags
    res  Sound_ChnlKeepStateBit, (ix + Sound_ChnlControl)
    res  Sound_ChnlVolSuppressBit, (ix + Sound_ChnlControl)
    
    ; fetch the data pointer
    ld   e, (ix + Sound_ChnlNextCommand)
    ld   d, (ix + Sound_ChnlNextCommand + 1)
    ; FALL THROUGH


; =============================================================================
; Sound_ReadStreamData(uint16 channel_ptr, uint16 stream_ptr)
; -----------------------------------------------------------------------------
;  Read and interpret the next byte from the sound data.
; -----------------------------------------------------------------------------
;  In:
;    DE  - Current data pointer (points into sound data stream).
;    IX  - Channel pointer.
;  Out:
;
; -----------------------------------------------------------------------------
Sound_ReadStreamData:        ; $8370
    ; read a byte of data and increment the pointer
    ld    a, (de)
    inc   de
    
    ; jump if the byte a control byte (i.e. >= $E0)?
    cp    $E0
    jp    nc, Sound_InterpretCommand_WithReturn
    
    bit   Sound_ChnlReadLiteralBit, (ix + Sound_ChnlControl)
    jp    nz, Sound_ReadLiteral
    
    ; jump if byte < $80
    cp    $80
    jr    c, Sound_ReadStreamData_CalcNoteHold
    
    ; jump if byte == $80
    jr    z, Sound_ReadStreamData_Rest
    
    
    ; value is a "note" command
    
    ; clear bit 7 of IX+$1D
    ex    af, af'
    ld    a, (ix + $1D)
    and   $7F
    ld    (ix + $1D), a
    ex    af, af'
    
    ; get the note value
    call  Sound_GetNoteValue
    ; store the note value in the channel structure
    ld    (ix + Sound_ChnlToneData), l
    ld    (ix + Sound_ChnlToneData + 1), h


; checks to see if the next byte is a "set ticks per note" command
; and sets the note duration as necessary
Sound_ReadStreamData_SetNoteHold:       ; $8397
    ; read the next byte
    ld   a, (de)
    inc  de
    or   a
    jp   p, Sound_ReadStreamData_CalcNoteHold
    
    ; copy the next tone duration to the current
    ld   a, (ix + Sound_ChnlToneDuration_Next)
    ld   (ix + Sound_ChnlToneDuration), a

    dec  de
    jr   ++


; calculate note duration based on the channel's tempo value
Sound_ReadStreamData_CalcNoteHold:      ; $83A6
    ; multiply the ticks-per-note value by the speed value
    call  Sound_MultiplyA
    ld    (ix + Sound_ChnlToneDuration), a
    ld    (ix + Sound_ChnlToneDuration_Next), a

++: ; store the data pointer
    ld    (ix + Sound_ChnlNextCommand), e
    ld    (ix + Sound_ChnlNextCommand + 1), d
    
    ; bail out if we need to preserve effect state
    bit   Sound_ChnlKeepStateBit, (ix + Sound_ChnlControl)
    ret   nz

    bit   Sound_ChnlVolumeOnlyBit, (ix + Sound_ChnlControl)
    jr    nz, +
    
    res   5, (ix + Sound_ChnlControl)
    
+:  ld    a, (ix + $0F)
    ld    (ix + $0E), a
    
    ; clear pitch bend length / pitch envelope index value
    xor  a
    ld   (ix + Sound_PitchBendLength), a
    
    ; check the volume effect flags
    bit  Sound_VolPreserveBit, (ix + Sound_VolumeEffectFlags)
    ret  nz

    ld   (ix + Sound_ChnlVolume), a
    ret


Sound_ReadStreamData_Rest:      ; $83D7
    call LABEL_85F8_134
    jr   Sound_ReadStreamData_SetNoteHold


; =============================================================================
; Sound_ReadLiteral(uint8 tone_lo_byte, uint16 src_ptr, uint16 channel_ptr)
; -----------------------------------------------------------------------------
;  Reads 16-bit, big-endian, tone data from the stream.
; -----------------------------------------------------------------------------
;  In:
;    A   - high-byte of the 16bit tone value.
;    DE  - Current data pointer (points into sound data).
;    IX  - Channel pointer.
;  Out:
;    A   - Next byte of data from the stream.
;    DE  - Pointer to the byte immediately following A.
;  Destroys:
;    BC, HL
; -----------------------------------------------------------------------------
Sound_ReadLiteral:       ;$83DC
    ; read another byte and copy the 16-bit value into HL
    ; NOTE: BIG ENDIAN READ
    ld    h, a      ;<-- 'low' byte is copied into H
    ld    a, (de)
    inc   de
    
    ; if the value is 0 don't bother adjusting
    ld    l, a      ;<-- 'high' byte is copied into L
    or    h
    jr    z, +

    ; apply the pitch adjustment
    
    ld    b, $00
    
    ; retrieve the tone adjustment value from
    ; the channel structure
    ld    a, (ix + Sound_ChnlPitchAdjust)
    or    a
    ld    c, a
    
    ; check the accumulator's sign bit.
    ; if the bit is set we need to sign extend into
    ; the B register
    jp    p, ++

    dec   b
    
++: ; adjust the tone value
    add   hl, bc

+:  ; store the tone data
    ld    (ix + Sound_ChnlToneData), l
    ld    (ix + Sound_ChnlToneData+1), h
    
    ; read another byte of data and increment the pointer
    ld    a, (de)
    inc   de
    jp    Sound_ReadStreamData_CalcNoteHold


; =============================================================================
; Sound_ResetAll()
; -----------------------------------------------------------------------------
;  Clears all memory used by the sound driver and initialises the PSG.
; -----------------------------------------------------------------------------
;  In:
;    None
;  Out:
;    None.
;  Destroys:
;    None.
; -----------------------------------------------------------------------------
Sound_ResetAll:        ; $83FA
    push  hl
    push  bc
    push  de
    
    ; reset all control bytes and channel structures
    ld    hl, $DD03
    ld    de, $DD04
    ld    bc, $018C
    ld    (hl), $00
    ldir
    
    pop   de
    pop   bc
    pop   hl
    ; fall through


; =============================================================================
; Sound_InitPSG()
; -----------------------------------------------------------------------------
;  Initialises the PSG registers with default values.
; -----------------------------------------------------------------------------
;  In:
;    None
;  Out:
;    None.
;  Destroys:
;    None.
; -----------------------------------------------------------------------------
Sound_InitPSG:        ;$840D
    push hl
    push bc
    ; write 10 bytes to the PSG
    ld   hl, Sound_Data_DefaultRegisterValues
    ld   b, $0A
    ld   c, Ports_PSG
    otir
    pop  bc
    pop  hl
    jp   Sound_SetActive

Sound_Data_DefaultRegisterValues:
.db Sound_PSG_Latch | Sound_PSG_Tone0, $00    ;set tone 0 = 0
.db Sound_PSG_Latch | Sound_PSG_Tone1, $00    ;set tone 1 = 0
.db Sound_PSG_Latch | Sound_PSG_Tone2, $00    ;set tone 2 = 0
.db Sound_PSG_Latch | Sound_PSG_Type_Volume | Sound_PSG_Tone0 | $0F
.db Sound_PSG_Latch | Sound_PSG_Type_Volume | Sound_PSG_Tone1 | $0F
.db Sound_PSG_Latch | Sound_PSG_Type_Volume | Sound_PSG_Tone2 | $0F
.db Sound_PSG_Latch | Sound_PSG_Type_Volume | Sound_PSG_Noise | $0F



; =============================================================================
; Sound_GetNoteValue(uint8 note_index)
; -----------------------------------------------------------------------------
;  Fetches the PSG tone counter register value for the specified note index.
; -----------------------------------------------------------------------------
;  In:
;    A   - Note number.
;  Out:
;    HL  - Note value.
;  Destroys:
;    BC
; -----------------------------------------------------------------------------
Sound_GetNoteValue:        ; $8427
    and   $7F
    add   a, (ix + Sound_ChnlPitchAdjust)
    ld    hl, Sound_Data_NoteValues
    ; FALL THROUGH


; =============================================================================
; Sound_CalcIndex_Int16(uint16 array_base, uint8 index)
; -----------------------------------------------------------------------------
;  Get an element from an array of 16-bit integers.
; -----------------------------------------------------------------------------
;  In:
;    A   - Element index.
;    HL  - Base address of the array.
;  Out:
;    HL  - Element value.
;  Destroys:
;    BC
; -----------------------------------------------------------------------------
Sound_CalcIndex_Int16:        ; $842F
    ld    c, a
    ld    b, $00
    add   hl, bc
    add   hl, bc
    ld    c, (hl)
    inc   hl
    ld    h, (hl)
    ld    l, c
    ret


; =============================================================================
; Sound_CalcIndex_Int8(uint32 array_base, uint8 index)
; -----------------------------------------------------------------------------
;  Calculate a pointer to an element in an array of bytes.
; -----------------------------------------------------------------------------
;  In:
;    C   - Element index.
;    HL  - Base address of the array.
;  Out:
;    A   - Element value.
;    HL  - Pointer to element within the array.
;  Destroys:
;    BC
; -----------------------------------------------------------------------------
Sound_CalcIndex_Int8:        ; $8439
    ld    b, $00
    add   hl, bc
    ld    a, (hl)
    ret


; =============================================================================
; Sound_MultiplyA(uint8 multiplicand, uint8 multiplier)
; -----------------------------------------------------------------------------
;  Performs 8-bit multiplication with the speed value stored in the channel.
; -----------------------------------------------------------------------------
;  In:
;    A         - Multiplicand
;    (ix + 2)  - Multiplier
;  Out:
;    A  - Value
;  Destroys:
;    BC
; -----------------------------------------------------------------------------
Sound_MultiplyA:        ; $843E
    ; fetch the multiplier and check that it's not 1
    ld    b, (ix + Sound_ChnlSpeed)
    dec   b
    ret   z

    ; multiply using repeated add
    ld    c, a
-:  add   a, c
    djnz  -
    ret



; PSG values approximately corresponding to MIDI notes
Sound_Data_NoteValues:        ; $8448
.include "src/sound_note_values.asm"
;.include "src/sound_note_values_tuned.asm"


; =============================================================================
; Sound_UpdateToneChannel(uint16 channel_ptr)
; -----------------------------------------------------------------------------
;  Runs the specified tone channel for 1 tick.
; -----------------------------------------------------------------------------
;  In:
;    IX - The channel pointer.
;  Out:
;    None.
; -----------------------------------------------------------------------------
Sound_UpdateToneChannel:        ; $84D4
    ; decrement the note duration counter
    dec   (ix + Sound_ChnlToneDuration)
    
    ; if the duration counter is > 0 we dont need to bother fetching
    ; new data but we may need to update a tone effect
    jr    nz, +
    
    ; duration counter == 0
    ; fetch data from the stream
    call  Sound_ReadChannelStream
    
    ; check that PSG volume writes are not suppressed
    bit   Sound_ChnlVolSuppressBit, (ix + Sound_ChnlControl)
    ret   nz
    
    ; check that the channel hasn't been suppressed by
    ; a sound effect module
    bit   Sound_ChannelSuppressBit, (ix + Sound_ChnlControl)
    ret   nz
    
    ; load any pitch effects 
    call  Sound_LoadPitchBendData
    call  LABEL_82B3_142
    
    ; and write to the PSG
    jr    Sound_WriteChannelData

+:  ; check to see if PSG writes should be suppressed
    bit   Sound_ChannelSuppressBit, (ix + Sound_ChnlControl)
    ret   nz
    
    ld    a, (ix + $0E)
    or    a
    jr    z, +
    
    dec   (ix + $0E)
    call  z, LABEL_85F8_134
    
+:  ld    a, (ix + Sound_ToneEffectFlags)
    or    a
    jr    z, Sound_UpdateChannelVolume
    
    bit   5, (ix + Sound_ChnlControl)
    jr    nz, Sound_UpdateChannelVolume
    ; FALL THROUGH

; =============================================================================
; Sound_WriteChannelData(uint16 channel_ptr, uint16 channel_data)
; -----------------------------------------------------------------------------
;  Writes data to the PSG and updates the volume.
; -----------------------------------------------------------------------------
;  In:
;    IX  - Pointer to a channel descriptor.
;  Out:
;    None.
; -----------------------------------------------------------------------------
Sound_WriteChannelData:        ;$850B
    ; check to see if we need to update volume only
    bit   Sound_ChnlVolumeOnlyBit, (ix + Sound_ChnlControl)
    jr    nz, Sound_UpdateChannelVolume
    
    ; apply any pitch effects
    call  Sound_ApplyToneEffect
    
    ; fetch the detune value
    ld    d, $00
    ld    a, (ix + Sound_ChnlDetune)    
    or    a
    ; check the value's sign and extend into D if necessary
    jp    p, ++    
    dec   d
    
++: ; add the detune value to the data
    ld    e, a
    add   hl, de
    
    
    ; get the current channel number
    ld    a, (ix + Sound_ChnlNumber)
    
    ; jump if it's a tone channel
    cp    Sound_PSG_Latch | Sound_PSG_Noise
    jr    nz, ++ 
    
    ; if we get here, the channel is a noise channel
    ; change to channel 2 instead
    ld    a, Sound_PSG_Latch | Sound_PSG_Tone2

++: ; store the channel number in the C register
    ld    c, a

    ; get the low 4-bits of data and combine them with the channel number
    ; to create a PSG latch byte
    ld    a, l
    and   $0F
    or    c
    ; write the latch byte to the PSG
    out   (Ports_PSG), a
    
    ; extract the upper 4 bits and combine with the second byte then
    ; rotate into the correct position
    ld    a, l
    and   $F0
    or    h
    rrca
    rrca
    rrca
    rrca
    ; write the data byte
    out   (Ports_PSG), a
    ; FALL THROUGH

; =============================================================================
; Sound_UpdateChannelVolume(uint16 channel_ptr)
; -----------------------------------------------------------------------------
;  Copies a channel's volume data to the PSG.
; -----------------------------------------------------------------------------
;  In:
;    IX  - Pointer to a channel descriptor.
;  Out:
;    None.
; -----------------------------------------------------------------------------
Sound_UpdateChannelVolume:        ; $853A
    ; grab any volume effect data
    call  Sound_CheckApplyVolumeEffect
    
    ; check that PSG writes are not suppressed
    bit   Sound_ChannelSuppressBit, (ix + Sound_ChnlControl)
    ret   nz
    
    ; check that volume updates are not suppressed
    bit   Sound_ChnlVolSuppressBit, (ix + Sound_ChnlControl)
    ret   nz
    
    ; add the channel's volume adjustment value to the effect
    add   a, (ix + Sound_ChnlVolumeAdjust)
    
    ; make sure that we don't overflow the 4 data bits
    bit   4, a
    jr    z, +
    ld    a, $0F

+:  ; fetch channel number from the structure
    or    (ix + Sound_ChnlNumber)
    ; set the "type" bit to volume
    add   a, Sound_PSG_Type_Volume
    ; write to the PSG
    out   (Ports_PSG), a

    ret


; =============================================================================
; Sound_CheckApplyVolumeEffect(uint16 channel_ptr)
; -----------------------------------------------------------------------------
;  Checks the channel's volume effect flags and applies an affect as
;  necessary.
; -----------------------------------------------------------------------------
;  In:
;    IX  - Pointer to a channel descriptor.
;  Out:
;    A   - Effect data to be added to volume adjustment.
;  Destroys:
;
; -----------------------------------------------------------------------------
Sound_CheckApplyVolumeEffect:       ; $8558
    ; get the effect flags from the channel structure
    ld    a, (ix + Sound_VolumeEffectFlags)
    or    a
    ; if flags == 0 no effect should be applied
    ret   z

    ; if MSB is reset apply a volume envelope
    jp    p, Sound_ApplyEnvelope

    ; check the "fade in" bit
    bit   4, (ix + $1D)
    jr    z, LABEL_8580_159
    
    ; fade volume in using effect value
    ld    d, (ix + Sound_ChnlVolEffectAdjust)   ;get volume adjustment value
    ld    a, (ix + Sound_ChnlVolume)            ;get current volume value
    sub   d
    jr    nc, +

    xor   a                ;resulting volume was < 0. reset to 0

+:  or    a
    ld    (ix + Sound_ChnlVolume), a        ;set current volume
    jr    nz, LABEL_85EE_161
    
    ; attenuation is now at zero. turn the "fade out"
    ; bit off. set bit 5
    ld    a, (ix + $1D)
    xor   $30               ;flip bits 4 & 5
    ld    (ix + $1D), a

    jr    LABEL_85EE_161


LABEL_8580_159:
    bit   5, (ix + $1D)
    jr    z, LABEL_85B0_162

    ld    a, (ix + Sound_ChnlVolume)
    ld    d, (ix + $21)
    ld    e, (ix + $22)
    add   a, d
    jr    c, +
    
    cp    e
    jr    c, ++
    
+:  ld    a, e

++: cp    e
    ld    (ix + Sound_ChnlVolume), a
    jr    nz, LABEL_85EE_161
    ld    a, (ix + $1D)
    bit   3, (ix + $1D)
    
    jr    z, +
    xor   $30
    jr    ++

+:  xor   $60

++: ld    (ix + $1D), a
    jr    LABEL_85EE_161


LABEL_85B0_162:
    bit   6, (ix + $1D)
    jr    z, LABEL_85D2_167
    
    ; fetch the current volume & adjustment value
    ld    a, (ix + Sound_ChnlVolume)
    ld    d, (ix + $23)
    
    ; add the adjustment value (increase attenuation)
    add   a, d
    jr    nc, +
    
    ; there was a carry - set volume off
    ld    a, $FF
    
+:  cp    $FF
    ld    (ix + Sound_ChnlVolume), a
    jr    nz, LABEL_85EE_161
    
    ; if attenuation == $FF
    ld    a, (ix + $1D)
    ; turn off bits 4, 5 & 6 of the volume effects flags
    and   $8F
    ld    (ix + $1D), a
    jr    LABEL_85EE_161


LABEL_85D2_167:
    ld    a, (ix + Sound_ChnlVolume)
    ld    d, (ix + $24)
    add   a, d
    jr    nc, +
    
    ld    a, (ix + $1D)
    and   $0F
    ld    (ix + $1D), a
    ld    a, $FF
    ld    (ix + Sound_ChnlVolume), a
    jp    Sound_SetVolumeOff

+:  ld    (ix + Sound_ChnlVolume), a
    ; FALL THROUGH

LABEL_85EE_161:
    ld    a, (ix + Sound_ChnlVolume)
    rrca
    rrca
    rrca
    rrca
    and   $0F
    ret

LABEL_85F8_134:
    ; bail out if we need to preserve effect state
    bit    Sound_ChnlKeepStateBit, (ix + Sound_ChnlControl)
    ret    nz

    ; check to see if a volume effect is being used
    bit    Sound_VolPreserveBit, (ix + Sound_VolumeEffectFlags)
    ; jump if there isnt
    jp     z, Sound_SetVolumeOff

    ; clear bits 4,5 & 6, set bit 7
    ld     a, (ix + $1D)
    and    $0F
    or     $80
    ld     (ix + $1D), a
    ret


; apply a volume envelope
Sound_ApplyEnvelope:        ; $860F
    dec   a
    ld    hl, Sound_Data_VolumeEnvelopes
    call  Sound_CalcIndex_Int16
    jr    Sound_ApplyEnvelope_GetData

Sound_ApplyEnvelope_SetIndex:       ; $8175
    ; set the index
    ld    (ix + Sound_VolEnvlpIndex), a

Sound_ApplyEnvelope_GetData:        ; $861B
    ; fetch the effect value from the array addressed by HL
    ; using (IX+$1F) as an index
    push  hl
    ld    c, (ix + Sound_VolEnvlpIndex)
    call  Sound_CalcIndex_Int8
    pop   hl
    
    ; if effect value < $80
    bit   7, a
    jr    z, Sound_ApplyEnvelope_NextIndex

    ; if value > $80 it is a command byte
    cp    $82
    jr    z, LABEL_8637_172
    
    cp    $81
    jr    z, LABEL_8641_173
    
    cp    $80
    jr    z, Sound_ApplyEnvelope_ResetIndex

    ; any command bytes >= $83 are a "set index" command
    inc   de
    ld    a, (de)
    jr    Sound_ApplyEnvelope_SetIndex

LABEL_8637_172:
    ; suppress psg writes
    ; this SET op seems a bit pointless since Sound_SetVolumeOff
    ; does the same thing
    set   Sound_ChnlVolSuppressBit, (ix + Sound_ChnlControl)
    ; CHECK: what is this POPping?
    pop   hl
    jr    Sound_SetVolumeOff


Sound_ApplyEnvelope_ResetIndex:     ; $863E
    xor   a
    jr    Sound_ApplyEnvelope_SetIndex

LABEL_8641_173:
    ; suppress volume writes
    set   Sound_ChnlVolSuppressBit, (ix + Sound_ChnlControl)
    pop   hl
    ret

Sound_ApplyEnvelope_NextIndex:      ; $8647
    inc   (ix + Sound_VolEnvlpIndex)
    ret


; =============================================================================
;  Sound_SetVolumeOff()
; -----------------------------------------------------------------------------
;  Sets PSG volume attenuation to full without affecting volume state
;  variables.
; -----------------------------------------------------------------------------
;  In:
;    None.
;  Out:
;    None.
;  Destroys:
;    A
; -----------------------------------------------------------------------------
Sound_SetVolumeOff:        ; $864B
    set   Sound_ChnlVolSuppressBit, (ix + Sound_ChnlControl)
    ; are PSG writes suppressed?
    bit   Sound_ChannelSuppressBit, (ix + Sound_ChnlControl)
    ret   nz
    
    ; set volume attenuation to full
    ld    a, Sound_PSG_Type_Volume | $0F
    add   a, (ix + Sound_ChnlNumber)
    out   (Ports_PSG), a
    ret


; =============================================================================
; Sound_UpdateNoiseChannel(uint16 channel_ptr)
; -----------------------------------------------------------------------------
;  Runs the noise channel for one tick.
; -----------------------------------------------------------------------------
;  In:
;    IX - The channel pointer.
;  Out:
;    None.
; -----------------------------------------------------------------------------
Sound_UpdateNoiseChannel:        ; $865C
    ; decrement counter
    dec   (ix + Sound_ChnlToneDuration)
    
    ; update volume if counter != 0
    jp    nz, Sound_UpdateChannelVolume
    
    ; re-enable PSG volume writes
    res   Sound_ChnlVolSuppressBit, (ix + Sound_ChnlControl)
    
    ; fetch the pointer to the next command
    ld    e, (ix + Sound_ChnlNextCommand)
    ld    d, (ix + Sound_ChnlNextCommand  + 1)
    
-:  ; fetch a byte of data from the source address
    ld    a, (de)
    inc   de
    
    ; is the byte a command byte?
    cp    $E0
    ; jump if it is
    jr    nc, Sound_UpdateNoiseChannel_InterpretCommand
    
    ; jump if A < $80
    cp    $80
    jp    c, Sound_ReadStreamData_CalcNoteHold
    
    ; if we get here, A is between $80 and $E0
    ; does something with noise data
    call  LABEL_8686_180
    jp    Sound_ReadStreamData_SetNoteHold

Sound_UpdateNoiseChannel_InterpretCommand:      ; $867D
    ld    hl, Sound_UpdateNoiseChannel_ReturnStub
    jp    Sound_InterpretCommand


Sound_UpdateNoiseChannel_ReturnStub:        ; $8663
    inc   de
    jr    -    



LABEL_8686_180:
    ; TODO: since accumulator value is not used after the
    ;   jump, using RRCA here would be cheaper
    bit   0, a
    jr    nz, LABEL_86C9_181
    bit   1, a
    jr    nz, LABEL_86A9_182
    bit   2, a
    jr    nz, LABEL_86C1_183
    bit   3, a
    jr    nz, LABEL_86A1_184
    bit   4, a
    jr    nz, LABEL_86B9_185
    bit   5, a
    jr    nz, LABEL_86B1_186
    jp    Sound_SetVolumeOff

LABEL_86A1_184:
    ld    a, $03        ; ???
    ld    b, $02        ; volume adjustment
    ld    c, Sound_PSG_Latch | Sound_PSG_Noise | 4      ; white noise, reset to $10
    jr    LABEL_86CF_187

LABEL_86A9_182:
    ld    a, $03
    ld    b, $02
    ld    c, Sound_PSG_Latch | Sound_PSG_Noise | 4      ; white noise, reset to $10
    jr    LABEL_86CF_187

LABEL_86B1_186:
    ld    a, $04
    ld    b, $04
    ld    c, Sound_PSG_Latch | Sound_PSG_Noise | 4      ; white noise, reset to $10
    jr    LABEL_86CF_187

LABEL_86B9_185:
    ld    a, $03
    ld    b, $03
    ld    c, Sound_PSG_Latch | Sound_PSG_Noise | 6      ; white noise, reset to $40
    jr    LABEL_86CF_187

LABEL_86C1_183:
    ld    a, $02
    ld    b, $02
    ld    c, Sound_PSG_Latch | Sound_PSG_Noise | 5      ; white noise, reset to $20
    jr    LABEL_86CF_187

LABEL_86C9_181:
    ld    a, $01
    ld    b, $02
    ld    c, Sound_PSG_Latch | Sound_PSG_Noise | 4      ; white noise, reset to $10

LABEL_86CF_187:
    ld    (ix + Sound_VolumeEffectFlags), a
    
    ; adjust the noise channel attenuation
    ld    a, (Sound_NoiseChnlVolume)
    add   a, b
    ld    (ix + Sound_ChnlVolumeAdjust), a
    
    ; are PSG writes suppressed?
    bit   Sound_ChannelSuppressBit, (ix + Sound_ChnlControl)
    ret   nz
    
    ; set the noise channel data
    ld    a, ($DD15)
    add   a, c
    ld    ($DD11), a
    out   (Ports_PSG), a
    ret


; =============================================================================
; Sound_InterpretCommand_WithReturn(uint8 command_value, uint16 data_ptr)
; -----------------------------------------------------------------------------
;  Interprets a command and calls the relevant subroutine. Control will
;  be returned to the Sound_ReadStreamData function.
; -----------------------------------------------------------------------------
;  In:
;    A   - The command value.
;    DE  - Sound data pointer.
;    IX  - Channel pointer.
;  Out:
;
;  Destroys:
;
; -----------------------------------------------------------------------------
Sound_InterpretCommand_WithReturn:        ; $86E8
    ; load this function pointer as a return address
    ld    hl, Sound_InterpretCommand_ReturnStub
    ; FALL THROUGH

; =============================================================================
; Sound_InterpretCommand(uint8 cmd, uint16 data, unit16 chnl, uint16 rtrn)
; -----------------------------------------------------------------------------
;  Interprets a command and calls the relevant subroutine.
; -----------------------------------------------------------------------------
;  In:
;    A   - The command value.
;    DE  - Sound data pointer.
;    IX  - Channel pointer.
;    HL  - Return address for the command function.
;  Out:
;    None.
; -----------------------------------------------------------------------------
Sound_InterpretCommand:        ; $86EB
    ; push a function pointer to the stack so that
    ; the indirect jump has a valid return address
    push  hl
    
    ; use A as an index into the array of functions
    sub   $E0
    ld    hl, Sound_CommandDispatchTable
    add   a, a
    ld    c, a
    ld    b, $00
    add   hl, bc
    
    ; fetch the function pointer from the array.
    ld    c, (hl)
    inc   hl
    ld    h, (hl)
    ld    l, c
    
    ; load the next data byte into A
    ld    a, (de)
    
    ; jump to the function.
    jp    (hl)

; This stub will return control to the Sound_ReadStreamData function
Sound_InterpretCommand_ReturnStub:        ;$86FC
    inc   de
    jp    Sound_ReadStreamData


Sound_CommandDispatchTable:         ;$8700
.dw LABEL_88BB                      ; $E0
.dw Sound_Command_Detune            ; $E1
.dw Sound_Command_AdjustToneVolume  ; $E2
.dw Sound_Command_DoNothing         ; $E3
.dw Sound_Command_AdjustNoiseVolume ; $E4
.dw LABEL_88D5                      ; $E5
.dw Sound_Command_AdjustToneVolume  ; $E6
.dw Sound_Command_RepeatNote        ; $E7
.dw LABEL_8892                      ; $E8
.dw Sound_Command_DoNothing         ; $E9
.dw Sound_Command_DoNothing         ; $EA
.dw Sound_Command_DoNothing         ; $EB
.dw Sound_Command_DoNothing         ; $EC
.dw Sound_Command_SetGlobalSpeed    ; $ED
.dw Sound_Command_DoNothing         ; $EE
.dw Sound_Data_PitchEnvelopes       ; $EF - invalid command
.dw Sound_Command_PitchBend           ; $F0
.dw Sound_Data_PitchEnvelopes       ; $F1 - invalid command
.dw LABEL_87DB                      ; $F2
.dw LABEL_8766                      ; $F3
.dw Sound_Command_PitchEnvelope     ; $F4
.dw Sound_Command_VolumeEnvelope    ; $F5
.dw Sound_Command_Jump              ; $F6
.dw Sound_Command_ConditionalJump   ; $F7
.dw Sound_Command_Branch            ; $F8
.dw Sound_Command_Return            ; $F9 
.dw Sound_Command_SetChnlSpeed      ; $FA
.dw Sound_Command_PitchAdjust       ; $FB
.dw Sound_Command_DoNothing         ; $FC
.dw Sound_Command_ReadLiteral       ; $FD - set/reset reading of literal tone data
.dw Sound_Command_DoNothing         ; $FE
.dw Sound_Command_DoNothing         ; $FF
    

Sound_Command_AdjustToneVolume:     ; $8740
    ; check to see if the sound is fading out
    ex    af, af'
        ld    a, (Sound_FadeMajorCount)
        or    a
        ret   nz
    ex    af, af'
    
    ; adjust tone volume attenuation
    add   a, (ix + Sound_ChnlVolumeAdjust)
    ; cap at 15
    and   $0F
    ld    (ix + Sound_ChnlVolumeAdjust), a
    ; FALL THROUGH
  

Sound_Command_DoNothing:            ; $874F
    ret


Sound_Command_AdjustNoiseVolume:    ; $8750
    ld    c, a
    ld    a, (Sound_NoiseChnlVolume)
    add   a, c
    ; cap attenuation at 15
    and   $0F
    ld    (Sound_NoiseChnlVolume), a
    ret


Sound_Command_PitchAdjust:    ; $875B
    add   a, (ix + Sound_ChnlPitchAdjust)
    ld    (ix + Sound_ChnlPitchAdjust), a
    ret


Sound_Command_SetChnlSpeed:         ; $8762
    ld    (ix + Sound_ChnlSpeed), a
    ret 


LABEL_8766:
    ; check the SFX index. jump if the MSB is set.
    ex    af, af'
        ld    a, (Sound_SFXIndex)
        or    a
        ; jump if SFX is playing
        jp    m, LABEL_878F
    ex    af, af'
    
    
    or    $FC
    inc   a
    jr    nz, LABEL_878F

    ; load pointer to secondary tone1 channel
    ld    hl, $DE30
    ; check to see if the channel is active
    bit   7, (hl)
    ; jump if it isn't
    jr    z, LABEL_878F

    ; CHECK: is this offset in the noise channel?
    ld    hl, $DDD0
    res   2, (hl)
    set   4, (hl)
    
    ; clear the channel's control byte
    xor   a
    ld    (ix + Sound_ChnlControl), a
    
    ; write  $FF to the PSG (set noise attenuation to $F)
    dec   a
    out   (Ports_PSG), a
    
    ; write $FF to the sfx index
    ld    (Sound_SFXIndex), a
    
    pop   hl
    pop   hl
    ret

LABEL_878F:
    ; read a byte of data from the stream and
    ; write it to the PSG
    ld    a, (de)
    out   (Ports_PSG), a
    
    ; get a pointer to primary tone2 channel
    ld    hl, $DDA0
    ; get a pointer to secondary tone1 channel
    ld    iy, $DE30
    
    or    $FC
    inc   a
    jr    nz, LABEL_878D
    
    ; latch tone 2 and set volume to $F
    ld    a, $DF
    out   (Ports_PSG), a
    
    ; reset the "volume only" flag for the current channel
    res   Sound_ChnlVolumeOnlyBit, (ix + Sound_ChnlControl)
    
    ; suppress PSG writes for primary channel2
    set   2, (hl)
    ; suppress PSG writes for secondary channel1
    set   2, (iy + Sound_ChnlControl)
    
    ret

LABEL_878D:
    ; set "volume updates only" flag for the current channel
    set   Sound_ChnlVolumeOnlyBit, (ix + Sound_ChnlControl)
    
    ; jump if secondary channel 1 is active
    bit   7, (iy + $00)
    jr    nz, LABEL_87BA
    
    ; clear "suppress PSG writes" flag for primary channel2
    res   2, (hl)
    ret

LABEL_87BA:
    ; clear "suppress PSG writes" flag for secondary channel1
    res   2, (iy + Sound_ChnlControl)
    ret   


Sound_Command_VolumeEnvelope:       ; $87BF
    ; store the envelope index in the volume effect flags
    ld    (ix + Sound_VolumeEffectFlags), a
    ret


Sound_Command_PitchEnvelope:        ; $87C3
    ; store the envelope index in the tone effect flags
    ld    (ix + Sound_ToneEffectFlags), a
    ret


Sound_Command_Jump:     ; $87C7
    ; retrieve the new pointer from the source data
    ex    de, hl
    ld    e, (hl)
    inc   hl
    ld    d, (hl)
    
    ; decrement the pointer since the next instruction
    ; after the RET will INC DE.
    dec   de
    ret


; these 2 functions set and clear the 16bit read flag
; in the channel control byte
Sound_Command_ReadLiteral:      ; $87CD
    cp    $01
    jr    nz, +
    set   Sound_ChnlReadLiteralBit, (ix + Sound_ChnlControl)
    ret

+:  res   Sound_ChnlReadLiteralBit, (ix + Sound_ChnlControl)
    ret


LABEL_87DB:
    ; fetch the channel number
    ld    a, (ix + Sound_ChnlNumber)
    
    ; jump tone channel 1
    cp    Sound_PSG_Latch | Sound_PSG_Tone1     ;$A0
    jr    z, LABEL_881A
    
    ; jump if tone channel 2
    cp    Sound_PSG_Latch | Sound_PSG_Tone2     ;$C0
    jr    z, LABEL_880E
    
    
    bit   Sound_ChnlVolumeOnlyBit, (ix + Sound_ChnlControl)
    jr    nz, +
    
    ; load HL with pointer to secondary tone 2 channel
    ld    hl, $DE30
    ; jump if channel is active
    bit   7, (hl)
    jp    nz, +

    ; load HL with pointer to primary tone 2 channel
    ld    hl, $DDA0
    res   2, (hl)
    res   6, (hl)
    set   4, (hl)
    
    ; clear the secondary tone2 channel's control byte
    ld    hl, $DE30
    ld    (hl), $00

+:  push  af
    ; read noise channel data?
    ld    a, ($DD11)
    out   (Ports_PSG), a
    pop   af
    
    ld    hl, $DDD0
    jr    LABEL_881D

LABEL_880E:
    ; check to see if secondary tone2 channel is active
    ld    hl, $DE60
    bit   7, (hl)
    ; jump if it is
    jr    nz, LABEL_881D
    
    ; load HL with a pointer to the primary tone2 channel
    ld    hl, $DDA0
    jr    LABEL_881D


LABEL_881A:
    ; load HL with pointer to primary tone1 channel
    ld    hl, $DD70
LABEL_881D:
    res   2, (hl)
    set   4, (hl)
    
    ; turn channel volume off
    or    $1F
    out   (Ports_PSG), a

    ; clear the channel control byte (disable channel)
    xor   a
    ld    (ix + Sound_ChnlControl), a
    
    ld    ix, $DE00
    bit   7, (ix+$00)
    jr    nz, +
    
    ld    ix, $DE30
    bit   7, (ix+$00)
    jr    nz, +
    
    ld    ix, $DE60
    bit   7, (ix+$00)
    jr    nz, +
    
    ; clear the priority value
    xor   a
    ld    (Sound_Priority), a

+:  pop   bc
    pop   bc
    ret


Sound_Command_Branch:        ; $884E
    ; read new data pointer into BC
    ld    c, a
    inc   de
    ld    a, (de)
    ld    b, a

    ; push the new data pointer onto the main stack
    push  bc
    
    ; load the channel structure pointer into HL
    push  ix
    pop   hl
    
    ; read the channel stack pointer into BC and
    ; decrement it by 2 (we'll be pushing a word 
    ; onto the channel stack).
    dec   (ix + Sound_ChnlStackPointer)
    ld    c, (ix + Sound_ChnlStackPointer)
    dec   (ix + Sound_ChnlStackPointer)
    ld    b, $00
    
    ; calculate the absolute address for the calculated 
    ; channel stack pointer
    add   hl, bc
    
    ; store the current data pointer in the channel stack
    ld    (hl), d
    dec   hl
    ld    (hl), e
    
    ; restore the new data pointer into DE
    pop   de
    ; decrement DE since the next instruction after the RET 
    ; will increment DE
    dec   de
    ret


Sound_Command_Return:        ; $8868
    ; load channel pointer into HL
    push  ix
    pop   hl
    
    ; load channel stack pointer into BC
    ld    c, (ix + Sound_ChnlStackPointer)
    ld    b, $00
    
    ; calculate absolute address of channel
    ; stack pointer
    add   hl, bc
    
    ; read old data pointer back into DE
    ld    e, (hl)
    inc   hl
    ld    d, (hl)
    
    ; restore the stack pointer
    inc   (ix + Sound_ChnlStackPointer)
    inc   (ix + Sound_ChnlStackPointer)
    
    ret


Sound_Command_ConditionalJump:      ; $887B
    inc   de
    
    ; loop counter memory starts at offset IX+$27
    add   a, Sound_ChnlLoopCounters

    ld    c, a
    ld    b, $00

    ; load the channel structure pointer into HL
    push  ix
    pop   hl
    
    ; adjust the pointer to the correct offset
    add   hl, bc

    ; read the loop counter from the channel structure
    ld    a, (hl)
    or    a
    jr    nz, +

    ; if the counter is zero this must be the first iteration
    ; of the loop. we need to read the counter value from the 
    ; source data
    ld    a, (de)
    ld    (hl), a

+:  inc   de

    ; decrement the loop counter
    dec   (hl)
    ; branch while the counter != 0
    jp    nz, Sound_Command_Jump

    inc   de
    ret


LABEL_8892:
    call  Sound_MultiplyA
    ld    (ix + $0E), a
    ld    (ix + $0F), a
    ret


Sound_Command_PitchBend:      ; $889C
    ; store the effect data pointer in the channel structure
    ld    (ix + Sound_PitchBendDataPtr), e
    ld    (ix + Sound_PitchBendDataPtr + 1), d
    ; set the effect flag
    ld    (ix + Sound_ToneEffectFlags), Sound_ChnlPitchBend
    ; move the data pointer past the parameter bytes
    inc   de
    inc   de
    inc   de
    ret


Sound_Command_RepeatNote:       ; $88AA
    set   Sound_ChnlKeepStateBit, (ix + Sound_ChnlControl)
    dec   de
    ret

Sound_Command_Detune:        ;$88B0
    ld    (ix + Sound_ChnlDetune), a
    ret


Sound_Command_SetGlobalSpeed:       ;$88B4
    ld    (Sound_Speed), a
    ld    (Sound_SpeedCounter), a
    ret



LABEL_88BB:
    ld    (ix + Sound_VolumeEffectFlags), Sound_VolPreserve
    
    ; HL = pointer to channel structure
    push  ix
    pop   hl
    
    ; adjust the pointer to IX + $20
    ld    b, $00
    ld    c, $20
    add   hl, bc
    
    ; copy 5 bytes into the channel structure
    ex    de, hl
    ldi
    ldi
    ldi
    ldi
    ldi
    ex    de, hl
    
    dec   de
    ret


LABEL_88D5:
    or    a
    jr    z, +
    ld    a, $08
+:  ld    (ix + $1E), a
    ret



Sound_Data_PitchEnvelopes:      ; $88DE
.include "src/sound_pitch_effects.asm"

; volume envelopes
Sound_Data_VolumeEnvelopes:     ; $8A2F
.include "src/sound_volume_effects.asm"

Sound_Data_Priorities:
.incbin "sound\sound_priorities.bin"


; -----------------------------------------------------------------------------
;  Speed values for each music module. Note that these values are referenced
;  but not used. The speed value is stored in the module and any values
;  copied from here are overwritten later, when the module is loaded.
;  See Sound_LoadMusicModule() for more.
; -----------------------------------------------------------------------------
Sound_Data_MusicSpeeds:
.db $03, $00, $05, $00, $00, $03, $00, $00
.db $03, $04, $03, $03, $05, $05, $00, $05
.db $03, $05, $07


Sound_Data_MusicPointers:        ; $8BE7
.dw Sound_Data_Music_ALZ
.dw Sound_Data_Music_UGZ
.dw Sound_Data_Music_GMZ 
.dw Sound_Data_Music_CEZ
.dw Sound_Data_Music_GHZ
.dw Sound_Data_Music_SHZ
.dw Sound_Data_Music_SEZ
.dw Sound_Data_Music_Intro
.dw Sound_Data_Music_Boss
.dw Sound_Data_Music_SpeedShoes
.dw Sound_Data_Music_Invincibility
.dw Sound_Data_Music_EndOfLevel
.dw Sound_Data_Music_LoseLife 
.dw Sound_Data_Music_Continue
.dw Sound_Data_Music_Emerald
.dw Sound_Data_Music_GameOver
.dw Sound_Data_Music_Ending 
.dw Sound_Data_Music_Unknown
.dw Sound_Data_Music_TitleCard


Sound_Data_SFXPointers:         ; $8C0D
.dw Sound_Data_SFX_Ring         ; $00
.dw Sound_Data_SFX_Roll         ; $01
.dw Sound_Data_SFX_Spring       ; $02
.dw Sound_Data_SFX_Jump         ; $03
.dw Sound_Data_SFX_04
.dw Sound_Data_SFX_05
.dw Sound_Data_SFX_06
.dw Sound_Data_SFX_07
.dw Sound_Data_SFX_08
.dw Sound_Data_SFX_09
.dw Sound_Data_SFX_0A
.dw Sound_Data_SFX_0B
.dw Sound_Data_SFX_0C 
.dw Sound_Data_SFX_0D
.dw Sound_Data_SFX_0E
.dw Sound_Data_SFX_0F
.dw Sound_Data_SFX_10
.dw Sound_Data_SFX_11
.dw Sound_Data_SFX_12
.dw Sound_Data_SFX_13
.dw Sound_Data_SFX_14
.dw Sound_Data_SFX_15
.dw Sound_Data_SFX_16
.dw Sound_Data_SFX_17
.dw Sound_Data_SFX_18
.dw Sound_Data_SFX_19
.dw Sound_Data_SFX_1A
.dw Sound_Data_SFX_1B
.dw Sound_Data_SFX_1B
.dw Sound_Data_SFX_1B
.dw Sound_Data_SFX_1B
.dw Sound_Data_SFX_1B
.dw Sound_Data_SFX_1B
.dw Sound_Data_SFX_1B
.dw Sound_Data_SFX_1B
.dw Sound_Data_SFX_1B
.dw Sound_Data_SFX_1B
.dw Sound_Data_SFX_1B

Sound_Data_Music_ALZ:           ; $8C59
;.incbin "sound/music_alz.bin"
.include "sound/music_alz.asm"

Sound_Data_Music_UGZ:           ; $8F98
;.incbin "sound/music_ugz.bin"
.include "sound/music_ugz.asm"

Sound_Data_Music_GMZ:           ; $94DD
;.incbin "sound/music_gmz.bin"
.include "sound/music_gmz.asm"

Sound_Data_Music_CEZ:           ; $9819
;.incbin "sound/music_cez.bin"
.include "sound/music_cez.asm"

Sound_Data_Music_GHZ:           ; $9B99
;.incbin "sound/music_ghz.bin"
.include "sound/music_ghz.asm"

Sound_Data_Music_SHZ:           ; $A053
;.incbin "sound/music_shz.bin"
.include "sound/music_shz.asm"

Sound_Data_Music_SEZ:           ; $A2CE
;.incbin "sound/music_sez.bin"
.include "sound/music_sez.asm"

Sound_Data_Music_Intro:         ; $A7C6
;.incbin "sound/music_intro.bin"
.include "sound/music_intro.asm"
;.include "sound/music_test.asm"

Sound_Data_Music_Boss:          ; $AA00
;.incbin "sound/music_boss.bin"
.include "sound/music_boss.asm"

Sound_Data_Music_SpeedShoes:    ; $AB9A
;.incbin "sound/music_speed_shoes.bin"
.include "sound/music_speed_shoes.asm"

Sound_Data_Music_Invincibility: ; $AC88
;.incbin "sound/music_invincibility.bin"
.include "sound/music_invincibility.asm"

Sound_Data_Music_EndOfLevel:    ; $AE1E
;.incbin "sound/music_end_of_level.bin"
.include "sound/music_end_of_level.asm"

Sound_Data_Music_LoseLife:      ; $AF1C
;.incbin "sound/music_lose_life.bin"
.include "sound/music_lose_life.asm"

Sound_Data_Music_Continue:      ; $AFA4
;.incbin "sound/music_continue.bin"
.include "sound/music_continue.asm"

Sound_Data_Music_Emerald:       ; $B0BE
;.incbin "sound/music_emerald.bin"
.include "sound/music_emerald.asm"

Sound_Data_Music_GameOver:      ; $B176
;.incbin "sound/music_gameover.bin"
.include "sound/music_gameover.asm"

Sound_Data_Music_Ending:        ; $B232
;.incbin "sound/music_ending.bin"
.include "sound/music_ending.asm"

Sound_Data_Music_Unknown:       ; $B946 
;.incbin "sound/music_unknown.bin"
.include "sound/music_unknown.asm"

Sound_Data_Music_TitleCard:     ; $BA90
;.incbin "sound/music_titlecard.bin"
.include "sound/music_titlecard.asm"


Sound_Data_SFX_Ring:            ; $BAEA
;.incbin "sound/sfx_ring.bin"
.include "sound/sfx_ring.asm"

Sound_Data_SFX_Roll:            ; $BB07
;.incbin "sound/sfx_roll.bin"
.include "sound/sfx_roll.asm"

Sound_Data_SFX_Spring:          ; $BB1F
;.incbin "sound/sfx_spring.bin"
.include "sound/sfx_spring.asm"

Sound_Data_SFX_Jump:            ; $BB45
;.incbin "sound/sfx_jump.bin"
.include "sound/sfx_jump.asm"

Sound_Data_SFX_04:              ; $BB6C
;.incbin "sound/sfx_04.bin"
.include "sound/sfx_04.asm"

Sound_Data_SFX_05:              ; $BB89
;.incbin "sound/sfx_05.bin"
.include "sound/sfx_05.asm"

Sound_Data_SFX_06:              ; $BBB8
;.incbin "sound/sfx_06.bin"
.include "sound/sfx_06.asm"

Sound_Data_SFX_07:              ; $BBD0
;.incbin "sound/sfx_07.bin"
.include "sound/sfx_07.asm"

Sound_Data_SFX_08:              ; $BBE6
;.incbin "sound/sfx_08.bin"
.include "sound/sfx_08.asm"

Sound_Data_SFX_09:              ; $BBF8
;.incbin "sound/sfx_09.bin"
.include "sound/sfx_09.asm"

Sound_Data_SFX_0A:              ; $BC0B
;.incbin "sound/sfx_0A.bin"
.include "sound/sfx_0A.asm"

Sound_Data_SFX_0B:              ; $BC33
;.incbin "sound/sfx_0B.bin"
.include "sound/sfx_0B.asm"

Sound_Data_SFX_0C:              ; $BC56
;.incbin "sound/sfx_0C.bin"
.include "sound/sfx_0C.asm"

Sound_Data_SFX_0D:              ; $BC7F
;.incbin "sound/sfx_0D.bin"
.include "sound/sfx_0D.asm"

Sound_Data_SFX_0E:              ; $BCBF
;.incbin "sound/sfx_0E.bin"
.include "sound/sfx_0E.asm"

Sound_Data_SFX_0F:              ; $BCDC
;.incbin "sound/sfx_0F.bin"
.include "sound/sfx_0F.asm"

Sound_Data_SFX_10:              ; $BCF0
;.incbin "sound/sfx_10.bin"
.include "sound/sfx_10.asm"

Sound_Data_SFX_11:              ; $BD0D
;.incbin "sound/sfx_11.bin"
.include "sound/sfx_11.asm"

Sound_Data_SFX_12:              ; $BD21
;.incbin "sound/sfx_12.bin"
.include "sound/sfx_12.asm"

Sound_Data_SFX_13:              ; $BD3C
;.incbin "sound/sfx_13.bin"
.include "sound/sfx_13.asm"

Sound_Data_SFX_14:              ; $BD53
;.incbin "sound/sfx_14.bin"
.include "sound/sfx_14.asm"

Sound_Data_SFX_15:              ; $BD6D
;.incbin "sound/sfx_15.bin"
.include "sound/sfx_15.asm"

Sound_Data_SFX_16:              ; $BD8D
;.incbin "sound/sfx_16.bin"
.include "sound/sfx_16.asm"

Sound_Data_SFX_17:              ; $BDC0
;.incbin "sound/sfx_17.bin"
.include "sound/sfx_17.asm"

Sound_Data_SFX_18:              ; $BDE0
;.incbin "sound/sfx_18.bin"
.include "sound/sfx_18.asm"

Sound_Data_SFX_19:              ; $BE0D
;.incbin "sound/sfx_19.bin"
.include "sound/sfx_19.asm"

Sound_Data_SFX_1A:              ; $BE2A 
    Stop

Sound_Data_SFX_1B:              ; $BE2F
.db $FF

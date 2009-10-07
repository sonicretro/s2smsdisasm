; ---------------------------------------------------------
;  RAM Variables
; ---------------------------------------------------------

; If the reset trigger is not 0, for each iteration of the game loop
; the trigger value is decremented and the PSG is intialised.
; If ($0 < value < $80) the sound driver is disabled.
.def    Sound_SpeedCounter          $DD01
.def    Sound_Speed                 $DD02   ; the speed counter reset value
.def    Sound_CurrentMusic          $DD03
.def    Sound_MusicTrigger1         $DD04
.def    Sound_MusicTrigger2         $DD05
.def    Sound_MusicTrigger3         $DD06

.def    Sound_ResetTrg              $DD08
.def    Sound_FadeMajorCount        $DD09
.def    Sound_FadeMinorCount        $DD0A
.def    Sound_FadeMinorReset        $DD0B

.def    Sound_SFXIndex              $DD0D   ; copy of the current sound effect number (see $81C7)

.def    Sound_Priority              $DD0F

; $DD11 - last noise channel command data ($86CF) ?

; $DD15 - something to do with noise channel data?
.def    Sound_NoiseChnlVolume       $DD16   ; noise channel attenuation

; ---------------------------------------------------------
;  Channel Structure Offsets
; ---------------------------------------------------------
.def    Sound_ChnlControl           $00
.def    Sound_ChnlNumber            $01
.def    Sound_ChnlSpeed             $02
.def    Sound_ChnlNextCommand       $03

.def    Sound_ChnlPitchAdjust       $05
.def    Sound_ChnlVolumeAdjust      $06

.def    Sound_ToneEffectFlags       $07     ; if MSB is set the effect is a pitch bend, otherwise it's an envelope.
.def    Sound_VolumeEffectFlags     $08
.def    Sound_ChnlStackPointer      $09		; used as a stack pointer. channel stack starts at (channel + 2F)
.def    Sound_ChnlToneDuration      $0A		; tone duration counter. decremented with each loop
.def    Sound_ChnlToneData          $0B		; Read by routine at $82D0 and written to the PSG.
.def    Sound_ChnlToneDuration_Next $0D		; next tone duration value

.def    Sound_PitchBendDataPtr      $10     ; pointer to data for the pitch bend effect
.def    Sound_ChnlToneAdjustment    $12     ; tone adjustment value (2 bytes). added to value at offset $0B

.def    Sound_PitchBendCountdown    $14     ; countdown value before applying pitch bend effect
.def    Sound_PitchBendLength       $15     ; number of ticks between changing the pitch adjustment value
.def    Sound_PitchBendStepValue    $16     ; value to add to the tone with each application of the effect
.def    Sound_PitchBendRepeat       $17     ; number of times to repeat the effect before negating the step value

.def    Sound_PitchEnvlpIndex       $15     ; note: same offset as Sound_PitchBendLength.

; $1D - flags

.def    Sound_ChnlVolume            $1F
.def    Sound_VolEnvlpIndex         $1F     ; note: shared with Sound_ChnlVolume

; volume effects
.def    Sound_ChnlVolEffectAdjust   $20

.def	Sound_ChnlDetune        	$25		; added to the tone data before writing to the PSG

.def    Sound_ChnlLoopCounters      $27     ; 3 loop counters are available
.def    Sound_ChnlLoopCounter0      Sound_ChnlLoopCounters
.def    Sound_ChnlLoopCounter1      Sound_ChnlLoopCounter0 + 1      
.def    Sound_ChnlLoopCounter2      Sound_ChnlLoopCounter1 + 1

.def    Sound_ChnlBranchSlots       $2A
.def    Sound_ChnlBranchSlot2       Sound_ChnlBranchSlots
.def    Sound_ChnlBranchSlot1       $2C
.def    Sound_ChnlBranchSlot0       $2E


; ---------------------------------------------------------
;  Channel control bits
; ---------------------------------------------------------
.def    Sound_ChnlKeepStateBit      1
.def    Sound_ChnlKeepState         1 << Sound_ChnlKeepStateBit

.def    Sound_ChannelSuppressBit    2
.def    Sound_ChannelSuppress       1 << Sound_ChannelSuppressBit

; if set the next word in the channel data stream is the literal
; tone data value which should be copied into (IX+$0B)
.def    Sound_ChnlReadLiteralBit    3
.def    Sound_ChnlReadLiteral       1 << Sound_ChnlReadLiteralBit

.def    Sound_ChnlVolSuppressBit    4
.def    Sound_ChnlVolSuppress       1 << Sound_ChnlVolSuppressBit

.def    Sound_ChnlVolumeOnlyBit     6
.def    Sound_ChnlVolumeOnly        1 << Sound_ChnlVolumeOnlyBit

.def	Sound_ChannelActiveBit	    7
.def	Sound_ChannelActive		    1 << Sound_ChannelActiveBit


; ---------------------------------------------------------
;  Tone Flag bits
; ---------------------------------------------------------
.def    Sound_ChnlPitchBendBit      7
.def    Sound_ChnlPitchBend         1 << Sound_ChnlPitchBendBit


; ---------------------------------------------------------
;  Volume Flag bits
; ---------------------------------------------------------
.def    Sound_VolPreserveBit        7
.def    Sound_VolPreserve           1 << Sound_VolPreserveBit


; ---------------------------------------------------------
;  PSG Command Bits
; ---------------------------------------------------------
.def    Sound_PSG_Latch             $80
.def    Sound_PSG_Tone0             $00
.def    Sound_PSG_Tone1             1 << 5
.def    Sound_PSG_Tone2             2 << 5
.def    Sound_PSG_Noise             3 << 5
.def    Sound_PSG_Type_Volume       $10


; ---------------------------------------------------------
;  Channel Structure Locations
; ---------------------------------------------------------
.def    Sound_ChannelSize       $30
.enum $DD40
	Sound_Channel_Music_0		dsb	Sound_ChannelSize   ; $DD40
	Sound_Channel_Music_1		dsb	Sound_ChannelSize   ; $DD70
	Sound_Channel_Music_2		dsb	Sound_ChannelSize   ; $DDA0
	Sound_Channel_Music_Noise	dsb	Sound_ChannelSize   ; $DDD0
    ;dsb $10
	Sound_Channel_SFX_0			dsb	Sound_ChannelSize   ; $DE00
	Sound_Channel_SFX_1			dsb	Sound_ChannelSize   ; $DE30
	Sound_Channel_SFX_2			dsb	Sound_ChannelSize   ; $DE60
.ende


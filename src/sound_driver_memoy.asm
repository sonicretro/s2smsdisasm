.struct Sound_ToneChannel
    Control         db
    PSGChannel      db
    Multiplier      db
    NextComandPtr   dw      ; pointer into sound data
    ToneAdjust      db      ; tone adjustment value
    Attenuation     db      ; volume attenuation value
    
    unk00           db
    unk01           db
    
    StackPtr        db
    TickCounter     db
    Tone            dw
    TickReset       db
.ends


.enum   SOUND_DRIVER_START
    sound_unk_01            dsb     7
    
    Sound_ResetTrigger      db
    Sound_FadeMajorCount    db
    Sound_FadeMinorCount    db
    Sound_FadeMinorReset    db
    
    sound_unk_02            dsb     11
    
    Sound_NoiseAttenuation  db
    
; -----------------------------------------------------------------------------
sound_unk_03_s:             .dw
    sound_unk_03            dsb     SOUND_DRIVER_START + $40 - sound_unk_03_s
; -----------------------------------------------------------------------------

.ende

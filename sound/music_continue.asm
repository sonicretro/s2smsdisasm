music_continue_bin:
.dw $8A2F
.db $04        ;num channels
.db $00
.db $02
.db $05

music_continue_bin_Channel0_Header:
.dw music_continue_bin_Channel0
.db $FF        ; pitch adjustment
.db $03        ; volume adjustment

music_continue_bin_Channel1_Header:
.dw music_continue_bin_Channel1
.db $FF        ; pitch adjustment
.db $03        ; volume adjustment

music_continue_bin_Channel2_Header:
.dw music_continue_bin_Channel2
.db $FF        ; pitch adjustment
.db $03        ; volume adjustment

music_continue_bin_Channel3_Header:
.dw music_continue_bin_Channel3
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

music_continue_bin_Channel0:
    Branch          music_continue_bin_LABEL_AFEE
    SetGlblSpeed    10
    Branch          music_continue_bin_LABEL_AFEE
    SetGlblSpeed    20
    Branch          music_continue_bin_LABEL_AFEE
    SetGlblSpeed    0
    Branch          music_continue_bin_LABEL_AFEE
.db $F0
    .db $09
    .db $01
    .db $01
    .db $05
    PitchAdjust     -4
    VolumeEnvelope  3
   
    C5
        .db 3
    C5
    C5
    C5
    Rest
        .db 12
    VolumeEnvelope  6
    As4
    B4
    VolumeEnvelope  8
    C5
        .db 6
    C4
music_continue_bin_LABEL_AFE5:
    AdjustVolume    2
    C4
    Loop            0, 5, music_continue_bin_LABEL_AFE5
    Stop
    
music_continue_bin_LABEL_AFEE:
    VolumeEnvelope  8
.db $F0
    .db $09
    .db $01
    .db $01
    .db $05
    Fs5
        .db 1
    G5
        .db 11
    Fs5
        .db 1
    G5
        .db 8
    F5
        .db 9
    E5
        .db 6
    E5
        .db 1
    F5
        .db 5
    E5
        .db 12
    C5
    G4
        .db 18
.db $F0
    .db $01
    .db $01
    .db $FB
    .db $01
    G4
        .db 12

    PitchAdjust     1
    Return

music_continue_bin_Channel2:
    VolumeEnvelope  7
    C4
        .db 6
    A3
    G3
    A3
        .db 3
    C4
        .db 6
    C4
        .db 3
    A3
        .db 6
    G3
    A3
    Loop            0, 2, music_continue_bin_Channel2
    
    PitchAdjust     1
    Loop            1, 4, music_continue_bin_Channel2
    
    PitchAdjust     -4
    VolumeEnvelope  3

    C3
        .db $03
    C3
    C3
    C3
    Rest
        .db 12
        
    VolumeEnvelope  6
    As3
    B3
    VolumeEnvelope  8
    C4
        .db 6
    C3
    
music_continue_bin_LABEL_B044:
    AdjustVolume    2
    C3
    Loop            0, 5, music_continue_bin_LABEL_B044
    Stop



music_continue_bin_Channel1:
    VolumeEnvelope  8
.db $F0
    .db $09
    .db $01
    .db $01
    .db $05
    Ds5
        .db $01
    E5
        .db $0B
    Ds5
        .db $01
    E5
        .db $08
    D5
        .db $09
    C5
        .db $06
    C5
        .db $01
    D5
        .db $05
    C5
        .db $0C
    G4
    E4
        .db $12
.db $F0
    .db $01
    .db $01
    .db $FB
    .db $01
    E4
        .db $0C
        
    PitchAdjust     1
    Loop            0, 4, music_continue_bin_Channel1

.db $F0
    .db $09
    .db $01
    .db $01
    .db $05
    PitchAdjust     -4
    VolumeEnvelope  3
    E4
        .db $03
    E4
    E4
    E4
    Rest
        .db 12
    
    VolumeEnvelope  6
    D4
    Ds4
    VolumeEnvelope  8
    E4
        .db $06
    E3
    
music_continue_bin_LABEL_B090:
    AdjustVolume    2
    E3
    Loop            0, 5, music_continue_bin_LABEL_B090
    Stop



music_continue_bin_Channel3:
.db $81    ; C3
    .db $03
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
    Loop            0, 31, music_continue_bin_Channel3
.db $88    ; G3
    .db $03
.db $81    ; C3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
    .db $03
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $80
    .db $0C
.db $81    ; C3
    .db $03
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $88    ; G3
    .db $06
.db $88    ; G3
.db $80
    .db $30
    Stop


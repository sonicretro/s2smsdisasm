music_ghz_bin:
.dw $8A2F
.db $04        ;num channels
.db $00
.db $02
.db $00

music_ghz_bin_Channel0_Header:
.dw music_ghz_bin_Channel0
.db $FF        ; pitch adjustment
.db $03        ; volume adjustment

music_ghz_bin_Channel1_Header:
.dw music_ghz_bin_Channel1
.db $FF        ; pitch adjustment
.db $05        ; volume adjustment

music_ghz_bin_Channel2_Header:
.dw music_ghz_bin_Channel2
.db $FF        ; pitch adjustment
.db $03        ; volume adjustment

music_ghz_bin_Channel3_Header:
.dw music_ghz_bin_Channel3
.db $00        ; pitch adjustment
.db $00        ; volume adjustment


music_ghz_bin_Channel0:
    VolumeEnvelope  4
    PitchAdjust     -12         ; shift down an octave
    
music_ghz_bin_LABEL_9BB3:
    Branch          Mus_GHZ_Ch0_Intro
    Loop            0, 2, music_ghz_bin_LABEL_9BB3

    PitchAdjust     12          ; shift up an octave

music_ghz_bin_LABEL_9BBD:
    VolumeEnvelope  6
    
music_ghz_bin_LABEL_9BBF:
    E6
        .db $06
    RepeatLast      2
    
    D6
        .db $01
    C6
    B5
    A5
    AdjustVolume    2
    Loop            0, 4, music_ghz_bin_LABEL_9BBF

    AdjustVolume    -8
    E5
        .db $03
    A5
    B5
    D6
    E6
        .db $06
    RepeatLast      2
    
    D6
        .db $01
    C6
    B5
    A5
    F6
        .db $01
    Fs6
        .db $08
    D6
        .db $09
    Cs6
        .db $06

music_ghz_bin_LABEL_9BE7:
    E6
        .db $06
    RepeatLast      2
    
    D6
        .db $01
    C6
    B5
    A5
    AdjustVolume    2
    Loop            0, 4, music_ghz_bin_LABEL_9BE7

    AdjustVolume    -8
    E5
        .db $03
    A5
    B5
    D6
    E6
        .db $06
    RepeatLast      2
    
    D6
        .db $01
    C6
    B5
    A5
    Gs6
        .db $01
    A6
        .db $08
    Gs6
        .db $09
    D6
        .db $06
    Loop            2, 2, music_ghz_bin_LABEL_9BBD
    Branch          music_ghz_bin_LABEL_9D87

    VolumeEnvelope  8
    As5
        .db $09
    B5
    As5
        .db $06
    A5
        .db $09
    G5
    E5
        .db $06
    Rest
        .db $06
    
    E5
    G5
    E5
    G5
    E5
        .db $03
    G5
        .db $05
    Rest
        .db $01

    G5
        .db $03
    E5
        .db $06
    D5
        .db $09
    E5
.db $F0
    .db $0F
    .db $01
    .db $01
    .db $06
    B4
        .db $42
    Rest
        .db $0C
    
.db $F0
    .db $00
    .db $00
    .db $00
    .db $00
    AdjustVolume    1
    VolumeEnvelope  5
    D6
        .db $01
    E6
        .db $04
    Rest
        .db $01
    
    D6
        .db $04
    Rest
        .db $02
    
    D6
        .db $01
    E6
        .db $04
    Rest
        .db $01
    
    D6
        .db $04
    Rest
        .db $02
    
    VolumeEnvelope  5
    E6
        .db $09
    G6
        .db $03
    AdjustVolume    2
    Rest
    
    G6
    Rest
    
    AdjustVolume    2
    G6
    AdjustVolume    -4
    VolumeEnvelope  5
    Rest
        .db $03
    
    D6
        .db $01
    E6
        .db $01
    Rest
        .db $01

    D6
        .db $04
    Rest
        .db $02
    
    D6
        .db $01
    E6
        .db $04
    Rest
        .db $01

    D6
        .db $04
    Rest
        .db $02

    VolumeEnvelope  5
    E6
        .db $09
    G6
        .db $03
    AdjustVolume    2
    Rest
    G6
    Rest
    
    AdjustVolume    2
    G6
    AdjustVolume    -4
    AdjustVolume    -1
    Branch          music_ghz_bin_LABEL_9D87
    
    VolumeEnvelope  8
    As5
        .db $09
    B5
    As5
        .db $06
    A5
        .db $09
    G5
    E5
        .db $06
    Rest
        .db $06
    E5
    G5
    E5
    G5
    E5
        .db $03
    G5
        .db $05
    Rest
        .db $01
    E5
        .db $03
    D5
    E5
    A5
        .db $09
    As5
.db $F0
    .db $0F
    .db $01
    .db $01
    .db $06
    B5
        .db $42
    Rest
        .db $0C
    
.db $F0
    .db $00
    .db $00
    .db $00
    .db $00
    
music_ghz_bin_LABEL_9CC6:
    VolumeEnvelope  6
    B6
    .db $06
.db $E7
    .db $02
    As6
    .db $01
    A6
    Gs5
    G5
    AdjustVolume    2
    Loop            0, 4, music_ghz_bin_LABEL_9CC6
    
    AdjustVolume    -8
    Loop            1, 2, music_ghz_bin_LABEL_9CC6

    VolumeEnvelope  6
    G6
    .db $01
    Gs6
    .db $05
    Gs6
    .db $06
    A6
    Gs6
    E6
    .db $09
    B5
    Gs6
    .db $0C
    Gs6
    .db $06
    A6
    Gs6
    E6
    .db $18
    G6
    .db $01
    Gs6
    .db $05
    Gs6
    .db $06
    A6
    Gs6
    E6
    .db $09
    B5
    Gs6
    .db $0C
    A6
    .db $06
    As6
    B6
    E6
    .db $18
    B6
    .db $06
    B6
    A6
    .db $09
    E6
    Cs6
    .db $0C
    B6
    B6
    .db $06
    A6
    .db $09
    E6
    .db $09
    Cs6
    .db $06
    E6
    Fs6
    G6
    .db $1E
    Fs6
    .db $0C
    G6
    .db $06
    A6
    .db $09
    G6
    A6
    .db $06
    A6
    .db $01
    B6
    .db $17
    G6
    .db $01
    Gs6
    .db $05
    Gs6
    .db $06
    A6
    Gs6
    E6
    .db $09
    B5
    Gs6
    .db $0C
    Gs6
    .db $06
    A6
    Gs6
    E6
    .db $18
    G6
    .db $01
    Gs6
    .db $05
    Gs6
    .db $06
    A6
    Gs6
    E6
    .db $09
    B5
    Gs6
    .db $0C
    A6
    .db $06
    As6
    B6
    E6
    .db $18
    B6
    .db $06
    B6
    A6
    .db $09
    E6
    Cs6
    .db $0C
    B6
    B6
    .db $06
    A6
    .db $09
    E6
    .db $09
    Cs6
    .db $06
    E6
    Fs6
    G6
    .db $1E
    Fs6
    .db $0C
    G6
    .db $06
    A6
    .db $09
    G6
    A6
    .db $06
    A6
    .db $01
    B6
    .db $17
    Jump            music_ghz_bin_LABEL_9BBD
    Stop


music_ghz_bin_LABEL_9D75:
    E5
    .db $03
    B4
    D5
    E5
    Rest
    
    B4
    D5
    E5
    Fs5
    E5
    D5
    B4
    A5
    Gs5
    Fs5
    D5
    Return


music_ghz_bin_LABEL_9D87:
    VolumeEnvelope  7
    D5
    .db $01
    E5
    .db $04
    Rest
    .db $01
    D5
    .db $04
    Rest
    .db $02

    D5
    .db $01
    E5
    .db $04
    Rest
    .db $01

    D5
    .db $04
    Rest
    .db $02

    VolumeEnvelope  5
    E5
    .db $09
    G5
    .db $03
    AdjustVolume    2
    Rest
    
    G5
    Rest
    
    AdjustVolume    2
    G5
    AdjustVolume    -4
    Rest
    .db $03
    
    E5
    D5
    Rest

    D5
    .db $01
    E5
    .db $04
    Rest
    .db $01
    
    D5
    .db $04
    Rest
    .db $02

    VolumeEnvelope  5
    E5
    .db $09
    G5
    A5
    .db $06
    Return

music_ghz_bin_Channel2:
    Detune          -1

music_ghz_bin_LABEL_9DC6:
    VolumeEnvelope  7
    E3
    .db $06
    E3
    E4
    E3
    .db $02
    Rest
    .db $01
    E3
    .db $06
    E3
    E3
    .db $02
    Rest
    .db $01
    
    E4
    .db $06
    E3
    E3
    .db $06
    E3
    E4
    E3
    .db $02
    Rest
    .db $01

    D3
    .db $06
    D3
    D3
    .db $02
    Rest
    .db $01
    
    Cs3
    .db $06
    D3
    Loop            0, 2, music_ghz_bin_LABEL_9DC6

music_ghz_bin_LABEL_9DF1:
    VolumeEnvelope  7
    E3
    .db $06
    E3
    E4
    E3
    .db $02
    Rest
    .db $01
    E3
    .db $06
    E3
    E3
    .db $02
    Rest
    .db $01

    E4
    .db $06
    E3
    E3
    .db $06
    E3
    E4
    E3
    .db $02
    Rest
    .db $01

    D3
    .db $06
    D3
    D3
    .db $02
    Rest
    .db $01
    
    Cs3
    .db $06
    D3
    Loop            0, 4, music_ghz_bin_LABEL_9DF1
    
music_ghz_bin_LABEL_9E1C:
    A3
    .db $06
    A3
    A4
    G3
    .db $02
    Rest
    .db $01
    G3
    .db $06
    G3
    G3
    .db $02
    Rest
    .db $01

    Fs3
    .db $06
    G3
    Loop            0, 4, music_ghz_bin_LABEL_9E1C

music_ghz_bin_LABEL_9E33:
    E3
    .db $06
    E3
    E4
    E3
    .db $02
    Rest
    .db $01

    D3
    .db $06
    D3
    D3
    .db $02
    Rest
    .db $01
    Cs3
    .db $06
    D3
    Loop            0, 4, music_ghz_bin_LABEL_9E33

music_ghz_bin_LABEL_9E4A:
    A3
    .db $06
    A3
    A4
    G3
    .db $02
    Rest
    .db $01

    G3
    .db $06
    G3
    G3
    .db $02
    Rest
    .db $01
    
    Fs3
    .db $06
    G3
    Loop            0, 4, music_ghz_bin_LABEL_9E4A

music_ghz_bin_LABEL_9E61:
    E3
    .db $06
    E3
    E4
    E3
    .db $02
    Rest
    .db $01
    
    D3
    .db $06
    D3
    D3
    .db $02
    Rest
    .db $01
    
    Cs3
    .db $06
    D3
    Loop            0, 2, music_ghz_bin_LABEL_9E61

music_ghz_bin_LABEL_9E78:
    B3
    .db $06
    B3
    B4
    B3
    .db $02
    Rest
    .db $01
    
    A3
    .db $06
    A3
    A3
    .db $02
    Rest
    .db $01
    
    Gs3
    .db $06
    A3
    Loop            0, 2, music_ghz_bin_LABEL_9E78
    
music_ghz_bin_LABEL_9E8F:
    E3
    .db $06
    E3
    E4
    E3
    .db $02
    Rest
    .db $01

    E3
    .db $06
    E3
    E3
    .db $02
    Rest
    .db $01
    
    E4
    .db $06
    E3
    Loop            0, 2, music_ghz_bin_LABEL_9E8F

music_ghz_bin_LABEL_9EA6:
    D3
    .db $06
    D3
    D4
    D3
    .db $02
    Rest
    .db $01
    
    D3
    .db $06
    D3
    D3
    .db $02
    Rest
    .db $01
    
    D4
    .db $06
    D3
    Loop            0, 2, music_ghz_bin_LABEL_9EA6

music_ghz_bin_LABEL_9EBD:
    Cs3
    .db $06
    Cs3
    Cs4
    Cs3
    .db $02
    Rest
    .db $01
    
    Cs3
    .db $06
    Cs3
    Cs3
    .db $02
    Rest
    .db $01
    
    Cs4
    .db $06
    Cs3
    Loop            0, 2, music_ghz_bin_LABEL_9EBD

    C3
    .db $06
    C3
    C4
    C3
    .db $02
    Rest
    .db $01
    
    C3
    .db $06
    C3
    C3
    .db $02
    Rest
    .db $01
    
    C4
    .db $06
    C3
    C3
    .db $06
    C3
    C4
    C3
    .db $02
    Rest
    .db $01
    
    C3
    .db $06
    D3
    D3
    .db $02
    Rest
    .db $01
    
    D4
    .db $06
    D3
    Loop            1, 2 music_ghz_bin_LABEL_9E8F
    Jump            music_ghz_bin_LABEL_9DF1
    Stop


music_ghz_bin_Channel1:
    PitchAdjust     -12     ; shift down an octave
    
music_ghz_bin_LABEL_9F03:
    VolumeEnvelope  5
    Branch          Mus_GHZ_Ch1_Intro
    Loop            0, 2, music_ghz_bin_LABEL_9F03
    
music_ghz_bin_LABEL_9F0D:
    VolumeEnvelope  3
    PitchAdjust     12      ; shift up an octave
    Branch          music_ghz_bin_LABEL_9D75
    
    PitchAdjust     -12     ;shift down an octave
    Loop            $01, $08, music_ghz_bin_LABEL_9F0D

    Branch          music_ghz_bin_LABEL_9FC0
    PitchAdjust     -5
    
    Branch          music_ghz_bin_LABEL_9FC0
    PitchAdjust     5
    
    Branch          music_ghz_bin_LABEL_9FC0
    PitchAdjust     -5
    
    Branch          music_ghz_bin_LABEL_9FD7
    Branch          music_ghz_bin_LABEL_9FD7
    PitchAdjust     7
    
    Branch          music_ghz_bin_LABEL_9FD7
    Branch          music_ghz_bin_LABEL_9FD7
    
    PitchAdjust     -2
    PitchAdjust     -12
    Detune          -1
    
music_ghz_bin_LABEL_9F3E:
    E6
    .db $03
    A6
    B6
    D7
    E7
    A7
    B7
    D8
    E8
    D8
    B7
    A7
    E7
    D7
    B6
    A6
    Loop            0, 4, music_ghz_bin_LABEL_9F3E
    
music_ghz_bin_LABEL_9F54:
    E6
    Gs6
    A6
    B6
    E7
    Gs7
    A7
    B7
    E8
    B7
    A7
    Gs7
    E7
    B6
    A6
    Gs6
    Loop            0, 2, music_ghz_bin_LABEL_9F54
    
    E6
    G6
    C7
    D7
    E7
    G7
    C8
    D8
    E8
    D8
    C8
    G7
    E7
    D7
    C7
    G6
    E6
    G6
    C7
    D7
    E7
    G7
    C8
    E8
    Fs8
    D8
    A7
    Fs7
    D7
    A6
    Fs6
    E6
    Loop            1, 2, music_ghz_bin_LABEL_9F3E
    
    Detune          -1
    PitchAdjust     12
    Jump            music_ghz_bin_LABEL_9F0D
    
    Stop


Mus_GHZ_Ch1_Intro:
    E5
    .db $06
    B5
    A5
    E5
    B5
    .db $09
    A5
    B5
    .db $06
    
    Rest
    .db $06
    
    B5
    A5
    
    Rest
    
    B5
    .db $09
    A5
    B5
    .db $06
    Return


Mus_GHZ_Ch0_Intro:      ; $9FAB
    Gs5
    .db $06
    E6
    D6
    Gs5
    E6
    .db $09
    D6
    E6
    .db $06
    Gs5
    .db $06
    E6
    D6
    Gs5
    E6
    .db $09
    D6
    E6
    .db $06
    Return

music_ghz_bin_LABEL_9FC0:
    A5
    .db $03
    D6
    E6
    A6
    Rest
    
    A5
    D6
    E6
    A6
    Rest
    
    A5
    Rest
    
    A6
    E6
    D6
    A5
    Loop            0, 4, music_ghz_bin_LABEL_9FC0
    Return


music_ghz_bin_LABEL_9FD7:
    A5
    .db $03
    D6
    E6
    A6
    Rest
    
    A5
    D6
    E6
    A6
    Rest
    
    A5
    Rest
    
    A6
    E6
    D6
    A5
    Return


music_ghz_bin_Channel3:
.db $80
    .db $0C
.db $88    ; G3
.db $80
.db $88    ; G3
.db $80
.db $88    ; G3
.db $80
.db $88    ; G3
.db $84    ; Ds3
.db $88    ; G3
.db $84    ; Ds3
.db $88    ; G3
.db $81    ; C3
    .db $06
.db $84    ; Ds3
.db $81    ; C3
    .db $03
.db $80
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $81    ; C3
.db $88    ; G3
.db $88    ; G3
music_ghz_bin_LABEL_A006:
.db $84    ; Ds3
    .db $03
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $84    ; Ds3
    .db $03
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $F7
    .db $00
    .db $03
    .dw music_ghz_bin_LABEL_A006
.db $84    ; Ds3
    .db $03
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
    .db $03
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $F6
    .dw music_ghz_bin_LABEL_A006
.db $F2


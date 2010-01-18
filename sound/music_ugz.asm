music_ugz_bin:
.dw $8A2F
.db $04     ; num channels
.db $00
.db $02     ; channel speed modifier
.db $00     ; global speed modifier

music_ugz_bin_Channel0_Header:
.dw music_ugz_bin_Channel0
.db $FF        ; pitch adjustment
.db $03        ; volume adjustment

music_ugz_bin_Channel1_Header:
.dw music_ugz_bin_Channel1
.db $FF        ; pitch adjustment
.db $03        ; volume adjustment

music_ugz_bin_Channel2_Header:
.dw music_ugz_bin_Channel2
.db $FF        ; pitch adjustment
.db $03        ; volume adjustment

music_ugz_bin_Channel3_Header:
.dw music_ugz_bin_Channel3
.db $00        ; pitch adjustment
.db $00        ; volume adjustment


; ---------------------------------------------------------
music_ugz_bin_Channel0:             ; $0016 / $8FAE
    PitchBend       12, 1, 1, 4
; ---------------------------------------------------------
music_ugz_bin_LABEL_8FB3:           ; $001B / $8FB3
    VolumeEnvelope  8
    C6                              ; $001D
        .db $07                     ; $001E
    B5                              ; $001F
        .db 1                       ; $0020
    A5                              ; $0021
    G5                              ; $0022
    F5                              ; $0023
    E5                              ; $0024
    AdjustVolume    2               ; $0025
    Loop            0, 6, music_ugz_bin_LABEL_8FB3      ; $0027
; ---------------------------------------------------------
    AdjustVolume    -12             ; $002C / $8FC4
    Rest                            ; $002E
        .db 6                       ; $002F
    
    E4                              ; $0030
        .db 1                       ; $0031
    F4                              ; $0032
    G4                              ; $0033
    A4                              ; $0034
    VolumeEnvelope  5               ; $0035
    As4                             ; $0037
        .db 14                      ; $0038
; ---------------------------------------------------------
music_ugz_bin_LABEL_8FD1:
    VolumeEnvelope  8               ; $0039
    C6                              ; $003B
        .db $07                     ; $003C
    B5                              ; $003D
        .db $01                     ; $003E
    A5                              ; $003F
    G5                              ; $0040
    F5                              ; $0041
    E5                              ; $0042
    AdjustVolume    2               ; $0043
    Loop            0, 6, music_ugz_bin_LABEL_8FD1      ; $0045
; ---------------------------------------------------------
    AdjustVolume    -12             ; $004A
    Rest
        .db $06
    B4
        .db $01
    C5
    D5
    Ds5
    VolumeEnvelope  5
    Ds5
        .db $0E     ; 72
    Loop            1, 2, music_ugz_bin_LABEL_8FB3
; ---------------------------------------------------------
music_ugz_bin_LABEL_8FF4:
    C5
        .db $0A
    G5
        .db $01
    A5
    As5
        .db $0C
    A5

    F5
    Ds5
        .db $03
    F5
        .db $06
    G5
    C5
    C5
        .db $0C
    Rest
        .db $03
    As4
    C5
    Ds5
        .db $06
    F5
        .db $09
    Fs5
    G5
        .db $1E
    RepeatLast      $30
; ---------------------------------------------------------
    Rest
        .db $0A

    G5
        .db $01
    A5
    As5
        .db $0C
    A5
    F5
    Ds5
        .db $03
    F5
        .db $06
    G5
    C5
    C5
        .db $0C
    Rest
        .db $03

    As4
    C5
    Ds5
        .db $06
    F5
        .db $09
    Ds5
        .db $30
    RepeatLast      $27
; ---------------------------------------------------------
    Loop            0, 2, music_ugz_bin_LABEL_8FF4
; ---------------------------------------------------------
    Branch          music_ugz_bin_LABEL_90FE
; ---------------------------------------------------------
    Fs5
        .db $01
    G5
        .db $08
    A5
        .db $09
    As5
        .db $06
    As5
        .db $01
    C6
        .db $08
    As5
        .db $09
    C6
        .db $06
    D6
        .db $09
    D6
        .db $01
    Ds6
        .db $08
    D6
        .db $06
    C6
        .db $0C
    As5
        .db $06
    C6
        .db $0C
    G5
    .db $2A
    RepeatLast      $30
; ---------------------------------------------------------
    Branch          music_ugz_bin_LABEL_90FE
; ---------------------------------------------------------
    Fs5
        .db $01
    G5
        .db $08
    A5
        .db $09
    As5
        .db $06
    As5
        .db $01
    C6
        .db $08
    As5
        .db $09
    C6
        .db $06
    D6
        .db $09
    D6
        .db $01
    Ds6
        .db $08
    D6
        .db $06
    B5
        .db $01
    C6
        .db $08
    D6
        .db $09
    Ds6
        .db $06
    F6
        .db $30
    Gs6
        .db $30
; ---------------------------------------------------------
    Branch          music_ugz_bin_LABEL_9090
    Branch          music_ugz_bin_LABEL_90B9
    Branch          music_ugz_bin_LABEL_9090
    Branch          music_ugz_bin_LABEL_90E2
    Jump            music_ugz_bin_LABEL_8FB3
    Stop

; ---------------------------------------------------------
music_ugz_bin_LABEL_9090:
    As5
        .db $01
    C6
        .db $0B
    As5
        .db $06
    G5
        .db $0C
    E6
        .db $01
    F6
        .db $0B
    E6
        .db $0C
    C6
        .db $0C
    Fs5
        .db $01
    G5
        .db $1D
    A5
        .db $01
    As5
        .db $0B
    A5
        .db $06
    F5
        .db $0C
    Gs5
        .db $01
    A5
        .db $0B
    G5
        .db $0C
    C5
        .db $0C
    B4
        .db $01
    C5
        .db $1D
    Return

music_ugz_bin_LABEL_90B9:
    C5
        .db $01
    Cs5
        .db $0B
    F5
        .db $06
    Gs5
        .db $0C
    C6
        .db $01
    Cs6
        .db $0B
    C6
        .db $0C
    G5
        .db $0C
    D5
        .db $01
    Ds5
        .db $1D
    Cs5
        .db $01
    D5
        .db $0B
    F5
        .db $06
    As5
        .db $0C
    Cs6
        .db $01
    D6
        .db $0B
    C6
        .db $0C
    E6
        .db $0C
    F6
        .db $01
    G6
        .db $1D
    Return
    
music_ugz_bin_LABEL_90E2:
    C5
        .db $01
    Cs5
        .db $0B
    F5
        .db $06
    Gs5
        .db $0C
    C6
        .db $01
    Cs6
        .db $0B
    C6
        .db $0C
    G5
        .db $0C
    D5
        .db $01
    Ds5
        .db $0B
    G5
        .db $06
    C6
    Ds6
    E6
        .db $30
    Fs6
    Return
    
music_ugz_bin_LABEL_90FE:
    As5
        .db $03
    AdjustVolume    2
    As5
    AdjustVolume    -2
    Cs6
        .db $03
    AdjustVolume    2
    Cs6
    AdjustVolume    -2
    Ds6
        .db $03
    AdjustVolume    2
    Ds6
    AdjustVolume    -2
    As5
        .db $03
    AdjustVolume    2
    As5
    AdjustVolume    -2
    C6
        .db $01
    Cs6
        .db $08
    Ds6
        .db $03
    AdjustVolume    2
    Ds6
    AdjustVolume    2
    Ds6
    AdjustVolume    -4
    As5
        .db $03
    AdjustVolume    2
    As5
    AdjustVolume    -2
    B5
        .db $01
    C6
        .db $08
    Cs6
        .db $09
    Ds6
        .db $06
    E6
        .db $01
    F6
        .db $08
    Ds6
        .db $09
    Cs6
        .db $06
    B5
        .db $01
    C6
        .db $08
    Cs6
        .db $09
    C6
        .db $06
    As5
        .db $0C
    Gs5
        .db $06
    A5
        .db $01
    As5
        .db $0B
    Ds5
        .db $2A
    Return

music_ugz_bin_Channel2:
    VolumeEnvelope  7
music_ugz_bin_LABEL_9154:
    Branch          music_ugz_bin_LABEL_91BE
    Loop            0, $18, music_ugz_bin_LABEL_9154
    
music_ugz_bin_LABEL_915C:
    Branch          music_ugz_bin_LABEL_91CD
    Loop            0, 4, music_ugz_bin_LABEL_915C
    
music_ugz_bin_LABEL_9164:
    Branch          music_ugz_bin_LABEL_91BE
    Loop            0, 4, music_ugz_bin_LABEL_9164
    
music_ugz_bin_LABEL_916C:
    Branch          music_ugz_bin_LABEL_91CD
    Loop            0, 4, music_ugz_bin_LABEL_916C
    Branch          music_ugz_bin_LABEL_91BE
    Branch          music_ugz_bin_LABEL_91BE
    Branch          music_ugz_bin_LABEL_91DC
    Branch          music_ugz_bin_LABEL_91DC

music_ugz_bin_LABEL_9180:
    Branch          music_ugz_bin_LABEL_91BE
    Loop            0, 4, music_ugz_bin_LABEL_9180
    Branch          music_ugz_bin_LABEL_91EB
    Branch          music_ugz_bin_LABEL_91BE
    Branch          music_ugz_bin_LABEL_91FA
    Branch          music_ugz_bin_LABEL_920A

music_ugz_bin_LABEL_9194:
    Branch          music_ugz_bin_LABEL_91BE
    Loop            0, 4, music_ugz_bin_LABEL_9194
    Branch          music_ugz_bin_LABEL_91EB
    Branch          music_ugz_bin_LABEL_91BE
    
music_ugz_bin_LABEL_91A2:
    E3
        .db $06
    E3
    Gs3
    E3
        .db $03
    B3
        .db $06
    E3
        .db $06
    E3
        .db $03
    Gs3
        .db $06
    B3
    
    PitchAdjust     2
    Loop            0, 2, music_ugz_bin_LABEL_91A2
    
    PitchAdjust     -4

    Jump            music_ugz_bin_LABEL_9154
    Stop
    
music_ugz_bin_LABEL_91BE:
    C3
        .db $06
    C3
    Ds3
    C3
        .db $03
    F3
        .db $06
    C3
        .db $03
    Fs3
        .db $06
    F3
    Ds3
    Return
    
music_ugz_bin_LABEL_91CD:
    Ds3
        .db $06
    Ds3
    Fs3
    Ds3
        .db $03
    Gs3
        .db $06
    Ds3
    Ds3
        .db $03
    A3
        .db $06
    As3
    Return

music_ugz_bin_LABEL_91DC:
    Cs3
        .db $06
    Cs3
    F3
    Cs3
        .db $03
    Gs3
        .db $06
    Cs3
    Cs3
        .db $03
    B3
        .db $06
    Cs4
    Return
    
music_ugz_bin_LABEL_91EB:
    Cs3
        .db $06
    Cs3
    F3
    Cs3
        .db $03
    Gs3
        .db $06
    Cs3
        .db $03
    B3
        .db $06
    As3
    Gs3
    Return

music_ugz_bin_LABEL_91FA:
    D3
        .db $06
    D3
    F3
    D3
        .db $03
    As3
        .db $06
    D3
        .db $06
    D3
        .db $03
    F3
        .db $06
    As3
    Return

music_ugz_bin_LABEL_920A:
    E3
        .db $06
    E3
    G3
    E3
        .db $03
    C4
        .db $06
    E3
        .db $06
    E3
        .db $03
    G3
        .db $06
    C4
    Return


music_ugz_bin_Channel1:
.db $F0
    .db $0D
    .db $01
    .db $01
    .db $04
music_ugz_bin_LABEL_921F:
.db $F5
    .db $06
.db $A0    ; G5
    .db $07
.db $9E    ; F5
    .db $01
.db $9D    ; E5
.db $9B    ; D5
.db $99    ; C5
.db $98    ; B4
.db $E6
    .db $02
.db $F7
    .db $00
    .db $06
    .dw music_ugz_bin_LABEL_921F
.db $E6
    .db $F4
.db $80
    .db $06
.db $8C    ; B3
    .db $01
.db $8D    ; C4
.db $8F    ; D4
.db $91    ; E4
.db $F5
    .db $05
.db $92    ; F4
    .db $0E
music_ugz_bin_LABEL_923D:
.db $F5
    .db $06
.db $A0    ; G5
    .db $07
.db $9E    ; F5
    .db $01
.db $9D    ; E5
.db $9B    ; D5
.db $99    ; C5
.db $98    ; B4
.db $E6
    .db $02
.db $F7
    .db $00
    .db $06
    .dw music_ugz_bin_LABEL_923D
.db $E6
    .db $F4
.db $80
    .db $06
.db $91    ; E4
    .db $01
.db $92    ; F4
.db $94    ; G4
.db $96    ; A4
.db $F5
    .db $05
.db $97    ; As4
    .db $0E
.db $F7
    .db $01
    .db $02
    .dw music_ugz_bin_LABEL_921F
music_ugz_bin_LABEL_9260:
.db $F5
    .db $03
.db $AC    ; G6
    .db $03
.db $E6
    .db $02
.db $AC    ; G6
.db $E6
    .db $FE
.db $A5    ; C6
.db $E6
    .db $02
.db $A5    ; C6
.db $E6
    .db $FE
.db $AE    ; A6
.db $E6
    .db $02
.db $AE    ; A6
.db $E6
    .db $FE
.db $A5    ; C6
.db $AF    ; As6
.db $E6
    .db $02
.db $AF    ; As6
.db $E6
    .db $FE
.db $A5    ; C6
.db $E6
    .db $02
.db $A5    ; C6
.db $E6
    .db $FE
.db $A5    ; C6
.db $B1    ; C7
.db $E6
    .db $02
.db $B1    ; C7
.db $E6
    .db $FE
.db $AF    ; As6
.db $E6
    .db $02
.db $AF    ; As6
.db $E6
    .db $FE
.db $F7
    .db $00
    .db $07
    .dw music_ugz_bin_LABEL_9260
.db $F5
    .db $08
.db $AB    ; Fs6
    .db $01
.db $AC    ; G6
    .db $05
.db $AB    ; Fs6
    .db $03
.db $F5
    .db $03
.db $AA    ; F6
.db $E6
    .db $02
.db $AA    ; F6
.db $E6
    .db $FE
.db $A8    ; Ds6
.db $E6
    .db $02
.db $A8    ; Ds6
.db $E6
    .db $FE
.db $A5    ; C6
.db $E6
    .db $02
.db $A5    ; C6
.db $E6
    .db $FE
.db $A3    ; As5
.db $E6
    .db $02
.db $A3    ; As5
.db $E6
    .db $FE
.db $A0    ; G5
.db $E6
    .db $02
.db $A0    ; G5
.db $E6
    .db $FE
.db $9F    ; Fs5
.db $9E    ; F5
.db $9C    ; Ds5
.db $F7
    .db $01
    .db $02
    .dw music_ugz_bin_LABEL_9260
music_ugz_bin_LABEL_92C4:
.db $F8
    .dw music_ugz_bin_LABEL_947E
.db $F7
    .db $00
    .db $04
    .dw music_ugz_bin_LABEL_92C4
.db $F5
    .db $06
.db $96    ; A4
    .db $01
.db $97    ; As4
    .db $08
.db $99    ; C5
    .db $09
.db $9B    ; D5
    .db $06
.db $9B    ; D5
    .db $01
.db $9C    ; Ds5
    .db $08
.db $9B    ; D5
    .db $09
.db $9C    ; Ds5
    .db $06
.db $9E    ; F5
    .db $09
.db $9E    ; F5
    .db $01
.db $A0    ; G5
    .db $08
.db $9E    ; F5
    .db $06
.db $9C    ; Ds5
    .db $0C
.db $9B    ; D5
    .db $06
.db $9C    ; Ds5
    .db $0C
.db $99    ; C5
    .db $2A
.db $E7
    .db $30
music_ugz_bin_LABEL_92F0:
.db $F8
    .dw music_ugz_bin_LABEL_947E
.db $F7
    .db $00
    .db $04
    .dw music_ugz_bin_LABEL_92F0
.db $F5
    .db $06
.db $96    ; A4
    .db $01
.db $97    ; As4
    .db $08
.db $99    ; C5
    .db $09
.db $9B    ; D5
    .db $06
.db $9B    ; D5
    .db $01
.db $9C    ; Ds5
    .db $08
.db $9B    ; D5
    .db $09
.db $9C    ; Ds5
    .db $06
.db $9E    ; F5
    .db $09
.db $9E    ; F5
    .db $01
.db $A0    ; G5
    .db $08
.db $9E    ; F5
    .db $06
.db $9C    ; Ds5
    .db $09
.db $9E    ; F5
    .db $09
.db $A0    ; G5
    .db $06
.db $A1    ; Gs5
    .db $30
.db $A4    ; B5
.db $F8
    .dw music_ugz_bin_LABEL_932B
.db $F8
    .dw music_ugz_bin_LABEL_9348
.db $F8
    .dw music_ugz_bin_LABEL_932B
.db $F8
    .dw music_ugz_bin_LABEL_93E3
.db $F6
    .dw music_ugz_bin_LABEL_921F
.db $F2
music_ugz_bin_LABEL_932B:
.db $F5
    .db $06
.db $E6
    .db $02
.db $A9    ; E6
    .db $0C
.db $A7    ; D6
    .db $06
.db $A3    ; As5
    .db $0C
.db $AF    ; As6
.db $AC    ; G6
.db $A9    ; E6
.db $A5    ; C6
    .db $1E
.db $A8    ; Ds6
    .db $0C
.db $A7    ; D6
    .db $06
.db $A3    ; As5
    .db $0C
.db $A7    ; D6
.db $A5    ; C6
.db $A0    ; G5
.db $9D    ; E5
    .db $1E
.db $E6
    .db $FE
.db $F9
music_ugz_bin_LABEL_9348:
.db $F5
    .db $03
.db $A6    ; Cs6
    .db $03
.db $A1    ; Gs5
.db $9E    ; F5
.db $9A    ; Cs5
.db $E6
    .db $02
.db $9A    ; Cs5
.db $E6
    .db $FE
.db $9A    ; Cs5
    .db $03
.db $9E    ; F5
.db $A1    ; Gs5
.db $A6    ; Cs6
.db $E6
    .db $02
.db $A6    ; Cs6
.db $E6
    .db $FE
.db $9E    ; F5
.db $E6
    .db $02
.db $9E    ; F5
.db $E6
    .db $FE
.db $A1    ; Gs5
.db $E6
    .db $02
.db $A1    ; Gs5
.db $E6
    .db $FE
.db $A6    ; Cs6
.db $E6
    .db $02
.db $A6    ; Cs6
.db $E6
    .db $FE
.db $A5    ; C6
    .db $03
.db $A0    ; G5
.db $9C    ; Ds5
.db $99    ; C5
.db $E6
    .db $02
.db $99    ; C5
.db $E6
    .db $FE
.db $99    ; C5
    .db $03
.db $9C    ; Ds5
.db $A0    ; G5
.db $A5    ; C6
.db $E6
    .db $02
.db $A5    ; C6
.db $E6
    .db $FE
.db $9C    ; Ds5
.db $E6
    .db $02
.db $9C    ; Ds5
.db $E6
    .db $FE
.db $A0    ; G5
.db $E6
    .db $02
.db $A0    ; G5
.db $E6
    .db $FE
.db $A5    ; C6
.db $E6
    .db $02
.db $A5    ; C6
.db $E6
    .db $FE
.db $A7    ; D6
    .db $03
.db $A3    ; As5
.db $9E    ; F5
.db $9B    ; D5
.db $E6
    .db $02
.db $9B    ; D5
.db $E6
    .db $FE
.db $9B    ; D5
    .db $03
.db $9E    ; F5
.db $A3    ; As5
.db $A7    ; D6
.db $E6
    .db $02
.db $A7    ; D6
.db $E6
    .db $FE
.db $9E    ; F5
.db $E6
    .db $02
.db $9E    ; F5
.db $E6
    .db $FE
.db $A3    ; As5
.db $E6
    .db $02
.db $A3    ; As5
.db $E6
    .db $FE
.db $A7    ; D6
.db $E6
    .db $02
.db $A7    ; D6
.db $E6
    .db $FE
.db $A9    ; E6
    .db $03
.db $A5    ; C6
.db $A0    ; G5
.db $9D    ; E5
.db $E6
    .db $02
.db $9D    ; E5
.db $E6
    .db $FE
.db $9D    ; E5
    .db $03
.db $A0    ; G5
.db $A5    ; C6
.db $A9    ; E6
.db $E6
    .db $02
.db $A9    ; E6
.db $E6
    .db $FE
.db $A0    ; G5
.db $E6
    .db $02
.db $A0    ; G5
.db $E6
    .db $FE
.db $A5    ; C6
.db $E6
    .db $02
.db $A5    ; C6
.db $E6
    .db $FE
.db $A9    ; E6
.db $E6
    .db $02
.db $A9    ; E6
.db $E6
    .db $FE
.db $F9
music_ugz_bin_LABEL_93E3:
.db $F5
    .db $03
.db $A6    ; Cs6
    .db $03
.db $A1    ; Gs5
.db $9E    ; F5
.db $9A    ; Cs5
.db $E6
    .db $02
.db $9A    ; Cs5
.db $E6
    .db $FE
.db $9A    ; Cs5
    .db $03
.db $9E    ; F5
.db $A1    ; Gs5
.db $A6    ; Cs6
.db $E6
    .db $02
.db $A6    ; Cs6
.db $E6
    .db $FE
.db $9E    ; F5
.db $E6
    .db $02
.db $9E    ; F5
.db $E6
    .db $FE
.db $A1    ; Gs5
.db $E6
    .db $02
.db $A1    ; Gs5
.db $E6
    .db $FE
.db $A6    ; Cs6
.db $E6
    .db $02
.db $A6    ; Cs6
.db $E6
    .db $FE
.db $A5    ; C6
    .db $03
.db $A0    ; G5
.db $9C    ; Ds5
.db $99    ; C5
.db $E6
    .db $02
.db $99    ; C5
.db $E6
    .db $FE
.db $99    ; C5
    .db $03
.db $9C    ; Ds5
.db $A0    ; G5
.db $A5    ; C6
.db $E6
    .db $02
.db $A5    ; C6
.db $E6
    .db $FE
.db $9C    ; Ds5
.db $E6
    .db $02
.db $9C    ; Ds5
.db $E6
    .db $FE
.db $A0    ; G5
.db $E6
    .db $02
.db $A0    ; G5
.db $E6
    .db $FE
.db $A5    ; C6
.db $E6
    .db $02
.db $A5    ; C6
.db $E6
    .db $FE
.db $A9    ; E6
    .db $03
.db $A4    ; B5
.db $A1    ; Gs5
.db $9D    ; E5
.db $E6
    .db $02
.db $9D    ; E5
.db $E6
    .db $FE
.db $9D    ; E5
    .db $03
.db $A1    ; Gs5
.db $A4    ; B5
.db $A9    ; E6
.db $E6
    .db $02
.db $A9    ; E6
.db $E6
    .db $FE
.db $A1    ; Gs5
.db $E6
    .db $02
.db $A1    ; Gs5
.db $E6
    .db $FE
.db $A4    ; B5
.db $E6
    .db $02
.db $A4    ; B5
.db $E6
    .db $FE
.db $A9    ; E6
.db $E6
    .db $02
.db $A9    ; E6
.db $E6
    .db $FE
.db $AB    ; Fs6
    .db $03
.db $A6    ; Cs6
.db $A3    ; As5
.db $9F    ; Fs5
.db $E6
    .db $02
.db $9F    ; Fs5
.db $E6
    .db $FE
.db $9F    ; Fs5
    .db $03
.db $A3    ; As5
.db $A6    ; Cs6
.db $AB    ; Fs6
.db $E6
    .db $02
.db $AB    ; Fs6
.db $E6
    .db $FE
.db $A3    ; As5
.db $E6
    .db $02
.db $A3    ; As5
.db $E6
    .db $FE
.db $A6    ; Cs6
.db $E6
    .db $02
.db $A6    ; Cs6
.db $E6
    .db $FE
.db $AB    ; Fs6
.db $E6
    .db $02
.db $AB    ; Fs6
.db $E6
    .db $FE
.db $F9
music_ugz_bin_LABEL_947E:
.db $E6
    .db $02
.db $F5
    .db $08
.db $97    ; As4
    .db $06
.db $97    ; As4
.db $9A    ; Cs5
.db $97    ; As4
    .db $03
.db $9C    ; Ds5
    .db $06
.db $97    ; As4
    .db $03
.db $E8
    .db $00
.db $9A    ; Cs5
    .db $12
.db $E6
    .db $FE
.db $F9

music_ugz_bin_Channel3:
music_ugz_bin_LABEL_9493:
.db $84    ; Ds3
    .db $03
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $84    ; Ds3
.db $88    ; G3
.db $81    ; C3
.db $88    ; G3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $84    ; Ds3
.db $88    ; G3
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
    .dw music_ugz_bin_LABEL_9493
.db $84    ; Ds3
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $84    ; Ds3
.db $88    ; G3
.db $81    ; C3
.db $88    ; G3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $84    ; Ds3
.db $88    ; G3
.db $81    ; C3
.db $88    ; G3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $F6
    .dw music_ugz_bin_LABEL_9493
.db $F2


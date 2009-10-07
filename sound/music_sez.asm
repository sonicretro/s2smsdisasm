music_sez_bin:
.dw $8A2F
.db $04        ;num channels
.db $00
.db $02
.db $00

music_sez_bin_Channel0_Header:
.dw music_sez_bin_Channel0
.db $D2        ; pitch adjustment
.db $04        ; volume adjustment

music_sez_bin_Channel1_Header:
.dw music_sez_bin_Channel1
.db $D2        ; pitch adjustment
.db $07        ; volume adjustment

music_sez_bin_Channel2_Header:
.dw music_sez_bin_Channel2
.db $D2        ; pitch adjustment
.db $03        ; volume adjustment

music_sez_bin_Channel3_Header:
.dw music_sez_bin_Channel3
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

music_sez_bin_Channel0:
.db $F5
    .db $08
music_sez_bin_LABEL_A2E6:
.db $F8
    .dw music_sez_bin_LABEL_A44C
.db $F7
    .db $00
    .db $03
    .dw music_sez_bin_LABEL_A2E6
.db $CD    ; 
    .db $03
.db $CC    ; 
.db $C9    ; 
.db $CB    ; 
.db $C6    ; A8
.db $CB    ; 
.db $C9    ; 
.db $C4    ; G8
.db $F7
    .db $01
    .db $04
    .dw music_sez_bin_LABEL_A2E6
music_sez_bin_LABEL_A2FC:
.db $E6
    .db $05
.db $F5
    .db $0A
music_sez_bin_LABEL_A300:
.db $D5    ; 
    .db $03
.db $D0    ; 
.db $D5    ; 
.db $D4    ; 
.db $E6
    .db $FF
.db $D5    ; 
.db $D0    ; 
.db $D5    ; 
.db $D4    ; 
.db $E6
    .db $FF
.db $D5    ; 
.db $D0    ; 
.db $D5    ; 
.db $D4    ; 
.db $E6
    .db $FF
.db $D5    ; 
.db $D0    ; 
.db $D5    ; 
.db $D4    ; 
.db $E6
    .db $FF
.db $D5    ; 
.db $D0    ; 
.db $D5    ; 
.db $D4    ; 
.db $E6
    .db $FF
.db $D5    ; 
.db $D0    ; 
.db $D5    ; 
.db $D4    ; 
.db $E6
    .db $FF
.db $D5    ; 
.db $D0    ; 
.db $D5    ; 
.db $D4    ; 
.db $E6
    .db $FF
.db $D5    ; 
.db $D0    ; 
.db $D5    ; 
.db $D4    ; 
.db $E6
    .db $07
.db $D5    ; 
.db $D0    ; 
.db $CD    ; 
.db $D4    ; 
.db $E6
    .db $FF
.db $D5    ; 
.db $CF    ; 
.db $CD    ; 
.db $D4    ; 
.db $E6
    .db $FF
.db $D5    ; 
.db $CF    ; 
.db $CD    ; 
.db $D4    ; 
.db $E6
    .db $FF
.db $D5    ; 
.db $CF    ; 
.db $CD    ; 
.db $D4    ; 
.db $E6
    .db $FF
.db $D5    ; 
.db $CF    ; 
.db $CD    ; 
.db $D4    ; 
.db $E6
    .db $FF
.db $D5    ; 
.db $CF    ; 
.db $CD    ; 
.db $D4    ; 
.db $E6
    .db $FF
.db $D5    ; 
.db $CF    ; 
.db $CD    ; 
.db $D4    ; 
.db $E6
    .db $FF
.db $D5    ; 
.db $CF    ; 
.db $CD    ; 
.db $D4    ; 
.db $E6
    .db $07
.db $F7
    .db $00
    .db $02
    .dw music_sez_bin_LABEL_A300
.db $F5
    .db $08
.db $E6
    .db $FB
.db $F0
    .db $06
    .db $01
    .db $01
    .db $04
music_sez_bin_LABEL_A36F:
.db $D2    ; 
    .db $06
.db $D0    ; 
    .db $02
.db $D2    ; 
.db $D0    ; 
.db $CF    ; 
    .db $03
.db $CD    ; 
.db $CC    ; 
.db $CF    ; 
.db $CD    ; 
.db $C9    ; 
.db $CB    ; 
.db $C8    ; 
.db $C5    ; Gs8
.db $C8    ; 
.db $C6    ; A8
.db $C1    ; E8
.db $C6    ; A8
.db $C8    ; 
.db $C9    ; 
.db $CB    ; 
.db $E7
    .db $06
.db $C9    ; 
    .db $03
.db $80
.db $CB    ; 
.db $80
.db $C9    ; 
.db $C8    ; 
.db $C6    ; A8
.db $C8    ; 
.db $C9    ; 
.db $C4    ; G8
.db $C1    ; E8
.db $C2    ; F8
.db $C4    ; G8
.db $C6    ; A8
.db $C8    ; 
.db $C9    ; 
.db $CA    ; 
.db $CB    ; 
.db $C9    ; 
.db $CB    ; 
.db $CC    ; 
.db $CD    ; 
.db $CB    ; 
.db $80
.db $C9    ; 
.db $CB    ; 
.db $CD    ; 
    .db $06
.db $CE    ; 
    .db $03
.db $80
.db $CD    ; 
.db $CC    ; 
.db $CB    ; 
.db $C9    ; 
.db $CB    ; 
.db $C9    ; 
.db $C8    ; 
.db $C5    ; Gs8
.db $C6    ; A8
.db $C9    ; 
.db $C6    ; A8
    .db $06
.db $F7
    .db $00
    .db $02
    .dw music_sez_bin_LABEL_A36F
.db $F0
    .db $00
    .db $00
    .db $00
    .db $00
.db $F5
    .db $15
.db $BD    ; C8
    .db $03
    .db $03
.db $BC    ; B7
.db $BD    ; C8
.db $80
.db $BD    ; C8
.db $BC    ; B7
.db $BD    ; C8
.db $80
.db $BD    ; C8
.db $BC    ; B7
.db $BD    ; C8
.db $80
.db $BD    ; C8
.db $BC    ; B7
.db $BD    ; C8
.db $C1    ; E8
    .db $09
    .db $03
.db $80
    .db $24
.db $C2    ; F8
    .db $03
    .db $03
.db $C1    ; E8
.db $C2    ; F8
.db $80
.db $C2    ; F8
.db $C1    ; E8
.db $C2    ; F8
.db $80
.db $C2    ; F8
.db $C1    ; E8
.db $C2    ; F8
.db $80
.db $C2    ; F8
.db $C1    ; E8
.db $C2    ; F8
.db $BC    ; B7
    .db $09
    .db $03
.db $80
    .db $0F
.db $D2    ; 
    .db $03
.db $D1    ; 
.db $CE    ; 
.db $D7    ; 
.db $D4    ; 
.db $D1    ; 
.db $D9    ; 
.db $F5
    .db $08
.db $FB
    .db $0C
.db $F0
    .db $06
    .db $01
    .db $01
    .db $04
music_sez_bin_LABEL_A3FD:
.db $F8
    .dw music_sez_bin_LABEL_A466
.db $F7
    .db $00
    .db $04
    .dw music_sez_bin_LABEL_A3FD
.db $C4    ; G8
    .db $03
.db $C1    ; E8
.db $E7
    .db $06
.db $E7
    .db $24
.db $FB
    .db $F4
.db $F0
    .db $00
    .db $00
    .db $00
    .db $00
.db $E6
    .db $02
.db $F5
    .db $15
.db $80
    .db $03
.db $F8
    .dw music_sez_bin_LABEL_A4C0
.db $F8
    .dw music_sez_bin_LABEL_A4C0
.db $AE    ; A6
    .db $03
    .db $03
    .db $03
    .db $03
.db $B1    ; C7
.db $AE    ; A6
.db $AE    ; A6
.db $B3    ; D7
.db $AE    ; A6
.db $AE    ; A6
.db $B4    ; Ds7
.db $AE    ; A6
.db $AE    ; A6
.db $AE    ; A6
.db $B5    ; E7
.db $E6
    .db $FE
.db $F5
    .db $08
music_sez_bin_LABEL_A433:
.db $F8
    .dw music_sez_bin_LABEL_A44C
.db $F7
    .db $00
    .db $03
    .dw music_sez_bin_LABEL_A433
.db $CD    ; 
    .db $03
.db $CC    ; 
.db $C9    ; 
.db $CB    ; 
.db $C6    ; A8
.db $CB    ; 
.db $C9    ; 
.db $C4    ; G8
.db $F7
    .db $01
    .db $02
    .dw music_sez_bin_LABEL_A433
.db $F6
    .dw music_sez_bin_LABEL_A2FC
music_sez_bin_LABEL_A44C:
.db $E6
    .db $03
.db $C6    ; A8
    .db $03
.db $E6
    .db $FD
.db $C9    ; 
.db $E6
    .db $03
.db $C6    ; A8
.db $E6
    .db $FD
.db $CB    ; 
.db $E6
    .db $03
.db $C6    ; A8
.db $E6
    .db $FD
.db $CC    ; 
.db $E6
    .db $03
.db $C6    ; A8
.db $E6
    .db $FD
.db $CD    ; 
.db $F9
music_sez_bin_LABEL_A466:
.db $CB    ; 
    .db $09
.db $C9    ; 
    .db $03
.db $80
    .db $06
.db $CB    ; 
    .db $09
.db $C9    ; 
    .db $03
.db $80
    .db $06
.db $CB    ; 
    .db $03
    .db $03
.db $C9    ; 
.db $80
.db $CB    ; 
    .db $09
.db $C9    ; 
    .db $03
.db $80
    .db $06
.db $CB    ; 
.db $E7
    .db $06
.db $CD    ; 
    .db $03
    .db $03
.db $CB    ; 
.db $CB    ; 
.db $C9    ; 
    .db $06
.db $F9

music_sez_bin_Channel2:
.db $F5
    .db $15
.db $80
    .db $30
.db $80
.db $80
.db $AE    ; A6
    .db $03
.db $B5    ; E7
.db $B8    ; G7
.db $BA    ; A7
.db $80
.db $B5    ; E7
.db $80
.db $BA    ; A7
.db $80
.db $B5    ; E7
.db $80
.db $BA    ; A7
.db $B5    ; E7
.db $B4    ; Ds7
.db $B3    ; D7
.db $B1    ; C7
music_sez_bin_LABEL_A49F:
.db $F8
    .dw music_sez_bin_LABEL_A4C0
.db $F7
    .db $00
    .db $14
    .dw music_sez_bin_LABEL_A49F
.db $F8
    .dw music_sez_bin_LABEL_A4D2
music_sez_bin_LABEL_A4AA:
.db $F8
    .dw music_sez_bin_LABEL_A4C0
.db $F8
    .dw music_sez_bin_LABEL_A507
.db $F7
    .db $00
    .db $04
    .dw music_sez_bin_LABEL_A4AA
music_sez_bin_LABEL_A4B5:
.db $F8
    .dw music_sez_bin_LABEL_A4C0
.db $F7
    .db $00
    .db $04
    .dw music_sez_bin_LABEL_A4B5
.db $F6
    .dw music_sez_bin_LABEL_A49F
music_sez_bin_LABEL_A4C0:
.db $AE    ; A6
    .db $03
    .db $03
    .db $03
    .db $03
.db $B1    ; C7
.db $AE    ; A6
.db $AE    ; A6
.db $B3    ; D7
.db $AE    ; A6
.db $AE    ; A6
.db $B4    ; Ds7
.db $AE    ; A6
.db $AE    ; A6
.db $AE    ; A6
.db $B5    ; E7
.db $AE    ; A6
.db $F9
music_sez_bin_LABEL_A4D2:
.db $AE    ; A6
    .db $03
    .db $03
.db $AE    ; A6
.db $AE    ; A6
.db $80
.db $AE    ; A6
.db $AE    ; A6
.db $AE    ; A6
.db $80
.db $AE    ; A6
.db $AE    ; A6
.db $AE    ; A6
.db $80
.db $AE    ; A6
.db $AE    ; A6
.db $AE    ; A6
.db $B1    ; C7
    .db $09
    .db $03
.db $80
    .db $24
.db $B3    ; D7
    .db $03
    .db $03
.db $B1    ; C7
.db $B3    ; D7
.db $80
.db $B3    ; D7
.db $B1    ; C7
.db $B3    ; D7
.db $80
.db $B3    ; D7
.db $B1    ; C7
.db $B3    ; D7
.db $80
.db $B3    ; D7
.db $B1    ; C7
.db $B3    ; D7
.db $B5    ; E7
    .db $09
    .db $03
.db $80
    .db $0F
.db $BA    ; A7
    .db $03
.db $B9    ; Gs7
.db $B3    ; D7
.db $B5    ; E7
.db $B9    ; Gs7
.db $B0    ; B6
.db $B3    ; D7
.db $F9
music_sez_bin_LABEL_A507:
.db $B1    ; C7
    .db $03
    .db $03
    .db $03
    .db $03
.db $B8    ; G7
.db $B1    ; C7
.db $B1    ; C7
.db $B1    ; C7
.db $B1    ; C7
.db $B6    ; F7
.db $B1    ; C7
.db $B1    ; C7
.db $B1    ; C7
.db $B5    ; E7
.db $B1    ; C7
.db $B1    ; C7
.db $F9

music_sez_bin_Channel1:
.db $F5
    .db $08
.db $80
    .db $09
music_sez_bin_LABEL_A51D:
.db $F8
    .dw music_sez_bin_LABEL_A6D8
.db $F7
    .db $00
    .db $03
    .dw music_sez_bin_LABEL_A51D
.db $CD    ; 
    .db $03
.db $CC    ; 
.db $C9    ; 
.db $CB    ; 
.db $C6    ; A8
.db $CB    ; 
.db $C9    ; 
.db $C4    ; G8
.db $F7
    .db $01
    .db $03
    .dw music_sez_bin_LABEL_A51D
music_sez_bin_LABEL_A533:
.db $F8
    .dw music_sez_bin_LABEL_A6D8
.db $F7
    .db $00
    .db $03
    .dw music_sez_bin_LABEL_A533
.db $CD    ; 
    .db $03
.db $CC    ; 
.db $C9    ; 
.db $CB    ; 
.db $C6    ; A8
music_sez_bin_LABEL_A541:
.db $F5
    .db $0A
.db $E6
    .db $02
music_sez_bin_LABEL_A545:
.db $C6    ; A8
    .db $03
.db $C8    ; 
.db $C9    ; 
.db $CD    ; 
.db $E6
    .db $FF
.db $D0    ; 
.db $C8    ; 
.db $C9    ; 
.db $CD    ; 
.db $E6
    .db $FF
.db $D0    ; 
.db $C8    ; 
.db $C9    ; 
.db $CD    ; 
.db $E6
    .db $FF
.db $D0    ; 
.db $C8    ; 
.db $C9    ; 
.db $CD    ; 
.db $E6
    .db $FF
.db $D0    ; 
.db $C8    ; 
.db $C9    ; 
.db $CD    ; 
.db $E6
    .db $FF
.db $D0    ; 
.db $C8    ; 
.db $C9    ; 
.db $CD    ; 
.db $E6
    .db $FF
.db $D0    ; 
.db $C8    ; 
.db $C9    ; 
.db $CD    ; 
.db $E6
    .db $FF
.db $D0    ; 
.db $C8    ; 
.db $C9    ; 
.db $CD    ; 
.db $E6
    .db $07
.db $C3    ; Fs8
.db $C6    ; A8
.db $C9    ; 
.db $CD    ; 
.db $E6
    .db $FF
.db $CF    ; 
.db $C6    ; A8
.db $C9    ; 
.db $CD    ; 
.db $E6
    .db $FF
.db $CF    ; 
.db $C6    ; A8
.db $C9    ; 
.db $CD    ; 
.db $E6
    .db $FF
.db $CF    ; 
.db $C6    ; A8
.db $C9    ; 
.db $CD    ; 
.db $E6
    .db $FF
.db $CF    ; 
.db $C6    ; A8
.db $C9    ; 
.db $CD    ; 
.db $E6
    .db $FF
.db $CF    ; 
.db $C6    ; A8
.db $C9    ; 
.db $CD    ; 
.db $E6
    .db $FF
.db $CF    ; 
.db $C6    ; A8
.db $C9    ; 
.db $CD    ; 
.db $E6
    .db $FF
.db $CF    ; 
.db $C6    ; A8
.db $C9    ; 
.db $CD    ; 
    .db $03
.db $E6
    .db $07
.db $F7
    .db $00
    .db $02
    .dw music_sez_bin_LABEL_A545
.db $E6
    .db $FD
.db $F5
    .db $08
.db $80
    .db $03
.db $D2    ; 
    .db $06
.db $D0    ; 
    .db $02
.db $D2    ; 
.db $D0    ; 
.db $CF    ; 
    .db $03
.db $CD    ; 
.db $CC    ; 
.db $CF    ; 
.db $CD    ; 
.db $C9    ; 
.db $CB    ; 
.db $C8    ; 
.db $C5    ; Gs8
.db $C8    ; 
.db $C6    ; A8
.db $C1    ; E8
.db $C6    ; A8
.db $C8    ; 
.db $C9    ; 
.db $CB    ; 
.db $E7
    .db $06
.db $C9    ; 
    .db $03
.db $80
.db $CB    ; 
.db $80
.db $C9    ; 
.db $C8    ; 
.db $C6    ; A8
.db $C8    ; 
.db $C9    ; 
.db $C4    ; G8
.db $C1    ; E8
.db $C2    ; F8
.db $C4    ; G8
.db $C6    ; A8
.db $C8    ; 
.db $C9    ; 
.db $CA    ; 
.db $CB    ; 
.db $C9    ; 
.db $CB    ; 
.db $CC    ; 
.db $CD    ; 
.db $CB    ; 
.db $80
.db $C9    ; 
.db $CB    ; 
.db $CD    ; 
    .db $06
.db $CE    ; 
    .db $03
.db $80
.db $CD    ; 
.db $CC    ; 
.db $CB    ; 
.db $C9    ; 
.db $CB    ; 
.db $C9    ; 
.db $C8    ; 
.db $C5    ; Gs8
.db $C6    ; A8
.db $C9    ; 
.db $C6    ; A8
    .db $03
.db $FB
    .db $F4
.db $D5    ; 
    .db $06
.db $D4    ; 
    .db $02
.db $D5    ; 
.db $D4    ; 
.db $D2    ; 
    .db $03
.db $D0    ; 
.db $CF    ; 
.db $D2    ; 
.db $D0    ; 
.db $CD    ; 
.db $CF    ; 
.db $CB    ; 
.db $C8    ; 
.db $CB    ; 
.db $C9    ; 
.db $C5    ; Gs8
.db $C9    ; 
.db $CB    ; 
.db $CD    ; 
.db $CE    ; 
.db $E7
    .db $06
.db $CD    ; 
    .db $03
.db $80
.db $CE    ; 
.db $80
.db $CD    ; 
.db $CB    ; 
.db $C9    ; 
.db $CB    ; 
.db $CD    ; 
.db $C8    ; 
.db $C5    ; Gs8
.db $C6    ; A8
.db $C8    ; 
.db $C9    ; 
.db $CB    ; 
.db $CC    ; 
.db $CD    ; 
.db $CE    ; 
.db $CD    ; 
.db $CE    ; 
.db $CF    ; 
.db $D0    ; 
.db $CE    ; 
.db $80
.db $CD    ; 
.db $CE    ; 
.db $D0    ; 
    .db $06
.db $D2    ; 
    .db $03
.db $80
.db $D0    ; 
.db $CF    ; 
.db $CE    ; 
.db $CC    ; 
.db $CE    ; 
.db $CC    ; 
.db $CB    ; 
.db $C8    ; 
.db $C9    ; 
.db $CC    ; 
.db $C9    ; 
    .db $06
.db $FB
    .db $0C
.db $F5
    .db $15
.db $E6
    .db $FE
.db $C1    ; E8
    .db $03
    .db $03
.db $BF    ; D8
.db $C1    ; E8
.db $80
.db $C1    ; E8
.db $BF    ; D8
.db $C1    ; E8
.db $80
.db $C1    ; E8
.db $BF    ; D8
.db $C1    ; E8
.db $80
.db $C1    ; E8
.db $BF    ; D8
.db $C1    ; E8
.db $C4    ; G8
    .db $09
    .db $03
.db $80
    .db $24
.db $C6    ; A8
    .db $03
    .db $03
.db $C5    ; Gs8
.db $C6    ; A8
.db $80
.db $C6    ; A8
.db $C5    ; Gs8
.db $C6    ; A8
.db $80
.db $C6    ; A8
.db $C5    ; Gs8
.db $C6    ; A8
.db $80
.db $C6    ; A8
.db $C5    ; Gs8
.db $C6    ; A8
.db $BF    ; D8
    .db $09
    .db $03
.db $80
    .db $0F
.db $CE    ; 
    .db $03
.db $CD    ; 
.db $CB    ; 
.db $D4    ; 
.db $D1    ; 
.db $CE    ; 
.db $D4    ; 
.db $F5
    .db $08
.db $FB
    .db $0C
.db $E6
    .db $02
.db $F0
    .db $06
    .db $01
    .db $01
    .db $04
music_sez_bin_LABEL_A683:
.db $F8
    .dw music_sez_bin_LABEL_A6F2
.db $F7
    .db $00
    .db $04
    .dw music_sez_bin_LABEL_A683
.db $C9    ; 
    .db $03
.db $C6    ; A8
.db $E7
    .db $06
.db $E7
    .db $24
.db $FB
    .db $F4
.db $E6
    .db $FE
.db $E6
    .db $04
.db $F5
    .db $15
.db $80
    .db $06
.db $80
    .db $30
.db $F8
    .dw music_sez_bin_LABEL_A4C0
.db $AE    ; A6
    .db $03
    .db $03
    .db $03
    .db $03
.db $B1    ; C7
.db $AE    ; A6
.db $AE    ; A6
.db $B3    ; D7
.db $AE    ; A6
.db $AE    ; A6
.db $B4    ; Ds7
.db $AE    ; A6
.db $AE    ; A6
.db $AE    ; A6
.db $E6
    .db $FF
.db $F5
    .db $08
.db $80
    .db $09
music_sez_bin_LABEL_A6B6:
.db $F8
    .dw music_sez_bin_LABEL_A6D8
.db $F7
    .db $00
    .db $03
    .dw music_sez_bin_LABEL_A6B6
.db $CD    ; 
    .db $03
.db $CC    ; 
.db $C9    ; 
.db $CB    ; 
.db $C6    ; A8
.db $CB    ; 
.db $C9    ; 
.db $C4    ; G8
music_sez_bin_LABEL_A6C7:
.db $F8
    .dw music_sez_bin_LABEL_A6D8
.db $F7
    .db $00
    .db $03
    .dw music_sez_bin_LABEL_A6C7
.db $CD    ; 
    .db $03
.db $CC    ; 
.db $C9    ; 
.db $CB    ; 
.db $C6    ; A8
.db $F6
    .dw music_sez_bin_LABEL_A541
music_sez_bin_LABEL_A6D8:
.db $E6
    .db $03
.db $C6    ; A8
    .db $03
.db $E6
    .db $FD
.db $C9    ; 
.db $E6
    .db $03
.db $C6    ; A8
.db $E6
    .db $FD
.db $CB    ; 
.db $E6
    .db $03
.db $C6    ; A8
.db $E6
    .db $FD
.db $CC    ; 
.db $E6
    .db $03
.db $C6    ; A8
.db $E6
    .db $FD
.db $CD    ; 
.db $F9
music_sez_bin_LABEL_A6F2:
.db $C6    ; A8
    .db $03
.db $BA    ; A7
.db $BD    ; C8
.db $C4    ; G8
.db $BA    ; A7
.db $BD    ; C8
.db $C6    ; A8
.db $BA    ; A7
.db $BD    ; C8
.db $C4    ; G8
.db $BA    ; A7
.db $BD    ; C8
.db $C6    ; A8
.db $BA    ; A7
.db $C4    ; G8
.db $BA    ; A7
.db $C6    ; A8
.db $BD    ; C8
.db $C1    ; E8
.db $C4    ; G8
.db $BD    ; C8
.db $C1    ; E8
.db $C6    ; A8
.db $BD    ; C8
.db $C6    ; A8
.db $BD    ; C8
.db $C9    ; 
.db $BD    ; C8
.db $C6    ; A8
.db $BD    ; C8
.db $C4    ; G8
.db $BD    ; C8
.db $F9

music_sez_bin_Channel3:
music_sez_bin_LABEL_A714:
.db $80
    .db $30
.db $80
.db $80
.db $88    ; G3
    .db $03
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $80
.db $84    ; Ds3
.db $80
.db $84    ; Ds3
.db $80
.db $88    ; G3
.db $80
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
music_sez_bin_LABEL_A729:
.db $F8
    .dw music_sez_bin_LABEL_A781
.db $F7
    .db $00
    .db $05
    .dw music_sez_bin_LABEL_A729
.db $88    ; G3
    .db $03
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $80
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $80
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $80
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $84    ; Ds3
.db $81    ; C3
.db $81    ; C3
.db $84    ; Ds3
.db $80
    .db $06
.db $81    ; C3
    .db $03
    .db $03
.db $88    ; G3
    .db $03
    .db $03
    .db $03
    .db $03
    .db $03
.db $A0    ; G5
    .db $06
.db $80
    .db $03
.db $88    ; G3
    .db $03
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $80
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $80
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $80
.db $88    ; G3
.db $88    ; G3
.db $84    ; Ds3
.db $84    ; Ds3
.db $81    ; C3
.db $81    ; C3
.db $84    ; Ds3
.db $80
    .db $06
.db $80
    .db $09
.db $88    ; G3
    .db $03
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
music_sez_bin_LABEL_A776:
.db $F8
    .dw music_sez_bin_LABEL_A781
.db $F7
    .db $00
    .db $02
    .dw music_sez_bin_LABEL_A776
.db $F6
    .dw music_sez_bin_LABEL_A714
music_sez_bin_LABEL_A781:
.db $84    ; Ds3
    .db $03
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $84    ; Ds3
.db $84    ; Ds3
.db $88    ; G3
.db $81    ; C3
.db $84    ; Ds3
.db $84    ; Ds3
.db $88    ; G3
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $84    ; Ds3
    .db $03
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $84    ; Ds3
.db $84    ; Ds3
.db $88    ; G3
.db $81    ; C3
.db $84    ; Ds3
.db $84    ; Ds3
.db $88    ; G3
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $88    ; G3
.db $84    ; Ds3
    .db $03
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $84    ; Ds3
.db $84    ; Ds3
.db $88    ; G3
.db $81    ; C3
.db $84    ; Ds3
.db $84    ; Ds3
.db $88    ; G3
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $84    ; Ds3
    .db $03
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $84    ; Ds3
.db $84    ; Ds3
.db $88    ; G3
.db $81    ; C3
.db $84    ; Ds3
.db $84    ; Ds3
.db $88    ; G3
.db $81    ; C3
.db $84    ; Ds3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $F9


sfx_04_bin:
.dw $8A2F
.db $01        ;num channels
.db $01
.db $80
.db $A0

sfx_04_bin_Channel0_Header:
.dw sfx_04_bin_Channel0
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

sfx_04_bin_Channel0:
sfx_04_bin_LABEL_BB76:
.db $F0
    .db $01
    .db $01
    .db $50
    .db $01
.db $F5
    .db $07
.db $85    ; E3
    .db $04
.db $99    ; C5
    .db $06
.db $E6
    .db $03
.db $F7
    .db $00
    .db $03
    .dw sfx_04_bin_LABEL_BB76
.db $F2


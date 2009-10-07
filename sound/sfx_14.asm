sfx_14_bin:
.dw $8A2F
.db $01        ;num channels
.db $01
.db $80
.db $A0

sfx_14_bin_Channel0_Header:
.dw sfx_14_bin_Channel0
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

sfx_14_bin_Channel0:
.db $E0
    .db $10
    .db $01
    .db $FF
    .db $00
    .db $00
.db $F0
    .db $06
    .db $06
    .db $FF
    .db $01
.db $A6    ; Cs6
    .db $7F
.db $E7
    .db $7F
.db $F2


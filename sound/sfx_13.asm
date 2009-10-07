sfx_13_bin:
.dw $8A2F
.db $01        ;num channels
.db $01
.db $80
.db $E0

sfx_13_bin_Channel0_Header:
.dw sfx_13_bin_Channel0
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

sfx_13_bin_Channel0:
.db $F3
    .db $E7
.db $A0    ; G5
    .db $08
.db $E0
    .db $FF
    .db $03
    .db $FF
    .db $82
    .db $82
.db $C0    ; Ds8
    .db $60
.db $F2


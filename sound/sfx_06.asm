sfx_06_bin:
.dw $8A2F
.db $01        ;num channels
.db $01
.db $80
.db $A0

sfx_06_bin_Channel0_Header:
.dw sfx_06_bin_Channel0
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

sfx_06_bin_Channel0:
.db $E0
    .db $0A
    .db $05
    .db $FF
    .db $00
    .db $00
.db $F0
    .db $01
    .db $01
    .db $04
    .db $01
.db $C4    ; G8
    .db $40
.db $F2


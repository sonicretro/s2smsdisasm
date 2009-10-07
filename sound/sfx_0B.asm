sfx_0B_bin:
.dw $8A2F
.db $01        ;num channels
.db $01
.db $80
.db $E0

sfx_0B_bin_Channel0_Header:
.dw sfx_0B_bin_Channel0
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

sfx_0B_bin_Channel0:
.db $F3
    .db $E7
.db $F5
    .db $03
.db $F0
    .db $01
    .db $01
    .db $F9
    .db $01
.db $A2    ; A5
    .db $07
.db $F0
    .db $00
    .db $00
    .db $00
    .db $00
.db $E0
    .db $7F
    .db $04
    .db $FF
    .db $00
    .db $00
.db $C4    ; G8
    .db $3C
.db $F2


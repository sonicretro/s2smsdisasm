sfx_15_bin:
.dw $8A2F
.db $01        ;num channels
.db $01
.db $80
.db $E0

sfx_15_bin_Channel0_Header:
.dw sfx_15_bin_Channel0
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

sfx_15_bin_Channel0:
.db $F3
    .db $E7
.db $F5
    .db $03
sfx_15_bin_LABEL_BD7B:
.db $A0    ; G5
    .db $03
.db $B0    ; B6
.db $F7
    .db $00
    .db $03
    .dw sfx_15_bin_LABEL_BD7B
sfx_15_bin_LABEL_BD83:
.db $A0    ; G5
.db $B0    ; B6
.db $E6
    .db $02
.db $F7
    .db $00
    .db $05
    .dw sfx_15_bin_LABEL_BD83
.db $F2


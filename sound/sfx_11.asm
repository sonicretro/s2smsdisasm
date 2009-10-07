sfx_11_bin:
.dw $8A2F
.db $01        ;num channels
.db $01
.db $80
.db $A0

sfx_11_bin_Channel0_Header:
.dw sfx_11_bin_Channel0
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

sfx_11_bin_Channel0:
.db $F0
    .db $02
    .db $01
    .db $31
    .db $01
.db $F5
    .db $05
.db $8C    ; B3
    .db $1B
.db $F2


sfx_08_bin:
.dw $8A2F
.db $01        ;num channels
.db $01
.db $80
.db $A0

sfx_08_bin_Channel0_Header:
.dw sfx_08_bin_Channel0
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

sfx_08_bin_Channel0:
.db $F5
    .db $03
.db $AC    ; G6
    .db $02
.db $9D    ; E5
.db $80
    .db $01
.db $F2


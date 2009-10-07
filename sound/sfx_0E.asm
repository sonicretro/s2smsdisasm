sfx_0E_bin:
.dw $8A2F
.db $01        ;num channels
.db $01
.db $80
.db $A0

sfx_0E_bin_Channel0_Header:
.dw sfx_0E_bin_Channel0
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

sfx_0E_bin_Channel0:
sfx_0E_bin_LABEL_BCC9:
.db $F0
    .db $01
    .db $01
    .db $50
    .db $01
.db $F5
    .db $07
.db $90    ; Ds4
    .db $05
.db $82    ; Cs3
    .db $02
.db $E6
    .db $03
.db $F7
    .db $00
    .db $03
    .dw sfx_0E_bin_LABEL_BCC9
.db $F2


sfx_0A_bin:
.dw $8A2F
.db $01        ;num channels
.db $01
.db $80
.db $A0

sfx_0A_bin_Channel0_Header:
.dw sfx_0A_bin_Channel0
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

sfx_0A_bin_Channel0:
sfx_0A_bin_LABEL_BC15:
.db $F5
    .db $07
.db $F0
    .db $01
    .db $01
    .db $B3
    .db $01
.db $8D    ; C4
    .db $03
.db $80
    .db $05
.db $F5
    .db $03
.db $F0
    .db $01
    .db $01
    .db $F4
    .db $01
.db $9E    ; F5
    .db $04
.db $80
    .db $02
.db $E6
    .db $05
.db $F7
    .db $00
    .db $02
    .dw sfx_0A_bin_LABEL_BC15
.db $F2


sfx_07_bin:
.dw $8A2F
.db $01        ;num channels
.db $01
.db $80
.db $A0

sfx_07_bin_Channel0_Header:
.dw sfx_07_bin_Channel0
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

sfx_07_bin_Channel0:
.db $F0
    .db $01
    .db $01
    .db $05
    .db $02
.db $A2    ; A5
    .db $02
.db $80
    .db $03
.db $A2    ; A5
    .db $18
.db $F2


sfx_09_bin:
.dw $8A2F
.db $01        ;num channels
.db $01
.db $80
.db $A0

sfx_09_bin_Channel0_Header:
.dw sfx_09_bin_Channel0
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

sfx_09_bin_Channel0:
.db $F5
    .db $03
.db $AA    ; F6
    .db $01
.db $B1    ; C7
    .db $02
.db $80
    .db $01
.db $F2


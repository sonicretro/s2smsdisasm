sfx_19_bin:
.dw $8A2F
.db $01        ;num channels
.db $01
.db $80
.db $A0

sfx_19_bin_Channel0_Header:
.dw sfx_19_bin_Channel0
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

sfx_19_bin_Channel0:
.db $F5
    .db $07
.db $F0
    .db $01
    .db $01
    .db $FF
    .db $04
sfx_19_bin_LABEL_BE1E:
.db $AA    ; F6
    .db $03
.db $AF    ; As6
.db $B3    ; D7
.db $E6
    .db $02
.db $F7
    .db $00
    .db $07
    .dw sfx_19_bin_LABEL_BE1E
.db $F2


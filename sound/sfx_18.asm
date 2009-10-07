sfx_18_bin:
.dw $8A2F
.db $01        ;num channels
.db $02
.db $80
.db $A0

sfx_18_bin_Channel0_Header:
.dw sfx_18_bin_Channel0
.db $00        ; pitch adjustment
.db $00        ; volume adjustment


.db $80
.db $E0
    .db $06
    .db $BE
    .db $00
    .db $00
sfx_18_bin_Channel0:
    .db $F5
    .db $03
.db $B0    ; B6
    .db $01
.db $80
    .db $03
.db $E0
    .db $FF
    .db $11
    .db $FF
    .db $FF
    .db $FF
sfx_18_bin_LABEL_BDFC:
.db $C4    ; G8
    .db $09
.db $E6
    .db $04
.db $F7
    .db $00
    .db $03
    .dw sfx_18_bin_LABEL_BDFC
.db $F2
.db $F3
    .db $E7
.db $F5
    .db $03
.db $C0    ; Ds8
    .db $04
.db $F2


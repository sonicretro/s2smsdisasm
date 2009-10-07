sfx_10_bin:
.dw $8A2F
.db $01        ;num channels
.db $01
.db $80
.db $A0

sfx_10_bin_Channel0_Header:
.dw sfx_10_bin_Channel0
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

sfx_10_bin_Channel0:
sfx_10_bin_LABEL_BCFA:
.db $F0
    .db $01
    .db $01
    .db $50
    .db $01
.db $F5
    .db $07
.db $89    ; Gs3
    .db $06
.db $89    ; Gs3
    .db $03
.db $E6
    .db $02
.db $F7
    .db $00
    .db $05
    .dw sfx_10_bin_LABEL_BCFA
.db $F2


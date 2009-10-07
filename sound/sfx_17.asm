sfx_17_bin:     ; $BDC0
.dw $8A2F
.db $01        ;num channels
.db $01
.db $80
.db $E0

sfx_17_bin_Channel0_Header: ; $BDC6
.dw sfx_17_bin_Channel0
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

sfx_17_bin_Channel0:        ; $BDCA
.db $F3
    .db $E7
.db $F5
    .db $04
sfx_17_bin_LABEL_BDCE:
.db $A8    ; Ds6
    .db $03
.db $BB    ; As7
.db $F7
    .db $00
    .db $03
    .dw sfx_17_bin_LABEL_BDCE
sfx_17_bin_LABEL_BDD6:
.db $A8    ; Ds6
.db $BB    ; As7
.db $E6
    .db $02
.db $F7
    .db $00
    .db $05
    .dw sfx_17_bin_LABEL_BDD6
.db $F2


sfx_12_bin:
.dw $8A2F
.db $01        ;num channels
.db $01
.db $80
.db $E0

sfx_12_bin_Channel0_Header:
.dw sfx_12_bin_Channel0
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

sfx_12_bin_Channel0:
.db $F3
    .db $E7
.db $A0    ; G5
    .db $0A
.db $89    ; Gs3
    .db $06
.db $99    ; C5
    .db $0C
.db $95    ; Gs4
    .db $03
.db $9C    ; Ds5
    .db $05
.db $98    ; B4
    .db $01
.db $99    ; C5
    .db $17
.db $F2


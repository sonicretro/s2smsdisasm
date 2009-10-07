sfx_0C_bin:
.dw $8A2F
.db $01        ;num channels
.db $01
.db $80
.db $A0

sfx_0C_bin_Channel0_Header:
.dw sfx_0C_bin_Channel0
.db $07        ; pitch adjustment
.db $00        ; volume adjustment

sfx_0C_bin_Channel0:
.db $F5
    .db $08
.db $8D    ; C4
    .db $04
.db $92    ; F4
.db $97    ; As4
.db $94    ; G4
.db $99    ; C5
.db $9E    ; F5
.db $A3    ; As5
.db $A0    ; G5
.db $E6
    .db $03
sfx_0C_bin_LABEL_BC6D:
.db $F5
    .db $03
.db $99    ; C5
    .db $02
.db $A0    ; G5
.db $A4    ; B5
.db $A5    ; C6
    .db $04
.db $80
    .db $01
.db $E6
    .db $03
.db $F7
    .db $00
    .db $03
    .dw sfx_0C_bin_LABEL_BC6D
.db $F2


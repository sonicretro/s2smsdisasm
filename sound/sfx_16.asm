sfx_16_bin:     ; $BD8D
.dw $8A2F
.db $01        ;num channels
.db $02
.db $80
.db $A0

sfx_16_bin_Channel0_Header:     ; $BD93
.dw sfx_16_bin_Channel0
.db $00        ; pitch adjustment
.db $00        ; volume adjustment


.db $80         ;$BD97
.db $E0
    .db $9D
    .db $BD
    .db $00
    .db $00
    .db $F3
.db $E7
.db $F0
    .db $01
    .db $01
    .db $F6
    .db $01
.db $C0    ; Ds8
    .db $04
.db $F2

sfx_16_bin_Channel0:
.db $F5
    .db $03
.db $94    ; G4
    .db $04
.db $80
    .db $01
.db $F0
    .db $01
    .db $01
    .db $F4
    .db $01
.db $F5
    .db $08
sfx_16_bin_LABEL_BDB4:
.db $9D    ; E5
    .db $04
.db $E6
    .db $04
.db $80
    .db $04
.db $F7
    .db $00
    .db $03
    .dw sfx_16_bin_LABEL_BDB4
.db $F2


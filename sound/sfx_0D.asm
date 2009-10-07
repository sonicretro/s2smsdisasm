sfx_0D_bin:
.dw $8A2F
.db $01        ;num channels
.db $01
.db $80
.db $A0

sfx_0D_bin_Channel0_Header:
.dw sfx_0D_bin_Channel0
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

sfx_0D_bin_Channel0:
.db $F5
    .db $06
.db $F0
    .db $01
    .db $01
    .db $F8
    .db $01
.db $8D    ; C4
    .db $08
.db $91    ; E4
    .db $07
.db $94    ; G4
    .db $06
.db $98    ; B4
    .db $06
.db $9B    ; D5
    .db $05
.db $9E    ; F5
    .db $05
.db $A2    ; A5
    .db $04
.db $A5    ; C6
    .db $03
.db $A9    ; E6
    .db $02
sfx_0D_bin_LABEL_BCA2:
.db $9E    ; F5
    .db $02
.db $A2    ; A5
    .db $02
.db $A5    ; C6
    .db $02
.db $80
    .db $01
.db $FB
    .db $07
.db $E6
    .db $03
.db $F7
    .db $00
    .db $02
    .dw sfx_0D_bin_LABEL_BCA2
.db $E6
    .db $FA
.db $FB
    .db $F2
.db $E6
    .db $04
.db $F7
    .db $01
    .db $03
    .dw sfx_0D_bin_LABEL_BCA2
.db $F2


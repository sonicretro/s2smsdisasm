sfx_spring_bin:
.dw $8A2F
.db $01        ;num channels
.db $01
.db $80
.db $A0

sfx_spring_bin_Channel0_Header:
.dw sfx_spring_bin_Channel0
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

sfx_spring_bin_Channel0:
sfx_spring_bin_LABEL_BB29:
.db $F0
    .db $02
    .db $01
    .db $31
    .db $01
.db $F5
    .db $06
.db $91    ; E4
    .db $04
.db $F5
    .db $08
.db $F0
    .db $02
    .db $01
    .db $32
    .db $01
.db $91    ; E4
    .db $02
.db $9D    ; E5
    .db $02
.db $E6
    .db $03
.db $F7
    .db $00
    .db $05
    .dw sfx_spring_bin_LABEL_BB29
.db $F2


music_titlecard_bin:
.dw $8A2F
.db $04        ;num channels
.db $00
.db $02
.db $07

music_titlecard_bin_Channel0_Header:
.dw music_titlecard_bin_Channel0
.db $FF        ; pitch adjustment
.db $03        ; volume adjustment

music_titlecard_bin_Channel1_Header:
.dw music_titlecard_bin_Channel1
.db $0B        ; pitch adjustment
.db $03        ; volume adjustment

music_titlecard_bin_Channel2_Header:
.dw music_titlecard_bin_Channel2
.db $06        ; pitch adjustment
.db $03        ; volume adjustment

music_titlecard_bin_Channel3_Header:
.dw music_titlecard_bin_Channel3
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

music_titlecard_bin_Channel0:
music_titlecard_bin_LABEL_BAA6:
.db $F5
    .db $08
.db $81    ; C3
    .db $03
.db $84    ; Ds3
.db $86    ; F3
.db $87    ; Fs3
.db $80
.db $88    ; G3
.db $80
.db $8B    ; As3
.db $80
.db $8C    ; B3
.db $80
.db $8D    ; C4
.db $80
.db $90    ; Ds4
.db $92    ; F4
.db $93    ; Fs4
.db $94    ; G4
.db $94    ; G4
.db $94    ; G4
.db $94    ; G4
.db $80
.db $E6
    .db $04
music_titlecard_bin_LABEL_BAC0:
.db $94    ; G4
    .db $03
.db $80
.db $E6
    .db $02
.db $F7
    .db $00
    .db $04
    .dw music_titlecard_bin_LABEL_BAC0
.db $F2

music_titlecard_bin_Channel2:
.db $F6
    .dw music_titlecard_bin_LABEL_BAA6
.db $F2

music_titlecard_bin_Channel1:
.db $F6
    .dw music_titlecard_bin_LABEL_BAA6
.db $F2

music_titlecard_bin_Channel3:
.db $84    ; Ds3
    .db $03
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $88    ; G3
    .db $03
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $F2


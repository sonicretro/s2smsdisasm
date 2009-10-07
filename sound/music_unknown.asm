music_unknown_bin:
.dw $8A2F
.db $04        ;num channels
.db $00
.db $02
.db $05

music_unknown_bin_Channel0_Header:
.dw music_unknown_bin_Channel0
.db $FF        ; pitch adjustment
.db $02        ; volume adjustment

music_unknown_bin_Channel1_Header:
.dw music_unknown_bin_Channel1
.db $FF        ; pitch adjustment
.db $02        ; volume adjustment

music_unknown_bin_Channel2_Header:
.dw music_unknown_bin_Channel2
.db $FF        ; pitch adjustment
.db $04        ; volume adjustment

music_unknown_bin_Channel3_Header:
.dw music_unknown_bin_Channel3
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

music_unknown_bin_Channel0:
music_unknown_bin_LABEL_B95C:
.db $F5
    .db $04
.db $AE    ; A6
    .db $03
.db $AA    ; F6
.db $B0    ; B6
.db $AA    ; F6
.db $B1    ; C7
.db $AA    ; F6
.db $B3    ; D7
.db $AA    ; F6
.db $F7
    .db $00
    .db $08
    .dw music_unknown_bin_LABEL_B95C
music_unknown_bin_LABEL_B96C:
.db $AC    ; G6
    .db $03
.db $A9    ; E6
.db $AE    ; A6
.db $A9    ; E6
.db $B0    ; B6
.db $A9    ; E6
.db $B1    ; C7
.db $A9    ; E6
.db $F7
    .db $00
    .db $08
    .dw music_unknown_bin_LABEL_B96C
music_unknown_bin_LABEL_B97A:
.db $F5
    .db $04
.db $AE    ; A6
    .db $03
.db $AA    ; F6
.db $B0    ; B6
.db $AA    ; F6
.db $B1    ; C7
.db $AA    ; F6
.db $B3    ; D7
.db $AA    ; F6
.db $F7
    .db $00
    .db $08
    .dw music_unknown_bin_LABEL_B97A
music_unknown_bin_LABEL_B98A:
.db $AC    ; G6
    .db $03
.db $A9    ; E6
.db $AE    ; A6
.db $A9    ; E6
.db $B0    ; B6
.db $A9    ; E6
.db $B1    ; C7
.db $A9    ; E6
.db $F7
    .db $00
    .db $08
    .dw music_unknown_bin_LABEL_B98A
music_unknown_bin_LABEL_B998:
.db $B1    ; C7
    .db $03
.db $AE    ; A6
.db $B3    ; D7
.db $AE    ; A6
.db $B5    ; E7
.db $AE    ; A6
.db $B6    ; F7
.db $AE    ; A6
.db $F7
    .db $00
    .db $08
    .dw music_unknown_bin_LABEL_B998
music_unknown_bin_LABEL_B9A6:
.db $B0    ; B6
    .db $03
.db $AC    ; G6
.db $B1    ; C7
.db $AC    ; G6
.db $B3    ; D7
.db $AC    ; G6
.db $B5    ; E7
.db $AC    ; G6
.db $F7
    .db $00
    .db $08
    .dw music_unknown_bin_LABEL_B9A6
.db $F6
    .dw music_unknown_bin_LABEL_B97A
.db $F2

music_unknown_bin_Channel2:
music_unknown_bin_LABEL_B9B8:
.db $F5
    .db $02
.db $92    ; F4
    .db $02
.db $96    ; A4
.db $99    ; C5
.db $9D    ; E5
    .db $03
.db $E6
    .db $03
.db $9D    ; E5
    .db $03
.db $E6
    .db $FD
.db $E6
    .db $02
.db $F7
    .db $00
    .db $04
    .dw music_unknown_bin_LABEL_B9B8
.db $E6
    .db $F8
.db $F7
    .db $01
    .db $04
    .dw music_unknown_bin_LABEL_B9B8
.db $FB
    .db $FB
.db $F7
    .db $02
    .db $02
    .dw music_unknown_bin_LABEL_B9B8
.db $FB
    .db $0A
music_unknown_bin_LABEL_B9DD:
.db $F5
    .db $03
.db $86    ; F3
    .db $03
.db $E6
    .db $05
.db $86    ; F3
.db $E6
    .db $FB
.db $8A    ; A3
.db $E6
    .db $05
.db $8A    ; A3
.db $E6
    .db $FB
.db $8D    ; C4
.db $E6
    .db $05
.db $8D    ; C4
.db $E6
    .db $FB
.db $91    ; E4
.db $86    ; F3
.db $E6
    .db $05
.db $86    ; F3
.db $E6
    .db $FB
.db $86    ; F3
.db $8A    ; A3
.db $E6
    .db $05
.db $8A    ; A3
.db $E6
    .db $FB
.db $8D    ; C4
.db $E6
    .db $05
.db $8D    ; C4
.db $E6
    .db $FB
.db $91    ; E4
.db $E6
    .db $05
.db $91    ; E4
.db $E6
    .db $FB
.db $F7
    .db $00
    .db $04
    .dw music_unknown_bin_LABEL_B9DD
music_unknown_bin_LABEL_BA11:
.db $F5
    .db $03
.db $81    ; C3
    .db $03
.db $E6
    .db $05
.db $81    ; C3
.db $E6
    .db $FB
.db $85    ; E3
.db $E6
    .db $05
.db $85    ; E3
.db $E6
    .db $FB
.db $88    ; G3
.db $E6
    .db $05
.db $88    ; G3
.db $E6
    .db $FB
.db $8C    ; B3
.db $81    ; C3
.db $E6
    .db $05
.db $81    ; C3
.db $E6
    .db $FB
.db $81    ; C3
.db $85    ; E3
.db $E6
    .db $05
.db $85    ; E3
.db $E6
    .db $FB
.db $88    ; G3
.db $E6
    .db $05
.db $88    ; G3
.db $E6
    .db $FB
.db $8C    ; B3
.db $E6
    .db $05
.db $8C    ; B3
.db $E6
    .db $FB
.db $F7
    .db $00
    .db $04
    .dw music_unknown_bin_LABEL_BA11
.db $F6
    .dw music_unknown_bin_LABEL_B9DD
.db $F2

music_unknown_bin_Channel1:
.db $80
    .db $09
.db $E6
    .db $05
.db $F6
    .dw music_unknown_bin_LABEL_B95C
.db $F2

music_unknown_bin_Channel3:
music_unknown_bin_LABEL_BA51:
.db $80
    .db $30
.db $F7
    .db $00
    .db $07
    .dw music_unknown_bin_LABEL_BA51
.db $E4
    .db $01
.db $80
    .db $18
.db $81    ; C3
    .db $03
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $88    ; G3
.db $88    ; G3
music_unknown_bin_LABEL_BA65:
.db $81    ; C3
    .db $03
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $F7
    .db $00
    .db $07
    .dw music_unknown_bin_LABEL_BA65
.db $81    ; C3
    .db $03
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $88    ; G3
.db $88    ; G3
.db $F6
    .dw music_unknown_bin_LABEL_BA65
.db $F2


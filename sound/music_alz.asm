music_alz_bin:
.dw $8A2F
.db $04        ;num channels
.db $00
.db $02
.db $03

music_alz_bin_Channel0_Header:
.dw music_alz_bin_Channel0
.db $FF        ; pitch adjustment
.db $05        ; volume adjustment

music_alz_bin_Channel1_Header:
.dw music_alz_bin_Channel1
.db $FF        ; pitch adjustment
.db $05        ; volume adjustment

music_alz_bin_Channel2_Header:
.dw music_alz_bin_Channel2
.db $FF        ; pitch adjustment
.db $03        ; volume adjustment

music_alz_bin_Channel3_Header:
.dw music_alz_bin_Channel3
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

music_alz_bin_Channel0:
.db $F5
    .db $06
.db $84    ; Ds3
    .db $02
.db $88    ; G3
.db $8B    ; As3
.db $88    ; G3
.db $8B    ; As3
.db $8F    ; D4
.db $8B    ; As3
.db $8F    ; D4
.db $92    ; F4
.db $8F    ; D4
.db $92    ; F4
.db $96    ; A4
music_alz_bin_LABEL_8C7E:
.db $F8
    .dw music_alz_bin_LABEL_8DA0
.db $F7
    .db $00
    .db $07
    .dw music_alz_bin_LABEL_8C7E
.db $F5
    .db $07
.db $FB
    .db $0C
.db $E6
    .db $03
.db $81    ; C3
    .db $04
.db $E6
    .db $04
.db $81    ; C3
    .db $02
.db $E6
    .db $FC
.db $84    ; Ds3
    .db $04
.db $E6
    .db $04
.db $84    ; Ds3
    .db $02
.db $E6
    .db $FC
.db $86    ; F3
    .db $04
.db $E6
    .db $04
.db $86    ; F3
    .db $02
.db $E6
    .db $FC
.db $81    ; C3
    .db $04
.db $84    ; Ds3
    .db $04
.db $E6
    .db $04
.db $84    ; Ds3
    .db $02
.db $E6
    .db $FC
.db $86    ; F3
    .db $04
.db $E6
    .db $04
.db $86    ; F3
    .db $02
.db $E6
    .db $FC
.db $81    ; C3
    .db $02
.db $84    ; Ds3
    .db $04
.db $E6
    .db $04
.db $84    ; Ds3
    .db $02
.db $E6
    .db $FC
.db $86    ; F3
    .db $03
.db $E6
    .db $FD
.db $FB
    .db $F4
.db $F5
    .db $06
.db $A4    ; B5
    .db $01
.db $A5    ; C6
.db $A6    ; Cs6
music_alz_bin_LABEL_8CCC:
.db $E6
    .db $FE
.db $F5
    .db $06
music_alz_bin_LABEL_8CD0:
.db $A7    ; D6
    .db $04
.db $80
    .db $02
.db $E6
    .db $01
.db $F7
    .db $00
    .db $08
    .dw music_alz_bin_LABEL_8CD0
.db $E6
    .db $F8
music_alz_bin_LABEL_8CDD:
.db $A7    ; D6
    .db $04
.db $80
    .db $02
.db $E6
    .db $02
.db $A7    ; D6
    .db $04
.db $80
    .db $02
.db $E6
    .db $FE
.db $FB
    .db $FE
.db $F7
    .db $00
    .db $03
    .dw music_alz_bin_LABEL_8CDD
.db $FB
    .db $06
.db $A2    ; A5
    .db $04
.db $80
    .db $02
.db $E6
    .db $02
.db $A2    ; A5
    .db $04
.db $80
    .db $02
.db $E6
    .db $FE
music_alz_bin_LABEL_8CFE:
.db $A0    ; G5
    .db $04
.db $80
    .db $02
.db $E6
    .db $01
.db $F7
    .db $00
    .db $08
    .dw music_alz_bin_LABEL_8CFE
.db $E6
    .db $F8
.db $E6
    .db $02
.db $FB
    .db $F4
.db $F5
    .db $06
.db $A0    ; G5
    .db $04
.db $A5    ; C6
    .db $02
.db $A7    ; D6
    .db $04
.db $AC    ; G6
    .db $02
.db $E6
    .db $03
.db $AC    ; G6
    .db $04
.db $E6
    .db $FD
.db $A0    ; G5
    .db $02
.db $A5    ; C6
    .db $04
.db $A7    ; D6
    .db $02
.db $AC    ; G6
    .db $06
.db $E6
    .db $03
.db $AC    ; G6
    .db $04
.db $E6
    .db $FD
.db $A0    ; G5
    .db $02
.db $A5    ; C6
    .db $04
.db $A7    ; D6
    .db $02
.db $AC    ; G6
    .db $06
.db $FB
    .db $0C
.db $F7
    .db $01
    .db $04
    .dw music_alz_bin_LABEL_8CCC
music_alz_bin_LABEL_8D3C:
.db $F8
    .dw music_alz_bin_LABEL_8DE3
.db $F5
    .db $06
.db $FB
    .db $F4
.db $A0    ; G5
    .db $04
.db $E6
    .db $02
.db $A0    ; G5
    .db $02
.db $E6
    .db $FE
.db $A3    ; As5
    .db $04
.db $E6
    .db $02
.db $A3    ; As5
    .db $02
.db $E6
    .db $FE
.db $A2    ; A5
    .db $04
.db $A3    ; As5
    .db $02
.db $E6
    .db $02
.db $A3    ; As5
    .db $04
.db $E6
    .db $FE
.db $A3    ; As5
    .db $02
.db $A5    ; C6
    .db $04
.db $E6
    .db $02
.db $A5    ; C6
    .db $02
.db $E6
    .db $FE
.db $A3    ; As5
    .db $04
.db $E6
    .db $02
.db $A3    ; As5
    .db $02
.db $E6
    .db $FE
.db $A2    ; A5
    .db $04
.db $E6
    .db $02
.db $A2    ; A5
    .db $02
.db $E6
    .db $FE
.db $A3    ; As5
    .db $04
.db $E6
    .db $02
.db $A3    ; As5
    .db $02
.db $E6
    .db $FE
.db $F0
    .db $10
    .db $01
    .db $FA
    .db $01
.db $A0    ; G5
    .db $0C
.db $F0
    .db $00
    .db $00
    .db $00
    .db $00
.db $AC    ; G6
    .db $24
.db $FB
    .db $0C
.db $F7
    .db $01
    .db $02
    .dw music_alz_bin_LABEL_8D3C
music_alz_bin_LABEL_8D94:
.db $F8
    .dw music_alz_bin_LABEL_8E8E
.db $F7
    .db $00
    .db $08
    .dw music_alz_bin_LABEL_8D94
.db $F6
    .dw music_alz_bin_LABEL_8C7E
.db $F2
music_alz_bin_LABEL_8DA0:
.db $F5
    .db $07
.db $FB
    .db $F4
.db $AC    ; G6
    .db $04
.db $E6
    .db $04
.db $AC    ; G6
    .db $02
.db $E6
    .db $FC
.db $A5    ; C6
    .db $04
.db $E6
    .db $04
.db $A5    ; C6
    .db $02
.db $E6
    .db $FC
.db $AE    ; A6
    .db $04
.db $E6
    .db $04
.db $AE    ; A6
    .db $02
.db $E6
    .db $FC
.db $A5    ; C6
    .db $04
.db $AF    ; As6
    .db $04
.db $E6
    .db $04
.db $AF    ; As6
    .db $02
.db $E6
    .db $FC
.db $A5    ; C6
    .db $04
.db $E6
    .db $04
.db $A5    ; C6
    .db $02
.db $E6
    .db $FC
.db $A5    ; C6
    .db $02
.db $B1    ; C7
    .db $04
.db $E6
    .db $04
.db $B1    ; C7
    .db $02
.db $E6
    .db $FC
.db $AF    ; As6
    .db $04
.db $E6
    .db $04
.db $AF    ; As6
    .db $02
.db $E6
    .db $FC
.db $FB
    .db $0C
.db $F9
music_alz_bin_LABEL_8DE3:
.db $FB
    .db $F4
.db $E6
    .db $FD
.db $F0
    .db $0E
    .db $01
    .db $02
    .db $06
.db $BB    ; As7
    .db $06
.db $B6    ; F7
    .db $04
.db $B8    ; G7
    .db $06
.db $B3    ; D7
    .db $02
.db $B6    ; F7
    .db $06
.db $B1    ; C7
    .db $04
.db $B3    ; D7
    .db $06
.db $AF    ; As6
    .db $02
.db $B1    ; C7
    .db $06
.db $AC    ; G6
    .db $04
.db $AF    ; As6
    .db $06
.db $AA    ; F6
    .db $02
.db $AC    ; G6
    .db $06
.db $A7    ; D6
    .db $04
.db $AA    ; F6
    .db $06
.db $A5    ; C6
    .db $02
.db $A7    ; D6
    .db $06
.db $A3    ; As5
    .db $04
.db $A5    ; C6
    .db $06
.db $A0    ; G5
    .db $02
.db $A3    ; As5
    .db $06
.db $F0
    .db $00
    .db $00
    .db $00
    .db $00
.db $E6
    .db $03
.db $FB
    .db $0C
.db $F9
.db $F5
    .db $07
.db $81    ; C3
    .db $04
.db $E6
    .db $04
.db $81    ; C3
    .db $02
.db $E6
    .db $FC
.db $84    ; Ds3
    .db $04
.db $E6
    .db $04
.db $84    ; Ds3
    .db $02
.db $E6
    .db $FC
.db $86    ; F3
    .db $04
.db $E6
    .db $04
.db $86    ; F3
    .db $02
.db $E6
    .db $FC
.db $87    ; Fs3
    .db $04
.db $88    ; G3
    .db $04
.db $E6
    .db $04
.db $88    ; G3
    .db $02
.db $E6
    .db $FC
.db $88    ; G3
    .db $04
.db $E6
    .db $04
.db $87    ; Fs3
    .db $02
.db $E6
    .db $FC
.db $87    ; Fs3
    .db $02
.db $86    ; F3
    .db $04
.db $E6
    .db $04
.db $86    ; F3
    .db $02
.db $E6
    .db $FC
.db $84    ; Ds3
    .db $04
.db $E6
    .db $04
.db $84    ; Ds3
    .db $02
.db $E6
    .db $FC
.db $F9

music_alz_bin_Channel2:
.db $F5
    .db $06
.db $81    ; C3
    .db $02
.db $84    ; Ds3
.db $88    ; G3
.db $84    ; Ds3
.db $88    ; G3
.db $8B    ; As3
.db $88    ; G3
.db $8B    ; As3
.db $8F    ; D4
.db $8B    ; As3
.db $8F    ; D4
.db $92    ; F4
music_alz_bin_LABEL_8E6E:
.db $F8
    .dw music_alz_bin_LABEL_8E8E
.db $F7
    .db $00
    .db $08
    .dw music_alz_bin_LABEL_8E6E
music_alz_bin_LABEL_8E76:
.db $F8
    .dw music_alz_bin_LABEL_8E8E
.db $F7
    .db $00
    .db $18
    .dw music_alz_bin_LABEL_8E76
.db $FB
    .db $0C
music_alz_bin_LABEL_8E80:
.db $F8
    .dw music_alz_bin_LABEL_8E8E
.db $F7
    .db $00
    .db $08
    .dw music_alz_bin_LABEL_8E80
.db $FB
    .db $F4
.db $F6
    .dw music_alz_bin_LABEL_8E6E
.db $F2
music_alz_bin_LABEL_8E8E:
.db $F5
    .db $07
.db $81    ; C3
    .db $04
.db $E6
    .db $04
.db $81    ; C3
    .db $02
.db $E6
    .db $FC
.db $84    ; Ds3
    .db $04
.db $E6
    .db $04
.db $84    ; Ds3
    .db $02
.db $E6
    .db $FC
.db $86    ; F3
    .db $04
.db $E6
    .db $04
.db $86    ; F3
    .db $02
.db $E6
    .db $FC
.db $81    ; C3
    .db $04
.db $84    ; Ds3
    .db $04
.db $E6
    .db $04
.db $84    ; Ds3
    .db $02
.db $E6
    .db $FC
.db $86    ; F3
    .db $04
.db $E6
    .db $04
.db $86    ; F3
    .db $02
.db $E6
    .db $FC
.db $81    ; C3
    .db $02
.db $84    ; Ds3
    .db $04
.db $E6
    .db $04
.db $84    ; Ds3
    .db $02
.db $E6
    .db $FC
.db $86    ; F3
    .db $04
.db $E6
    .db $04
.db $86    ; F3
    .db $02
.db $E6
    .db $FC
.db $F9

music_alz_bin_Channel1:
.db $F5
    .db $06
.db $FB
    .db $13
.db $81    ; C3
    .db $02
.db $84    ; Ds3
.db $88    ; G3
.db $84    ; Ds3
.db $88    ; G3
.db $8B    ; As3
.db $88    ; G3
.db $8B    ; As3
.db $8F    ; D4
.db $8B    ; As3
.db $8F    ; D4
.db $92    ; F4
.db $FB
    .db $ED
music_alz_bin_LABEL_8EE0:
.db $FB
    .db $F4
.db $F8
    .dw music_alz_bin_LABEL_8F07
.db $FB
    .db $0C
.db $F7
    .db $00
    .db $07
    .dw music_alz_bin_LABEL_8EE0
.db $F8
    .dw music_alz_bin_LABEL_8DA0
music_alz_bin_LABEL_8EEF:
.db $F8
    .dw music_alz_bin_LABEL_8DA0
.db $F7
    .db $00
    .db $18
    .dw music_alz_bin_LABEL_8EEF
.db $FB
    .db $F4
music_alz_bin_LABEL_8EF9:
.db $F8
    .dw music_alz_bin_LABEL_8DA0
.db $F7
    .db $00
    .db $08
    .dw music_alz_bin_LABEL_8EF9
.db $FB
    .db $0C
.db $F6
    .dw music_alz_bin_LABEL_8EE0
.db $F2
music_alz_bin_LABEL_8F07:
.db $F5
    .db $07
.db $A0    ; G5
    .db $04
.db $E6
    .db $04
.db $A0    ; G5
    .db $02
.db $E6
    .db $FC
.db $A3    ; As5
    .db $04
.db $E6
    .db $04
.db $A3    ; As5
    .db $02
.db $E6
    .db $FC
.db $A5    ; C6
    .db $04
.db $E6
    .db $04
.db $A5    ; C6
    .db $02
.db $E6
    .db $FC
.db $A0    ; G5
    .db $04
.db $A3    ; As5
    .db $04
.db $E6
    .db $04
.db $A3    ; As5
    .db $02
.db $E6
    .db $FC
.db $A5    ; C6
    .db $04
.db $E6
    .db $04
.db $A5    ; C6
    .db $02
.db $E6
    .db $FC
.db $A0    ; G5
    .db $02
.db $A3    ; As5
    .db $04
.db $E6
    .db $04
.db $A3    ; As5
    .db $02
.db $E6
    .db $FC
.db $A5    ; C6
    .db $04
.db $E6
    .db $04
.db $A5    ; C6
    .db $02
.db $E6
    .db $FC
.db $F9

music_alz_bin_Channel3:
.db $88    ; G3
    .db $02
.db $81    ; C3
.db $81    ; C3
.db $A0    ; G5
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
    .db $04
.db $81    ; C3
    .db $02
.db $88    ; G3
.db $81    ; C3
.db $88    ; G3
music_alz_bin_LABEL_8F54:
.db $84    ; Ds3
    .db $04
.db $81    ; C3
    .db $02
.db $81    ; C3
    .db $04
.db $81    ; C3
    .db $02
.db $88    ; G3
    .db $04
.db $81    ; C3
    .db $02
.db $81    ; C3
    .db $04
.db $81    ; C3
    .db $02
.db $84    ; Ds3
    .db $04
.db $81    ; C3
    .db $02
.db $81    ; C3
    .db $04
.db $84    ; Ds3
    .db $02
.db $88    ; G3
    .db $04
.db $81    ; C3
    .db $02
.db $81    ; C3
    .db $04
.db $81    ; C3
    .db $02
.db $84    ; Ds3
    .db $04
.db $81    ; C3
    .db $02
.db $81    ; C3
    .db $04
.db $81    ; C3
    .db $02
.db $88    ; G3
    .db $04
.db $81    ; C3
    .db $02
.db $81    ; C3
    .db $04
.db $84    ; Ds3
    .db $02
.db $81    ; C3
    .db $04
.db $88    ; G3
    .db $02
.db $84    ; Ds3
    .db $04
.db $81    ; C3
    .db $02
.db $88    ; G3
    .db $04
.db $84    ; Ds3
    .db $02
.db $88    ; G3
    .db $04
.db $88    ; G3
    .db $02
.db $F6
    .dw music_alz_bin_LABEL_8F54
.db $F2


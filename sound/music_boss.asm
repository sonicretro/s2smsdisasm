music_boss_bin:
.dw $8A2F
.db $04        ;num channels
.db $00
.db $01
.db $03

music_boss_bin_Channel0_Header:
.dw music_boss_bin_Channel0
.db $EA        ; pitch adjustment
.db $05        ; volume adjustment

music_boss_bin_Channel1_Header:
.dw music_boss_bin_Channel1
.db $C6        ; pitch adjustment
.db $04        ; volume adjustment

music_boss_bin_Channel2_Header:
.dw music_boss_bin_Channel2
.db $C6        ; pitch adjustment
.db $03        ; volume adjustment

music_boss_bin_Channel3_Header:
.dw music_boss_bin_Channel3
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

music_boss_bin_Channel0:
.db $80
    .db $20
.db $FB
    .db $E8
music_boss_bin_LABEL_AA1A:
.db $F5
    .db $0F
.db $80
    .db $04
.db $C9    ; 
.db $C6    ; A8
.db $80
.db $C9    ; 
.db $C6    ; A8
.db $80
.db $C9    ; 
.db $C6    ; A8
.db $80
.db $C9    ; 
.db $C6    ; A8
.db $80
.db $C9    ; 
.db $C6    ; A8
.db $CD    ; 
.db $80
.db $CB    ; 
.db $C6    ; A8
.db $80
.db $CB    ; 
.db $C6    ; A8
.db $80
.db $CB    ; 
.db $C6    ; A8
.db $80
.db $CB    ; 
.db $C6    ; A8
.db $80
.db $CB    ; 
.db $C6    ; A8
.db $CE    ; 
.db $80
.db $C9    ; 
.db $C6    ; A8
.db $80
.db $C9    ; 
.db $C6    ; A8
.db $80
.db $C9    ; 
.db $C6    ; A8
.db $80
.db $C9    ; 
.db $C6    ; A8
.db $80
.db $C9    ; 
.db $C6    ; A8
.db $CC    ; 
.db $80
.db $C9    ; 
.db $C6    ; A8
.db $80
.db $C9    ; 
.db $C6    ; A8
.db $80
.db $C9    ; 
.db $C6    ; A8
.db $80
.db $C9    ; 
.db $C6    ; A8
.db $80
.db $C9    ; 
.db $C6    ; A8
.db $CD    ; 
.db $F7
    .db $00
    .db $02
    .dw music_boss_bin_LABEL_AA1A
.db $E6
    .db $FE
.db $F5
    .db $06
.db $F0
    .db $01
    .db $01
    .db $01
    .db $04
music_boss_bin_LABEL_AA6B:
.db $CD    ; 
    .db $04
.db $C9    ; 
.db $E6
    .db $01
.db $F7
    .db $00
    .db $08
    .dw music_boss_bin_LABEL_AA6B
.db $E6
    .db $F8
music_boss_bin_LABEL_AA77:
.db $CE    ; 
    .db $04
.db $CB    ; 
.db $E6
    .db $01
.db $F7
    .db $00
    .db $08
    .dw music_boss_bin_LABEL_AA77
.db $E6
    .db $F8
music_boss_bin_LABEL_AA83:
.db $CC    ; 
    .db $04
.db $C9    ; 
.db $E6
    .db $01
.db $F7
    .db $00
    .db $08
    .dw music_boss_bin_LABEL_AA83
.db $E6
    .db $F8
music_boss_bin_LABEL_AA8F:
.db $CD    ; 
    .db $04
.db $C9    ; 
.db $E6
    .db $01
.db $F7
    .db $00
    .db $08
    .dw music_boss_bin_LABEL_AA8F
.db $E6
    .db $F8
.db $F7
    .db $01
    .db $02
    .dw music_boss_bin_LABEL_AA6B
music_boss_bin_LABEL_AAA0:
.db $CE    ; 
    .db $04
.db $CB    ; 
.db $E6
    .db $01
.db $F7
    .db $00
    .db $08
    .dw music_boss_bin_LABEL_AAA0
.db $E6
    .db $F8
music_boss_bin_LABEL_AAAC:
.db $D2    ; 
    .db $04
.db $CE    ; 
.db $E6
    .db $01
.db $F7
    .db $00
    .db $08
    .dw music_boss_bin_LABEL_AAAC
.db $E6
    .db $F8
music_boss_bin_LABEL_AAB8:
.db $CE    ; 
    .db $04
.db $CB    ; 
.db $E6
    .db $01
.db $F7
    .db $00
    .db $08
    .dw music_boss_bin_LABEL_AAB8
.db $E6
    .db $F8
music_boss_bin_LABEL_AAC4:
.db $CB    ; 
    .db $04
.db $C8    ; 
.db $E6
    .db $01
.db $F7
    .db $00
    .db $08
    .dw music_boss_bin_LABEL_AAC4
.db $E6
    .db $F8
.db $F7
    .db $01
    .db $02
    .dw music_boss_bin_LABEL_AAA0
.db $F5
    .db $07
.db $F0
    .db $00
    .db $00
    .db $00
    .db $00
.db $E6
    .db $02
.db $E6
    .db $FE
music_boss_bin_LABEL_AAE0:
.db $E8
    .db $03
.db $D2    ; 
    .db $04
    .db $04
.db $E8
    .db $00
music_boss_bin_LABEL_AAE7:
.db $D2    ; 
    .db $04
.db $80
.db $E6
    .db $02
.db $F7
    .db $00
    .db $07
    .dw music_boss_bin_LABEL_AAE7
.db $E6
    .db $F2
.db $F7
    .db $01
    .db $02
    .dw music_boss_bin_LABEL_AAE0
.db $80
    .db $40
.db $80
.db $E6
    .db $02
.db $F6
    .dw music_boss_bin_LABEL_AA1A

music_boss_bin_Channel1:
.db $E1
    .db $01
.db $80
    .db $04

music_boss_bin_Channel2:
.db $80
    .db $20
.db $F5
    .db $14
music_boss_bin_LABEL_AB08:
.db $F8
    .dw music_boss_bin_LABEL_AB34
.db $F7
    .db $00
    .db $10
    .dw music_boss_bin_LABEL_AB08
.db $FB
    .db $02
music_boss_bin_LABEL_AB12:
.db $F8
    .dw music_boss_bin_LABEL_AB34
.db $F7
    .db $00
    .db $08
    .dw music_boss_bin_LABEL_AB12
.db $FB
    .db $FE
music_boss_bin_LABEL_AB1C:
.db $F8
    .dw music_boss_bin_LABEL_AB34
.db $F7
    .db $00
    .db $03
    .dw music_boss_bin_LABEL_AB1C
.db $BA    ; A7
    .db $08
music_boss_bin_LABEL_AB26:
.db $BA    ; A7
    .db $08
.db $E6
    .db $01
.db $F7
    .db $00
    .db $07
    .dw music_boss_bin_LABEL_AB26
.db $E6
    .db $F9
.db $F6
    .dw music_boss_bin_LABEL_AB08
music_boss_bin_LABEL_AB34:
.db $BA    ; A7
    .db $04
    .db $04
.db $80
.db $BA    ; A7
.db $C4    ; G8
.db $C6    ; A8
.db $BA    ; A7
.db $BA    ; A7
.db $80
.db $C4    ; G8
.db $C6    ; A8
.db $BA    ; A7
.db $C4    ; G8
.db $C6    ; A8
.db $BA    ; A7
.db $BA    ; A7
.db $F9
.db $F2

music_boss_bin_Channel3:
.db $88    ; G3
    .db $04
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $80
    .db $08
.db $88    ; G3
    .db $04
music_boss_bin_LABEL_AB51:
.db $84    ; Ds3
    .db $04
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $84    ; Ds3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $F7
    .db $00
    .db $03
    .dw music_boss_bin_LABEL_AB51
.db $84    ; Ds3
    .db $04
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $88    ; G3
.db $81    ; C3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $84    ; Ds3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $F7
    .db $01
    .db $06
    .dw music_boss_bin_LABEL_AB51
music_boss_bin_LABEL_AB7D:
.db $81    ; C3
.db $81    ; C3
.db $A0    ; G5
.db $81    ; C3
.db $F7
    .db $00
    .db $0C
    .dw music_boss_bin_LABEL_AB7D
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $80
    .db $0C
.db $88    ; G3
    .db $04
.db $80
    .db $08
.db $88    ; G3
    .db $04
.db $F6
    .dw music_boss_bin_LABEL_AB51


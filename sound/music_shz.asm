music_shz_bin:
.dw $8A2F
.db $04        ;num channels
.db $00
.db $02
.db $03

music_shz_bin_Channel0_Header:
.dw music_shz_bin_Channel0
.db $C8        ; pitch adjustment
.db $04        ; volume adjustment

music_shz_bin_Channel1_Header:
.dw music_shz_bin_Channel1
.db $C8        ; pitch adjustment
.db $04        ; volume adjustment

music_shz_bin_Channel2_Header:
.dw music_shz_bin_Channel2
.db $C8        ; pitch adjustment
.db $04        ; volume adjustment

music_shz_bin_Channel3_Header:
.dw music_shz_bin_Channel3
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

music_shz_bin_Channel0:
music_shz_bin_LABEL_A069:
.db $F5
    .db $0D
.db $BA    ; A7
    .db $04
.db $C1    ; E8
    .db $02
.db $C6    ; A8
    .db $04
.db $CD    ; 
    .db $06
.db $E6
    .db $02
    .db $02
.db $E6
    .db $02
    .db $04
.db $E6
    .db $02
    .db $02
.db $E6
    .db $FA
.db $CF    ; 
    .db $0A
.db $D0    ; 
    .db $06
.db $E6
    .db $02
    .db $02
.db $E6
    .db $02
    .db $04
.db $E6
    .db $02
    .db $02
.db $E6
    .db $FA
.db $BA    ; A7
    .db $04
.db $C1    ; E8
    .db $02
.db $C6    ; A8
    .db $04
.db $CD    ; 
    .db $08
.db $CF    ; 
    .db $0A
.db $D0    ; 
    .db $08
.db $CF    ; 
    .db $04
.db $E6
    .db $02
    .db $02
.db $E6
    .db $02
    .db $04
.db $E6
    .db $02
    .db $02
.db $E6
    .db $FA
.db $F7
    .db $00
    .db $02
    .dw music_shz_bin_LABEL_A069
.db $E6
    .db $FF
.db $FB
    .db $02
.db $F0
    .db $20
    .db $01
    .db $02
    .db $06
.db $F5
    .db $0B
.db $DA    ; 
    .db $06
.db $D9    ; 
.db $D7    ; 
    .db $04
.db $D9    ; 
    .db $02
.db $D3    ; 
    .db $18
.db $D2    ; 
    .db $06
    .db $06
.db $D3    ; 
.db $D0    ; 
.db $D2    ; 
    .db $04
.db $CE    ; 
    .db $06
.db $D0    ; 
    .db $02
.db $CB    ; 
    .db $0C
.db $CE    ; 
    .db $06
    .db $06
.db $D0    ; 
    .db $04
.db $CB    ; 
    .db $26
.db $80
    .db $28
.db $D0    ; 
    .db $02
.db $D3    ; 
    .db $04
.db $D7    ; 
    .db $02
.db $DA    ; 
    .db $06
.db $D9    ; 
.db $D7    ; 
    .db $04
.db $D9    ; 
    .db $02
.db $D3    ; 
    .db $18
.db $D2    ; 
    .db $06
    .db $06
.db $D3    ; 
.db $D0    ; 
.db $80
    .db $04
.db $CE    ; 
    .db $06
.db $D0    ; 
    .db $02
.db $CB    ; 
    .db $0C
.db $C9    ; 
    .db $04
.db $C7    ; 
    .db $02
.db $C9    ; 
    .db $04
.db $C7    ; 
    .db $26
.db $C6    ; A8
    .db $04
.db $C4    ; G8
    .db $02
.db $C6    ; A8
    .db $04
.db $C4    ; G8
    .db $2A
.db $FB
    .db $FE
.db $F5
    .db $14
music_shz_bin_LABEL_A105:
.db $C6    ; A8
    .db $02
.db $CD    ; 
    .db $04
.db $C6    ; A8
    .db $02
.db $CF    ; 
    .db $04
.db $C6    ; A8
    .db $02
.db $D0    ; 
    .db $04
.db $CF    ; 
    .db $06
.db $80
    .db $02
.db $F5
    .db $0B
.db $D9    ; 
    .db $06
.db $D5    ; 
    .db $04
.db $D2    ; 
    .db $06
    .db $02
.db $D0    ; 
    .db $04
.db $F5
    .db $14
.db $C6    ; A8
    .db $02
.db $CD    ; 
    .db $04
.db $C6    ; A8
    .db $02
.db $CF    ; 
    .db $04
.db $C6    ; A8
    .db $02
.db $D0    ; 
    .db $04
.db $CF    ; 
    .db $06
.db $F5
    .db $0B
.db $D0    ; 
    .db $02
.db $D5    ; 
    .db $06
.db $CC    ; 
    .db $04
.db $CB    ; 
    .db $0C
.db $F5
    .db $14
.db $C6    ; A8
    .db $02
.db $CD    ; 
    .db $04
.db $C6    ; A8
    .db $02
.db $CF    ; 
    .db $04
.db $C6    ; A8
    .db $02
.db $D0    ; 
    .db $04
.db $CF    ; 
    .db $06
.db $C9    ; 
    .db $02
.db $CC    ; 
    .db $06
.db $CB    ; 
.db $C9    ; 
.db $CB    ; 
    .db $04
.db $C6    ; A8
    .db $02
.db $C9    ; 
    .db $04
.db $CB    ; 
    .db $06
.db $C9    ; 
.db $80
    .db $1E
.db $F5
    .db $14
.db $F7
    .db $00
    .db $02
    .dw music_shz_bin_LABEL_A105
.db $80
    .db $02
.db $E6
    .db $01
.db $F6
    .dw music_shz_bin_LABEL_A069

music_shz_bin_Channel2:
.db $F5
    .db $07
music_shz_bin_LABEL_A16B:
.db $BA    ; A7
    .db $04
.db $B8    ; G7
    .db $02
.db $BA    ; A7
    .db $04
.db $BD    ; C8
    .db $0E
.db $B8    ; G7
    .db $0A
    .db $06
    .db $02
.db $B9    ; Gs7
    .db $06
.db $BA    ; A7
    .db $04
.db $B8    ; G7
    .db $02
.db $BA    ; A7
    .db $04
.db $BD    ; C8
    .db $0E
.db $B8    ; G7
    .db $0A
    .db $06
.db $C4    ; G8
    .db $02
.db $BF    ; D8
    .db $06
.db $F6
    .dw music_shz_bin_LABEL_A16B

music_shz_bin_Channel1:
music_shz_bin_LABEL_A18B:
.db $F5
    .db $0D
.db $80
    .db $0A
.db $C9    ; 
    .db $06
.db $E6
    .db $02
    .db $02
.db $E6
    .db $02
    .db $04
.db $E6
    .db $02
    .db $02
.db $E6
    .db $FA
    .db $0A
    .db $06
.db $E6
    .db $02
    .db $02
.db $E6
    .db $02
    .db $04
.db $E6
    .db $02
    .db $02
.db $E6
    .db $FA
.db $80
    .db $0A
.db $C9    ; 
    .db $08
    .db $0A
    .db $08
    .db $04
.db $E6
    .db $02
    .db $02
.db $E6
    .db $02
    .db $04
.db $E6
    .db $02
    .db $02
.db $E6
    .db $FA
.db $F7
    .db $00
    .db $02
    .dw music_shz_bin_LABEL_A18B
.db $FB
    .db $02
.db $E6
    .db $02
.db $F5
    .db $0B
.db $80
    .db $06
.db $DA    ; 
    .db $06
.db $D9    ; 
.db $D7    ; 
    .db $04
.db $D9    ; 
    .db $02
.db $D3    ; 
    .db $18
.db $D2    ; 
    .db $06
    .db $06
.db $D3    ; 
.db $D0    ; 
.db $D2    ; 
    .db $04
.db $CE    ; 
    .db $06
.db $D0    ; 
    .db $02
.db $CB    ; 
    .db $0C
.db $CE    ; 
    .db $06
    .db $06
.db $D0    ; 
    .db $04
.db $CB    ; 
    .db $26
.db $80
    .db $28
.db $D0    ; 
    .db $02
.db $D3    ; 
    .db $04
.db $D7    ; 
    .db $02
.db $DA    ; 
    .db $06
.db $D9    ; 
.db $D7    ; 
    .db $04
.db $D9    ; 
    .db $02
.db $D3    ; 
    .db $18
.db $D2    ; 
    .db $06
    .db $06
.db $D3    ; 
.db $D0    ; 
.db $80
    .db $04
.db $CE    ; 
    .db $06
.db $D0    ; 
    .db $02
.db $CB    ; 
    .db $0C
.db $C9    ; 
    .db $04
.db $C7    ; 
    .db $02
.db $C9    ; 
    .db $04
.db $C7    ; 
    .db $26
.db $C6    ; A8
    .db $04
.db $C4    ; G8
    .db $02
.db $C6    ; A8
    .db $04
.db $C4    ; G8
    .db $26
.db $FB
    .db $FE
.db $E6
    .db $FE
music_shz_bin_LABEL_A217:
.db $F5
    .db $14
.db $C9    ; 
    .db $04
.db $80
    .db $02
.db $CB    ; 
    .db $04
.db $80
    .db $02
.db $CD    ; 
    .db $04
.db $CB    ; 
    .db $06
.db $80
    .db $02
.db $E6
    .db $02
.db $F5
    .db $0B
.db $80
    .db $06
.db $D9    ; 
    .db $06
.db $D5    ; 
    .db $04
.db $D2    ; 
    .db $06
    .db $02
.db $E6
    .db $FE
.db $F5
    .db $14
.db $C9    ; 
    .db $04
.db $80
    .db $02
.db $CB    ; 
    .db $04
.db $80
    .db $02
.db $CD    ; 
    .db $04
.db $CB    ; 
    .db $06
.db $E6
    .db $02
.db $F5
    .db $0B
.db $80
    .db $06
.db $D0    ; 
    .db $02
.db $D5    ; 
    .db $06
.db $CC    ; 
    .db $04
.db $CB    ; 
    .db $08
.db $E6
    .db $FE
.db $F5
    .db $14
.db $C9    ; 
    .db $04
.db $80
    .db $02
.db $CB    ; 
    .db $04
.db $80
    .db $02
.db $CD    ; 
    .db $04
.db $CB    ; 
    .db $06
.db $C6    ; A8
    .db $02
.db $C9    ; 
    .db $06
.db $C8    ; 
.db $C6    ; A8
.db $C8    ; 
    .db $04
.db $C4    ; G8
    .db $02
.db $C6    ; A8
    .db $04
.db $C8    ; 
    .db $06
.db $C6    ; A8
.db $80
    .db $20
.db $F7
    .db $00
    .db $02
    .dw music_shz_bin_LABEL_A217
.db $F6
    .dw music_shz_bin_LABEL_A18B

music_shz_bin_Channel3:
music_shz_bin_LABEL_A27B:
.db $F8
    .dw music_shz_bin_LABEL_A289
.db $F7
    .db $00
    .db $03
    .dw music_shz_bin_LABEL_A27B
.db $F8
    .dw music_shz_bin_LABEL_A2AF
.db $F6
    .dw music_shz_bin_LABEL_A27B
music_shz_bin_LABEL_A289:
.db $84    ; Ds3
    .db $04
.db $81    ; C3
    .db $02
.db $84    ; Ds3
    .db $04
.db $81    ; C3
    .db $02
.db $88    ; G3
    .db $04
.db $E4
    .db $02
.db $88    ; G3
    .db $02
.db $E4
    .db $02
.db $88    ; G3
    .db $04
.db $E4
    .db $02
.db $88    ; G3
    .db $02
.db $E4
    .db $FA
.db $84    ; Ds3
    .db $04
.db $88    ; G3
    .db $02
.db $81    ; C3
    .db $04
    .db $02
.db $88    ; G3
    .db $04
.db $81    ; C3
    .db $02
    .db $04
    .db $02
.db $F9
music_shz_bin_LABEL_A2AF:
.db $84    ; Ds3
    .db $04
.db $88    ; G3
    .db $02
.db $84    ; Ds3
    .db $04
.db $84    ; Ds3
    .db $02
.db $88    ; G3
    .db $04
.db $81    ; C3
    .db $02
.db $81    ; C3
    .db $04
.db $88    ; G3
    .db $02
.db $84    ; Ds3
    .db $04
.db $88    ; G3
    .db $02
.db $81    ; C3
    .db $04
    .db $02
.db $88    ; G3
    .db $02
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $F9


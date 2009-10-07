music_emerald_bin:
.dw $8A2F
.db $04        ;num channels
.db $00
.db $02
.db $00

music_emerald_bin_Channel0_Header:
.dw music_emerald_bin_Channel0
.db $D4        ; pitch adjustment
.db $02        ; volume adjustment

music_emerald_bin_Channel1_Header:
.dw music_emerald_bin_Channel1
.db $D4        ; pitch adjustment
.db $03        ; volume adjustment

music_emerald_bin_Channel2_Header:
.dw music_emerald_bin_Channel2
.db $C8        ; pitch adjustment
.db $02        ; volume adjustment

music_emerald_bin_Channel3_Header:
.dw music_emerald_bin_Channel3
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

music_emerald_bin_Channel0:
.db $F5
    .db $08
.db $D5    ; 
    .db $08
    .db $02
    .db $02
    .db $02
    .db $02
    .db $04
    .db $04
    .db $04
    .db $04
.db $D1    ; 
    .db $08
.db $D3    ; 
    .db $08
.db $D1    ; 
    .db $08
.db $D3    ; 
    .db $08
.db $F5
    .db $00
.db $E6
    .db $07
.db $F0
    .db $01
    .db $01
    .db $01
    .db $04
.db $D5    ; 
    .db $04
music_emerald_bin_LABEL_B0F3:
.db $E7
    .db $04
.db $E6
    .db $FF
.db $F7
    .db $00
    .db $07
    .dw music_emerald_bin_LABEL_B0F3
.db $F2

music_emerald_bin_Channel2:
.db $F5
    .db $08
.db $BD    ; C8
    .db $08
    .db $02
    .db $02
    .db $02
    .db $02
    .db $04
    .db $04
    .db $04
    .db $04
.db $B9    ; Gs7
    .db $08
.db $B8    ; G7
    .db $08
.db $B9    ; Gs7
    .db $08
.db $BB    ; As7
    .db $08
.db $F5
    .db $00
.db $E6
    .db $07
.db $F0
    .db $01
    .db $01
    .db $01
    .db $04
.db $BD    ; C8
    .db $04
music_emerald_bin_LABEL_B11C:
.db $E7
    .db $04
.db $E6
    .db $FF
.db $F7
    .db $00
    .db $07
    .dw music_emerald_bin_LABEL_B11C
.db $F2

music_emerald_bin_Channel1:
.db $F5
    .db $11
.db $CD    ; 
    .db $08
    .db $02
    .db $02
    .db $02
    .db $02
    .db $04
    .db $04
    .db $04
    .db $04
.db $C9    ; 
    .db $02
.db $C0    ; Ds8
.db $C5    ; Gs8
.db $C9    ; 
.db $CB    ; 
.db $BC    ; B7
.db $C2    ; F8
.db $C7    ; 
.db $C9    ; 
.db $BD    ; C8
.db $C0    ; Ds8
.db $C5    ; Gs8
.db $CB    ; 
.db $BF    ; D8
.db $C2    ; F8
.db $C7    ; 
.db $CD    ; 
.db $D0    ; 
.db $E6
    .db $05
.db $F5
    .db $06
music_emerald_bin_LABEL_B149:
.db $D9    ; 
.db $DC    ; 
.db $E6
    .db $FF
.db $F7
    .db $00
    .db $07
    .dw music_emerald_bin_LABEL_B149
.db $F2

music_emerald_bin_Channel3:
.db $88    ; G3
    .db $08
.db $81    ; C3
    .db $02
    .db $02
    .db $02
    .db $02
    .db $04
    .db $04
    .db $04
    .db $04
.db $88    ; G3
    .db $08
    .db $08
    .db $08
    .db $08
.db $E4
    .db $0C
music_emerald_bin_LABEL_B165:
.db $81    ; C3
    .db $02
.db $E4
    .db $FF
.db $F7
    .db $00
    .db $0C
    .dw music_emerald_bin_LABEL_B165
music_emerald_bin_LABEL_B16E:
.db $81    ; C3
    .db $02
.db $F7
    .db $00
    .db $04
    .dw music_emerald_bin_LABEL_B16E
.db $F2


music_lose_life_bin:
.dw $8A2F
.db $04        ;num channels
.db $00
.db $02
.db $05

music_lose_life_bin_Channel0_Header:
.dw music_lose_life_bin_Channel0
.db $FF        ; pitch adjustment
.db $03        ; volume adjustment

music_lose_life_bin_Channel1_Header:
.dw music_lose_life_bin_Channel1
.db $FF        ; pitch adjustment
.db $03        ; volume adjustment

music_lose_life_bin_Channel2_Header:
.dw music_lose_life_bin_Channel2
.db $FF        ; pitch adjustment
.db $03        ; volume adjustment

music_lose_life_bin_Channel3_Header:
.dw music_lose_life_bin_Channel3
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

music_lose_life_bin_Channel0:
.db $F5
    .db $08
.db $F0
    .db $0D
    .db $01
    .db $01
    .db $04
.db $8F    ; D4
    .db $02
.db $91    ; E4
.db $92    ; F4
.db $93    ; Fs4
.db $96    ; A4
.db $98    ; B4
.db $8D    ; C4
    .db $0C
.db $8D    ; C4
    .db $09
.db $8D    ; C4
    .db $09
.db $8C    ; B3
    .db $06
.db $8B    ; As3
    .db $30
.db $F2

music_lose_life_bin_Channel2:
.db $F5
    .db $08
.db $F0
    .db $0D
    .db $01
    .db $01
    .db $04
.db $83    ; D3
    .db $02
.db $85    ; E3
.db $86    ; F3
.db $87    ; Fs3
.db $8A    ; A3
.db $8C    ; B3
.db $9B    ; D5
    .db $0C
.db $9B    ; D5
    .db $09
.db $9B    ; D5
    .db $09
.db $9A    ; Cs5
    .db $06
.db $99    ; C5
    .db $30
.db $F2

music_lose_life_bin_Channel1:
.db $F5
    .db $08
.db $F0
    .db $01
    .db $01
    .db $06
    .db $01
.db $B1    ; C7
    .db $0C
.db $F5
    .db $08
.db $F0
    .db $0D
    .db $01
    .db $01
    .db $04
.db $9F    ; Fs5
    .db $0C
.db $9F    ; Fs5
    .db $09
.db $9F    ; Fs5
    .db $09
.db $9D    ; E5
    .db $06
.db $9C    ; Ds5
    .db $30
.db $F2

music_lose_life_bin_Channel3:
.db $81    ; C3
    .db $02
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
    .db $0C
.db $88    ; G3
    .db $09
.db $88    ; G3
.db $88    ; G3
    .db $06
music_lose_life_bin_LABEL_AF8D:
.db $88    ; G3
    .db $01
.db $88    ; G3
.db $88    ; G3
.db $E4
    .db $01
.db $F7
    .db $00
    .db $08
    .dw music_lose_life_bin_LABEL_AF8D
music_lose_life_bin_LABEL_AF98:
.db $88    ; G3
    .db $01
.db $88    ; G3
.db $88    ; G3
.db $E4
    .db $FF
.db $F7
    .db $00
    .db $08
    .dw music_lose_life_bin_LABEL_AF98
.db $F2


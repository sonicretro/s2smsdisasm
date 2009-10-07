music_gameover_bin:
.dw $8A2F
.db $04        ;num channels
.db $00
.db $02
.db $05

music_gameover_bin_Channel0_Header:
.dw music_gameover_bin_Channel0
.db $FF        ; pitch adjustment
.db $03        ; volume adjustment

music_gameover_bin_Channel1_Header:
.dw music_gameover_bin_Channel1
.db $FF        ; pitch adjustment
.db $03        ; volume adjustment

music_gameover_bin_Channel2_Header:
.dw music_gameover_bin_Channel2
.db $FF        ; pitch adjustment
.db $03        ; volume adjustment

music_gameover_bin_Channel3_Header:
.dw music_gameover_bin_Channel3
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

music_gameover_bin_Channel0:
.db $F5
    .db $06
.db $E6
    .db $03
.db $F0
    .db $0F
    .db $01
    .db $03
    .db $01
.db $A0    ; G5
    .db $0C
.db $E6
    .db $FD
.db $F0
    .db $13
    .db $01
    .db $01
    .db $05
.db $99    ; C5
    .db $0C
.db $97    ; As4
    .db $06
.db $94    ; G4
    .db $0C
.db $9E    ; F5
    .db $0D
.db $9D    ; E5
    .db $0E
.db $99    ; C5
    .db $10
.db $F0
    .db $19
    .db $01
    .db $03
    .db $07
.db $98    ; B4
    .db $36
.db $F2

music_gameover_bin_Channel2:
.db $F5
    .db $06
.db $E6
    .db $03
.db $F0
    .db $0F
    .db $01
    .db $04
    .db $01
.db $A5    ; C6
    .db $0C
.db $E6
    .db $FD
.db $F0
    .db $13
    .db $01
    .db $01
    .db $05
.db $9D    ; E5
    .db $0C
.db $9B    ; D5
    .db $06
.db $97    ; As4
    .db $0C
.db $A3    ; As5
    .db $0D
.db $A0    ; G5
    .db $0E
.db $9D    ; E5
    .db $10
.db $F0
    .db $19
    .db $01
    .db $04
    .db $07
.db $9C    ; Ds5
    .db $36
.db $F2

music_gameover_bin_Channel1:
.db $F5
    .db $06
.db $E6
    .db $03
.db $F0
    .db $0F
    .db $01
    .db $04
    .db $01
.db $8D    ; C4
    .db $0C
.db $E6
    .db $FD
.db $F0
    .db $13
    .db $01
    .db $01
    .db $05
.db $8D    ; C4
    .db $0C
.db $8B    ; As3
    .db $06
.db $88    ; G3
    .db $0C
.db $92    ; F4
    .db $0D
.db $91    ; E4
    .db $0E
.db $8D    ; C4
    .db $10
.db $F0
    .db $19
    .db $01
    .db $03
    .db $07
.db $86    ; F3
    .db $36
.db $F2

music_gameover_bin_Channel3:
.db $80
    .db $0C
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
    .db $04
.db $88    ; G3
    .db $03
.db $81    ; C3
.db $81    ; C3
    .db $04
.db $81    ; C3
.db $88    ; G3
    .db $04
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
music_gameover_bin_LABEL_B21B:
.db $88    ; G3
    .db $01
.db $88    ; G3
.db $88    ; G3
.db $E4
    .db $01
.db $F7
    .db $00
    .db $0A
    .dw music_gameover_bin_LABEL_B21B
music_gameover_bin_LABEL_B226:
.db $88    ; G3
    .db $01
.db $88    ; G3
.db $88    ; G3
.db $E4
    .db $FF
.db $F7
    .db $00
    .db $08
    .dw music_gameover_bin_LABEL_B226
.db $F2


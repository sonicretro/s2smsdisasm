music_end_of_level_bin:
.dw $8A2F
.db $04        ;num channels
.db $00
.db $01
.db $03

music_end_of_level_bin_Channel0_Header:
.dw music_end_of_level_bin_Channel0
.db $FF        ; pitch adjustment
.db $02        ; volume adjustment

music_end_of_level_bin_Channel1_Header:
.dw music_end_of_level_bin_Channel1
.db $FF        ; pitch adjustment
.db $02        ; volume adjustment

music_end_of_level_bin_Channel2_Header:
.dw music_end_of_level_bin_Channel2
.db $FF        ; pitch adjustment
.db $02        ; volume adjustment

music_end_of_level_bin_Channel3_Header:
.dw music_end_of_level_bin_Channel3
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

music_end_of_level_bin_Channel0:
.db $F5
    .db $03
.db $F0
    .db $01
    .db $01
    .db $16
    .db $01
.db $9D    ; E5
    .db $03
.db $9D    ; E5
.db $91    ; E4
.db $91    ; E4
.db $F5
    .db $08
.db $F0
    .db $01
    .db $01
    .db $10
    .db $01
.db $84    ; Ds3
    .db $0C
.db $F0
    .db $10
    .db $01
    .db $01
    .db $04
.db $9B    ; D5
    .db $06
.db $9D    ; E5
    .db $0C
.db $A0    ; G5
.db $9D    ; E5
    .db $06
.db $A0    ; G5
.db $A2    ; A5
.db $A3    ; As5
.db $A4    ; B5
.db $A7    ; D6
.db $A9    ; E6
    .db $30
.db $F5
    .db $03
.db $F0
    .db $01
    .db $01
    .db $16
    .db $01
.db $91    ; E4
    .db $03
.db $8A    ; A3
.db $F5
    .db $08
.db $F0
    .db $01
    .db $01
    .db $10
    .db $01
.db $84    ; Ds3
    .db $0C
.db $F2

music_end_of_level_bin_Channel2:
.db $E6
    .db $04
.db $F5
    .db $03
.db $F0
    .db $01
    .db $01
    .db $16
    .db $01
.db $FB
    .db $22
.db $9D    ; E5
    .db $03
.db $9D    ; E5
.db $91    ; E4
.db $91    ; E4
.db $F0
    .db $01
    .db $01
    .db $10
    .db $01
.db $84    ; Ds3
    .db $0C
.db $FB
    .db $DE
.db $E6
    .db $FC
.db $F0
    .db $10
    .db $01
    .db $01
    .db $04
.db $F5
    .db $08
.db $83    ; D3
    .db $06
.db $85    ; E3
    .db $0C
.db $88    ; G3
.db $85    ; E3
    .db $06
.db $88    ; G3
.db $8A    ; A3
.db $8B    ; As3
.db $8C    ; B3
.db $8F    ; D4
.db $85    ; E3
    .db $30
.db $E6
    .db $04
.db $F5
    .db $03
.db $F0
    .db $01
    .db $01
    .db $16
    .db $01
.db $FB
    .db $22
.db $91    ; E4
    .db $03
.db $8A    ; A3
.db $F0
    .db $01
    .db $01
    .db $10
    .db $01
.db $84    ; Ds3
    .db $0C
.db $FB
    .db $DE
.db $E6
    .db $FC
.db $F2

music_end_of_level_bin_Channel1:
.db $F5
    .db $03
.db $F0
    .db $01
    .db $01
    .db $16
    .db $01
.db $FB
    .db $03
.db $9D    ; E5
    .db $03
.db $9D    ; E5
.db $91    ; E4
.db $91    ; E4
.db $F5
    .db $08
.db $F0
    .db $01
    .db $01
    .db $10
    .db $01
.db $84    ; Ds3
    .db $0C
.db $FB
    .db $FD
.db $F0
    .db $10
    .db $01
    .db $01
    .db $04
.db $F5
    .db $08
.db $8A    ; A3
    .db $06
.db $8C    ; B3
    .db $0C
.db $8F    ; D4
.db $8C    ; B3
    .db $06
.db $8F    ; D4
.db $91    ; E4
.db $92    ; F4
.db $93    ; Fs4
.db $96    ; A4
.db $98    ; B4
    .db $30
.db $F5
    .db $03
.db $F0
    .db $01
    .db $01
    .db $16
    .db $01
.db $FB
    .db $03
.db $91    ; E4
    .db $03
.db $8A    ; A3
.db $F5
    .db $08
.db $F0
    .db $01
    .db $01
    .db $10
    .db $01
.db $84    ; Ds3
    .db $0C
.db $FB
    .db $FD
.db $F2

music_end_of_level_bin_Channel3:
.db $81    ; C3
    .db $06
.db $A0    ; G5
.db $88    ; G3
    .db $0C
.db $88    ; G3
    .db $06
.db $88    ; G3
    .db $0C
.db $88    ; G3
.db $88    ; G3
    .db $06
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $81    ; C3
    .db $0C
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
    .db $03
.db $88    ; G3
.db $88    ; G3
    .db $0C
.db $F2


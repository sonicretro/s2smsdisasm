music_speed_shoes_bin:
.dw $8A2F
.db $04        ;num channels
.db $00
.db $01
.db $04

music_speed_shoes_bin_Channel0_Header:
.dw music_speed_shoes_bin_Channel0
.db $CB        ; pitch adjustment
.db $04        ; volume adjustment

music_speed_shoes_bin_Channel1_Header:
.dw music_speed_shoes_bin_Channel1
.db $CB        ; pitch adjustment
.db $05        ; volume adjustment

music_speed_shoes_bin_Channel2_Header:
.dw music_speed_shoes_bin_Channel2
.db $CB        ; pitch adjustment
.db $03        ; volume adjustment

music_speed_shoes_bin_Channel3_Header:
.dw music_speed_shoes_bin_Channel3
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

music_speed_shoes_bin_Channel0:
.db $80
    .db $40
.db $F5
    .db $08
music_speed_shoes_bin_LABEL_ABB4:
.db $BD    ; C8
    .db $04
.db $C1    ; E8
.db $C4    ; G8
.db $C9    ; 
.db $CD    ; 
.db $C9    ; 
.db $C4    ; G8
.db $C1    ; E8
.db $BD    ; C8
.db $C1    ; E8
.db $C4    ; G8
.db $80
.db $CD    ; 
.db $C9    ; 
.db $C4    ; G8
.db $C1    ; E8
.db $F7
    .db $00
    .db $02
    .dw music_speed_shoes_bin_LABEL_ABB4
music_speed_shoes_bin_LABEL_ABCA:
.db $C4    ; G8
    .db $04
.db $C8    ; 
.db $CB    ; 
.db $CF    ; 
.db $D2    ; 
.db $CF    ; 
.db $CB    ; 
.db $C8    ; 
.db $C4    ; G8
.db $C8    ; 
.db $CB    ; 
.db $CF    ; 
.db $D2    ; 
.db $CF    ; 
.db $CB    ; 
.db $C8    ; 
.db $F7
    .db $00
    .db $02
    .dw music_speed_shoes_bin_LABEL_ABCA
music_speed_shoes_bin_LABEL_ABE0:
.db $E6
    .db $07
music_speed_shoes_bin_LABEL_ABE2:
.db $D2    ; 
    .db $02
.db $DE    ; 
.db $D2    ; 
.db $DE    ; 
.db $E6
    .db $FF
.db $F7
    .db $00
    .db $08
    .dw music_speed_shoes_bin_LABEL_ABE2
.db $E6
    .db $01
.db $E6
    .db $07
music_speed_shoes_bin_LABEL_ABF2:
.db $D0    ; 
.db $DC    ; 
.db $D0    ; 
.db $DC    ; 
.db $E6
    .db $FF
.db $F7
    .db $00
    .db $08
    .dw music_speed_shoes_bin_LABEL_ABF2
.db $E6
    .db $01
.db $E6
    .db $07
music_speed_shoes_bin_LABEL_AC01:
.db $CB    ; 
.db $D7    ; 
.db $CB    ; 
.db $D7    ; 
.db $E6
    .db $FF
.db $F7
    .db $00
    .db $08
    .dw music_speed_shoes_bin_LABEL_AC01
.db $E6
    .db $01
music_speed_shoes_bin_LABEL_AC0E:
.db $CB    ; 
.db $D7    ; 
.db $CB    ; 
.db $D7    ; 
.db $E6
    .db $01
.db $F7
    .db $00
    .db $08
    .dw music_speed_shoes_bin_LABEL_AC0E
.db $E6
    .db $F8
.db $F7
    .db $01
    .db $02
    .dw music_speed_shoes_bin_LABEL_ABE0
.db $F6
    .dw music_speed_shoes_bin_LABEL_ABB4

music_speed_shoes_bin_Channel2:
.db $F5
    .db $07
.db $80
    .db $40
music_speed_shoes_bin_LABEL_AC27:
.db $BA    ; A7
    .db $08
.db $BD    ; C8
.db $B5    ; E7
.db $B8    ; G7
.db $BA    ; A7
    .db $04
.db $BD    ; C8
.db $80
.db $BD    ; C8
.db $B5    ; E7
    .db $08
.db $B8    ; G7
.db $F6
    .dw music_speed_shoes_bin_LABEL_AC27

music_speed_shoes_bin_Channel1:
.db $F5
    .db $08
.db $80
    .db $40
music_speed_shoes_bin_LABEL_AC3B:
.db $C6    ; A8
    .db $04
.db $C9    ; 
.db $CD    ; 
.db $D0    ; 
.db $D2    ; 
.db $D0    ; 
.db $CD    ; 
.db $C9    ; 
.db $C6    ; A8
.db $C9    ; 
.db $CD    ; 
.db $D0    ; 
.db $D2    ; 
.db $D0    ; 
.db $CD    ; 
.db $C9    ; 
.db $F7
    .db $00
    .db $02
    .dw music_speed_shoes_bin_LABEL_AC3B
music_speed_shoes_bin_LABEL_AC51:
.db $C6    ; A8
    .db $04
.db $CB    ; 
.db $CF    ; 
.db $D2    ; 
.db $D5    ; 
.db $D2    ; 
.db $CF    ; 
.db $CB    ; 
.db $C6    ; A8
.db $CB    ; 
.db $CF    ; 
.db $D2    ; 
.db $D5    ; 
.db $D2    ; 
.db $CF    ; 
.db $CB    ; 
.db $F7
    .db $00
    .db $02
    .dw music_speed_shoes_bin_LABEL_AC51
.db $F6
    .dw music_speed_shoes_bin_LABEL_AC3B

music_speed_shoes_bin_Channel3:
.db $88    ; G3
    .db $04
    .db $04
    .db $04
    .db $04
.db $84    ; Ds3
.db $88    ; G3
.db $88    ; G3
.db $80
.db $88    ; G3
.db $84    ; Ds3
.db $88    ; G3
.db $80
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $80
music_speed_shoes_bin_LABEL_AC7B:
.db $81    ; C3
    .db $04
.db $E4
    .db $02
.db $81    ; C3
    .db $04
.db $81    ; C3
.db $81    ; C3
.db $E4
    .db $FE
.db $F6
    .dw music_speed_shoes_bin_LABEL_AC7B


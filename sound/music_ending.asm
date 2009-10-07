music_ending_bin:
.dw $8A2F
.db $04        ;num channels
.db $00
.db $02
.db $03

music_ending_bin_Channel0_Header:
.dw music_ending_bin_Channel0
.db $D7        ; pitch adjustment
.db $02        ; volume adjustment

music_ending_bin_Channel1_Header:
.dw music_ending_bin_Channel1
.db $D7        ; pitch adjustment
.db $04        ; volume adjustment

music_ending_bin_Channel2_Header:
.dw music_ending_bin_Channel2
.db $CB        ; pitch adjustment
.db $02        ; volume adjustment

music_ending_bin_Channel3_Header:
.dw music_ending_bin_Channel3
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

music_ending_bin_Channel0:
.db $F5
    .db $14
music_ending_bin_LABEL_B24A:
.db $CD    ; 
    .db $12
.db $CB    ; 
    .db $1E
.db $C8    ; 
    .db $12
.db $C9    ; 
.db $C8    ; 
    .db $0C
.db $F7
    .db $00
    .db $02
    .dw music_ending_bin_LABEL_B24A
.db $F5
    .db $06
.db $F0
    .db $15
    .db $02
    .db $01
    .db $04
.db $80
    .db $0C
.db $C6    ; A8
    .db $06
.db $C9    ; 
.db $C9    ; 
.db $C6    ; A8
.db $C9    ; 
.db $C6    ; A8
.db $CD    ; 
.db $CB    ; 
    .db $0C
.db $C9    ; 
.db $CB    ; 
    .db $06
.db $C4    ; G8
    .db $0C
.db $80
.db $C6    ; A8
    .db $06
.db $C9    ; 
.db $C9    ; 
.db $C6    ; A8
.db $C9    ; 
.db $C6    ; A8
.db $CD    ; 
.db $CB    ; 
    .db $0C
.db $C9    ; 
.db $CB    ; 
    .db $12
.db $80
    .db $0C
.db $C6    ; A8
    .db $06
.db $C9    ; 
.db $C9    ; 
.db $C6    ; A8
.db $C9    ; 
.db $C6    ; A8
.db $D2    ; 
.db $D0    ; 
    .db $0C
.db $CD    ; 
.db $CD    ; 
    .db $06
    .db $06
.db $CE    ; 
.db $D0    ; 
    .db $30
.db $F0
    .db $0A
    .db $01
    .db $03
    .db $03
.db $80
    .db $1E
.db $BB    ; As7
    .db $12
.db $F0
    .db $15
    .db $02
    .db $01
    .db $04
.db $80
    .db $0C
.db $C6    ; A8
    .db $06
.db $C9    ; 
.db $C9    ; 
.db $C6    ; A8
.db $C9    ; 
.db $C6    ; A8
.db $CD    ; 
.db $CB    ; 
    .db $0C
.db $C9    ; 
.db $CB    ; 
    .db $06
.db $C4    ; G8
    .db $0C
.db $80
.db $C6    ; A8
    .db $06
.db $C9    ; 
.db $C9    ; 
.db $C6    ; A8
.db $C9    ; 
.db $C6    ; A8
.db $CD    ; 
.db $CB    ; 
    .db $0C
.db $C9    ; 
.db $CB    ; 
    .db $12
.db $80
    .db $0C
.db $C6    ; A8
    .db $06
.db $C9    ; 
.db $C9    ; 
.db $C6    ; A8
.db $C9    ; 
.db $C6    ; A8
.db $D2    ; 
.db $D0    ; 
    .db $0C
.db $CD    ; 
.db $CD    ; 
    .db $06
    .db $06
.db $CE    ; 
.db $D0    ; 
    .db $30
.db $80
    .db $24
.db $D5    ; 
    .db $06
.db $D4    ; 
.db $D2    ; 
    .db $0C
.db $D0    ; 
.db $CD    ; 
    .db $06
.db $C9    ; 
.db $CB    ; 
.db $CD    ; 
.db $E7
    .db $06
.db $C8    ; 
.db $C4    ; G8
    .db $18
.db $D2    ; 
    .db $06
.db $D4    ; 
.db $D5    ; 
    .db $0C
.db $D4    ; 
.db $D2    ; 
    .db $06
.db $C9    ; 
.db $CB    ; 
.db $CD    ; 
.db $E7
    .db $0C
.db $80
    .db $12
.db $CD    ; 
    .db $06
.db $D0    ; 
.db $CF    ; 
.db $CE    ; 
    .db $0C
.db $C6    ; A8
    .db $06
.db $C7    ; 
.db $C8    ; 
    .db $0C
.db $CD    ; 
    .db $06
.db $CB    ; 
.db $C9    ; 
.db $C8    ; 
.db $C9    ; 
.db $D5    ; 
    .db $0C
.db $D2    ; 
    .db $06
.db $D4    ; 
.db $D5    ; 
.db $D5    ; 
    .db $0C
.db $D1    ; 
.db $D0    ; 
    .db $06
.db $CC    ; 
.db $CE    ; 
.db $D0    ; 
.db $E7
    .db $0C
.db $80
    .db $24
.db $80
    .db $18
.db $CD    ; 
    .db $06
.db $CE    ; 
.db $D0    ; 
.db $D2    ; 
.db $CE    ; 
    .db $12
.db $D5    ; 
.db $D4    ; 
    .db $06
.db $D2    ; 
.db $D0    ; 
    .db $0C
.db $C4    ; G8
    .db $06
.db $C6    ; A8
.db $C8    ; 
.db $C9    ; 
.db $CB    ; 
.db $CD    ; 
.db $E7
    .db $18
.db $80
    .db $06
.db $CD    ; 
.db $CD    ; 
.db $CD    ; 
.db $CE    ; 
.db $CD    ; 
.db $C9    ; 
.db $C6    ; A8
    .db $12
    .db $06
    .db $06
.db $C8    ; 
.db $C9    ; 
.db $CB    ; 
.db $CD    ; 
    .db $0C
.db $CB    ; 
    .db $06
.db $CD    ; 
.db $CE    ; 
.db $E7
    .db $0C
.db $CD    ; 
.db $CE    ; 
    .db $06
.db $CD    ; 
.db $CB    ; 
.db $C9    ; 
.db $E7
    .db $06
.db $CB    ; 
.db $CB    ; 
    .db $24
.db $80
    .db $18
.db $CD    ; 
    .db $06
.db $CE    ; 
.db $D0    ; 
.db $D2    ; 
.db $CE    ; 
    .db $12
.db $D5    ; 
.db $D4    ; 
    .db $06
.db $D2    ; 
.db $D0    ; 
    .db $0C
.db $C4    ; G8
    .db $06
.db $C6    ; A8
.db $C8    ; 
.db $C9    ; 
.db $CD    ; 
.db $D4    ; 
.db $E7
    .db $06
.db $D2    ; 
    .db $12
.db $80
    .db $06
.db $CD    ; 
.db $CD    ; 
.db $CD    ; 
.db $CE    ; 
.db $CD    ; 
.db $CB    ; 
.db $C9    ; 
    .db $12
    .db $06
.db $C8    ; 
.db $C6    ; A8
.db $C4    ; G8
.db $C4    ; G8
.db $E7
    .db $0C
.db $C8    ; 
    .db $06
.db $C9    ; 
.db $CB    ; 
.db $CB    ; 
    .db $12
.db $C9    ; 
    .db $1E
.db $E7
    .db $24
.db $80
    .db $0C
music_ending_bin_LABEL_B386:
.db $CD    ; 
    .db $12
.db $CB    ; 
    .db $1E
.db $C8    ; 
    .db $12
.db $C9    ; 
.db $C8    ; 
    .db $0C
.db $F7
    .db $00
    .db $03
    .dw music_ending_bin_LABEL_B386
.db $ED
    .db $03
.db $CD    ; 
    .db $12
.db $CB    ; 
.db $C9    ; 
    .db $0C
.db $C8    ; 
    .db $30
.db $F2

music_ending_bin_Channel2:
.db $F5
    .db $11
music_ending_bin_LABEL_B3A0:
.db $F8
    .dw music_ending_bin_LABEL_B59D
.db $F7
    .db $00
    .db $02
    .dw music_ending_bin_LABEL_B3A0
music_ending_bin_LABEL_B3A8:
.db $F8
    .dw music_ending_bin_LABEL_B59D
.db $F7
    .db $00
    .db $02
    .dw music_ending_bin_LABEL_B3A8
.db $F8
    .dw music_ending_bin_LABEL_B5FE
.db $F8
    .dw music_ending_bin_LABEL_B65F
music_ending_bin_LABEL_B3B6:
.db $F8
    .dw music_ending_bin_LABEL_B59D
.db $F7
    .db $00
    .db $02
    .dw music_ending_bin_LABEL_B3B6
.db $F8
    .dw music_ending_bin_LABEL_B5FE
.db $F8
    .dw music_ending_bin_LABEL_B6AF
.db $B6    ; F7
    .db $04
.db $E6
    .db $04
.db $C9    ; 
    .db $02
.db $C8    ; 
.db $80
.db $E6
    .db $FC
.db $B6    ; F7
.db $E6
    .db $04
.db $C6    ; A8
.db $80
.db $C4    ; G8
.db $E6
    .db $FC
.db $B6    ; F7
    .db $04
.db $E6
    .db $04
.db $C4    ; G8
    .db $02
.db $C6    ; A8
.db $80
.db $C6    ; A8
.db $C4    ; G8
.db $80
.db $E6
    .db $FC
.db $BD    ; C8
.db $BF    ; D8
    .db $04
.db $E6
    .db $04
.db $C6    ; A8
    .db $02
.db $E6
    .db $FC
.db $C0    ; Ds8
    .db $04
.db $E6
    .db $04
.db $C8    ; 
    .db $02
.db $E6
    .db $FC
.db $B5    ; E7
    .db $04
.db $E6
    .db $04
.db $C8    ; 
    .db $02
.db $C6    ; A8
.db $80
.db $E6
    .db $FC
.db $B5    ; E7
.db $E6
    .db $04
.db $C4    ; G8
.db $80
.db $C4    ; G8
.db $E6
    .db $FC
.db $B5    ; E7
    .db $04
.db $E6
    .db $04
.db $C1    ; E8
    .db $02
.db $C4    ; G8
.db $80
.db $C4    ; G8
.db $C1    ; E8
.db $80
.db $E6
    .db $FC
.db $B5    ; E7
.db $B8    ; G7
    .db $04
.db $E6
    .db $04
.db $C4    ; G8
    .db $02
.db $E6
    .db $FC
.db $B9    ; Gs7
    .db $04
.db $E6
    .db $04
.db $C6    ; A8
    .db $02
.db $E6
    .db $FC
.db $BA    ; A7
    .db $04
.db $E6
    .db $04
.db $C9    ; 
    .db $02
.db $C8    ; 
.db $80
.db $E6
    .db $FC
.db $BA    ; A7
.db $E6
    .db $04
.db $C6    ; A8
.db $80
.db $C4    ; G8
.db $E6
    .db $FC
.db $BA    ; A7
    .db $04
.db $E6
    .db $04
.db $C6    ; A8
    .db $02
    .db $02
.db $80
.db $C6    ; A8
.db $C4    ; G8
.db $80
.db $E6
    .db $FC
.db $BC    ; B7
.db $BF    ; D8
    .db $04
.db $E6
    .db $04
.db $C6    ; A8
    .db $02
.db $E6
    .db $FC
.db $C0    ; Ds8
    .db $04
.db $E6
    .db $04
.db $C8    ; 
    .db $02
.db $E6
    .db $FC
.db $B5    ; E7
    .db $04
.db $E6
    .db $04
.db $C8    ; 
    .db $02
.db $C6    ; A8
.db $80
.db $E6
    .db $FC
.db $B5    ; E7
.db $E6
    .db $04
.db $C4    ; G8
.db $80
.db $C1    ; E8
.db $E6
    .db $FC
.db $B5    ; E7
    .db $04
.db $E6
    .db $04
.db $C4    ; G8
    .db $02
.db $C1    ; E8
.db $80
.db $C4    ; G8
.db $C1    ; E8
.db $80
.db $E6
    .db $FC
.db $B5    ; E7
.db $C1    ; E8
    .db $04
.db $E6
    .db $04
.db $D0    ; 
    .db $02
.db $E6
    .db $FC
.db $C0    ; Ds8
    .db $04
.db $E6
    .db $04
.db $CF    ; 
    .db $02
.db $E6
    .db $FC
.db $BF    ; D8
    .db $04
.db $E6
    .db $04
.db $CD    ; 
    .db $02
.db $CB    ; 
.db $80
.db $E6
    .db $FC
.db $BF    ; D8
.db $E6
    .db $04
.db $CD    ; 
.db $80
.db $CB    ; 
.db $E6
    .db $FC
.db $B8    ; G7
    .db $04
.db $E6
    .db $04
    .db $02
.db $C9    ; 
.db $80
.db $C9    ; 
.db $C8    ; 
.db $80
.db $C8    ; 
.db $C9    ; 
.db $80
.db $C9    ; 
.db $CB    ; 
.db $80
.db $CB    ; 
.db $E6
    .db $FC
.db $BA    ; A7
    .db $04
.db $E6
    .db $04
.db $C9    ; 
    .db $02
.db $C8    ; 
.db $80
.db $E6
    .db $FC
.db $BA    ; A7
.db $E6
    .db $04
.db $C6    ; A8
.db $80
.db $C6    ; A8
.db $E6
    .db $FC
.db $BA    ; A7
    .db $04
.db $E6
    .db $04
.db $C4    ; G8
    .db $02
.db $C6    ; A8
.db $80
.db $C6    ; A8
.db $C4    ; G8
.db $80
.db $C4    ; G8
.db $C6    ; A8
.db $80
.db $C6    ; A8
.db $C8    ; 
.db $80
.db $C8    ; 
.db $E6
    .db $FC
.db $B6    ; F7
    .db $04
.db $E6
    .db $04
.db $C9    ; 
    .db $02
.db $C5    ; Gs8
.db $80
.db $E6
    .db $FC
.db $B6    ; F7
.db $E6
    .db $04
.db $C9    ; 
.db $80
.db $C5    ; Gs8
.db $E6
    .db $FC
.db $B6    ; F7
    .db $04
.db $E6
    .db $04
.db $C5    ; Gs8
    .db $02
.db $CC    ; 
.db $80
.db $CC    ; 
.db $C9    ; 
.db $80
.db $C9    ; 
.db $C5    ; Gs8
.db $80
.db $C5    ; Gs8
.db $C2    ; F8
.db $80
.db $C2    ; F8
.db $E6
    .db $FC
.db $B8    ; G7
    .db $04
.db $E6
    .db $04
.db $C8    ; 
    .db $02
.db $C4    ; G8
.db $80
.db $E6
    .db $FC
.db $B8    ; G7
.db $E6
    .db $04
.db $C8    ; 
.db $80
.db $C4    ; G8
.db $E6
    .db $FC
.db $B8    ; G7
    .db $04
.db $E6
    .db $04
.db $C4    ; G8
    .db $02
.db $C6    ; A8
.db $80
.db $C4    ; G8
.db $E6
    .db $FC
.db $B8    ; G7
    .db $04
.db $E6
    .db $04
.db $C4    ; G8
    .db $02
.db $E6
    .db $FC
.db $BA    ; A7
    .db $04
.db $E6
    .db $04
.db $C6    ; A8
    .db $02
.db $E6
    .db $FC
.db $B8    ; G7
    .db $04
.db $E6
    .db $04
.db $C8    ; 
    .db $02
.db $E6
    .db $FC
.db $F5
    .db $0C
.db $F8
    .dw music_ending_bin_LABEL_B710
.db $B5    ; E7
.db $B5    ; E7
.db $B5    ; E7
.db $B5    ; E7
    .db $04
.db $B5    ; E7
    .db $06
.db $B5    ; E7
    .db $02
    .db $06
    .db $06
    .db $06
.db $B6    ; F7
.db $B6    ; F7
.db $B6    ; F7
.db $B6    ; F7
.db $B6    ; F7
.db $B6    ; F7
.db $B6    ; F7
.db $B6    ; F7
.db $B8    ; G7
.db $B8    ; G7
.db $B8    ; G7
.db $B8    ; G7
    .db $04
.db $B8    ; G7
    .db $06
.db $B8    ; G7
    .db $02
    .db $06
    .db $06
    .db $06
.db $F8
    .dw music_ending_bin_LABEL_B710
.db $B8    ; G7
.db $B8    ; G7
.db $B8    ; G7
.db $B8    ; G7
    .db $04
.db $B8    ; G7
    .db $06
.db $B8    ; G7
    .db $02
    .db $06
    .db $06
    .db $06
.db $B6    ; F7
    .db $15
.db $BD    ; C8
    .db $02
.db $C2    ; F8
    .db $04
.db $C4    ; G8
    .db $02
.db $C2    ; F8
    .db $07
.db $BD    ; C8
    .db $04
.db $C2    ; F8
.db $BD    ; C8
.db $B6    ; F7
    .db $30
music_ending_bin_LABEL_B56E:
.db $F8
    .dw music_ending_bin_LABEL_B59D
.db $F7
    .db $00
    .db $03
    .dw music_ending_bin_LABEL_B56E
.db $BF    ; D8
    .db $04
.db $E6
    .db $04
.db $C9    ; 
    .db $02
.db $C8    ; 
.db $80
.db $E6
    .db $FC
.db $BF    ; D8
.db $E6
    .db $04
.db $C9    ; 
.db $80
.db $C8    ; 
.db $E6
    .db $FC
.db $B8    ; G7
    .db $04
.db $E6
    .db $04
.db $C9    ; 
    .db $02
.db $C8    ; 
.db $80
.db $C9    ; 
.db $80
.db $CB    ; 
.db $E6
    .db $FC
.db $B8    ; G7
.db $BF    ; D8
    .db $06
.db $BE    ; Cs8
    .db $06
.db $BD    ; C8
    .db $30
.db $F2
music_ending_bin_LABEL_B59D:
.db $BF    ; D8
    .db $04
.db $E6
    .db $04
.db $C9    ; 
    .db $02
.db $C8    ; 
.db $80
.db $E6
    .db $FC
.db $BF    ; D8
.db $E6
    .db $04
.db $C9    ; 
.db $80
.db $C8    ; 
.db $E6
    .db $FC
.db $BF    ; D8
    .db $04
.db $E6
    .db $04
.db $C9    ; 
    .db $02
.db $C8    ; 
.db $80
.db $C9    ; 
.db $BF    ; D8
.db $CB    ; 
.db $E6
    .db $FC
.db $BF    ; D8
.db $B6    ; F7
    .db $04
.db $E6
    .db $04
.db $C9    ; 
    .db $02
.db $E6
    .db $FC
.db $B7    ; Fs7
    .db $04
.db $E6
    .db $04
.db $C8    ; 
    .db $02
.db $E6
    .db $FC
.db $B8    ; G7
    .db $04
.db $E6
    .db $04
.db $C9    ; 
    .db $02
.db $C8    ; 
.db $80
.db $E6
    .db $FC
.db $B8    ; G7
.db $E6
    .db $04
.db $C9    ; 
.db $80
.db $C8    ; 
.db $E6
    .db $FC
.db $B8    ; G7
    .db $04
.db $E6
    .db $04
.db $C9    ; 
    .db $02
.db $C8    ; 
.db $80
.db $C9    ; 
.db $80
.db $CB    ; 
.db $E6
    .db $FC
.db $B8    ; G7
.db $BD    ; C8
    .db $04
.db $E6
    .db $04
.db $C9    ; 
    .db $02
.db $E6
    .db $FC
.db $BE    ; Cs8
    .db $04
.db $E6
    .db $04
.db $C8    ; 
    .db $02
.db $E6
    .db $FC
.db $F9
music_ending_bin_LABEL_B5FE:
.db $BF    ; D8
    .db $04
.db $E6
    .db $04
.db $C9    ; 
    .db $02
.db $C8    ; 
.db $80
.db $E6
    .db $FC
.db $BF    ; D8
.db $E6
    .db $04
.db $C9    ; 
.db $80
.db $C8    ; 
.db $E6
    .db $FC
.db $BF    ; D8
    .db $04
.db $E6
    .db $04
.db $C9    ; 
    .db $02
.db $C8    ; 
.db $80
.db $C9    ; 
.db $80
.db $CB    ; 
.db $E6
    .db $FC
.db $BF    ; D8
.db $C2    ; F8
    .db $04
.db $E6
    .db $04
.db $C9    ; 
    .db $02
.db $E6
    .db $FC
.db $C3    ; Fs8
    .db $04
.db $E6
    .db $04
.db $C8    ; 
    .db $02
.db $E6
    .db $FC
.db $C4    ; G8
    .db $04
.db $E6
    .db $04
.db $C9    ; 
    .db $02
.db $C8    ; 
.db $80
.db $E6
    .db $FC
.db $BF    ; D8
.db $E6
    .db $04
.db $C9    ; 
.db $80
.db $C8    ; 
.db $E6
    .db $FC
.db $B8    ; G7
    .db $04
.db $E6
    .db $04
.db $C9    ; 
    .db $02
.db $C8    ; 
.db $80
.db $C9    ; 
.db $80
.db $CB    ; 
.db $E6
    .db $FC
.db $B8    ; G7
.db $BF    ; D8
    .db $04
.db $E6
    .db $04
.db $C6    ; A8
    .db $02
.db $E6
    .db $FC
.db $BE    ; Cs8
    .db $04
.db $E6
    .db $04
.db $C5    ; Gs8
    .db $02
.db $E6
    .db $FC
.db $F9
music_ending_bin_LABEL_B65F:
.db $BD    ; C8
    .db $04
.db $E6
    .db $04
.db $C4    ; G8
    .db $02
.db $C6    ; A8
.db $80
.db $E6
    .db $FC
.db $BD    ; C8
.db $E6
    .db $04
.db $C4    ; G8
.db $80
.db $C6    ; A8
.db $E6
    .db $FC
.db $BD    ; C8
    .db $04
.db $E6
    .db $04
.db $C4    ; G8
    .db $02
.db $C6    ; A8
.db $80
.db $C4    ; G8
.db $80
.db $CB    ; 
.db $E6
    .db $FC
.db $B8    ; G7
.db $BA    ; A7
    .db $04
.db $E6
    .db $04
.db $CD    ; 
    .db $02
.db $E6
    .db $FC
.db $B8    ; G7
    .db $04
.db $E6
    .db $04
.db $CB    ; 
    .db $02
.db $E6
    .db $FC
.db $BD    ; C8
    .db $04
.db $E6
    .db $04
.db $C4    ; G8
    .db $02
.db $C6    ; A8
.db $80
.db $E6
    .db $FC
.db $BD    ; C8
.db $E6
    .db $04
.db $C4    ; G8
.db $80
.db $C6    ; A8
.db $E6
    .db $FC
.db $BD    ; C8
    .db $04
.db $E6
    .db $04
.db $C4    ; G8
    .db $02
.db $C6    ; A8
.db $80
.db $C4    ; G8
.db $E6
    .db $FC
.db $C0    ; Ds8
    .db $12
.db $F9
music_ending_bin_LABEL_B6AF:
.db $BD    ; C8
    .db $04
.db $E6
    .db $04
.db $C4    ; G8
    .db $02
.db $C6    ; A8
.db $80
.db $E6
    .db $FC
.db $BD    ; C8
.db $E6
    .db $04
.db $C4    ; G8
.db $80
.db $C6    ; A8
.db $E6
    .db $FC
.db $BD    ; C8
    .db $04
.db $E6
    .db $04
.db $C4    ; G8
    .db $02
.db $C6    ; A8
.db $80
.db $C8    ; 
.db $CB    ; 
.db $80
.db $E6
    .db $FC
.db $B8    ; G7
.db $BA    ; A7
    .db $04
.db $E6
    .db $04
.db $CE    ; 
    .db $02
.db $E6
    .db $FC
.db $B8    ; G7
    .db $04
.db $E6
    .db $04
.db $CD    ; 
    .db $02
.db $E6
    .db $FC
.db $BD    ; C8
    .db $04
.db $E6
    .db $04
.db $C4    ; G8
    .db $02
.db $C6    ; A8
.db $80
.db $E6
    .db $FC
.db $BD    ; C8
.db $E6
    .db $04
.db $C4    ; G8
.db $80
.db $C6    ; A8
.db $E6
    .db $FC
.db $BD    ; C8
    .db $04
.db $E6
    .db $04
.db $C4    ; G8
    .db $02
.db $E6
    .db $FC
.db $BC    ; B7
    .db $04
.db $E6
    .db $04
.db $C2    ; F8
    .db $02
.db $C8    ; 
.db $80
.db $CB    ; 
.db $E6
    .db $FC
.db $B5    ; E7
    .db $04
.db $E6
    .db $04
.db $C5    ; Gs8
    .db $02
.db $C8    ; 
.db $80
.db $CE    ; 
.db $E6
    .db $FC
.db $F9
music_ending_bin_LABEL_B710:
.db $BD    ; C8
    .db $06
.db $BD    ; C8
.db $BD    ; C8
.db $BD    ; C8
.db $BD    ; C8
.db $BD    ; C8
.db $BD    ; C8
.db $BD    ; C8
.db $BF    ; D8
.db $BF    ; D8
.db $BF    ; D8
.db $BF    ; D8
    .db $04
.db $BF    ; D8
    .db $06
.db $BF    ; D8
    .db $02
    .db $06
    .db $06
    .db $06
.db $B5    ; E7
.db $B5    ; E7
.db $B5    ; E7
.db $B5    ; E7
.db $B5    ; E7
.db $B5    ; E7
.db $B5    ; E7
.db $B5    ; E7
.db $BA    ; A7
.db $BA    ; A7
.db $BA    ; A7
.db $BA    ; A7
    .db $04
.db $BA    ; A7
    .db $06
.db $BA    ; A7
    .db $02
    .db $06
    .db $06
    .db $06
.db $BF    ; D8
.db $BF    ; D8
.db $BF    ; D8
.db $BF    ; D8
.db $BF    ; D8
.db $BF    ; D8
.db $BF    ; D8
.db $BF    ; D8
.db $F9

music_ending_bin_Channel1:
.db $F5
    .db $14
music_ending_bin_LABEL_B744:
.db $C4    ; G8
    .db $12
.db $C2    ; F8
    .db $1E
.db $BF    ; D8
    .db $12
.db $C1    ; E8
.db $BF    ; D8
    .db $0C
.db $F7
    .db $00
    .db $02
    .dw music_ending_bin_LABEL_B744
.db $F5
    .db $06
.db $80
    .db $04
.db $80
    .db $0C
.db $C6    ; A8
    .db $06
.db $C9    ; 
.db $C9    ; 
.db $C6    ; A8
.db $C9    ; 
.db $C6    ; A8
.db $CD    ; 
.db $CB    ; 
    .db $0C
.db $C9    ; 
.db $CB    ; 
    .db $06
.db $C4    ; G8
    .db $0C
.db $80
.db $C6    ; A8
    .db $06
.db $C9    ; 
.db $C9    ; 
.db $C6    ; A8
.db $C9    ; 
.db $C6    ; A8
.db $CD    ; 
.db $CB    ; 
    .db $0C
.db $C9    ; 
.db $CB    ; 
    .db $12
.db $80
    .db $0C
.db $C6    ; A8
    .db $06
.db $C9    ; 
.db $C9    ; 
.db $C6    ; A8
.db $C9    ; 
.db $C6    ; A8
.db $D2    ; 
.db $D0    ; 
    .db $0C
.db $CD    ; 
.db $CD    ; 
    .db $06
    .db $06
.db $CE    ; 
.db $D0    ; 
    .db $2C
.db $F0
    .db $0A
    .db $01
    .db $03
    .db $03
.db $80
    .db $1E
.db $B7    ; Fs7
    .db $12
.db $F0
    .db $00
    .db $00
    .db $00
    .db $00
.db $80
    .db $04
.db $80
    .db $0C
.db $C6    ; A8
    .db $06
.db $C9    ; 
.db $C9    ; 
.db $C6    ; A8
.db $C9    ; 
.db $C6    ; A8
.db $CD    ; 
.db $CB    ; 
    .db $0C
.db $C9    ; 
.db $CB    ; 
    .db $06
.db $C4    ; G8
    .db $0C
.db $80
.db $C6    ; A8
    .db $06
.db $C9    ; 
.db $C9    ; 
.db $C6    ; A8
.db $C9    ; 
.db $C6    ; A8
.db $CD    ; 
.db $CB    ; 
    .db $0C
.db $C9    ; 
.db $CB    ; 
    .db $12
.db $80
    .db $0C
.db $C6    ; A8
    .db $06
.db $C9    ; 
.db $C9    ; 
.db $C6    ; A8
.db $C9    ; 
.db $C6    ; A8
.db $D2    ; 
.db $D0    ; 
    .db $0C
.db $CD    ; 
.db $CD    ; 
    .db $06
    .db $06
.db $CE    ; 
.db $D0    ; 
    .db $30
.db $80
    .db $24
.db $D5    ; 
    .db $06
.db $D4    ; 
    .db $02
.db $E6
    .db $01
.db $F0
    .db $15
    .db $02
    .db $01
    .db $04
.db $FB
    .db $F4
.db $D5    ; 
    .db $0C
.db $D4    ; 
.db $D0    ; 
    .db $06
.db $CD    ; 
.db $CE    ; 
.db $D0    ; 
.db $E7
    .db $06
.db $CB    ; 
.db $C8    ; 
    .db $18
.db $80
    .db $0C
.db $E6
    .db $FF
.db $FB
    .db $0C
.db $F0
    .db $00
    .db $00
    .db $00
    .db $00
.db $80
    .db $04
.db $D5    ; 
    .db $0C
.db $D4    ; 
.db $D2    ; 
    .db $06
.db $C9    ; 
.db $CB    ; 
.db $CD    ; 
.db $E7
    .db $0C
.db $80
    .db $0E
.db $E6
    .db $01
.db $FB
    .db $F4
.db $F0
    .db $15
    .db $02
    .db $01
    .db $04
.db $D0    ; 
    .db $06
.db $D4    ; 
.db $D3    ; 
.db $D2    ; 
    .db $0C
.db $C9    ; 
    .db $06
.db $CA    ; 
.db $CB    ; 
    .db $0C
.db $D0    ; 
    .db $06
.db $CE    ; 
.db $CD    ; 
.db $CB    ; 
.db $CD    ; 
.db $D9    ; 
    .db $0C
.db $E6
    .db $FF
.db $FB
    .db $0C
.db $F0
    .db $00
    .db $00
    .db $00
    .db $00
.db $80
    .db $04
.db $D2    ; 
    .db $06
.db $D4    ; 
.db $D5    ; 
.db $D5    ; 
    .db $0C
.db $D1    ; 
.db $D0    ; 
    .db $06
.db $CC    ; 
.db $CE    ; 
.db $D0    ; 
.db $E7
    .db $0C
.db $80
    .db $24
.db $80
    .db $18
.db $CD    ; 
    .db $06
.db $CE    ; 
.db $D0    ; 
.db $D2    ; 
.db $CE    ; 
    .db $12
.db $D5    ; 
.db $D4    ; 
    .db $06
.db $D2    ; 
.db $D0    ; 
    .db $0C
.db $C4    ; G8
    .db $06
.db $C6    ; A8
.db $C8    ; 
.db $C9    ; 
.db $CB    ; 
.db $CD    ; 
.db $E7
    .db $18
.db $80
    .db $06
.db $CD    ; 
.db $CD    ; 
.db $CD    ; 
.db $CE    ; 
.db $CD    ; 
.db $C9    ; 
.db $C6    ; A8
    .db $12
    .db $06
    .db $06
.db $C8    ; 
.db $C9    ; 
.db $CB    ; 
.db $CD    ; 
    .db $0C
.db $CB    ; 
    .db $06
.db $CD    ; 
.db $CE    ; 
.db $E7
    .db $0C
.db $CD    ; 
.db $CE    ; 
    .db $06
.db $CD    ; 
.db $CB    ; 
.db $C9    ; 
.db $E7
    .db $06
.db $CB    ; 
.db $CB    ; 
    .db $20
.db $F0
    .db $15
    .db $02
    .db $01
    .db $04
.db $80
    .db $18
.db $C9    ; 
    .db $06
.db $CB    ; 
.db $CD    ; 
.db $CE    ; 
.db $CB    ; 
    .db $12
.db $D2    ; 
.db $D0    ; 
    .db $06
.db $CE    ; 
.db $CD    ; 
    .db $0C
.db $C1    ; E8
    .db $06
.db $C2    ; F8
.db $C4    ; G8
.db $C6    ; A8
.db $C9    ; 
.db $D0    ; 
.db $E7
    .db $06
.db $CD    ; 
    .db $12
.db $80
    .db $06
.db $C9    ; 
.db $C9    ; 
.db $C9    ; 
.db $CB    ; 
.db $C9    ; 
.db $C8    ; 
.db $C6    ; A8
    .db $12
    .db $06
.db $C4    ; G8
.db $C2    ; F8
.db $C1    ; E8
.db $BF    ; D8
.db $E7
    .db $0C
.db $BF    ; D8
    .db $06
.db $C1    ; E8
.db $C2    ; F8
.db $C2    ; F8
    .db $12
    .db $1E
.db $E7
    .db $24
.db $80
    .db $0C
music_ending_bin_LABEL_B8AB:
.db $C4    ; G8
    .db $12
.db $C2    ; F8
    .db $1E
.db $BF    ; D8
    .db $12
.db $C1    ; E8
.db $BF    ; D8
    .db $0C
.db $F7
    .db $00
    .db $03
    .dw music_ending_bin_LABEL_B8AB
.db $C4    ; G8
    .db $12
.db $C2    ; F8
.db $BF    ; D8
    .db $0C
.db $C1    ; E8
    .db $30
.db $F2

music_ending_bin_Channel3:
.db $80
    .db $30
.db $80
.db $80
.db $E4
    .db $07
music_ending_bin_LABEL_B8C7:
.db $81    ; C3
    .db $02
    .db $02
.db $E4
    .db $FF
.db $F7
    .db $00
    .db $07
    .dw music_ending_bin_LABEL_B8C7
.db $81    ; C3
    .db $02
.db $88    ; G3
    .db $06
.db $88    ; G3
    .db $04
    .db $02
.db $84    ; Ds3
    .db $06
music_ending_bin_LABEL_B8DA:
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
.db $84    ; Ds3
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
.db $88    ; G3
    .db $04
.db $81    ; C3
    .db $02
.db $81    ; C3
    .db $02
.db $81    ; C3
.db $81    ; C3
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
.db $84    ; Ds3
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
.db $88    ; G3
    .db $04
.db $81    ; C3
    .db $02
.db $81    ; C3
    .db $04
.db $88    ; G3
    .db $02
.db $F7
    .db $00
    .db $17
    .dw music_ending_bin_LABEL_B8DA
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
.db $84    ; Ds3
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
.db $88    ; G3
    .db $04
.db $81    ; C3
    .db $02
.db $81    ; C3
    .db $02
.db $81    ; C3
.db $81    ; C3
.db $A0    ; G5
    .db $06
.db $80
    .db $2A
.db $84    ; Ds3
    .db $06
.db $F2


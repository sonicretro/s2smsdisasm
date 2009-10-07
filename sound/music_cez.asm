music_cez_bin:
.dw $8A2F
.db $04        ;num channels
.db $00
.db $02
.db $00

music_cez_bin_Channel0_Header:
.dw music_cez_bin_Channel0
.db $FF        ; pitch adjustment
.db $04        ; volume adjustment

music_cez_bin_Channel1_Header:
.dw music_cez_bin_Channel1
.db $FF        ; pitch adjustment
.db $04        ; volume adjustment

music_cez_bin_Channel2_Header:
.dw music_cez_bin_Channel2
.db $FF        ; pitch adjustment
.db $04        ; volume adjustment

music_cez_bin_Channel3_Header:
.dw music_cez_bin_Channel3
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

music_cez_bin_Channel0:
music_cez_bin_LABEL_982F:
.db $F5
    .db $08
.db $A0    ; G5
    .db $02
.db $A7    ; D6
.db $A4    ; B5
.db $A5    ; C6
.db $A7    ; D6
    .db $08
.db $A7    ; D6
    .db $02
.db $A5    ; C6
.db $A2    ; A5
.db $A4    ; B5
.db $A0    ; G5
    .db $08
.db $F7
    .db $00
    .db $04
    .dw music_cez_bin_LABEL_982F
music_cez_bin_LABEL_9844:
.db $9E    ; F5
    .db $02
.db $A5    ; C6
.db $A2    ; A5
.db $A3    ; As5
.db $A5    ; C6
    .db $08
.db $A5    ; C6
    .db $02
.db $A3    ; As5
.db $A0    ; G5
.db $A2    ; A5
.db $9E    ; F5
    .db $08
.db $F7
    .db $00
    .db $04
    .dw music_cez_bin_LABEL_9844
music_cez_bin_LABEL_9857:
.db $A0    ; G5
    .db $02
.db $A7    ; D6
.db $A4    ; B5
.db $A5    ; C6
.db $A7    ; D6
    .db $08
.db $A7    ; D6
    .db $02
.db $A5    ; C6
.db $A2    ; A5
.db $A4    ; B5
.db $A0    ; G5
    .db $08
.db $F7
    .db $00
    .db $04
    .dw music_cez_bin_LABEL_9857
music_cez_bin_LABEL_986A:
.db $9E    ; F5
    .db $02
.db $A5    ; C6
.db $A2    ; A5
.db $A3    ; As5
.db $A5    ; C6
    .db $08
.db $A5    ; C6
    .db $02
.db $A3    ; As5
.db $A0    ; G5
.db $A2    ; A5
.db $9E    ; F5
    .db $08
.db $F7
    .db $00
    .db $04
    .dw music_cez_bin_LABEL_986A
music_cez_bin_LABEL_987D:
.db $F8
    .dw music_cez_bin_LABEL_98F7
.db $A4    ; B5
    .db $10
.db $F8
    .dw music_cez_bin_LABEL_98F7
.db $A4    ; B5
    .db $08
.db $A5    ; C6
.db $F8
    .dw music_cez_bin_LABEL_9904
.db $A2    ; A5
    .db $08
.db $99    ; C5
.db $F8
    .dw music_cez_bin_LABEL_9904
.db $A2    ; A5
    .db $10
.db $F8
    .dw music_cez_bin_LABEL_98F7
.db $A4    ; B5
    .db $10
.db $F8
    .dw music_cez_bin_LABEL_98F7
.db $A4    ; B5
    .db $08
.db $A9    ; E6
.db $F8
    .dw music_cez_bin_LABEL_9910
.db $A2    ; A5
    .db $08
.db $A9    ; E6
.db $F8
    .dw music_cez_bin_LABEL_9910
.db $A2    ; A5
    .db $10
.db $F7
    .db $00
    .db $02
    .dw music_cez_bin_LABEL_987D
.db $F8
    .dw music_cez_bin_LABEL_991E
.db $9B    ; D5
    .db $08
.db $9B    ; D5
.db $9B    ; D5
    .db $04
.db $F8
    .dw music_cez_bin_LABEL_991E
.db $A4    ; B5
    .db $08
.db $A4    ; B5
.db $A4    ; B5
    .db $04
.db $F8
    .dw music_cez_bin_LABEL_991E
.db $9B    ; D5
    .db $08
.db $9B    ; D5
.db $9B    ; D5
    .db $04
.db $F8
    .dw music_cez_bin_LABEL_991E
.db $A7    ; D6
    .db $08
.db $A7    ; D6
.db $A7    ; D6
    .db $04
.db $F8
    .dw music_cez_bin_LABEL_991E
.db $9B    ; D5
    .db $08
.db $9B    ; D5
.db $9B    ; D5
    .db $04
.db $F8
    .dw music_cez_bin_LABEL_991E
.db $A4    ; B5
    .db $08
.db $A4    ; B5
.db $A4    ; B5
    .db $04
.db $F8
    .dw music_cez_bin_LABEL_991E
.db $A4    ; B5
    .db $08
.db $A4    ; B5
.db $A4    ; B5
    .db $04
.db $A7    ; D6
    .db $08
.db $A7    ; D6
.db $A7    ; D6
.db $A7    ; D6
    .db $04
.db $A7    ; D6
    .db $08
.db $A7    ; D6
    .db $04
.db $A7    ; D6
    .db $08
.db $A7    ; D6
.db $A7    ; D6
.db $F6
    .dw music_cez_bin_LABEL_9857
music_cez_bin_LABEL_98F7:
.db $80
    .db $08
.db $9B    ; D5
.db $A4    ; B5
.db $9B    ; D5
    .db $04
.db $A4    ; B5
    .db $08
.db $A4    ; B5
    .db $04
.db $9B    ; D5
    .db $08
.db $F9
music_cez_bin_LABEL_9904:
.db $A5    ; C6
    .db $08
.db $A4    ; B5
.db $A2    ; A5
    .db $0C
.db $A2    ; A5
    .db $08
.db $A2    ; A5
    .db $04
.db $9B    ; D5
    .db $08
.db $F9
music_cez_bin_LABEL_9910:
.db $A9    ; E6
    .db $08
.db $9B    ; D5
.db $A2    ; A5
    .db $0C
.db $A2    ; A5
    .db $04
.db $80
    .db $04
.db $A2    ; A5
    .db $04
.db $A7    ; D6
    .db $08
.db $F9
music_cez_bin_LABEL_991E:
.db $A0    ; G5
    .db $04
.db $A2    ; A5
.db $A0    ; G5
.db $A2    ; A5
    .db $08
.db $A2    ; A5
.db $A2    ; A5
    .db $04
.db $A0    ; G5
.db $A2    ; A5
.db $A0    ; G5
.db $F9

music_cez_bin_Channel2:
music_cez_bin_LABEL_992B:
.db $F5
    .db $08
.db $A9    ; E6
    .db $04
.db $AA    ; F6
    .db $08
.db $AE    ; A6
    .db $04
.db $80
    .db $08
.db $AC    ; G6
.db $80
    .db $04
.db $AC    ; G6
    .db $0C
.db $AC    ; G6
    .db $08
.db $AC    ; G6
.db $F7
    .db $00
    .db $04
    .dw music_cez_bin_LABEL_992B
music_cez_bin_LABEL_9942:
.db $F5
    .db $07
.db $F8
    .dw music_cez_bin_LABEL_9997
music_cez_bin_LABEL_9947:
.db $F8
    .dw music_cez_bin_LABEL_9997
.db $F7
    .db $00
    .db $04
    .dw music_cez_bin_LABEL_9947
music_cez_bin_LABEL_994F:
.db $88    ; G3
    .db $04
.db $88    ; G3
.db $88    ; G3
    .db $08
.db $88    ; G3
.db $88    ; G3
    .db $04
.db $8A    ; A3
    .db $08
.db $8A    ; A3
.db $8A    ; A3
.db $8A    ; A3
    .db $04
.db $8A    ; A3
.db $8A    ; A3
.db $8C    ; B3
    .db $04
.db $8C    ; B3
.db $8C    ; B3
    .db $08
.db $8C    ; B3
.db $8C    ; B3
    .db $04
.db $8D    ; C4
    .db $08
.db $8D    ; C4
.db $8D    ; C4
.db $88    ; G3
    .db $04
.db $88    ; G3
.db $88    ; G3
.db $F7
    .db $00
    .db $03
    .dw music_cez_bin_LABEL_994F
.db $8F    ; D4
    .db $04
.db $8F    ; D4
.db $8F    ; D4
    .db $08
.db $8F    ; D4
.db $83    ; D3
    .db $04
.db $8F    ; D4
    .db $08
.db $8F    ; D4
.db $8F    ; D4
.db $83    ; D3
    .db $04
.db $83    ; D3
.db $83    ; D3
.db $8F    ; D4
    .db $04
.db $8F    ; D4
.db $8F    ; D4
    .db $08
.db $8F    ; D4
.db $83    ; D3
    .db $04
.db $8F    ; D4
    .db $08
.db $8F    ; D4
.db $8F    ; D4
.db $8F    ; D4
    .db $04
.db $8F    ; D4
.db $8F    ; D4
.db $F6
    .dw music_cez_bin_LABEL_9942
music_cez_bin_LABEL_9997:
.db $88    ; G3
    .db $04
.db $88    ; G3
.db $88    ; G3
    .db $08
.db $88    ; G3
.db $88    ; G3
    .db $04
.db $88    ; G3
    .db $08
.db $88    ; G3
    .db $04
.db $88    ; G3
    .db $08
.db $88    ; G3
.db $83    ; D3
.db $88    ; G3
    .db $04
.db $88    ; G3
.db $88    ; G3
    .db $08
.db $88    ; G3
.db $88    ; G3
    .db $04
.db $88    ; G3
    .db $08
.db $88    ; G3
    .db $04
.db $88    ; G3
    .db $08
.db $88    ; G3
.db $83    ; D3
.db $86    ; F3
    .db $04
.db $86    ; F3
.db $86    ; F3
    .db $08
.db $86    ; F3
.db $86    ; F3
    .db $04
.db $86    ; F3
    .db $08
.db $86    ; F3
    .db $04
.db $86    ; F3
    .db $08
.db $86    ; F3
.db $81    ; C3
.db $86    ; F3
    .db $04
.db $86    ; F3
.db $86    ; F3
    .db $08
.db $86    ; F3
.db $86    ; F3
    .db $04
.db $86    ; F3
    .db $08
.db $86    ; F3
    .db $04
.db $86    ; F3
    .db $08
.db $86    ; F3
.db $81    ; C3
    .db $04
.db $86    ; F3
.db $F9

music_cez_bin_Channel1:
music_cez_bin_LABEL_99DA:
.db $F5
    .db $06
.db $8F    ; D4
    .db $04
.db $98    ; B4
.db $94    ; G4
.db $96    ; A4
.db $9B    ; D5
    .db $10
.db $9B    ; D5
    .db $04
.db $99    ; C5
.db $98    ; B4
.db $99    ; C5
.db $94    ; G4
    .db $10
.db $F7
    .db $00
    .db $02
    .dw music_cez_bin_LABEL_99DA
music_cez_bin_LABEL_99EF:
.db $8D    ; C4
    .db $04
.db $96    ; A4
.db $92    ; F4
.db $94    ; G4
.db $99    ; C5
    .db $10
.db $99    ; C5
    .db $04
.db $97    ; As4
.db $96    ; A4
.db $97    ; As4
.db $92    ; F4
    .db $10
.db $F7
    .db $00
    .db $02
    .dw music_cez_bin_LABEL_99EF
music_cez_bin_LABEL_9A02:
.db $8F    ; D4
    .db $04
.db $98    ; B4
.db $94    ; G4
.db $96    ; A4
.db $9B    ; D5
    .db $10
.db $9B    ; D5
    .db $04
.db $99    ; C5
.db $98    ; B4
.db $99    ; C5
.db $94    ; G4
    .db $10
.db $F7
    .db $00
    .db $02
    .dw music_cez_bin_LABEL_9A02
music_cez_bin_LABEL_9A15:
.db $8D    ; C4
    .db $04
.db $96    ; A4
.db $92    ; F4
.db $94    ; G4
.db $99    ; C5
    .db $10
.db $99    ; C5
    .db $04
.db $97    ; As4
.db $96    ; A4
.db $97    ; As4
.db $92    ; F4
    .db $10
.db $F7
    .db $00
    .db $02
    .dw music_cez_bin_LABEL_9A15
music_cez_bin_LABEL_9A28:
.db $F5
    .db $08
.db $F8
    .dw music_cez_bin_LABEL_9ABE
.db $A0    ; G5
    .db $10
.db $F8
    .dw music_cez_bin_LABEL_9ABE
.db $A0    ; G5
    .db $08
.db $A2    ; A5
.db $F8
    .dw music_cez_bin_LABEL_9ACB
.db $9E    ; F5
    .db $08
.db $A2    ; A5
.db $F8
    .dw music_cez_bin_LABEL_9ACB
.db $9E    ; F5
    .db $10
.db $F8
    .dw music_cez_bin_LABEL_9ABE
.db $A0    ; G5
    .db $10
.db $F8
    .dw music_cez_bin_LABEL_9ABE
.db $A0    ; G5
    .db $08
.db $A5    ; C6
.db $F8
    .dw music_cez_bin_LABEL_9AD7
.db $9E    ; F5
    .db $08
.db $A5    ; C6
.db $F8
    .dw music_cez_bin_LABEL_9AD7
.db $9E    ; F5
    .db $10
.db $F7
    .db $00
    .db $02
    .dw music_cez_bin_LABEL_9A28
.db $F5
    .db $06
.db $9B    ; D5
    .db $08
.db $99    ; C5
    .db $04
.db $98    ; B4
.db $94    ; G4
    .db $30
.db $9B    ; D5
    .db $08
.db $99    ; C5
    .db $04
.db $98    ; B4
.db $94    ; G4
    .db $08
.db $91    ; E4
    .db $04
.db $8F    ; D4
    .db $20
.db $80
    .db $04
.db $9B    ; D5
    .db $08
.db $99    ; C5
    .db $04
.db $98    ; B4
.db $94    ; G4
    .db $30
.db $9B    ; D5
    .db $08
.db $99    ; C5
    .db $04
.db $98    ; B4
.db $94    ; G4
    .db $08
.db $9D    ; E5
    .db $04
.db $9B    ; D5
    .db $20
.db $80
    .db $04
.db $9B    ; D5
    .db $08
.db $99    ; C5
    .db $04
.db $98    ; B4
.db $94    ; G4
    .db $30
.db $9B    ; D5
    .db $08
.db $99    ; C5
    .db $04
.db $98    ; B4
.db $94    ; G4
    .db $08
.db $91    ; E4
    .db $04
.db $8F    ; D4
    .db $20
.db $80
    .db $04
.db $9B    ; D5
    .db $08
.db $99    ; C5
    .db $04
.db $98    ; B4
.db $9B    ; D5
    .db $08
.db $99    ; C5
    .db $04
.db $98    ; B4
.db $9B    ; D5
    .db $08
.db $99    ; C5
    .db $04
.db $98    ; B4
.db $9B    ; D5
    .db $08
.db $99    ; C5
    .db $04
.db $98    ; B4
.db $9B    ; D5
    .db $08
.db $8F    ; D4
.db $9B    ; D5
.db $8F    ; D4
.db $9B    ; D5
    .db $04
.db $8F    ; D4
.db $9B    ; D5
.db $8F    ; D4
.db $9B    ; D5
.db $8F    ; D4
.db $9B    ; D5
.db $8F    ; D4
.db $F6
    .dw music_cez_bin_LABEL_9A02
music_cez_bin_LABEL_9ABE:
.db $80
    .db $10
.db $A0    ; G5
    .db $08
.db $80
    .db $04
.db $A0    ; G5
    .db $08
.db $A0    ; G5
    .db $04
.db $80
    .db $08
.db $F9
music_cez_bin_LABEL_9ACB:
.db $A2    ; A5
    .db $08
.db $A0    ; G5
.db $9E    ; F5
    .db $0C
.db $9E    ; F5
    .db $08
.db $9E    ; F5
    .db $04
.db $80
    .db $08
.db $F9
music_cez_bin_LABEL_9AD7:
.db $A5    ; C6
    .db $08
.db $A4    ; B5
.db $9E    ; F5
    .db $0C
.db $9E    ; F5
    .db $04
.db $80
    .db $04
.db $9E    ; F5
    .db $04
.db $80
    .db $08
.db $F9

music_cez_bin_Channel3:
music_cez_bin_LABEL_9AE5:
.db $80
    .db $40
.db $F7
    .db $00
    .db $04
    .dw music_cez_bin_LABEL_9AE5
music_cez_bin_LABEL_9AEC:
.db $84    ; Ds3
    .db $04
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $F7
    .db $00
    .db $0C
    .dw music_cez_bin_LABEL_9AEC
.db $81    ; C3
    .db $04
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $80
    .db $04
.db $88    ; G3
    .db $04
.db $88    ; G3
    .db $08
.db $88    ; G3
.db $88    ; G3
    .db $04
.db $88    ; G3
music_cez_bin_LABEL_9B09:
.db $84    ; Ds3
    .db $04
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $84    ; Ds3
    .db $04
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $84    ; Ds3
    .db $04
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $84    ; Ds3
    .db $04
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $88    ; G3
.db $81    ; C3
.db $88    ; G3
.db $84    ; Ds3
    .db $04
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $84    ; Ds3
    .db $04
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $84    ; Ds3
    .db $04
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $84    ; Ds3
    .db $04
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $88    ; G3
.db $81    ; C3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $F7
    .db $00
    .db $03
    .dw music_cez_bin_LABEL_9B09
.db $F6
    .dw music_cez_bin_LABEL_9AEC


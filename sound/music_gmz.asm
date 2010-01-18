music_gmz_bin:
.dw $8A2F
.db $04        ;num channels
.db $00
.db $02
.db $05

music_gmz_bin_Channel0_Header:
.dw music_gmz_bin_Channel0
.db $FF        ; pitch adjustment
.db $03        ; volume adjustment

music_gmz_bin_Channel1_Header:
.dw music_gmz_bin_Channel1
.db $FF        ; pitch adjustment
.db $04        ; volume adjustment

music_gmz_bin_Channel2_Header:
.dw music_gmz_bin_Channel2
.db $FF        ; pitch adjustment
.db $03        ; volume adjustment

music_gmz_bin_Channel3_Header:
.dw music_gmz_bin_Channel3
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

music_gmz_bin_Channel0:
.db $E0
    .db $02     ; vol decrement step
    .db $03     ; vol increment step
    .db $FF     ; max vol
    .db $02
    .db $01
.db $97    ; As4
    .db $30
.db $E0
    .db $00
    .db $00
    .db $00
    .db $00
    .db $00
music_gmz_bin_LABEL_9501:
.db $F8
    .dw music_gmz_bin_LABEL_958A
.db $F8
    .dw music_gmz_bin_LABEL_958A
.db $FB
    .db $01
.db $F8
    .dw music_gmz_bin_LABEL_958A
.db $F8
    .dw music_gmz_bin_LABEL_958A
.db $FB
    .db $FF
.db $FB
    .db $13
.db $F8
    .dw music_gmz_bin_LABEL_960B
.db $FB
    .db $ED
.db $E6
    .db $02
music_gmz_bin_LABEL_951A:
.db $F5
    .db $06
.db $99    ; C5
    .db $06
.db $A0    ; G5
    .db $03
.db $99    ; C5
.db $A2    ; A5
    .db $06
.db $99    ; C5
    .db $03
.db $A3    ; As5
    .db $06
.db $99    ; C5
    .db $03
.db $A5    ; C6
    .db $12
.db $F7
    .db $00
    .db $04
    .dw music_gmz_bin_LABEL_951A
.db $FB
    .db $01
.db $F7
    .db $01
    .db $02
    .dw music_gmz_bin_LABEL_951A
.db $FB
    .db $FE
.db $F8
    .dw music_gmz_bin_LABEL_9561
music_gmz_bin_LABEL_953C:
.db $F5
    .db $06
.db $99    ; C5
    .db $06
.db $A0    ; G5
    .db $03
.db $99    ; C5
.db $A2    ; A5
    .db $06
.db $99    ; C5
    .db $03
.db $A3    ; As5
    .db $06
.db $99    ; C5
    .db $03
.db $A5    ; C6
    .db $12
.db $F7
    .db $00
    .db $04
    .dw music_gmz_bin_LABEL_953C
.db $FB
    .db $01
.db $F7
    .db $01
    .db $02
    .dw music_gmz_bin_LABEL_953C
.db $FB
    .db $FE
.db $E6
    .db $FE
.db $F6
    .dw music_gmz_bin_LABEL_9501
.db $F2
music_gmz_bin_LABEL_9561:
.db $F5
    .db $06
.db $99    ; C5
    .db $03
.db $94    ; G4
.db $97    ; As4
.db $9C    ; Ds5
.db $99    ; C5
.db $E6
    .db $02
.db $99    ; C5
.db $E6
    .db $FE
.db $F7
    .db $00
    .db $05
    .dw music_gmz_bin_LABEL_9561
.db $E6
    .db $04
.db $99    ; C5
.db $E6
    .db $02
.db $99    ; C5
.db $E6
    .db $FA
.db $F7
    .db $01
    .db $02
    .dw music_gmz_bin_LABEL_9561
.db $FB
    .db $01
.db $F7
    .db $02
    .db $02
    .dw music_gmz_bin_LABEL_9561
.db $FB
    .db $FE
.db $F9
music_gmz_bin_LABEL_958A:
.db $E6
    .db $08
music_gmz_bin_LABEL_958C:
.db $F5
    .db $03
.db $94    ; G4
    .db $03
.db $94    ; G4
.db $E6
    .db $FF
.db $F7
    .db $00
    .db $08
    .dw music_gmz_bin_LABEL_958C
music_gmz_bin_LABEL_9598:
.db $94    ; G4
.db $F7
    .db $00
    .db $08
    .dw music_gmz_bin_LABEL_9598
.db $F5
    .db $08
.db $95    ; Gs4
    .db $01
.db $96    ; A4
.db $97    ; As4
    .db $0A
.db $95    ; Gs4
    .db $0C
.db $F9

music_gmz_bin_Channel2:
.db $E0
    .db $02
    .db $03
    .db $FF
    .db $02
    .db $01
.db $88    ; G3
    .db $30
.db $E0
    .db $00
    .db $00
    .db $00
    .db $00
    .db $00
music_gmz_bin_LABEL_95B6:
.db $F8
    .dw music_gmz_bin_LABEL_95E2
.db $F8
    .dw music_gmz_bin_LABEL_95E2
.db $FB
    .db $01
.db $F8
    .dw music_gmz_bin_LABEL_95E2
.db $F8
    .dw music_gmz_bin_LABEL_95E2
.db $FB
    .db $FF
.db $F8
    .dw music_gmz_bin_LABEL_960B
music_gmz_bin_LABEL_95C9:
.db $F8
    .dw music_gmz_bin_LABEL_95E2
.db $F8
    .dw music_gmz_bin_LABEL_95E2
.db $FB
    .db $01
.db $F8
    .dw music_gmz_bin_LABEL_95E2
.db $F8
    .dw music_gmz_bin_LABEL_95E2
.db $FB
    .db $FF
.db $F7
    .db $02
    .db $03
    .dw music_gmz_bin_LABEL_95C9
.db $F6
    .dw music_gmz_bin_LABEL_95B6
.db $F2
music_gmz_bin_LABEL_95E2:
.db $F5
    .db $04
.db $81    ; C3
    .db $06
.db $84    ; Ds3
.db $81    ; C3
    .db $03
.db $88    ; G3
    .db $06
.db $81    ; C3
    .db $03
.db $84    ; Ds3
    .db $06
.db $81    ; C3
    .db $03
.db $88    ; G3
    .db $06
.db $81    ; C3
    .db $03
.db $84    ; Ds3
    .db $06
.db $81    ; C3
    .db $06
.db $84    ; Ds3
.db $81    ; C3
    .db $03
.db $88    ; G3
    .db $06
.db $81    ; C3
    .db $03
.db $84    ; Ds3
    .db $06
.db $81    ; C3
    .db $03
.db $87    ; Fs3
    .db $06
.db $81    ; C3
    .db $03
.db $84    ; Ds3
    .db $06
.db $F9

music_gmz_bin_LABEL_960B:
.db $F5
    .db $03
.db $81    ; C3
    .db $03
.db $E6
    .db $04
.db $81    ; C3
.db $E6
    .db $FC
music_gmz_bin_LABEL_9614:
.db $81    ; C3
.db $E6
    .db $02
.db $81    ; C3
.db $E6
    .db $02
.db $81    ; C3
.db $E6
    .db $FC
.db $F7
    .db $00
    .db $04
    .dw music_gmz_bin_LABEL_9614
.db $82    ; Cs3
.db $E6
    .db $02
.db $82    ; Cs3
.db $E6
    .db $FE
.db $81    ; C3
.db $E6
    .db $04
.db $81    ; C3
.db $E6
    .db $FC
music_gmz_bin_LABEL_962E:
.db $81    ; C3
.db $E6
    .db $02
.db $81    ; C3
.db $E6
    .db $02
.db $81    ; C3
.db $E6
    .db $FC
.db $F7
    .db $00
    .db $04
    .dw music_gmz_bin_LABEL_962E
.db $84    ; Ds3
.db $E6
    .db $02
.db $84    ; Ds3
.db $E6
    .db $FE
.db $F5
    .db $03
.db $81    ; C3
    .db $03
.db $E6
    .db $04
.db $81    ; C3
.db $E6
    .db $FC
music_gmz_bin_LABEL_964B:
.db $81    ; C3
.db $E6
    .db $02
.db $81    ; C3
.db $E6
    .db $02
.db $81    ; C3
.db $E6
    .db $FC
.db $F7
    .db $00
    .db $04
    .dw music_gmz_bin_LABEL_964B
.db $82    ; Cs3
.db $E6
    .db $02
.db $82    ; Cs3
.db $E6
    .db $FE
.db $81    ; C3
.db $E6
    .db $04
.db $81    ; C3
.db $E6
    .db $FC
.db $81    ; C3
.db $E6
    .db $02
.db $81    ; C3
.db $E6
    .db $02
.db $81    ; C3
.db $E6
    .db $FC
.db $81    ; C3
.db $E6
    .db $02
.db $81    ; C3
.db $E6
    .db $FE
.db $84    ; Ds3
.db $E6
    .db $02
.db $84    ; Ds3
.db $E6
    .db $02
.db $84    ; Ds3
.db $E6
    .db $FC
.db $84    ; Ds3
.db $E6
    .db $02
.db $84    ; Ds3
.db $E6
    .db $FE
.db $82    ; Cs3
.db $E6
    .db $02
.db $82    ; Cs3
.db $E6
    .db $FE
.db $82    ; Cs3
.db $E6
    .db $02
.db $82    ; Cs3
.db $E6
    .db $FE
.db $F7
    .db $01
    .db $02
    .dw music_gmz_bin_LABEL_960B
.db $F9

music_gmz_bin_Channel1:
.db $E0
    .db $02
    .db $03
    .db $FF
    .db $02
    .db $01
.db $92    ; F4
    .db $30
.db $E0
    .db $00
    .db $00
    .db $00
    .db $00
    .db $00
music_gmz_bin_LABEL_96A3:
    Branch          music_gmz_bin_LABEL_9723
    Branch          music_gmz_bin_LABEL_9723
    PitchAdjust     1
    Branch          music_gmz_bin_LABEL_9723
    Branch          music_gmz_bin_LABEL_9723
    PitchAdjust     -1
    PitchAdjust     12
    Branch          music_gmz_bin_LABEL_9741
    PitchAdjust     -12
    AdjustVolume    2
music_gmz_bin_LABEL_96BC:
.db $F5
    .db $06
.db $94    ; G4
    .db $06
.db $99    ; C5
    .db $03
.db $94    ; G4
.db $9B    ; D5
    .db $06
.db $94    ; G4
    .db $03
.db $9C    ; Ds5
    .db $06
.db $94    ; G4
    .db $03
.db $F5
    .db $04
.db $E8
    .db $03
.db $B1    ; C7
    .db $06
.db $E6
    .db $02
.db $B1    ; C7
.db $E6
    .db $02
.db $B1    ; C7
.db $E6
    .db $FC
.db $E8
    .db $00
.db $F7
    .db $00
    .db $04
    .dw music_gmz_bin_LABEL_96BC
.db $FB
    .db $01
.db $F7
    .db $01
    .db $02
    .dw music_gmz_bin_LABEL_96BC
.db $FB
    .db $FE
.db $FB
    .db $FB
.db $F8
    .dw music_gmz_bin_LABEL_9561
.db $FB
    .db $05
music_gmz_bin_LABEL_96F0:
.db $F5
    .db $06
.db $94    ; G4
    .db $06
.db $99    ; C5
    .db $03
.db $94    ; G4
.db $9B    ; D5
    .db $06
.db $94    ; G4
    .db $03
.db $9C    ; Ds5
    .db $06
.db $94    ; G4
    .db $03
.db $F5
    .db $04
.db $E8
    .db $03
.db $B1    ; C7
    .db $06
.db $E6
    .db $02
.db $B1    ; C7
.db $E6
    .db $02
.db $B1    ; C7
.db $E6
    .db $FC
.db $E8
    .db $00
.db $F7
    .db $00
    .db $04
    .dw music_gmz_bin_LABEL_96F0
.db $FB
    .db $01
.db $F7
    .db $01
    .db $02
    .dw music_gmz_bin_LABEL_96F0
.db $FB
    .db $FE
.db $E6
    .db $FE
.db $F6
    .dw music_gmz_bin_LABEL_96A3
.db $F2
music_gmz_bin_LABEL_9723:
.db $E6
    .db $08
music_gmz_bin_LABEL_9725:
.db $F5
    .db $03
.db $8F    ; D4
    .db $03
.db $8F    ; D4
.db $E6
    .db $FF
.db $F7
    .db $00
    .db $08
    .dw music_gmz_bin_LABEL_9725
music_gmz_bin_LABEL_9731:
.db $8F    ; D4
.db $F7
    .db $00
    .db $08
    .dw music_gmz_bin_LABEL_9731
.db $F5
    .db $08
.db $90    ; Ds4
    .db $01
.db $91    ; E4
.db $92    ; F4
    .db $0A
.db $90    ; Ds4
    .db $0C
.db $F9
music_gmz_bin_LABEL_9741:
.db $F5
    .db $03
.db $80
    .db $06
music_gmz_bin_LABEL_9745:
.db $84    ; Ds3
    .db $03
.db $E6
    .db $02
.db $84    ; Ds3
.db $E6
    .db $02
.db $84    ; Ds3
.db $E6
    .db $FC
.db $F7
    .db $00
    .db $04
    .dw music_gmz_bin_LABEL_9745
.db $86    ; F3
.db $E6
    .db $02
.db $86    ; F3
.db $E6
    .db $FE
.db $80
    .db $06
music_gmz_bin_LABEL_975C:
.db $84    ; Ds3
    .db $03
.db $E6
    .db $02
.db $84    ; Ds3
.db $E6
    .db $02
.db $84    ; Ds3
.db $E6
    .db $FC
.db $F7
    .db $00
    .db $04
    .dw music_gmz_bin_LABEL_975C
.db $88    ; G3
.db $E6
    .db $02
.db $88    ; G3
.db $E6
    .db $FE
.db $F5
    .db $03
.db $84    ; Ds3
    .db $03
.db $E6
    .db $04
.db $84    ; Ds3
.db $E6
    .db $FC
music_gmz_bin_LABEL_977A:
.db $84    ; Ds3
.db $E6
    .db $02
.db $84    ; Ds3
.db $E6
    .db $02
.db $84    ; Ds3
.db $E6
    .db $FC
.db $F7
    .db $00
    .db $04
    .dw music_gmz_bin_LABEL_977A
.db $86    ; F3
.db $E6
    .db $02
.db $86    ; F3
.db $E6
    .db $FE
.db $84    ; Ds3
.db $E6
    .db $04
.db $84    ; Ds3
.db $E6
    .db $FC
.db $84    ; Ds3
.db $E6
    .db $02
.db $84    ; Ds3
.db $E6
    .db $02
.db $84    ; Ds3
.db $E6
    .db $FC
.db $84    ; Ds3
.db $E6
    .db $02
.db $84    ; Ds3
.db $E6
    .db $FE
.db $88    ; G3
.db $E6
    .db $02
.db $88    ; G3
.db $E6
    .db $02
.db $88    ; G3
.db $E6
    .db $FC
.db $88    ; G3
.db $E6
    .db $02
.db $88    ; G3
.db $E6
    .db $FE
.db $86    ; F3
.db $E6
    .db $02
.db $86    ; F3
.db $E6
    .db $FE
.db $86    ; F3
.db $E6
    .db $02
.db $86    ; F3
.db $E6
    .db $FE
.db $F7
    .db $01
    .db $02
    .dw music_gmz_bin_LABEL_9741
.db $F9

music_gmz_bin_Channel3:
.db $80
    .db $18
.db $88    ; G3
    .db $03
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $84    ; Ds3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
music_gmz_bin_LABEL_97CF:
.db $84    ; Ds3
    .db $03
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $84    ; Ds3
.db $88    ; G3
.db $81    ; C3
.db $88    ; G3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $84    ; Ds3
.db $88    ; G3
.db $81    ; C3
.db $88    ; G3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $F7
    .db $00
    .db $03
    .dw music_gmz_bin_LABEL_97CF
.db $84    ; Ds3
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $84    ; Ds3
.db $88    ; G3
.db $81    ; C3
.db $88    ; G3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $81    ; C3
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $81    ; C3
.db $84    ; Ds3
.db $88    ; G3
.db $81    ; C3
.db $88    ; G3
.db $84    ; Ds3
.db $81    ; C3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $88    ; G3
.db $F6
    .dw music_gmz_bin_LABEL_97CF
.db $F2


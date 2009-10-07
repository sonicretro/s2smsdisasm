music_invincibility_bin:
.dw $8A2F
.db $04        ;num channels
.db $00
.db $01
.db $03

music_invincibility_bin_Channel0_Header:
.dw music_invincibility_bin_Channel0
.db $FF        ; pitch adjustment
.db $03        ; volume adjustment

music_invincibility_bin_Channel1_Header:
.dw music_invincibility_bin_Channel1
.db $FF        ; pitch adjustment
.db $03        ; volume adjustment

music_invincibility_bin_Channel2_Header:
.dw music_invincibility_bin_Channel2
.db $FF        ; pitch adjustment
.db $03        ; volume adjustment

music_invincibility_bin_Channel3_Header:
.dw music_invincibility_bin_Channel3
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

music_invincibility_bin_Channel0:
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
.db $95    ; Gs4
.db $95    ; Gs4
.db $8D    ; C4
.db $8D    ; C4
.db $F5
    .db $08
.db $84    ; Ds3
    .db $06
.db $F0
    .db $01
    .db $01
    .db $00
    .db $01
music_invincibility_bin_LABEL_ACB5:
.db $F5
    .db $08
.db $F0
    .db $0B
    .db $01
    .db $08
    .db $01
.db $A5    ; C6
    .db $0C
.db $E6
    .db $02
.db $F7
    .db $00
    .db $04
    .dw music_invincibility_bin_LABEL_ACB5
.db $E6
    .db $F8
.db $A3    ; As5
    .db $06
.db $F0
    .db $0B
    .db $01
    .db $FF
    .db $01
.db $A5    ; C6
    .db $0C
.db $F0
    .db $10
    .db $01
    .db $02
    .db $03
.db $A8    ; Ds6
    .db $1E
music_invincibility_bin_LABEL_ACD7:
.db $F5
    .db $08
.db $F0
    .db $0B
    .db $01
    .db $08
    .db $01
.db $A5    ; C6
    .db $0C
.db $E6
    .db $02
.db $F7
    .db $00
    .db $04
    .dw music_invincibility_bin_LABEL_ACD7
.db $E6
    .db $F8
.db $A3    ; As5
    .db $06
.db $F0
    .db $08
    .db $01
    .db $02
    .db $01
.db $A5    ; C6
    .db $0C
.db $F0
    .db $10
    .db $01
    .db $02
    .db $03
.db $9F    ; Fs5
    .db $1E
.db $F7
    .db $01
    .db $02
    .dw music_invincibility_bin_LABEL_ACB5
.db $E6
    .db $FE
music_invincibility_bin_LABEL_AD00:
.db $E6
    .db $08
.db $80
    .db $06
.db $A3    ; As5
.db $E6
    .db $FF
music_invincibility_bin_LABEL_AD07:
.db $A3    ; As5
.db $A3    ; As5
.db $E6
    .db $FF
.db $F7
    .db $00
    .db $07
    .dw music_invincibility_bin_LABEL_AD07
.db $A3    ; As5
.db $A5    ; C6
.db $80
.db $F0
    .db $10
    .db $01
    .db $08
    .db $01
.db $A5    ; C6
    .db $12
.db $E6
    .db $02
music_invincibility_bin_LABEL_AD1C:
.db $F0
    .db $0C
    .db $01
    .db $08
    .db $01
.db $A5    ; C6
    .db $0C
.db $E6
    .db $01
.db $F7
    .db $00
    .db $05
    .dw music_invincibility_bin_LABEL_AD1C
.db $E6
    .db $F9
.db $F7
    .db $01
    .db $02
    .dw music_invincibility_bin_LABEL_AD00
.db $E6
    .db $02
.db $F6
    .dw music_invincibility_bin_LABEL_ACB5
.db $F2

music_invincibility_bin_Channel2:
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
.db $95    ; Gs4
.db $95    ; Gs4
.db $8D    ; C4
.db $8D    ; C4
.db $84    ; Ds3
    .db $06
.db $FB
    .db $DE
.db $E6
    .db $FC
.db $F0
    .db $01
    .db $01
    .db $00
    .db $01
music_invincibility_bin_LABEL_AD54:
.db $F5
    .db $07
.db $81    ; C3
    .db $06
.db $81    ; C3
.db $84    ; Ds3
.db $81    ; C3
.db $86    ; F3
.db $81    ; C3
.db $87    ; Fs3
.db $88    ; G3
.db $F6
    .dw music_invincibility_bin_LABEL_AD54
.db $F2

music_invincibility_bin_Channel1:
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
.db $95    ; Gs4
.db $95    ; Gs4
.db $8D    ; C4
.db $8D    ; C4
.db $F5
    .db $08
.db $84    ; Ds3
    .db $06
.db $FB
    .db $FD
.db $F0
    .db $01
    .db $01
    .db $00
    .db $01
.db $E1
    .db $01
music_invincibility_bin_LABEL_AD80:
.db $F5
    .db $08
.db $F0
    .db $0B
    .db $01
    .db $08
    .db $01
.db $A5    ; C6
    .db $0C
.db $E6
    .db $02
.db $F7
    .db $00
    .db $04
    .dw music_invincibility_bin_LABEL_AD80
.db $E6
    .db $F8
.db $A3    ; As5
    .db $06
.db $F0
    .db $0B
    .db $01
    .db $FF
    .db $01
.db $A5    ; C6
    .db $0C
.db $F0
    .db $10
    .db $01
    .db $02
    .db $03
.db $A8    ; Ds6
    .db $1E
music_invincibility_bin_LABEL_ADA2:
.db $F5
    .db $08
.db $F0
    .db $0B
    .db $01
    .db $08
    .db $01
.db $A5    ; C6
    .db $0C
.db $E6
    .db $02
.db $F7
    .db $00
    .db $04
    .dw music_invincibility_bin_LABEL_ADA2
.db $E6
    .db $F8
.db $A3    ; As5
    .db $06
.db $F0
    .db $08
    .db $01
    .db $02
    .db $01
.db $A5    ; C6
    .db $0C
.db $F0
    .db $10
    .db $01
    .db $02
    .db $03
.db $9F    ; Fs5
    .db $1E
.db $F7
    .db $01
    .db $02
    .dw music_invincibility_bin_LABEL_AD80
.db $E1
    .db $FF
.db $E6
    .db $FE
music_invincibility_bin_LABEL_ADCD:
.db $E6
    .db $08
.db $80
    .db $06
.db $A0    ; G5
.db $E6
    .db $FF
music_invincibility_bin_LABEL_ADD4:
.db $A0    ; G5
.db $A0    ; G5
.db $E6
    .db $FF
.db $F7
    .db $00
    .db $07
    .dw music_invincibility_bin_LABEL_ADD4
.db $A0    ; G5
.db $A0    ; G5
.db $80
.db $F0
    .db $10
    .db $01
    .db $08
    .db $01
.db $A0    ; G5
    .db $12
.db $E6
    .db $02
music_invincibility_bin_LABEL_ADE9:
.db $F0
    .db $0C
    .db $01
    .db $08
    .db $01
.db $A0    ; G5
    .db $0C
.db $E6
    .db $01
.db $F7
    .db $00
    .db $05
    .dw music_invincibility_bin_LABEL_ADE9
.db $E6
    .db $F9
.db $F7
    .db $01
    .db $02
    .dw music_invincibility_bin_LABEL_ADCD
.db $E6
    .db $02
.db $F6
    .dw music_invincibility_bin_LABEL_AD80
.db $F2

music_invincibility_bin_Channel3:
.db $80
    .db $06
.db $A0    ; G5
.db $88    ; G3
.db $81    ; C3
music_invincibility_bin_LABEL_AE09:
.db $84    ; Ds3
    .db $03
.db $80
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $80
.db $81    ; C3
.db $81    ; C3
.db $84    ; Ds3
.db $80
.db $81    ; C3
.db $81    ; C3
.db $88    ; G3
.db $80
.db $81    ; C3
.db $81    ; C3
.db $F6
    .dw music_invincibility_bin_LABEL_AE09
.db $F2


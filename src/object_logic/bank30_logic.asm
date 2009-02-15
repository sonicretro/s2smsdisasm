
.include "src\object_logic\logic_titlescreen_objects.asm"
   

DATA_B30_8E2B:
.dw DATA_B30_8E31
.dw DATA_B30_8E36
.dw DATA_B30_8E4D

DATA_B30_8E31:
.db $FF, $05
	.db $01
.db $FF, $03
DATA_B30_8E36:
.db $FF, $04
	.dw $FE00
	.dw $0000
.db $20, $01
	.dw LABEL_B30_8E57
.db $FF, $05
	.db  $02
.db $FF, $02
	.dw LABEL_B30_8E69
.db $20, $01
	.dw LABEL_B30_8E57
.db $FF, $00

DATA_B30_8E4D:
.db $04, $03
	.dw LABEL_B30_8EBB
.db $04, $04
	.dw LABEL_B30_8EBB
.db $FF, $00

LABEL_B30_8E57:
	call    LABEL_200 + $57
	call    LABEL_200 + $5A
	ld      a, (ix+$21)
	and     $0F
	ret     z
	ld      a, $FF
	ld      ($D3A8), a
	ret     

LABEL_B30_8E69:
	ld      (ix+$1F), $03
	ld      hl, $0080
	ld      (ix+$0A), l
	ld      (ix+$0B), h
	ld      a, ($D2B9)
	and     $06
	add     a, a
	add     a, a
	add     a, (ix+$3F)
	ld      e, a
	ld      d, $00
	ld      hl, DATA_B30_8E9B
	add     hl, de
	ld      a, (hl)
	ld      (ix+$16), a
	inc     hl
	ld      a, (hl)
	ld      (ix+$17), a
	inc     hl
	ld      a, (hl)
	ld      (ix+$18), a
	inc     hl
	ld      a, (hl)
	ld      (ix+$19), a
	ret     

DATA_B30_8E9B:
.db $90, $FF, $70, $00
.db $70, $00, $90, $FF
.db $90, $FF, $90, $FF
.db $70, $00, $70, $00
.db $90, $FF, $40, $00
.db $C0, $FF, $70, $00
.db $90, $FF, $70, $00
.db $70, $00, $90, $FF


LABEL_B30_8EBB:
	ld      a, (ix+$1F)
	and     $01
	ld      de, $0040
	jr      z, +
	ld      de, $FFC0
+:	ld      l, (ix+$16)
	ld      h, (ix+$17)
	add     hl, de
	ld      (ix+$16), l
	ld      (ix+$17), h
	ld      e, (ix+$0A)
	ld      d, (ix+$0B)
	bit     7, h
	jr      z, LABEL_B30_8EF2
	dec     hl
	ld      a, h
	cpl     
	ld      h, a
	ld      a, l
	cpl     
	ld      l, a
	xor     a
	sbc     hl, de
	jr      c, LABEL_B30_8EFB
	res     0, (ix+$1F)
	jp      LABEL_B30_8EFB

LABEL_B30_8EF2:
	xor     a
	sbc     hl, de
	jr      c, LABEL_B30_8EFB
	set     0, (ix+$1F)
LABEL_B30_8EFB:
	ld      l, (ix+$0A)
	ld      h, (ix+$0B)
	ld      de, $0004
	add     hl, de
	ld      (ix+$0A), l
	ld      (ix+$0B), h
	ld      a, (ix+$1F)
	and     $02
	ld      de, $0040
	jr      z, +
	ld      de, $ffc0
+:	ld      l, (ix+$18)
	ld      h, (ix+$19)
	add     hl, de
	ld      (ix+$18), l
	ld      (ix+$19), h
	ld      e, (ix+$0a)
	ld      d, (ix+$0b)
	bit     7, h
	jr      z, LABEL_B30_8F42
	dec     hl
	ld      a, h
	cpl     
	ld      h, a
	ld      a, l
	cpl     
	ld      l, a
	xor     a
	sbc     hl, de
	jr      c, LABEL_B30_8F4B
	res     1, (ix+$1f)
	jp      LABEL_B30_8F4B

LABEL_B30_8F42:
	xor     a
	sbc     hl, de
	jr      c, LABEL_B30_8F4B
	set     1, (ix+$1f)
LABEL_B30_8F4B:
	call    LABEL_B30_8E57
	ld      a, (ix+$1e)
	add     a, $04
	ld      (ix+$1e), a
	ld      hl, $D3CE
	xor     a
	ld      (hl), a
	inc     hl
	ld      (hl), a
	inc     hl
LABEL_B30_8F5E:
	ld      (hl), a
	inc     hl
	ld      (hl), a
	inc     hl
	ld      b, $04
-:	call    LABEL_B30_8F7D
	inc     hl
	inc     hl
	inc     hl
	inc     hl
	djnz    -
	bit     6, (ix+$04)
	ret     z
	ld      a, (ix+$0b)
	cp      $09
	ret     c
	ld      (ix+$00), $ff
	ret     

LABEL_B30_8F7D:
	push    hl
	ld      a, b
	dec     a
	add     a, a
	add     a, a
	add     a, a
	add     a, a
	add     a, a
	add     a, a
	ld      e, (ix+$1e)
	add     a, e
	ld      e, a
	add     a, $c0
	ld      d, $00
	ld      hl, $0330
	add     hl, de
	ld      c, (hl)
	ld      e, a
	ld      d, $00
	ld      hl, $0330
	add     hl, de
	ld      a, (hl)
	sra     a
	sra     a
	sra     a
	sra     a
	ld      e, a
	and     $80
	rlca    
	neg     
	ld      d, a
	pop     hl
	push    hl
	ld      (hl), e
	inc     hl
	ld      (hl), d
	inc     hl
	ld      a, c
LABEL_B30_8FB2:
	sra     a
	sra     a
	sra     a
	sra     a
	ld      e, a
	and     $80
	rlca    
	neg     
	ld      d, a
	ld      (hl), e
	inc     hl
	ld      (hl), d
	pop     hl
	ret     

DATA_B30_8FC6:
.db $CA, $8F
.db $D0, $8F
DATA_B30_8FCA:
.db $20, $00
	.dw LABEL_B30_9020
.db $FF, $03
DATA_B30_8FD0:
.db $FF, $04
	.dw $FF00
	.dw $0000
.db $08, $01
	.dw LABEL_B30_9026
.db $08, $02
	.dw LABEL_B30_9026
.db $08, $01
	.dw LABEL_B30_9026
.db $08, $02
	.dw LABEL_B30_9026
.db $FF, $04
	.dw $0000
	.dw $0400
.db $04, $01
	.dw LABEL_B30_9026
.db $04, $02
	.dw LABEL_B30_9026
.db $04, $01
	.dw LABEL_B30_9026
.db $04, $02
	.dw LABEL_B30_9026
.db $FF, $04
	.dw $FC00
	.dw $0000
.db $04, $01
	.dw LABEL_B30_9026
.db $04, $02
	.dw LABEL_B30_9026
.db $04, $01
	.dw LABEL_B30_9026
.db $04, $02
	.dw LABEL_B30_9026
.db $04, $01
	.dw LABEL_B30_9026
.db $04, $02
	.dw LABEL_B30_9026
.db $20, $02
	.dw LABEL_B30_9038
.db $FF, $00

LABEL_B30_9020:
	ld      b, $01
	ld      (ix+$02), b
	ret     

LABEL_B30_9026:
	call    LABEL_200 + $57
	call    LABEL_200 + $5A
	ld      a, (ix+$21)
	and     $0f
	ret     z
	ld      a, $ff
	ld      ($D3A8), a
	ret     

LABEL_B30_9038:
	ld      (ix+$00), $ff
	ret     

DATA_B30_903D:
.dw DATA_B30_905D
.dw DATA_B30_9069
.dw DATA_B30_906F
.dw DATA_B30_9075
.dw DATA_B30_907F
.dw DATA_B30_90A4
.dw DATA_B30_90E5
.dw DATA_B30_914D
.dw DATA_B30_9157
.dw DATA_B30_91FD
.dw DATA_B30_920B
.dw DATA_B30_9215
.dw DATA_B30_921F
.dw DATA_B30_9229
.dw DATA_B30_9266
.dw DATA_B30_9270

DATA_B30_905D:
.db $FF, $08
	.db $19
.db $FF, $09
	.db $09
.db $E0, $01
	.dw LABEL_B30_9285
.db $FF, $03
DATA_B30_9069:
.db $E0, $01
	.dw LABEL_B30_929B
.db $FF, $00

DATA_B30_906F:
.db $E0, $01
	.dw LABEL_B30_92B3
.db $FF, $00

DATA_B30_9075:
.db $80, $01
	.dw LABEL_B30_934A
.db $20, $01
	.dw LABEL_B30_92D7
.db $FF, $00

DATA_B30_907F:
.db $10, $01
	.dw LABEL_B30_934A
.db $FF, $06
	.db $53
	.dw $FFF0
	.dw $FFEA
	.db $00
.db $40, $02
	.dw LABEL_B30_934A
.db $FF, $06
	.db $53
	.dw $FFF0
	.dw $FFDA
	.db $04
.db $C0, $01
	.dw LABEL_B30_934A
.db $FF, $05
	.db $03
.db $80, $02
	.dw LABEL_B30_934A
.db $FF, $00

DATA_B30_90A4:
.db $10, $01
	.dw LABEL_B30_934A
.db $FF, $06
	.db $54
	.dw $0000
	.dw $FFFC
	.db $00
.db $18, $02
	.dw LABEL_B30_934A
.db $FF, $06
	.db $54
	.dw $0000
	.dw $FFFC
	.db $04
.db $18, $02
	.dw LABEL_B30_934A
.db $FF, $06
	.db $54
	.dw $0000
	.dw $FFFC
	.db $00
.db $18, $02
	.dw LABEL_B30_934A
.db $FF, $06
	.db $54
	.dw $0000
	.dw $FFFC
	.db $04
.db $18, $02
	.dw LABEL_B30_934A
.db $60, $01
	.dw LABEL_B30_934A
.db $FF, $05
	.db $03
.db $80, $02
	.dw LABEL_B30_934A
.db $FF, $00

DATA_B30_90E5:
.db $FF, $02
	.dw LABEL_B30_9136
.db $04, $01
	.dw LABEL_B30_9326
.db $FF, $02
	.dw LABEL_B30_913C
.db $04, $02
	.dw LABEL_B30_9326
.db $FF, $02
	.dw LABEL_B30_9136
.db $06, $01
	.dw LABEL_B30_9326
.db $FF, $02
	.dw LABEL_B30_913C
.db $28, $02
	.dw LABEL_B30_9326
.db $FF, $02
	.dw LABEL_B30_9136
.db $FF, $02
	.dw LABEL_B30_9142
.db $10, $01
	.dw LABEL_B30_9326,
.db $10, $02
	.dw LABEL_B30_9326
.db $10, $01
	.dw LABEL_B30_9326
.db $10, $02
	.dw LABEL_B30_9326
.db $10, $01
	.dw LABEL_B30_9326
.db $10, $02
	.dw LABEL_B30_9326
.db $FF, $05
	.db $03
.db $FF, $02
	.dw LABEL_B30_9148
.db $FF, $02
	.dw LABEL_B30_913C
.db $80, $02
	.dw LABEL_B30_934A
.db $FF, $00

LABEL_B30_9136:
	ld      a, $09
	ld      ($D4A6), a
	ret     

LABEL_B30_913C:
	ld      a, $0A
	ld      ($D4A6), a
	ret     

LABEL_B30_9142:
	ld      a, $ff
	ld      ($D46C), a
	ret     

LABEL_B30_9148:
	xor     a
	ld      ($D46C), a
	ret     

DATA_B30_914D:
.db $08, $03
	.dw	LABEL_B30_933A
.db $08, $04
	.dw	LABEL_B30_933A
.db $FF, $00

DATA_B30_9157:
.db $FF, $02
	.dw LABEL_B30_913C
.db $FF, $02
	.dw LABEL_200 + $120
.db $08, $03
	.dw LABEL_200 + $2A
.db $08, $04
	.dw LABEL_200 + $2A
.db $08, $03
	.dw LABEL_200 + $2A
.db $08, $04
	.dw LABEL_200 + $2A
.db $08, $03
	.dw LABEL_200 + $2A
.db $08, $04
	.dw LABEL_200 + $2A
.db $FF, $06
	.db $0F
	.dw $0008
	.dw $FFC0
	.db $03
.db $08, $03
	.dw LABEL_200 + $2A
.db $FF, $06
	.db $0F
	.dw $FFF8
	.dw $FFC2
	.db $03
.db $08, $04
	.dw LABEL_200 + $2A
.db $FF, $06
	.db $0F
	.dw $0004
	.dw $FFE8
	.db $07
.db $08, $03
	.dw LABEL_200 + $2A
.db $FF, $06
	.db $0F
	.dw $FFFC
	.dw $FFE8
	.db $07
.db $FF, $02
	.dw LABEL_B30_91E9
.db $08, $0A
	.dw LABEL_200 + $2A
.db $FF, $06
	.db $0F
	.dw $0000
	.dw $FFF4
	.db $05
.db $FF, $02
	.dw LABEL_B30_91F3
.db $FF, $04
	.dw $05A0
	.dw $FC00
.db $FF, $02
	.dw LABEL_B30_91CA
.db $FF, $05
	.db $09
.db $08, $0A
	.dw LABEL_200 + $2A
.db $FF, $00

LABEL_B30_91CA:
	ld      (ix+$1f), $00
	ret     

LABEL_B30_91CF:
	ld      a, (ix+$1f)
	or      a
	ret     nz
	ld      l, (ix+$14)
	ld      h, (ix+$15)
	ld      de, $ffd0
	add     hl, de
	ld      (ix+$14), l
	ld      (ix+$15), h
	ld      (ix+$1f), $01
	ret     

LABEL_B30_91E9:
	ld      bc, $0000
	ld      de, $ffc0
	call    LABEL_200 + $0111
	ret

LABEL_B30_91F3:
	ld      bc, $0000
	ld      de, $fff0
	call    LABEL_200 + $0111
	ret

DATA_B30_91FD:
.db $FF, $02
	.dw LABEL_B30_91CF
.db $08, $06
	.dw LABEL_B30_9370
.db $08, $07
	.dw LABEL_B30_9370
.db $FF, $00

DATA_B30_920B:
.db $08, $06
	.dw LABEL_B30_93C2
.db $08, $07
	.dw LABEL_B30_93C2
.db $FF, $00

DATA_B30_9215:
.db $08, $06
	.dw LABEL_B30_9370
.db $08, $07
	.dw LABEL_B30_9370
.db $FF, $00

DATA_B30_921F:
.db $08, $08
	.dw LABEL_B30_9401
.db $08, $09
	.dw LABEL_B30_9401
.db $FF, $00

DATA_B30_9229:
.db $40, $09
	.dw LABEL_200 + $2A
.db $40, $09
	.dw LABEL_200 + $2A
.db $FF, $04
	.dw $0000
	.dw $FFC0
.db $88, $08
	.dw LABEL_200 + $57
.db $FF, $04
	.dw $0000
	.dw $0040
.db $08, $08
	.dw LABEL_200 + $57
.db $FF, $04
	.dw $0000
	.dw $0000
.db $08, $09
	.dw LABEL_200 + $2A
.db $FF, $02
	.dw LABEL_B30_9136
.db $FF, $02
	.dw LABEL_B30_9260
.db $FF, $05
	.db $0E
.db $08, $09
	.dw LABEL_200 + $2A
.db $FF, $00


LABEL_B30_9260:
	ld      a, $e0
	ld      (ix+$1f), a
	ret     

DATA_B30_9266:
.db $02, $08
	.dw LABEL_B30_942E
.db $03, $00
	.dw LABEL_B30_942E
.db $FF, $00

DATA_B30_9270:
.db $08, $00
	.dw LABEL_200 + $2A
.db $FF, $08
	.db $1A
.db $FF, $02
	.dw LABEL_B30_913C
.db $C0, $00
	.dw LABEL_200 + $2A
.db $E0, $00
	.dw LABEL_B30_943A
.db $FF, $00


LABEL_B30_9285:
	ld      a, $ff
	ld      ($d4a2), a
	ld      (ix+$02), $01
	set     1, (ix+$04)
	res     6, (ix+$04)
	ld      (ix+$24), $08
	ret     

LABEL_B30_929B:
	ld      hl, ($d174)
	ld      de, $0180
	xor     a
	sbc     hl, de
	ret     c
	ld      bc, $0200
	ld      de, $00c0
	call    LABEL_200 + $F6
	ld      (ix+$02), $02
	ret     

LABEL_B30_92B3:
	call    LABEL_200 + $1B
	ld      (ix+$21), $00
	ld      hl, ($d174)
	ld      de, $0200
	xor     a
	sbc     hl, de
	ld      a, h
	or      l
	ret     nz
	call    LABEL_200 + $F3
	ld      hl, $0200
	ld      ($d282), hl		;set max camera x position
	ld      ($d280), hl		;set min camera x position
	ld      (ix+$02), $03
	ret     

LABEL_B30_92D7:
	call    LABEL_B30_934A
	inc     (ix+$1e)
	ld      a, (ix+$24)
	add     a, a
	ld      e, a
	ld      d, $00
	ld      hl, DATA_B30_92F8
	add     hl, de
	ld      a, (hl)
	inc     hl
	ld      h, (hl)
	ld      l, a
	ld      a, (ix+$1e)
	and     $07
	ld      e, a
	add     hl, de
	ld      a, (hl)
	ld      (ix+$02), a
	ret     

DATA_B30_92F8:
.dw DATA_B30_930E
.dw DATA_B30_930E
.dw DATA_B30_930E
.dw DATA_B30_9316
.dw DATA_B30_9316
.dw DATA_B30_9316
.dw DATA_B30_931E
.dw DATA_B30_931E
.dw DATA_B30_931E
.dw DATA_B30_931E
.dw DATA_B30_931E

DATA_B30_930E:
.db $04, $05, $06, $04, $05, $06, $04, $05
DATA_B30_9316:
.db $05, $06, $05, $06, $05, $06, $05, $06
DATA_B30_931E:
.db $04, $06, $04, $06, $04, $06, $04, $06


LABEL_B30_9326:
	call	LABEL_B30_934A
	ld      a, ($d46c)
	or      a
	ret     z
	ld      a, ($d501)
	cp      $21
	ret     z
	ld      a, $ff
	ld      ($d3a8), a
	ret     

LABEL_B30_933A:
	call    LABEL_200 + $1B
	ld      (ix+$21), $00
	dec     (ix+$1f)
	ret     nz
	ld      (ix+$02), $04
	ret     

LABEL_B30_934A:
	call    LABEL_200 + $1B
	ld      a, (ix+$21)
	and     $0f
	ret     z
	ld      a, (ix+$24)
	or      a
	jr      z, LABEL_B30_9365
	dec     (ix+$24)
	ld      (ix+$02), $07
	ld      (ix+$1f), $40
	ret     

LABEL_B30_9365:
	ld      (ix+$02), $08
	ld      hl, $0400
	ld      ($D282), hl
	ret     

LABEL_B30_9370:
	call    LABEL_B30_940F
	call    LABEL_200 + $57
	bit     7, (ix+$19)
	jr      z, LABEL_B30_9386
	ld      de, $0028
	ld      bc, $0600
	call    LABEL_200 + $0F
	ret     

LABEL_B30_9386:
	ld      de, $0080
	ld      bc, $0600
	call    LABEL_200 + $0F
	ld      hl, $0180
	ld      (ix+$16), l
	ld      (ix+$17), h
	call    LABEL_200 + $60
	bit     1, (ix+$22)
	ret     z
	ld      hl, $0000
	ld      (ix+$16), l
	ld      (ix+$17), h
	ld      a, (ix+$01)
	cp      $09
	jr      nz, +
	ld      a, ($d501)
	cp      $31
	ret     nz
+:	ld      a, (ix+$01)
	inc     a
	ld      (ix+$02), a
	ld      (ix+$1f), $40
	ret     

LABEL_B30_93C2:
	ld      hl, $0300
	ld      (ix+$16), l
	ld      (ix+$17), h
	call    LABEL_B30_940F
	ld      hl, $0300
	ld      (ix+$18), l
	ld      (ix+$19), h
	call    LABEL_200 + $60
	call    LABEL_200 + $57
	ld      l, (ix+$11)
	ld      h, (ix+$12)
	ld      de, $044C
	xor     a
	sbc     hl, de
	ret     c
	ld      (ix+$02), $0b
	ld      hl, $fca0
	ld      (ix+$18), l
	ld      (ix+$19), h
	ld      hl, $02c0
	ld      (ix+$16), l
	ld      (ix+$17), h
	ret     

LABEL_B30_9401:
	call    LABEL_B30_940F
	ld      a, ($d501)
	cp      $32
	ret     nz
	ld      (ix+$02), $0d
	ret

LABEL_B30_940F:
	ld      a, ($d522)
	bit     1, a
	ret     z
	ld      a, ($d501)
	cp      $31
	ret     z
	cp      $32
	ret     z
	ld      hl, ($d511)
	ld      de, $0368
	xor     a
	sbc     hl, de
	ret     c
	ld      a, $31
	ld      ($d502), a
	ret     

LABEL_B30_942E:
	dec     (ix+$1f)
	ret     nz
	ld      a, (ix+$01)
	inc     a
	ld      (ix+$02), a
	ret     

LABEL_B30_943A:
	ld      (ix+$00), $5d
	ld      (ix+$3f), $01
	xor     a
	ld      (ix+$01), a
	ld      (ix+$02), a
	ld      (ix+$04), a
	ld      (ix+$07), a
	ld      (ix+$0e), a
	ld      (ix+$0f), a
	ret     

DATA_B30_9456:
.dw DATA_B30_946C
.dw DATA_B30_9472
.dw DATA_B30_949E
.dw DATA_B30_94C4
.dw DATA_B30_94FF
.dw DATA_B30_9505
.dw DATA_B30_9516
.dw DATA_B30_9602
.dw DATA_B30_960C
.dw DATA_B30_9637
.dw DATA_B30_9484

DATA_B30_946C:
.db $E0, $00
	.dw LABEL_B30_9556
.db $FF, $00

DATA_B30_9472:
.db $04, $0E
	.dw LABEL_B30_95B0
.db $04, $0F
	.dw LABEL_B30_95B0
.db $04, $10
	.dw LABEL_B30_95B0
.db $04, $11
	.dw LABEL_B30_95B0
.db $FF, $00

DATA_B30_9484:
.db $08, $0C
	.dw LABEL_B30_95A0
.db $08, $0D
	.dw LABEL_B30_95A0
.db $08, $0A
	.dw LABEL_B30_95A0
.db $08, $0B
	.dw LABEL_B30_95A0
.db $08, $0C
	.dw LABEL_B30_95A0
.db $08, $0D
	.dw LABEL_B30_95A0
.db $FF, $00

DATA_B30_949E:
.db $08, $14
	.dw	LABEL_200 + $2A
.db $08, $14
	.dw	LABEL_200 + $2A
.db $08, $14
	.dw	LABEL_200 + $2A
.db $08, $14
	.dw	LABEL_200 + $2A
.db $20, $15
	.dw	LABEL_200 + $2A
.db $E0, $15
	.dw	LABEL_200 + $2A
.db $E0, $15
	.dw	LABEL_200 + $2A
.db $E0, $15
	.dw	LABEL_200 + $2A
.db $E0, $15
	.dw	LABEL_200 + $2A
.db $FF, $00

DATA_B30_94C4:
.db $C0, $15
	.dw	LABEL_200 + $2A
.db $FF, $02
	.dw LABEL_B30_94DA
.db $20, $15
	.dw	LABEL_200 + $2A
.db $E0, $15
	.dw	LABEL_200 + $2A
.db $E0, $15
	.dw LABEL_B30_94E0
.db $FF, $00


LABEL_B30_94DA:
	ld      a, $0E
	ld      ($D4A6), a
	ret     

LABEL_B30_94E0:
	ld      hl, $ffe0
	ld      (ix+$14), l
	ld      (ix+$15), h
	ld      hl, $0088
	ld      (ix+$11), l
	ld      (ix+$12), h
	res     4, (ix+$04)
	res     7, (ix+$04)
	ld      (ix+$02), $04
	ret     

DATA_B30_94FF:
.db $06, $12
	.dw LABEL_B30_951C
.db $FF, $00

DATA_B30_9505
.db $E0, $13
	.dw LABEL_200 + $2A
.db $E0, $13
	.dw LABEL_200 + $2A
.db $E0, $13
	.dw LABEL_200 + $2A
.db $FF, $05
	.db $06
.db $FF, $00

DATA_B30_9516:
.db $E0, $13
	.dw LABEL_200 + $2A
.db $FF, $00


LABEL_B30_951C:
	ld      de, $0040
	ld      bc, $0600
	call    LABEL_200 + $0F
	call    LABEL_200 + $57
	ld      l, (ix+$14)
	ld      h, (ix+$15)
	bit     7, h
	ret     nz
	ld      de, $00c0
	xor     a
	sbc     hl, de
	ret     c
	ld      e, (ix+$18)
	ld      d, (ix+$19)
	bit     7, d
	ret     nz
	xor     a
	ld      hl, $0080
	sbc     hl, de
	jr      c, LABEL_B30_954E
	ld      (ix+$02), $05
	ret     

LABEL_B30_954E:
	ld      (ix+$18), l
	ld      (ix+$19), h
	xor     a
	ret     

LABEL_B30_9556:
	ld      a, (ix+$3f)
	or      a
	jr      z, LABEL_B30_9568
	ld      (ix+$02), $07
	ld      (ix+$1f), $e0
	call    LABEL_B30_9136
	ret     

LABEL_B30_9568:
	ld      a, ($D2C5)
	and     $3F
	cp      $3F
	jr      z, +
	set     7, (ix+$04)
+:	set     4, (ix+$04)
	set     1, (ix+$04)
	ld      (ix+$02), $01
	ld      hl, ($D514)
	ld      (ix+$14), l
	ld      (ix+$15), h
	ld      (ix+$09), $1C
	ld      (ix+$08), $4A
	ld      hl, ($D511)
	ld      de, $FFE0
	add     hl, de
	ld      (ix+$11), l
	ld      (ix+$12), h
	ret     

LABEL_B30_95A0:
	ld      hl, ($d511)
	ld      de, $ffe0
	add     hl, de
	ld      (ix+$11), l
	ld      (ix+$12), h
	jp      LABEL_B30_95FE

LABEL_B30_95B0:
	ld      h, (ix+$0a)
	ld      l, (ix+$0b)
	ld      de, $fff8
	bit     0, (ix+$1f)
	jr      z, +
	ld      de, $0008
+:	add     hl, de
	ex      de, hl
	bit     7, d
	jr      z, LABEL_B30_95D1
	ld      de, $0000
	set     0, (ix+$1f)
	jr      LABEL_B30_95E0

LABEL_B30_95D1:
	ld      hl, $2800
	xor     a
	sbc     hl, de
	jr      nc, LABEL_B30_95E0
	ld      de, $2800
	res     0, (ix+$1f)
LABEL_B30_95E0:
	ld      (ix+$0a), d
	ld      (ix+$0b), e
	ld      hl, ($d511)
	ld      de, $ffe0
	add     hl, de
	ld      e, (ix+$0a)
	ld      d, $00
	xor     a
	sbc     hl, de
	ld      (ix+$11), l
	ld      (ix+$12), h
	jp      LABEL_B30_95FE

LABEL_B30_95FE:
	call    LABEL_200 + $57
	ret     

DATA_B30_9602:
.db $02, $01
	.dw LABEL_B30_942E
.db $03, $00
	.dw LABEL_B30_942E
.db $FF, $00

DATA_B30_960C:
.db $FF, $02
	.dw LABEL_B30_913C
.db $FF, $04
	.dw $0000
	.dw $FFC0
.db $08, $01
	.dw LABEL_200 + $57
.db $FF, $04
	.dw $0000
	.dw $0040
.db $88, $01
	.dw LABEL_200 + $57
.db $FF, $04
	.dw $0000
	.dw $0000
.db $08, $01
	.dw	LABEL_200 + $2A
.db $FF, $05
	.db $09
.db $03, $01
	.dw LABEL_200 + $2A
.db $FF, $00

DATA_B30_9637:
.db $08, $01
	.dw LABEL_200 + $2A
.db $08, $02
	.dw LABEL_200 + $2A
.db $08, $01
	.dw LABEL_200 + $2A
.db $08, $02
	.dw LABEL_200 + $2A
.db $40, $03
	.dw LABEL_200 + $2A
.db $08, $08
	.dw LABEL_200 + $2A
.db $08, $03
	.dw LABEL_200 + $2A
.db $08, $08
	.dw LABEL_200 + $2A
.db $08, $03
	.dw LABEL_200 + $2A
.db $10, $08
	.dw LABEL_200 + $2A
.db $08, $03
	.dw LABEL_200 + $2A
.db $10, $08
	.dw LABEL_200 + $2A
.db $E0, $08
	.dw LABEL_200 + $2A
.db $E0, $08
	.dw LABEL_200 + $2A
.db $FF, $00

DATA_B30_9671:
.dw DATA_B30_9677
.dw DATA_B30_96A6
.dw DATA_B30_96E8

DATA_B30_9677:
.db $FF, $05
	.db $01
.db $E0, $00
	.dw LABEL_B30_9680
.db $FF, $00

LABEL_B30_9680:
	ld      (ix+$08), $40
	ld      hl, $007e
	ld      (ix+$14), l
	ld      (ix+$15), h
	ld      hl, ($d511)
	ld      de, $0020
	add     hl, de
	ld      (ix+$11), l
	ld      (ix+$12), h
	xor     a
	ld      (ix+$1e), a
	ld      (ix+$1f), a
	ld      (ix+$02), $01
	ret

DATA_B30_96A6:
.db $06, $01
	.dw LABEL_B30_96C0
.db $06, $02
	.dw LABEL_B30_96C0
.db $06, $03
	.dw LABEL_B30_96C0
.db $06, $04
	.dw LABEL_B30_96C0
.db $06, $05
	.dw LABEL_B30_96C0
.db $06, $06
	.dw LABEL_B30_96C0
.db $FF, $00

LABEL_B30_96C0:
	ld      hl, ($d511)
	ld      de, $0020
	add     hl, de
	ld      (ix+$11), l
	ld      (ix+$12), h
	ld      l, (ix+$1e)
	ld      h, (ix+$1f)
	inc     hl
	ld      (ix+$1e), l
	ld      (ix+$1f), h
	ld      de, $00d8
	xor     a
	sbc     hl, de
	ld      a, h
	or      l
	ret     nz
	ld      (ix+$02), $02
	ret     

DATA_B30_96E8:
.db $FF, $04
	.dw $FE00
	.dw $0180
.db $06, $01
	.dw LABEL_B30_96F8
.db $06, $02
	.dw LABEL_B30_96F8
.db $FF, $00


LABEL_B30_96F8:
	call    LABEL_200 + $57
	ret     

DATA_B30_96FC:
.dw DATA_B30_9706
.dw DATA_B30_9735
.dw DATA_B30_976F
.dw DATA_B30_9808
.dw DATA_B30_981C

DATA_B30_9706:
.db $FF, $05
	.db $01
.db $E0, $00
	.dw LABEL_B30_970F
.db $FF, $00


LABEL_B30_970F:
	ld      (ix+$08), $5a
	ld      hl, $007e
	ld      (ix+$14), l
	ld      (ix+$15), h
	ld      hl, ($d511)
	ld      de, $0020
	add     hl, de
	ld      (ix+$11), l
	ld      (ix+$12), h
	xor     a
	ld      (ix+$1e), a
	ld      (ix+$1f), a
	ld      (ix+$02), $01
	ret     

DATA_B30_9735:
.db $06, $01
	.dw LABEL_B30_973F
.db $06, $02
	.dw LABEL_B30_973F
.db $FF, $00

LABEL_B30_973F:
	ld      hl, ($d511)
	ld      de, $0020
	add     hl, de
	ld      (ix+$11), l
	ld      (ix+$12), h
	ld      l, (ix+$1e)
	ld      h, (ix+$1f)
	inc     hl
	ld      (ix+$1e), l
	ld      (ix+$1f), h
	ld      de, $00f5
	xor     a
	sbc     hl, de
	ld      a, h
	or      l
	ret     nz
	ld      (ix+$02), $04
	ld      (ix+$1e), $00
	ld      (ix+$1f), $00
	ret     

DATA_B30_976F:
.db $FF, $04
	.dw $0000
	.dw $0000
.db $08, $01
	.dw LABEL_B30_9818
.db $08, $02
	.dw LABEL_B30_9818
.db $08, $01
	.dw LABEL_B30_9818
.db $08, $02
	.dw LABEL_B30_9818
.db $08, $01
	.dw LABEL_B30_9818
.db $08, $02
	.dw LABEL_B30_9818
.db $08, $01
	.dw LABEL_B30_9818
.db $08, $02
	.dw LABEL_B30_9818
.db $FF, $04
	.dw $0040
	.dw $0000
.db $06, $01
	.dw LABEL_B30_9818
.db $06, $02
	.dw LABEL_B30_9818
.db $FF, $04
	.dw $0000
	.dw $0000
.db $06, $01
	.dw LABEL_B30_9818
.db $06, $02
	.dw LABEL_B30_9818
.db $06, $01
	.dw LABEL_B30_9818
.db $06, $02
	.dw LABEL_B30_9818
.db $06, $01
	.dw LABEL_B30_9818
.db $06, $02
	.dw LABEL_B30_9818
.db $FF, $04
	.dw $FFE0
	.dw $0000
.db $06, $01
	.dw LABEL_B30_9818
.db $FF, $04
	.dw $0000
	.dw $0000
.db $06, $02
	.dw LABEL_B30_9818
.db $06, $01
	.dw LABEL_B30_9818
.db $06, $02
	.dw LABEL_B30_9818
.db $06, $01
	.dw LABEL_B30_9818
.db $06, $02
	.dw LABEL_B30_9818
.db $06, $01
	.dw LABEL_B30_9818
.db $06, $02
	.dw LABEL_B30_9818
.db $06, $01
	.dw LABEL_B30_9818
.db $06, $02
	.dw LABEL_B30_9818
.db $FF, $04
	.dw $0000
	.dw $0000
.db $06, $01
	.dw LABEL_B30_9818
.db $FF, $05
	.db $03
.db $06, $02
	.dw LABEL_B30_9818
.db $FF, $00

DATA_B30_9808:
.db $FF, $04
	.dw $0040
	.dw $FFC0
.db $06, $01
	.dw LABEL_B30_9818
.db $06, $02
	.dw LABEL_B30_9818
.db $FF, $00


LABEL_B30_9818:
	call    LABEL_200 + $57
	ret     

DATA_B30_981C:
.db $06, $01
	.dw LABEL_B30_9826
.db $06, $02
	.dw LABEL_B30_9826
.db $FF, $00

LABEL_B30_9826:
	ld      l, (ix+$1e)
	ld      h, (ix+$1f)
	inc     hl
	ld      (ix+$1e), l
	ld      (ix+$1f), h
	ld      de, $01e0
	xor     a
	sbc     hl, de
	ld      a, h
	or      l
	ret     nz
	ld      (ix+$02), $02
	ret     

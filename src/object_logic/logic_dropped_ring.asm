Logic_DroppedRing:		;$AF72
DATA_B31_AF72:
.dw DATA_B31_AF78
.dw DATA_B31_AF7E
.dw DATA_B31_AF90

DATA_B31_AF78:
.db $01, $00 
	.dw LABEL_B31_AFAA
.db $FF, $00

DATA_B31_AF7E:
.db $04, $01
	.dw LABEL_B31_B017
.db $04, $02
	.dw LABEL_B31_B017
.db $04, $03
	.dw LABEL_B31_B017
.db $04, $04
	.dw LABEL_B31_B017
.db $FF, $00

DATA_B31_AF90:
.db $04, $05
	.dw LABEL_B31_B079
.db $04, $06
	.dw LABEL_B31_B079
.db $04, $05
	.dw LABEL_B31_B079
.db $04, $06
	.dw LABEL_B31_B079
.db $04, $05
	.dw LABEL_B31_B079
.db $04, $06
	.dw LABEL_B31_B079
.db $FF, $01


LABEL_B31_AFAA:
	ld		hl, ($D511)		;move sprite to 16-pixels above player
	ld      (ix+$11), l		;set sprite's hpos
	ld      (ix+$12), h
	ld      hl, ($D514)
	ld      de, $FFF0
	add     hl, de			;subtract $10
	ld      (ix+$14), l		;set sprite's vpos
	ld      (ix+$15), h
	ld      l, (ix+$3F)
	ld      h, $00
	add     hl, hl
	ex      de, hl
	ld      hl, DATA_B31_AFFB	;set horizontal speed
	add     hl, de
	ld      a, (hl)
	ld      (ix+$16), a
	inc     hl
	ld      a, (hl)
	ld      (ix+$17), a
	ld      hl, DATA_B31_B009	;set vertical speed
	add     hl, de
	ld      a, (hl)
	ld      (ix+$18), a
	inc     hl
	ld      a, (hl)
	ld      (ix+$19), a
	ld      hl, $FC00
	ld      (ix+$3C), l
	ld      (ix+$3D), h
	ld      (ix+$02), $01
	set     7, (ix+$03)
	set     6, (ix+$03)
	set     0, (ix+$04)
	ret     

DATA_B31_AFFB:
.db $00, $00, $00, $FF, $00, $01, $80, $FD, $80, $02, $80, $FC, $80, $03

DATA_B31_B009:
.db $00, $FB, $80, $FB, $80, $FB, $80, $FC, $80, $FC, $00, $FE, $00, $FE


LABEL_B31_B017:
	ld		l, (ix+$18)			;add 32 to sprite's horizontal speed
	ld		h, (ix+$19)
	ld      de, $0020
	add     hl, de
	ld      (ix+$18), l
	ld      (ix+$19), h
	call    VF_Engine_CheckCollision
	ld      a, (ix+$21)
	and     $0F
	jr      nz, LABEL_B31_B06C
	call    VF_Engine_UpdateObjectPosition
	res     1, (ix+$22)
	bit     7, (ix+$19)
	call    z, LABEL_200 + $60
	bit     1, (ix+$22)
	jr      z, +
	res     6, (ix+$03)
	ld      l, (ix+$3c)
	ld      h, (ix+$3d)
	ld      bc, $0080
	xor     a
	add     hl, bc
	jr      c, ++
	ld      (ix+$3c), l
	ld      (ix+$3d), h
	ld      (ix+$18), l
	ld      (ix+$19), h
+:	bit     6, (ix+$04)
	ret     z
++:	ld      (ix+$00), $ff
	ret     

LABEL_B31_B06C:
	ld      a, SFX_Ring
	ld      ($DD04), a
	call    VF_Engine_IncrementRingCounter
	ld      (ix+$02), $02
	ret

LABEL_B31_B079:
	ret

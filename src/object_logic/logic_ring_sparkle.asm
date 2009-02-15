Logic_RingSparkle:		;$ABE1
.dw RingSparkle_State_00
.dw RingSparkle_State_01

RingSparkle_State_00:	;$ABE5
.db $01, $00, 
	.dw LABEL_B31_ABFD
.db $FF, $00

RingSparkle_State_01:	;$ABEB:
.db $04, $01
	.dw LABEL_B31_AC20
.db $04, $02
	.dw LABEL_B31_AC20
.db $04, $01
	.dw LABEL_B31_AC20
.db $04, $02
	.dw LABEL_B31_AC20
.db $FF, $01


LABEL_B31_ABFD:
	ld		hl, ($D35A)
	ld		a, l
	and     $F0
	add     a, $06
	ld      (ix+$11), a
	ld      (ix+$12), h
	ld      hl, ($D35C)
	ld      a, l
	and     $F0
	ld      (ix+$14), a
	ld      (ix+$15), h
	ld      (ix+$02), $01
	set     1, (ix+$04)
	ret     

LABEL_B31_AC20:
	ret

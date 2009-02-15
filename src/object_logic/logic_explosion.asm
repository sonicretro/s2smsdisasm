Logic_Explosion:			;$B68E
.dw Explosion_State_00
.dw Explosion_State_01
.dw Explosion_State_01

Explosion_State_00:			;$B694
.db $01, $00
	.dw LABEL_B31_B6D9
.db $FF, $00


;Used for state 1 and state 2
Explosion_State_01:			;$B69A
.db $FF, $09
	.db SFX_BombDestroy
.db $04, $01
	.dw Explosion_State_01_Logic_01
.db $04, $02
	.dw Explosion_State_01_Logic_01
.db $04, $03
	.dw Explosion_State_01_Logic_01
.db $04, $02
	.dw Explosion_State_01_Logic_01
.db $04, $01
	.dw Explosion_State_01_Logic_01
.db $FF, $02
	.dw Explosion_State_01_Logic_02
.db $01, $01
	.dw Explosion_State_01_Logic_01
.db $80, $00
	.dw Explosion_State_01_Logic_03
.db $FF, $00


Explosion_State_01_Logic_02:		;$B6BF
	ld      a, (ix+$3F)
	ld      b, a
	and     $3F
	ret     z
	dec     a
	ld      c, a
	ld      a, b
	and     $C0
	or      c
	ld      (ix+$3F), a
	ld      a, (ix+$01)
	and     $01
	inc     a
	ld      (ix+$02), a
	ret     

LABEL_B31_B6D9:
	res     4, (ix+$04)
	ld      (ix+$02), $01
	ld      (ix+$08), $00
	ld      (ix+$09), $00
	set     0, (ix+$04)
	ret

Explosion_State_01_Logic_01:		;$B6EE
	ret     

Explosion_State_01_Logic_03:		;$B6EF
	bit     6, (ix+$3F)
	jp      nz, LABEL_B31_B702
	bit     7, (ix+$3F)
	jp      nz, LABEL_B31_B70B
	ld      (ix+$00), $FF
	ret     

LABEL_B31_B702:
	xor     a
	ld      (ix+$3E), a
	ld      (ix+$00), $FF
	ret     

LABEL_B31_B70B:
	ld      (ix+$00), $FE
	ret     

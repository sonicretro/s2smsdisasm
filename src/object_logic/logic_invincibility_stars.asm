Logic_InvincibilityStars:		;$AE04
.dw InvincibilityStars_State_00		;DATA_B31_AE0A
.dw InvincibilityStars_State_01
.dw InvincibilityStars_State_02

InvincibilityStars_State_00:	;$AE0A
.db $01, $00
	.dw InvincibilityStars_State_00_Logic_01
.db $FF, $00

InvincibilityStars_State_01:	;$AE10
.db $01, $01
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $02
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $03
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $04
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $05
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $06
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $07
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $08
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $09
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $0A
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $0B
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $0C
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $0D
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $0E
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $0F
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $10
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $11
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $12
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $13
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $14
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $15
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $16
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $17
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $18
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $19
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $1A
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $1B
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $1C
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $1D
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $1E
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $1F
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $20
	.dw InvincibilityStars_State_01_Logic_01
.db $FF, $00

InvincibilityStars_State_02:	;$AE92
.db $01, $05
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $06
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $07
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $08
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $09
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $0A
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $0B
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $0C
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $0D
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $0E
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $0F
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $10
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $11
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $12
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $13
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $14
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $15
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $16
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $17
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $18
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $19
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $1A
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $1B
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $1C
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $1D
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $1E
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $1F
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $20
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $01
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $02
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $03
	.dw InvincibilityStars_State_01_Logic_01
.db $01, $04
	.dw InvincibilityStars_State_01_Logic_01
.db $FF, $00

InvincibilityStars_State_00_Logic_01:	;$AF14
	ld      a, (ix+$3F)
	inc     a
	ld      (ix+$02), a
	set     0, (ix+$04)
	ld      hl, $D503
	set     7, (hl)
	jp      VF_Engine_MoveObjectToPlayer


InvincibilityStars_State_01_Logic_01:	;$AF27
	ld      a, ($D532)
	cp      $02
	jr      nz, +
	ld      hl, $D503
	set     7, (hl)
	jp      VF_Engine_MoveObjectToPlayer

+:	ld      (ix+$00), $FF
	ret    

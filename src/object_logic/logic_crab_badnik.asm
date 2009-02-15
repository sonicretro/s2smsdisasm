Logic_Crab:				;$841C
.dw Crab_State_00
.dw Crab_State_01
.dw Crab_State_02
.dw Crab_State_03
Logic_CrabProjectile:	;$8424
.dw CrabProjectile_State_00		;DATA_B28_8597
.dw CrabProjectile_State_01		;DATA_B28_859D

Crab_State_00:		;$8428
.db $01, $00
	.dw Crab_State_00_Logic_01
.db $FF, $00

Crab_State_01:		;$842E
.db $FF, $02
	.dw Crab_State_01_Logic_01
.db $06, $01
	.dw Crab_State_01_Logic_02
.db $06, $02
	.dw Crab_State_01_Logic_02
.db $06, $01
	.dw Crab_State_01_Logic_02
.db $06, $02
	.dw Crab_State_01_Logic_02
.db $06, $01
	.dw Crab_State_01_Logic_02
.db $06, $02
	.dw Crab_State_01_Logic_02
.db $06, $01
	.dw Crab_State_01_Logic_02
.db $06, $02
	.dw Crab_State_01_Logic_02
.db $06, $01
	.dw Crab_State_01_Logic_02
.db $06, $02
	.dw Crab_State_01_Logic_02
.db $06, $01
	.dw Crab_State_01_Logic_02
.db $06, $02
	.dw Crab_State_01_Logic_02
.db $06, $01
	.dw Crab_State_01_Logic_02
.db $06, $02
	.dw Crab_State_01_Logic_02
.db $06, $01
	.dw Crab_State_01_Logic_02
.db $06, $02
	.dw Crab_State_01_Logic_02
.db $06, $01
	.dw Crab_State_01_Logic_02
.db $06, $02
	.dw Crab_State_01_Logic_02
.db $FF, $05
	.db $02		;change object state
.db $06, $02
	.dw VF_DoNothing
.db $FF, $00


Crab_State_02:			;$8483
.db $FF, $02
	.dw Crab_State_02_Logic_01
.db $06, $01
	.dw Crab_State_02_Logic_02
.db $06, $02
	.dw Crab_State_02_Logic_02
.db $06, $01
	.dw Crab_State_02_Logic_02
.db $06, $02
	.dw Crab_State_02_Logic_02
.db $06, $01
	.dw Crab_State_02_Logic_02
.db $06, $02
	.dw Crab_State_02_Logic_02
.db $06, $01
	.dw Crab_State_02_Logic_02
.db $06, $02
	.dw Crab_State_02_Logic_02
.db $06, $01
	.dw Crab_State_02_Logic_02
.db $06, $02
	.dw Crab_State_02_Logic_02
.db $06, $01
	.dw Crab_State_02_Logic_02
.db $06, $02
	.dw Crab_State_02_Logic_02
.db $06, $01
	.dw Crab_State_02_Logic_02
.db $06, $02
	.dw Crab_State_02_Logic_02
.db $06, $01
	.dw Crab_State_02_Logic_02
.db $06, $02
	.dw Crab_State_02_Logic_02
.db $06, $01
	.dw Crab_State_02_Logic_02
.db $06, $02
	.dw Crab_State_02_Logic_02
.db $FF, $05		;set state to $01
	.db $01
.db $06, $02
	.dw VF_DoNothing
.db $FF, $00


Crab_State_03:			;$84D8
.db $FF, $04
	.dw $0000
	.dw $0000
.db $40, $03
	.dw Crab_State_03_Logic_01
.db $FF, $09
	.db SFX_BombBounce
.db $FF, $06		;spawn a fireball projectile
	.db Object_CrabProjectile
	.dw $0000
	.dw $0000
	.db $00
.db $FF, $06		;spawn a fireball projectile
	.db Object_CrabProjectile
	.dw $0000
	.dw $0000
	.db $01
.db $40, $03
	.dw Crab_State_03_Logic_01
.db $FF, $05
	.db $01			;set state
.db $20, $01
	.dw Crab_State_03_Logic_01
.db $FF, $00


Crab_State_00_Logic_01:		;$8502
	ld      (ix+$02), $01
	ld      (ix+$1E), $00
	ret     


;Logic to move the crab right
Crab_State_01_Logic_01:		;$850B
	inc     (ix+$1E)
	res     7, (ix+$0A)		;clear direction flag
	ld      hl, $00C0		;set horizontal speed to 192
	ld      (ix+$17), h
	ld      (ix+$16), l
	ld      hl, $0200		;set vertical speed to 512
	ld      (ix+$18), l
	ld      (ix+$19), h
	ret     

;Logic to move the crab left
Crab_State_02_Logic_01:		;$8525
	set     7, (ix+$0A)		;set direction flag
	ld      hl, $FF40		;set horizontal speed to -192
	ld      (ix+$17), h
	ld      (ix+$16), l
	ld      hl, $0200		;set vertical speed to 512
	ld      (ix+$18), l
	ld      (ix+$19), h
	ret     

Crab_State_01_Logic_02:		;$853C
	bit     6, (ix+$04)
	ret     nz
	call    VF_Engine_UpdateObjectPosition
	call    LABEL_200 + $60
	call    VF_Engine_CheckCollision
	call    Logic_CheckBackgroundCollision
	bit     0, a
	jr      z, LABEL_B28_8558
	ld      (ix+$02), $02		;set state to $02
	jp      LABEL_B28_8594

LABEL_B28_8558:
	ld      a, (ix+$1E)
	cp      $04
	jp      c, LABEL_B28_8594
	ld      a, $03
	ld      (ix+$02), a
	jp      LABEL_B28_8594

Crab_State_02_Logic_02:		;$8568
	bit     6, (ix+$04)
	ret     nz
	call    VF_Engine_UpdateObjectPosition
	call    LABEL_200 + $60
	call    VF_Engine_CheckCollision
	call    Logic_CheckBackgroundCollision
	bit     0, a
	jr      z, +
	ld      (ix+$02), $01
+:	jp      LABEL_B28_8594


Crab_State_03_Logic_01:		;$8584
	ld      (ix+$1E), $00
	call    VF_Engine_UpdateObjectPosition
	call    LABEL_200 + $60
	call    VF_Engine_CheckCollision
	jp      LABEL_B28_8594

LABEL_B28_8594:
	jp      VF_Logic_CheckDestroyObject

CrabProjectile_State_00:		;$8597
.db $01, $00
	.dw CrabProjectile_State_00_Logic_01
.db $FF, $00

CrabProjectile_State_01:		;$859D
.db $04, $01
	.dw CrabProjectile_State_01_Logic_01
.db $04, $02
	.dw CrabProjectile_State_01_Logic_01
.db $FF, $00


CrabProjectile_State_00_Logic_01:	;$85A7
	ld      hl, $0080		;set horizontal speed to 128
	ld      a, (ix+$3F)
	or      a
	jr      z, +			;if this is the first projectile
	ld      hl, $FF80		;set horizontal speed to -128
+:	ld      (ix+$16), l
	ld      (ix+$17), h
	ld      hl, $FC00
	ld      (ix+$18), l		;set vertical speed to -1024
	ld      (ix+$19), h
	ld      (ix+$02), $01	;set state to $01
	ret     

CrabProjectile_State_01_Logic_01:	;$85C7
	call    VF_Engine_UpdateObjectPosition
	ld      l, (ix+$18)			;get vertical speed
	ld      h, (ix+$19)
	ld      de, $0020			;increase by 32
	add     hl, de
	ld      (ix+$18), l			;set vertical speed
	ld      (ix+$19), h
	bit     6, (ix+$04)
	jr      z, +
	ld      (ix+$00), $FF		;destroy the object
+:	call    VF_Engine_CheckCollision
	ld      a, (ix+$21)
	and     $0F
	ret     z
	ld      a, $FF
	ld      ($D3A8), a
	ret     

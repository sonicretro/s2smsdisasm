
Logic_Newtron:			;$B314
.dw Newtron_State_00
.dw Newtron_State_01
.dw Newtron_State_02
.dw Newtron_State_03
.dw Newtron_State_04
.dw Newtron_State_05


;State 00 - initialiser
Newtron_State_00:		;$B320
.db $E0, $00
	.dw Newtron_Init
.db $FF, $00

;State 01 - check player's proximity to the badnik
Newtron_State_01:		;$B326
.db $E0, $00
	.dw Newtron_CheckProximity
.db $FF, $00

;State 02 - flash into view
Newtron_State_02:		;$B32C
.db $01, $04
	.dw Newtron_DoNothing
.db $06, $00
	.dw Newtron_DoNothing
.db $01, $04
	.dw Newtron_DoNothing
.db $05, $00
	.dw Newtron_DoNothing
.db $01, $04
	.dw Newtron_DoNothing
.db $04, $00
	.dw Newtron_DoNothing
.db $01, $04
	.dw Newtron_DoNothing
.db $03, $00
	.dw Newtron_DoNothing
.db $01, $04
	.dw Newtron_DoNothing
.db $02, $00
	.dw Newtron_DoNothing
.db $01, $04
	.dw Newtron_DoNothing
.db $01, $00
	.dw Newtron_DoNothing
.db $01, $03
	.dw Newtron_DoNothing
.db $01, $01
	.dw Newtron_DoNothing
.db $01, $03
	.dw Newtron_DoNothing
.db $01, $01
	.dw Newtron_DoNothing
.db $01, $03
	.dw Newtron_DoNothing
.db $01, $01
	.dw Newtron_DoNothing
.db $01, $03
	.dw Newtron_DoNothing
.db $01, $01
	.dw Newtron_DoNothing
.db $01, $03
	.dw Newtron_DoNothing
.db $01, $01
	.dw Newtron_DoNothing
.db $01, $03
	.dw Newtron_DoNothing
.db $01, $01
	.dw Newtron_DoNothing
.db $01, $03
	.dw Newtron_DoNothing
.db $01, $01
	.dw Newtron_DoNothing
.db $FF, $05		;set state to $03
	.db $03
.db $30, $01
	.dw Newtron_DoNothing
.db $FF, $00

;State 03 - fire a fireball
Newtron_State_03:		;$B39D
.db $FF, $09		;play sound
	.db SFX_BombBounce
.db $FF, $06		;spawn a fireball
	.db Object_Newtron_Fireball
	.dw $0008
	.dw $FFF8
	.db $00
.db $40, $02
	.dw Newtron_CheckCollisions
.db $FF, $05
	.db $04			;set state = $04
.db $01, $02
	.dw VF_DoNothing
.db $FF, $00

;State 05 - flash & disappear
Newtron_State_04:		;$B3B5
.db $01, $03
	.dw Newtron_DoNothing2
.db $01, $01
	.dw Newtron_DoNothing2
.db $01, $03
	.dw Newtron_DoNothing2
.db $01, $01
	.dw Newtron_DoNothing2
.db $01, $03
	.dw Newtron_DoNothing2
.db $01, $00
	.dw Newtron_DoNothing2
.db $01, $03
	.dw Newtron_DoNothing2
.db $01, $00
	.dw Newtron_DoNothing2
.db $01, $03
	.dw Newtron_DoNothing2
.db $01, $00
	.dw Newtron_DoNothing2
.db $01, $03
	.dw Newtron_DoNothing2
.db $03, $00
	.dw Newtron_DoNothing2
.db $01, $04
	.dw Newtron_DoNothing2
.db $03, $00
	.dw Newtron_DoNothing2
.db $01, $04
	.dw Newtron_DoNothing2
.db $03, $00
	.dw Newtron_DoNothing2
.db $FF, $05
	.db $05		;set state to $05
.db $01, $00
	.dw Newtron_DoNothing2
.db $FF, $00


Newtron_State_05:		;$B3FE
.db $E0, $00
	.dw Newtron_Destroy
.db $FF, $00


;initialiser
Newtron_Init:			;$B404
	bit     6, (ix+$04)
	ret     nz
	set     4, (ix+$04)
	ld      (ix+$02), $01	;set state to $01
	ret     


;check player's proximity to this object
Newtron_CheckProximity:		;$B412
	ld      a, $80		;check player's horizontal proximity
	call    Logic_CheckPlayerHorizontalProximity
	or      a
	ret     z			;return if player is to object's right
	
	ld      a, $80		;check player's vertical proximity
	call    Logic_CheckPlayerVerticalProximity
	or      a
	ret     z			;return if player is above object
	
	ld      (ix+$02), $02	;set state to $02
	ret     

	
Newtron_DoNothing:			;$B425
	ret     


;check for collisions with the player object
Newtron_CheckCollisions		;$B426
	call    VF_Engine_CheckCollision
	ld      a, (ix+$21)
	and     $0F
	jp      nz, Newtron_CheckDestroy
	ret     

;FIXME: could be replaced with call to Newtron_DoNothing
Newtron_DoNothing2:			;$B432
	ret     


;destroy this object
Newtron_Destroy:			;$B433
	ld      (ix+$00), $ff
	ld      (ix+$3E), $00
	ret     


;check to see if this object should be destroyed
;by a collision with the player object
Newtron_CheckDestroy:		;$B43C
	ld      (ix+$3F), $40
	jp      VF_Logic_CheckDestroyObject

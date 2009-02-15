Logic_UGZ_Fireball:		;$B5B0
.dw UGZ_Fireball_State_00
.dw UGZ_Fireball_State_01
.dw UGZ_Fireball_State_02
.dw UGZ_Fireball_State_03
.dw UGZ_Fireball_State_04
.dw UGZ_Fireball_State_05

;state 0 - initialiser
UGZ_Fireball_State_00:	;$B5BC
.db $FF, $02
	.dw UGZ_Fireball_Init
.db $FF, $03		;do-nothing stub
;fall through

;state 1 - adjust vertical speed
UGZ_Fireball_State_01:	;$B5C2
.db $20, $01
	.dw UGZ_Fireball_AdjustVerticalSpeed
.db $FF, $00

;state 2 - adjust vertical speed & check vpos against initial
UGZ_Fireball_State_02:	;$B5C8
.db $20, $02
	.dw UGZ_Fireball_AdjustVerticalSpeed_CheckPos
.db $FF, $00

;state 3 - wait a while then change state to 1
UGZ_Fireball_State_03:	;$B5CE
.db $40, $00
	.dw VF_DoNothing
.db $FF, $05		;set state = 01
	.db $01
.db $40, $00
	.dw VF_DoNothing
.db $FF, $00

;state 4 - wait for object to become visible
UGZ_Fireball_State_04:	;$B5DB
.db $E0, $00
	.dw	UGZ_Fireball_WaitForVisible
.db $FF, $00

;state 5 - checks collisions. waits for object
;to become invisible then resets its hpos
UGZ_Fireball_State_05:	;$B5E1
.db $FF, $04
	.dw $0200
	.dw $0000
.db $E0, $03
	.dw UGZ_Fireball_ResetHorizontalPos
.db $FF, $00


UGZ_Fireball_Init:		;$B5ED
	ld      a, (ix+$3F)			;jump if option byte is not set
	or      a
	jp      z, UGZ_Fireball_Init_MoveUp
	
	ld      (ix+$02), $04		;set state 04
	ret     


;resets the fireball's vpos, sets the vertical velocity
;and changes to state 01
UGZ_Fireball_Init_MoveUp:	;$B5F9
	ld      hl, $FB00			;set vertical speed = -1280
	ld      (ix+$18), l
	ld      (ix+$19), h
	
	ld      hl, $0000			;set horizontal speed = 0
	ld      (ix+$16), l
	ld      (ix+$17), h

	ld      l, (ix+$3C)			;copy to initial vpos to current vpos
	ld      h, (ix+$3D)
	ld      (ix+$14), l
	ld      (ix+$15), h

	ld      (ix+$02), $01		;set state 01
	ret     

UGZ_Fireball_AdjustVerticalSpeed:		;$B61C
	ld      de, $0010			;adjust vertical speed
	ld      bc, $0400
	call    VF_Engine_SetObjectVerticalSpeed
	
	bit     7, (ix+$19)			;check collisions if fireball moving down
	jp      nz, UGZ_Fireball_CheckCollision

	ld      (ix+$02), $02		;set state 02
	jp      UGZ_Fireball_CheckCollision		;check collisions


UGZ_Fireball_AdjustVerticalSpeed_CheckPos:		;$B633
	ld      de, $0014			;velocity adjustment
	ld      bc, $0400			;max velocity
	call    VF_Engine_SetObjectVerticalSpeed

	ld      l, (ix+$3C)			;compare current vpos with 
	ld      h, (ix+$3D)			;initial vpos
	ld      e, (ix+$14)
	ld      d, (ix+$15)
	xor     a
	sbc     hl, de
								;jump if current vpos < initial vpos
	jp      nc, UGZ_Fireball_CheckCollision
	
	call    UGZ_Fireball_Init_MoveUp
	
	ld      (ix+$02), $03		;set state 03
	jp      UGZ_Fireball_CheckCollision


UGZ_Fireball_WaitForVisible:		;$B658
	bit     6, (ix+$04)
	ret     nz					;return if object not visible

	ld      (ix+$02), $05		;set state 05
	ret


;waits for the object to become invisible then resets
;its horizontal position
UGZ_Fireball_ResetHorizontalPos:		;$B662
	bit     6, (ix+$04)			;jump if object is object visible
	jp      z, UGZ_Fireball_CheckCollision

	ld      (ix+$02), $04		;set state 04
	
	ld      l, (ix+$3A)			;copy initial hpos...
	ld      h, (ix+$3B)
	ld      (ix+$11), l			;...to current hpos
	ld      (ix+$12), h
	
	jp      UGZ_Fireball_CheckCollision

	
UGZ_Fireball_CheckCollision:		;$B67C
	call    VF_Engine_UpdateObjectPosition
	call    VF_Engine_CheckCollision
	ld      a, (ix+$21)
	and     $0F
	ret     z				;return if no collision
	
	ld      a, $FF			;set "player hurt" trigger
	ld      ($D3A8), a

	ret     

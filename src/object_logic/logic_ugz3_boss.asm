Logic_UGZ3_Robotnik:			;$A39D
.dw UGZ3_Robotnik_State_00
.dw UGZ3_Robotnik_State_01
.dw UGZ3_Robotnik_State_02
.dw UGZ3_Robotnik_State_03
.dw UGZ3_Robotnik_State_04
.dw UGZ3_Robotnik_State_05
.dw UGZ3_Robotnik_State_06
.dw UGZ3_Robotnik_State_07
.dw UGZ3_Robotnik_State_08
.dw UGZ3_Robotnik_State_09
.dw UGZ3_Robotnik_State_0A
.dw UGZ3_Robotnik_State_0B

Logic_UGZ3_CannonBall:			;$A3B5
.dw UGZ3_CannonBall_State_00
.dw UGZ3_CannonBall_State_01

UGZ3_CannonBall_State_00:		;$A3B9
.db $FF, $02
	.dw UGZ3_CannonBall_State_00_Logic_01	;LABEL_B28_A3C8
.db $FF, $05		;change sprite state to $01
	.db $01
.db $FF, $03

UGZ3_CannonBall_State_01:		;$A3C2
.db $E0, $01
	.dw UGZ3_CannonBall_State_01_Logic_01
.db $FF, $00

UGZ3_CannonBall_State_00_Logic_01:		;$A3C8
	ld      a, $FF
	ld      ($D4A2), a
	ld      hl, $0100
	ld      a, ($D2B9)
	ld      e, a
	ld      d, $00
	add     hl, de
	ld      (ix+$16), l		;set horizontal velocity
	ld      (ix+$17), h
	ret     

UGZ3_CannonBall_State_01_Logic_01:		;$A3DE
	call    LABEL_200 + $60
	call    LABEL_200 + $1B
	ld      a, (ix+$21)
	and     $0F
	jp      z, LABEL_B28_A3F4
	ld      a, $FF
	ld      ($D3A8), a
	jp      VF_Engine_DisplayExplosionObject

LABEL_B28_A3F4:
	call    VF_Engine_UpdateObjectPosition
	ld      de, $0060		;value to adjust by
	ld      bc, $0600		;maximum velocity
	call    VF_Engine_SetObjectVerticalSpeed
	bit     1, (ix+$22)
	jr      z, LABEL_B28_A42C
	bit     6, (ix+$04)
	jr      nz, +
	ld      a, SFX_BombBounce
	ld      ($DD04), a
+:	ld      e, (ix+$18)		;get vertical velocity
	ld      d, (ix+$19)
	bit     7, d			;is sprite moving up?
	jr      nz, +
	ld      hl, $0080
	xor     a
	sbc     hl, de
	jr      c, ++
	ld      hl, $0000
++:	ld      (ix+$18), l		;set vertical velocity
	ld      (ix+$19), h
LABEL_B28_A42C:
+:	ld      h, (ix+$12)		;get horizontal pos
	ld      l, (ix+$11)
	ld      de, $0DA0
	xor     a
	sbc     hl, de
	ret     c				;return if hpos < $DA0
	ld      h, (ix+$15)		;get vertical pos
	ld      l, (ix+$14)
	ld      de, $0120
	xor     a
	sbc     hl, de
	ret     c				;return if vpos < $120
	ld      a, ($D46B)
	call    VF_Engine_GetObjectDescriptorPointer
	push    hl
	pop     iy
	ld      a, (iy+$01)
	cp      $02
	jp      z, VF_Engine_DisplayExplosionObject
	ld      a, (iy+$02)
	cp      $03
	jr      z, +
	ld      a, (ix+$01)
	cp      $03
	jr      z, +
	ld      (iy+$02), $02
	ld      (iy+$1e), $40
	dec     (iy+$24)
	jp      nz, VF_Engine_DisplayExplosionObject
	ld      a, ($d46a)
	call    VF_Engine_GetObjectDescriptorPointer
	push    hl
	pop     iy
	ld      (iy+$02), $07
+:	jp      VF_Engine_DisplayExplosionObject


UGZ3_Robotnik_State_00:		;$A483
.db $E0, $01
	.dw UGZ3_Robotnik_State_00_Logic_01
.db $FF, $08
	.db $17
.db $01, $01
	.dw VF_DoNothing
.db $FF, $02
	.dw UGZ3_Robotnik_State_00_Logic_02
.db $FF, $05
	.db $01
.db $01, $01
	.dw VF_DoNothing
.db $FF, $03


UGZ3_Robotnik_State_00_Logic_01:		;$A49B
	ld      (ix+$07), $e0
	ld      hl, ($D514)
	ld      de, $0210
	xor     a
	sbc     hl, de
	ret     c
	ld      (ix+$07), $01
	ret     

UGZ3_Robotnik_State_01:		;$A4AE
.db $04, $03
	.dw UGZ3_Robotnik_State_01_Logic_01
.db $04, $04
	.dw UGZ3_Robotnik_State_01_Logic_01
.db $FF, $00

UGZ3_Robotnik_State_02:		;$A4B8
.db $04, $03
	.dw UGZ_Robotnik_State_02_Logic_01
.db $04, $04
	.dw UGZ_Robotnik_State_02_Logic_01
.db $FF, $00

UGZ3_Robotnik_State_03:		;$A4C2
.db $E0, $02
	.dw UGZ3_Robotnik_State_03_Logic_01
.db $FF, $00

UGZ3_Robotnik_State_04:		;$A4C8
.db $E0, $02
	.dw UGZ3_Robotnik_State_04_Logic_01
.db $FF, $00

UGZ3_Robotnik_State_05:		;$A4CE
.db $04, $03
	.dw UGZ3_Robotnik_State_05_Logic_01
.db $04, $04
	.dw UGZ3_Robotnik_State_05_Logic_01
.db $FF, $00

UGZ3_Robotnik_State_06:		;$A4D8
.db $10, $03
	.dw VF_DoNothing
.db $FF, $06		;spawn a cannon ball
	.db Object_UGZ_CannonBall
	.dw $0000
	.dw $0018
	.db $00
.db $E0, $04
	.dw VF_DoNothing
.db $FF, $00

UGZ3_Robotnik_State_07:		;$A4EA
.db $E0, $01
	.dw UGZ3_Robotnik_State_07_Logic_01
.db $FF, $00

UGZ3_Robotnik_State_08:		;$A4F0
.db $20, $01
	.dw VF_DoNothing
.db $FF, $05
	.db $09
.db $10, $01
	.dw VF_DoNothing
.db $FF, $00

UGZ3_Robotnik_State_09:		;$A4FD
.db $08, $03
	.dw UGZ3_Robotnik_State_09_Logic_01
.db $08, $04
	.dw UGZ3_Robotnik_State_09_Logic_01
.db $08, $03
	.dw UGZ3_Robotnik_State_09_Logic_01
.db $FF, $06	;spawn an explosion object
	.db Object_Explosion
	.dw $FFFC	;offset from current object's hpos
	.dw $FFF0	;offset from current object's vpos
	.db $00	
.db $08, $04
	.dw UGZ3_Robotnik_State_09_Logic_01
.db $08, $03
	.dw UGZ3_Robotnik_State_09_Logic_01
.db $FF, $06	;spawn an explosion object
	.db Object_Explosion
	.dw $0004
	.dw $FFF8
	.db $00
.db $08, $04
	.dw UGZ3_Robotnik_State_09_Logic_01
.db $FF, $00

;**************************
;*	lift player 
UGZ3_Robotnik_State_0A:		;$A527
.db $E0, $02
	.dw UGZ3_Robotnik_State_0A_Logic_01
.db $FF, $00

;**************************
;*	grab player
UGZ3_Robotnik_State_0B:		;$A52D
.db $E0, $02
	.dw UGZ3_Robotnik_State_0B_Logic_01
.db $FF, $00


UGZ3_Robotnik_State_00_Logic_02:		;A553
	push    ix
	pop     hl
	call    VF_Engine_GetObjectIndexFromPointer
	ld      ($D46A), a		;store the sprite number
	set     7, (ix+$03)
	ld      hl, ($D174)
	ld      de, $0120
	add     hl, de
	ld      (ix+$11), l		;set horizontal pos
	ld      (ix+$12), h
	ret     

UGZ3_Robotnik_State_01_Logic_01:		;$A54E
	call    VF_Engine_SetMinimumCameraX		;lock camera
	ld      de, $0000
	ld      hl, ($D511)
	ld      bc, $06C0
	call    VF_Logic_MoveHorizontalTowardsObject	;set horizontal position
	call    VF_Engine_UpdateObjectPosition
	ld      hl, ($D176)			;vert. cam pos?
	ld      de, $0050
	add     hl, de
	ld      (ix+$14), l			;set vertical position 80 pixels
	ld      (ix+$15), h			;from the top of the screen
	ld      a, (ix+$16)			;get horizontal speed
	ld      h, (ix+$17)
	or      h
	ret     nz					;bail out if the sprite is moving
	ld      (ix+$02), $02		;change state to $02
	ld      a, Music_Boss		;play the Boss music
	ld      ($DD04), a
	ret     

UGZ_Robotnik_State_02_Logic_01		;$A57F
	call    VF_Engine_SetMinimumCameraX
	ld      hl, ($D511)
	ld      (ix+$11), l
	ld      (ix+$12), h
	ld      hl, $0E00
	ld      (ix+$18), l
	ld      (ix+$19), h
	call    VF_Engine_UpdateObjectPosition
	call    VF_Engine_CheckCollision
	ld      a, (ix+$21)
	and     $0f
	ret     z
	ld      (ix+$02), $0B
	ret     

;****************************************************
;*	Deals with the part where Robotnik grabs sonic.	*
;****************************************************
UGZ3_Robotnik_State_0B_Logic_01:		;$A5A5
	ld      hl, ($D511)		;get player's horizontal pos
	ld      (ix+$11), l		;set as this sprite's hpos
	ld      (ix+$12), h
	ld      hl, ($D514)		;get player's vertical position
	ld      de, $FFE0		;subtract 32 and set as this sprite's vpos
	add     hl, de
	ld      (ix+$14), l
	ld      (ix+$15), h
	ld      de, $0360		;is the sprite's vpos < $360?
	xor     a
	sbc     hl, de
	ret     c				;return if it is
	ld      (ix+$02), $0A
	ld      a, PlayerState_UGZ_Boss
	ld      ($D502), a
	ld      hl, $0000		;set vertical velocity to 0
	ld      (ix+$18), l
	ld      (ix+$19), h
	ret

;****************************************************
;*	Deals with the part where Robotnik lifts sonic.	*
;****************************************************
UGZ3_Robotnik_State_0A_Logic_01:		;$A5D5
	call    VF_Engine_SetMinimumCameraX
	ld      hl, $FE00
	ld      (ix+$18), l		;set vertical velocity
	ld      (ix+$19), h
	ld      hl, $0000
	ld      (ix+$16), l		;set horizontal velocity
	ld      (ix+$17), h
	call    VF_Engine_UpdateObjectPosition
	ld      de, $0000		;added to sprite's hpos and set as player's hpos
	ld      bc, $0020		;added to sprite's vpos and set as player's vpos
	call    UGZ3_Robotnik_SetPlayerPosition
	ld      e, (ix+$14)		;get vertical position
	ld      d, (ix+$15)
	ld      hl, $0060		;is sprite vpos < 96?
	xor     a
	sbc     hl, de
	ret     c
	ld      (ix+$02), $03	;set sprite state to $03
	ld      a, ($D137)
	cp      $22				;check for down + 2 buttons
	ret     nz
	ld      a, ($D2BA)
	cp      $09
	ret     nz
	ld      a, PlayerState_Falling
	ld      ($D502), a
	ld      (ix+$02), $05
	ret     

UGZ3_Robotnik_State_03_Logic_01:		;$A61D
	call    VF_Engine_SetMinimumCameraX
	ld      hl, $0200
	ld      (ix+$16), l		;set horizontal velocity
	ld      (ix+$17), h
	ld      hl, $0000
	ld      (ix+$18), l		;set vertical velocity
	ld      (ix+$19), h
	call    VF_Engine_UpdateObjectPosition
	ld      de, $0000
	ld      bc, $0020
	call    UGZ3_Robotnik_SetPlayerPosition
	ld      e, (ix+$11)		;get horizontal position
	ld      d, (ix+$12)
	ld      hl, $0D50		;check to see if sprite hpos
	xor     a				;is > $D50
	sbc     hl, de
	ret     nc
	ld      (ix+$02), $04	;set sprite state to $04
	ld      hl, $0000
	ld      (ix+$16), l		;set horizontal velocity
	ld      (ix+$17), h
	ret     

UGZ3_Robotnik_State_04_Logic_01:		;$A659
	call    VF_Engine_SetMinimumCameraX
	ld      hl, $0200
	ld      (ix+$18), l		;set vertical velocity
	ld      (ix+$19), h
	call    VF_Engine_UpdateObjectPosition
	ld      de, $0000
	ld      bc, $0020
	call    UGZ3_Robotnik_SetPlayerPosition
	ld      e, (ix+$14)		;vertical position
	ld      d, (ix+$15)
	ld      hl, $00B8
	xor     a
	sbc     hl, de
	ret     nc
	ld      (ix+$02), $05
	ld      hl, $0000
	ld      (ix+$18), l		;set vertical velocity
	ld      (ix+$19), h
	ld      a, PlayerState_Falling
	ld      ($D502), a
	ld      bc, $0CCA
	ld      de, $0078
	call    VF_Engine_SetCameraAndLock
	ret     

UGZ3_Robotnik_State_05_Logic_01:		;$A69A
	ld      hl, $0CA0
	ld      de, $0000
	ld      bc, $0200	;new horizontal velocity
	call    VF_Logic_MoveHorizontalTowardsObject		;ets horizontal velocity
	ld      hl, $0020
	ld      de, $0000
	ld      bc, $0200
	call    VF_Logic_MoveVerticalTowardsObject		;sets vertical velocity
	call    VF_Engine_UpdateObjectPosition
	ld      a, (ix+$16)			;get horizontal velocity
	ld      h, (ix+$17)
	or      h
	ret     nz					;return if the sprite is moving
	ld      a, (ix+$18)			;get the vertical velocity
	ld      h, (ix+$19)
	or      h
	ret     nz
	ld      (ix+$02), $06		;set state $06
	ret     

UGZ3_Robotnik_State_07_Logic_01:		;$A6CA
	res     7, (ix+$03)
	call    VF_Engine_CheckCollision
	call    LABEL_200 + $60
	ld      hl, $0200
	ld      (ix+$18), l		;set vertical velocity
	ld      (ix+$19), h
	ld      hl, $0000
	bit     1, (ix+$22)
	jr      z, +
	ld      hl, $0280
+:	ld      (ix+$16), l		;set horizontal velocity
	ld      (ix+$17), h
	call    VF_Engine_UpdateObjectPosition
	ld      h, (ix+$12)		;get horizontal pos
	ld      l, (ix+$11)
	ld      de, $0DB0
	xor     a
	sbc     hl, de			;is the horiz. pos $DB0?
	ret     c
	ld      (ix+$02), $08	;set the state to $08
	ld      a, ($D46B)		;get the bomb's sprite index
	call    VF_Engine_GetObjectDescriptorPointer
	push    hl
	pop     iy
	ld      (iy+$02), $03	;set the bomb sprite's state
	ret     

UGZ3_Robotnik_State_09_Logic_01:		;$A711
	ld      b, (ix+$1E)
	ld      a, (ix+$1F)
	and     $01
	rlca    
	rlca    
	rlca    
	rlca    
	sub     $08
	add     a, b
	jr      nz, +
	dec     (ix+$1F)
+:	ld      (ix+$1E), a
	ld      l, a
	ld      h, $00
	ld      de, $FE80
	add     hl, de
	ld      (ix+$18), l		;set vertical velocity
	ld      (ix+$19), h
	ld      a, (ix+$1E)
	add     a, $80
	ld      l, a
	ld      h, $00
	ld      de, $FF00
	add     hl, de
	ld      (ix+$16), l		;set horizontal velocity
	ld      (ix+$17), h
	call    VF_Engine_UpdateObjectPosition
	ret     

UGZ3_Robotnik_SetPlayerPosition:		;$A74B
	ld      l, (ix+$11)		;get horizontal position
	ld      h, (ix+$12)
	add     hl, de
	ld      ($D511), hl		;set sonic's horizontal position
	ld      l, (ix+$14)		;get vertical position
	ld      h, (ix+$15)
	add     hl, bc
	ld      ($D514), hl		;set sonic's vertical position
	ret


Logic_UGZ3_Pincers:			;$A760
.dw UGZ3_Pincers_State_00
.dw UGZ3_Pincers_State_01
.dw UGZ3_Pincers_State_02
.dw UGZ3_Pincers_State_03

UGZ3_Pincers_State_00:		;$A768
.db $FF, $02
	.dw UGZ3_Pincers_State_00_Logic_01
.db $FF, $05
	.db $01
.db $E0, $00
	.dw VF_DoNothing
.db $FF, $03

UGZ3_Pincers_State_01:		;$A775
.db $FF, $07
	.dw UGZ3_Pincers_State_01_Logic_01
	.dw LABEL_200 + $1B
.db $FF, $07
	.dw UGZ3_Pincers_State_01_Logic_02
	.dw LABEL_200 + $1B
.db $FF, $00

UGZ3_Pincers_State_02:		;$A783:
.db $08, $03
	.dw UGZ3_Pincers_State_02_Logic_01
.db $08, $05
	.dw UGZ3_Pincers_State_02_Logic_01
.db $FF, $00

UGZ3_Pincers_State_03:		;$A78D
.db $FF, $02
	.dw VF_Score_AddBossValue
.db $08, $04
	.dw VF_DoNothing
.db $FF, $06	;spawn an explosion sprite
	.db Object_Explosion
	.dw $000C
	.dw $FFEC
	.db $05
.db $08, $04
	.dw VF_DoNothing
.db $FF, $06	;spawn an explosion sprite
	.db Object_Explosion
	.dw $FFF4
	.dw $FFEC
	.db $05
.db $08, $04
	.dw VF_DoNothing
.db $FF, $06	;spawn an explosion sprite
	.db Object_Explosion
	.dw $0004
	.dw $FFE8
	.db $05
.db $08, $04
	.dw VF_DoNothing
.db $FF, $06	;spawn an explosion sprite
	.db Object_Explosion
	.dw $FFFC
	.dw $FFE8
	.db $05
.db $08, $04
	.dw VF_DoNothing
.db $FF, $06	;spawn an explosion sprite
	.db Object_Explosion
	.dw $0000
	.dw $FFE4
	.db $05
.db $E0, $00
	.dw VF_DoNothing
.db $08, $00
	.dw UGZ3_Pincers_State_03_Logic_01
.db $FF, $00

UGZ3_Pincers_State_00_Logic_01:		;$A7D7
	push    ix
	pop     hl
	call    VF_Engine_GetObjectIndexFromPointer
	ld      ($D46B), a
	ld      (ix+$24), $06
	ret     

UGZ3_Pincers_State_01_Logic_01:		;$A7E5
	ld      (ix+$06), $01	;set animation frame to $01
	jp      +
UGZ3_Pincers_State_01_Logic_02		;$A7EC
	ld      (ix+$06), $02	;set animation frame to $02
+	ld      a, (ix+$24)
	inc     a
	add     a, a
	ld      (ix+$07), a		;set frame display timer
	ret     

UGZ3_Pincers_State_02_Logic_01:		;$A7F9
	ld      a, (ix+$02)
	cp      $03
	ret     z
	call    LABEL_200 + $1B
	dec     (ix+$1E)
	ret     nz
	ld      (ix+$02), $01
	ret     

UGZ3_Pincers_State_03_Logic_01:		;$A80B
	call    LABEL_200 + $F3
	ld      (ix+$00), $FE
	ret

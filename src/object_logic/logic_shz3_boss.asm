;*
;*	NOTE: Object $36 is also used by this boss but is not included in this file.
;*


;********************************************************
;*	Logic for the second type of bouncing bird robot.	*
;*	These are spawned by the egg capsules rather than	*
;*	the main boss object.								*
;********************************************************
Logic_SHZ3_BirdRobot2:		;$9B15
.dw SHZ3_BirdRobot2_State_00
.dw SHZ3_BirdRobot2_State_01
.dw SHZ3_BirdRobot2_State_02


;State 00 - initialiser
SHZ3_BirdRobot2_State_00:	;$9B1B
.db $FF, $04	;set h/v velocities
	.dw $0000
	.dw $F400
.db $FF, $05	;set state 1
	.db $01
.db $FF, $03


;State 01 - launch bird up
SHZ3_BirdRobot2_State_01:	;$9B26
.db $FF, $07
	.dw SHZ3_BirdRobot2_SetAnimation_1
	.dw SHZ3_BirdRobot2_LaunchUp
.db $FF, $00


;State 02 - bounce bird towards player
SHZ3_BirdRobot2_State_02:	;$9B2E
.db $FF, $07
	.dw SHZ3_BirdRobot2_SetAnimation_1
	.dw SHZ3_BirdRobot2_MainLogic
.db $FF, $07
	.dw SHZ3_BirdRobot2_SetAnimation_2
	.dw SHZ3_BirdRobot2_MainLogic
.db $FF, $07
	.dw SHZ3_BirdRobot2_SetAnimation_3
	.dw SHZ3_BirdRobot2_MainLogic
.db $FF, $00


SHZ3_BirdRobot2_SetAnimation_1:		;$9B42
	ld      b, $01			;for right-facing objects
	ld      c, $04			;for left-facing objects
	jp      SHZ3_BirdRobot2_SetAnimationAttribs

SHZ3_BirdRobot2_SetAnimation_2:		;$9B49
	ld      b, $02			;for right-facing objects
	ld      c, $05			;for left-facing objects
	jp      SHZ3_BirdRobot2_SetAnimationAttribs

SHZ3_BirdRobot2_SetAnimation_3:		;$9B50
	ld      b, $03			;for right-facing objects
	ld      c, $06			;for left-facing objects


;sets the current animation frame number and display timer
SHZ3_BirdRobot2_SetAnimationAttribs:	;$9B54
	bit     7, (ix+$17)		;check object's direction
	jr      z, +			;jump if object is moving right
	
	ld      b, c			;object moving left - use alternate anim
	
+:	ld      (ix+$06), b		;set the object's animation frame number
	ld      (ix+$07), $04	;set the frame display timer
	ret     


;adds to the object's vertical velocity until it
;starts to fall towards the ground
SHZ3_BirdRobot2_LaunchUp:	;$9B63
	call    VF_Engine_UpdateObjectPosition
	ld      de, $0080		;add to the bird's vertical speed
	ld      bc, $0600		;until it starts to fall downwards
	call    VF_Engine_SetObjectVerticalSpeed
	bit     7, (ix+$19)
	ret     nz				;return if the bird is still moving up
	ld      (ix+$02), $02	;set state = $02
	ret     


;make bird bounce & move towards player
SHZ3_BirdRobot2_MainLogic:	;$9B79
	ld      a, ($D46A)		;check the "destroy children" trigger.
	or      a				;jump if flag is set (destroy this object).
	jp      nz, LABEL_B28_9BD5
	
	call    VF_Engine_CheckCollision
	call    VF_Engine_UpdateObjectPosition
	
	ld      de, $0020		;value to adjust speed by
	ld      bc, $0600		;maximum speed
	call    VF_Engine_SetObjectVerticalSpeed
	
	ld      hl, $0200		;bounce speed threshold
	call    LABEL_200 + $12		;make the bird bounce
	
	jp      nz, ++
	
	;calculate the bird's horizontal velocity based on
	;its position, relative to the player.
	ld      hl, ($D511)		;hl = player's hpos
	ld      e, (ix+$11)		;de = bird's hpos
	ld      d, (ix+$12)
	
	ld      bc, $0080		;bird's h-vel if bird is to player's left
	xor     a
	sbc     hl, de
	jr      nc, +			;jump if bird is to left of player
	ld      bc, $FF80		;bird's h-vel if bird is to player's right
	
+:	ld      (ix+$16), c		;set the bird's horizontal velocity
	ld      (ix+$17), b

	ld      h, (ix+$19)		;HL = bird's vertical speed
	ld      l, (ix+$18)
	ld      de, $FD00
	xor     a
	sbc     hl, de
	jr      nc, ++
	ld      (ix+$19), d
	ld      (ix+$18), e

++:	ld      a, (ix+$21)		;check for collisions with the player
	and     $0F
	ret     z				;return if no collision
	ld      a, ($D503)		;get the player object's flags
	bit     1, a
	ret     z				;return if the player is hurt by the collision
	call    SHZ3_Boss_ClearChildIndex
LABEL_B28_9BD5:
	call    VF_Score_AddBadnikValue
	jp      VF_Engine_DisplayExplosionObject



;************************************************
;*	Logic for the egg capsules that create the	*
;*	small bird objects.							*
;************************************************
Logic_SHZ3_EggCapsule:		;$9BDB
.dw SHZ3_EggCapsule_State_00
.dw SHZ3_EggCapsule_State_01
.dw SHZ3_EggCapsule_State_02

;State 0 - intialiser
SHZ3_EggCapsule_State_00:	;$9BE1
.db $FF, $02
	.dw SHZ3_EggCapsule_Init
.db $FF, $03

;State 1
SHZ3_EggCapsule_State_01:	;$9BE7
.db $60, $01
	.dw SHZ3_EggCapsule_CheckCollisions
.db $FF, $06	;spawn a small bird object
	.db Object_SHZ3_SmallBird2
	.dw $0000
	.dw $FFF8
	.db $00
.db $C0, $01
	.dw SHZ3_EggCapsule_CheckCollisions
.db $FF, $00

;State 2
SHZ3_EggCapsule_State_02:	;$9BF9
.db $E0, $01
	.dw LABEL_B28_9C2B
.db $FF, $00


;Initialisation routine - called for State 0
SHZ3_EggCapsule_Init:		;$9BFF
	ld      a, (ix+$3F)
	or      a
	jr      nz, +
	ld      (ix+$02), $01		;set state = 1
	set     7, (ix+$03)
	ret     

+:	ld      (ix+$02), $02		;set state = 2
	ret     

;checks for collisions between the egg capsule and the player
SHZ3_EggCapsule_CheckCollisions:		;$9C13
	call    VF_Engine_CheckCollision
	ld      a, (ix+$21)
	and     $0F
	ret     z					;were there any collisions?
	ld      a, ($D503)			;will the player destroy the badnik?
	bit     1, a
	ret     z
	call    SHZ3_Boss_ClearChildIndex
	call    VF_Score_AddBadnikValue
	jp      VF_Engine_DisplayExplosionObject


LABEL_B28_9C2B:
	call    VF_Engine_CheckCollision
	call    VF_Engine_UpdateObjectPosition
	ld      de, $0010
	ld      bc, $0600
	call    VF_Engine_SetObjectVerticalSpeed
	bit     6, (ix+$04)
	ret     z
	ld      (ix+$00), $FF
	ret     


;************************************************
;*	Logic for the main SHZ boss bird robot.		*
;************************************************
Logic_SHZ3_Boss:		;$9C44
.dw SHZ3_Boss_State_00
.dw SHZ3_Boss_State_01
.dw SHZ3_Boss_State_02
.dw SHZ3_Boss_State_03
.dw SHZ3_Boss_State_04
.dw SHZ3_Boss_State_05
.dw SHZ3_Boss_State_06
.dw SHZ3_Boss_State_07
.dw SHZ3_Boss_State_08
.dw SHZ3_Boss_State_09
.dw SHZ3_Boss_State_0A
.dw SHZ3_Boss_State_0B
.dw SHZ3_Boss_State_0C
;NOTE: SHZ3_Boss_State_0D should come here but is missing.

;state 0 - initialiser
SHZ3_Boss_State_00:		;$9C5E
.db $FF, $09
	.db $09
.db $FF, $02
	.dw SHZ3_Boss_Init
.db $FF, $03

;state 01 - lock the camera
SHZ3_Boss_State_01:		;$9C67
.db $E0, $00
	.dw SHZ3_Boss_SetCamera
.db $FF, $00

;state 02 - load tiles & spawn small bird robots
SHZ3_Boss_State_02:		;$9C6D
.db $FF, $08
	.db $14				;set tile load trigger
.db $40, $00
	.dw VF_DoNothing
.db $FF, $06			;spawn a small bird object
	.db Object_SHZ3_SmallBird1
	.dw $0060
	.dw $FF30
	.db $01
.db $FF, $02
	.dw SHZ3_Boss_StoreChildIndex
.db $10, $00
	.dw VF_DoNothing
.db $FF, $06			;spawn a small bird object
	.db Object_SHZ3_SmallBird1
	.dw $0040
	.dw $FF30
	.db $00
.db $FF, $02
	.dw SHZ3_Boss_StoreChildIndex
.db $10, $00
	.dw VF_DoNothing
.db $FF, $06			;spawn a small bird object
	.db Object_SHZ3_SmallBird1
	.dw $FFA0
	.dw $FF30
	.db $00
.db $FF, $02
	.dw SHZ3_Boss_StoreChildIndex
.db $10, $00
	.dw VF_DoNothing
.db $FF, $06			;spawn a small bird object
	.db Object_SHZ3_SmallBird1
	.dw $FFC0
	.dw $FF30
	.db $00
.db $FF, $02
	.dw SHZ3_Boss_StoreChildIndex
.db $FF, $05
	.db $03
.db $10, $00
	.dw VF_DoNothing
.db $FF, $00

;state 3 - wait for player to destroy eggs & birds
SHZ3_Boss_State_03:		;$9CB9
.db $10, $00
	.dw SHZ3_Boss_CheckNextState
.db $FF, $00

;state 4 - spawn small bird robots
SHZ3_Boss_State_04:		;$9CBF
.db $FF, $06			;spawn a small bird object (alt. logic)
	.db Object_SHZ3_SmallBird2
	.dw $0050
	.dw $FF30
	.db $00
.db $FF, $02
	.dw SHZ3_Boss_StoreChildIndex
.db $10, $00
	.dw VF_DoNothing
.db $FF, $06			;spawn a small bird object (alt. logic)
	.db Object_SHZ3_SmallBird2
	.dw $0030
	.dw $FF30
	.db $00
.db $FF, $02
	.dw SHZ3_Boss_StoreChildIndex
.db $10, $00
	.dw VF_DoNothing
.db $FF, $06			;spawn a small bird object (alt. logic)
	.db Object_SHZ3_SmallBird2
	.dw $FFE0
	.dw $FF30
	.db $00
.db $FF, $02
	.dw SHZ3_Boss_StoreChildIndex
.db $10, $00
	.dw VF_DoNothing
.db $FF, $06			;spawn a small bird object (alt. logic)
	.db Object_SHZ3_SmallBird2
	.dw $FF90
	.dw $FF30
	.db $00
.db $FF, $02
	.dw SHZ3_Boss_StoreChildIndex
.db $FF, $05			;set sprite state = $05
	.db $05
.db $10, $00
	.dw VF_DoNothing
.db $FF, $00

;state 5 - wait for player to destroy birds
SHZ3_Boss_State_05:		;$9D04
.db $10, $00
	.dw SHZ3_Boss_CheckNextState
.db $FF, $00

;state 6 - make player fall through cloud. move camera down
SHZ3_Boss_State_06:		;$9D0A
.db $20, $00
	.dw VF_DoNothing
.db $10, $00
	.dw SHZ3_Boss_MoveCameraDown
.db $10, $00
	.dw VF_DoNothing
.db $FF, $00


;state 7 - spawn the 4 egg capsules 
SHZ3_Boss_State_07:		;$9D18
.db $02, $00
	.dw VF_DoNothing
.db $FF, $06
	.db Object_SHZ3_EggCapsule
	.dw $0050
	.dw $FFF4
	.db $00
.db $FF, $02
	.dw SHZ3_Boss_StoreChildIndex
.db $08, $00
	.dw VF_DoNothing
.db $FF, $06
	.db Object_SHZ3_EggCapsule
	.dw $0030
	.dw $FFF4
	.db $00
.db  $FF, $02
	.dw SHZ3_Boss_StoreChildIndex
.db $10, $00
	.dw VF_DoNothing
.db $FF, $06
	.db Object_SHZ3_EggCapsule
	.dw $FFD0
	.dw $FFF4
	.db $00
.db $FF, $02
	.dw SHZ3_Boss_StoreChildIndex
.db $08, $00
	.dw VF_DoNothing
.db $FF, $06
	.db Object_SHZ3_EggCapsule
	.dw $FF90
	.dw $FFF4
	.db $00
.db $FF, $02
	.dw SHZ3_Boss_StoreChildIndex
.db $80, $00
	.dw VF_DoNothing
.db $FF, $05		;set state = $08
	.db $08
.db $10, $00
	.dw VF_DoNothing
.db $FF, $00


;state 8 - wait for player to destroy egg capsules & birds
SHZ3_Boss_State_08:		;$9D65
.db $10, $00
	.dw SHZ3_Boss_CheckNextState
.db $FF, $00


;state 9 - move the big bird up into view
SHZ3_Boss_State_09:		;$9D6B
.db $FF, $02
	.dw SHZ3_Boss_SetInitialPosision
.db $FF, $04			;set the boss' speed (move up)
	.dw $0000			;horizontal
	.dw $FF00			;vertical
.db $08, $02
	.dw VF_Engine_UpdateObjectPosition
.db $08, $05
	.dw VF_Engine_UpdateObjectPosition
.db $08, $02
	.dw VF_Engine_UpdateObjectPosition
.db $08, $05
	.dw VF_Engine_UpdateObjectPosition
.db $08, $02
	.dw VF_Engine_UpdateObjectPosition
.db $FF, $05			;set state = $0A
	.db $0A
.db $08, $05
	.dw VF_Engine_UpdateObjectPosition
.db $FF, $00


;state 0A - main boss
SHZ3_Boss_State_0A:		;$9D92
.db $08, $02
	.dw SHZ3_Boss_MainLogic
.db $08, $05
	.dw SHZ3_Boss_MainLogic
.db $08, $02
	.dw SHZ3_Boss_MainLogic
.db $08, $05
	.dw SHZ3_Boss_MainLogic
.db $10, $01
	.dw SHZ3_Boss_MainLogic
.db $10, $03
	.dw SHZ3_Boss_MainLogic
.db $FF, $06			;spawn a fireball object
	.db Object_SHZ3_Boss_Fireball
	.dw $0010
	.dw $FFD0
	.db $00
.db $10, $03
	.dw SHZ3_Boss_MainLogic
.db $08, $02
	.dw SHZ3_Boss_MainLogic
.db $08, $05
	.dw SHZ3_Boss_MainLogic
.db $08, $02
	.dw SHZ3_Boss_MainLogic
.db $08, $05
	.dw SHZ3_Boss_MainLogic
.db $FF, $00


;state 0B - after boss <> player collision
SHZ3_Boss_State_0B:		;$9DC8
.db $03, $04
	.dw SHZ3_Boss_CollisionWithPlayer
.db $04, $06
	.dw SHZ3_Boss_CollisionWithPlayer
.db $FF, $00


;state 0C - explosions and score updates
SHZ3_Boss_State_0C:		;$9DD2
.db $FF, $02			;update player's score
	.dw VF_Score_AddBossValue
.db $03, $04
	.dw VF_DoNothing
.db $FF, $06
	.db Object_Explosion
	.dw $000C
	.dw $FFEC
	.db $05
.db $08, $06
	.dw VF_DoNothing
.db $FF, $06
	.db Object_Explosion
	.dw $FFF4
	.dw $FFE8
	.db $05
.db $08, $04
	.dw VF_DoNothing
.db $FF, $06
	.db Object_Explosion
	.dw $0004
	.dw $FFE6
	.db $05
.db $08, $06
	.dw VF_DoNothing
.db $FF, $06
	.db Object_Explosion
	.dw $FFFC
	.dw $FFE4
	.db $05
.db $08, $04
	.dw VF_DoNothing
.db $FF, $06
	.db Object_Explosion
	.dw $0000
	.dw $FFE0
	.db $05
.db $FF, $04		;set velocities (move boss offscreen)
	.dw $0080
	.dw $0100
.db $40, $06
	.dw VF_Engine_UpdateObjectPosition
.db $03, $04
	.dw SHZ3_Boss_SetBossDestroyed
.db $FF, $00

;FIXME: Unused. State $0D does not exist in the above despatch table.
;This sequence doesn't make sense anyway.
SHZ3_Boss_State_0D:		;$9EE2
.db $03, $04
	.dw VF_DoNothing
.db $FF, $06			;spawn a new boss object (why?)
	.db Object_SHZ3_Boss
	.dw $0000
	.dw $0050
	.db $01
.db $FF, $04
	.dw $0100
	.dw $0000
.db $20, $06
	.dw VF_Engine_UpdateObjectPosition
.db $03, $04
	.dw SHZ3_Boss_SetBossDestroyed
.db $FF, $00


;set the "boss destroyed" flag - causes any remaining child 
;bird robot objects to be destroyed
SHZ3_Boss_SetBossDestroyed:		;$9E3E
	ld      a, $FF				;set the "destroy children" trigger
	ld      ($D46A), a
	jp      SHZ3_Boss_ReleaseCamera


;************************************************************
;*	Record a child object's index in the array at $D3BC.	*
;*	This sub should be called after an $FF $06 command (the	*
;*	sprite pointer is expected in IY).						*
;************************************************************
SHZ3_Boss_StoreChildIndex:	;$9E46
	ld      b, $08			;search the 8-element array at
	ld      de, $D3BC		;$D3BC for an empty slot
-:	ld      a, (de)
	or      a				;is element empty?
	jr      z, +
	inc     de				;move to the next element
	djnz    -
	ret

;store the object index
+:	push    iy			;HL = IY
	pop     hl
	push    de			;preserve DE
	call    VF_Engine_GetObjectIndexFromPointer
	pop     de			;restore DE
	ld      (de), a		;store the object's index in the array
	ret     


;************************************************************
;*	Remove the current object from the SHZ3 boss' child 	*
;*	object array at $D3BC. Expects to find a pointer to the *
;*	object's descriptor in IX.								*
;************************************************************
SHZ3_Boss_ClearChildIndex		;$9E5D
	push    ix			;HL = IX (pointer to current object's descriptor)
	pop     hl
	call    VF_Engine_GetObjectIndexFromPointer
	
	ld      c, a		;c = object index
	
	ld      b, $08		;search the 8-element array for the 
	ld      de, $D3BC	;object's index
-:	ld      a, (de)
	cp      c
	jr      z, +		;jump if index found
	inc     de			;move to the next element
	djnz    -
	ret

;remove the object's index from the array
+:	xor     a
	ld      (de), a
	ret


SHZ3_Boss_Init:				;$9E74
	ld      a, $FF				;set boss mode flag?
	ld      ($D4A2), a
	xor     a					;clear the "destroy children" trigger
	ld      ($D46A), a
	
	ld      a, (ix+$3F)			;if the option byte is set in
	or      a					;the sprite layout the game will
	jr      nz, +				;jump here and crash!
	
	ld      (ix+$02), $01		;set state = $01
	ld      (ix+$24), $06		;set the hit counter
	ret     

;FIXME:	this code initialises the object to an invalid state. 
+:	ld      (ix+$02), $0D		;set state = $0D  ($0D does not exist).
	ld      (ix+$24), $08		;set the hit counter
	ret     


;wait for player to enter boss area and lock camera
SHZ3_Boss_SetCamera:		;$9E95
	ld      hl, ($D511)			;HL = player hpos
	ld      e, (ix+$11)			;DE = object's hpos
	ld      d, (ix+$12)
	xor     a
	sbc     hl, de
	ret     c					;return if player is to object's left
	ld      bc, $0814			;new camera x-pos
	ld      de, $003E			;new camera y-pos
	call    VF_Engine_SetCameraAndLock
	ld      (ix+$02), $02		;set state = $02
	ret     


;wait for the player to destroy all egg capsules & birds
;then increment the big bird robot's state
SHZ3_Boss_CheckNextState:		;$9EB0
	ld      b, $08				;search the 8-element child object
	ld      de, $D3BC			;array at $D3BC
	ld      c, $00
	
-:	ld      a, (de)				;or the value at (DE) with C
	or      c
	ld      c, a
	inc     de					;move to the next element
	djnz    -
	
	ld      a, c				;if C is non-zero there are child
	or      a					;objects that the player should
	ret     nz					;destroy first
	
	ld      a, (ix+$01)			;there are no more child objects -
	inc     a					;move to the next state
	ld      (ix+$02), a
	ret     


;Moves the camera down & makes player fall through to the lower area
SHZ3_Boss_MoveCameraDown:		;$9EC8
	call    LABEL_200 + $F3
	
	ld      hl, ($D280)		;set max camera Y pos to min cam y pos
	ld      ($D282), hl
	
	ld      (ix+$02), $07	;set state - $07
	
	ld      a, PlayerState_SHZ3_Boss_Fall
	ld      ($D502), a		;set player state
	ret     


SHZ3_Boss_SetInitialPosision:	;$9EDB
	ld      hl, $0840			;set boss' hpos
	ld      (ix+$11), l
	ld      (ix+$12), h
	ld      hl, $01F0			;set boss' vpos
	ld      (ix+$14), l
	ld      (ix+$15), h
	ret     


;checks collisions & updates object velocities
SHZ3_Boss_MainLogic:			;$9EEE
	call    VF_Engine_UpdateObjectPosition
	call    SHZ3_Boss_SetVelocities
	call    LABEL_200 + $1B		;check collisions
	ld      a, (ix+$21)
	and     $0F
	ret     z					;return if there were no collisions
	ld      (ix+$1F), $40
	set     5, (ix+$04)			;flash the object
	ld      (ix+$02), $0B		;set state = $0B
	ret     


;calculates & sets horizontal & vertical velocities
SHZ3_Boss_SetVelocities:		;$9F0A
	ld      hl, ($D511)			;get player's hpos...
	ld      de, $FFC0			;...and subtract 64.
								;move the boss towards the player
	add     hl, de				;player's adjusted hpos
	ld      de, $0000			;no further adjustment
	ld      bc, $00C0			;desired speed
	call    VF_Logic_MoveHorizontalTowardsObject
								;make the boss move up and down
	inc     (ix+$1E)			;increment the counter
	ld      bc, $0070			;move down
	ld      a, (ix+$1E)
	and     $40
	jr      nz, +	
	ld      bc, $FF90			;move up
+:	ld      (ix+$18), c			;set vertical speed
	ld      (ix+$19), b
	ret     


;decrements hit counter and flash timer
SHZ3_Boss_CollisionWithPlayer:	;$9F31
	call    VF_Engine_UpdateObjectPosition
	call    SHZ3_Boss_SetVelocities
	call    LABEL_200 + $1B		;check collisions
	xor     a
	ld      (ix+$21), a			;reset the collision flags
	dec     (ix+$1f)			;flash counter?
	ret     nz
	res     5, (ix+$04)
	res     7, (ix+$04)
	dec     (ix+$24)			;decrement the hit counter
	jr      z, +				;jump if hit counter == 0
	
	ld      (ix+$02), $0A		;set state = $0A
	ret     

+:	ld      (ix+$02), $0C		;set state = $0C
	ret


SHZ3_Boss_ReleaseCamera:	;$9F59
	ld      hl, $0B00		;set maximum camera X position
	ld      ($D282), hl

	call    VF_Engine_ReleaseCamera
	ld      (ix+$00), $FE
	ret


;************************************************
;*	Logic for the SHZ boss' fireballs objects	*
;************************************************
Logic_SHZ3_Fireball:		;$9F67
.dw SHZ3_Fireball_State_00
.dw SHZ3_Fireball_State_01

;state 00 - initialiser
SHZ3_Fireball_State_00:		;$9F6B
.db $FF, $05		;set state = $01
	.db $01
.db $FF, $03


;state 01 - main logic
SHZ3_Fireball_State_01:		;$9F70
.db $06, $01
	.dw SHZ3_Fireball_MainLogic
.db $06, $02
	.dw SHZ3_Fireball_MainLogic
.db $06, $03
	.dw SHZ3_Fireball_MainLogic
.db $FF, $00

;moves the fireball towards the player & destroys
;it when it moves offscreen.
SHZ3_Fireball_MainLogic:	;$9F7E
	call    VF_Engine_CheckCollision
	ld      a, (ix+$21)
	and     $0F
	jr      z, +			;jump if there were no collisions
	
	ld      a, $FF			;set the "player hurt" trigger
	ld      ($D3A8), a
	
+:	call    VF_Engine_UpdateObjectPosition
	
	ld      hl, ($D514)		;get player's vpos
	ld      de, $FFE8		;Adjustment value for HL
	ld      bc, $00C0		;desired vert. velocity
	call    VF_Logic_MoveVerticalTowardsObject
	
	ld      bc, $0180		;set horizontal velocity
	ld      (ix+$16), c
	ld      (ix+$17), b

	ld      hl, ($D174)		;hl = camera horiz. pos + 1
	inc     h
	ld      e, (ix+$11)		;de = fireball's hpos
	ld      d, (ix+$12)
	xor     a
	sbc     hl, de
	ret     nc				;return if fireball is still on screen
	ld      (ix+$00), $FF	;destroy the fireball object
	ret     

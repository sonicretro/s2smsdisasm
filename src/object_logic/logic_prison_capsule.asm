Logic_PrisonCapsule:		;$9020
.dw PrisonCapsule_State_00
.dw PrisonCapsule_State_01
.dw PrisonCapsule_State_02
.dw PrisonCapsule_State_03
.dw PrisonCapsule_State_04
.dw PrisonCapsule_State_05

;initialiser
PrisonCapsule_State_00:		;$902C
.db $FF, $08			;set PLC value to $10 (prison capsule art)
	.db $10
.db $18, $00
	.dw VF_DoNothing
.db $FF, $06			;spawn special object $06
	.db SpecObj_HideTimerRings
	.dw $0000
	.dw $0000
	.db $00
.db $FF, $08			;set PLC to $11 (animals)
	.db $11
.db $FF, $05			;change state to $04
	.db $04
.db $FF, $03


;makes the prison capsule jitter around by either adding or
;subtracting 96 from the horizontal velocity and adding or
;subtracting 64 from vertical velocity
PrisonCapsule_State_01:		;$9043
.db $04, $01
	.dw PrisonCapsule_AdjustVelocities_a96_a64
.db $04, $01
	.dw PrisonCapsule_AdjustVelocities_s96_a64
.db $04, $01
	.dw PrisonCapsule_AdjustVelocities_s96_s64
.db $04, $01
	.dw PrisonCapsule_AdjustVelocities_a96_s64
.db $04, $01
	.dw PrisonCapsule_AdjustVelocities_s96_s64
.db $04, $01
	.dw PrisonCapsule_AdjustVelocities_a96_s64
.db $04, $01
	.dw PrisonCapsule_AdjustVelocities_a96_a64
.db $04, $01
	.dw PrisonCapsule_AdjustVelocities_s96_a64
.db $02, $01
	.dw PrisonCapsule_AdjustVelocities_s96_a64
.db $02, $01
	.dw PrisonCapsule_AdjustVelocities_a96_a64
.db $02, $01
	.dw PrisonCapsule_AdjustVelocities_a96_s64
.db $02, $01
	.dw PrisonCapsule_AdjustVelocities_s96_s64
.db	$04, $01
	.dw PrisonCapsule_AdjustVelocities_s96_s64
.db $04, $01
	.dw PrisonCapsule_AdjustVelocities_a96_s64
.db $04, $01
	.dw PrisonCapsule_AdjustVelocities_a96_a64
.db $04, $01
	.dw PrisonCapsule_AdjustVelocities_s96_a64
.db $04, $01
	.dw PrisonCapsule_AdjustVelocities_a96_a64
.db $04, $01
	.dw PrisonCapsule_AdjustVelocities_s96_a64
.db	$04, $01
	.dw PrisonCapsule_AdjustVelocities_s96_s64
.db $04, $01
	.dw PrisonCapsule_AdjustVelocities_a96_s64
.db $02, $01
	.dw PrisonCapsule_AdjustVelocities_a96_s64
.db $02, $01
	.dw PrisonCapsule_AdjustVelocities_s96_s64
.db $02, $01
	.dw PrisonCapsule_AdjustVelocities_s96_a64
.db $02, $01
	.dw PrisonCapsule_AdjustVelocities_a96_a64
.db $FF, $00


;first part of end-of-level sequence
PrisonCapsule_State_02:		;$90A5
.db $FF, $04			;set horizontal and vertical speeds
	.dw $0000
	.dw $0000
.db $40, $01
	.dw PrisonCapsule_SetEndOfLevel
.db $10, $02
	.dw PrisonCapsule_SetEndOfLevel
.db $10, $03
	.dw PrisonCapsule_SetEndOfLevel
.db $FF, $02
	.dw LABEL_200 + $2D		;TODO: resets ix+$1F. what's 1f used for?
.db $FF, $05
	.db $03
.db $0C, $03
	.dw PrisonCapsule_SetEndOfLevel
.db $FF, $00


;second part of end-of-level sequence
PrisonCapsule_State_03:		;$90C4
.db $0C, $03
	.dw PrisonCapsule_SetEndOfLevel
.db $FF, $06
	.db Object_Explosion
	.dw $0000
	.dw $FFFF
	.db $00
.db $0C, $03
	.dw PrisonCapsule_SetEndOfLevel
.db $FF, $06
	.db Object_Explosion
	.dw $FFE8
	.dw $FFDC
	.db $00
.db $FF, $02
	.dw PrisonCapsule_CreateAnimal
.db $0C, $03
	.dw PrisonCapsule_SetEndOfLevel
.db $FF, $06
	.db Object_Explosion
	.dw $0008
	.dw $0004
	.db $00
.db $0C, $03
	.dw PrisonCapsule_SetEndOfLevel
.db $FF, $02
	.dw PrisonCapsule_CreateAnimal
.db $FF, $06
	.db Object_Explosion
	.dw $FFF8
	.dw $0000
	.db $00
.db $0C, $03
	.dw PrisonCapsule_SetEndOfLevel
.db $FF, $06
	.db Object_Explosion
	.dw $0018
	.dw $FFDC
	.db $00
.db $0C, $03
	.dw PrisonCapsule_SetEndOfLevel
.db $FF, $06
	.db Object_Explosion
	.dw $FFFA
	.dw $0000
	.db $00
.db $0C, $03
	.dw PrisonCapsule_SetEndOfLevel
.db $FF, $02
	.dw PrisonCapsule_CreateAnimal
.db $0C, $03
	.dw PrisonCapsule_SetEndOfLevel
.db $FF, $00

;sets camera position
PrisonCapsule_State_04:		;$9122
.db $E0, $01,
	.dw PrisonCapsule_LockCamera
.db $FF, $00

PrisonCapsule_State_05:		;$9128
.db $70, $01
	.dw PrisonCapsule_MoveDown
.db $FF, $00


PrisonCapsule_MoveDown:		;$912E
	call    VF_Engine_CheckCollisionAndAdjustPlayer			;test for collisions with player
	
	ld      hl, $00C0
	ld      (ix+$18), l				;set vertical speed
	ld      (ix+$19), h
	call    VF_Engine_UpdateObjectPosition
	
	ld      a, (CurrentLevel)		;get a pointer to the capsule's
	add     a, a					;original v-pos for the current level
	add     a, a
	ld      e, a
	ld      d, $00
	ld      hl, Data_PrisonCapsule_CameraPositions
	add     hl, de
	inc     hl
	inc     hl

	ld      e, (hl)					;get the original vpos
	inc     hl
	ld      d, (hl)

	ld      hl, $0040				;add 64 to the vpos and set as the
	add     hl, de					;object's new vertical position
	ld      e, (ix+$14)
	ld      d, (ix+$15)

	ld      a, d					;check to see if MSB has changed
	and     $80
	ret     nz

	xor     a						;move object back up
	sbc     hl, de
	ret     nc
	
	ld      (ix+$02), $01			;set state = $01
	
	ld      hl, $0000				;set vertical speed to 0
	ld      (ix+$18), l
	ld      (ix+$19), h
	ret     


PrisonCapsule_LockCamera:		;$916E
	call    VF_Engine_SetMinimumCameraX
	set     1, (ix+$04)
	set     7, (ix+$03)
	res     6, (ix+$04)			;clear the "hide object" flag
	
	ld      hl, ($D176)			;get vertical cam position
	ld      de, $FFD8			;subtract 40 from cam pos
	add     hl, de

	ld      (ix+$14), l			;set object's vertical pos so that
	ld      (ix+$15), h			;it appears offscreen (above)
	
	ld      de, ($D174)			;get horiz. cam position
	ld      l, (ix+$11)			;get object's h-pos
	ld      h, (ix+$12)
	xor     a

	sbc     hl, de				;compare object's hpos with camera hpos
	jr      c, +				;jump if object to left of camera

	ld      a, h				;return if the object is too far offscreen
	or      a
	ret     nz

	ld      a, l				;return if the object is too far offscreen
	cp      $80
	ret     nc

+:	ld      (ix+$02), $05		;set state = $05

	ld      a, (CurrentLevel)	;work out where to lock the camera
	add     a, a				;calculate an index into the array
	add     a, a
	ld      e, a
	ld      d, $00
	ld      hl, Data_PrisonCapsule_CameraPositions
	add     hl, de

	ld      c, (hl)				;horizontal lock value
	inc     hl
	ld      b, (hl)
	inc     hl
	
	ld      e, (hl)				;vertical lock value
	inc     hl
	ld      d, (hl)
	call    VF_Engine_SetCameraAndLock		;lock the camera
	ret

Data_PrisonCapsule_CameraPositions:		;$91BB
;		  vertical
;	horiz.   |
;  |------|------|
.dw $0EF4, $0008		;UGZ
.dw $0AF2, $0100		;SHZ
.dw $0EF5, $0080		;ALZ
.dw $1381, $007E		;GHZ
.dw $03F3, $005E		;GMZ
.dw $03F3, $005E		;SEZ
.dw $0DE4, $025E		;CEZ


PrisonCapsule_SetEndOfLevel:	;$91D7
	call    VF_Engine_CheckCollisionAndAdjustPlayer
	
	ld      a, ($D501)			;check player state
	cp      PlayerState_EndOfLevel
	jr      z, +

	ld      a, ($D503)			;check to see if player is jumping
	bit     0, a
	jp      nz, +

	ld      a, PlayerState_EndOfLevel
	ld      ($D502), a			;set player state
	
	ld      a, Music_EndOfLevel
	ld      ($DD04), a			;play end of level music


+:	ld      a, (ix+$1E)			;make the capsule vibrate
	inc     (ix+$1E)
	and     $06
	ld      e, a
	ld      d, $00
	ld      hl, DATA_B28_9207
	add     hl, de
	ld      a, (hl)
	inc     hl
	ld      h, (hl)
	ld      l, a
	jp      (hl)


DATA_B28_9207:
.dw LABEL_B28_9215
.dw LABEL_B28_9225
.dw LABEL_B28_9225
.dw LABEL_B28_9215


;Checks for collisions and adds 96 to horizontal velocity
;and 64 to vertical velocity.
PrisonCapsule_AdjustVelocities_a96_a64:		;$920F
	call    VF_Engine_CheckCollisionAndAdjustPlayer		;check for collisions with player
	call    PrisonCapsule_CheckCollision_SetState2
LABEL_B28_9215:
	call    PrisonCapsule_Add64ToVerticalSpeed
	call    PrisonCapsule_Add96ToHorizontalSpeed
	call    VF_Engine_UpdateObjectPosition
	ret     


;Checks for collisions and subtracts 96 from horizontal velocity
;and 64 from vertical velocity.
PrisonCapsule_AdjustVelocities_s96_s64:
	call    VF_Engine_CheckCollisionAndAdjustPlayer
	call    PrisonCapsule_CheckCollision_SetState2
LABEL_B28_9225:
	call    PrisonCapsule_Sub64FromVerticalSpeed
	call    PrisonCapsule_Sub96FromHorizontalSpeed
	call    VF_Engine_UpdateObjectPosition
	ret     


;Checks for collisions, adds 96 to horizontal velocity
;and subtracts 64 from vertical velocity.
PrisonCapsule_AdjustVelocities_a96_s64:
	call    VF_Engine_CheckCollisionAndAdjustPlayer
	call    PrisonCapsule_CheckCollision_SetState2
	call    PrisonCapsule_Sub64FromVerticalSpeed
	call    PrisonCapsule_Add96ToHorizontalSpeed
	call    VF_Engine_UpdateObjectPosition
	ret     


;Checks for collisions, subtracts 96 from horizontal velocity
;and adds 64 to vertical velocity.
PrisonCapsule_AdjustVelocities_s96_a64:		;$923F
	call    VF_Engine_CheckCollisionAndAdjustPlayer
	call    PrisonCapsule_CheckCollision_SetState2
	call    PrisonCapsule_Add64ToVerticalSpeed
	call    PrisonCapsule_Sub96FromHorizontalSpeed
	call    VF_Engine_UpdateObjectPosition
	ret     

;checks for collisions with the player and, if a collision
;occurred, sets the object's state to $02
PrisonCapsule_CheckCollision_SetState2:		;$924F
	ld      a, (ix+$21)
	and     $0F
	ret     z					;return if there were no collisions
	
	ld      (ix+$02), $02		;set object state = $02
	
	ld      a, SFX_Bomb			;play Bomb sound
	ld      ($DD04), a
	ret     


PrisonCapsule_Add64ToVerticalSpeed:		;$925F
	ld      l, (ix+$18)			;add 64 to object's vertical speed
	ld      h, (ix+$19)
	ld      de, $0040
	add     hl, de
	ld      (ix+$18), l
	ld      (ix+$19), h
	ret     


PrisonCapsule_Add96ToHorizontalSpeed:	;$9270
	ld      l, (ix+$16)			;add 96 to object's vertical speed
	ld      h, (ix+$17)
	ld      de, $0060
	add     hl, de
	ld      (ix+$16), l
	ld      (ix+$17), h
	ret     

PrisonCapsule_Sub64FromVerticalSpeed:	;$9281
	ld      l, (ix+$18)
	ld      h, (ix+$19)
	ld      de, $0040
	xor     a
	sbc     hl, de
	ld      (ix+$18), l
	ld      (ix+$19), h
	ret     

PrisonCapsule_Sub96FromHorizontalSpeed:	;$9294
	ld      l, (ix+$16)
	ld      h, (ix+$17)
	ld      de, $0060
	xor     a
	sbc     hl, de
	ld      (ix+$16), l
	ld      (ix+$17), h
	ret     

PrisonCapsule_CreateAnimal:		;$92A7
	ld      a, (ix+$1F)			;check the animal counter
	cp      $10
	ret     nc					;allocate, at most, 10 objects

	call    VF_Engine_AllocateObjectLowPriority
	ret     c					;return if no slots available

	ld      (iy+$00), Object_PrisonAnimals
	
	ld      l, (ix+$11)			;set the new object's hpos to 
	ld      h, (ix+$12)			;the prison capsule's hpos
	ld      (iy+$11), l
	ld      (iy+$12), h
	
	ld      l, (ix+$14)			;set the new object's vpos to 
	ld      h, (ix+$15)			;the prison capsule's vpos
	ld      (iy+$14), l
	ld      (iy+$15), h
	
	ld      a, (ix+$04)			;set the animals horizontal movement
	and     $10					;flag = to the prison capsule's
	ld      (iy+$04), a

	ld      a, (ix+$08)			;copy VRAM tile indices to from the
	ld      (iy+$08), a			;capsule to the animal object
	ld      a, (ix+$09)
	ld      (iy+$09), a

	ld      a, (CurrentLevel)
	rlca
	rlca
	rlca
	rlca
	add     a, (ix+$1F)
	
	inc     (ix+$1F)			;increment the animal counter
	
	ld      e, a
	ld      d, $00
	ld      hl, DATA_B28_92FA
	add     hl, de
	ld      a, (hl)
	ld      (iy+$3F), a
	ret     

DATA_B28_92FA:
.db $01, $02, $01, $02, $01, $02, $01, $02
.db $01, $02, $01, $02, $01, $02, $01, $02
.db $03, $04, $03, $04, $03, $04, $03, $04
.db $03, $04, $03, $04, $03, $04, $03, $04
.db $05, $06, $05, $06, $05, $06, $05, $06
.db $05, $06, $05, $06, $05, $06, $05, $06
.db $07, $08, $07, $08, $07, $08, $07, $08
.db $07, $08, $07, $08, $07, $08, $07, $08
.db $09, $0A, $09, $0A, $09, $0A, $09, $0A
.db $09, $0A, $09, $0A, $09, $0A, $09, $0A
.db $0B, $0C, $0B, $0C, $0B, $0C, $0B, $0C
.db $0B, $0C, $0B, $0C, $0B, $0C, $0B, $0C
.db $09, $0A, $09, $0A, $09, $0A, $09, $0A
.db $09, $0A, $09, $0A, $09, $0A, $09, $0A

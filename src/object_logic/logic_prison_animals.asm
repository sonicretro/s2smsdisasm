Logic_PrisonAnimals:		;$936A
.dw PrisonAnimals_State_00
.dw PrisonAnimals_State_01
.dw PrisonAnimals_State_02

;initialiser - sets state to 01
PrisonAnimals_State_00:		;$9370
.db $01, $00
	.dw PrisonAnimals_SetState01
.db $FF, $00

PrisonAnimals_State_01:		;$9376
.db $FF, $07
	.dw PrisonAnimals_SetFrame1
	.dw PrisonAnimals_SetFalling
.db $FF, $00

PrisonAnimals_State_02:		;937E
.db $FF, $07
	.dw PrisonAnimals_SetFrame1
	.dw PrisonAnimals_UpdateSpeed
.db $FF, $07
	.dw PrisonAnimals_SetFrame2
	.dw PrisonAnimals_UpdateSpeed
.db $FF, $00


PrisonAnimals_SetState01:	;$938C
	ld      (ix+$02), $01
	ret     

;sets the first animation frame
PrisonAnimals_SetFrame1:		;$9391
	ld      (ix+$07), $05		;set frame display time
	
	ld      a, (ix+$3F)			;calculate and set frame number
	dec     a
	add     a, a
	inc     a
	ld      (ix+$06), a

	ret

;sets the second animation frame
PrisonAnimals_SetFrame2:		;$939F
	ld      (ix+$07), $05		;set frame display time
	
	ld      a, (ix+$3F)			;calculate and set frame number
	dec     a
	add     a, a
	inc     a
	inc     a
	ld      (ix+$06), a
	
	ret

;make the animal fall out of the prison capsule
PrisonAnimals_SetFalling:		;$93AE
	ld      de, $0020			;set the object's vertical speed
	ld      bc, $0400
	call    VF_Engine_SetObjectVerticalSpeed
	call    VF_Engine_UpdateObjectPosition

	ld      bc, $0000			;check for collisions with the level blocks
	ld      de, $0000
	call    VF_Engine_GetCollisionValueForBlock
	cp      $00
	ret     z					;return if no collision

	ld      (ix+$02), $02		;set state = $02
	
	ld      a, (ix+$3F)			;set the object's horizontal speed based on the
	ld      d, $FE				;value at ix+$3F (the object parameter)
	and     $01
	jr      z, +
	ld      d, $02
+:	ld      (ix+$17), d			

	ret     


PrisonAnimals_UpdateSpeed:		;$93D9
	bit     6, (ix+$04)			;destroy the object if not visible
	jp      nz, PrisonAnimals_Destroy

	ld      de, $0040			;update the object's vertical speed
	ld      bc, $0600
	call    VF_Engine_SetObjectVerticalSpeed
	call    VF_Engine_UpdateObjectPosition

	ld      bc, $0000			;collide with the background tiles
	ld      de, $0000
	call    VF_Engine_GetCollisionValueForBlock
	cp      $00
	ret     z					;return if no collision

	ld      l, (ix+$18)			;get the object's vertical speed
	ld      h, (ix+$19)
	bit     7, h
	ret     nz					;return if the object is moving up

	ex      de, hl				;DE = object's vertical speed
	ld      hl, $0040
	xor     a
	sbc     hl, de				;subtract 64 from vertical speed
	jr      c, +				;jump if speed now < 0
	
	ld      hl, $0000			;set speed = 0
	
+:	ld      (ix+$18), l			;set vertical speed
	ld      (ix+$19), h
	ret


PrisonAnimals_Destroy:			;$9414
	ld      (ix+$00), $FF		;destroy the object
	ret     

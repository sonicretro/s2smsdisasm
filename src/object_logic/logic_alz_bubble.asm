Logic_ALZ_Bubble:		;$B13F
.dw ALZ_Bubble_State_00
.dw ALZ_Bubble_State_01
.dw	ALZ_Bubble_State_02
.dw ALZ_Bubble_State_03
.dw ALZ_Bubble_State_04
.dw ALZ_Bubble_State_05
.dw ALZ_Bubble_State_06
.dw ALZ_Bubble_State_07
.dw ALZ_Bubble_State_08
.dw ALZ_Bubble_State_09
.dw ALZ_Bubble_State_0A


ALZ_Bubble_State_00:	;$B155
.db $FF, $02
	.dw LABEL_B31_B22D
.db $FF, $03		;calls the do-nothing stub (?)

ALZ_Bubble_State_01:	;$B15B
.db $10, $00
	.dw VF_DoNothing
.db $FF, $07
	.dw LABEL_B31_B375
	.dw VF_DoNothing
.db $FF, $07
	.dw LABEL_B31_B375
	.dw VF_DoNothing
.db $FF, $07
	.dw LABEL_B31_B375
	.dw VF_DoNothing
.db $FF, $02
	.dw LABEL_B31_B3BD
.db $FF, $02
	.dw Logic_ALZ_Bubble_SetPosition
.db $FF, $06
	.db $0A
	.dw $0000
	.dw $0000
	.db $01
.db $FF, $04
	.dw $0000
	.dw $FF80
.db $C0, $04
	.dw LABEL_B31_B245		;updates horizontal speed
.db $FF, $05
	.db $02
.db $01, $04
	.dw LABEL_B31_B245		;updates horizontal speed
.db $FF, $00

ALZ_Bubble_State_02:	;$B194
.db $E0, $04
	.dw LABEL_B31_B24C
.db $FF, $00

ALZ_Bubble_State_03:	;$B19A
.db $10, $00
	.dw VF_DoNothing
.db $FF, $02
	.dw Logic_ALZ_Bubble_SetPosition
.db $FF, $04
	.dw $0000
	.dw $FF60
.db $10, $03
	.dw Logic_Bubble_SetHorizontalSpeed
.db $10, $02
	.dw Logic_Bubble_SetHorizontalSpeed
.db $FF, $05
	.db $04
.db $10, $02
	.dw Logic_Bubble_SetHorizontalSpeed
.db $FF, $00

ALZ_Bubble_State_04:	;$B1B9
.db $10, $01
	.dw	LABEL_B31_B250
.db $FF, $00

ALZ_Bubble_State_05:	;$B1BF
.db $20, $00
	.dw VF_DoNothing
.db $FF, $02
	.dw Logic_ALZ_Bubble_SetPosition
.db $FF, $07
	.dw LABEL_B31_B375
	.dw VF_DoNothing
.db $FF, $07
	.dw LABEL_B31_B375
	.dw VF_DoNothing
.db $FF, $04
	.dw $0000
	.dw $FF80
.db $10, $03
	.dw Logic_Bubble_SetHorizontalSpeed
.db $10, $02
	.dw Logic_Bubble_SetHorizontalSpeed
.db $10, $01
	.dw Logic_Bubble_SetHorizontalSpeed
.db $FF, $05
	.db $06		;set state = $06
.db $10, $01
	.dw Logic_Bubble_SetHorizontalSpeed
.db $FF, $00

ALZ_Bubble_State_06:	;$B1EE
.db $10, $05
	.dw LABEL_B31_B272
.db $FF, $00

ALZ_Bubble_State_07:	;$B1F4
.db $FF, $04
	.dw $0000
	.dw $FF80
.db $FF, $02
	.dw Logic_ALZ_Bubble_GetPlayerPos
.db $FF, $02
	.dw Logic_ALZ_Bubble_SetPosition
.db $FF, $02
	.dw LABEL_B31_B35E
.db $10, $03
	.dw Logic_Bubble_SetHorizontalSpeed
.db $FF, $05
	.db $08
.db $10, $03
	.dw	Logic_Bubble_SetHorizontalSpeed
.db $FF, $00

ALZ_Bubble_State_08:	;$B213
.db $E0, $06
	.dw	LABEL_B31_B3D2
.db $FF, $00

ALZ_Bubble_State_09:	;$B219
.db $10, $01
	.dw	Logic_Bubble_SetHorizontalSpeed
.db $30, $00
	.dw VF_DoNothing
.db $30, $00
	.dw LABEL_B31_B4CE
.db $FF, $00

ALZ_Bubble_State_0A:	;$B227
.db $E0, $00
	.dw LABEL_B31_B2B6
.db $FF, $00

LABEL_B31_B22D:
	ld      a, (ix+$3f)
	add     a, a
	inc     a
	ld      (ix+$02), a
	set     7, (ix+$03)
	cp      $07
	ret     nz
	set     1, (ix+$04)
	res     6, (ix+$04)
	ret     

LABEL_B31_B245:
	call    LABEL_B31_B3F2
	call    Logic_Bubble_SetHorizontalSpeed
	ret     

LABEL_B31_B24C:
	call    LABEL_B31_B3D2
	ret     

LABEL_B31_B250:
	call    LABEL_B31_B3D2
	call    VF_Engine_CheckCollision
	ld      a, (ix+$21)
	and     $0F
	ret     z
	ld      a, ($D501)
	cp      $1F
	ret     z
	cp      $28
	ret     z
	cp      $21
	ret     z
	ld      (ix+$02), $09
	ld      a, $25
	ld      ($D502), a
	ret     

LABEL_B31_B272:
	call    LABEL_B31_B3D2
	call    VF_Engine_CheckCollision
	ld      a, (ix+$21)
	and     $0F
	ret     z
	ld      a, ($D501)
	cp      PlayerState_LostLife
	ret     z
	cp      $28
	ret     z
	cp      $21
	ret     z
	ld      hl, ($D511)		;get player's hpos
	ld      (ix+$11), l		;set as object's hpos
	ld      (ix+$12), h
	ld      hl, ($D514)		;get player's vpos
	ld      (ix+$14), l		;set as object's vpos
	ld      (ix+$15), h
	ld      a, PlayerState_ALZ_Bubble
	ld      ($D502), a		;set player's state
	xor     a
	ld      ($D521), a
	ld      ($D503), a
	ld      (ix+$02), $0A	;set the bubble's state to $0A
	ld      hl, $FF00		;set vertical speed to -256
	ld      (ix+$18), l
	ld      (ix+$19), h
	ret     

LABEL_B31_B2B6:
	call    LABEL_B31_B3D2
	call    LABEL_B31_B311
	ld      l, (ix+$11)
	ld      h, (ix+$12)
	ld      ($D511), hl		;move player to bubble's hpos
	ld      l, (ix+$14)		
	ld      h, (ix+$15)
	ld      ($D514), hl		;move player to bubble's vpos
	ld      a, (ix+$00)
	cp      $0A
	jp      nz, LABEL_B31_B307
	
	ld      bc, $0000		;check for collision at top of bubble
	ld      de, $FFE0
	call    VF_Engine_GetCollisionValueForBlock	
	cp      $81
	jp      z, LABEL_B31_B307
	
	ld      bc, $FFF0		;check for collision at left of bubble
	ld      de, $FFF0
	call    VF_Engine_GetCollisionValueForBlock
	cp      $81
	jr      z, LABEL_B31_B307
	
	ld      bc, $0010		;check for collision at right of bubble
	ld      de, $FFF0
	call    VF_Engine_GetCollisionValueForBlock
	cp      $81
	jr      z, LABEL_B31_B307
	
	ld      a, ($D501)
	cp      PlayerState_ALZ_Bubble	;is player still caught in the bubble?
	ret     z
	jp      LABEL_B31_B30C

LABEL_B31_B307:
	ld      a, PlayerState_Falling
	ld      ($D502), a
LABEL_B31_B30C:
	ld      (ix+$02), $05
	ret     

LABEL_B31_B311:
	ld      a, ($D137)
	and     $0C				;check for left/right buttons
	jp      z, LABEL_B31_B341
	ld      hl, $0100		;move right
	and     $08
	jr      nz, +
	ld      hl, $FF00		;move left
+:	ld      (ix+$16), l		;set horizontal speed
	ld      (ix+$17), h
	ld      l, (ix+$18)		;get vertical speed
	ld      h, (ix+$19)
	push    hl
	xor     a
	ld      (ix+$18), a		;set vertical speed to 0
	ld      (ix+$19), a
	call    VF_Engine_UpdateObjectPosition
	pop     hl
	ld      (ix+$18), l		;restore vertical speed
	ld      (ix+$19), h
LABEL_B31_B341:
	ld      a, ($D137)
	ld      b, a
	ld      hl, $FF00
	and     $01				;is up button pressed?
	jr      nz, +
	ld      a, b
	and     $02				;is down button pressed
	ld      hl, $FF80
	jr      z, +
	ld      hl, $FFD0
+:	ld      (ix+$18), l		;set the vertical speed
	ld      (ix+$19), h
	ret     

LABEL_B31_B35E:
	ld      (ix+$08), $CE	;set VRAM tile index (right facing)
	ld      (ix+$09), $CE	;set VRAM tile index (left facing)
	ld      a, ($D2B9)
	and     $01
	set     4, (ix+$04)
	ret     z
	res     4, (ix+$04)
	ret     

LABEL_B31_B375:
	push    ix
	pop     hl
	call    VF_Engine_GetObjectIndexFromPointer
	add     a, a
	ld      b, a
	ld      a, ($D2B9)
	add     a, b
	and     $3F
	add     a, $40
	ld      (ix+$07), a
	ld      (ix+$06), $00
	ret     


Logic_ALZ_Bubble_SetPosition:		;$B38D
	ld      a, (ix+$3A)		;set horizontal pos
	ld      (ix+$11), a
	ld      a, (ix+$3B)
	ld      (ix+$12), a
	ld      a, (ix+$3C)		;set vertical pos
	ld      (ix+$14), a
	ld      a, (ix+$3D)
	ld      (ix+$15), a
	ret     

Logic_ALZ_Bubble_GetPlayerPos:		;$B3A6
	ld      hl, ($D511)		;copy player's hpos to IX+$3A
	ld      (ix+$3A), l
	ld      (ix+$3B), h
	ld      hl, ($D514)		;copy player's vpos-24 to IX+$3C
	ld      de, $FFE8
	add     hl, de
	ld      (ix+$3C), l
	ld      (ix+$3D), h
	ret     

LABEL_B31_B3BD:
	ld      hl, $D3CE
	ld      b, $20
	xor     a
-:	ld      (hl), a
	inc     hl
	djnz    -
	ld      hl, $D3EE
	ld      b, $10
	xor     a
-:	ld      (hl), a
	inc     hl
	djnz    -
	ret     

LABEL_B31_B3D2:
	call    Logic_Bubble_SetHorizontalSpeed
	call    LABEL_B31_B4A0
	ret     

Logic_Bubble_SetHorizontalSpeed:	;$B3D9
	inc     (ix+$1E)
	ld      hl, $0040		;horiz speed = 64
	bit     4, (ix+$1E)		;16th frame?
	jr      z, +
	ld      hl, $FFC0		;horiz speed = -64
+:	ld      (ix+$16), l
	ld      (ix+$17), h
	call    VF_Engine_UpdateObjectPosition
	ret     

LABEL_B31_B3F2:
	push    ix
	ld      b, $06
	ld      iy, $D3CE
	ld      ix, $D3EE
LABEL_B31_B3FE:
	ld      a, ($D2B9)
	rrca    
	rrca    
	rrca    
	rrca    
	and     $03
	add     a, a
	add     a, b
	dec     a
	add     a, a
	add     a, a
	ld      e, a
	ld      d, $00
	ld      hl, DATA_B31_B470
	add     hl, de
	ld      e, (hl)
	inc     hl
	ld      d, (hl)
	push    hl
	ld      hl, $FFF4
	add     hl, de
	ld      a, ($D2B9)
	and     $0F
	add     a, b
	ld      e, a
	ld      d, $00
	add     hl, de
	ex      de, hl
	ld      l, (ix+$01)
	ld      h, (iy+$02)
	ld      c, (iy+$03)
	ld      a, d
	and     $80
	rlca    
	dec     a
	cpl     
	add     hl, de
	adc     a, c
	ld      (iy+$03), a
	ld      (ix+$01), l
	ld      (iy+$02), h
	pop     hl
	inc     hl
	ld      e, (hl)
	inc     hl
	ld      d, (hl)
	ld      l, (ix+$00)
	ld      h, (iy+$00)
	ld      c, (iy+$01)
	ld      a, d
	and     $80
	rlca    
	dec     a
	cpl     
	add     hl, de
	adc     a, c
	ld      (iy+$01), a
	ld      (ix+$00), l
	ld      (iy+$00), h
	ld      de, $0004
	add     iy, de
	ld      de, $0002
	add     ix, de
	dec     b
	jp      nz, LABEL_B31_B3FE
	pop     ix
	ret     

DATA_B31_B470:
.dw $0004, $FFF8, $FFFC, $FFF4
.dw $0010, $FFE0, $FFF0, $FFD8
.dw $001C, $FFF0, $FFE4, $FFEE
.dw $FFFC, $FFFC, $0004, $FFF6
.dw $FFF0, $FFE4, $0010, $FFDA
.dw $FFE8, $FFED, $0018, $FFF1


LABEL_B31_B4A0:
	ld      de, ($D176)		;vert cam pos
	ld      l, (ix+$14)		;get vpos
	ld      h, (ix+$15)
	xor     a
	sbc     hl, de			;calculate object's position on screen
	jr      c, LABEL_B31_B4CE	;jump if object not on screen
	ld      a, h
	cp      $02
	jp      nc, LABEL_B31_B4CE
	ld      a, (CurrentAct)
	dec     a
	jp      z, LABEL_B31_B4D3
	ld      de, $FFD0
	ld      bc, $0000
	call    VF_Engine_GetCollisionValueForBlock
	cp      $00
	jr      z, LABEL_B31_B4CE
	cp      $81
	jr      z, LABEL_B31_B4CE
	ret
	
LABEL_B31_B4CE:			;destroy the object
	ld      (ix+$00), $ff
	ret     

LABEL_B31_B4D3:
	ret

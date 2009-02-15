Logic_Minecart:			;$88CF
.dw Minecart_State_00
.dw Minecart_State_01
.dw Minecart_State_02
.dw Minecart_State_03
.dw Minecart_State_04
.dw Minecart_State_05
.dw Minecart_State_06

Minecart_State_00:			;$88DD
.db $01, $00
	.dw Minecart_State_00_Logic_01
.db $FF, $00

Minecart_State_01:			;$88E3
.db $FF, $04
	.dw $0000
	.dw $0100
.db $80, $01
	.dw Minecart_State_01_Logic_01
.db $FF, $00

Minecart_State_02:			;$88EF
.db $03, $01
	.dw Minecart_State_02_Logic_01
.db $03, $02
	.dw Minecart_State_02_Logic_01
.db $03, $03
	.dw Minecart_State_02_Logic_01
.db $03, $04
	.dw Minecart_State_02_Logic_01
.db $FF, $00

Minecart_State_03:			;$8901
.db $03, $04
	.dw Minecart_State_03_Logic_01
.db $03, $03
	.dw Minecart_State_03_Logic_01
.db $03, $02
	.dw Minecart_State_03_Logic_01
.db $03, $01
	.dw Minecart_State_03_Logic_01
.db $FF, $00

Minecart_State_04:			;$8913
.db $03, $01
	.dw Minecart_State_04_Logic_01
.db $03, $02
	.dw Minecart_State_04_Logic_01
.db $03, $03
	.dw Minecart_State_04_Logic_01
.db $03, $04
	.dw Minecart_State_04_Logic_01
.db $FF, $00

Minecart_State_05:			;$8925
.db $06, $01
	.dw Minecart_State_05_Logic_01
.db $06, $02
	.dw Minecart_State_05_Logic_01
.db $06, $03
	.dw Minecart_State_05_Logic_01
.db $06, $04
	.dw Minecart_State_05_Logic_01
.db $FF, $00

Minecart_State_06:			;$8937
.db $10, $05
	.dw Minecart_State_06_Logic_01
.db $03, $00
	.dw Minecart_State_06_Logic_01
.db $03, $05
	.dw Minecart_State_06_Logic_01
.db $03, $00
	.dw Minecart_State_06_Logic_01
.db $03, $05
	.dw Minecart_State_06_Logic_01
.db $FF, $01


;setup the minecart 
Minecart_State_00_Logic_01:		;$894D
	ld		(ix+$02), $01	;set state to $01
	ret

Minecart_State_01_Logic_01:		;$8952
	bit		6, (ix+$04)
	ret		nz
	call    LABEL_B28_8ABD
	jp      z, LABEL_B28_8AAE
LABEL_B28_895D:
	ld      (ix+$3E), $00
	ld      a, (ix+$3F)		;fetch the option byte and set it
	ld      (ix+$02), a		;as the object state
	ld      hl, $0400		;set the horizontal speed to 1024
	ld      (ix+$18), l
	ld      (ix+$19), h
	ret     

Minecart_State_02_Logic_01:		;$8971
	ld      l, (ix+$16)		;get horizontal speed
	ld      h, (ix+$17)
	ld      a, h
	cp      $04
	jr      nc, +			;jump if H >= $04
	ld      de, $0010
	add     hl, de
	ld      (ix+$16), l		;set horizontal speed
	ld      (ix+$17), h
+:	ld      bc, $0010
	ld      de, $FFF0
	call    LABEL_200 + $63
	ld      a, ($D353)
	ld      hl, DATA_B28_8B0C
	ld      bc, $001B
	cpir    
	jr      z, LABEL_B28_89F7
	call    LABEL_B28_8ABD
	bit     1, (ix+$22)
	jp      nz, LABEL_B28_8AAE
	ld      (ix+$02), $04	;set state to "falling"
	ld      hl, $0000
	ld      (ix+$18), l		;set vertical speed
	ld      (ix+$19), h
	ret     

Minecart_State_03_Logic_01:		;$89B4
	ld      l, (ix+$16)		;get horizontal speed and 2's comp the value
	ld      h, (ix+$17)
	dec     hl
	ld      a, h
	cpl     
	ld      h, a
	ld      a, l
	cpl     
	ld      l, a
	ld      a, h
	cp      $04
	jr      nc, +			;jump if hi-byte of speed >= $04
	ld      de, $0010		;increase speed by 16
	add     hl, de
	dec     hl
	ld      a, h
	cpl     
	ld      h, a
	ld      a, l
	cpl     
	ld      l, a
	ld      (ix+$16), l		;store horizontal speed
	ld      (ix+$17), h
+:	ld      bc, $FFF0
	ld      de, $FFF0
	call    LABEL_200 + $63
	ld      a, ($D353)
	ld      hl, DATA_B28_8B0C
	ld      bc, $001B
	cpir    
	jr      z, LABEL_B28_89F7
	call    LABEL_B28_8ABD
	bit     1, (ix+$22)
	jp      nz, LABEL_B28_8AAE
LABEL_B28_89F7:
	bit     1, (ix+$22)
	jr      nz, LABEL_B28_8A51
	ld      (ix+$02), $04		;set state to $04
	ld      hl, $0000			;set vertical speed to 0
	ld      (ix+$18), l
	ld      (ix+$19), h
	ret     

Minecart_State_04_Logic_01:		;$8A0B
	ld      bc, $0010
	bit     7, (ix+$17)
	jr      z, +
	ld      bc, $FFF0
+:	ld      de, $FFF0
	call    LABEL_200 + $63
	ld      a, ($D353)
	ld      hl, DATA_B28_8B0C
	ld      bc, $001B
	cpir    
	jr      nz, +
	ld      hl, $0000
	ld      (ix+$16), l
	ld      (ix+$17), h
+:	ld      bc, $0600
	ld      de, $0020
	call    VF_Engine_SetObjectVerticalSpeed
	bit     1, (ix+$22)
	jp      z, LABEL_B28_8AAE
	ld      a, ($D368)
	ld      hl, DATA_B28_8AF2
	ld      bc, $001A
	cpir    
	jp      z, LABEL_B28_895D
LABEL_B28_8A51:
	ld      a, SFX_MinecartCrash
	ld      ($DD04), a
	res     1, (ix+$22)
	res     7, (iy+$04)
	ld      hl, $FC00			;set the vertical speed to
	ld      (ix+$18), l			;make the minecart bounce up
	ld      (ix+$19), h
	ld      (ix+$16), $00		;set the horizontal speed to 0
	ld      (ix+$17), $00
	ld      (ix+$02), $05		;set the state to $05
	push    ix
	pop     hl
	ld      de, ($D39E)
	xor     a					;clear carry flag
	sbc     hl, de
	ret     nz					;check to see if player is riding
	ld      hl, $0000			;the minecart.
	ld      ($D39E), hl
	push    ix
	ld      ix, $D500	;get a pointer to the player object structure...
	call    VF_Player_PlayHurtAnimation	;... and play the "hurt" anim
	pop     ix			;restore the minecart's object pointer.
	ret

Minecart_State_05_Logic_01:		;$8A90
	ld      bc, $0600
	ld      de, $0040
	call    VF_Engine_SetObjectVerticalSpeed
	bit     1, (ix+$22)
	jp      z, LABEL_B28_8AAE
	ld      (ix+$02), $06
	ret     

Minecart_State_06_Logic_01:		;$8AA5
	ld      (ix+$3E), $00
	ld      (ix+$3F), $00
	ret     

LABEL_B28_8AAE:
	call    VF_Engine_UpdateObjectPosition
	call    LABEL_200 + $60
	ld      a, ($D353)
	ld      ($D368), a
	jp      LABEL_200 + $0C

LABEL_B28_8ABD:
	bit     6, (ix+$03)
	jr      z, +
	dec     (ix+$1F)
	jr      nz, +
	res     6, (ix+$03)
+:	call    VF_Engine_CheckCollision
	ld      a, (ix+$21)
	and     $0D
	ld      (ix+$21), a
	ret     z
	ld      ($D39E), ix		;store pointer to minecart object descriptor
	ld      iy, $D500		;get a pointer to the player object structure
	res     0, (iy+$03)
	res     1, (iy+$03)
	ld      (iy+$02), PlayerState_EnterMineCart	;set player state to $16
	ld      a, SFX_EnterMinecart
	ld      ($DD04), a
	ret     

DATA_B28_8AF2:
.db $00, $01, $02, $03, $04, $05, $06, $0D
.db $10, $11, $12, $13, $14, $15, $16, $21
.db $22, $23, $24, $26, $27, $2C, $2D, $2E
.db $4D, $61

DATA_B28_8B0C:
.db $20, $24, $28, $29, $2A, $2B, $40, $41
.db $42, $43, $44, $45, $46, $4F, $50, $51
.db $52, $53, $54, $55, $56, $60, $64, $68
.db $69, $6A, $6B


LABEL_B28_8B27:
	ld      l, (ix+$2C)
	ld      h, $00
	bit     7, (ix+$17)
	jr      z, +
	ex      de, hl
	ld      hl, $0000
	xor     a
	sbc     hl, de
+:	push    hl
	pop     bc
	ld      de, $FFE0
	call    LABEL_200 + $63
	cp      $81
	jr      z, LABEL_B28_8B4A
	cp      $8D
	jr      z, LABEL_B28_8B4A
	ret

LABEL_B28_8B4A:
	bit     7, (ix+$17)
	jr      nz, LABEL_B28_8B55
	set     2, (ix+$22)
	ret     

LABEL_B28_8B55:
	set     3, (ix+$22)
	ret     

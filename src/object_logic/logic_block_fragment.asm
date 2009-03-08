Logic_BlockFragment:
.dw BlockFragment_State_00
.dw BlockFragment_State_01

BlockFragment_State_00:		;$AC25
.db $FF, $09		;play the "break block" sound
	.db SFX_BreakBlock
.db $01, $00
	.dw BlockFragment_State_00_Logic_01
.db $FF, $00

BlockFragment_State_01		;$AC2E	
.db $80, $01
	.dw BlockFragment_State_01_Logic_01
.db $FF, $00


BlockFragment_State_00_Logic_01:		;$AC34
	ld      l, (ix+$3F)
	ld      h, $00
	add     hl, hl
	add     hl, hl
	add     hl, hl
	ld      de, DATA_B31_AC98
	ld      a, ($D517)		;hi-byte of player velocity
	and     a
	jp      p, +
	ld      de, DATA_B31_ACB8
+:	add     hl, de
	ld      e, (hl)
	inc     hl
	ld      d, (hl)
	inc     hl
	ex      de, hl
	ld      bc, ($D35A)
	add     hl, bc
	ld      (ix+$11), l		;set sprite's hpos
	ld      (ix+$12), h
	ex      de, hl
	ld      e, (hl)
	inc     hl
	ld      d, (hl)
	inc     hl
	ex      de, hl
	ld      bc, ($D35C)
	add     hl, bc
	ld      (ix+$14), l		;set sprite's vpos
	ld      (ix+$15), h
	ex      de, hl
	ld      a, (hl)
	ld      (ix+$16), a		;set sprite's horizontal velocity
	inc     hl
	ld      a, (hl)
	ld      (ix+$17), a
	inc     hl
	ld      a, (hl)
	ld      (ix+$18), a		;set sprite's vertical velocity
	inc     hl
	ld      a, (hl)
	ld      (ix+$19), a
	ld      (ix+$02), $01	;set state to $01
	set     0, (ix+$04)
	ld      a, (CurrentLevel)
	cp      $06
	ret     nz
	ld      a, (CurrentAct)
	cp      $02
	ret     nz
	ld      (ix+$08), $9C
	ret     

DATA_B31_AC98:
.dw $0004, $0000, $FE00, $FC00
.dw $0014, $0000, $0080, $FD00
.dw $0004, $0014, $FE00, $FF00
.dw $0014, $0014, $0080, $FE00
DATA_B31_ACB8:
.dw $0004, $0000, $FF80, $FD00
.dw $0014, $0000, $0200, $FC00
.dw $0004, $0014, $FF80, $FE00
.dw $0014, $0014, $0200, $FF00


BlockFragment_State_01_Logic_01:		;$ACD8
	bit     6, (ix+$04)
	jp      nz, VF_Engine_DeallocateObject
	ld      bc, $1000
	ld      de, $00C0
	call    VF_Engine_SetObjectVerticalSpeed
	jp      VF_Engine_UpdateObjectPosition

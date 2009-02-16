.include	"src\includes\structures.asm"
.include	"src\includes\objects.asm"				;values for objects
.include	"src\includes\player_states.asm"		;values for player object state
.include	"src\includes\sound_values.asm"			;values for music/sfx


;=====================================================================
;Changing the "Version" variable will determine which version
;of the ROM is built. Values are:
;	1 - for version 1.0
;	2 - for version 2.2

.DEF Version		1

;some basic sense-checking on the version variable
.IFNEQ Version 2
	.IFNEQ Version 1
		.PRINTT "FAIL: Invalid build version!\n"
		.FAIL 
	.ENDIF
.ENDIF
;=====================================================================

.def LevelDataStart			$C001

.def HorizontalVelocity		$D516
.def VerticalVelocity		$D518

.def BackgroundXScroll		$D172
.def BackgroundYScroll		$D173

.def CameraOffsetX			$D288
.def CameraOffsetY			$D289	;used for moving the camera when looking up or down
.def GameState				$D293	;bit 1 = pause flag
.def CurrentLevel			$D295
.def CurrentAct				$D296
.def LifeCounter			$D298
.def RingCounter			$D299	;BCD
.def Score					$D29C	;score stored in 3-byte BCD

.def LevelTimerTrigger		$D2B8	;level timer update trigger
.def LevelTimer				$D2B9

.def MaxHorizontalVelocity	$D36D
.def IdleTimer				$D3B4

.def PlayerUnderwater		$D467	;non-zero = player under water

;Variables used by the continue screen
.def ContinueScreen_Count	$D2C4
.def ContinueScreen_Timer	$D2C3	;when this fires the countdown is decreased

;Variables used by demo levels
.def ControlByte			$D2D2	;holds a pointer to the controller byte to be copied into $D137
.def DemoNumber				$D2D7
.def DemoBank				$D2D8	;holds the bank number that $D2D2 points into. This should be paged in before dereferencing the pointer.
.def NextControlByte		$D2D9	;holds a pointer to the next controller byte to be copied into $D2D2

.def RingArt_SrcAddress		$D395
.def RingArt_DestAddress	$D397


;Variables used by palette control/update routines
.def PaletteFadeTime		$D2C8	;TODO: Check this one
.def BgPaletteControl		$D4E6	;Triggers background palette fades (bit 6 = to black, bit 7 = to colour).
.def BgPaletteIndex			$D4E7	;Current background palette (index into array of palettes)
.def FgPaletteControl		$D4E8	;Triggers foreground palette fades (bit 6 = to black, bit 7 = to colour).
.def FgPaletteIndex			$D4E9	;Current foreground palette (index into array of palettes)
.def PaletteUpdatePending	$D4EA	;Will trigger a CRAM update when set

.def CurrentMusicTrack		$DD03
.def NextMusicTrack			$DD04	;Write bytes here to play music/sfx

;VDP Values
.def ScreenMap				$3800	;location of the screen map (name table)
.def SAT					$3F00	;location of the Sprite Attribute Table
.def VDPRegister0			$D11E	;copies of the VDP registers stored in RAM
.def VDPRegister1			$D11F
.def VDPRegister2			$D120
.def VDPRegister3			$D121
.def VDPRegister4			$D122
.def VDPRegister5			$D123
.def VDPRegister6			$D124
.def SATUpdateRequired		$D134	;Causes the SAT to be udpated when set.
.def WorkingCRAM			$D4C6	;copy of Colour RAM maintained in work RAM.

.def LastLevel				$07
.def LastBankNumber			$1F

.MEMORYMAP
SLOTSIZE $4000
SLOT 0 $0000
SLOT 1 $4000
SLOT 2 $8000
DEFAULTSLOT 2
.ENDME

.ROMBANKMAP
BANKSTOTAL 32
BANKSIZE $4000
BANKS 32
.ENDRO

.EMPTYFILL $FF

.BANK 0 SLOT 0
.ORG $0000

_START:
	di
	im		1
	ld		sp, $DFF0
	;set page-2 to map to ROM as specified in register $FFFF
	ld		a, $00
	ld		($FFFC), a
	;set page-0 to ROM bank-0
	ld		a, $00
	ld		($FFFD), a
	;set page-1 to ROM bank-1
	inc		a
	ld		($FFFE), a
	;set page-2 to ROM bank-2
	inc		a
	ld		($FFFF), a
_RST_18H:
	;read current scanline
	in		a, ($7E)
	;wait for scanline to = 176
	cp		$B0
	jr		nz, _RST_18H
	;Clear a work ram ($C001 to $DFEF)
	ld		hl, $C001
	ld		de, $C002
	ld		bc, $1FEE
	ld		(hl), $00
	ldir
	
	ld		a, $01
	ld		($D12A), a
	ld		a, $02
	ld		($D12B), a
	jp		LABEL_457_3

_IRQ_HANDLER:
_INT_38H:
	di
	push	af
	in		a, ($BF)
	rlca
	jp		c, LABEL_4A5_57
	jp		LABEL_5B2_58		

;just padding?
.db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.db $00, $02, $00

_NMI_HANDLER:
	jp		_Pause_Handler


;seems to be unsed data
LABEL_69:
.db $00, $00, $00, $00, $00, $00, $00, $32, $00, $00


ErrorTrap:	  ;$0073
	call	Engine_ClearScreen
	ld		a, $01
	ld		($D2C7), a
	ld		hl, $3A4C	   ;scribble to this vram address
	ld		de, _error_msg
	ld		bc, $0005
	call	DrawText
	jr		+

_error_msg:
.db "ERROR"

+:  ld	  b, $B4
-:  ei
	halt
	djnz	-
	jp		$0000


.db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.db $00, $00, $00, $00, $00, $00, $00, $00, $00


.db "MS SONIC", $A5, "THE", $A5, "HEDGEHOG.2 "
.IFEQ Version 2.2
	.db "Ver2.20 1992/12/09"
.ELSE
	.db "Ver1.00 1992/09/05"
.ENDIF
.db " SEGA /Aspect Co.,Ltd "


;****************************************************************
;*  The following table serves as a lookup table that is used   *
;*  by tile loading routines to mirror tiles horizontally on	*
;*  the-fly. Each byte represents the mirrored data for each	*
;*  possible byte of tile data. For example, if the byte of	 *
;*  tile data was $D6 (1101 0110 in binary), its mirrored value *
;*  would be $6B (0110 1011 in binary).						 *
;*  This array needs to be aligned to a $100 byte boundary in   *
;*  order for the addressing mechanism to work properly.		*
;****************************************************************
Data_TileMirroringValues:	   ;$0100
.db $00, $80, $40, $C0, $20, $A0, $60, $E0
.db $10, $90, $50, $D0, $30, $B0, $70, $F0
.db $08, $88, $48, $C8, $28, $A8, $68, $E8
.db $18, $98, $58, $D8, $38, $B8, $78, $F8
.db $04, $84, $44, $C4, $24, $A4, $64, $E4
.db $14, $94, $54, $D4, $34, $B4, $74, $F4
.db $0C, $8C, $4C, $CC, $2C, $AC, $6C, $EC
.db $1C, $9C, $5C, $DC, $3C, $BC, $7C, $FC
.db $02, $82, $42, $C2, $22, $A2, $62, $E2
.db $12, $92, $52, $D2, $32, $B2, $72, $F2
.db $0A, $8A, $4A, $CA, $2A, $AA, $6A, $EA
.db $1A, $9A, $5A, $DA, $3A, $BA, $7A, $FA
.db $06, $86, $46, $C6, $26, $A6, $66, $E6
.db $16, $96, $56, $D6, $36, $B6, $76, $F6
.db $0E, $8E, $4E, $CE, $2E, $AE, $6E, $EE
.db $1E, $9E, $5E, $DE, $3E, $BE, $7E, $FE
.db $01, $81, $41, $C1, $21, $A1, $61, $E1
.db $11, $91, $51, $D1, $31, $B1, $71, $F1
.db $09, $89, $49, $C9, $29, $A9, $69, $E9
.db $19, $99, $59, $D9, $39, $B9, $79, $F9
.db $05, $85, $45, $C5, $25, $A5, $65, $E5
.db $15, $95, $55, $D5, $35, $B5, $75, $F5
.db $0D, $8D, $4D, $CD, $2D, $AD, $6D, $ED
.db $1D, $9D, $5D, $DD, $3D, $BD, $7D, $FD
.db $03, $83, $43, $C3, $23, $A3, $63, $E3
.db $13, $93, $53, $D3, $33, $B3, $73, $F3
.db $0B, $8B, $4B, $CB, $2B, $AB, $6B, $EB
.db $1B, $9B, $5B, $DB, $3B, $BB, $7B, $FB
.db $07, $87, $47, $C7, $27, $A7, $67, $E7
.db $17, $97, $57, $D7, $37, $B7, $77, $F7
.db $0F, $8F, $4F, $CF, $2F, $AF, $6F, $EF
.db $1F, $9F, $5F, $DF, $3F, $BF, $7F, $FF

;************************************************************
;*  Main logic vtable - used extensively by object logic	*
;************************************************************
LABEL_200:
VF_Engine_AllocateObjectHighPriority:				;$200 - find an available object slot from $D540 onwards
	jp		Engine_AllocateObjectHighPriority						   
VF_Engine_AllocateObjectLowPriority:				;$203 - find an available object slot from $D700 onwards
	jp		Engine_AllocateObjectLowPriority
	jp		LABEL_6248						 		;$206
VF_Engine_MoveObjectToPlayer:						;$209
	jp		Engine_MoveObjectToPlayer
VF_Logic_CheckDestroyObject:						;$20C
	jp		Logic_CheckDestroyObject
VF_Engine_SetObjectVerticalSpeed:
	jp		Engine_SetObjectVerticalSpeed			;$20F
	jp		LABEL_631A								;$212
	jp		LABEL_6344								;$215
VF_Engine_CheckCollisionAndAdjustPlayer:			;$218
	jp		Engine_CheckCollisionAndAdjustPlayer
	jp		LABEL_6355								;$21B
	jp		LABEL_635B								;$21E
	jp		LABEL_63A9								;$221
	jp		LABEL_63C0								;$224
VF_Engine_AdjustPlayerAfterCollision:				;$227
	jp		Engine_AdjustPlayerAfterCollision
VF_DoNothing:										;$22A
	jp		DoNothingStub
	jp		LABEL_64B1								;$22D
VF_Engine_GetObjectIndexFromPointer:				;$230
	jp		Engine_GetObjectIndexFromPointer
VF_Engine_GetObjectDescriptorPointer:				;$233
	jp		Engine_GetObjectDescriptorPointer
	jp		LABEL_64D4								;$236
	jp		LABEL_6544								;$239
VF_Logic_UpdateObjectDirectionFlag					;$23C
	jp		Logic_UpdateObjectDirectionFlag
VF_Logic_ChangeDirectionTowardsPlayer:				;$23F
	jp		Logic_ChangeDirectionTowardsPlayer
VF_Logic_ChangeDirectionTowardsObject:				;$242
	jp		Logic_ChangeDirectionTowardsObject
VF_Logic_MoveHorizontalTowardsPlayerAt0400			;$245
	jp		Logic_MoveHorizontalTowardsPlayerAt0400
VF_Logic_MoveHorizontalTowardsObject:				;$248
	jp		Logic_MoveHorizontalTowardsObject
VF_Logic_MoveVerticalTowardsObject:					;$24B
	jp		Logic_MoveVerticalTowardsObject
	jp		LABEL_67EC								;$24E
	jp		LABEL_67F1								;$251
	jp		LABEL_67F6								;$254
VF_Engine_UpdateObjectPosition:
	jp		Engine_UpdateObjectPosition				;$257
VF_Engine_CheckCollision:
	jp		Engine_CheckCollision					;$25A
VF_Engine_DisplayExplosionObject:
	jp		Engine_DisplayExplosionObject			;$25D
	jp		LABEL_75C5								;$260
VF_Engine_GetCollisionValueForBlock:
	jp		Engine_GetCollisionValueForBlock		;$263 - collide with background tiles
	jp		LABEL_2FCB								;$266
VF_Player_HandleStanding:
	jp		Player_HandleStanding					;$269
VF_Engine_IncrementRingCounter:
	jp		IncrementRingCounter					;$26C
VF_Player_CalculateLoopFrame:						;$26F
	jp		Player_CalculateLoopFrame
VF_Player_CalculateLoopFallFrame:					;$272
	jp		Player_CalculateLoopFallFrame
	jp		LABEL_49B0								;$275
VF_Engine_ReleaseCamera:
	jp		Engine_ReleaseCamera					;$278
VF_Player_PlayHurtAnimation:
	jp		Player_PlayHurtAnimation				;$27B
	jp		LABEL_4037								;$27E
	jp		LABEL_46BB								;$281
VF_Player_HandleVerticalSpring:
	jp		Player_HandleVerticalSpring				;$284
	jp		LABEL_34DA								;$287
	jp		LABEL_3484								;$28A
VF_Player_HandleFalling:
	jp		Player_HandleFalling					;$28D
	jp		LABEL_41DD								;$290
	jp		LABEL_40D6								;$293
	jp		LABEL_408E								;$296
	jp		LABEL_4199								;$299
	jp		LABEL_40B2								;$29C
VF_Player_HandleJumping:
	jp		Player_HandleJumping					;$29F
	jp		LABEL_424A								;$2A2
	jp		LABEL_343E								;$2A5
VF_Player_HandleCrouched:
	jp		Player_HandleCrouched					;$2A8
VF_Player_HandleLookUp:
	jp		Player_HandleLookUp						;$2AB
	jp		LABEL_438A								;$2AE
VF_Player_HandleRolling:
	jp		Player_HandleRolling					;$2B1
	jp		LABEL_359B								;$2B4 - loop motion
VF_Player_SetState_MoveBack:						;$2B7
	jp		Player_SetState_MoveBack
VF_Player_HandleRunning:
	jp		Player_HandleRunning					;$2BA
	jp		LABEL_34FD								;$2BD
	jp		LABEL_3467								;$2C0
VF_Player_HandleIdle:
	jp		Player_HandleIdle						;$2C3
	jp		LABEL_375E								;$2C6
	jp		LABEL_375F								;$2C9
VF_Player_HandleSkidRight:
	jp		Player_HandleSkidRight					;$2CC
VF_Player_HandleSkidLeft:
	jp		Player_HandleSkidLeft					;$2CF
	jp		LABEL_46C0								;$2D2
	jp		LABEL_46EA								;$2D5
VF_Player_HandleWalk:
	jp		Player_HandleWalk						;$2D8
	jp		Player_MineCart_Handle					;$2DB
VF_UpdateCyclingPalette_ScrollingText:				;$2DE
	jp		UpdateCyclingPalette_ScrollingText
	jp		LABEL_33B7								;$2E1
VF_Engine_CreateBlockFragmentObjects
	jp		Engine_CreateBlockFragmentObjects		;$2E4 - spawn the 4 block fragment objects
	jp		LABEL_348F								;$2E7
	jp		LABEL_34A4								;$2EA - collide with air bubble - reset air timer.
	jp		LABEL_20FB								;$2ED
VF_Player_HandleBalance:							;$2F0
	jp		Player_HandleBalance
	jp		LABEL_49CF								;$2F3
VF_Engine_SetCameraAndLock:							;$2F6
	jp		Engine_SetCameraAndLock
VF_Logic_ChangeFrameDisplayTime:					;$2F9 - change frame display time based on speed
	jp		Logic_ChangeFrameDisplayTime
VF_Player_CalculateBalanceOnObject:					;$2FC
	jp		Player_CalculateBalanceOnObject
	jp		LABEL_34A9								;$2FF
VF_Engine_SetMinimumCameraX:
	jp		Engine_SetMinimumCameraX				;$302
VF_Engine_SetMaximumCameraX:
	jp		Engine_SetMaximumCameraX				;$305
	jp		LABEL_34E1								;$308
	jp		LABEL_25AC								;$30B
VF_Engine_UpdateRingCounterSprites:					;$30E
	jp		Engine_UpdateRingCounterSprites			;$30E
VF_Engine_RemoveBreakableBlock:						;$311
	jp		Engine_RemoveBreakableBlock
VF_Engine_ChangeLevelMusic:
	jp		Engine_ChangeLevelMusic					;$314
VF_Score_AddBadnikValue:
	jp		Score_AddBadnikValue					;$317
VF_Score_AddBossValue:
	jp		Score_AddBossValue						;$31A
	jp		LABEL_1CC4								;$31D
	jp		LABEL_1CCA								;$320

.db $00, $00, $00, $00, $00, $00
.db $00, $00, $00, $00, $00, $00, $00 

DATA_330:
.db $00, $03, $06, $09, $0C, $0F, $12, $15
.db $19, $1C, $1F, $22, $25, $28, $2B, $2E
.db $31, $34, $36, $39, $3C, $3F, $42, $44
.db $47, $49, $4C, $4F, $51, $53, $56, $58
.db $5A, $5C, $5F, $61, $63, $65, $67, $68
.db $6A, $6C, $6E, $6F, $71, $72, $73, $75
.db $76, $77, $78, $79, $7A, $7B, $7C, $7D
.db $7D, $7E, $7E, $7F, $7F, $7F, $7F, $7F
.db $7F, $7F, $7F, $7F, $7F, $7E, $7E, $7D
.db $7D, $7C, $7B, $7B, $7A, $79, $78, $77
.db $75, $74, $73, $71, $70, $6E, $6D, $6B
.db $69, $68, $66, $64, $62, $60, $5E, $5B
.db $59, $57, $55, $52, $50, $4D, $4B, $48
.db $46, $43, $40, $3D, $3B, $38, $35, $32
.db $2F, $2C, $29, $26, $23, $20, $1D, $1A
.db $17, $14, $11, $0E, $0B, $07, $04, $01
.db $00, $FF, $FC, $F9, $F5, $F2, $EF, $EC
.db $E9, $E6, $E3, $E0, $DD, $DA, $D7, $D4
.db $D1, $CE, $CB, $C8, $C5, $C3, $C0, $BD
.db $BA, $B8, $B5, $B3, $B0, $AE, $AB, $A9
.db $A7, $A5, $A2, $A0, $9E, $9C, $9A, $98
.db $97, $95, $93, $92, $90, $8F, $8D, $8C
.db $8B, $89, $88, $87, $86, $85, $85, $84
.db $83, $83, $82, $82, $81, $81, $81, $81
.db $81, $81, $81, $81, $81, $81, $82, $82
.db $83, $83, $84, $85, $86, $87, $88, $89
.db $8A, $8B, $8D, $8E, $8F, $91, $92, $94
.db $96, $98, $99, $9B, $9D, $9F, $A1, $A4
.db $A6, $A8, $AA, $AD, $AF, $B1, $B4, $B7
.db $B9, $BC, $BE, $C1, $C4, $C7, $CA, $CC
.db $CF, $D2, $D5, $D8, $DB, $DE, $E1, $E4
.db $E7, $EB, $EE, $F1, $F4, $F7, $FA, $FD



.db $00


Start:
LABEL_431_86:
	di
	ld		sp, $DFF0
	call	_VDP_Set_Register_1_flags_0_to_5
	ld		hl, $C001		  ;clear work RAM
	ld		de, $C002
	ld		bc, $1FEE
	ld		(hl), $00
	ldir
	;setup default paging
	ld		a, $00
	ld		($FFFC), a
	ld		a, $00
	ld		($FFFD), a
	inc		a
	ld		($FFFE), a
	inc		a
	ld		($FFFF), a
LABEL_457_3:
	call	LABEL_12A3_4	   ;possibly wait for vblank routine
	call	Sound_ResetChannels
	call	Initialise_VDP_Registers
	;clear screen?
	call	ClearPaletteRAM
	call	ClearVRAM
	call	Engine_LoadLevelTiles
	call	LevelSelectCheck
	call	EnableFrameInterrupt
	call	SetDisplayVisible
LABEL_472:
	ld		hl, $D292
	set		6, (hl)
	ld		a, $04			 ;set the palette fade timeout value (will fade every 4th VBLANK)
	ld		($D2C8), a
	call	ChangeGameMode
	di
	call	Engine_ClearScreen
	call	Engine_ClearWorkingVRAM
	xor		a
	ld		($D292), a
	call	Engine_InitCounters
	ei
	halt
	ld		hl, GameState
	ld		(hl), $44
	jp		Engine_UpdateGameState

LevelSelectCheck:
	xor		a
	ld		($D12C), a
	in		a, ($DD)
	cpl
	;-----------------
	;ld   a, $0d
	;nop
	;-----------------
	cp		$0D
	ret		nz
	ld		($D12C), a
	ret

;Main game loop
_VSyncInterrupt:
LABEL_4A5_57:
	ex		af, af'
	push	af
	push	bc
	push	de
	push	hl
	exx
	push	bc
	push	de
	push	hl
	push	ix
	push	iy
	ld		a, ($D4A3)		  ;only updates palettes
	or		a
	jp		nz, LABEL_58D_61
	ld		a, ($D136)		  ;Only allows sound driver to update
	or		a
	jp		nz, LABEL_55D_62
	call	_VDP_Set_Register_1_flags_0_to_5
	ld		bc, $0000
	ld		a, ($D290)		  ;do we need to default the background scroll values?
	or		a
	jp		z, LABEL_4DD_63
	dec		a
	ld		($D290), a
	and		$06
	ld		e, a
	ld		d, $00
	ld		hl, DefaultScrollValues
	add		hl, de
	ld		c, (hl)
	inc		hl
	ld		b, (hl)
LABEL_4DD_63:
	;Set the background X-scroll value (write to register VDP(8))
	ld		a, (BackgroundXScroll)
	add		a, b
	out		($BF), a
	ld		a, $88
	out		($BF), a
	;Set the background Y-scroll value (write to register VDP(9))
	ld		a, (BackgroundYScroll)
	add		a, c
	out		($BF), a
	ld		a, $89
	out		($BF), a
	
	ld		a, ($D15E)
	bit		6, a
	jr		z, LABEL_51B_64
	res		6, a
	ld		($D15E), a
	ld		ix, $D15E
	
	bit		4, (ix+0)
	call	nz, Engine_CopyMappingsToVRAM_Row
	
	bit		5, (ix+0)
	call	nz, Engine_CopyMappingsToVRAM_Column
	
	ld		hl, ($D284)
	ld		($D174), hl
	ld		hl, ($D286)
	ld		($D176), hl
LABEL_51B_64:
	call	UpdateSAT
	call	Engine_AnimateRingArt
	call	SetDisplayVisible
	call	_WriteToPaletteRAM
	call	ReadInput
	call	Engine_LoadPlayerTiles
	
	ld		a, (GameState)
	bit		1, a				;check whether game is paused
	jr		nz, LABEL_55D_62
	
	;load ROM bank-9 into page-2 and call the palette update code
	ld		a, :Bank09
	ld		($FFFF), a
	call	Palette_Update
	
	ld		a, (GameState)
	bit		6, a
	jr		z, LABEL_55D_62
	ld		a, (GameState)
	bit		2, a
	jr		nz, LABEL_55D_62
	ld		a, :Bank31
	ld		($FFFF), a
	call	Engine_UpdateSpriteAttribs
	call	Engine_UpdateSpriteAttribsArt
	ld		a, :Bank30				  ;page in the bank with the cycling palette data
	ld		($FFFF), a
	call	Engine_UpdateCyclingPalettes
LABEL_55D_62:
	;load ROM bank-2 into page-2
	ld		a, :Bank2
	ld		($FFFF), a
	call	LABEL_8000_92
	ld		a, ($D292)
	or		a
	call	nz, LABEL_59E_218

	call	Engine_Timer_Increment	;increment the act timer
	
	ld		hl, $D12F		;increment the frame counter
	inc		(hl)
	
	ld		a, ($D12B)
	ld		($FFFF), a
	ld		hl, $D135	   ;pause timer
	inc		(hl)
	pop		iy
	pop		ix
	pop		hl
	pop		de
	pop		bc
	exx
	pop		hl
	pop		de
	pop		bc
	pop		af
	ex		af, af'
	pop		af
	ei
	ret

LABEL_58D_61:
	call	_WriteToPaletteRAM
	jp		LABEL_55D_62


WaitForInterrupt:
LABEL_593:
	ei
	ld		hl, $D135
-:  ld   a, (hl)
	or		a
	jr		z, -
	ld		(hl), $00
	ret

LABEL_59E_218:
	ld		a, ($D157)
	and		$30
	ret		z
	ld		hl, $D292
	set		7, (hl)
	ret


; Data from 5AA to 5B1 (8 bytes)
DefaultScrollValues:
_DATA_05AA:
.db $FE, $00, $FE, $FE, $02, $02, $00, $02

LABEL_5B2_58:
	;Set register VDP(10) to 255 (i.e. No line interrupt)
	ld		a, $FF
	out		($BF), a
	ld		a, $8A
	out		($BF), a
	
	ld		a, ($D132)
	inc		a
	jr		nz, _VDP_Palette_Setup
	ld		a, (PlayerUnderwater)
	or		a
	jp		z, LABEL_656_60	;bail out
_VDP_Palette_Setup:
	push	hl
	;set up the VDP to write to palette RAM at address $0
	ld		a, $00
	out		($BF), a
	ld		a, $C0
	out		($BF), a
	;write the 16 colours to the VRAM
	ld		hl, DATA_65A

.REPEAT 16
	ld		a, (hl)
	out		($BE), a
	inc		hl
	nop
	nop
	nop
	nop
.ENDR

	ld		(PaletteUpdatePending), a
LABEL_656_60:
	pop		hl
	pop		af
	ei
	ret


DATA_65A:
; Data from 65A to 671 (24 bytes)
.db $10, $10, $24, $39, $39, $24, $34, $38, $28, $14, $3D, $3F, $00, $3D, $3E, $3F
.db $3E, $00, $D3, $BF, $3E, $88, $D3, $BF

_Pause_Handler:
	push	af
	ld		a, (BgPaletteControl)
	or		a
	jr		nz, LABEL_68D_231
	ld		a, ($D292)
	or		a
	jr		nz, LABEL_68D_231
	ld		a, (GameState)
	and		$FD
	cp		$40
	jr		nz, LABEL_68D_231
	ld		a, $01
	ld		($D12E), a
LABEL_68D_231:
	pop		af
	retn


Engine_UpdateGameState:	 ;$690
	call	WaitForInterrupt
	ld		a, (GameState)
	rlca
	jp		c, +				;bit 7  - ending sequence
	rlca
	jp		nc, LABEL_72F	   ;bit 6  - game over/continue
	rlca
	jp		c, ScoreCard_NextAct		;bit 5  - end of act core card
	rlca
	jp		c, ScoreCard_NextZone	   ;bit 4  - end of zone score card
	rlca
	jp		c, Player_DoLoseLife		;bit 3  - player dead
	rlca
	jp		c, LABEL_97F		;bit 2 - title card - load level
	rlca
	jp		c, LABEL_9C4
	call	Engine_UpdateLevelState
	call	LABEL_A13
	jr		Engine_UpdateGameState


;run the ending sequence
+:  call Engine_LoadLevel		 ;load the level
	call	Engine_ChangeLevelMusic
	call	LoadLevelPalette
	call	Engine_ReleaseCamera
	ld		a, Music_Ending
	ld		($DD04), a
	call	LABEL_6F3
	xor		a
	ld		($D4A6), a
	ld		($D4AE), a
	call	PaletteFadeOut
	ld		b, $3C
-:  ei
	halt
	djnz	-
	xor		a
	ld		($D2BD), a	 ;used by the continue screen routines
	ld		($D2C5), a
	ld		hl, GameState
	res		7, (hl)
	res		6, (hl)
	res		4, (hl)
	res		3, (hl)
	jp		Engine_UpdateGameState

LABEL_6F3:					  ;ending credits sequence
	ld		a, $5D
	ld		($D700), a
	ld		a, $01
	ld		($D500), a
	ld		a, $2A
	ld		($D502), a

	xor		a			;reset the level timer update trigger
	ld		(LevelTimerTrigger), a

	ld		a, $0D	 ;set up the cycling palette
	ld		($D4A6), a
	ld		a, :Bank29
	call	Engine_SwapFrame2
	call	LABEL_B29_B400		 ;move the last 16 sprites in the SAT off of the screen.
	ld		hl, $012C
	ld		($D46F), hl
	call	WaitForInterrupt
	call	Engine_UpdateLevelState
	ld		a, :Bank29
	call	Engine_SwapFrame2
	call	LABEL_B29_B40C
	ld		a, ($D701)
	cp		$06
	jr		nz, $EB
	ret

LABEL_72F:
	xor		a
	ld		($DD03), a		  ;stop music
	ei
	halt
	call	Engine_ClearWorkingVRAM	;clear all copies of VRAM values from work RAM.				 
	call	Engine_ClearLevelAttributes		 ;clear level header
	call	Engine_ClearScreen
	call	GameState_CheckContinue ;load the continue screen if required
	ld		a, ($D2BD)		  ;load the "Game Over" screen if bit 7 of $D2BD is reset.
	bit		7, a
	jr		nz, GameState_DoContinue
	ld		a, Music_GameOver
	ld		($DD04), a
	call	GameOverScreen_DrawScreen
	ld		b, $78
-:  ei
	halt
	djnz	-
	ld		bc, $0D98
-   call	WaitForInterrupt
	ld		a, ($D137)		  ;check to see if button 1/2 is pressed
	and		$30
	jr		nz, +
	dec		bc
	ld		a, b
	or		c
	jr		nz, -
+:  call	PaletteFadeOut
	call	FadeMusic
	ld		b, $3C
-:  ei
	halt
	djnz	-
	jp		LABEL_472

GameState_DoContinue:
LABEL_777:
	ld		a, $03
	ld		(LifeCounter), a
	xor		a
	ld		($D29C), a
	ld		($D29D), a
	ld		($D29E), a
	ld		hl, GameState
	res		3, (hl)
	set		2, (hl)
	set		6, (hl)
	jp		Engine_UpdateGameState

GameState_CheckContinue:
LABEL_792:
	ld		hl, $D2BD
	res		7, (hl)
	ld		a, (hl)
	or		a
	ret		z
	xor		a				   ;reset the timer
	ld		(ContinueScreen_Timer), a
	ld		a, $09			  ;set the countdown to 9
	ld		(ContinueScreen_Count), a
	call	ContinueScreen_DrawScreen
	call	ContinueScreen_LoadNumberMappings
	ld		ix, $D500
	ld		(ix+0), $01
	ld		(ix+1), $2F
	ld		(ix+2), $2F
	call	Engine_UpdatePlayerObjectState
	ld		a, Music_Continue
	ld		($DD04), a
	ld		hl, GameState
	set		6, (hl)
	call	ContinueScreen_MainLoop
	ld		hl, GameState
	res		6, (hl)
	call	PaletteFadeOut
	call	FadeMusic
	ld		b, $3C
-:  ei
	halt
	djnz	-
	ret

ContinueScreen_MainLoop:		;7DB
	call	WaitForInterrupt
	call	Engine_UpdatePlayerObjectState
	ld		a, ($D147)
	and		$30			 ;is button 1/2 pressed?
	jr		nz, +
	ld		hl, ContinueScreen_Timer	;increase the timer
	inc		(hl)
	ld		a, (hl)
	cp		$5A			 ;if the timer = $5A, decrement the countdown
	jr		c, ContinueScreen_MainLoop
	ld		(hl), $00
	inc		hl
	dec		(hl)
	ld		a, (hl)
	cp		$FF			 ;countown expired
	ret		z
	call	ContinueScreen_LoadNumberMappings
	ld		a, SFX_LoseRings
	ld		($DD04), a
	jr		ContinueScreen_MainLoop
+:  ld	  hl, $D2BD
	res		7, (hl)
	dec		(hl)
	set		7, (hl)
	ld		a, SFX_ExtraLife
	ld		($DD04), a
	ld		b, $B4
-:  push	bc
	call	WaitForInterrupt
	call	Engine_UpdatePlayerObjectState
	pop		bc
	djnz	-
	ret

LABEL_81D:
	jp		Engine_UpdateGameState

ScoreCard_NextAct:
LABEL_820:
	call	LABEL_A27		  ;reset LevelTimerTrigger
	call	LABEL_878
	ld		b, $B4
-:  ei
	halt
	djnz	-
	ld		a, (LifeCounter)   ;store number of lives when starting the act
	ld		($D297), a
	call	LABEL_7D32		 ;reset D4A6, D4AE, D397
	call	PaletteFadeOut	 ;trigger FG & BG palette fade to black
	ld		b, $1E
-:  ei
	halt
	djnz	-
	ld		a, $00			 ;stop music
	ld		($DD04), a
	call	Engine_ClearWorkingVRAM	   ;clear various blocks of RAM & prepare the SAT
	call	Engine_ClearLevelAttributes
	call	Engine_ClearScreen
	call	LABEL_1EEE
	call	TitleCard_LoadAndDraw  ;also deals with loading score card tiles
	call	ScoreCard_UpdateScore
	ld		b, $3C
-:  ei
	halt
	djnz	-
	call	PaletteFadeOut	 ;trigger FG & BG palette fade to black
	ld		b, $3C
-:  ei
	halt
	djnz	-
	ld		hl, GameState
	res		5, (hl)
	;increment the act counter
	ld		a, (CurrentAct)
	inc		a
	ld		(CurrentAct), a
	ld		hl, GameState
	set		2, (hl)
	jp		Engine_UpdateGameState
	
LABEL_878:
	ld		a, ($D2C6)
	or		a
	ret		z
	ld		a, ($D2BD)
	inc		a
	ld		($D2BD), a
	ld		a, (CurrentLevel)
	inc		a
	ld		b, a
	xor		a
	scf
-:  rla
	djnz	-
	ld		b, a
	ld		a, ($D2C5)
	or		b
	ld		($D2C5), a
	xor		a
	ld		($D2C6), a
	ret


ScoreCard_NextZone:
;LABEL_89B:
	call	LABEL_A27
	call	LABEL_878
	ld		bc, $012C
LABEL_8A4:
	push	bc
	call	WaitForInterrupt
	call	Engine_UpdateLevelState
	pop		bc
	dec		bc
	ld		a, b
	or		c
	jp		nz, LABEL_8A4
	xor		a			   ;stop music
	ld		($DD03), a
	call	LABEL_7D32
	call	PaletteFadeOut
	ld		b, $1E
-:  ei
	halt
	djnz	-
	call	Engine_ClearWorkingVRAM
	call	Engine_ClearLevelAttributes
	call	Engine_ClearScreen
	call	LABEL_1EEE
	call	TitleCard_LoadAndDraw
	call	ScoreCard_UpdateScore
	ld		b, $3C
-:  ei
	halt
	djnz	-
	call	PaletteFadeOut
	ld		b, $3C
-:  ei
	halt
	djnz	-
	;reset the act counter & increment level counter
	xor		a
	ld		(CurrentAct), a
	ld		($D2C6), a
	ld		a, (CurrentLevel)
	inc		a
	ld		(CurrentLevel), a
	cp		$06
	jr		c, +
	jr		z, ++
	ld		a, ($D2C5)
	and		$3F
	cp		$3F
	jr		nz, LABEL_91B
	ld		a, $01
	ld		(CurrentAct), a
	jp		LABEL_91B
	
++:	ld		a, ($D2C5)
	and		$1F
	cp		$1F
	jr		nz, LABEL_91B
	
+:	ld		hl, GameState   ;play ending sequence
	res		4, (hl)
	set		2, (hl)
	jp		Engine_UpdateGameState
	
LABEL_91B:
	ld		a, $07
	ld		(CurrentLevel), a
	ld		hl, GameState
	res		4, (hl)
	set		7, (hl)
	jp		Engine_UpdateGameState

Player_DoLoseLife:
LABEL_92A:
	call	LABEL_A27
	ld		hl, LifeCounter
	dec		(hl)
	call	LABEL_25AC
	call	WaitForInterrupt
	call	Engine_UpdatePlayerObjectState
	ld		a, ($D502)
	cp		PlayerState_LostLife
	jr		z, $05
	ld		a, PlayerState_LostLife
	ld		($D502), a
	ld		a, ($D51D)
	cp		$02
	jr		nz, $E7
	ld		b, $78
-:  ei
	halt
	djnz	-
	ld		a, $00				  ;stop music
	ld		(NextMusicTrack), a
	call	LABEL_7D32
	call	PaletteFadeOut
	ld		b, $3C
-:  ei
	halt
	djnz	-
	ld		a, (LifeCounter)
	or		a
	jr		z, $0D
	ld		(LifeCounter), a
	ld		hl, GameState
	res		3, (hl)
	set		2, (hl)
	jp		Engine_UpdateGameState


	ld		hl, GameState
	res		6, (hl)
	jp		Engine_UpdateGameState

LABEL_97F:
	call	Engine_ClearScreen
	call	TitleCard_LoadAndDraw
	call	ScrollingText_UpdateSprites
	call	PaletteFadeOut
	call	FadeMusic
	ld		b, $2A
-:  ei
	halt
	djnz	-
	call	Engine_LoadLevel
	call	CapLifeCounterValue
	call	Engine_UpdateRingCounterSprites
	call	Engine_Timer_SetSprites
	call	Engine_ChangeLevelMusic
	call	LoadLevelPalette
	call	Engine_ReleaseCamera
	ld		a, (CurrentLevel)   ;check to see if we're on ALZ-2 and set the water level
	cp		$02				 
	jr		nz, +
	ld		a, (CurrentAct)
	dec		a
	jr		nz, +
	ld		hl, $0100		   ;set water level
	ld		($D4A4), hl
+:  ld	  hl, GameState
	res		2, (hl)
	jp		Engine_UpdateGameState
	
LABEL_9C4:
	xor		a
	ld		(LevelTimerTrigger), a
-:  ld	  a, ($D12E)
	or		a
	jr		z, -
	xor		a
	ld		($D12E), a
	xor		a
	ld		($DD08), a

	ld		a, $FF	;set level timer update trigger
	ld		(LevelTimerTrigger), a

	ld		hl, GameState
	res		1, (hl)
	halt
	jp		Engine_UpdateGameState



;****************************************************************
;*  This subroutine deals with updating the state of the level. *
;*  This includes camera, objects, any level specific features  *
;*  (such as the SHZ2 wind) and any PLCs.					   *
;****************************************************************
Engine_UpdateLevelState:			;$9E4
	ld		ix, $D15E		   ;load the pointer to the level descriptor
	bit		6, (ix+0)
	ret		nz
	call	Engine_UpdateCameraPos
	di
	call	Engine_UpdatePlayerObjectState
	ei
	call	Engine_UpdateAllObjects
	call	Engine_HandlePLC
	call	Engine_UpdateSHZ2Wind
	
	ld		a, ($D2D6)
	and		$0B
	jp		nz, +			   ;update object layout every 11th frame

	ld		a, :Bank30		  ;load the level's sprite layout
	call	Engine_SwapFrame2
	call	Engine_UpdateObjectLayout
	
+:  ld	  hl, $D2D6
	inc		(hl)
	ret

LABEL_A13:
	ld		a, ($D12E)
	or		a
	ret		z
	xor		a
	ld		($D12E), a
	ld		a, $80
	ld		($DD08), a
	ld		hl, GameState
	set		1, (hl)
	ret

LABEL_A27:
	xor		a		;reset timer update trigger
	ld		(LevelTimerTrigger), a
	ret


.include "src\level_select.asm"
;.include "src\sound_select.asm"


_Load_Intro_Level:
	di
	call	Engine_ClearLevelAttributes
	ld		a, $09
	ld		(CurrentLevel), a
	ld		a, $00
	ld		(CurrentAct), a
	di
	call	Engine_LoadLevel			 ;load the level

	ld		a, $7C
	ld		($D288), a
	ld		a, $74
	ld		($D289), a
	call	Engine_CalculateCameraBounds	   ;setup screen offsets
	di
	
	ld		a, :Bank08			 ;load background scenery
	call	Engine_SwapFrame2
	ld		hl, $0200
	call	VDP_SetVRAMPointer
	ld		hl, Art_Intro_Scenery
	xor		a
	call	LoadTiles
	
	ld		a, :Bank19			 ;load tails tiles
	call	Engine_SwapFrame2
	ld		hl, $0800
	call	VDP_SetVRAMPointer
	ld		hl, Art_Intro_Tails
	xor		a
	call	LoadTiles
	
	
	ld		a, :Bank19			 ;load robotnik tiles
	call	Engine_SwapFrame2
	ld		hl, $0B40
	call	VDP_SetVRAMPointer
	ld		hl, Art_Intro_Tails_Eggman
	xor		a
	call	LoadTiles
	
	di
	ld		a, $2C
	ld		($D173), a		  ;store vert. scroll value
	ld		a, $5F
	ld		($D740), a
	ld		a, $1C
	ld		($D7C0), a
	ld		a, $1D
	ld		($D800), a
	ld		($D840),a 
	call	LoadLevelPalette
	ld		a, $40
	ld		(GameState), a
	call	Engine_ReleaseCamera
	ld		a, Music_Intro			  ;Play intro music
	ld		(NextMusicTrack), a
LABEL_F41:
	call	WaitForInterrupt
	call	LABEL_107C
	call	Engine_UpdateLevelState
	ld		hl, ($D511)
	inc		hl
	ld		($D511), hl
	ld		bc, $0170
	xor		a
	sbc		hl, bc
	jp		c, LABEL_F41
	ld		a, $1E
	ld		($D780), a
	ld		bc, $030C
-:  call LABEL_107C
	push	bc
	call	WaitForInterrupt
	call	Engine_UpdateLevelState
	pop		bc
	dec		bc
	ld		a, b
	or		c
	jr		nz, -
	ld		a, $10
	ld		($D502), a
	call	LABEL_49B0
	ld		bc, $0078
-:  call LABEL_107C
	push	bc
	call	WaitForInterrupt
	call	Engine_UpdateLevelState
	pop		bc
	dec		bc
	ld		a, b
	or		c
	jr		nz, -
	ld		bc, $003C
-:  call LABEL_107C
	push	bc
	call	WaitForInterrupt
	call	Engine_UpdateLevelState
	pop		bc
	dec		bc
	ld		a, b
	or		c
	jr		nz, -
	xor		a
	ld		($D700), a
	ret

_Load_Title_Level:
	di
	call	Engine_ClearLevelAttributes
	call	Engine_ClearWorkingVRAM
	ld		a, $09
	ld		(CurrentLevel), a
	ld		a, $01
	ld		(CurrentAct), a
	call	Engine_LoadLevel
LABEL_FB9:
	di		
	call	Engine_ClearScreen
	ld		a, :Bank24			  ;page in bank 24
	call	Engine_SwapFrame2
	ld		hl, $2000
	call	VDP_SetVRAMPointer
	ld		hl, Art_Title_Screen	;title screen compressed art
	xor		a
	call	LoadTiles			   ;load the tiles into VRAM
	ld		a, $08				  ;page in bank 08
	call	Engine_SwapFrame2
	ld		hl, $38CC			   ;destination
	ld		de, Mappings_Title	  ;source
	ld		bc, $1214			   ;row/col count
	call	Engine_LoadCardMappings	 ;load the mappings into VRAM
	ld		a, $2C				  ;set the background scroll values
	ld		(BackgroundYScroll), a  
	ld		a, $F8
	ld		(BackgroundXScroll), a
	di		
	ld		hl, $DB00			   ;clear the working SAT
	ld		de, $DB01
	ld		bc, $00BF
	ld		(hl), $00
	ldir	
	ld		a, $00				  ;clear the first object
	ld		($D500), a
	ld		a, :Bank08			  ;swap in bank 8 
	call	Engine_SwapFrame2
	ld		hl, $0200
	call	VDP_SetVRAMPointer
	ld		hl, Art_Title_Sonic_Hand	;load sonic's animated hand
	xor		a
	call	LoadTiles
	
	ld		hl, $05C0
	call	VDP_SetVRAMPointer
	ld		hl, Art_Title_Tails_Face	;load tails' animated eye
	xor		a
	call	LoadTiles
	
	ld		c, $50		  ;object number
	ld		h, $00
	call	Engine_AllocateObjectHighPriority	   ;set up the hand object
	
	ld		c, $51		  ;object number
	ld		h, $00
	call	Engine_AllocateObjectHighPriority   ;set up the eye object
	
	call	LoadLevelPalette
	ld		a, $40
	ld		(GameState), a
	
	xor		a
	ld		($D12F), a		;reset the frame counter

	ld		bc, $001E
	push	bc
	call	WaitForInterrupt
	call	Engine_UpdateLevelState
	call	TitleScreen_ChangePressStartText
	pop		bc
	dec		bc
	ld		a, b
	or		c
	jr		nz, $F0
	ld		bc, $04B0
	call	LABEL_107C
	push	bc
	call	WaitForInterrupt
	call	Engine_UpdateLevelState
	call	TitleScreen_ChangePressStartText
	pop		bc
	dec		bc
	ld		a, b
	or		c
	jr		nz, $ED
	ret		

TitleScreen_ChangePressStartText:
LABEL_1060:
	;page in the bank containing the mappings
	ld		a, :Bank08
	call	Engine_SwapFrame2
	
	ld		a, ($D12F)				;get the frame counter value
	
	ld		de, Mappings_Title + $258	;"Press Start Button" text mappings
	
	and		$20						;alternate between "Press Start Button" and blank
	jr		z, +					;row every 32nd frame

	ld		de, Mappings_Title		;title screen mappings
	
+:	ld		hl, $3C8C				;vram destination
	ld		bc, $0114				;rows/cols
	;load the mappings into VRAM
	call	Engine_LoadCardMappings
	ret

LABEL_107C:
	ld		hl, $D292
	bit		7, (hl)
	ret		z
	pop		af
	ret		
	
LABEL_1084:
Engine_ChangeLevelMusic:
	ld		a, (CurrentLevel)
	ld		b, a
	add		a, a
	add		a, b
	ld		b, a
	ld		a, (CurrentAct)
	add		a, b
	ld		l, a
	ld		h, $00
	ld		de, ZoneMusicTracks_Start
	add		hl, de
	ld		a, (hl)
	ld		(NextMusicTrack), a
	ret		

ZoneMusicTracks_Start:
;  |---- Act ----|
;  | 1  | 2  | 3 |
.db $82, $82, $82 ;Under Ground Zone
.db $86, $86, $86 ;Sky High Zone
.db $81, $81, $81 ;Aqua Lake  Zone
.db $85, $85, $85 ;Green Hills Zone
.db $83, $83, $83 ;Gimmick Mountain Zone
.db $87, $87, $87 ;Scrambled Egg Zone
.db $84, $84	  ;Crystal Egg Zone
.db $89		   ;Boss/Crystal Egg Act 3
.db $91, $91, $91 ;End Credits

FadeMusic:
LABEL_10B3:
	ld		hl, $DD09
	ld		(hl), $0C
	inc		hl
	ld		(hl), $01
	inc		hl
	ld		(hl), $02
	ret		

	
;loads the player sprite tiles into VRAM
Engine_LoadPlayerTiles:	 ;$10BF
	ld		a, ($D34E)
	and		$A0
	cp		$A0			;check for bits 5 & 7
	ret		nz
	ld		a, ($D34F)	 ;which sprite?
	or		a
	jp		z, Engine_ClearPlayerTiles
	ld		l, a		   ;calculate offset (aligned to 4-byte)
	ld		h, $00
	add		hl, hl
	add		hl, hl
	ld		de, Data_PlayerSprites - $04
	ld		a, ($D34E)
	bit		6, a		   ;if bit 6 is set the sprite is facing left
	jr		z, +
	ld		de, Data_PlayerSprites_Mirrored - $04
+:	add		hl, de
	ld		a, :Data_PlayerSprites
	ld		($FFFF), a
	ld		a, (hl)		;bank number
	inc		hl
	ld		e, (hl)		;art pointer
	inc		hl
	ld		d, (hl)
	inc		hl
	ld		b, (hl)		;tile count / 2 (each sprite is 8x16)
	ld		($FFFF), a
	;set vram address to $0
	ld		a, $00
	out		($BF), a
	ld		a, $00
	or		$40
	out		($BF), a
Engine_LoadPlayerTiles_CopyTiles:   ;copy 2 tiles (64 bytes) to vram
.REPEAT 64
	ld		a, (de)
	out		($BE), a
	inc		de
	nop
.ENDR

	dec		b
	jp		nz, Engine_LoadPlayerTiles_CopyTiles
	ld		hl, $D34E
	res		7, (hl)
	ret

;*****************************************
;* Resets the tile patters in VRAM.	  *
;*****************************************
Engine_ClearPlayerTiles:
	;set vram address to $0
	ld		a, $00
	out		($BF), a
	ld		a, $00
	or		$40
	out		($BF), a
	xor		a
	ld		b, $20
-:  out  ($BE), a
	out		($BE), a
	out		($BE), a
	out		($BE), a
	out		($BE), a
	out		($BE), a
	out		($BE), a
	out		($BE), a
	out		($BE), a
	out		($BE), a
	out		($BE), a
	out		($BE), a
	out		($BE), a
	out		($BE), a
	out		($BE), a
	out		($BE), a
	djnz	-
	ret

	
;updates sprite art flags + frame index
Engine_UpdateSpriteAttribsArt:		  ;$1274
	ld		hl, $D34E
	ld		a, ($D504)
	rlca
	rlca
	and		$40
	or		$20
	ld		(hl), a
	ld		a, ($D350)
	cp		(hl)
	jr		z, +
	ld		a, (hl)
	ld		($D350), a
	set		7, (hl)
+:  ld   a, ($D34F)
	ld		b, a
	ld		a, ($D506)
	cp		b
	ret		z
	ld		($D34F), a	 ;animation frame art to load
	set		7, (hl)		;set the "sprite art update required" flag
	ret


Engine_SwapFrame2:
LABEL_129C:
	ld		($D12B), a
	ld		($FFFF), a
	ret

LABEL_12A3_4:
	ld		bc, $0A96
	;read the VDP status flags
	in		a, ($BF)
-:  in   a, ($BF)   ;- 12 T-states	  FIXME: why read a second time? Timing issue? 
	and		a		  ;- 4 T-states
	;wait for no pending frame interrupt
	jp		p, -
	;run a busy-loop
-:  dec  bc
	ld		a, c
	or		b
	jp		nz, -
	in		a, ($BF)
	and		a
	ld		a, $01
	;jump if pending frame interrupt
	jp		m, +
	dec		a
+:  ld   ($D12D), a
	or		a
	ret		nz
	ld		a, $80
	ld		($DE91), a
	ret

PaletteFadeOut:
LABEL_12C8:
	ld		hl, BgPaletteControl
	ld		(hl), $00
	set		6, (hl)	;flag - background palette fade to black.
	inc		hl
	inc		hl
	ld		(hl), $00
	set		6, (hl)   ;flag - foreground palette fade to black.
	ret

LABEL_12D6_79:
_WriteToPaletteRAM:
	;check the PaletteUpdatePending flag
	ld		a, (PaletteUpdatePending)
	or		a
	;don't update if the flag is 0
	ret		z
	ld		hl, WorkingCRAM
	ld		de, $C000
	ld		bc, $0020
	call	VDP_CopyToVRAM
	;reset the PaletteUpdatePending flag
	xor		a
	ld		(PaletteUpdatePending), a
	ret

Initialise_VDP_Registers:
	;read/clear VDP status flags
	in		a, ($BF)
	ld		b, $0B
	ld		c, $80
	ld		de, VDPRegister0
	ld		hl, Initial_VDP_Register_Values
-:  ld   a, (hl)
	out		($BF), a
	ld		(de), a
	ld		a, c
	out		($BF), a
	inc		c
	inc		de
	inc		hl
	djnz	-
	ret

Initial_VDP_Register_Values:
.db $26, $82, $FF, $FF, $FF, $FF, $FB, $00, $00, $00, $FF


;********************************************************
;*  Write to VDP Register and maintain a copy in RAM.   *
;*  NOTE: seems to be unused (debug?)				   *
;*													  *
;*  in  b	   The data.							   *
;*  in  c	   The register.						   *
;*  destroys	A									   *
;********************************************************
Write_VDP_Register:
LABEL_1310:
	push	bc
	push	hl
	;update the VDP Register
	ld		a, b
	out		($BF), a
	ld		a, c
	or		$80
	out		($BF), a
	;update the RAM copy
	ld		a, b
	ld		b, $00
	ld		hl, VDPRegister0
	add		hl, bc
	ld		(hl), a
	pop		hl
	pop		bc
	ret


LABEL_1325:
	in		a, ($BF)
	ret


;****************************************************
;*  Set the VDP to write to a specific address.	 *
;*  in  hl	  The VRAM address.				   *
;****************************************************
VDP_SetVRAMPointer:	 ;$1328
	push	af		 ;preserve AF
	ld		a, l	   ;set the VRAM pointer
	out		($BF), a
	ld		a, h
	or		$40
	out		($BF), a
	pop		af		 ;restore AF
	ret


;****************************************************
;*  Sends a VRAM Read command to the VDP with the   *
;*  address stored in HL.						   *
;*  in  hl	  The VRAM address.				   *
;****************************************************
VDP_SendRead:		   ;$1333
	ld		a, l
	out		($BF), a
	ld		a, h
	and		$3F
	out		($BF), a
	push	af
	pop		af
	ret


;NOTE: Probably unused code
LABEL_133E:
	push	af
	call	VDP_SetVRAMPointer
	pop		af
	out		($BE), a
	ret

;NOTE: Probably unused code
LABEL_1346:
	call	VDP_SendRead
	in		a, ($BE)
	ret

;NOTE: Probably unused code
LABEL_134C:
	push	de
	push	af
	call	VDP_SetVRAMPointer
	pop		af
	ld		d, a
	ld		a, d
	out		($BE), a
	push	af
	pop		af
	in		a, ($BE)
	dec		bc
	ld		a, b
	or		c
	jr		nz, $F4
	pop		de
	ret

;************************************************
;*  Copy a single value to a block of VRAM.	 *
;*											  *
;*  in  hl	  The VRAM address to copy to.	*
;*  in  de	  The vale to copy to VRAM.	   *
;*  in  bc	  Byte count.					 *
;*  destroys	A, BC
;************************************************
VDP_WriteToVRAM:		;$1361
	call	VDP_SetVRAMPointer
-:  ld   a, e		   ;write DE to VRAM
	out		($BE), a
	push	af 
	pop		af
	ld		a, d
	out		($BE), a
	
	dec		bc
	ld		a, b
	or		c
	jr		nz, -
	ret

;************************************************
;*  Copy a block of data from RAM to VRAM.	  *
;*											  *
;*  in  hl	  The source address.			 *
;*  in  de	  The VRAM address.			   *
;*  in  bc	  Byte count.					 *
;*  destroys	A, BC, DE, HL				   *
;************************************************
VDP_CopyToVRAM:		 ;$1372
	ex		de, hl		 ;set the VRAM pointer
	call	VDP_SetVRAMPointer
	
-:  ld   a, (de)		;copy from (de) to VRAM
	out		($BE), a
	inc		de
	dec		bc
	ld		a, b
	or		c
	jr		nz, -
	ret


LABEL_1381:
SetDisplayVisible:
	;set register VDP(1) - mode control register 2
	ld		hl, VDPRegister1
	ld		a, (hl)
	;change all flags - make sure display is visible
	or		$40
	ld		(hl), a
	out		($BF), a
	ld		a, $81
	out		($BF), a
	ret

_VDP_Set_Register_1_flags_0_to_5:
	;set register VDP(1) - mode control register 2
	ld		hl, VDPRegister1
	ld		a, (hl)
	;only set flags 0 to 5
	and		$BF
	ld		(hl), a
	out		($BF), a
	ld		a, $81
	out		($BF), a
	ret

EnableFrameInterrupt:
	ld		hl, VDPRegister1
	ld		a, (hl)
	or		$20
	ld		(hl), a
	out		($BF), a
	ld		a, $81
	out		($BF), a
	ret


;********************************************
;* Set the value for VDP(1) but leave the   *
;* "Frame Interrupt" bit unchanged.		 *
;********************************************
SetVDPRegister1_LeaveInt:
LABEL_13AA:
	ld		hl, VDPRegister1
	ld		a, (hl)
	and		$DF
	ld		(hl), a
	out		($BF), a
	ld		a, $81
	out		($BF), a
	ret

;**********************************************
;*  DrawText
;*   Used by Level Select routine to draw text
;*   to the screen.
;*	hl  - The VRAM address.
;*	de  - Pointer to chars
;*	bc  - Char count
;**********************************************
DrawText:
LABEL_13B8:
	di
	call	VDP_SetVRAMPointer
	push	de
	push	bc
-:  ld   a, (de)
	out		($BE), a	   ;write a char to the VDP memory
	ld		a, ($D2C7)	 ;retrieve the tile attributes byte
	nop
	nop
	nop
	out		($BE), a	   ;write the attributes byte to the VDP
	inc		de			  ;increment pointer to next char
	dec		bc			 ;decrement counter
	ld		a, c
	or		b
	jr		nz, -		  ;jump if not zero
	pop		bc
	pop		de
	ret

LABEL_13D2:
	push	de
	push	bc
	ld		a, ($D292)
	bit		7, a
	jr		nz, +
	di
	call	VDP_SetVRAMPointer
	ld		a, (de)
	out		($BE), a
	ld		a, ($D2C7)
	nop
	nop
	nop
	out		($BE), a
	ei
	push	bc
	push	de
	push	hl
	ld		b, $06
-:  ei
	halt
	ld		a, ($D137)
	and		$80
	jr		nz, ++
	djnz	-
++: pop	 hl
	pop		de
	pop		bc
	inc		hl
	inc		hl
	inc		de
	dec		bc
	ld		a, c
	or		b
	jr		nz, $CE
+:  pop	 bc
	pop		de
	ret

	
;******************************************************************************
;* Updates SAT with data from $DB00 and $DB40. $DB00 contains VPOS attribues  *
;* that get copied into VRAM at $3F00 -> $3F3F. $DB40 contains HPOS and char  *
;* codes that get copied into $3F7F -> $3FFF.								 *
;******************************************************************************
UpdateSAT:
LABEL_1409:
	ld		hl, SATUpdateRequired	   ;check to see if SAT update is required
	xor		a
	or		(hl)
	ret		z				;don't bother updating if $D134 = 0
	
	ld		(hl), $00		;reset the "update required" flag
	
	ld		a, ($D12F)		;if framecount is odd do a descending update
	rrca
	jp		c, UpdateSAT_Descending
	
	ld		a, $00		  ;set VRAM pointer to $3F00 (SAT)
	out		($BF), a
	ld		a, $3F
	or		$40
	out		($BF), a
	ld		hl, $DB00	   ;copy 64 VPOS bytes.
	ld		c, $BE
.REPEAT 64
	outi
.ENDR
	ld		a, $80		  ;set VRAM pointer to SAT + $80
	out		($BF), a
	ld		a, $3F
	or		$40
	out		($BF), a
	ld		hl, $DB40	   ;copy HPOS and char code attributes to VRAM at $3F7F.
	ld		c, $BE
.REPEAT 128
	outi
.ENDR
	ret


;******************************************************************************
;* Updates SAT with data from $DB00 and $DB40. Player sprites written first.  *
;* The remaining sprites are written in descending order.					 *
;******************************************************************************
UpdateSAT_Descending:
LABEL_15B7_76:
	ld		a, $00	  ;set VRAM pointer to SAT
	out		($BF), a
	ld		a, $3F
	or		$40
	out		($BF), a
	ld		hl, $DB00   ;write 8 bytes from $DB00 to VRAM
	ld		c, $BE
	outi
	outi
	outi
	outi
	outi
	outi
	outi
	outi
	ld		hl, $DB3F   ;write 56 bytes from $DB3F (decremented) to VRAM
	ld		c, $BE
.REPEAT 56
	outd
.ENDR
	ld		a, $80		  ;set VRAM pointer to SAT + $80
	out		($BF), a
	ld		a, $3F
	or		$40
	out		($BF), a
	ld		hl, $DB40	   ;write 16 bytes from $DB40 to SAT + $80
	ld		c, $BE
.REPEAT 16
	outi
.ENDR
	ld		hl, $DBBE   ;write $38 2-byte words descending from $DBBE
	ld		de, $FFFC   ; -4
	ld		c, $BE
.REPEAT 56
	outi
	outi
	add		hl, de
.ENDR
	ret		



;****************************************************
;*  Clears the screen map & sprite attribute table. *
;****************************************************
Engine_ClearNameTable:	  ;179B
	ei
	halt
	di
	ld		hl, ScreenMap  ;address
	ld		bc, $0380	  ;count
	ld		de, $0000	  ;value
	call	VDP_WriteToVRAM
	jr		Engine_ClearSAT


;************************************************************
;*  Clears the screen by resetting the first level tile	 *
;*  (i.e. the tiles starting at $2000) in VRAM and then	 *
;*  setting each element in the screen map to point to it.  *
;*														  *
;*  destroys	A, BC, DE, HL							   *
;************************************************************
Engine_ClearScreen:	 ;$17AC
	ei
	halt
	di
	ld		hl, $2000		  ;clear the first level tile from VRAM (32-bytes starting at $2000)
	ld		bc, $0020
	ld		de, $0000
	call	VDP_WriteToVRAM
	ld		hl, ScreenMap	  ;set up all background tiles to point to the first "level tile"
	ld		bc, $0380
	ld		de, $0100
	call	VDP_WriteToVRAM


;************************************************************
;*  Clears the copy of the SAT that's stored in work RAM	*
;*  and sets the SAT update trigger.						*
;*														  *
;*  destroys	A, B, DE, HL								*
;************************************************************
Engine_ClearSAT:			;$17C7
	ld		hl, $DB00		  ;fill $DB00->$DB3F with $F0, $DB40->$DBC0 with $00
	ld		de, $DB40		  ;this will be copied into the SAT with the next update
	xor		a				  ;so that all sprites have VPOS=240
	ld		b, $40
-:  ld   (hl), $F0
	inc		hl
	ld		(de), a
	inc		de
	ld		(de), a
	inc		de
	djnz	-
	ld		a, $FF			 ;set the SAT update trigger.
	ld		(SATUpdateRequired), a
	ret


;************************************************************
;*
Engine_UpdateSpriteAttribs:	 ;$17DF
	ld		a, (GameState)
	bit		7, a
	jp		nz, LABEL_1937_190
	ld		ix, $D500		  ;player object descriptor
	ld		hl, $DB00
	ld		($D369), hl		;store the SAT VPOS pointer
	ld		hl, $DB40
	ld		($D36B), hl		;store the SAT HPOS pointer
	
	ld		b, $14			 ;number of objects to update
	
	;update each object
-:  xor  a				  ;check that object state != 0
	or		(ix+$01)
	jr		z, +

	ld		a, (ix+$00)		;get object type
	dec		a
	cp		$EF
	jr		nc, +
	
	push	bc
	ld		c, (ix+$04)
	bit		5, c		   ;sprite flashing
	call	nz, Engine_ToggleSpriteVisible
	bit		7, c		   ;set = sprite not drawn
	jr		nz, ++
	bit		6, c		   ;set = sprite not drawn
	jr		nz, ++
	call	Engine_GetObjectScreenPos
	call	Engine_UpdateObjectVPOS
	call	Engine_UpdateObjectHPOS
++: pop  bc

+:  ld   de, $0040	  ;move to next sprite
	add		ix, de
	djnz	-
	
	ld		hl, ($D369)	;update vpos attribs?
	ld		a, $32
	sub		l
	jr		c, +
	inc		a
	ld		c, a
	ld		b, $00
	ld		e, l
	ld		d, h
	inc		de
	ld		(hl), $E0	  ;set remaining sprites VPOS = 224
	ldir
+:  ld   a, $FF
	ld		(SATUpdateRequired), a
	ret

;********************************************************
;*  Updates the VPOS attributes for each of an object's *
;*  sprites.											*
;*													  *
;*  IX	  -   Pointer to object descriptor.		   *
;*  ($D36B) -   Pointer to the object's SAT VPOS attrib *
;********************************************************
Engine_UpdateObjectVPOS:		;$1842
	ld		iy, ($D369)	 ;SAT VPOS
	ld		h, (ix+$2B) 
	ld		l, (ix+$2A)
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	ld		l, (ix+$1C)	 ;object's vertical position on screen
	ld		h, (ix+$1D)
	add		hl, de
	ld		($D393), hl
	exx
	ld		d, (ix+$29)	 ;get a pointer to the sprite arrangement offsets
	ld		e, (ix+$28)
	ld		bc, ($D393)
	exx
	ld		a, (ix+$05)	 ;sprite count
	or		a
	ret		z
	ld		b, a			;loop through each sprite
-:  exx
	ld		a, (de)		 ;get the offset value for this sprite
	ld		l, a
	inc		de
	ld		a, (de)
	ld		h, a
	inc		de
	add		hl, bc		  ;adjust the vertical position for the sprite
	ld		(iy+0), l	   ;store in the working SAT
	ld		a, $40
	add		a, l
	ld		l, a
	jr		nc, +
	inc		h
+:  ld	  a, h
	or		a
	jr		nz, +
	ld		a, l
	cp		$30
	jr		nc, ++
+:  ld	  (iy+0), $E0	 ;push the sprite to line 224
++: inc	 de			  ;move to the next sprite offset value
	inc		de
	inc		iy			  ;move to the next VPOS in the working SAT
	exx
	djnz	-			   ;update next sprite
	ld		($D369), iy	 ;store current VPOS pointer
	ret


;********************************************************
;*  Updates the VPOS attributes for each of an object's *
;*  sprites.											*
;*													  *
;*  IX	  -   Pointer to object descriptor.		   *
;*  ($D36B) -   Pointer to the object's SAT HPOS attrib *
;********************************************************
Engine_UpdateObjectHPOS:		;$1896
	ld		iy, ($D36B)	 ;SAT HPOS pointer
	ld		h, (ix+$2B)
	ld		l, (ix+$2A)
	inc		hl			  ;skip over vertical offset word
	inc		hl
	ld		e, (hl)		 ;get horizontal offset word
	inc		hl
	ld		d, (hl)
	bit		4, (ix+4)	   ;which direction is the object facing?
	jr		z, +			;2's comp the offset if we need to.
	dec		de
	ld		a, e
	cpl
	ld		e, a
	ld		a, d
	cpl
	ld		d, a
+:  inc	 hl
	ld		c, (hl)		 ;get the pointer to the object's char codes
	inc		hl
	ld		b, (hl)
	ld		($D110), bc	 ;store the pointer for later
	ld		l, (ix+$1A)	 ;horiz. pos on screen
	ld		h, (ix+$1B)
	add		hl, de		  ;add the horiz. offset value to the object's position
	ld		($D393), hl	 ;store the value for later
	exx
	ld		d, (ix+$29)	 ;get the pointer to the sprite arrangement data
	ld		e, (ix+$28)
	inc		de			  ;skip over the VPOS offset value
	inc		de
	ld		a, (ix+$00)
	dec		a
	jr		z, +
	bit		4, (ix+$04)	 ;adjust the pointer if the object is facing
	jr		z, +			;backwards
	ld		hl, $046C
	add		hl, de
	ex		de, hl
+:  ld	  bc, ($D393)	 ;fetch the horizontal position value
	exx
	ld		a, (ix+5)	   ;get the sprite count
	or		a
	ret		z
	ld		b, a			;loop thru each sprite
-:  exx
	ld		a, (de)		 ;calculate the VPOS attribute
	ld		l, a
	inc		de
	ld		a, (de)
	ld		h, a
	inc		de
	add		hl, bc
	ld		(iy+0), l	   ;store the VPOS attribute
	ld		a, h
	or		a
	jr		z, +
	ld		(iy+0), $00	 ;push the sprite off screen
+:  inc	 de			  ;move to the next sprite offset value
	inc		de
	inc		iy			  ;move to the sprite's char code
	ld		hl, ($D110)	 ;get the pointer to the char codes
	ld		a, (hl)		 
	bit		4, (ix+$04)	 ;which direction are we facing
	jr		z, +			;calculate the VRAM char code
	add		a, (ix+$09)	 ;add the VRAM tile offset for left-facing sprites
	jr		++
+:  add	 a, (ix+$08)	 ;add the VRAM tile offset for right-facing sprites
++: ld	  (iy+$00), a	 ;store the char code in the working SAT.
	inc		hl			  ;increment the char code pointer...
	ld		($D110), hl	 ;...and store it for later
	inc		iy			  ;move to the next sprite's HPOS
	exx
	djnz	-			   ;update the next sprite
	ld		($D36B), iy	 ;store the current HPOS pointer
	ret

Engine_ToggleSpriteVisible:	 ;$1923
	inc		(ix+$2E)
	ld		a, (ix+$2E)
	rrca
	rrca
	jr		c, +			;hide sprite when frame count % 2 == 0
	res		7, (ix+4)
	ret
+:  set	 7, (ix+4)
	ret

LABEL_1937_190:
	ld		ix, $D500
	ld		hl, $DB00
	ld		($D369), hl
	ld		hl, $DB40
	ld		($D36B), hl
	ld		b, $10
-:  xor  a
	or		(ix+1)
	jr		z, ++
	ld		a, (ix+0)
	dec		a
	cp		$EF
	jr		nc, ++
	push	bc
	ld		c, (ix+4)
	bit		5, c
	call	nz, Engine_ToggleSpriteVisible
	bit		7, c
	jr		nz, +
	bit		6, c
	jr		nz, +
	call	Engine_GetObjectScreenPos
	call	Engine_UpdateObjectVPOS
	call	Engine_UpdateObjectHPOS
+:  pop  bc
++: ld   de, $0040
	add		ix, de
	djnz	-
	ld		a, $FF
	ld		(SATUpdateRequired), a
	ret

;******************************************
;* Load Mappings into VRAM
;*
;*  HL  - VRAM Address
;*  DE  - Pointer to mappings
;*  B   - Row Count
;*  C   - Column Count
;******************************************
Engine_LoadCardMappings:					;$197F
	;calculate vram address
	call	LABEL_19D7
Engine_LoadMappings:		;$1982
	push	bc
	push	hl
	ld		b, c
	call	VDP_SetVRAMPointer
-:  ld   a, (de)
	out		($BE), a   ;write tile 1
	inc		de
	inc		hl
	ld		a, (de)
	nop
	nop
	out		($BE), a   ;write attribute
	inc		de
	inc		hl
	ld		a, l
	and		$3F		;wrap at the 64th address
	jp		nz, +
	push	de
	ld		de, $0040
	or		a
	sbc		hl, de
	call	VDP_SetVRAMPointer ;...and set VRAM pointer
	pop		de
+:  djnz -
	pop		hl
	ld		bc, $0040
	add		hl, bc
	ld		a, h	   ;make sure we're not overwriting the SAT
	cp		$3F
	jp		nz, +
	ld		h, $38	 
+:  pop  bc		 ;move to the next row
	djnz	Engine_LoadMappings
	ei
	ret

LABEL_19B9:		 ;TODO: seems to be unused
	ld		a, l
	and		$3F
	ret		nz
	push	de
	ld		de, $0040
	or		a
	sbc		hl, de
	call	VDP_SetVRAMPointer
	pop		de
	ret

_Unknown_5:		 ;TODO: seems to be unused   
	ld		a, h
	cp		$3F		;check for overflow from SAT
	ret		nz
	ld		h, $38
	ret

_Unknown_6:		 ;TODO: seems to be unused
	ld		a, h
	cp		$38		;check for overflow from screen map
	ret		nc
	ld		h, $3E
	ret

LABEL_19D7:
	push	bc
	ld		a, l
	and		$C0
	ld		b, a
	ld		a, ($D174)	 ;horiz. offset in level
	rrca
	rrca
	add		a, l
	and		$3E
	or		b
	ld		l, a
	push	hl
	ld		a, ($D176)	 ;vert. offset in level
	rrca
	rrca
	rrca
	and		$1F
	rlca
	ld		c, a
	ld		b, 0
	ld		hl, Data_OffscreenBufferOffsets
	add		hl, bc
	ld		c, (hl)
	inc		hl
	ld		b, (hl)
	pop		hl
	add		hl, bc
	ld		a, h
	cp		$3F
	jr		c, 6
	or		a
	ld		bc, $0700
	sbc		hl, bc
	pop		bc
	ret


;********************************************************
;*  Updates a single mapping block to the screen after  *
;*  a change to the level layout (e.g. player collected *
;*  a ring or destroyed a breakable block.)			 *
;*  Copies each of the tiles in the block to VRAM.	  *
;********************************************************
Engine_UpdateMappingBlock:
	di
	call	LABEL_1A13	 ;calculate VRAM address
	ld		bc, $0404	  ;load a mapping block
	jp		Engine_LoadMappings

LABEL_1A13:
	ld		hl, ($D358)	;collision vert. pos
	ld		a, l
	and		$E0			;cap at line 224
	ld		l, a		   
	srl		h
	rr		l	  ;hl /= 2
	srl		h
	rr		l	  ;hl /= 2
	ld		bc, Data_OffscreenBufferOffsets
	add		hl, bc
	ld		c, (hl)
	inc		hl
	ld		b, (hl)
	ld		a, ($D356)	 ;collision horiz. pos
	rrca
	rrca
	and		$38
	ld		l, a
	ld		h, $38		 ;offset into screen map
	add		hl, bc
	ret

ReadInput:  ;$1A35
	ld		hl, $D145
	ld		de, $D146
	ld		bc, $000F
	lddr
	ld		hl, $D155
	ld		de, $D156
	ld		bc, $000F
	lddr
	call	_Port1_Input
	cpl
	ld		($D137), a	  ;store joypad bitfield
	ld		a, ($D138)  
	xor		$FF		 
	ld		b, a
	ld		a, ($D137)	  ;load joypad bitfield
	and		$BF			 ;using only joypad-1 bits
	ld		c, a
	xor		$FF
	xor		b
	and		c
	ld		($D147), a
	ld		($D157), a
	ld		a, ($D292)	  ;should cpu control sonic?
	bit		3, a
	call	nz, MovePlayer	  ;should the cpu control the player?
	in		a, ($DD)		;is "reset" button pressed?
	cpl
	and		$10
	ret		z
	jp		Start
	ret

_Port1_Input:   ;$1A7A
	in		a, ($DC)
	or		$C0
	and		$7F
	ld		b, a
	ld		c, $80
	and		$30		;check buttons 1 & 2
	jr		nz, +	  ;jump if buttons not pressed
	ld		c, $00
+:  ld   a, c
	or		b
	ret

;*******************************************
;*  Used in the demo levels to move Sonic. *
;*******************************************
MovePlayer:
LABEL_1A8C_85:
	ld		a, ($D2D8)		 ;page in the bank with the control sequences
	ld		($FFFF), a
	ld		hl, (ControlByte)  ;fetch the offset (offset for the current control sequence within the bank)
	ld		a, h			   ;bail out if offset = 0
	or		l
	ret		z
	ld		a, (hl)			;load the control byte
	ld		($D137), a		 ;and store it for later
	inc		hl
	ld		a, (hl)
	ld		($D147), a
	inc		hl
	ld		(ControlByte), hl  ;fetch the next offset 
	ret


.include "src\tile_loading_routines.asm"



;********************************************************
;*	Multiply an 8-bit integer with an 8-bit unsigned	*
;*	value.	UNUSED										*
;*														*
;*	in	H		Multiplier.								*
;*		E		Multiplicand.							*
;*	out	HL		Product.								*
;*	destroys	A, B, HL								*
;********************************************************
Engine_Multiply_8_by_8u:	;$1BDD
	ld		d, $00		;D = L = 0
	ld		l, d
	
	ld		b, $08		;loop 8 times	
-:	add		hl, hl
	jr		nc, +
	add		hl, de
+:	djnz	-

	ret


;********************************************************
;*	Divide a 16-bit integer by an 8-bit unsigned value.	*
;*														*
;*	in	HL		Dividend.								*
;*		E		Divisor.								*
;*	out	L		Quotient.								*
;*	destroys	A, B, HL								*
;********************************************************
Engine_Divide_16_by_u8:		;$1BE9
	ld		b, $10		;loop 16 times
	xor		a			;clear carry
	
-:	add		hl, hl
	rla					;rotate carry bit into A
	
	cp		e
	jr		c, +
	sub		e
	set		0, l		;FIXME: "inc l" is faster
+:	djnz	-
	ret


;unused
LABEL_1BF7:
	ld		a, $10
-:	sla		e
	rl		d
	adc		hl, hl
	jr		c, +
	
	sbc		hl, bc
	jr		nc, ++
	
	add		hl, bc
	dec		a
	jr		nz, - 
	ret

+:	or		a
	sbc		hl, bc
++:	inc		e
	dec		a
	jr		nz, -
	ret


ScoreCard_UpdateScore:		;$1C12
-:	ld		a, ($D137)		;check for button press
	and		$30
	jr		nz, +			;if not pressing a button, wait for 1 frame
	
	ei
	halt
	
+:	ld		a, (RingCounter)
	or		a
	jr		z, +++

	sub		$01				 ;decrement ring counter
	daa		
	ld		(RingCounter), a
	
	ld		hl, Score_BadnikValue
	call	LABEL_1CD0	  ;update score value
	call	LABEL_1D4F	  ;update score graphics?
	call	LABEL_1D6F
	ld		a, ($D137)	  ;check for button press
	and		$30
	jr		z, +

	ld		a, ($D12F)		;jump if framecount is odd
	and		$01
	jr		nz, ++

	ld		a, SFX_ScoreTick	;score 'tick' sound
	ld		(NextMusicTrack), a
	jr		++

+:	ld		a, ($D12F)			;get the frame counter
	and		$03
	jr		nz, ++

	ld		a, SFX_ScoreTick	;score 'tick' sound
	ld		(NextMusicTrack), a
++:	jr		-
+++:
	ld		b, $3C

-:	ei	  
	halt	
	djnz	-
	
-:	ld		a, ($D137)	  ;check for button press
	and		$30
	jr		nz, +

	ei		
	halt	
+:	xor		a
	ld		de, $D2A2	   ;score time value
	ld		hl, Score_BadnikValue
	ld		a, (de)
	sbc		a, (hl)
	daa		
	ld		(de), a
	inc		de
	inc		hl
	ld		a, (de)
	sbc		a, (hl)
	daa		
	ld		(de), a
	ld		hl, Score_BadnikValue
	call	LABEL_1CD0	  ;update score value
	call	LABEL_1D60
	call	LABEL_1D6F
	ld		a, ($D137)	  ;check for button press
	and		$30
	jr		z, +

	ld		a, ($D12F)		;jump if frame count is odd
	and		$01
	jr		nz, ++

	ld		a, SFX_ScoreTick	;score tick sound
	ld		(NextMusicTrack), a
	jr		++

+:	ld		a, ($D12F)
	and		$03
	jr		nz, ++
	
	ld		a, SFX_ScoreTick	;score tick sound
	ld		(NextMusicTrack), a
++:	ld		hl, $D2A2
	ld		a, (hl)
	inc		hl
	or		(hl)
	jr		nz, -

	ld		hl, $3C2A	   ;vram address
	ld		de, ScoreCard_Mappings_Blank	;mapping source
	ld		bc, $0202	   ;rows,cols
	call	Engine_LoadCardMappings
	ret

Score_AddBadnikValue:	   ;$1CB8
	ld		hl, Score_BadnikValue
	jp		LABEL_1CD0

Score_AddBossValue:		 ;$1CBE
	ld		hl, Score_BossValue
	jp		LABEL_1CD0

LABEL_1CC4:
	ld		hl, DATA_1E76
	jp		LABEL_1CD0

LABEL_1CCA:
	ld		hl, DATA_1E94
	jp		LABEL_1CD0


;Add the value pointed to by HL to the score
LABEL_1CD0:
	ld		a, ($D292)
	or		a
	ret		nz
	xor		a
	ld		de, Score
	ld		a, (de)
	adc		a, (hl)
	daa		
	ld		(de), a	 ;update first BCD byte
	inc		de
	inc		hl
	ld		a, (de)
	adc		a, (hl)
	daa		
	ld		(de), a	 ;update second BCD byte
	inc		de
	inc		hl
	ld		a, (de)
	adc		a, (hl)
	daa		
	ld		(de), a	 ;update third BCD byte
	
	jr		nc, +	   ;score overflow. cap at 999,990
	ld		hl, $D29F
	ld		(hl), $90
	inc		hl
	ld		(hl), $99
	inc		hl
	ld		(hl), $99
	ld		a, $02
	jr		++
+:  ld	  a, $01
++: ld	  ($D2B5), a
	call	LABEL_1D05
	jp		LABEL_1D34
		
LABEL_1D05: ;BCD subtraction subroutine
	xor		a
	ld		de, $D29E
	ld		hl, $D2A1
	ld		a, (de)
	sub		(hl)
	ret		c
	jr		z, +
	jr		++
+:  dec	 hl
	dec		de
	ld		a, (de)
	sub		(hl)
	ret		c
	jr		z, +
	jr		++
+:  dec	 hl
	dec		de
	ld		a, (de)
	sub		(hl)
	ret		c
	jr		nc, ++
++: ld	  hl, Score
	ld		de, $D29F
	ld		bc, $0003
	ldir	
	ld		a, $02
	ld		($D2B5), a
	ret

LABEL_1D34:
	ld		hl, $D2B6
	ld		a, (hl)
	or		a
	ret		nz
	ld		a, ($D29E)
	cp		$03
	ret		c
	ld		(hl), $01
	ld		hl, LifeCounter
	inc		(hl)
	ld		a, ($D293)
	bit		4, a
	ret		nz
	jp		CapLifeCounterValue

LABEL_1D4F:
	di		
	ld		a, $01
	ld		($D2B4), a
	ld		hl, RingCounter
	ld		de, $3BA4
	call	LABEL_1D7F
	ei		
	ret

LABEL_1D60:
	di		
	ld		a, $02
	ld		($D2B4), a
	ld		hl, $D2A2
	ld		de, $3C24
	call	LABEL_1D7F
LABEL_1D6F:
	ld		a, $03
	ld		($D2B4), a
	ld		hl, Score
	ld		de, $3CA0
	call	LABEL_1D7F
	ei		
	ret

LABEL_1D7F:
	push	de
	push	hl
	ld		de, $D2A8
	ld		bc, $0007
	ldir	
	pop		hl
	call	LABEL_1E37
	pop		hl
	ld		a, ($D2B4)
	cp		$02
	jr		c, +
	jr		z, ++
	ld		de, $D2B3
	ld		bc, $0605
	jr		LABEL_1DAF
++: ld	  de, $D2B1
	ld		bc, $0403
	jr		LABEL_1DAF
+:  ld	  de, $D2AF
	ld		bc, $0201
	jr		LABEL_1DAF  ;FIXME: pointless


LABEL_1DAF:
	ld		($D11C), hl
-:  ld	  a, c
	or		a
	jr		z, +
	dec		c
	ld		a, (de)
	cp		$30
	jr		nz, +
	ld		a, $3A
	jr		++
+:  ld	  c, $00
	ld		a, (de)
++: push	bc
	sub		$30
	add		a, a
	add		a, a
	push	de
	di		
	ld		hl, ($D11C)
	call	VDP_SetVRAMPointer
	ld		hl, ScoreCard_Mappings_Numbers
	ld		e, a
	ld		d, $00
	add		hl, de
	ld		a, (hl)
	out		($BE), a
	push	af
	pop		af
	inc		hl
	ld		a, (hl)
	out		($BE), a
	push	af
	pop		af
	inc		hl
	push	hl
	ld		hl, ($D11C)
	inc		hl
	inc		hl
	ld		($D11C), hl
	ld		de, $3E
	add		hl, de
	call	VDP_SetVRAMPointer
	pop		hl
	ld		a, (hl)
	out		($BE), a
	push	af
	pop		af
	inc		hl
	ld		a, (hl)
	out		($BE), a
	push	af
	pop		af
	inc		hl
	ei		
	pop		de
	dec		de
	pop		bc
	djnz	-
	ret

;mappings for scorecard digits 0-9
ScoreCard_Mappings_Numbers:	 ;$1E07
.db $4E, $11, $58, $11
.db $4F, $11, $59, $11
.db $50, $11, $5A, $11
.db $51, $11, $5B, $11
.db $52, $11, $5C, $11
.db $53, $11, $5B, $11
.db $54, $11, $48, $11
.db $55, $11, $5D, $11
.db $56, $11, $48, $11
.db $57, $11, $5B, $11

;mappings for blank character
ScoreCard_Mappings_Blank:	   ;$1E2F
.db $70, $11
.db $70, $11
.db $70, $11
.db $70, $11


LABEL_1E37:
	xor		a
	ld		hl, $D2A8
	ld		de, $D2AE
	ld		a, ($D2B4)
	ld		c, a
	ld		b, a
	cp		$04
	ccf		
	ret		c
-:  ld	  a, (hl)
	and		$0F
	cp		$0A
	ccf		
	ret		c
	ld		a, (hl)
	and		$F0
	cp		$A0
	ccf		
	ret		c
	inc		hl
	djnz	-
	ld		hl, $D2A8
	xor		a
	ld		b, c
-:  rrd	 
	or		$30
	ld		(de), a
	inc		de
	rrd		
	or		$30
	ld		(de), a
	inc		de
	inc		hl
	djnz	-
	ret

DATA_1E6D:
.db $00, $00, $00

Score_BadnikValue:
.db $01, $00, $00
Score_BossValue:
.db $50, $00, $00
DATA_1E76:
.db $00, $01, $00
DATA_1E79:
.db $10, $01, $00
DATA_1E7C:
.db $20, $01, $00
DATA_1E7F:
.db $30, $01, $00
DATA_1E82:
.db $40, $01, $00
DATA_1E85:
.db $50, $01, $00
DATA_1E88:
.db $60, $01, $00
DATA_1E8B:
.db $70, $01, $00
DATA_1E8E:
.db $80, $01, $00
DATA_1E91:
.db $90, $01, $00
DATA_1E94:
.db $00, $02, $00
DATA_1E97:
.db $10, $02, $00
DATA_1E9A:
.db $20, $02, $00
DATA_1E9D:
.db $30, $02, $00
DATA_1EA0:
.db $40, $02, $00
DATA_1EA3:
.db $50, $02, $00
DATA_1EA6:
.db $60, $02, $00
DATA_1EA9:
.db $70, $02, $00
DATA_1EAC:
.db $80, $02, $00
DATA_1EAF:
.db $90, $02, $00
DATA_1EB2:
.db $00, $03, $00
DATA_1EB5:
.db $10, $03, $00
DATA_1EB8:
.db $20, $03, $00
DATA_1EBB:
.db $30, $03, $00
DATA_1EBE:
.db $40, $03, $00
DATA_1EC1:
.db $50, $03, $00
DATA_1EC4:
.db $60, $03, $00
DATA_1EC7:
.db $70, $03, $00
DATA_1ECA:
.db $80, $03, $00
DATA_1ECD:
.db $90, $03, $00
DATA_1ED0:
.db $00, $05, $00
DATA_1ED3:
.db $00, $06, $00
DATA_1ED6:
.db $00, $07, $00
DATA_1ED9:
.db $00, $08, $00
DATA_1EDC:
.db $00, $09, $00
DATA_1EDF:
.db $00, $10, $00
DATA_1EE2:
.db $00, $15, $00
DATA_1EE5:
.db $00, $20, $00
DATA_1EE8:
.db $00, $25, $00
DATA_1EEB:
.db $00, $30, $00

LABEL_1EEE:
	ld		a, ($D2BA)
	or		a
	jr		nz, LABEL_1F0E
	ld		a, (LevelTimer)
	cp		$20
	jr		nc, ++
	ld		a, $20
++: sub	 $20
	add		a, a
	ld		l, a
	ld		h, $00
	ld		de, DATA_1F70
	add		hl, de
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	ex		de, hl
	jp		LABEL_2079

LABEL_1F0E:
+:  xor	 a
	ld		($D2A5), a
	ld		($D2A6), a
	ld		($D2A7), a
	ld		hl, (LevelTimer)	 ;get the current zone time
	ld		de, $0959		   ;subtract 9mins 59sec
	xor		a
	sbc		hl, de
	jr		z, +
	ld		hl, (LevelTimer)
	srl		h
	rr		l
	srl		h
	rr		l
	srl		h
	rr		l
	srl		h
	rr		l
	ld		a, l
	sub		$10
	jr		nc, ++
	xor		a
++: ld	  l, a
	ld		h, $00
	ld		de, DATA_1FE4
	add		hl, de
	ld		a, (hl)
	ld		($D2A5), a
	ld		a, (LevelTimer)
	and		$0F
	cp		$05
	jr		c, ++
	ld		a, ($D2A5)
	cp		$01
	jr		z, ++
	sub		$01
	daa		
	ld		($D2A5), a
++: xor	 a
	ld		($D2A6), a
	ld		($D2A7), a
	ld		hl, $D2A5
	jp		LABEL_2079
	
+:  ld	  hl, DATA_1ED0
	jp		LABEL_2079
		
		
DATA_1F70:
.dw DATA_1EEB
.dw DATA_1EE8
.dw DATA_1EE5
.dw DATA_1EE2
.dw DATA_1EDF
.dw DATA_1EDC
.dw DATA_1ED9
.dw DATA_1ED6
.dw DATA_1ED3
.dw DATA_1ED0
.dw DATA_1E6D
.dw DATA_1E6D
.dw DATA_1E6D
.dw DATA_1E6D
.dw DATA_1E6D
.dw DATA_1E6D
.dw DATA_1ECD
.dw DATA_1ECA
.dw DATA_1EC7
.dw DATA_1EC4
.dw DATA_1EC1
.dw DATA_1EBE
.dw DATA_1EBB
.dw DATA_1EB8
.dw DATA_1EB5
.dw DATA_1EB2
.dw DATA_1E6D
.dw DATA_1E6D
.dw DATA_1E6D
.dw DATA_1E6D
.dw DATA_1E6D
.dw DATA_1E6D
.dw DATA_1EAF
.dw DATA_1EAC
.dw DATA_1EA9
.dw DATA_1EA6
.dw DATA_1EA3
.dw DATA_1EA0
.dw DATA_1E9D
.dw DATA_1E9A
.dw DATA_1E97
.dw DATA_1E94
.dw DATA_1E6D
.dw DATA_1E6D
.dw DATA_1E6D
.dw DATA_1E6D
.dw DATA_1E6D
.dw DATA_1E6D
.dw DATA_1E91
.dw DATA_1E8E
.dw DATA_1E8B
.dw DATA_1E88
.dw DATA_1E85
.dw DATA_1E82
.dw DATA_1E7F
.dw DATA_1E7C
.dw DATA_1E79
.dw DATA_1E76


DATA_1FE4:
.incbin "unknown\s2_1FE4.bin"

;Used by the score card
;add the value pointed to by HL to the score at $D2A2
Engine_Score_AddValue:
LABEL_2079:
	ld		a, ($D292)
	or		a
	ret		nz

	xor		a
	ld		de, $D2A2
	ld		a, (de)
	adc		a, (hl)
	daa		
	ld		(de), a
	
	inc		de
	inc		hl
	ld		a, (de)
	adc		a, (hl)
	daa		
	ld		(de), a
	
	inc		de
	inc		hl
	ld		a, (de)
	adc		a, (hl)
	daa		
	ld		(de), a
	
	ret		nc

	ld		hl, $D2A2
	ld		(hl), $90
	inc		hl
	ld		(hl), $99
	inc		hl
	ld		(hl), $99
	ld		a, $02
	ret

;increment the zone timer clock
Engine_Timer_Increment:		 ;$20A1
	ld		a, (LevelTimerTrigger)	;is timer update required?
	or		a
	ret		z

	ld		hl, $D2BC			;increment the frame counter
	inc		(hl)

	ld		a, $3C	;return if the frame counter < 60
	sub		(hl)
	ret		nz

	ld		(hl), a	;frame counter == 60. reset the counter
	ld		hl, LevelTimer		;increment the zone timer
	ld		a, $01			  ;increment seconds
	add		a, (hl)
	daa
	ld		(hl), a

	sub		$60		;increment minutes if required
	jp		nz, Engine_Timer_SetSprites

	ld		(hl), a	;reset seconds
	inc		hl
	ld		a, $01	;increment minutes
	add		a, (hl)
	daa
	ld		(hl), a	;is the timer at 10 minutes?
	sub		$10
	jp		nz, Engine_Timer_SetSprites

	ld		a, $FF	;timer at 10 minutes. set the 
	ld		($D49F), a			;"Kill player" flag

	xor		a
	ld		(LevelTimerTrigger), a	;reset "timer update required" flag.
	ret

;calculate the sprites to display for the zone timer
Engine_Timer_SetSprites:		;$20D2
	ld		a, ($D292)
	or		a
	ret		nz

	ld		a, (LevelTimer+1)	;get the minutes
	rlca
	and		$1E		;calculate the sprite to display for the current value
	add		a, $10
	ld		($DBB9), a			;set the char code in the SAT

	ld		a, (LevelTimer)		;get the seconds
	rrca	;calculate the sprite to display for the most significant digit
	rrca
	rrca
	and		$1E
	add		a, $10
	ld		($DBBD), a			;set the char code in the SAT

	ld		a, (LevelTimer)		;calculate the sprite to display for the lest significant digit
	rlca
	and		$1E
	add		a, $10
	ld		($DBBF), a			;set the char code in the SAT
	ret

LABEL_20FB:
	ld		a, (ix+$0B)
	or		a
	ret		z
	ld		d, $00
	ld		e, (ix+$0A)
	ld		hl, DATA_330
	add		hl, de
	ld		a, (hl)
	and		a
	jp		p, LABEL_211B
	ld		($D100), a
	ld		a, $FF
	ld		($D101), a
	ld		($D106), a
	jr		+
LABEL_211B:
	ld		($D100), a
	xor		a
	ld		($D101), a
	ld		($D106), a
+:  ld	  hl, $0000
	ld		($D104), hl
	ld		b, (ix+$0B)
-:  ld	  hl, ($D104)
	ld		de, ($D100)
	add		hl, de
	ld		($D104), hl
	djnz	-
	push	ix
	pop		hl
	ld		de, $0010
	add		hl, de
	ld		de, $D104
	xor		a
	ld		a, (de)
	adc		a, (hl)
	ld		(hl), a
	inc		de
	inc		hl
	ld		a, (de)
	adc		a, (hl)
	ld		(hl), a
	inc		de
	inc		hl
	ld		a, (de)
	adc		a, (hl)
	ld		(hl), a
	ld		a, (ix+$0a)
	add		a, $C0
	ld		e, a
	ld		d, $00
	ld		hl, DATA_330
	add		hl, de
	ld		a, (hl)
	and		a
	jp		p, LABEL_2171
	ld		($D100), a
	ld		a, $FF
	ld		($D101), a
	ld		($D106), a
	jr		+
LABEL_2171:
	ld		($D100), a
	xor		a
	ld		($D101), a
	ld		($D106), a
+:  ld	  hl, $0000
	ld		($D104), hl
	ld		b, (ix+$0B)
-:  ld	  hl, ($D104)
	ld		de, ($D100)
	add		hl, de
	ld		($D104), hl
	djnz	-
	push	ix
	pop		hl
	ld		de, $0013
	add		hl, de
	ld		de, $D104
	xor		a
	ld		a, (de)
	adc		a, (hl)
	ld		(hl), a
	inc		de
	inc		hl
	ld		a, (de)
	adc		a, (hl)
	ld		(hl), a
	inc		de
	inc		hl
	ld		a, (de)
	adc		a, (hl)
	ld		(hl), a
	ret

Engine_LoadLevel:		;$21AA
	di
	call	Engine_ClearWorkingVRAM
	call	Engine_LoadLevelTiles
	call	Engine_InitStatusIcons
	ld		ix, $D15E
	call	Engine_ClearLevelAttributes		;clear level header
	call	Engine_LoadLevelHeader:
	call	Engine_LoadLevelLayout
	call	LoadRingArtPointers
	ld		a, $01				 	;set up the sonic object
	ld		($D500), a
	ld		a, ($D2B7)
	or		a
	jr		nz, +
	xor		a
	ld		(LevelTimer), a
	ld		(LevelTimer+1), a
	dec		a			;set timer update trigger
	ld		(LevelTimerTrigger), a
	ei
	halt
	ret
	
+:	ei			;FIXME: 3 wasted opcodes
	halt
	ret


Engine_ClearWorkingVRAM:	   ;21E0
	ld		hl, $D300   ;clear RAM from $D300 -> $DBBF
	ld		de, $D301
	ld		bc, $08BF
	ld		(hl), $00
	ldir
	ret

;****************************************************
;*  Initialises the status icons' art and positions *
;*  on screen. Status icons occupy the last 12	  *
;*  locations in the SAT so that they will be drawn *
;*  on top of everything else.					  *
;****************************************************
Engine_InitStatusIcons:	 ;$21EE
	ld		a, ($D292)
	or		a
	ret		nz
	di		
	call	Engine_ClearSAT
	ld		hl, Engine_Data_StatusIconDefaults
	ld		ix, $DB34			   ;VPOS for last 12 sprites in SAT
	ld		iy, $DBA8			   ;HPOS/char for last 12 sprites
	ld		b, $0C
	call	Engine_SetStatusIconPositions
	ld		a, (CurrentLevel)	   ;check to see if we're on the last level
	cp		$06
	jr		nz, +
	ld		a, (CurrentAct)		 ;check to see if we're on the last act
	cp		$02
	jr		nz, +
	ld		a, $E0				  ;we're on the last level
	ld		($DB38), a			  ;SAT vpos attributes
	ld		($DB39), a
+:  ei
	ret

;Initial positions of the status icons (lives/timer/rings)
Engine_Data_StatusIconDefaults:	 ;$221F
;		hpos
;   vpos  |   char
;  |----|----|----|
.db $AF, $28, $16	   ;life icon position
.db $AF, $10, $28
.db $AF, $18, $2A
.db $AF, $20, $24
.db $00, $20, $10	   ;ring icon position
.db $00, $28, $10
.db $00, $10, $3E
.db $00, $18, $40
.db $10, $10, $10	   ;timer position
.db $10, $18, $26
.db $10, $20, $10
.db $10, $28, $10

;****************************************************
;*  Copies the sprite defaults to the working copy  *
;*  of the SAT held in RAM at $DB00.				*
;****************************************************
Engine_SetStatusIconPositions:	  ;$2243
	ld		a, (hl)		 ;load vpos
	ld		(ix+$00), a
	inc		hl
	ld		a, (hl)		 ;load hpos
	ld		(iy+$00), a
	inc		hl
	ld		a, (hl)		 ;load char
	ld		(iy+$01), a
	inc		hl
	inc		ix
	inc		iy
	inc		iy
	djnz	Engine_SetStatusIconPositions
	ret		

;****************************************************
;*  Set the score/ring/life/etc. counters to their  *
;*  default values.								 *
;****************************************************
Engine_InitCounters:		;$225B
	ld		a, $03
	ld		(LifeCounter), a	;set the life count to 3
	ld		($D297), a
	xor		a
	ld		(RingCounter), a	;reset the ring count
	ld		(Score), a		  ;reset the 3-byte Score
	ld		(Score+1), a
	ld		(Score+2), a
	ld		($D2A2), a		  ;\ 
	ld		($D2A3), a		  ; |
	ld		($D2A4), a		  ; | used in score card tallying 
	ld		($D2A5), a		  ; |
	ld		($D2A6), a		  ; |
	ld		($D2A7), a		  ;/
	ld		($D2C5), a
	ld		a, ($D294)
	or		a
	ret		nz
	ld		(CurrentLevel), a
	ld		(CurrentAct), a
	ret		


;********************************************************
;*  Loads ring art, collision data pointer & cycling	*
;*  palette indices.									*
;********************************************************
LoadRingArtPointers:		;$2291
	xor		a
	ld		(RingCounter), a
	ld		a, (CurrentLevel)   ;get the pointer for the current level
	add		a, a
	ld		l, a
	ld		h, $00
	ld		de, RingArtPointers
	add		hl, de
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	
	ld		a, (CurrentAct)	 ;get the pointer for the current act
	add		a, a
	ld		l, a
	ld		h, $00
	add		hl, de
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	
	ex		de, hl
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	inc		hl
	ld		($D2D4), de	 ;collision data pointer
	
	ld		e, (hl)		 ;Read Source address
	inc		hl
	ld		d, (hl)
	inc		hl
	ld		(RingArt_SrcAddress), de
	
	ld		e, (hl)		 ;Read VRAM destination
	inc		hl
	ld		d, (hl)
	inc		hl
	ld		(RingArt_DestAddress), de
	
	ld		a, (hl)
	ld		($D4A6), a	  ;cycling palette index
	inc		hl
	
	ld		a, (hl)
	ld		($D4AE), a
	inc		hl
	
	ld		a, (hl)
	ld		($D4B6), a
	inc		hl
	
	ld		a, (hl)
	ld		($D4BE), a
	inc		hl
	ret

.include "src\ring_art_pointers.asm"


LABEL_2416:
;  00000000
;  |||||||`-
;  ||||||`--
;  |||||`---
;  ||||`---- Load demo flag
;  |||`----- Load title screen flag
;  ||`------ Load intro flag
;  |`------- 
;  `-------- Load level flag

ChangeGameMode:
	ld		a, ($D292)
	rlca
	jp		c, LABEL_24BE_48	   ;Load a level - jump if bit 0 is set
	rlca
	jr		c, LABEL_242F_49
	rlca
	jp		c, LABEL_2439_50	   ;load the Intro level - jump if bit 2 is set
	rlca
	jp		c, LABEL_2459_51	   ;load title screen - jump if bit 3 is set
	rlca
	jp		c, DemoSequence_PlayDemo	   ;load a demo - jump if bit 4 is set
	jp		ChangeGameMode


LABEL_242F_49:
	ld		hl, $D292
	res		6, (hl) ;intro flag
	set		5, (hl) ;title screen flag
	jp		ChangeGameMode


LABEL_2439_50:
	call	_Load_Intro_Level


LABEL_243C:
	ld		a, 0
	ld		($D700), a
	call	PaletteFadeOut
	call	FadeMusic
	ld		b, $2A
-:  ei
	halt
	djnz	-
	ld		hl, $D292
	res		5, (hl)	 ;clear load intro flag
	res		7, (hl)	 ;clear load level flag
	set		4, (hl)	 ;set load title screen flag
	jp		ChangeGameMode


LABEL_2459_51:
	call	_Load_Title_Level
	call	PaletteFadeOut	 ;fade the palette
	ld		b, $2A
-:  ei
	halt	
	djnz	-
	ld		hl, $D292
	res		4, (hl)	;clear load title screen flag
	set		3, (hl)	;set load demo flag
	jp		ChangeGameMode


DemoSequence_PlayDemo:	  ;246F
	di
	call	DemoSequence_ChangeLevel
	ld		a, $40			 ;set the "Demo mode" flag
	ld		(GameState), a
	call	DemoSequence_LoadLevel


LABEL_247B:
	ld		hl, (NextControlByte)
	ld		(ControlByte), hl
	ld		bc, $05DC		  ;demo timer
	call	LABEL_2530
	call	LABEL_2576
	ld		hl, $D292
	res		7, (hl)
	ld		hl, $0000
	ld		(ControlByte), hl
	xor		a
	ld		(GameState), a
	ld		(CurrentLevel), a
	ld		(CurrentAct), a
	ld		hl, $D292
	bit		7, (hl)
	jr		z, +

	ld		hl, $D292
	res		7, (hl)
	res		3, (hl)
	set		4, (hl)
	jp		ChangeGameMode

+:  ld   hl, $D292
	res		7, (hl)
	res		3, (hl)
	set		6, (hl)
	jp		ChangeGameMode

LABEL_24BE_48:
	ld		a, ($D12C)		  ;check for level select cheat
	cp		$0D
	jr		nz, +
	xor		a
	ld		($D294), a
	call	LevelSelectMenu	 ;run the level select
	call	PaletteFadeOut
	ld		b, $2A
-:  ei
	halt
	djnz	-
+:  xor	 a
	ld		($D292), a
	ld		(GameState), a
	ret

DemoSequence_ChangeLevel:
;LABEL_24DD_53:
	ld		a, (DemoNumber)
	inc		a
	and		$07
	ld		(DemoNumber), a
	add		a, a
	add		a, a
	ld		l, a
	ld		h, $00
	ld		de, LevelDemoHeaders
	add		hl, de
	ld		a, (hl)
	ld		(CurrentLevel), a	  ;which level is the demo for?
	inc		hl
	ld		a, (hl)
	ld		(DemoBank), a		  ;which bank is the control sequence in?
	inc		hl
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	ld		(NextControlByte), de  ;where is the control sequence?
	xor		a
	ld		(CurrentAct), a		;default to the first act...
	ld		a, (CurrentLevel)
	cp		$01
	ret		nz
	ld		a, $01				 ;...except for SHZ when we should use act 2
	ld		(CurrentAct), a
	ret

LevelDemoHeaders:
;	 Level
;	  |   Bank
;	  |	|  Control sequence pointer
;   |----|----|--------|
;.db $01, $1D, $00, $90 ;SHZ demo

;SHZ demo
.db $01
.db :DemoControlSequence_SHZ
.dw DemoControlSequence_SHZ

;GHZ demo
.db $03
.db :DemoControlSequence_GHZ
.dw DemoControlSequence_GHZ

;ALZ demo
.db $02
.db :DemoControlSequence_ALZ
.dw DemoControlSequence_ALZ

;SEZ demo
.db $05
.db :DemoControlSequence_SEZ
.dw DemoControlSequence_SEZ

;SHZ demo
.db $01
.db :DemoControlSequence_SHZ
.dw DemoControlSequence_SHZ

;GHZ demo
.db $03
.db :DemoControlSequence_GHZ
.dw DemoControlSequence_GHZ

;ALZ demo
.db $02
.db :DemoControlSequence_ALZ
.dw DemoControlSequence_ALZ

;SEZ demo
.db $05
.db :DemoControlSequence_SEZ
.dw DemoControlSequence_SEZ


LABEL_2530:
	push	bc
	call	WaitForInterrupt
	call	Engine_UpdateLevelState
	pop		bc
	ld		a, ($D292)
	bit		7, a
	ret		nz
	ld		a, (GameState)
	cp		$40
	ret		nz
	dec		bc			  ;decrement the demo timer
	ld		a, b
	or		c
	jr		nz, LABEL_2530
	ret

DemoSequence_LoadLevel:	 ;254A
	di
	ld		hl, GameState
	set		2, (hl)	 ;set "title card" flag
	call	Engine_ClearScreen
	call	TitleCard_LoadAndDraw
	call	ScrollingText_UpdateSprites
	call	PaletteFadeOut
	ld		b, $2A	  ;pause to load the level
-:  ei
	halt
	djnz	-
	call	Engine_LoadLevel		  ;load the level
	call	LoadLevelPalette
	call	Engine_ReleaseCamera			;unlocks camera
	ld		a, $20
	ld		(RingCounter), a	;start level with 32 rings
	ld		hl, GameState
	res		2, (hl)			 ;reset "title card" flag
	ret
	
LABEL_2576:
	call	WaitForInterrupt
	call	Engine_UpdatePlayerObjectState
	ld		a, ($D501)
	cp		PlayerState_LostLife
	jr		nz, +
	ld		a, ($D51D)
	cp		$02
	jr		nz, LABEL_2576
+:  ld	  a, $00		  ;stop music
	ld		($DD04), a
	call	LABEL_7D32
	call	PaletteFadeOut
	ld		b, $3C
-:  ei
	halt
	djnz	-
	ret
	

LABEL_259C:
	ei
	halt
	push	hl
	pop		hl
	ld		a, ($D292)
	bit		7, a
	ret		nz
	dec		hl
	ld		a, h
	or		l
	ret		z
	jr		LABEL_259C	 ;$F0

CapLifeCounterValue:	
LABEL_25AC:
	ld		a, ($D292)
	or		a
	ret		nz
	ld		a, (LifeCounter)
	cp		$09				;cap the life display at 9
	jr		c, +
	ld		a, $09
+:  rlca
	and		$1E
	add		a, $10
	ld		($DBA9), a
	ret
	
IncrementRingCounter:
LABEL_25C3:
	ld		a, (RingCounter)
	add		a, $01
	daa
	ld		(RingCounter), a
	;check for 100 rings
	or		a
	jr		nz, Engine_UpdateRingCounterSprites
	;we have 100 rings; increment life counter
	ld		hl, LifeCounter
	inc		(hl)
	call	CapLifeCounterValue
	ld		a, SFX_ExtraLife
	ld		($DD04), a


Engine_UpdateRingCounterSprites:	;$25DB
	ld		a, ($D292)
	or		a
	ret		nz

	ld		a, (CurrentLevel)
	cp		$06				;check for crystal egg act 2
	jr		nz, +
	ld		a, (CurrentAct)
	cp		$02
	ret		z

+:  ld   a, (RingCounter)   ;calculate the sprite for the
	rrca	;first BCD digit
	rrca
	rrca
	and		$1E
	add		a, $10
	ld		($DBB1), a

	ld		a, (RingCounter)   ;calculate the sprite for the
	rlca	;second BCD digit
	and		$1E
	add		a, $10
	ld		($DBB3), a
	ret


TitleCard_LoadAndDraw:
LABEL_2606:
	di
	call	Engine_ClearLevelAttributes	
	ld		de, $1170	  ;copy $1170 to the name table
	ld		hl, ScreenMap
	ld		bc, $0380
	call	VDP_WriteToVRAM
	call	TitleCard_LoadTiles
;FIXME: potential optimisations here.
	ld		a, (GameState)
	bit		2, a
	jr		z, +
	ld		a, Music_TitleCard	 ;play title card music
	ld		($DD04), a
+:  ei
	ld		hl, BgPaletteControl   ;trigger bg palette fade to colour.
	ld		(hl), $00
	set		7, (hl)
	inc		hl
	ld		(hl), $03
	ld		a, (CurrentLevel)
	add		a, $1D
	ld		hl, FgPaletteControl   ;trigger fg palette fade to colour.
	ld		(hl), $00
	set		7, (hl)
	inc		hl
	ld		(hl), a
	ld		b, $0C
-:  ei
	halt
	djnz	-
	call	TitleCard_LoadText
	call	TitleCard_LoadActLogoMappings
	call	TitleCard_LoadZoneText
	ret

;****************************************
;* Loads the mappings for the zone name *
;* into VRAM							*
;****************************************
TitleCard_LoadText:
LABEL_264E:
	ld		hl, $0038
	ld		($D110), hl
	ld		bc, $0101		  ;load 1 row + 1 col to start with
	ld		($D118), bc
	ld		a, (CurrentLevel)
	add		a, a
	ld		l, a
	ld		h, $00
	ld		de, TitleCard_Mappings	 ;pointers to title card mappings
	add		hl, de
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	ld		hl, $0038
	add		hl, de
	ex		de, hl
	ld		a, (GameState)
	bit		2, a
	jr		nz, +
	ld		de, DATA_2D0C
+:  ld   ($D11A), de
	ld		hl, $3900
	ld		($D11C), hl
	ld		b, $1C
	call	TitleCard_ScrollTextFromLeft
	ret

;****************************************
;* Loads the mappings for the act logo  *
;* into VRAM							*
;****************************************
TitleCard_LoadActLogoMappings:  ;$2688
	ld		hl, $001C
	ld		($D110), hl
	ld		bc, $0101
	ld		($D118), bc		;rows/cols
	ld		a, (CurrentAct)	;which logo do we need?
	add		a, a
	ld		l, a
	ld		h, $00
	ld		de, DATA_28FE		  ;calculate the offset to the pointer
	add		hl, de
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	ld		($D11A), de		;source address
	ld		hl, $39FE		  ;VRAM destination
	ld		($D11C), hl
	ld		b, $0E			 ;count
	call	TitleCard_ScrollActLogo
	ret

;****************************************
;* Loads the mappings for the "Zone"	*
;* text into VRAM					   *
;****************************************
TitleCard_LoadZoneText:		 ;$26B3
	ld		hl, $0028
	ld		($D110), hl
	ld		bc, $0101
	ld		de, DATA_299C	  ;"Zone" text mappings
	ld		a, (GameState)
	bit		5, a
	jr		nz, $04
	bit		4, a
	jr		z, $03
	ld		de, DATA_2D6C
	ld		hl, $39C0
	ld		($D118), bc	;rows/cols
	ld		($D11A), de	;pointer to mappings
	ld		($D11C), hl	;VRAM address
	ld		b, $14
	call	TitleCard_ScrollTextFromLeft
	ret

TitleCard_ScrollTextFromLeft:	   ;$26E1
	push	bc
	ei
	halt
	ld		bc, ($D118)	;rows/cols
	ld		de, ($D11A)	;pointer to mappigns
	ld		hl, ($D11C)	;VRAM address
	call	Engine_LoadCardMappings
	ld		bc, ($D118)
	ld		de, ($D11A)
	ld		hl, ($D110)
	add		hl, de
	ex		de, hl
	push	de
	ld		hl, ($D11C)
	ld		de, $0040
	add		hl, de
	pop		de
	call	Engine_LoadCardMappings
	ld		bc, ($D118)
	inc		c
	ld		($D118), bc
	ld		de, ($D11A)
	dec		de
	dec		de
	ld		($D11A), de
	pop		bc
	djnz	TitleCard_ScrollTextFromLeft
	ret

TitleCard_ScrollActLogo:		;$2722
	push	bc
	ei
	halt
	ld		bc, ($D118)
	ld		de, ($D11A)
	ld		hl, ($D11C)
	call	Engine_LoadCardMappings
	ld		bc, ($D118)
	ld		hl, ($D11A)
	ld		de, ($D110)
	add		hl, de
	ex		de, hl
	push	de
	ld		hl, ($D11C)
	ld		de, $0040
	add		hl, de
	pop		de
	call	Engine_LoadCardMappings
	ld		bc, ($D118)
	ld		hl, ($D11A)
	ld		de, ($D110)
	add		hl, de
	add		hl, de
	ex		de, hl
	push	de
	ld		hl, ($D11C)
	ld		de, $0080
	add		hl, de
	pop		de
	call	Engine_LoadCardMappings
	ld		bc, ($D118)
	ld		hl, ($D11A)
	ld		de, ($D110)
	add		hl, de
	add		hl, de
	add		hl, de
	ex		de, hl
	push	de
	ld		hl, ($D11C)
	ld		de, $00C0
	add		hl, de
	pop		de 
	call	Engine_LoadCardMappings
	ld		bc, ($D118)
	ld		hl, ($D11A)
	ld		de, ($D110)
	add		hl, de
	add		hl, de
	add		hl, de
	add		hl, de
	ex		de, hl
	push	de
	ld		hl, ($D11C)
	ld		de, $0100
	add		hl, de
	pop		de
	call	Engine_LoadCardMappings
	ld		bc, ($D118)
	inc		c
	ld		($D118), bc
	ld		hl, ($D11C)
	dec		hl
	dec		hl
	ld		($D11C), hl
	pop		bc
	dec		b
	jp		nz, TitleCard_ScrollActLogo
	ret
	
GameOverScreen_DrawScreen:	  ;27B4
	di
	call	Engine_ClearLevelAttributes			;clear data from $D15E->$D290 (level header?)
	ld		de, $1107		  ;clear the screen
	ld		hl, ScreenMap
	ld		bc, $0380
	call	VDP_WriteToVRAM
	call	GameOverScreen_LoadTiles	   ;load the "Game Over" text  
	ld		a, :Bank15	 
	call	Engine_SwapFrame2  ;FIXME: this is probably unnecessary since the call to GameOverScreen_LoadTiles pages this in anyway
	ld		hl, $3AD0
	ld		de, GameOverScreen_Data_TextMappings
	ld		bc, $0212
	call	Engine_LoadCardMappings
	ei
	ld		hl, BgPaletteControl   ;fade bg palette to colour
	ld		(hl), $00
	set		7, (hl)
	inc		hl
	ld		(hl), $03
	ld		hl, FgPaletteControl   ;fade sprite palette to colour
	ld		(hl), $00
	set		7, (hl)
	inc		hl
	ld		(hl), $1E
	ret

ContinueScreen_DrawScreen:	  ;27EE
	di
	call	Engine_ClearLevelAttributes			;clear data from $D15E->$D290 (level header?)
	ld		de, $010A		  ;clear the screen to blank tile $0A (offset from $2000 in VRAM)
	ld		hl, ScreenMap
	ld		bc, $0380
	call	VDP_WriteToVRAM
	call	ContinueScreen_LoadTiles
	call	ContinueScreen_LoadNumberTiles
	ld		a, :Bank15
	call	Engine_SwapFrame2
	ld		hl, $3A50
	ld		de, ContinueScreen_Data_TextMappings
	ld		bc, $0212
	call	Engine_LoadCardMappings
	ei
	ld		hl, BgPaletteControl   ;fade background palette to colour
	ld		(hl), $00
	set		7, (hl)
	inc		hl
	ld		(hl), $03
	ld		hl, FgPaletteControl   ;fade sprite palette to colour
	ld		(hl), $00
	set		7, (hl)
	inc		hl
	ld		(hl), $1E
	ret
	
ContinueScreen_LoadNumberMappings:	  ;282B
	di
	ld		a, $0F
	call	Engine_SwapFrame2
	ld		a, (ContinueScreen_Count)   ;calculate the offset to the mappings
	add		a, a
	add		a, a
	add		a, a
	ld		e, a
	ld		d, $00
	ld		hl, ContinueScreen_Data_NumberMappings
	add		hl, de
	ex		de, hl
	ld		hl, $3B5E			   ;load the mappings into VRAM
	ld		bc, $0202
	call	Engine_LoadCardMappings
	ret

	
LABEL_2849:	 ;TODO: unused?
	push	bc
	push	de
	push	hl
	ld		bc, $0001
	call	VDP_CopyToVRAM
	ei
	halt
	halt
	pop		hl
	inc		hl
	pop		de
	inc		de
	pop		bc
	djnz	LABEL_2849
	ret

ScrollingText_UpdateSprites:		;285D
	call	ScrollingText_LoadSATValues
-:  ld	  a, $FF		  ;flag for a SAT update
	ld		(SATUpdateRequired), a
	call	ScrollingText_UpdateWorkingSAT
	call	UpdateCyclingPalette_ScrollingText
	ei		
	halt
	ld		a, ($D147)	  ;check for a buttons 1/2
	and		$30
	ret		nz
	ld		hl, ($D3BA)	 ;timer?
	dec		hl
	ld		($D3BA), hl
	ld		a, h
	or		l			   ;is timer 0?
	jp		nz, -
	ret

ScrollingText_LoadSATValues:		;2880
	ld		hl, $0078
	ld		($D3BA), hl
	ld		hl, $DB00	   ;working copy of SAT VPos attributes
	ld		b, $08		  ;set vpos to $18 for 8 sprites
	ld		a, $18
-:  ld	  (hl), a
	inc		hl
	djnz	-
	ld		b, $08		  ;set vpos to $30 for 8 sprites
	ld		a, $30
-:  ld	  (hl), a
	inc		hl
	djnz	-
	ld		hl, $DB40	   ;working copy of SAT Hpos/char codes
	ld		de, ScrollingText_Data_CharCodes
	ld		b, $10		  ;update 16 sprites
-:  ld	  a, (de)		 ;copy char code to wokring copy of SAT
	ld		(hl), a
	inc		hl
	ld		a, $82		  ;set HPOS = $82
	dec		b
	bit		2, b
	jr		nz, +
	ld		a, $80		  ;set HPOS = $80
+:  inc	 b
	ld		(hl), a
	inc		hl			  ;next sprite
	inc		de			  ;next char code
	djnz	-
	ret

ScrollingText_Data_CharCodes:   ;$28B4
.db $D0, $20, $40, $D8, $40, $30, $20, $D8
.db $A0, $A8, $80, $70, $90, $A0, $60, $70


ScrollingText_UpdateWorkingSAT:
LABEL_28C4:
	ld		hl, $DB40	   ;HPOS/char
	ld		de, $DB00	   ;VPOS
	ld		b, $10		  ;update 16 sprite entries
-:  ld	  a, (hl)		 ;do we have a sprite here?
	or		a
	call	nz, ScrollingText_UpdateSprite
	inc		hl			  ;move to next HPOS/char
	inc		hl
	inc		de			  ;move to next VPOS
	djnz	-
	ret

ScrollingText_UpdateSprite: 
LABEL_28D7:
	inc		hl			  ;get the HPOS attribute
	ld		a, (hl)		 
	dec		hl			  
	dec		(hl)
	cp		$82			 ;sprite char $82?
	jr		nz, +
	dec		(hl)			;move the sprite left.
+:  ld	  a, (de)		 ;get the VPOS
	ld		c, $10
	cp		$18			 ;vpos == $18?
	jr		z, +
	ld		c, $50
+:  ld	  a, (hl)
	cp		c
	ret		nc
	ld		a, $D0		  ;SAT terminator marker byte
	ld		(hl), a
	ret

	

TitleCard_Mappings:	 ;28F0
.include "src\titlecard_mappings.asm"


Engine_UpdatePlayerObjectState:
LABEL_2FA8:
	ld		ix,  $D500
	ld		a, ($D500)
	or		a
	ret		z					;check that there is an object in this slot
	ld		a, ($D49F)
	or		a
	call	nz, LABEL_3823		;not zero = dead
	ld		a, :Logic_Sonic		;page in bank 31
	call	Engine_SwapFrame2
	call	LABEL_603F
	ld		a, :Logic_Sonic
	call	Engine_SwapFrame2
	call	LABEL_6139
	jp		LABEL_47C9	  ;check monitor collisions?


LABEL_2FCB:
	;check to see if we're on the intro screen
	ld		a, (CurrentLevel)
	cp		$09
	jp		z, +
	push	iy
	ld		(ix+$0A), $40
	ld		(ix+$0B), $00
	ld		(ix+$06), $10
	ld		(ix+$05), $08
	ld		hl, $0400
	ld		($D36D), hl
	call	LABEL_48C4
	res		4, (ix+$04)
	pop		iy
	inc		(ix+$02)
	ret		

+:  push	iy
	ld		(ix+$0A), $40
	ld		(ix+$0B), $00
	ld		(ix+$06), $10
	ld		(ix+$05), $04
	pop		iy
	ld		(ix+$02), $0f
	ret		

Player_SetState_Standing:
LABEL_3011:
	res		0, (ix+$03)
	res		1, (ix+$03)
	ld		(ix+$02), PlayerState_Standing
	ld		hl, $0000
	ld		(IdleTimer), hl
	ld		($D516), hl
	ld		hl, $0400
	ld		($D36D), hl
	call	LABEL_48C4
	jp		Player_CalculateBalance	 ;check to see if sonic is balancing on a ledge

Player_SetState_Walking:
LABEL_3032:
	res		0, (ix+$03)
	res		1, (ix+$03)
	res		6, (ix+$03)
	ld		(ix+$02), PlayerState_Walking
	ld		hl, $0400
	ld		($D36D), hl		 ;set maximum horizontal velocity
	call	LABEL_48C4
	call	CalculatePlayerDirection
	ld		a, $80
	ld		($D289), a
	ret		

Player_SetState_LookUp:
LABEL_3054:
	ld		hl, $0000
	ld		($D516), hl
	ld		(ix+$02), PlayerState_LookUp
	ret		

Player_SetState_Crouch:
LABEL_305F:
	ld		hl, $0000
	ld		($D516), hl
	res		1, (ix+$03)	 ;lose rings on collision with enemy
	res		6, (ix+$03)
	ld		(ix+$02), PlayerState_Crouch
	ret		

Player_SetState_Running:
LABEL_3072:
	res		0, (ix+$03)
	res		1, (ix+$03)	 ;lose rings on collision with enemy
	ld		(ix+$02), PlayerState_Running
	ret		

Player_SetState_SkidRight:
LABEL_307F:
	bit		0, (ix+$03)
	ret		nz
	ld		a, SFX_Skid	 ;play "skid" sound
	ld		($DD04), a
	res		1, (ix+$03)	 ;lose rings on collision with enemy
	ld		(ix+$02), PlayerState_SkiddingRight
	ret		

Player_SetState_SkidLeft
LABEL_3092:
	bit		0, (ix+$03)
	ret		nz
	ld		a, SFX_Skid	 ;play "skid" sound
	ld		($DD04), a
	res		1, (ix+$03)	 ;lose rings on collision with enemy
	ld		(ix+$02), PlayerState_SkiddingLeft
	ret		

Player_SetState_Roll:
LABEL_30A5:
	ld		a, (ix+$17)
	or		a
	jp		z, Player_SetState_Crouch
	ld		(ix+$02), PlayerState_Rolling
	ld		hl, $0600
	ld		($D36D), hl
	call	LABEL_48C4
	res		0, (ix+$03)
	set		1, (ix+$03)		 ;set flag to destroy enemies on collision
	ld		a, SFX_Roll		 ;play "roll" sound
	ld		($DD04), a
	ret		

Player_SetState_JumpFromRamp
LABEL_30C7:
	ld		(ix+$02), PlayerState_JumpFromRamp
	set		0, (ix+$03)
	set		1, (ix+$03)
	res		1, (ix+$22)
	ret		

Player_SetState_VerticalSpring: 
LABEL_30D8:
	bit		7, (ix+$19)
	ret		nz
	ld		(ix+$02), PlayerState_VerticalSpring
	ld		(ix+$18), l	 ;set Y-axis velocity to HL
	ld		(ix+$19), h 
	set		0, (ix+$03)
	res		1, (ix+$03)
	res		2, (ix+$03)
	res		1, (ix+$22)	 ;trigger the movement
	ld		a, SFX_Spring   ;play "spring bounce" sound
	ld		($dd04), a
	ret		

Player_SetState_DiagonalSpring:
LABEL_30FD:
	bit		7, (ix+$19)
	ret		nz
	ld		(ix+$02), PlayerState_DiagonalSpring	;set sprite animation ($D502)
	ld		(ix+$18), l	 ;set Y-axis velocity to HL
	ld		(ix+$19), h
	set		0, (ix+$03)	 ;flag movement on Y-axis
	set		1, (ix+$03)	 ;flag movement on X-axis
	res		1, (ix+$22)	 ;trigger the movement
	ret		

LABEL_3119:				 ; \;
	ld		(ix+$02), $09   ; |
	ld		(ix+$16), l	 ; |
	ld		(ix+$17), h	 ; |
	ld		($d36d), hl	 ; |
	res		0, (ix+$03)	 ; |	 Identical to subroutine below
	set		1, (ix+$03)	 ; |
	res		1, (ix+$22)	 ; |
	ld		a, $9c		  ; |
	ld		($dd04), a	  ; |
	ret		; /

Player_SetState_HorizontalSpring:
LABEL_3138:
	ld		(ix+$02), PlayerState_Rolling   ;set sprite animation
	ld		(ix+$16), l	 ;set the X-axis speed to HL
	ld		(ix+$17), h
	ld		($D36D), hl
	res		0, (ix+$03)	 ;flag no movement on the Y-axis
	set		1, (ix+$03)	 ;flag movement on X-axis
	res		1, (ix+$22)	 ;trigger movement update
	ld		a, SFX_Spring   ;play spring bounce sound
	ld		($DD04), a
	ret		

Player_SetState_Falling:		;$3157
	ld		a, (ix+$01)
	cp		PlayerState_Jumping
	ret		z
	ld		(ix+$02), PlayerState_Falling
	ld		(ix+$18), $00   ;vertical velocity
	ld		(ix+$19), $01
	set		0, (ix+$03)	 ;set player in air
	res		1, (ix+$03)	 ;lose rings on collision with badnik
	res		1, (ix+$22)
	ret		

LABEL_3176:
	ld		(ix+$02), $1d
	ld		(ix+$18), $80
	ld		(ix+$19), $00
	set		0, (ix+$03)
	res		1, (ix+$03)
	res		1, (ix+$22)
	ret		

LABEL_318F:	 ;alz slippery slope logic
	ld		(ix+$02), PlayerState_ALZSlope  ;$1A
	res		0, (ix+$03)
	set		1, (ix+$22)
	ld		hl, $0400
	ld		($D36D), hl
	call	LABEL_48C4
	ld		a, $80			  ;reset camera offset
	ld		($D289), a
	ret		

CalculatePlayerDirection:	   ;31AA
	ld		a, ($D137)
	rlca
	rlca
	and		$30
	ret		z
	and		$10
	ld		b, a
	ld		a, (ix+$04)
	and		$EF
	or		b
	ld		(ix+$04), a
	ret

;******************************************************************
;* Handle a button press when the player is standing (not idle).  *
;******************************************************************
Player_HandleStanding:	  ;$31BF
LABEL_31BF:
	ld		a, $80
	ld		($D289), a
	call	LABEL_3A62				 ;Check for input?
	ld		a, ($D502)
	cp		PlayerState_Standing	   ;Compare to "standing" animation
	ret		nz				 
	ld		hl, (HorizontalVelocity)   ;Check to see if we should display the
	ld		a, h					   ;walking sprite
	or		l
	jp		nz, Player_SetState_Walking
	ld		hl, $D137
	ld		a, (hl)
	and		$0C						;check for left & right buttons
	jp		nz, Player_SetState_Walking			
	bit		0, (hl)					;check for up button
	jp		nz, Player_SetState_LookUp
	bit		1, (hl)					;check for down button
	jp		nz, Player_SetState_Crouch
	ld		hl, (IdleTimer)			;increment the wait timer
	inc		hl
	ld		(IdleTimer), hl
	ld		a, h
	cp		$02						;check for wait time >= 512 frames
	ret		c
	ld		(ix+$02), PlayerState_Idle ;change sprite to the "wait" animation
	ret

;*******************************************************************
;* Handle a button press when the player is balancing on a ledge.  *
;*******************************************************************
Player_HandleBalance:
LABEL_31F8:
	ld		a, $80			  ;reset the camera
	ld		($D289), a
	call	LABEL_3A62
	ld		a, ($D502)
	cp		PlayerState_Balance
	ret		nz
	ld		hl, (HorizontalVelocity)
	ld		a, h
	or		l
	jp		nz, Player_SetState_Walking
	ld		hl, $D137		   
	ld		a, (hl)
	and		$0C				 ;check for left/right buttons
	jp		nz, Player_SetState_Walking
	bit		0, (hl)			 ;check for up button
	jp		nz, Player_SetState_LookUp
	bit		1, (hl)			 ;check for down button
	jp		nz, Player_SetState_Crouch
	ret

;************************************************************
;* Handle a button press when the player is standing idle.  *
;************************************************************
Player_HandleIdle:
LABEL_3222:
	call	LABEL_3A62
	ld		a, ($D502)
	cp		PlayerState_Idle
	ret		nz
	ld		hl, $D137
	ld		a, (hl)
	and		$30				 ;check for button 1/2
	jp		nz, Player_SetState_Jumping
	ld		a, (hl)
	and		$0C				 ;check for left/right
	jp		nz, Player_SetState_Walking
	bit		0, (hl)			 ;check for up
	jp		nz, Player_SetState_LookUp
	bit		1, (hl)			 ;check for down
	jp		nz, Player_SetState_Crouch
	ret

;*********************************************************
;* Handle a button press when the player is looking up.  *
;*********************************************************
Player_HandleLookUp:		;$3245
LABEL_3245:
	ld		a, $B8
	ld		($D289), a
	call	LABEL_3A62
	ld		a, ($D502)
	cp		PlayerState_LookUp
	ret		nz
	ld		hl, $D137
	ld		a, (hl)
	and		$0C				 ;check for left/right buttons
	jp		nz, Player_SetState_Walking
	bit		1, (hl)
	jp		nz, Player_SetState_Crouch
	bit		0, (hl)
	jp		z, Player_SetState_Standing
	ret		

;*******************************************************
;* Handle a button press when the player is crouched.  *
;*******************************************************
Player_HandleCrouched:
LABEL_3267:
	ld		a, $30
	ld		($D289), a
	call	LABEL_3A62
	ld		a, ($D502)
	cp		PlayerState_Crouch
	ret		nz
	ld		hl, $D137
	bit		0, (hl)			 ;check for up button
	jp		nz, Player_SetState_LookUp
	bit		1, (hl)			 ;check for down button
	jp		z, Player_SetState_Standing
	ret		

;******************************************************
;* Handle a button press when the player is walking.  *
;******************************************************
Player_HandleWalk:
LABEL_3283:
	ld		a, $80				  ;reset the camera offset when we start
	ld		($D289), a	  ;to move.
	call	LABEL_3A62
	ld		a, (ix+$02)		 ;$D502
	cp		PlayerState_Walking
	ret		nz
	call	CalculatePlayerDirection	;which direction are we facing?
	call	LABEL_3676				  ;check for collisions with loops?
	ld		a, (ix+$17)				 ;increase horizontal velocity
	inc		a
	cp		$02
	jr		c, +
	ld		hl, $D137
	bit		1, (hl)			 ;check for down button
	jp		nz, Player_SetState_Roll
+:  ld	  a, (PlayerUnderwater)
	or		a
	jr		nz, +
	ld		hl, (HorizontalVelocity)
	bit		7, h		;if HorizontalVelocity is negative we need to 
	jr		z, ++	   ;2's comp the value.
	dec		hl
	ld		a, h
	cpl		
	ld		h, a
	ld		a, l
	cpl		
	ld		l, a
++: ld	  a, ($D36E)
	cp		h
	jp		z, Player_SetState_Running
+:  call	LABEL_32C8
	jp		LABEL_3321

LABEL_32C8:
	ld		a, ($D137)
	and		$0C				 ;check for left/right buttons
	ret		nz
	ld		hl, (HorizontalVelocity)
	bit		7, h		;if the value in HL is negative we'll
	jr		z, +		;need to 2's comp the value.
	dec		hl
	ld		a, h
	cpl		
	ld		h, a
	ld		a, l
	cpl		
	ld		l, a
+:  ld	  a, l
	and		$E0
	or		h
	jp		z, Player_SetState_Standing
	ret		

LABEL_32E4:
	ld		hl, $D137
	ld		a, (HorizontalVelocity+1)
	bit		7, a			;check the direction we're moving in
	jr		nz, +		   ;jump if we're moving left
	bit		2, (hl)		 ;check for left button and skid if pressed
	jr		z, ++
	jp		Player_SetState_SkidRight
+:  bit	 3, (hl)		 ;check for right button and skid if pressed
	jr		z, ++
	jp		Player_SetState_SkidLeft
++: ld	  a, ($D363)	  ;velocity adjustment?
	or		a
	jr		nz, +
	ld		hl, (HorizontalVelocity)
	bit		7, h			;check which direction we're moving
	jr		z, ++
	dec		hl			  ;2's comp. the value
	ld		a, h
	cpl		
	ld		h, a
	ld		a, l
	cpl		
	ld		l, a
++: ld	  a, l
	and		$F0
	or		h
	ret		nz
	ld		a, ($D137)	  ;if we get here the player is standing still
	bit		1, a			;check the down button
	jp		nz, Player_SetState_Crouch  ;crouch...
	jp		Player_SetState_Standing		;...or stand
+:  ret	 

LABEL_3321:
	ld		hl, $D137
	ld		a, (HorizontalVelocity+1)
	or		a	   ;check the hi-byte of the HorizontalVelocity
	ret		z	   ;word for 0.
	inc		a
	ret		z
	bit		7, (ix+$17)	 ;check which direction we're moving in
	jr		nz, LABEL_3337  ;jump if travelling left
	bit		2, (hl)		 ;travelling right - check left button
	jp		nz, Player_SetState_SkidRight
	ret		
LABEL_3337:
	bit		3, (hl)		 ;travelling left - check right button
	jp		nz, Player_SetState_SkidLeft
	ret		

;******************************************************
;* Handle a button press when the player is running.  *
;******************************************************
Player_HandleRunning:	   ;$333D
LABEL_333D:
	call	LABEL_3A62
	ld		a, ($D502)
	cp		PlayerState_Running
	ret		nz
	call	LABEL_3676
	ld		hl, $D137
	bit		1, (hl)
	jp		nz, Player_SetState_Roll
	ld		a, (HorizontalVelocity+1)
	bit		7, a
	jr		z, $02
	neg		
	cp		$04
	jp		c, Player_SetState_Walking
	jp		LABEL_3321

;********************************************************************
;* Handle a button press when the player is skidding to the right.  *
;********************************************************************
Player_HandleSkidRight:
LABEL_3362:
	call	LABEL_3A62
	ld		a, ($D502)
	cp		PlayerState_SkiddingRight
	ret		nz
	call	LABEL_32C8
	call	CalculatePlayerDirection
	ld		a, (HorizontalVelocity+1)
	and		$80
	ld		b, a
	ld		a, ($D137)
	rrca	
	rrca	
	rrca	
	rrca	
	and		$80
	xor		b
	ret		z
	jp		Player_SetState_Walking

;********************************************************************
;* Handle a button press when the player is skidding to the left.  *
;********************************************************************
Player_HandleSkidLeft:
LABEL_3385:
	call	LABEL_3A62
	ld		a, ($D502)
	cp		PlayerState_SkiddingLeft
	ret		nz
	call	LABEL_32C8
	call	CalculatePlayerDirection
	ld		a, (HorizontalVelocity+1)
	and		$80
	ld		b, a
	ld		a, ($D137)	  ;
	rlca	
	rlca	
	rlca	
	rlca	
	and		$80
	xor		b
	ret		z
	jp		Player_SetState_Walking

Player_HandleRolling:	   ;$33A8
LABEL_33A8:
	call	LABEL_3A62
	ld		a, ($D502)
	cp		PlayerState_Rolling
	ret		nz
	call	LABEL_3676
	jp		LABEL_32E4

LABEL_33B7:
	call	LABEL_3A62
	ld		a, ($D502)
	cp		PlayerState_JumpFromRamp
	ret		nz
	bit		1, (ix+$23)
	ret		z
	res		0, (ix+$03)
	call	LABEL_3676
	ld		a, ($D147)
	and		$30
	jp		nz, LABEL_3A8C
	ld		hl, ($D516)
	bit		7, h
	jr		z, $07
	dec		hl
	ld		a, h
	cpl		
	ld		h, a
	ld		a, l
	cpl		
	ld		l, a
	ld		a, l
	and		$C0
	or		h
	jp		z, Player_SetState_Standing
	ret		

Player_HandleJumping:
LABEL_33EA:
	ld		hl, $D3AA	   ;increase D3AA as long as button 1/2 is held.
	ld		a, ($D137)
	and		$30
	jr		nz, +
	ld		(hl), $20
	jr		++
+:  inc	 (hl)
	ld		a, (hl)
	cp		$0E
	jr		nc, ++
	ld		hl, $FBC0
	ld		a, (PlayerUnderwater)
	or		a
	jr		z, +
	ld		hl, $FCC0
+:  ld	  ($D518), hl
++: call	LABEL_3A62
	ld		a, ($D502)
	cp		PlayerState_Jumping
	ret		nz
	bit		1, (ix+$23)
	ret		z
	ld		a, ($D366)
	cp		$8D
	jp		nz, Player_SetState_Walking
	ret		

Player_HandleVerticalSpring:		;$3424
LABEL_3424:
	call	LABEL_3A62
	ld		a, ($D502)
	cp		PlayerState_VerticalSpring
	ret		nz
	bit		1, (ix+$23)		 ;check to see if we're standing on something
	jp		nz, Player_SetState_Walking
	bit		7, (ix+$19)		 ;check sign bit of vertical velocity
	jp		z, Player_SetState_Falling
	jp		CalculatePlayerDirection

Player_HandleDiagonalSpring:
LABEL_343E:
	call	LABEL_3A62
	ld		a, ($D502)
	cp		PlayerState_DiagonalSpring
	ret		nz
	bit		1, (ix+$23)		 ;check to see if we're standing on something
	jp		nz, Player_SetState_Walking
	bit		7, (ix+$19)		 ;check sign bit of vertical velocity
	jp		z, Player_SetState_Falling  
	ret		

Player_HandleFalling:	   ;$3456
LABEL_3456:
	call	LABEL_3A62
	ld		a, ($D502)
	cp		PlayerState_Falling
	ret		nz
	bit		1, (ix+$23)
	jp		nz, Player_SetState_Walking
	ret

LABEL_3467:
.IFEQ Version 2.2
	res		7, (ix+$04)
	ld		hl, $FF00
.ELSE
	ld		hl, $FF40	;set HorizontalVelocity
.ENDIF
	ld		(ix+$16), l
	ld		(ix+$17), h
	call	LABEL_3A62
	bit		1, (ix+$23)	 ;check to see if we're standing on something
	ret		z

.IFEQ Version 1.0
	ld		hl, $FF00
	ld		(ix+$16), l	 ;set HorizontalVelocity
	ld		(ix+$17), h
	jp		Player_SetState_Walking
	
.ELSE
	jp		Player_SetState_Walking
	
.ENDIF
	

LABEL_3484:
	call	LABEL_3A62
	bit		1, (ix+$23)	 ;check to see if we're standing on something
	jp		nz, Player_SetState_Walking
	ret		

LABEL_348F:
	res		7, (ix+$04)
	call	LABEL_7378
	call	LABEL_6938
	call	CalculatePlayerDirection
	call	LABEL_376E
	xor		a
	ld		($d469), a
	ret		


;Reset the air timer. Called after a collision with an air bubble.
LABEL_34A4:
	xor		a
	ld		($D469), a
	ret

LABEL_34A9:
	ld		b, $04
	ld		a, ($d365)
	cp		$07
	jr		c, +
	ld		b, $08
	cp		$10
	jr		c, ++
	cp		$17
	jr		nc, ++
+:  ld	  a, b
	ld		($D137), a
	xor		a
	ld		($D147), a
	call	CalculatePlayerDirection
++: call	LABEL_3A62
	ld		a, ($D366)
	cp		$00
	jp		z, Player_SetState_Falling
	ld		a, ($D363)
	or		a
	jp		z, Player_SetState_Walking
	ret		

LABEL_34DA:
	res		7, (ix+$04)
	jp		Object_UpdateVerticalVelocity
	
LABEL_34E1:
	res		7, (ix+$04)
	ld		hl, $0080
	ld		a, ($D51C)
	cp		$D8
	jr		c, $08
	ld		hl, GameState
	set		3, (hl)
	ld		hl, $1000
	ld		(VerticalVelocity), hl
	jp		Object_UpdateVerticalVelocity

LABEL_34FD:
	ld		a, (CurrentLevel)
	cp		$04
	jr		nz, $06
	ld		a, (CurrentAct)
	or		a
	jr		z, $59
	xor		a
	ld		(ix+$18), a
	ld		(ix+$19), a
	res		4, (ix+$04)
	ld		de, ($D174)	 ;horizontal screen offset in level
	ld		l, (ix+$11)	 ;horizontal object offset in level
	ld		h, (ix+$12)
	xor		a
	sbc		hl, de
	ld		de, $0120
	xor		a
	sbc		hl, de
	jr		c, $1A 

LABEL_352A:
	xor		a
	ld		(ix+$16), a
	ld		(ix+$17), a
	ld		a, (CurrentAct)
	cp		$02
	jr		nc, LABEL_353E
	ld		hl, GameState
	set		5, (hl)
	ret		

LABEL_353E:
	ld		hl, GameState
	set		4, (hl)
	ret		

LABEL_3544:
	ld		hl, (HorizontalVelocity)
	bit		7, h
	jr		z, $06
	ld		hl, $0000
	ld		(HorizontalVelocity), hl
	ld		a, h
	cp		$06
	jr		nc, +
	ld		de, $0010
	add		hl, de
	ld		(ix+$16), l
	ld		(ix+$17), h
+:  jp	  Engine_UpdateObjectPosition
	
LABEL_3563:
	xor		a
	ld		(ix+$18), a
	ld		(ix+$19), a
	set		4, (ix+$04)
	ld		hl, ($D174)
	ld		e, (ix+$11)
	ld		d, (ix+$12)
	xor		a
	sbc		hl, de
	jr		c, LABEL_357F
	jp		LABEL_352A

LABEL_357F:
	ld		hl, ($D516)
	bit		7, h
	jr		nz, $06
	ld		hl, $FFC0
	ld		($D516), hl
	ld		a, h
	cp		$FB
	jr		c, +
	ld		de, $FFF0
	add		hl, de
	ld		($D516), hl
+:  jp	  Engine_UpdateObjectPosition
	
;********************************
;*  Loads loop motion data.	 *
;********************************
LABEL_359B:
	ld		a, :Bank09
	call	Engine_SwapFrame2
	ld		l, (ix+$16)	 ;get horizontal velocity
	ld		h, (ix+$17)
	ld		de, ($D399)
	ld		a, ($D39B)
	add		hl, de
	jr		nc, +
	inc		a
	
+:  ld	  ($D399), hl
	ld		($D39B), a
	ld		hl, ($D39A)
	add		hl, hl
	ld		de, LoopMotionData  ;loop motion data?
	add		hl, de
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	
	ld		l, (ix+$3C)
	ld		h, (ix+$3D)
	add		hl, de
	ld		(ix+$14), l	 ;set vertical pos
	ld		(ix+$15), h
	ld		hl, ($D39A)
	add		hl, hl
	ld		de, $887D
	add		hl, de
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	ld		l, (ix+$3A)
	ld		h, (ix+$3B)
	add		hl, de
	ld		(ix+$11), l	 ;set horizontal pos
	ld		(ix+$12), h
	ld		hl, ($D39A)
	xor		a
	ld		de, $00b0
	sbc		hl, de
	jr		nc, $16
	ld		l, (ix+$16)	 ;get horizontal speed
	ld		h, (ix+$17)
	ld		de, $0007
	xor		a
	sbc		hl, de
	jr		c, $38
	ld		(ix+$16), l	 ;set horizontal speed
	ld		(ix+$17), h
	jr		$10
	ld		l, (ix+$16)
	ld		h, (ix+$17)
	ld		de, $000c
	add		hl, de
	ld		(ix+$16), l
	ld		(ix+$17), h
	ld		hl, ($D39A)
	ld		de, $0230
	xor		a
	sbc		hl, de
	ret		c
	ld		(ix+$02), $06
	ld		hl, ($D36D)
	ld		(ix+$16), l
	ld		(ix+$17), h
	call	LABEL_3A62
	ld		a, $10
	ld		($D39C), a
	ret		

LABEL_3638: 
	ld		l, (ix+$3a)
	ld		h, (ix+$3b)
	ld		e, (ix+$11)
	ld		d, (ix+$12)
	xor		a
	sbc		hl, de
	jr		c, $13
	ld		l, (ix+$11)
	ld		h, (ix+$12)
	ld		de, $0008
	add		hl, de
	ld		(ix+$11), l
	ld		(ix+$12), h
	jp		LABEL_3176

LABEL_365C:
	ld		l, (ix+$11)
	ld		h, (ix+$12)
	ld		de, $FFFE
	add		hl, de
	ld		(ix+$11), l
	ld		(ix+$12), h
	jp		LABEL_3176



;Called when player is at bottom of loop, moving 
;backwards
Player_SetState_MoveBack:   ;$366F	  
	ld		(ix+$02), PlayerState_Running
	jp		LABEL_3A62

LABEL_3676:
	ld		a, ($D39C)
	or		a
	jr		z, LABEL_3681
	dec		a
	ld		($D39C), a
	ret		

LABEL_3681:	 ;collide with ALZ-1 loop
	ld		a, (CurrentLevel)   ;check for ALZ
	cp		$02
	jr		nz, LABEL_36B2
	ld		a, (CurrentAct)	 ;check for ACT 1
	or		a
	ret		nz
	ld		hl, ($D511)	 ;horizontal pos in level
	ld		de, $075E
	xor		a
	sbc		hl, de
	ret		c
	ld		a, h
	or		a
	ret		nz
	ld		a, l
	and		$F8
	ret		nz
	ld		hl, ($D514)	 ;vertical pos in level
	ld		de, $0160
	xor		a
	sbc		hl, de
	ret		c
	ld		a, h
	or		a
	ret		nz
	ld		a, l
	and		$E0
	ret		nz
	jp		LABEL_3725

LABEL_36B2:	 ;collide with GHZ-1 loop
	ld		a, (CurrentLevel)   ;check for GHZ
	cp		$03
	ret		nz
	ld		a, (CurrentAct)	 ;check for ACT 1
	or		a
	jr		nz, LABEL_3703	  ;check for ACT 2
	ld		hl, ($D511)	 ;horizontal pos in level
	ld		de, $0D5E
	xor		a
	sbc		hl, de
	jr		c, LABEL_36E1
	ld		a, h
	or		a
	jr		nz, LABEL_36E1
	ld		a, l
	and		$F8
	jr		nz, LABEL_36E1
	ld		hl, ($D514)	 ;vertical pos in level
	ld		de, $0140
	xor		a
	sbc		hl, de
	jr		c, LABEL_36E1
	jp		LABEL_3725

LABEL_36E1:
	ld		hl, ($D511)	 ;horizontal pos in level
	ld		de, $0F3E
	xor		a
	sbc		hl, de
	jr		c, $17
	ld		a, h
	or		a
	jr		nz, $13
	ld		a, l
	and		$F8
	jr		nz, $0E
	ld		hl, ($D514)	 ;vertical pos in level
	ld		de, $0160
	xor		a
	sbc		hl, de
	jr		c, $03
	jp		LABEL_3725
	
LABEL_3702:
	ret		

LABEL_3703:
	ld		a, (CurrentAct)	 ;check for ACT 2
	dec		a
	ret		nz
	ld		hl, ($D511)	 ;horizontal pos in level
	ld		de, $0AFE
	xor		a
	sbc		hl, de
	ret		c
	ld		a, h
	or		a
	ret		nz
	ld		a, l
	and		$F8
	ret		nz
	ld		hl, ($D514)	 ;vertical pos in level
	ld		de, $0160
	xor		a
	sbc		hl, de
	ret		c
	jr		LABEL_3725			;FIXME: why bother?

;load loop motion data?
LABEL_3725:
	ld		a, (ix+$0A)
	cp		$80
	jr		nc, +
	ld		(ix+$02), PlayerState_OnLoop
	
	ld		l, (ix+$11)	 ;store copy of object h-pos
	ld		h, (ix+$12)
	ld		(ix+$3A), l
	ld		(ix+$3B), h
	
	ld		l, (ix+$14)	 ;store copy of object v-pos
	ld		h, (ix+$15)
	ld		de, $0000
	add		hl, de
	ld		(ix+$3C), l
	ld		(ix+$3D), h

	xor		a			   ;clear all loop variables
	ld		($D399), a
	ld		($D39A), a
	ld		($D39B), a
	pop		af
	ret		

+:  ld	  (ix+$02), $0D
	pop		af
	ret		


LABEL_375E:
	ret		

LABEL_375F:
	ld		hl, $0180
	ld		($D36D), hl
	ld		hl, $0008
	ld		($D36F), hl
	jp		Player_UpdateHorizontalVelocity

LABEL_376E:
	bit		7, (ix+$03)		 ;check to see if we need to flash the sprite
	jp		nz, FlashSprite
	ld		a, ($D532)		  ;check for invincibility power-up
	cp		$02
	jr		nz, +
	
	xor		a				   ;player is invincible
	ld		($D3A8), a
	ld		($D520), a
	ret		

	
+:  ld	  a, ($D3A8)
	or		a
	jp		z, LABEL_3796
	xor		a
	ld		($D3A8), a
	res		0, (ix+$23)
	jp		Player_SetState_Hurt

LABEL_3796:
	ld		a, ($D520)		  ;get the colliding object index
	or		a
	ret		z
	call	Engine_GetObjectDescriptorPointer
	ld		a, (hl)			 ;get the object type
	cp		Object_Glider
	jp		z, LABEL_38A8
	cp		Object_MineCart
	jp		z, LABEL_38A8
	bit		1, (ix+$03)
	jp		nz, LABEL_384E

Player_SetState_Hurt:	   ;$37B0
;LABEL_37B0:						;deals with "getting hurt"
	ld		a, (RingCounter)	;check for 0 rings
	or		a
	jp		z, LABEL_3823
	rrca	;calculate the number of rings to
	rrca	;drop based on the value of the 
	rrca	;high nibble of the ring counter.
	rrca	
	and		$0F
	inc		a	   
	cp		$08	 
	jr		c, +
	ld		a, $07  ;drop up to 7 rings
+:  ld	  b, a
	ld		c, Object_DroppedRing   
	ld		h, $00
-   push	bc
	call	Engine_AllocateObjectHighPriority
	pop		bc
	inc		h
	djnz	-
	
	set		7, (ix+$03)		 ;Flash player sprite on/off
	set		6, (ix+$03)
	ld		a, $78			  ;for $78 frames
	ld		($D3A9), a
	
	xor		a				   ;reset the ring counter
	ld		(RingCounter), a
	call	Engine_UpdateRingCounterSprites
	
	ld		a, SFX_LoseRings	;play the "Lose rings" sound effect
	ld		(NextMusicTrack), a
Player_PlayHurtAnimation:	   ;$37EA
	ld		(ix+$20), $00
	ld		(ix+$02), PlayerState_Hurt
	set		0, (ix+$03)
	res		2, (ix+$03)
	res		1, (ix+$22)
	ld		hl, $FC00	   ;make player sprite "bounce" out of the way
	bit		0, (ix+$22)
	jr		z, +
	ld		hl, $0000
+:  ld	  ($D518), hl	 ;move sprite up
	ld		hl, $0100
	bit		3, (ix+$23)
	jr		nz, +
	ld		hl, $FF00
+:  ld	  ($D516), hl	 ;move sprite back
	ld		hl, $0000
	ld		($D36F), hl
	ret		

LABEL_3823:
	ld		(ix+$02), PlayerState_LostLife
	set		0, (ix+$03)
	ld		(ix+$04), $00
	
	ld		hl, $FB00			   ;make the sprite bounce up first
	ld		(VerticalVelocity), hl
	
	ld		hl, $0000			   ;reset horizontal acceleration.
	ld		($D36F), hl
	
	res		1, (ix+$22)
	ld		hl, GameState
	set		3, (hl)
	xor		a
	ld		($D49F), a
	ld		a, Music_LoseLife	   ;play "Lost Life" sound
	ld		($DD04), a
	ret		

LABEL_384E:
	bit		4, (ix+$21)		 ;collision occurred at bottom of other object
	jr		nz, +
	bit		5, (ix+$21)		 ;collision occurred at top of other object
	jr		nz, ++
	
-:  xor	 a
	ld		($D520), a			  ;reset colliding object index
	ret

+:
.IFEQ Version 2.2
	ld		a, ($D501)
	cp		PlayerState_Rolling
	jr		z, -
.ENDIF
	set		0, (ix+$03)
	ld		hl, $0080			   ;make player rebound down
	ld		(VerticalVelocity), hl
	jr		-

++: set	 0, (ix+$03)
	res		1, (ix+$22)			 ;reset "bottom collision" in background flags
	ld		hl, $FD00			   ;make player rebound up
	ld		(VerticalVelocity), hl
	jr		-

FlashSprite:
LABEL_387B:
	ld		a, ($D3A9)
	or		a
	jr		z, ++	   ;if counter = 0 reset the sprite flags
	dec		a
	ld		($D3A9), a
	rrca
	rrca
	jr		c, +
-:  res	 7, (ix+$04)	 ;sprite = invisible
	ret

+:  set	 7, (ix+$04)	 ;sprite = visible
	ret		

++: res	 7, (ix+$04)
	res		7, (ix+$03)
	res		6, (ix+$03)
	xor		a
	ld		($D3A8), a
	ld		(ix+$20), a
	jr		-

LABEL_38A8:
	ld		(ix+$20), $00	   ;reset the colliding sprite index
	ret		


;************************************************************
;*  Calculates whether the player is balancing at the edge  *
;*  of a level block and, if so, which side.				*
;************************************************************
Player_CalculateBalance:		;$38AD
	ld		bc, $FFFC	   ;horizontal offset  (-4)
	ld		de, $0004	   ;vertical offset	(+4)	i.e. check bottom left of object
	call	Engine_GetCollisionDataForBlock	 ;collide with level tiles
	ld		a, ($D362)	  ;get vertical collision value

	ld		b, a
	push	bc

	ld		bc, $0004	   ;horizontal offset  (+4)
	ld		de, $0004	   ;vertical offset	(+4)	i.e. check bottom right of object
	call	Engine_GetCollisionDataForBlock	 ;collide with level tiles
	ld		a, ($D362)	  ;get vertical collision value

	pop		bc
	ld		c, a			;b = collision value at left, c = collision value at right

	sub		b			   ;compare left to right
	jr		nc, +		   ;jump if left value is less than right value
	neg

+:  cp	  $10
	ret		c
	ld		a, c			;restore right-edge collision value to A

	cp		b
	jr		z, Player_CalculateBalance_None	 ;jump if left == right
	jr		c, Player_CalculateBalance_Right	;jump if left > right

Player_CalculateBalance_Left:
	ld		(ix+$02), PlayerState_Balance
	set		4, (ix+$04)	 ;flag object balancing at left of block
	ret		

Player_CalculateBalance_Right:  ;$38E0
	ld		(ix+$02), PlayerState_Balance
	res		4, (ix+$04)	 ;flag object balancing at right of block
	ret		

Player_CalculateBalance_None:   ;$38E9
	ld		(ix+$02), PlayerState_Standing
	ret


;************************************************************
;*  Change the object's current animation based on its	  *
;*  horizontal velocity.									*
;************************************************************
Logic_ChangeFrameDisplayTime:	   ;$38EE
	ld		hl, $D52F	   ;increase $D52F and compare with 6
	inc		(hl)
	ld		a, (hl)
	cp		$06
	jr		c, +			;jump if $D52F < 6

	xor		a			   ;$D52F >= 6. Reset $D52F
	ld		(hl), a

+:  add	 a, $01		  ;FIXME: "inc a" faster?

	ld		(ix+$06), a	 ;set animation number (= $D52F + 1)
	ld		a, (HorizontalVelocity+1)   ;get hi-byte of current speed
	and		a
	jp		p, +			;jump if h-velocity is positive (moving right)
	neg

+:  ld	  l, a			;change frame dispaly time based on current speed
	ld		h, $00
	ld		de, DATA_3913
	add		hl, de
	ld		a, (hl)
	ld		(ix+$07), a	 ;set frame display time
	ret		

DATA_3913:  ;frame display times
.db $0A, $08, $06, $04, $04, $04, $04, $04 
.db $04, $04, $04, $04, $04, $04, $04, $04 



;************************************************************
;*  Calculates whether the player is balancing at the edge  *
;*  of an object and, if so, which side.					*
;************************************************************
Player_CalculateBalanceOnObject:		;$3923
	ld		hl, $D52F	   ;increase $D52F and compare to $14
	inc		(hl)
	ld		a, (hl)
	cp		$14
	jr		c, +			;jump if $D52F < $14

	xor		a			   ;reset $D52F to 0
	ld		(hl), a

+   ld	  c, a			;calculate index into array of animations
	ld		b, $00
	ld		hl, DATA_395C
	add		hl, bc

	ld		a, (hl)		 ;set current animation number
	ld		(ix+$06), a

	bit		1, (ix+$22)	 ;check for collision at bottom of object
	jr		z, Player_CalculateBalanceOnObject_UseInputFlags	;jump if no collision

	res		4, (ix+$04)	 ;flag object balancing at right edge

	ld		a, ($D517)	  ;get hi-byte of h-speed
	and		a
	jp		p, +			;jump if object moving right

	neg		
	set		4, (ix+$04)	 ;flag object balancing at left edge 

+:  ld	  l, a			;calculate index into array of frame display times
	ld		h, $00
	ld		de, DATA_3970
	add		hl, de

	ld		a, (hl)		 ;set frame display time
	ld		(ix+$07), a
	ret		

DATA_395C:	  ;animation numbers
.db $11, $12, $13, $14, $15, $12, $13, $14
.db $11, $15, $13, $14, $11, $12, $15, $14
.db $11, $12, $13, $15
	
DATA_3970:	  ;frame display times
.db $0A, $08, $06, $04, $04, $04, $04, $04
.db $04, $04, $04, $04, $04, $04, $04, $04

;check input flags to calculate balance position - used as a
;last resort if the collision flags can't be used
Player_CalculateBalanceOnObject_UseInputFlags:	  ;$3980
	ld		a, ($D137)	  ;get input flags
	bit		3, a			;is right-button pressed?
	jr		z, +			;jump if not pressed

	res		4, (ix+$04)	 ;flag player balancing at right-edge
	jr		++

+:  bit	 2, a			;is left-button pressed?
	jr		z, ++		   ;jump if not pressed

	set		4, (ix+$04)	 ;flag player balancing at left-edge

++: ld	  a, $03		  ;set frame display time = 3
	ld		(ix+$07), a
	ret		


;calculate the animation frame to display after the 
;player falls away from a loop
Player_CalculateLoopFallFrame:		;$399B
	ld		hl, ($D53C)		;get player's original vpos
	ld		de, ($D514)		;get player's current vpos
	
	xor		a
	sbc		hl, de			;use distance from original vpos
	srl		l				;to calculate the frame to display
	srl		l
	srl		l
	srl		l
	ld		h, $00
	add		hl, hl
	ld		de, Data_SonicLoopFallFrames
	add		hl, de
	ld		a, (hl)
	cp		(ix+$06)
	jr		nz, +
	
	inc		hl

+:	ld		a, (hl)
	ld		(ix+$06), a
	ld		(ix+$07), $06
	ret		

Data_SonicLoopFallFrames:		;$39C4
.db $01, $03, $01, $03, $1E, $1F, $1E, $1F
.db $21, $20, $22, $23, $24, $25, $27, $26
.db $28, $29, $2A, $2B, $2D, $2C, $2E, $2F
.db $30, $31, $33, $32, $34, $35, $36, $37
.db $39, $38, $3A, $3B


;calculate which animation frame to display
Player_CalculateLoopFrame:	  ;$39E8
	ld		hl, ($D39A)			;get player's position in loop
	ld		e, $1B				;divide by 27
	call	Engine_Divide_16_by_u8
	
	ld		h, $00				;calculate an index into the array
	add		hl, hl				;of loop animations
	ld		de, Data_SonicLoopAnimations
	add		hl, de

	ld		a, (hl)				;compare with current frame
	cp		(ix+$06)
	jr		nz, +

	inc		hl					;move to next frame

+:	ld		a, (hl)
	ld		(ix+$06), a			;set the current frame
	ld		(ix+$07), $06		;set frame display time
	ret		

Data_SonicLoopAnimations:	   ;$3A07
.db $1E, $1F, $1E, $1F, $21, $20, $22, $23
.db $24, $25, $27, $26, $28, $29, $2A, $2B
.db $2D, $2C, $2E, $2F, $30, $31, $33, $32
.db $34, $35, $36, $37, $39, $38, $3A, $3B
.db $01, $03, $01, $03, $01, $03, $01, $03
.db $01, $03, $01, $03, $01, $03, $01, $03
.db $01, $03, $01, $03


;********************************************************
;*  Calculates the position of an object within the	 *
;*  currently displayed screen.						 *
;********************************************************
Engine_GetObjectScreenPos:	  ;$3A3B
	ld		l, (ix+$11)		;sprite horiz. offset in level
	ld		h, (ix+$12)
	ld		de, ($D174)		;screen horiz. offset in level
	xor		a
	sbc		hl, de			 ;calculate sprite horiz. pos on screen.
	ld		(ix+$1A), l		;store horiz. pos
	ld		(ix+$1B), h
	ld		l, (ix+$14)		;sprite vert. offset in level
	ld		h, (ix+$15)
	ld		de, ($D176)		;screen vert. offset in level
	xor		a
	sbc		hl, de			 ;calculate sprite vert. pos on screen.
	ld		(ix+$1C), l		;store vert. pos
	ld		(ix+$1D), h
	ret


LABEL_3A62:
	ld		a, (CurrentLevel)
	cp		$02
	call	z, LABEL_4887   ;under water stuff
	call	LABEL_3BDD
	
	ld		a, (ix+$01)
	cp		PlayerState_Walking
	
	jr		nc, +		   ;dont adjust player speed if not 
							;already moving
	
	ld		hl, $0000
	ld		($D371), hl
	
+:  call	Player_UpdateHorizontalVelocity
	call	Object_UpdateVerticalVelocity

	call	LABEL_6BF2	  ;check collisions
	call	LABEL_376E

	ld		a, ($D147)
	and		$30			 ;check for either button 1 or button2
	ret		z

Player_SetState_Jumping:
LABEL_3A8C:
	ld		a, ($D501)
	cp		$1A
	ret		z
	bit		0, (ix+$03)
	ret		nz
	bit		2, (ix+$03)
	ret		nz
	xor		a
	ld		($D3AA),a   
	set		0, (ix+$03)		 ;set player in air
	set		1, (ix+$03)		 ;destroy enemies on collision
	ld		(ix+$02), PlayerState_Jumping	   ;play jump animation
	ld		hl, $FBC0
	ld		a, (PlayerUnderwater)
	or		a
	jr		z, +
	ld		hl, $FCC0
+:  ld	  (VerticalVelocity),hl
	ld		a, $80
	ld		($D289), a
	res		1, (ix+$22)
	ld		a, SFX_Jump		 ;play jump sound effect
	ld		($DD04), a
	ret		

;called when jumping & colliding with horizontal spring
LABEL_3ACA:
	set		0, (ix+$03)		 ;player rolling
	set		1, (ix+$03)		 ;destroy enemy on collision
	ld		(ix+$02), PlayerState_Jumping
	ld		hl, $0000
	ld		(VerticalVelocity), hl
	res		1, (ix+$22)
	ret		


;********************************************************
;*  Update the player's horizontal velocity by adding   *
;*  velocity delta & the gradient adjustment value.	 *
;********************************************************
Player_UpdateHorizontalVelocity:		;$3AE1
	ld		hl, (HorizontalVelocity)
	ld		de, ($D36F)
	add		hl, de			  ;add velocity delta to current speed
	ld		de, ($D371)
	add		hl, de			  ;add gradient adjustment to current speed
	bit		7, h
	jr		nz, +			   ;jump if object moving left
	
	;object moving right - check speed against maximum
	bit		2, (ix+$23)		 ;test for collision at right edge & stop if required
	jr		nz, Player_UpdateHorizontalVelocity_SetZero

	ld		(ix+$0A), $40
	ld		a, (MaxHorizontalVelocity+1)
	ld		b, a				;limit horizontal velocity to maximum
	ld		a, h
	cp		b
	jr		c, ++
	ld		hl, (MaxHorizontalVelocity)
	jr		++

	;object moving left - check speed against negated maximum
+:  bit	 3, (ix+$23)		 ;test for collision at left edge & stop if required
	jr		nz, Player_UpdateHorizontalVelocity_SetZero
	ld		(ix+$0A), $C0   
	ld		a, (MaxHorizontalVelocity+1)
	neg		
	ld		b, a
	ld		a, h
	cp		b
	jr		nc, ++
	ld		hl, (MaxHorizontalVelocity) ;limit horizontal velocity to minimum
	dec		hl				  ;2's comp the max velocity
	ld		a, h
	cpl		
	ld		h, a
	ld		a, l
	cpl		
	ld		l, a

++: ld	  (HorizontalVelocity), hl	;set the horiz. velocity
	ld		c, $00		  ;c = 0
	bit		7, h
	jr		z, +			;if player moving left
	dec		c			   ;   c = -1
+:  xor	 a
	ld		de, ($D510)	 ;adjust player hpos
	add		hl, de
	ld		($D510), hl
	ld		a, $00
	adc		a, c			;add carry to 3rd byte
	add		a, (ix+$12)
	ld		($D512), a
	ret		

Player_UpdateHorizontalVelocity_SetZero:		;$3B44
	ld		hl, $0000	   ;set speed & acceleration to 0
	ld		(HorizontalVelocity), hl
	ld		($D36F), hl
	ret		


Object_UpdateVerticalVelocity:
LABEL_3B4E:
	bit		0, (ix+$03)		 ;check to see if player is in air
	jr		nz, Object_CalcGravity	  ;player is in air - apply gravity
	ld		a, ($D3B9)
	or		a
	ret		nz
	ld		hl, (VerticalVelocity)
	ld		a, h
	and		a
	jp		p, Object_SetVerticalVelocity
	dec		hl
	ld		a, h
	cpl		
	ld		h, a
	ld		a, l
	cpl		
	ld		l, a
	jr		Object_SetVerticalVelocity


;********************************************************
;*  Calculates gravity based on the player's current	*
;*  state.											  *
;********************************************************
Object_CalcGravity:		 ;$3B6A
	ld		hl, (VerticalVelocity)
	ld		a, (PlayerUnderwater)		   ;check to see if player is underwater
	or		a
	jr		nz, Object_CalcGravity_Underwater
	ld		a, (ix+$01)
	ld		de, $0018					   ;deceleration from vertical spring
	cp		PlayerState_VerticalSpring
	jr		z, +
	ld		de, $0024					   ;deceleration from ramp jump
	cp		PlayerState_JumpFromRamp
	jr		z, +
	ld		de, $0030					   ;deceleration from normal jump
+:  add	 hl, de						  ;adjust the vertical velocity
	ld		a, h
	and		a
	jp		m, Object_SetVerticalVelocity   ;jump if resulting velocity is negative
	cp		$07
	jr		c, +
	ld		hl, $0700					   ;cap gravity at $700
+:  jr	  Object_SetVerticalVelocity


;********************************************************
;*  Calculates gravity for underwater sections based on *
;*  the player's current state.						 *
;********************************************************
Object_CalcGravity_Underwater:	  ;$3B96
	ld		a, (ix+$01)
	ld		de, $000C					   ;deceleration after collision with spring
	cp		PlayerState_VerticalSpring
	jr		z, +
	ld		de, $0012					   ;deceleration after ramp jump
	cp		PlayerState_JumpFromRamp
	jr		z, +
	ld		de, $0018					   ;deceleration for other conditions
+:  add	 hl, de						  ;adjust the vertical velocity
	ld		a, h
	and		a
	jp		m, Object_SetVerticalVelocity
	cp		$04
	jr		c, Object_SetVerticalVelocity
	ld		hl, $0400					   ;cap gravity at $400


Object_SetVerticalVelocity:		 ;$3BB7
	bit		1, (ix+$22)
	jr		z, +
	ld		hl, $0700
+:  ld	  (VerticalVelocity), hl
	ld		c, $00
	bit		7, h		;is velocity negative?
	jr		z, +
	dec		c
+:  xor	 a
	ld		de, ($D513)
	add		hl, de
	ld		($D513), hl
	ld		a, $00
	adc		a, c
	add		a, (ix+$15)
	ld		($D515), a
	ret		

LABEL_3BDD:
	ld		hl, ($D511)		 ;sprite horiz offset in level
	ld		de, ($D174)		 ;cam horiz offset in level
	xor		a
	sbc		hl, de			  ;calculate sprite offset on screen
	ld		a, l
	ld		bc, $0010		   ;check to see if sprite is at left-edge of level.
	cp		$10
	jp		c, Engine_LimitScreenPos_Left	   ;jump if A < $10
	ld		bc, $00F7		   ;check to see if sprite is at right-edge of level.
	cp		$F8
	jp		nc, Engine_LimitScreenPos_Right	 ;jump if A > $F8
	
	ld		a, (ix+$01)
	cp		PlayerState_Hurt
	ret		nc
	
	ld		a, (PlayerUnderwater)
	or		a
	jp		nz, LABEL_3C5F
	
	ld		a, (ix+$01)
	add		a, a
	add		a, a
	ld		l, a
	ld		h, $00
	ld		a, ($D137)
	and		$0C				 ;check for left/right buttons
	jp		z, LABEL_3CB8   
	ld		de, DATA_3D96
	bit		7, (ix+$17)		 ;is horizontal velocity negative?
	jr		nz, +
	ld		de, DATA_3D16
+:  ld	  bc, $0000
	bit		2, a
	jr		nz, LABEL_3C2B
	ld		bc, $0002

LABEL_3C2B:
	add		hl, bc		  ;calculate the pointer
	add		hl, de
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	ld		hl, (HorizontalVelocity)
	bit		7, h
	jr		z, +			;jump if player is moving right
	
	dec		hl			  ;player is moving left - 2's comp
	ld		a, h			;the horizontal velocity
	cpl		
	ld		h, a
	ld		a, l
	cpl		
	ld		l, a
	
+:  ld	  bc, $0080
	add		hl, bc		  ;add $80 to horizontal velocity
	
	ld		a, h
	or		a
	jr		nz, +		   ;jump if HL > $FF
	
	ex		de, hl		  ;de *= 2
	add		hl, hl
	ex		de, hl
	
+:  ld	  ($D36F), de	 ;set h-velocity delta
	ld		a, ($D363)	  ;speed modifier value from mapping block
	ld		l, a
	ld		h, $00
	ld		de, DATA_4016
	add		hl, de
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	ld		($D371), de
	ret		

LABEL_3C5F:
	ld		a, (ix+$01)		 ;get current animation (sprite type)
	add		a, a
	add		a, a
	ld		l, a
	ld		h, $00
	ld		a, ($D137)
	and		$0C				 ;check left/right buttons
	jr		z, LABEL_3CB8
	ld		de, DATA_3F16
	bit		7, (ix+$17)		 ;is horiz. velocity negative?
	jr		nz, +
	ld		de, DATA_3E96
+:  ld	  bc, $0000
	bit		2, a
	jr		nz, +
	ld		bc, $0002
+:  add	 hl, bc
	add		hl, de
	ld		e, (hl)
	inc		hl
	ld		d, (hl)

	ld		hl, ($D516)		 ;hl = HorizontalVelocity
	bit		7, h				;is horizontal velocity negative?
	jr		z, +
	dec		hl			  ;if hl is negative, 2's comp the value
	ld		a, h
	cpl		
	ld		h, a
	ld		a, l
	cpl		
	ld		l, a
+:  ld	  bc, $0080	   ;add 128 to hl
	add		hl, bc
	ld		a, h
	or		a
	jr		nz, +
	ex		de, hl
	add		hl, hl
	ex		de, hl
+:  ld	  ($D36F), de
	ld		a, ($D363)
	ld		l, a
	ld		h, $00
	ld		de, DATA_4016
	add		hl, de
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	ld		($D371), de
	ret		

LABEL_3CB8:
	ld		de, $0000
	ld		($D36F), de		 ;set horizontal speed delta to 0
	ld		a, (ix+$16)		 ;return if horiz speed == 0
	or		(ix+$17)
	ret		z
	ld		de, DATA_3E16
	ld		bc, $0000
	bit		7, (ix+$17)
	jp		nz, LABEL_3C2B	  ;jump if player moving left
	ld		bc, $0002
	jp		LABEL_3C2B

	
;FIXME: this subroutine is a duplicate. Replace with call to Engine_LimitScreenPos_Right.
Engine_LimitScreenPos_Left:	 ;$3CD9
	ld		hl, ($D174)		 ;horizontal cam offset in level
	add		hl, bc
	ld		($D511), hl
	xor		a
	ld		($D510), a
	jr		LABEL_3CF1

;****************************************************
;*  Limits the sprite's position on screen. Called  *
;*  when the sprite is at the horizontal extremes   *
;*  of the level.								   *
;****************************************************
Engine_LimitScreenPos_Right:	;$3CE6
	ld		hl, ($D174)		 ;horizontal cam offset
	add		hl, bc
	ld		($D511), hl
	xor		a
	ld		($D510), a

LABEL_3CF1:	 ;subtract velocity from hpos
	ld		hl, ($D510)
	ld		de, (HorizontalVelocity)
	ld		c, $00
	bit		7, d		;is horiz velocity negative?
	jr		z, +
	dec		c
+:  xor	 a
	sbc		hl, de
	ld		($D510), hl
	ld		a, (ix+$12)	 ;hi-byte of horizontal position
	sbc		a, c
	ld		(ix+$12), a
	ld		hl, $0000	   ;set velocity & delta-v to 0
	ld		($D36F), hl
	ld		(HorizontalVelocity), hl
	ret		


;Note that the data at $3F16 spans across into the next bank.
;This ORG directive keeps things aligned. It's hacky and probably
;should be changed.

.ORG $3D16

.IFEQ Version 2.2
.db $D5, $C9
.ENDIF

DATA_3D16:
.incbin "unknown\s2_3D16.bin"

DATA_3D96:
.incbin "unknown\s2_3D96.bin"

DATA_3E16:
.incbin "unknown\s2_3E16.bin"

DATA_3E96:
.incbin "unknown\s2_3E96.bin"

DATA_3F16:
.incbin "unknown\s2_3F16.bin"

.IFEQ Version 1.0
.db $00, $00
.ENDIF

.BANK 1 SLOT 1
.ORG $0000

.IFEQ Version 2.2
.db	$00, $00
.ENDIF

.db $00, $00, $05, $00, $FB, $FF, $00, $00 
.db $00, $00, $00, $00, $00, $00, $00, $00 
.db $00, $00, $00, $00, $00, $00

;h-speed adjustment values
DATA_4016:
.dw $0000
.dw $FFE1
.dw $001F
.dw $FFE8
.dw $0018
.dw $FFF0
.dw $0010

LABEL_4024:
	res		0, (ix+$03)
	set		2, (ix+$03)
	ld		(ix+$02), $11
	ld		hl, $0000
	ld		($d516), hl
	ret

LABEL_4037:
	res		0, (ix+$03)
	set		2, (ix+$03)
	ld		(ix+$02), $12
	ret

LABEL_4044:	 
	bit		1, (ix+$22)
	jr		nz, LABEL_404F
	ld		(ix+$02), $13
	ret

LABEL_404F:
	set		0, (ix+$03)
	ld		(ix+$02), $13
	ld		(ix+$18), $00
	ld		(ix+$19), $fe
	res		1, (ix+$22)
	ret

LABEL_4064:
	ld		(ix+$02), PlayerState_HangGliderBack
	ld		(ix+$18), $00
	ld		(ix+$19), $fe
	set		0, (ix+$03)
	res		1, (ix+$22)
	ret

LABEL_4079:
	ld		(ix+$02), PlayerState_HangGliderFwd
	ld		(ix+$18), $80
	ld		(ix+$19), $00
	set		0, (ix+$03)
	res		1, (ix+$22)
	ret

LABEL_408E:
	res		7, (ix+$04)
	call	LABEL_3A62
	ld		hl, ($D516)
	bit		7, h
	jr		z, +
	dec		hl
	ld		a, h
	cpl		
	ld		h, a
	ld		a, l
	cpl		
	ld		l, a
+:  ld	  a, l
	and		$F0
	or		h
	jp		nz, LABEL_4037
	bit		1, (ix+$22)
	jp		z, LABEL_4044
	ret

LABEL_40B2:
	res		7, (ix+$04)
	call	LABEL_3A62
	bit		1, (ix+$22)
	jp		z, LABEL_4044
	ld		hl, ($D516)
	bit		7, h
	jr		z, +
	dec		hl
	ld		a, h
	cpl		
	ld		h, a
	ld		a, l
	cpl		
	ld		l, a
+:  ld	  a, l
	and		$F0
	or		h
	jp		z, LABEL_4024
	ret

LABEL_40D6:
	res		7, (ix+$04)
	call	LABEL_4137
	call	LABEL_6BF2
LABEL_40E0:
	call	LABEL_376E
	bit		1, (ix+$22)
	jr		z, LABEL_40F0
	res		2, (ix+$03)
	jp		LABEL_3032

LABEL_40F0:
	ld		a, (ix+$22)
	and		$0F
	jr		nz, +
	call	LABEL_4109
	jr		c, +
	ld		a, ($D147)
	and		$30
	ret		z
+:  res	 2, (ix+$03)
	jp		Player_SetState_Falling

LABEL_4109:
	ld		de, ($D174)
	ld		hl, ($D511)
	xor		a
	sbc		hl, de
	jp		c, LABEL_4135
	
	ld		a, h
	or		a
	jp		nz, LABEL_4135
	
	ld		a, l
	cp		$F0
	jp		nc, LABEL_4135
	
.IFEQ Version 2.2
	ld		hl, ($D176)
	ld		de, $0020
	add		hl, de
	ld		de, ($D514)
	ex		de, hl
.ELSE
	ld		de, ($D176)
	ld		hl, ($D514)
.ENDIF
	xor		a
	sbc		hl, de
	
.IFEQ Version 2.2
	jp		nc, +
	ld		($D514), de
+:
.ELSE
	jp		c, LABEL_4135
	ld		a, h
	or		a
	jp		nz, LABEL_4135
.ENDIF
	xor		a
	ret

LABEL_4135:
	scf		
	ret

LABEL_4137:
	call	LABEL_4204
	ld		de, $0004
	ld		bc, $0200
	call	Engine_SetObjectVerticalSpeed
	call	Engine_UpdateObjectPosition
	ld		a, ($D137)
	bit		2, a
	jr		nz, LABEL_415F
	bit		3, a
	jr		nz, LABEL_415A
	ld		a, ($D440)
	cp		$02
	jp		z, LABEL_415F
	ret

LABEL_415A:
	ld		(ix+$02), $15
	ret

LABEL_415F:
	ld		e, (ix+$16)
	ld		d, (ix+$17)
	ld		l, e
	ld		h, d
	ld		bc, $01C0
	xor		a
	sbc		hl, bc
	jr		c, +
	ld		de, $01C0
+:  ld	  l, (ix+$18)
	ld		h, (ix+$19)
	add		hl, de
	srl		h
	rr		l
	bit		7, h
	jr		nz, +
	ex		de, hl
	ld		hl, $0000
	xor		a
	sbc		hl, de
	ld		de, $0080
	add		hl, de
	jr		c, +
	ld		(ix+$18), l
	ld		(ix+$19), h
+:  ld	  (ix+$02), $14
	ret

LABEL_4199:
	res		7, (ix+$04)
	call	LABEL_41A6
	call	LABEL_6BF2
	jp		LABEL_40E0

LABEL_41A6:
	call	Engine_UpdateObjectPosition
	call	LABEL_4226
	ld		a, ($D137)
	bit		3, a
	jr		nz, +
	ld		a, ($D440)
	cp		$02
	ret		z
+:  ld	  de, $0008
	ld		bc, $0400
	call	Engine_SetObjectVerticalSpeed
	ld		a, ($D137)
	bit		2, a
	ret		nz
	ld		a, (ix+$19)
	bit		7, a
	jr		z, +
	ld		hl, $0000
	ld		(ix+$18), l
	ld		(ix+$19), h
+:  ld	  (ix+$02), $13
	ret

LABEL_41DD:
	res		7, (ix+$04)
	call	LABEL_41EA
	call	LABEL_6BF2
	jp		LABEL_40E0

LABEL_41EA:
	call	LABEL_4226
	ld		de, $0010
	ld		bc, $0400
	call	Engine_SetObjectVerticalSpeed
	call	Engine_UpdateObjectPosition
	ld		a, ($D137)
	bit		3, a
	ret		nz
	ld		(ix+$02), $13
	ret

LABEL_4204:
	ld		l, (ix+$16)
	ld		h, (ix+$17)
	ld		de, $0006
	add		hl, de
	ld		e, l
	ld		d, h
	bit		7, h
	jr		nz, +
	ld		bc, $0280
	xor		a
	sbc		hl, bc
	jr		c, +
	ld		de, $0280
+:  ld	  (ix+$16), e
	ld		(ix+$17), d
	ret

LABEL_4226:
	ld		l, (ix+$16)
	ld		h, (ix+$17)
	ld		de, $000A
	xor		a
	sbc		hl, de
	ld		e, l
	ld		d, h
	bit		7, h
	jr		nz, +
	ld		bc, $0060
	xor		a
	sbc		hl, bc
	jr		nc, ++
+:  ld	  de, $0060
++: ld	  (ix+$16), e
	ld		(ix+$17), d
	ret

LABEL_424A:
	call	LABEL_376E
	res		7, (ix+$04)
	ld		a, ($D137)
	and		$0C
	jr		z, +
	ld		de, $0010
	and		$08
	jr		nz, ++
	ld		de, $FFF0
++: ld	  hl, ($D3C7)
	add		hl, de
	ld		e, l
	ld		d, h
	ld		bc, $0300
	xor		a
	sbc		hl, bc
	jr		nc, ++
	ld		de, $0300
++: ld	  l, e
	ld		h, d
	ld		bc, $07FF
	xor		a
	sbc		hl, bc
	jr		c, ++
	ld		de, $07FF
++: ld	  ($D3C7), de
+:  ld	  a, ($D3C6)
	ld		b, a
	ld		a, ($D3C8)
	add		a, b
	ld		($D3C6), a
	call	LABEL_42B7
	ld		a, ($D147)
	and		$30
	ret		z
	xor		a
	ld		($D3CD), a
	ld		(ix+$02), $0B
	ld		a, ($D3C6)
	add		a, $40
	ld		(ix+$0A), a
	ld		a, ($D3C8)
	add		a, a
	add		a, a
	add		a, a
	add		a, a
	add		a, a
	ld		(ix+$0B), a
	call	LABEL_64D4
	ret

LABEL_42B7:
	ld		a, ($D3C6)
	ld		c, a
	ld		b, $00
	ld		hl, DATA_330
	add		hl, bc
	ld		a, (hl)
	and		a
	jp		m, LABEL_42E8
	ld		e, $50
	ld		hl, $D3CA
	bit		7, (hl)
	jr		z, +
	ld		e, $38
+:  ld	  hl, $0000
	ld		d, $00
	ld		b, $08
-:  rrca	
	jr		nc, +
	add		hl, de
+:  sla	 e
	rl		d
	djnz	-
	ld		l, h
	ld		h, $00
	jp		LABEL_4310

LABEL_42E8:
	neg		
	ld		e, $50
	ld		hl, $D3CA
	bit		7, (hl)
	jr		z, +
	ld		e, $38
+:  ld	  hl, $0000
	ld		d, $00
	ld		b, $08
-:  rrca	
	jr		nc, +
	add		hl, de
+:  sla	 e
	rl		d
	djnz	-
	ld		de, $0000
	ex		de, hl
	xor		a
	sbc		hl, de
	ld		l, h
	ld		h, $FF
LABEL_4310:
	ld		de, ($D3C9)
	ld		a, d
	and		$7F
	ld		d, a
	add		hl, de
	ld		(ix+$11), l
	ld		(ix+$12), h
	ld		a, ($D3C6)
	add		a, $C0
	ld		c, a
	ld		b, $00
	ld		hl, DATA_330
	add		hl, bc
	ld		a, (hl)
	and		a
	jp		m, LABEL_4352
	ld		e, $50
	ld		hl, $D3CA
	bit		7, (hl)
	jr		z, +
	ld		e, $38
+:  ld	  hl, $0000
	ld		d, $00
	ld		b, $08
-:  rrca	
	jr		nc, +
	add		hl, de
+:  sla	 e
	rl		d
	djnz	-
	ld		l, h
	ld		h, $00
	jp		LABEL_437A

LABEL_4352:
	neg		
	ld		e, $50
	ld		hl, $D3CA
	bit		7, (hl)
	jr		z, +
	ld		e, $38
+:  ld	  hl, $0000
	ld		d, $00
	ld		b, $08
-:  rrca	
	jr		nc, +
	add		hl, de
+:  sla	 e
	rl		d
	djnz	-
	ld		de, $0000
	ex		de, hl
	xor		a
	sbc		hl, de
	ld		l, h
	ld		h, $FF
LABEL_437A:
	ld		de, ($D3CB)
	add		hl, de
	ld		de, $000C
	add		hl, de
	ld		(ix+$14), l
	ld		(ix+$15), h
	ret

LABEL_438A:
	res		7, (ix+$04)
	ld		a, ($D3C4)
	ld		b, a
	ld		a, ($D365)
	ld		($D3C4), a
	cp		b
	jr		z, +
	xor		a
	ld		($D3C5), a
+:  ld	  a, ($D365)
	sub		$30
	ld		b, a
	jp		c, LABEL_43AF
	cp		$10
	jr		nc, LABEL_43AF
	jp		LABEL_43BF

LABEL_43AF:
	ld		a, ($D367)
	sub		$30
	ld		b, a
	jp		c, LABEL_43F9
	cp		$10
	jr		nc, LABEL_43F9
	jp		LABEL_43C5

LABEL_43BF:
	ld		a, ($D3C5)
	or		a
	jr		nz, LABEL_43F3
LABEL_43C5:
	ld		a, b
	add		a, a
	ld		e, a
	ld		d, $00
	ld		hl, DATA_43D3
	add		hl, de
	ld		a, (hl)
	inc		hl
	ld		h, (hl)
	ld		l, a
	jp		(hl)

DATA_43D3:
.dw LABEL_4414 
.dw LABEL_441A 
.dw LABEL_45A8 
.dw LABEL_45C6 
.dw LABEL_45E4 
.dw LABEL_4602 
.dw LABEL_4420 
.dw LABEL_4482 
.dw LABEL_4546 
.dw LABEL_44E4 
.dw LABEL_4620 
.dw LABEL_4408 
.dw LABEL_440E 
.dw LABEL_4623 
.dw LABEL_4629 
.dw LABEL_4408

LABEL_43F3:
	call	Engine_UpdateObjectPosition
	jp		LABEL_6BF2

LABEL_43F9:
	ld		a, SFX_LeaveTube
	ld		($DD04), a
	xor		a
	ld		($D3A8), a
	ld		(ix+$21), a
	jp		Player_SetState_JumpFromRamp

LABEL_4408
	call	LABEL_468D
	jp		LABEL_43F3

LABEL_440E:
	call	LABEL_468D
	jp		LABEL_43F3

LABEL_4414:
	call	LABEL_469D
	jp		LABEL_43F3

LABEL_441A:
	call	LABEL_468D
	jp		LABEL_43F3

LABEL_4420:
	ld		a, (ix+$17)
	or		a
	jr		z, LABEL_445F
	bit		7, (ix+$17)
	jp		z, LABEL_4446
	call	LABEL_462F
	jp		nc, LABEL_43F3
	ld		a, ($D137)
	bit		0, a
	jr		nz, LABEL_4440
	call	LABEL_465D
	jp		LABEL_43F3

LABEL_4440:
	call	LABEL_467D
	jp		LABEL_43F3

LABEL_4446:
	call	LABEL_4637
	jp		nc, LABEL_43F3
	ld		a, ($D137)
	bit		0, a
	jr		nz, LABEL_4459
	call	LABEL_464D
	jp		LABEL_43F3

LABEL_4459:
	call	LABEL_467D
	jp		LABEL_43F3
	
LABEL_445F:
	call	LABEL_4640
	jp		nc, LABEL_43F3
	ld		a, ($D137)
	bit		3, a			;right button
	jr		nz, LABEL_4476
	bit		2, a			;left button
	jr		nz, LABEL_447C
	call	LABEL_467D
	jp		LABEL_43F3

LABEL_4476:
	call	LABEL_464D
	jp		LABEL_43F3


LABEL_447C:
	call	LABEL_465D
	jp		LABEL_43F3

LABEL_4482:
	ld		a, (ix+$17)
	or		a
	jr		z, LABEL_44C1
	bit		7, (ix+$17)
	jp		z, LABEL_44A8
	call	LABEL_462F
	jp		nc, LABEL_43F3
	ld		a, ($D137)
	bit		1, a
	jr		nz, LABEL_44A2
	call	LABEL_465D
	jp		LABEL_43F3

LABEL_44A2:
	call	LABEL_466D
	jp		LABEL_43F3

LABEL_44A8:
	call	LABEL_4637
	jp		nc, LABEL_43F3
	ld		a, ($D137)
	bit		1, a
	jr		nz, LABEL_44BB
	call	LABEL_464D
	jp		LABEL_43F3

LABEL_44BB:
	call	LABEL_466D
	jp		LABEL_43F3
LABEL_44C1:
	call	LABEL_464B
	jp		nc, LABEL_43F3
	ld		a, ($D137)
	bit		3, a
	jr		nz, LABEL_44D8
	bit		2, a
	jr		nz, LABEL_44DE
	call	LABEL_466D
	jp		LABEL_43F3

LABEL_44D8:
	call	LABEL_464D
	jp		LABEL_43F3

LABEL_44DE:
	call	LABEL_465D
	jp		LABEL_43F3
	
LABEL_44E4:
	ld		a, (ix+$17)
	or		a
	jr		nz, LABEL_4523
	bit		7, (ix+$19)
	jp		z, LABEL_450A
	call	LABEL_464B
	jp		nc, LABEL_43F3
	ld		a, ($D137)
	bit		2, a
	jr		nz, LABEL_4504
	call	LABEL_467D
	jp		LABEL_43F3
	
LABEL_4504:
	call	LABEL_465D
	jp		LABEL_43F3

LABEL_450A:
	call	LABEL_4640
	jp		nc, LABEL_43F3
	ld		a, ($D137)
	bit		2, a
	jr		nz, LABEL_451D
	call	LABEL_466D
	jp		LABEL_43F3

LABEL_451D:
	call	LABEL_465D
	jp		LABEL_43F3

LABEL_4523:
	call	LABEL_4637
	jp		nc, LABEL_43F3
	ld		a, ($D137)
	bit		0, a
	jr		nz, LABEL_453A
	bit		1, a
	jr		nz, LABEL_4540
	call	LABEL_465D
	jp		LABEL_43F3

LABEL_453A:
	call	LABEL_467D
	jp		LABEL_43F3
	
LABEL_4540:
	call	LABEL_466D
	jp		LABEL_43F3

LABEL_4546:
	ld		a, (ix+$17)
	or		a
	jr		nz, LABEL_4585
	bit		7, (ix+$19)
	jp		z, LABEL_456C
	call	LABEL_464B
	jp		nc, LABEL_43F3
	ld		a, ($D137)
	bit		3, a
	jr		nz, LABEL_4566
	call	LABEL_467D
	jp		LABEL_43F3

LABEL_4566:
	call	LABEL_464D
	jp		LABEL_43F3

LABEL_456C:
	call	LABEL_4640
	jp		nc, LABEL_43F3
	ld		a, ($D137)
	bit		3, a
	jr		nz, LABEL_457F
	call	LABEL_466D
	jp		LABEL_43F3

LABEL_457F:
	call	LABEL_464D
	jp		LABEL_43F3

LABEL_4585:
	call	LABEL_462F
	jp		nc, LABEL_43F3
	ld		a, ($D137)
	bit		0, a
	jr		nz, LABEL_459C
	bit		1, a
	jr		nz, LABEL_45A2
	call	LABEL_464D
	jp		LABEL_43F3

LABEL_459C:
	call	LABEL_467D
	jp		LABEL_43F3

LABEL_45A2:
	call	LABEL_466D
	jp		LABEL_43F3

LABEL_45A8:
	ld		a, (ix+$17)
	or		a
	jr		nz, LABEL_45BA
	call	LABEL_464B
	jp		nc, LABEL_43F3
	call	LABEL_464D
	jp		LABEL_43F3

LABEL_45BA:
	call	LABEL_462F
	jp		nc, LABEL_43F3
	call	LABEL_466D
	jp		LABEL_43F3

LABEL_45C6:
	ld		a, (ix+$17)
	or		a
	jr		nz, LABEL_45D8
	call	LABEL_464B
	jp		nc, LABEL_43F3
	call	LABEL_465D
	jp		LABEL_43F3

LABEL_45D8:
	call	LABEL_4637
	jp		nc, LABEL_43F3
	call	LABEL_466D
	jp		LABEL_43F3

LABEL_45E4:
	ld		a, (ix+$17)
	or		a
	jr		nz, LABEL_45F6
	call	LABEL_4640
	jp		nc, LABEL_43F3
	call	LABEL_464D
	jp		LABEL_43F3

LABEL_45F6:  
	call	LABEL_462F
	jp		nc, LABEL_43F3
	call	LABEL_467D
	jp		LABEL_43F3

LABEL_4602:
	ld		a, (ix+$17)
	or		a
	jr		nz, LABEL_4614
	call	LABEL_4640
	jp		nc, LABEL_43F3
	call	LABEL_465D
	jp		LABEL_43F3


LABEL_4614:
	call	LABEL_4637
	jp		nc, LABEL_43F3
	call	LABEL_467D
	jp		LABEL_43F3

LABEL_4620:
	jp		LABEL_43F3
		
LABEL_4623:
	call	LABEL_469D
	jp		LABEL_43F3

LABEL_4629:
	call	LABEL_469D
	jp		LABEL_43F3

LABEL_462F:
	ld		a, (ix+$11)
	and		$1F
	cp		$0E
	ret

LABEL_4637:
	ld		a, (ix+$11)
	and		$1F
	cp		$0E
	ccf		
	ret

LABEL_4640:
	ld		a, (ix+$14)
	sub		$0E
	and		$1F
	cp		$14
	ccf		
	ret

LABEL_464B:
	scf		
	ret

LABEL_464D:
	call	LABEL_469D
	ld		hl, $0000
	ld		($D518), hl
	ld		hl, $0600
	ld		($D516), hl
	ret

LABEL_465D:
	call	LABEL_469D
	ld		hl, $0000
	ld		($D518), hl
	ld		hl, $FA00
	ld		($D516), hl
	ret

LABEL_466D:
	call	LABEL_468D
	ld		hl, $0600
	ld		($d518), hl
	ld		hl, $0000
	ld		($d516), hl
	ret

LABEL_467D:
	call	LABEL_468D
	ld		hl, $FA00
	ld		($D518), hl
	ld		hl, $0000
	ld		($D516), hl
	ret

LABEL_468D:
	ld		a, (ix+$11)
	and		$E0
	add		a, $0E
	ld		(ix+$11), a
	ld		a, $FF
	ld		($D3C5), a
	ret

LABEL_469D:
	ld		l, (ix+$14)
	ld		h, (ix+$15)
	ld		de, $FFF0
	add		hl, de
	ld		a, l
	and		$E0
	ld		l, a
	ld		de, $002A
	add		hl, de
	ld		(ix+$14), l
	ld		(ix+$15), h
	ld		a, $FF
	ld		($D3C5), a
	ret

LABEL_46BB:
	ld		(ix+$02), $17
	ret

;called on initial collision with mine cart
LABEL_46C0:
	res		7, (ix+$04)
	ld		hl, $D3A0
	ld		(hl), $00
	inc		hl
	ld		(hl), $02
	inc		hl
	ld		(hl), $04
	inc		hl
	ld		(hl), $6A
	inc		hl
	ld		(hl), $6C
	inc		hl
	ld		(hl), $6E
	inc		hl
	ld		(hl), $70
	inc		hl
	ld		(hl), $72
	ld		iy, ($D39E)
	call	LABEL_4727
	set		7, (iy+$04)
	ret

;called once per frame when in a mine cart
LABEL_46EA:
	ld		iy, ($D39E)
	call	LABEL_4727
	call	LABEL_7378
	call	LABEL_376E
	ld		a, (ix+$02)
	cp		$1E
	jr		z, +
	res		0, (ix+$03)
	ld		a, ($D137)
	and		$30
	ret		z
+:	ld		iy, ($D39E)
	res		7, (iy+$04)
	ld		(iy+$1F), $10
	set		6, (iy+$03)
	ld		a, (iy+$3F)
	ld		(iy+$02), a
	ld		hl, $0000
	ld		($D39E), hl
	jp		Player_SetState_Jumping

LABEL_4727:
	ld		l, (iy+$11)
	ld		h, (iy+$12)
	ld		($D511), hl
	ld		l, (iy+$14)
	ld		h, (iy+$15)
	ld		($D514), hl
	ld		l, (iy+$16)
	ld		h, (iy+$17)
	ld		($D516), hl
	ld		l, (iy+$18)
	ld		h, (iy+$19)
	ld		($D518), hl
	ld		hl, $D503
	set		1, (hl)
	call	Player_CheckHorizontalLevelCollision
	ld		a, (iy+$3F)
	cp		$02
	jr		z, LABEL_475F
	set		4, (ix+$04)
	ret

LABEL_475F:
	res		4, (ix+$04)
	ret

;********************************************
;*  UGZ Mine Cart input handling routines   *
;********************************************
Player_MineCart_Handle:
LABEL_4764:
	ld		a, ($D137)
	ld		de, MineCart_LookingUp
	bit		0, a			;check for up button
	jr		nz, +
	ld		de, MineCart_LookingDown
	bit		1, a			;check for down button
	jr		nz, +
	ld		de, MineCart_LookingAhead
+:  ld	  a, (ix+$1E)	 ;frame number
	bit		7, (ix+$17)
	jr		nz, MineCart_UpdateAnimation
	inc		a
	jr		MineCart_SetSprite

MineCart_UpdateAnimation:	   ;4784
	dec		a			   ;next frame
MineCart_SetSprite:			 ;4785
	and		$03			 ;cap at 4 frames
	ld		(ix+$1E), a	 ;store frame number
	add		a, a			;calculate offset
	add		a, (ix+$1E)
	ld		l, a
	ld		h, $00
	add		hl, de
	ld		a, (hl)		 ;sprite state?
	ld		(ix+$06), a
	inc		hl
	ld		a, (hl)		 ;wheel left
	ld		($D3A6), a
	inc		hl
	ld		a, (hl)		 ;wheel right
	ld		($D3A7), a
	ld		(ix+$07), $03   ;?
	ret

;	   Wheel (left)
;	 ?   |  Wheel (right)
;  |----|----|----|
MineCart_LookingAhead:
.db $59, $70, $72 
.db $59, $74, $76 
.db $5A, $78, $7A
.db $5A, $7C, $7E

MineCart_LookingUp:
.db $5B, $70, $72 
.db $5B, $74, $76 
.db $5B, $78, $7A 
.db $5B, $7C, $7E

MineCart_LookingDown:
.db $5C, $70, $72
.db $5C, $74, $76
.db $5C, $78, $7A
.db $5C, $7C, $7E


;********************************************
;*  Power-up monitor collision routines.	*
;********************************************
LABEL_47C9:
	ld		a, ($D532)	  ;check for power-up
	or		a
	jr		z, Collision_Monitor

	ld		hl, ($D4A0)	 ;increment counter
	inc		hl
	ld		($D4A0), hl

	ld		bc, $04B0	   ;check to see if timer has expired
	xor		a
	sbc		hl, bc
	jr		c, Collision_Monitor	;jump if timer hasn't expired

	xor		a			   ;reset power-up
	ld		($D532), a

	ld		hl, $0000	   ;reset timer
	ld		($D4A0), hl

	ld		a, ($D4A2)	  ;check the boss flag
	or		a
	ret		nz

	ld		a, ($D293)	  ;check bit 6 of the game mode
	and		$BF
	ret		nz

.IFEQ Version 2.2
	ld		a, ($D501)
	cp		PlayerState_EndOfLevel
	ret		z
.ENDIF
	jp		Engine_ChangeLevelMusic


Collision_Monitor:		  ;$47F6
	ld		hl, $D39D
	ld		a, (hl)
	bit		0, a
	jr		nz, Collision_Monitor_Rings
	bit		1, a
	jr		nz, Collision_Monitor_Life
	bit		4, a
	jr		nz, Collision_Monitor_Continue
	bit		5, a
	jr		nz, LABEL_4845
	bit		2, a
	jr		nz, Collision_Monitor_Sneakers
	bit		3, a
	jr		nz, Collision_Monitor_Invincibility
	bit		6, a
.IFEQ Version 2.2
	jp		nz, LABEL_4884
.ELSE
	jr		nz, LABEL_4884
.ENDIF
	ret

Collision_Monitor_Rings:	;4817
	res		0, (hl)
	ld		a, (RingCounter)
	add		a, $10	  ;add 10 rings to the counter (bcd)
	daa		
	ld		(RingCounter), a
	ld		a, SFX_10Rings
	ld		($DD04), a

.IFEQ Version 2.2
	call	Engine_UpdateRingCounterSprites
	
	ld		a, (RingCounter)
	cp		$10
	ret		nc
	
	ld		a, ($D298)
	inc		a
	ld		(LifeCounter), a
	ld		a, SFX_ExtraLife
	ld		($DD04), a
	jp		LABEL_25AC
.ELSE
	jp		Engine_UpdateRingCounterSprites
.ENDIF

Collision_Monitor_Life:	 ;482A
	res		1, (hl)
	ld		a, ($D298)
	inc		a
	ld		(LifeCounter), a
	ld		a, SFX_ExtraLife
	ld		($DD04), a
	jp		LABEL_25AC

Collision_Monitor_Continue:
LABEL_483B:
	res		4, (hl)
	ld		a, ($D2BD)	  ;used by continue screen
	inc		a
	ld		($D2BD), a
	ret

LABEL_4845:
	res		5, (hl)
	ret

Collision_Monitor_Sneakers:	 ;4848
	res		2, (hl)
	ld		a, Music_SpeedSneakers
	ld		($DD04), a
	ld		a, $01		  ;power-up type = speed sneakers
	ld		($D532), a
	ld		hl, $0000	   ;timer (count up)
	ld		($D4A0), hl
	ld		c, Object_SpeedShoesStar
	ld		h, $00		  ;set up first star sprite
	call	Engine_AllocateObjectHighPriority
	ld		h, $01		  ;set up second star sprite
	jp		Engine_AllocateObjectHighPriority

Collision_Monitor_Invincibility:
LABEL_4866:
	res		3, (hl)
	ld		a, Music_Invincibility
	ld		($DD04), a
	ld		a, $02		  ;power-up type = invincibility
	ld		($D532), a
	ld		hl, $0000
	ld		($D4A0), hl	 ;timer
	ld		c, Object_InvincibilityStar ;show the spinning stars
	ld		h, $00
	call	Engine_AllocateObjectHighPriority
	ld		h, $01		  ;causes the second sprite to be opposite the first
	jp		Engine_AllocateObjectHighPriority


LABEL_4884:
	res		6, (hl)
	ret

LABEL_4887:
	call	LABEL_48F0		  ;update the "UnderWater" flag for the current act
	ld		a, (PlayerUnderwater)
	or		a
	jr		nz, Engine_WaterLevel_IncAirTimer
	xor		a
	ld		($D469), a
	ret

Engine_WaterLevel_IncAirTimer:
LABEL_4895:
	ld		hl, $D468		   ;air timer
	inc		(hl)
	ld		a, (hl)
	cp		$78
	ret		c
	ld		(hl), $00
	call	LABEL_48B8
	ld		hl, $D469
	inc		(hl)
	ld		a, (hl)
	cp		$0B
	jr		z, LABEL_48B0	   ;create the countdown object
	cp		$11
	jr		z, LABEL_48B7
	ret

LABEL_48B0:
	ld		c, Object_AirCountdown	  ;countdown object number
	ld		h, $00
	jp		Engine_AllocateObjectHighPriority   ;allocate a slot for the object


LABEL_48B7:
	ret

LABEL_48B8:
	ld		a, r
	and		$04
	ret		nz
	ld		c, Object_ALZ_Bubble
	ld		h, $03
	jp		Engine_AllocateObjectHighPriority
	

LABEL_48C4:
	ld		a, (PlayerUnderwater)
	or		a
	ret		z
	ld		hl, ($D36D)
	srl		h
	rr		l
	ld		($D36D), hl
	ret


LABEL_48D4:
	ret

LABEL_48D5:
	ld		a, (PlayerUnderwater)
	or		a
	ret		z
	inc		(ix+$30)
	ld		a, (ix+$30)
	and		$03
	ret		z
	ld		de, $0000
	ld		($D36F), de
	ld		($D371), de
	pop		de
	ret

LABEL_48F0:
	ld		a, (CurrentLevel)
	cp		$02
	ret		nz
	ld		a, (CurrentAct)
	or		a
	jr		z, LABEL_4944
	dec		a
	jr		z, Engine_UpdateUnderWaterFlag	  ;update for ALZ-2
	ld		hl, ($D511)
	ld		bc, $0880
	xor		a
	sbc		hl, bc
	jr		c, LABEL_4917	   ;update for ALZ-3 (part 1)
	ld		hl, ($D511)
	ld		bc, $0900
	xor		a
	sbc		hl, bc
	jr		c, LABEL_4926	   ;update for ALZ-3 (part 2)
	jr		LABEL_4935		  ;update for ALZ-3 (part 3)


LABEL_4917:
	ld		hl, ($D514)
	ld		bc, $0120
	xor		a
	sbc		hl, bc
	jp		c, Engine_ClearUnderWater
	jp		Engine_SetUnderWater

LABEL_4926:
	ld		hl, ($D514)
	ld		bc, $0160
	xor		a
	sbc		hl, bc
	jp		c, Engine_ClearUnderWater
	jp		Engine_SetUnderWater

LABEL_4935
	ld		hl, ($D514)
	ld		bc, $0140
	xor		a
	sbc		hl, bc
	jp		c, Engine_ClearUnderWater
	jp		Engine_SetUnderWater

LABEL_4944:	 ;handle water level for ALZ-1
	ld		hl, ($D511)
	ld		bc, $0650
	xor		a
	sbc		hl, bc
	jr		c, LABEL_4951
	jr		LABEL_4960

LABEL_4951:
	ld		hl, ($D514)
	ld		bc, $01C0
	xor		a
	sbc		hl, bc
	jp		c, Engine_ClearUnderWater
	jp		Engine_SetUnderWater

LABEL_4960
	ld		hl, ($D514)
	ld		bc, $0220
	xor		a
	sbc		hl, bc
	jp		c, Engine_ClearUnderWater
	jp		Engine_SetUnderWater

Engine_UpdateUnderWaterFlag:		;$496F
	ld		hl, ($D514)	 ;check whether the player is below the
	ld		bc, ($D4A4)	 ;zone's water level
	xor		a
	sbc		hl, bc
	jp		c, Engine_ClearUnderWater
	jp		Engine_SetUnderWater

	
Engine_ClearUnderWater:
	xor		a
	ld		(PlayerUnderwater), a
	ret

Engine_SetUnderWater:
	ld		a, $FF
	ld		(PlayerUnderwater), a
	ret

Engine_UpdateCameraPos:
LABEL_498A:
	ld		ix, $D15E
	bit		7, (ix+$00)
	ret		z
	call	LABEL_5D93
	ld		a, ($D162)		  ;bank with 32x32 mappings
	call	Engine_SwapFrame2
	call	Engine_UpdateCameraXPos
	call	Engine_UpdateCameraYPos
	call	Engine_CalculateBgScroll
	set		6, (ix+$00)
	ret

;enable camera movement
Engine_ReleaseCamera:	   ;$49AA
	ld		hl, $D15E
	set		7, (hl)
	ret

;lock camera movement
Engine_LockCamera:		  ;$49B0
LABEL_49B0:
	ld		hl, $D15E
	res		7, (hl)
	ld		hl, ($D174)
	ld		($D280), hl
	ret

;************************************************
;*  Set the camera position and lock in place.  *
;*											  *
;*  in  BC	  Horizontal camera offset.	   *
;*  in  DE	  Vertical camera offset.		 *
;*  destroys	HL							  *
;************************************************
Engine_SetCameraAndLock:		;$49BC
	ld		hl, $D15E
	set		7, (hl)		 ;lock camera
	ld		hl, $D15F
	set		0, (hl)		 ;update camera pos
	ld		($D2CE), bc	 ;horizontal camera offset
	ld		($D2D0), de	 ;vertical camera offset
	ret

LABEL_49CF:
	ld		hl, $D15E
	set		7, (hl)
	ld		hl, $D15F
	res		0, (hl)
	ret

Engine_SetMinimumCameraX:	   ;$49DA
	ld		hl, ($D280)	 ;minimum camera X pos
	ld		de, ($D174)	 ;current horiz. cam position?
	xor		a
	sbc		hl, de
	ret		nc
	ld		($D280), de
	ret

Engine_SetMaximumCameraX:	   ;$49EA
	ld		hl, ($D282)	 ;maximum camera x pos
	ld		de, ($D174)	 ;current horiz. cam position?
	xor		a
	sbc		hl, de
	ret		c
	ld		($D282), de
	ret


;update camera horizontal position
Engine_UpdateCameraXPos:	;$49FA
	ld		hl, ($D284)		 ;horiz sprite offset?
	ld		de, ($D280)		 ;minimum camera X pos
	xor		a
	sbc		hl, de
	jr		c, Engine_UpdateCameraXPos_Limit		;limit camera to minimum x pos
	ld		hl, ($D284)
	ld		de, ($D282)		 ;level width
	xor		a
	sbc		hl, de
	jr		nc, Engine_UpdateCameraXPos_Limit	   ;limit camera to level width
	bit		3, (ix+$00)
	jr		nz, +	   ;FIXME: this seems a bit pointless. This subroutine is identical.
	
	ld		a, ($D174)
	ld		b, a
	ld		a, ($D284)
	xor		b
	jp		nz, Engine_LoadMappings32_Column		;load a column of tiles from the 32x32 mappings
	ret

+:	ld		a, ($D174)
	ld		b, a
	ld		a, ($D284)
	xor		b
	jp		nz, Engine_LoadMappings32_Column
	ret

;limit the camera position
Engine_UpdateCameraXPos_Limit:  
	ld		hl, ($D174)
	ld		($D284), hl
	ret


Engine_UpdateCameraYPos:		;$4A37
	ld		hl, ($D286)		 ;vertical offset
	ld		de, ($D27C)		 ;minimum camera y pos
	xor		a
	sbc		hl, de
	jr		c, Engine_UpdateCameraYPos_Limit		;limit camera to minimum y position
	ld		hl, ($D286)
	ld		de, ($D27E)		 ;level height
	xor		a
	sbc		hl, de
	jr		nc, Engine_UpdateCameraYPos_Limit	   ;limit camera to level height
	bit		1, (ix+$00)
	jr		nz, +			   ;FIXME: subroutine identical to below. required?
	ld		a, ($D176)
	and		$F8
	ld		b, a
	ld		a, ($D286)
	and		$F8
	xor		b
	jp		nz, Engine_LoadMappings32_Row	   ;load a row of mappings from the 32x32 mappings
	ret		

+:  ld	  a, ($D176)
	and		$F8
	ld		b, a
	ld		a, ($D286)
	and		$F8
	xor		b
	jp		nz, Engine_LoadMappings32_Row
	ret

;limit camera y position
Engine_UpdateCameraYPos_Limit:  ;$4A75
	ld		hl, ($D176)
	ld		($D286), hl
	ret

Engine_CalculateBgScroll:	   ;$4A7C
	ld		a, ($D174)	  ;calculate horiz. scroll
	add		a, $01
	neg
	ld		($D172), a	  ;store h-scroll
	ld		hl, ($D176)	 ;Calculate the vertical scroll value
	ld		de, $0011
	add		hl, de
	ld		de, $00E0	   ;224 (screen height)
-:  xor	 a
	sbc		hl, de
	jr		nc, -
	add		hl, de
	ld		a, l
	ld		($D173), a	  ;store v-scroll
	ret

;****************************************************************
;*  Calculate the address of the mapping block at the top-left  *
;*  of the screen (within the level data).					  *
;*															  *
;*  in  BC	  Horizontal adjustment value.					*
;*  in  DE	  Vertical adjustment value.					  *
;*  out HL	  Address of current block.					   *
;*  out ($D278) Address of current block.					   *
;*  out ($D160) Index of block on the x-axis.				   *
;*  out ($D161) Index of block on the y-axis.				   *
;*  destroys	A, BC, DE									   *
;**************************************************************** 
Engine_Mappings_GetBlockXY:	 ;$4A9B
	ld		hl, ($D174)	 ;horizontal offset in level
	bit		2, (ix+$00)	 ;IX = $D15E
	jr		z, +
	ld		bc, $0008
	add		hl, bc
+:  sla	 l			   ;calculate the block on the x-axis
	rl		h	   ;hl *= 2
	sla		l
	rl		h	   ;hl *= 2
	sla		l
	rl		h	   ;hl *= 2
	ld		(ix+$02), h	 ;$D160 = abs($D174 / 32)
	
	ld		hl, ($D176)
	add		hl, de		  ;calculate the block on the y-axis
	sla		l
	rl		h	   ;hl *= 2
	sla		l
	rl		h	   ;hl *= 2
	sla		l
	rl		h	   ;hl *= 2
	ld		(ix+$03), h	 ;$D161 = abs($D176 / 32)
	
	ld		a, h			;HL = H * 2
	add		a, a
	ld		l, a
	ld		h, $00
	
	ld		de, ($D168)	 ;get the pointer to the row offsets
	add		hl, de
	ld		e, (hl)		 ;get the offset for the current row of
	inc		hl			  ;mappings
	ld		d, (hl)
	
	ld		l, (ix+$02)	 ;add the block x index to the row offset
	ld		h, $00
	add		hl, de
	ld		de, $C001	   ;calculate position in the level data array
	add		hl, de
	ld		($D278), hl	 ;$D278 = address of mapping block in level data
	ret

;Precalculated address offsets for each row of blocks
;for a given level width
.include "src\level_width_multiples.asm"


;****************************************
;*  Decompress level layout into RAM	*
;****************************************
Engine_LoadLevelLayout:	   ;$5305
	di		
	ld		ix, $D15E
	ld		a, (ix+$05)			;load the bank with the layout data
	call	Engine_SwapFrame2
	ld		l, (ix+$08)			;HL = pointer to layout data
	ld		h, (ix+$09)
	ld		de, $C001		   ;RAM destination for level layout
	push	hl
	pop		iy				  ;iy points to mappings
-:  ld	  a, d
	and		$F0
	cp		$C0				 ;only write to RAM between $C000 and $CFFF
	jr		nz, Engine_LoadLevel_DrawScreen
	ld		a, (iy+$00)		 ;load a byte from the layout stream
	cp		$FD				 ;check for the compression marker byte
	jp		nz, Engine_LoadLevelLayout_CopyByte
	ld		a, (iy+$01)		 ;compression - repeat count
	or		a				   ;check for end-of-stream marker ($FD, $00)
	jp		z, Engine_LoadLevel_DrawScreen
	ld		b, a
--: ld	  a, d
	and		$F0				 ;only write to RAM between $C000 and $CFFF
	cp		$C0
	jr		nz, Engine_LoadLevel_DrawScreen
	ld		a, (iy+$02)		 ;compression - the byte to repeat
	ld		(de), a
	inc		de
	djnz	--
	ld		bc, $0003
	add		iy, bc
	jp		-

;********************************
;* Copy a layout byte into RAM. *
;********************************
Engine_LoadLevelLayout_CopyByte:
	ld		a, (iy+$00)
	ld		(de), a
	inc		de
	inc		iy
	jp		-


;********************************************************
;*  Load the starting sprite & camera X/Y coordinates   *
;*  for the current level/act, then load the tiles for  *
;*  the screen viewport.								*
;********************************************************
Engine_LoadLevel_DrawScreen:		;$5353
	ei		;interrupt happens immediately after this
	call	Engine_LoadLevel_SetInitialPositions
	ld		hl, ($D2CA)	 ;set the screen X pos
	ld		($D174), hl
	ld		($D284), hl
	ld		hl, ($D2CC)	 ;set the screen Y pos
	ld		($D176), hl
	ld		($D286), hl
	;load the tiles for the initial screen (one row at a time)
	ld		b, $1D		  ;29
-:  di	  
	push	bc
	ld		hl, ($D176)	 ;get screen Y pos
	ld		de, $0008	   ;move to next row
	add		hl, de
	ld		($D286), hl
	ld		a, ($D162)	  ;bank for 32x32 mappings
	call	Engine_SwapFrame2
	call	Engine_LoadMappings32_Row	   ;load a row of tiles
	set		6, (ix+$00)
	call	WaitForInterrupt
	pop		bc
	djnz	-
	
	ld		a, $80				  ;setup camera offset
	ld		($D288), a
	ld		a, $78
	ld		($D289), a
	call	Engine_CalculateCameraBounds
	
	ld		hl, ($D2CA)	 ;set screen x pos
	ld		de, $0008
	add		hl, de
	ld		($D284), hl
	ld		($D174), hl
	
	ld		hl, ($D2CC)	 ;set screen y pos
	ld		($D286), hl
	ld		($D176), hl
	
	ld		de, $0010	   ;calculate vertical bg scroll value
	add		hl, de
	ld		de, $00E0
-:  xor	 a
	sbc		hl, de
	jr		nc, -
	add		hl, de
	ld		a, l
	ld		($D173), a	  ;store v-scroll value
	ei		
	ret

;********************************************
;*  Loads initial camera X/Y and sprite X/Y *
;*  for each level/act.					 *
;********************************************
Engine_LoadLevel_SetInitialPositions:	   ;$53C0
	ld		a, (CurrentLevel)
	ld		l, a
	ld		h, $00
	add		hl, hl
	ld		de, LevelLayout_Data_InitPos
	add		hl, de
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	ld		a, (CurrentAct)
	ld		l, a
	ld		h, $00
	add		hl, hl
	add		hl, de
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	push	de
	pop		iy
	ld		l, (iy+$00)	 ;load initial screeen X pos
	ld		h, (iy+$01)
	ld		($D2CA), hl
	ld		l, (iy+$02)	 ;load initial screen Y pos
	ld		h, (iy+$03)
	ld		($D2CC), hl
	ld		l, (iy+$04)	 ;initial player x pos
	ld		h, (iy+$05)
	ld		($D511), hl
	ld		l, (iy+$06)	 ;initial player y pos
	ld		h, (iy+$07)
	ld		($D514), hl
	ret

.include "src\level_layout_initial_positions.asm"


Engine_ClearLevelAttributes:		;$5531
	ld		hl, $D15E	  ;clear data from $D15E to $D290
	ld		de, $D15F
	ld		bc, $0132
	ld		(hl), $00
	ldir
	ret

Engine_LoadLevelHeader::		;$553F
	;load the pointer to the level header
	ld		a, (CurrentLevel)
	ld		l, a
	ld		h, $00
	add		hl, hl
	ld		de, LevelHeaders
	add		hl, de
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	;load the pointer for the current act
	ld		a, (CurrentAct)
	ld		l, a
	ld		h, $00
	add		hl, hl
	add		hl, de
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	push	de
	pop		iy
	ld		ix, $D15E	   ;destination for the level header
	
	ld		a, (iy+$00)
	ld		(ix+$04), a	 ;$D162	  - Bank number for 32x32 mappings
	
	ld		a, (iy+$01)	 ;$D164-D165 - pointer to 32x32 mappings
	ld		(ix+$06), a
	ld		a, (iy+$02)
	ld		(ix+$07), a
	
	ld		a, (iy+$03)	 ;$D163	  - Bank number for level layout
	ld		(ix+$05), a
	
	ld		a, (iy+$04)	 ;$D166-D167 - Pointer to level layout
	ld		(ix+$08), a
	ld		a, (iy+$05)
	ld		(ix+$09),a
	
	ld		a, (iy+$06)	 ;$D16C-D16D - level width in blocks
	ld		(ix+$0E), a
	ld		a, (iy+$07)
	ld		(ix+$0F), a

	ld		a, (iy+$08)	 ;$D16A-D16B - 2's comp. level width
	ld		(ix+$0C), a
	ld		a, (iy+$09)
	ld		(ix+$0D), a
	
	ld		a, (iy+$0A)	 ;$D16E-D16F - Vertical offset into layout data
	ld		(ix+$10), a	 
	ld		a, (iy+$0B)
	ld		(ix+$11), a
	
	ld		l, (iy+$0C)	 ;minimum camera x pos
	ld		h, (iy+$0D)
	ld		($D280), hl

	ld		l, (iy+$0E)	 ;minimum camera y pos
	ld		h, (iy+$0F)
	ld		($D27C), hl
	
	ld		l, (iy+$10)	 ;maximum camera x pos
	ld		h, (iy+$11)
	ld		($D282), hl
	
	ld		l, (iy+$12)	 ;maximum camera y pos
	ld		h, (iy+$13)
	ld		($D27E), hl

	ld		a, (iy+$14)	 ;$D168
	ld		(ix+$0A), a
	ld		a, (iy+$15)	 ;$D169
	ld		(ix+$0B), a
	
	ld		a, $80
	ld		($D288), a
	ld		a, $78
	ld		($D289), a
	call	Engine_CalculateCameraBounds
	ret		

.include "src\level_headers.asm"


;load a column of tiles from 32x32 mappings
Engine_LoadMappings32_Column:   ;$585B
	ld		de, $0008
	call	Engine_Mappings_GetBlockXY  ;get address of current mapping
	
	ld		de, $0008	   ;adjustment value for right edge of screen
	
	bit		3, (ix+$00)	 ;which way is the level scrolling?
	jr		nz, +		   ;jump if level scrolling left
	
	ld		de, $0000	   ;adjustment value for left edge of screen
	
+:  add	 hl, de		  ;add adjustment value to address of mapping

	exx		
	ld		de, $D178	   ;set destination for tile data
	exx

	ld		b, $08		  ;loop 8 times (8 mappings per column)
	
-:  push	bc
	push	hl
	ld		e, (hl)		 ;DE = value of mapping at address
	ld		d, $00
	ex		de, hl
	
	add		hl, hl
	ld		bc, ($D164)	 ;pointer to 32x32 mappings
	add		hl, bc		  ;HL = pointer to data for mapping
	
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	
	ld		a, ($D174)	  ;lo-byte of horiz. cam offset
	
	bit		2, (ix+$00)	 ;is level scrolling left?
	jr		z, +			;jump if level scrolling right
	
	add		a, $08		  ;adjust camera offset
	
+:  rrca					;calculate the pointer to the tile
	rrca	;values for the current mapping block
	and		$06
	ld		l, a
	ld		h, $00
	add		hl, de		  ;HL = pointer to tile data
	
	ld		b, $04		  ;loop 4 times (4 tiles per column in block)
	push	hl
	exx		
	pop		hl
	exx
	
--: exx
	ld		a, (hl)		 ;copy 2-byte tile value to work RAM at (DE)
	ld		(de), a
	inc		hl
	inc		de
	ld		a, (hl)
	ld		(de), a
	inc		de
	ld		a, $07		  ;move to the next row (i.e. add 7 to index).
	add		a, l
	ld		l, a
	exx		
	djnz	--			  ;copy next tile
	
	pop		hl
	ld		de, ($D16C)	 ;level width in blocks
	add		hl, de		  ;move to next row of mappings in level data
	pop		bc
	djnz	-
	
	set		5, (ix+$00)	 ;flag VRAM update required
	ret


Engine_CopyMappingsToVRAM_Column:   ;$58BA
	ld		hl, ($D176)	 ;HL = camera vpos
	ld		bc, $0008	   ;adjust vert offset value
	add		hl, bc		  ;calculate start address of offscreen tile
	srl		h			   ;buffer, relative to the nametable address.
	rr		l			   ;E.g. if offset is $100 the offscreen tile
	srl		h			   ;buffer starts at $3800 + $100 = $3900.
	rr		l
	srl		h
	rr		l
	add		hl, hl
	ld		bc, Data_OffscreenBufferOffsets
	add		hl, bc
	ld		c, (hl)
	inc		hl
	ld		b, (hl)
	
	ld		a, ($D174)	  ;get lo-byte of camera hpos
	
	bit		2, (ix+0)	   ;is level scrolling left?
	jr		z, +			;jump if level scrolling right
	
	add		a, $08		  ;adjust camera hpos
	
+:  rrca
	rrca
	and		$3E
	ld		l, a
	ld		h, $78
	add		hl, bc
	
	ld		bc, $0040	   ;BC = 2 * width of display in tiles (64).
							;this is used to increment the VRAM
							;address pointer
	ld		d, $7F		  ;DE is used to cap the VRAM address pointer
	ld		e, $07		  ;and prevent overflow
	
	exx
	ld		a, ($D176)	  ;A = lo-byte of camera vpos.
	add		a, $08		  ;caluclate the source address to copy
	rrca	;the tile data from.
	rrca
	and		$06
	ld		l, a
	ld		h, $00
	ld		de, $D178	   ;source of tile data
	add		hl, de
	
	ld		b, $36		  ;tile count
	ld		c, $BE		  ;VRAM data port
	
-:  exx
	ld		a, l			;set VRAM address
	out		($BF), a
	ld		a, h
	out		($BF), a

	add		hl, bc		  ;increment the VRAM address pointer
	ld		a, h
	cp		d			   ;check that the VRAM address pointer 
	jp		c, +			;is within bounds
	
	sub		e			   ;pointer not within bounds - adjust value
	ld		h, a
	
+:  exx
	outi	;write tile data to VRAM
	outi
	
	jp		nz, -		   ;move to next tile
	
	res		5, (ix+0)	   ;reset the "VRAM column update required" flag
	ret


Engine_LoadMappings32_Row:  ;$5920
	ld		de, $0000
	call	Engine_Mappings_GetBlockXY
	
	ld		de, ($D16E)	 ;get vertical offset value
	bit		1, (ix+0)	   ;is level scrolling down?
	jr		nz, +		   ;jump if it is
	
	ld		de, $0000	   ;level is scrolling up
	
+:  add	 hl, de		  ;add block's address to vertical offset value

	exx
	ld		de, $D1F8
	exx
	ld		b, $09
-:  push	bc
	push	hl
	ld		e, (hl)
	ld		d, $00
	ex		de, hl
	add		hl, hl
	ld		bc, ($D164)	 ;pointer to 32x32 mappings
	add		hl, bc		  ;calculate offset into mappings pointer array
	ld		e, (hl)		 ;get the pointer to the tile data
	inc		hl
	ld		d, (hl)
	ld		a, ($D176)	  ;get the tile scroll value by removing the
	and		$18			 ;"fine scroll" value from the lower 3 bits
	ld		l, a
	ld		h, $00
	add		hl, de
	push	hl
	exx
	pop		hl
	ld		bc, $0008
	ldir
	exx
	pop		hl
	inc		hl
	pop		bc
	djnz	-
	set		4, (ix+0)
	ret


;********************************************************
;*  Copy the row of mapping data at $D1F8 to the row	*
;*  above or below the camera.						  *
;********************************************************
Engine_CopyMappingsToVRAM_Row:	  ;$5966
	ld		a, ($D174)	  ;camera hpos
	bit		2, (ix+0)	   ;is level scrolling left?
	jr		z, +			;jump if level scrolling right
	
	add		a, $08		  ;adjust camera hpos
	
+:  rrca					;calculate the RAM address to copy tile
	rrca	;data from
	and		$06
	ld		l, a
	ld		h, $00
	ld		de, $D1F8	   ;source of new row data
	add		hl, de
	ex		de, hl
	
	ld		hl, ($D176)	 ;HL = camera vpos
	srl		h
	rr		l	   ;hl /= 2
	srl		h
	rr		l	   ;hl /= 2
	
	srl		h	   ;this division and the following ADD ensures
	rr		l	   ;that the offset is a multiple of 2.
	add		hl, hl
	
	ld		bc, Data_OffscreenBufferOffsets
	add		hl, bc		  ;calculate the start of the tile buffer
	ld		c, (hl)
	inc		hl
	ld		b, (hl)

	ld		a, ($D174)	  ;A = lo-byte of camera vpos
	bit		2, (ix+0)	   ;is level scrolling left?
	jr		z, +			;jump if level scrolling right
	
	add		a, $08		  ;adjust vpos
	
+:  rrca
	rrca
	and		$3E
	ld		l, a
	ld		h, $78		  ;calculate VRAM command byte to set 
	add		hl, bc		  ;address pointer

	ld		b, $21		  ;number of tile values to copy
	bit		2, (ix+0)	   ;is level scrolling left?
	jr		z, +			;jump if scrolling right
	
	dec		b			   ;scrolling left - decrement tile count
	
+:  ld	  a, l			;set up to write to the screen map in VRAM
	out		($BF), a
	ld		a, h
	out		($BF), a

-:  ld	  a, (de)		 ;write the 2-byte tile value to VRAM
	out		($BE), a
	inc		de
	inc		hl
	ld		a, (de)
	out		($BE), a
	inc		de
	inc		hl
	ld		a, l
	and		$3F
	jp		nz, +
	
	push	de
	ld		de, $0040
	or		a
	sbc		hl, de
	ld		a, l
	out		($BF), a
	ld		a, h
	out		($BF), a
	pop		de
+:  djnz	-

	res		4, (ix+0)	   ;reset the "VRAM row update required" flag
	ret


;********************************************************
;*  Lookup table of off-screen buffer address offsets.  *
;********************************************************
Data_OffscreenBufferOffsets:		;$59DB
.incbin "misc\offscreen_buffer_offsets.bin"



LABEL_5D93:				 ;updates current position in level
	ld		a, ($D15E)	  ;reset the scrolling flags
	and		$F0
	ld		($D15E), a
	
	bit		0, (ix+$01)
	jp		nz, LABEL_5EA1
	
	call	Engine_CameraAdjust
	ld		a, ($D28A)
	ld		b, a
	ld		hl, ($D511)
	ld		de, ($D174)
	xor		a
	sbc		hl, de
	jr		z, $40
	ld		a, l
	cp		b
	jr		c, $1E
	ld		a, ($D28B)
	ld		b, a
	ld		a, l
	cp		b
	jr		c, $34
	sub		b
	cp		$09
	jr		c, $02
	ld		a, $08
	ld		l,a
	ld		de, ($D174)
	add		hl, de
	ld		($D284), hl
	set		3, (ix+$00)
	jr		$1E
	ld		a, ($D28C)
	ld		b, a
	ld		a, l
	cp		b
	jr		nc, $16
	sub		b
	cp		$F7
	jr		nc, $02
	ld		a, $F8
	ld		l, a
	ld		h, $FF
	ld		de, ($D174)
	add		hl, de
	ld		($D284), hl
	set		2, (ix+$00)
	ld		a, ($D28D)
	ld		b, a
	ld		hl, ($D514)
	ld		de, ($D286)
	xor		a
	sbc		hl, de
	ret		z
	ld		a, l
	cp		b
	jr		c, $1C
	ld		a, ($D28E)
	ld		b, a
	ld		a, l
	cp		b
	ret		c
	sub		b
	cp		$09
	jr		c, $02
	ld		a, $08
	ld		l, a
	ld		de, ($D176)
	add		hl, de
	ld		($D286), hl
	set		1, (ix+$00)
	ret		

LABEL_5E24:
	ld		a, ($D28F)
	ld		b, a
	ld		a, l
	cp		b
	ret		nc
	sub		b
	cp		$F7
	jr		nc, +
	ld		a, $F8
+:  ld	  l, a
	ld		h, $FF
	ld		de, ($D176)
	add		hl, de
	ld		($D286), hl
	set		0, (ix+$00)
	ret		


;************************************************
;*  Adjust the camera position to look up/down  *
;*  or left/right.							  *
;************************************************
Engine_CameraAdjust:
LABEL_5E42:
	ld		a, ($D28A)
	ld		b, a
	ld		a, ($D288)	  ;horizontal cam adjustment
	cp		b
	jr		z, LABEL_5E62
	jr		c, +			;is adjustment < D28A?
	inc		b
	inc		b
	jr		++
+:  dec	 b
	dec		b
++: ld	  a, b			;set camera bounds
	ld		($D28A), a
	sub		$08
	ld		($D28C), a
	add		a, $10
	ld		($D28B), a
LABEL_5E62:
	ld		a, ($D28D)
	ld		b, a
	ld		a, ($D289)
	cp		b
	ret		z
	jr		c, +			;is adjustment < $D28D?
	inc		b
	jr		++
+:  dec	 b
++: ld	  a, b
	ld		($D28D), a	  ;set camera bounds
	sub		$10
	ld		($D28F), a
	add		a, $20
	ld		($D28E), a
	ret

Engine_CalculateCameraBounds:   ;$5E80
	ld		a, ($D288)
	ld		($D28A), a
	sub		$08
	ld		($D28C), a	  ;camera left bounds
	add		a, $10
	ld		($D28B), a	  ;camera right bounds
	ld		a, ($D289)
	ld		($D28D), a
	sub		$10
	ld		($D28F), a	  ;camera top bounds
	add		a, $20
	ld		($D28E), a	  ;camera bottom bounds
	ret		

LABEL_5EA1:
	ld		hl, ($D2CE)	 ;horizotal camera lock position?
	ld		de, ($D174)	 ;camera hpos
	xor		a
	sbc		hl, de
	jr		z, +			;jump if cam hpos == lock hpos
	jr		c, ++		   ;jump if cam hpos > lock hpos
	
	inc		de
	ld		($D284), de
	set		3, (ix+$00)	 ;set "level scrolling right" flag
	jr		+
	
++: dec	 de
	ld		($D284), de
	set		2, (ix+$00)	 ;set "level scrolling left" flag

+:  ld	  hl, ($D2D0)	 ;vertical camera lock position?
	ld		de, ($D176)	 ;DE = camera vpos
	xor		a
	sbc		hl, de
	ret		z			   ;return if lock vpos == camera vpos
	
	jr		c, +			;jump if cam vpod > lock vpos
	inc		de
	ld		($D286), de
	set		1, (ix+$00)
	ret

+:  dec	 de
	ld		($D286), de
	set		0, (ix+$00)
	ret

Engine_UpdateAllObjects:
LABEL_5EE4:
	xor		a
	ld		($D521), a	  ;reset player object's collision flags
	ld		ix, $D540	   ;get pointer to first, non-player, object descriptor
	ld		b, $13		  ;number of descriptors to iterate over
-:  push	bc
	di		
	call	LABEL_5EFD
	ei		
	ld		de, $0040	   ;move to next object descriptor structure
	add		ix, de
	pop		bc
	djnz	-
	ret


;********************************************
;   Updates the object pointed to by the	*
;   IX register.							*
;********************************************
LABEL_5EFD:
	ld		a, (ix+$00)
	or		a
	ret		z				   ;is there an object in this slot?
	cp		$F0				 ;jump if object >= $F0

.IFEQ Version 2.2
	jr		nc, LABEL_5F73
.ELSE
	jr		nc, LABEL_5F51
.ENDIF
	ld		a, (ix+$00)
	cp		$50
	jr		nc, LABEL_5F3D	  ;object types >= 80 are in bank 30
	cp		$20
	jr		nc, LABEL_5F29	  ;object types >= 32 < 80 are in bank 28
	ld		a, :Bank31		  ;object types >= 0 < 32 are in bank 31
	call	Engine_SwapFrame2
	call	LABEL_604A
	ld		a, :Bank31
	call	Engine_SwapFrame2
	call	LABEL_6139
	ld		a, (ix+$01)
	or		a
	call	nz, LABEL_617C
	ret		

LABEL_5F29: ;badniks & minecart
	ld		a, :Bank28
	call	Engine_SwapFrame2
	call	LABEL_604A
	ld		a, :Bank28
	call	Engine_SwapFrame2
	call	LABEL_6139
	call	LABEL_617C
	ret		

LABEL_5F3D:
	ld		a, :Bank30
	call	Engine_SwapFrame2
	call	LABEL_604A
	ld		a, :Bank30
	call	Engine_SwapFrame2
	call	LABEL_6139
	call	LABEL_617C
	ret		

.IFEQ Version 2.2
LABEL_5F73:
	cp		$FE
	jp		z, $620F
	cp		$FF
	jp		z, $6245
	ret
.ENDIF


.IFEQ Version 1.0
LABEL_5F51:
	and		$0F
	add		a, a
	ld		l, a
	ld		h, $00
	ld		de, DATA_5F60
	add		hl, de
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	ex		de, hl
	jp		(hl)

DATA_5F60:
.dw LABEL_5F80
.dw LABEL_5F80
.dw LABEL_5F80
.dw LABEL_5F80
.dw LABEL_5F80
.dw LABEL_5F80
.dw LABEL_5F80
.dw LABEL_5F80
.dw LABEL_5F80
.dw LABEL_5F80
.dw LABEL_5F80
.dw LABEL_5F80
.dw LABEL_5F80
.dw LABEL_5F80
.dw LABEL_6212
.dw LABEL_6248

LABEL_5F80:
ret

.ENDIF


Logic_Pointers	  ;$5F81
.include "src\object_logic_pointers.asm"

LABEL_603F:
	ld		a, ($D501)
	cp		PlayerState_LostLife
	jr		z, +
	cp		$28
	jr		z, +
LABEL_604A:
	ld		a, (ix+$0E)
	or		(ix+$0F)
	jr		z, Engine_UpdateObjectStateAnim
	ld		a, (ix+$02)	 ;check to see if we need to update the object's state
	cp		(ix+$01)
	jr		nz, Engine_UpdateObjectState
+:  dec	 (ix+$07)		;frame display counter?
	jp		z, LABEL_6087
	ret

Engine_UpdateObjectState:
	ld		a, (ix+$02)	 ;copy from working copy of state variable to
	ld		(ix+$01), a	 ;current state.
Engine_UpdateObjectStateAnim:	   ;$6067
	ld		a, (ix+$00)	 ;calculate a pointer to the object's animations
	dec		a
	add		a, a
	ld		l, a
	ld		h, $00
	ld		de, Logic_Pointers
	add		hl, de
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	ld		a, (ix+$01)	 ;get a pointer to the anim for the current state
	add		a, a
	ld		l, a
	ld		h, $00
	add		hl, de
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	ld		(ix+$0E), e	 ;store the pointer here
	ld		(ix+$0F), d
LABEL_6087:
	ld		l, (ix+$0E)	 ;fetch the animation pointer
	ld		h, (ix+$0F)
	ld		a, (hl)
	cp		$FF			 ;check for & process a command byte
	jp		z, Logic_ProcessCommand
	ld		(ix+$07), a	 ;frame display counter 
	inc		hl
	ld		a, (hl)
	ld		(ix+$06), a	 ;frame number
	inc		hl
	ld		a, (hl)
	ld		(ix+$0C), a	 ;pointer to logic subroutine
	inc		hl
	ld		a, (hl)
	ld		(ix+$0D), a
	inc		hl			  ;store next frame pointer
	ld		(ix+$0E), l
	ld		(ix+$0F), h
LABEL_60AC:
	ld		a, :Bank31
	call	Engine_SwapFrame2
	ld		l, (ix+$00)	 ;which object?
	ld		h, $00
	add		hl, hl
	ld		de, ObjectAnimations	;offset into animation pointer array in bank 31
	add		hl, de
	ld		e, (hl)		 ;get a pointer to the object's animation sequences
	inc		hl
	ld		d, (hl)
	ld		l, (ix+$06)	 ;object frame number
	ld		h, $00
	add		hl, hl
	add		hl, de		  ;get a pointer to the data for the current frame
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	ex		de, hl
	ld		a, (hl)
	ld		(ix+$05), a	 ;number of sprites in this object
	inc		hl
	ld		a, (hl)
	ld		(ix+$2C), a
	inc		hl
	ld		a, (hl)
	ld		(ix+$2D), a
	inc		hl
	ld		a, (hl)
	ld		(ix+$28), a	 ;pointer to sprite arrangement data
	inc		hl
	ld		a, (hl)
	ld		(ix+$29), a
	inc		hl
	ld		(ix+$2A), l	 ;pointer to sprite attribute data (horiz/vert 
	ld		(ix+$2B), h	 ;sprite offsets & pointer to char codes)
	ret		

LABEL_60E9:
	ld		a, (ix+$00)
	dec		a
	ret		nz
	ld		a, (ix+$06)
	ld		($D34F), a
	cp		$11
	jr		c, +
	cp		$16
	jr		c, LABEL_6131
+:  ld	  hl, $D137
	bit		2, (hl)		 ;check for left button
	jr		nz, LABEL_6127
	bit		3, (hl)		 ;check for right button
	jr		nz, LABEL_611D
	res		4, (ix+$04)
	ld		a, ($D350)
	and		$40
	or		$80
	ld		($D34E), a
	and		$40
	ret		z
	set		4, (ix+$04)
	ret		

LABEL_611D:
	ld		a, $80
	ld		($D34E), a
	res		4, (ix+$04)
	ret		

LABEL_6127:  
	ld		a, $C0
	ld		($D34E), a
	set		4, (ix+$04)
	ret		

LABEL_6131:  
	bit		7, (ix+$17)
	jr		z, LABEL_611D
	jr		LABEL_6127

LABEL_6139:	 ;called on collision
	ld		l, (ix+$0C)
	ld		h, (ix+$0D)
	ld		a, h
	or		l
	ret		z
	jp		(hl)
	ret		

;find an open object slot (entire range)
Engine_AllocateObjectHighPriority:	  ;$6144
	push	ix
	ld		ix, $D540
	ld		b, $10
	ld		de, $0040
-:  ld	  a, (ix+$00)
	or		a
	jr		z, LABEL_615C
	add		ix, de
	djnz	-
	pop		ix
	ret		

LABEL_615C:
	ld		(ix+$00), c
	ld		(ix+$3F), h
	pop		ix
	ret		

;find an open object slot (badnik range)
Engine_AllocateObjectLowPriority:	   ;$6165
	ld		iy, $D700
	ld		de, $0040
	ld		b, $0B
-:	ld		a, (iy+$00)
	or		a
	jr		z, +
	add		iy, de
	djnz	-
	scf
	ret
+:	xor		a
	ret		

LABEL_617C:
	bit		1, (ix+$04)
	ret		nz
	res		6, (ix+$04)
	ld		l, (ix+$11)
	ld		h, (ix+$12)
	ld		bc, $0020	   
	add		hl, bc
	ld		bc, ($D174)
	xor		a
	sbc		hl, bc
	srl		h
	rr		l
	srl		h
	rr		l
	ld		a, l
	cp		$50
	jr		nc, LABEL_61C2
	ld		l, (ix+$14)
	ld		h, (ix+$15)
	ld		bc, $0020
	add		hl, bc
	ld		bc, ($D176)
	xor		a
	sbc		hl, bc
	srl		h
	rr		l
	srl		h
	rr		l
	ld		a, l
	cp		$50
	jr		nc, LABEL_61C2
	ret		

LABEL_61C2:
	bit		0, (ix+$04)
	jp		nz, LABEL_6248
	set		6, (ix+$04)
	ld		l, (ix+$11)
	ld		h, (ix+$12)
	ld		bc, $0180
	add		hl, bc
	ld		bc, ($D174)
	xor		a
	sbc		hl, bc
	ld		a, h
	cp		$04
	jr		nc, LABEL_61FA
	ld		l, (ix+$14)
	ld		h, (ix+$15)
	ld		bc, $0180
	add		hl, bc
	ld		bc, ($d176)
	xor		a
	sbc		hl, bc
	ld		a, h
	cp		$04
	jr		nc, LABEL_61FA
	ret		

LABEL_61FA:
	ld		a, (ix+$3e)
	or		a
	jr		z, +
	ld		(ix+$00), $fe
	ld		(ix+$01), $00
	ret		

+:  ld	  (ix+$00), $ff
	ld		(ix+$01), $00
	ret		

LABEL_6212:
	ld		l, (ix+$3a)
	ld		h, (ix+$3b)
	ld		bc, $0180
	add		hl, bc
	ld		bc, ($d174)
	xor		a
	sbc		hl, bc
	ld		a, h
	cp		$04
	jr		nc, LABEL_623F
	ld		l, (ix+$3c)
	ld		h, (ix+$3d)
	ld		bc, $0180
	add		hl, bc
	ld		bc, ($d176)
	xor		a
	sbc		hl, bc
	ld		a, h
	cp		$04
	jr		nc, LABEL_623F
	ret		

LABEL_623F:
	ld		(ix+$00), $ff
	ld		(ix+$01), $00
	ret		

LABEL_6248:
	ld		a, (ix+$3E)
	or		a
	jp		z, +
	dec		a
	ld		e, a
	ld		d, $00
	ld		hl, $D400
	add		hl, de
	ld		(hl), $00
+:  push	ix
	pop		hl
	ld		(hl), $00
	ld		e, l
	ld		d, h
	inc		de
	ld		bc, $003F
	ldir	
	ret		

Engine_MoveObjectToPlayer:	  ;$6267
	ld		bc, ($D511)	 ;copy player's position to another object
	ld		de, ($D514)
	ld		(ix+$11), c
	ld		(ix+$12), b
	ld		(ix+$14), e
	ld		(ix+$15), d
	ret		


;********************************************************************
;*  Check to see if an object should be destroyed by a collision	*
;*  with the player object. Destroys object if required.			*
;*																  *
;*  in  IX	  Pointer to object's descriptor.					 *
;*  destroys	A & possibly DE, HL, BC if the object is destroyed. *
;********************************************************************
Logic_CheckDestroyObject:		   ;$627C
	ld		a, (ix+$21)	 ;get the object's object-to-object collision flags
	and		$0F
	ret		z			   ;return if no collisions
	ld		a, ($D503)	  ;check the "destroy enemies on collision" flag
	bit		1, a
	ret		z			   ;return if "destroy enemies" flag not set
	ld		(ix+$3F), $80

Engine_DisplayExplosionObject:	  ;$628C
	call	LABEL_62A7		  ;update score
	ld		(ix+$00), $0F	   ;display an explosion
	xor		a
	ld		(ix+$01), a
	ld		(ix+$02), a
	ld		(ix+$04), a
	ld		(ix+$07), a
	ld		(ix+$0E), a
	ld		(ix+$0F), a
	ret		

;updates score after a sonic -> object collision
LABEL_62A7:
	ld		a, (ix+$00)	 ;get object type
	sub		$20
	ret		c
	cp		$20			 ;make sure that object type >= 20 & < 40
	ret		nc
	add		a, a			;jump based on object type
	ld		e, a
	ld		d, $00
	ld		hl, DATA_62BD
	add		hl, de
	ld		a, (hl)
	inc		hl
	ld		h, (hl)
	ld		l, a
	jp		(hl)
	
DATA_62BD:  ;object collision type jump vectors
.dw LABEL_62FD
.dw LABEL_62FD  
.dw LABEL_62FD
.dw Score_AddBadnikValue	;badnik score value (crab)
.dw LABEL_62FD
.dw LABEL_62FD
.dw LABEL_62FD
.dw LABEL_62FD
.dw LABEL_62FD
.dw LABEL_62FD
.dw LABEL_62FD
.dw Score_AddBadnikValue	;badnik score value
.dw LABEL_62FD
.dw LABEL_62FD
.dw LABEL_62FD
.dw LABEL_62FD
.dw LABEL_62FD
.dw LABEL_62FD
.dw Score_AddBadnikValue	;badnik score value
.dw Score_AddBadnikValue	;badnik score value
.dw Score_AddBadnikValue	;badnik score value
.dw Score_AddBadnikValue	;badnik score value
.dw LABEL_62FD
.dw Score_AddBadnikValue	;badnik score value
.dw Score_AddBadnikValue	;badnik score value
.dw LABEL_62FD
.dw Score_AddBadnikValue	;badnik score value
.dw LABEL_62FD
.dw LABEL_62FD
.dw LABEL_62FD
.dw LABEL_62FD
.dw LABEL_62FD

LABEL_62FD:
	ret		

;****************************************************
;*  Sets a object's vertical velocity but enforces  *
;*  a maximum value.								*
;*													*
;*  in  DE	  Value to adjust velocity by.			*
;*  in  BC	  Maximum velocity.						*
;*  out DE	  Vertical velocity.					*
;*  destroys	HL, DE, A							*
;****************************************************
Engine_SetObjectVerticalSpeed:	  ;$62FE
	ld		l, (ix+$18)	 ;get vertical velocity
	ld		h, (ix+$19)
	add		hl, de
	ld		e, l
	ld		d, h
	bit		7, h
	jr		nz, LABEL_6313  ;jump if object is moving up
	xor		a
	sbc		hl, bc		  ;set velocity if below threshold
	jr		c, LABEL_6313
	ret		

LABEL_6311:
	ld		e, c
	ld		d, b
LABEL_6313:
	ld		(ix+$18), e	 ;set vertical velocity
	ld		(ix+$19), d
	ret		


;******************************************
;*  
;******************************************
LABEL_631A:
	ld		bc, $0000
	ld		de, $0000
	push	hl
	call	Engine_GetCollisionValueForBlock			;collide with background tiles
	pop		hl
	
	bit		7, a				;is block value >= $80?
	jr		z, LABEL_634C	   ;if not, clear Z flag and return
	
	ld		e, (ix+$18)		 ;DE = object's vertical speed
	ld		d, (ix+$19)
	bit		7, d
	jr		nz, LABEL_634C	  ;jump if object moving up (clear Z flag)
	
	xor		a				   ;this part makes the object bounce
	sbc		hl, de			  ;HL -= DE
	jr		c, LABEL_6344	   ;jump if object now moving up
	
	ld		hl, $0000		   ;object still moving down - set vertical
	ld		(ix+$18), l		 ;velocity to 0
	ld		(ix+$19), h
	xor		a				   ;set Z flag
	scf
	ret		

LABEL_6344:
	ld		(ix+$18), l
	ld		(ix+$19), h
	xor		a				   ;set Z flag
	ret		

LABEL_634C:
	xor		a
	dec		a				   ;clear Z flag
	ret		

;****************************************************************
;*  Test for collision between an object and the player then	*
;*  move/update the player object accordingly.				  *
;****************************************************************
Engine_CheckCollisionAndAdjustPlayer:   ;$634F
	call	Engine_CheckCollision
	jp		Engine_AdjustPlayerAfterCollision


LABEL_6355:
	call	Engine_CheckCollision
	call	Engine_AdjustPlayerAfterCollision
LABEL_635B:
	ld		a, ($D501)			  ;check for jumps/rolls
	cp		PlayerState_Jumping
	jr		z, LABEL_636B
	cp		PlayerState_Rolling
	jr		z, LABEL_636B
	cp		PlayerState_JumpFromRamp
	jr		z, LABEL_636B
	ret		

LABEL_636B:
	ld		a, (ix+$21)
	and		$0F
	ret		z
	bit		0, a
	jr		nz, +
	bit		1, a
	jr		nz, ++
	ld		hl, ($D518)
	ld		a, l
	or		h
	jr		z, ++
+:  ld	  hl, $FC00	   ;set vertical speed
	ld		($D518), hl
++: ld	  a, PlayerState_JumpFromRamp
	ld		($D502), a
	ld		a, SFX_Bomb		 ;play "bomb" sound
	ld		($DD04), a
	ld		bc, $0400
	ld		hl, ($D511)	 ;get player's horizontal position into HL
	ld		e, (ix+$11)	 ;get object's horizontal position into DE
	ld		d, (ix+$12)
	xor		a
	sbc		hl, de
	jr		nc, +		   ;jump if object is behind player
	ld		bc, $FC00
+:  ld	  ($D516), bc	 ;horizonal velocity
	ret		

LABEL_63A9:
	call	LABEL_6355
	ld		a, (ix+$1f)
	or		a
	jp		nz, LABEL_63E5
	res		5, (ix+$04)
	res		7, (ix+$04)
	ld		(ix+$21), $00
	ret		

LABEL_63C0:
	call	Engine_CheckCollisionAndAdjustPlayer
	ld		a, (ix+$1f)
	or		a
	jp		nz, LABEL_63E5
	res		5, (ix+$04)
	res		7, (ix+$04)
	ld		a, (ix+$21)
	and		$0f
	ret		z
	ld		(ix+$1f), $40
	dec		(ix+$24)
	ld		a, $aa
	ld		($dd04), a
	ret		

LABEL_63E5:
	dec		(ix+$1f)
	set		5, (ix+$04)
	ld		(ix+$21), $00
	ret		

;****************************************************
;*  Checks an object's collision flags (ix+$21) and *
;*  adjusts the player object accordingly.		  *
;*  Should be called after Engine_CheckCollision.   *
;****************************************************
Engine_AdjustPlayerAfterCollision:	  ;$63F1
	ld		a, (ix+$21)	 ;check the object for collisions
	and		$0F
	ret		z			   ;return if no collisions
	
	add		a, a			;calculate a jump based on the
	ld		e, a			;type of collision
	ld		d, $00
	ld		hl, DATA_6404
	add		hl, de
	ld		a, (hl)
	inc		hl
	ld		h, (hl)
	ld		l, a
	jp		(hl)

DATA_6404:
.dw LABEL_6424	  ;$00 - no collision
.dw LABEL_643C	  ;$01 - collision at top
.dw LABEL_6425	  ;$02 - collision at bottom
.dw LABEL_6424	  ;$03 - invalid (collision at top & bottom)
.dw LABEL_6483	  ;$04 - collision at right
.dw LABEL_6424	  ;$05 - invalid (collision top-right)
.dw LABEL_6424	  ;$06 - invalid (collision bottom-right)
.dw LABEL_6424	  ;$07 - invalid (right-top-bottom)
.dw LABEL_6454	  ;$08 - collision at left
.dw LABEL_6424
.dw LABEL_6424
.dw LABEL_6424
.dw LABEL_6424
.dw LABEL_6424
.dw LABEL_6424
.dw LABEL_6424

LABEL_6424:
	ret

LABEL_6425:	 ;collision at bottom
	ld		a, ($D523)	  ;test for collision at bottom
	bit		1, a
	ret		nz
	ld		a, ($D52D)	  ;get player object's height
	ld		e, a
	ld		d, $00
	ld		l, (ix+$14)	 ;add to object's vpos
	ld		h, (ix+$15)
	add		hl, de
	ld		($D514), hl
	ret		

LABEL_643C:
	ld		a, ($d523)
	bit		0, a
	ret		nz
	ld		e, (ix+$2d)
	ld		d, $00
	ld		l, (ix+$14)
	ld		h, (ix+$15)
	xor		a
	sbc		hl, de
	ld		($d514), hl
	ret		

LABEL_6454:
	ld		a, ($D523)
	bit		3, a
	ret		nz
	ld		hl, ($D174)
	ld		de, $0020
	add		hl, de
	ld		de, ($D511)
	xor		a
	sbc		hl, de
	ret		nc
	ld		e, (ix+$2c)
	ld		d, $00
	ld		a, ($d52c)
	ld		l, a
	ld		h, $00
	add		hl, de
	ex		de, hl
	ld		l, (ix+$11)
	ld		h, (ix+$12)
	xor		a
	sbc		hl, de
	ld		($d511), hl
	ret		

LABEL_6483:
	ld		a, ($d523)
	bit		2, a
	ret		nz
	ld		hl, ($d174)
	ld		de, $00e0
	add		hl, de
	ld		de, ($d511)
	xor		a
	sbc		hl, de
	ret		c
	ld		e, (ix+$2c)
	ld		d, $00
	ld		a, ($d52c)
	ld		l, a
	ld		h, $00
	add		hl, de
	ex		de, hl
	ld		l, (ix+$11)
	ld		h, (ix+$12)
	add		hl, de
	ld		($d511), hl
	ret		

DoNothingStub:	  ;$64B0
	ret		


;used by prison capsule to reset the count of child animal
;objects that it has spawned (stored at ix+$1F).
LABEL_64B1:
	xor		a
	ld		(ix+$1F), a
	ret		

;****************************************************
;*  Calculates the slot number occupied by an	   *
;*  object given a pointer to its descriptor.	   *
;*												  *
;*  HL  -   Pointer to the object's descriptor.	 *
;*  Clobbers: DE, HL								*
;*  Returns Slot number in A.					   *
;****************************************************
Engine_GetObjectIndexFromPointer:	   ;64B6
	ld		de, $D500
	xor		a
	sbc		hl, de
	ld		a, h
	sla		l
	rla		
	sla		l
	rla		
	inc		a
	ret		

;****************************************************
;*  Calculates the address of an object descriptor. *
;*												  *
;*  in  A	   The slot number.					*
;*  out HL	  The slot's address.				 *
;*  destroys	DE, A							   *
;****************************************************
Engine_GetObjectDescriptorPointer:	  ;$64C5
	dec		a
	ld		h, a
	xor		a
	srl		h   ;shift bit 0 into bit 7 of A register
	rra		
	srl		h   ;shift bit 0 into bit 7 of A register
	rra		
	ld		l, a
	ld		de, $D500   ;offset from player object address
	add		hl, de
	ret		


;horizontal platform?
LABEL_64D4:
	xor		a
	ld		(ix+$16), a	 ;reset object's horizontal velocity
	ld		(ix+$17), a
	ld		(ix+$18), a	 ;reset object's vertical velocity
	ld		(ix+$19), a

	ld		a, (ix+$0B)
	or		a
	ret		z

	ld		d, $00
	ld		e, (ix+$0A)
	ld		hl, DATA_330
	add		hl, de
	ld		a, (hl)

	ld		e, a
	and		$80
	rlca	
	neg		
	ld		d, a
	ld		hl, $0000
	ld		b, (ix+$0B)

-:  add	 hl, de
	djnz	-

	ld		a, l
	sra		h
	rra		
	sra		h
	rra		
	sra		h
	rra		
	sra		h
	rra		
	ld		(ix+$16), a		 ;set object's horizontal velocity
	ld		(ix+$17), h

	ld		a, (ix+$0A)
	add		a, $C0
	ld		e, a
	ld		d, $00
	ld		hl, DATA_330
	add		hl, de
	ld		a, (hl)

	ld		e, a
	and		$80
	rlca	
	neg		
	ld		d, a
	ld		hl, $0000
	ld		b, (ix+$0B)

-:  add	 hl, de
	djnz	-

	ld		a, l
	sra		h
	rra		
	sra		h
	rra		
	sra		h
	rra		
	sra		h
	rra		
	ld		(ix+$18), a		 ;set object's vertical velocity
	ld		(ix+$19), h
	ret


LABEL_6544:
	xor		a
	ld		(ix+$22), a
	ld		l, (ix+$2C)
	ld		h, $00
	bit		7, (ix+$17)
	jr		z, +
	ex		de, hl
	ld		hl, $0000
	xor		a
	sbc		hl, de
+:  push	hl
	pop		bc
	ld		de, $FFEF
	call	Engine_GetCollisionValueForBlock		;collide with background tiles
	cp		$81
	jr		z, LABEL_656B
	cp		$8D
	jr		z, LABEL_656B
	ret		

LABEL_656B:
	bit		7, (ix+$17)
	jr		nz, LABEL_6576
	set		2, (ix+$22)
	ret
LABEL_6576:
	set		3, (ix+$22)
	ret		

;********************************************************
;*  Change an object's direction flags based on the	 *
;*  current horizontal velocity.						*
;*													  *
;*  destroys	A, H									*
;********************************************************
Logic_UpdateObjectDirectionFlag:	;$657B
	ld		h, (ix+$17)	 ;test object's horizontal velocity
	ld		a, (ix+$16)
	or		h
	ret		z			   ;return if velocity is 0
	ld		a, h
	and		$80			 ;which direction is the object moving?
	jr		nz, +		   ;jump if object moving left
	
	res		4, (ix+$04)	 ;flag object moving right
	ret

+:  set	 4, (ix+$04)	 ;flag object moving left
	ret		


;********************************************************
;*  Change an object's direction flags so that the next *
;*  update will move the object towards the player.	 *
;*													  *
;*  destroys	A, DE, HL							   *
;********************************************************
Logic_ChangeDirectionTowardsPlayer:	 ;$6592
	ld		de, ($D511)	 ;DE = player hpos

;********************************************************
;*  Change an object's direction flags so that the next *
;*  update will move the object towards another object. *
;*													  *
;*  in  DE	  The other object's hpos				 *
;*  destroys	A, HL								   *
;********************************************************
Logic_ChangeDirectionTowardsObject:	 ;$6596
	ld		l, (ix+$11)	 ;HL = object's hpos
	ld		h, (ix+$12)

	xor		a
	sbc		hl, de		  ;compare both objects' hpos
	ret		z			   ;return if objects are overlapping

	jr		nc, +		   ;jump if DE < HL

	res		4, (ix+$04)	 ;flag object moving right
	ret

+:  set	 4, (ix+$04)	 ;flag object moving left
	ret


;****************************************************************
;*  Moves object A towards player on the x-axis by calculating  *
;*  the direction to move A and setting its speed accordingly.  *
;*  Will try to set speed to $0400							  *
;*															  *
;*  in  DE	  Adjustment value to apply to B's h-pos.		 *
;*  out BC	  Actual horiz. velocity applied to object A.	 *
;*  destroys	A, DE, HL									   *
;****************************************************************
Logic_MoveHorizontalTowardsPlayerAt0400:	;$65AC
	ld		hl, ($D511)
	ld		bc, $0400
	jp		Logic_MoveHorizontalTowardsObject   ;FIXME: why bother with this?


;****************************************************************
;*  Moves object A horizontally towards object B by calculating *
;*  the direction to move A and setting its speed accordingly.  *
;*															  *
;*  in  HL	  Object B's horizontal position.				 *
;*  in  DE	  Adjustment value to apply to B's h-pos.		 *
;*  in  BC	  Desired horiz. velocity to apply to object A.   *
;*  out BC	  Actual horiz. velocity applied to object A.	 *
;*  destroys	A, DE, HL									   *
;****************************************************************
Logic_MoveHorizontalTowardsObject:	  ;$65B5
	bit		4, (ix+$04)	 ;which direction is the object facing
	jr		z, +			;jump if facing right
	
	dec		de			  ;2's comp DE
	ld		a, d
	cpl		
	ld		d, a
	ld		a, e
	cpl		
	ld		e, a
	
+:  add	 hl, de		  ;add DE to other object's hpos
	ld		a, l
	and		$F8
	ld		l, a
	ld		e, (ix+$11)	 ;DE = object hpos
	ld		d, (ix+$12)
	ld		a, e
	and		$F8
	ld		e, a
	xor		a
	sbc		hl, de		  ;subtract object hpos from other
							;object's adjusted hpos
	jr		nc, +		   ;jump if object is to left of other object
	
	dec		bc			  ;2's comp bc (i.e. move in reverse)
	ld		a, b
	cpl		
	ld		b, a
	ld		a, c
	cpl		
	ld		c, a
	
+:  ld	  a, l
	or		h
	jr		nz, +		   ;jump if HL != 0 (i.e. objects are not on
							;top of each other).
	ld		bc, $0000	   ;set horizontal velocity to 0
	
+:  ld	  (ix+$17), b	 ;set object's horizontal velocity
	ld		(ix+$16), c
	ret		


;****************************************************************
;*  Moves object A towards object B on the Y-axis by			*
;*  calculating the direction to move A and setting its speed   *
;*  accordingly.												*
;*															  *
;*  in  HL	  Object B's vertical position.				   *
;*  in  DE	  Adjustment value to apply to B's v-pos.		 *
;*  in  BC	  Desired vert. velocity to apply to object A.	*
;*  out BC	  Actual vert. velocity applied to object A.	  *
;*  destroys	A, DE, HL									   *
;****************************************************************
Logic_MoveVerticalTowardsObject:		;$65EB
	add		hl, de		  ;adjust object B's vpos
	ld		a, l
	and		$FC
	ld		l, a
	
	ld		e, (ix+$14)	 ;DE = object A's vpos
	ld		d, (ix+$15)
	ld		a, e
	and		$FC
	ld		e, a
	
	xor		a
	sbc		hl, de		  ;compare A's vpos with B's
	jr		nc, +		   ;jump if A is above B
	
	dec		bc			  ;2's comp desired velocity
	ld		a, b
	cpl		
	ld		b, a
	ld		a, c
	cpl		
	ld		c, a

+:  ld	  a, l			;if objects are overlapping
	or		h			   ;set object A's speed to 0
	jr		nz, +
	ld		bc, $0000
	
+:  ld	  (ix+$19), b	 ;set A's vertical velocity
	ld		(ix+$18), c
	ret		


;********************************************************************
;*  Removes a breakable block from the level layout and replaces	*
;*  it with an empty block. Also creates the 4 block fragment	   *
;*  objects.														*
;********************************************************************
Engine_RemoveBreakableBlock:		;$6614
	ld		a, ($D12B)	  ;keep hold of the current bank number so that
	push	af			  ;we can swap it back in later

	call	Engine_GetCollisionValueForBlock	;collide with background tiles
	
	ld		a, ($D162)		  ;swap in the bank with the mappings
	call	Engine_SwapFrame2
	
	ld		a, $FD			  ;set the current mapping block to $FD
	ld		hl, ($D354)
	ld		(hl), a

	ld		l, a
	ld		h, $00
	add		hl, hl
	
	ld		a, ($D164)		  ;BC = pointer to 32x32 mappings for level
	ld		c, a
	ld		a, ($D165)
	ld		b, a

	add		hl, bc			  ;DE = pointer to data for mapping $FD
	ld		e, (hl)
	inc		hl
	ld		d, (hl)

	call	Engine_UpdateMappingBlock   ;update VRAM

	ld		hl, ($D356)		 ;get adjusted h-pos
	ld		a, l				;calculate position of block
	and		$E0
	ld		l, a
	ld		($D35A), hl		 ;set X-coordinate for block
	
	ld		hl, ($D358)		 ;get adjusted v-pos
	ld		a, l				;calculate position of block
	and		$E0				 ;on the y-axis
	ld		l, a
	ld		($D35C), hl		 ;set the y-coordinate for block

	ld		c, Object_BlockFragment

	ld		a, ($D353)		  ;get the "current mapping number" variable
	cp		$F7
	jr		nz, +

	ld		c, Object_BlockFragment2

+:  ld	  h, $00			  ;create 4 fragment objects
	call	Engine_AllocateObjectHighPriority
	ld		h, $01
	call	Engine_AllocateObjectHighPriority
	ld		h, $02
	call	Engine_AllocateObjectHighPriority
	ld		h, $03
	call	Engine_AllocateObjectHighPriority

	pop		af				  ;retrieve the previous bank number
	ld		($D12B), a		  ;and swap it back in
	ld		($FFFF), a
	ret		

	
;interprets a command in the object logic
Logic_ProcessCommand:	   ;$6675
	inc		hl
	ld		a, (hl)		 ;"command" byte 
	inc		hl
	ld		(ix+$0E), l	 ;store an updated pointer to the object's logic
	ld		(ix+$0F), h
	add		a, a			;jump based on the value of the command byte
	ld		l, a
	ld		h, $00
	ld		de, Logic_CommandVTable
	add		hl, de
	ld		a, (hl)
	inc		hl
	ld		h, (hl)
	ld		l, a
	jp		(hl)

Logic_CommandVTable:		;$668B
.dw LABEL_66AE	  ;$00 - load next animation
.dw LABEL_66B1	  ;$01 - 
.dw LABEL_66B4	  ;$02 - Execute logic using following 2 bytes as function pointer.
.dw LABEL_66CA	  ;$03 - do nothing stub
.dw LABEL_66CB	  ;$04 - Set sprite's horizontal/vertical velocity
.dw LABEL_66FB	  ;$05 - Change sprite state (e.g. write to $D502 for sonic) & load next animation frame
.dw LABEL_670F	  ;$06 - Load a new sprite.
.dw LABEL_6791	  ;$07 - Run new input logic.
.dw LABEL_67B1	  ;$08 - triggers loading of a monitor or chaos emerald
.dw LABEL_67C5	  ;$09 - 
.dw LABEL_66AB	  ;$0A - load the next animation frame
.dw LABEL_66AB	  ;$0B - 
.dw LABEL_66AB	  ;$0C -
.dw LABEL_66AB	  ;$0D - 
.dw LABEL_66AB	  ;$0E - 
.dw LABEL_66AB	  ;$0F - 

LABEL_66AB:
	jp		LABEL_6087
	
LABEL_66AE:
	jp		Engine_UpdateObjectStateAnim

LABEL_66B1:
	jp		LABEL_6248

LABEL_66B4:	 ;command sequence $FF $02 - jump to pointer
	ld		l, (ix+$0e)
	ld		h, (ix+$0f)
	ld		e, (hl)		 ;read the command's pointer operand
	inc		hl
	ld		d, (hl)
	inc		hl
	ld		(ix+$0e), l	 ;store pointer to next frame
	ld		(ix+$0f), h
	ld		hl, LABEL_6087  ;push this to the stack as the return address
	push	hl			  ;for the subroutine
	ex		de, hl
	jp		(hl)			;jump to subroutine,
	
LABEL_66CA:
	ret		

LABEL_66CB:	 ;command sequence $FF $04 - set the sprite's speed
	ld		l, (ix+$0e)
	ld		h, (ix+$0f)
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	inc		hl
	ld		c, (hl)
	inc		hl
	ld		b, (hl)
	inc		hl
	ld		(ix+$0e), l
	ld		(ix+$0f), h
	bit		4, (ix+$04)
	jr		z, +
	ld		hl, $0000
	xor		a
	sbc		hl, de
	ex		de, hl
+:  ld	  (ix+$16), e
	ld		(ix+$17), d
	ld		(ix+$18), c
	ld		(ix+$19), b
	jp		LABEL_6087

LABEL_66FB:
	ld		l, (ix+$0e)
	ld		h, (ix+$0f)
	ld		a, (hl)
	inc		hl
	ld		(ix+$0e), l
	ld		(ix+$0f), h
	ld		(ix+$02), a
	jp		LABEL_6087

LABEL_670F:	 ;command sequence $FF $06 - load a sprite
	call	Engine_AllocateObjectLowPriority
	jr		c, LABEL_677C   ;if no sprite slots
	ld		l, (ix+$0E)
	ld		h, (ix+$0F)
	ld		a, (hl)
	ld		(iy+$00), a
	inc		hl
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	inc		hl
	ld		c, (hl)
	inc		hl
	ld		b, (hl)
	inc		hl
	ld		a, (hl)
	ld		(iy+$3F), a
	inc		hl
	ld		(ix+$0E), l
	ld		(ix+$0F), h
	bit		4, (ix+$04)
	jr		z, +
	ld		hl, $0000
	xor		a
	sbc		hl, de
	ex		de, hl
+:  ld	  l, (ix+$11)
	ld		h, (ix+$12)
	add		hl, de
	ld		(iy+$11), l
	ld		(iy+$12), h
	ld		(iy+$3A), l
	ld		(iy+$3B), h
	ld		l, (ix+$14)
	ld		h, (ix+$15)
	add		hl, bc
	ld		(iy+$14), l
	ld		(iy+$15), h
	ld		(iy+$3C), l
	ld		(iy+$3D), h
	ld		a, (ix+$04)
	and		$10
	ld		(iy+$04), a
	ld		a, (ix+$08)
	ld		(iy+$08), a
	ld		a, (ix+$09)
	ld		(iy+$09), a
	jp		LABEL_6087

LABEL_677C:	 ;no open sprite slots
	ld		l, (ix+$0E)	 ;skip over the data for the "load sprite"
	ld		h, (ix+$0F)	 ;command and continue with the next frame
	inc		hl
	inc		hl
	inc		hl
	inc		hl
	inc		hl
	inc		hl
	ld		(ix+$0E), l
	ld		(ix+$0F), h
	jp		LABEL_6087

LABEL_6791:
	ld		l, (ix+$0E)
	ld		h, (ix+$0F)
	ld		e, (hl)		 ;pointer to subroutine
	inc		hl
	ld		d, (hl)
	inc		hl
	ld		a, (hl)
	ld		(ix+$0c), a	 ;store new input handler
	inc		hl
	ld		a, (hl)
	ld		(ix+$0d), a
	inc		hl
	ld		(ix+$0E), l
	ld		(ix+$0F), h
	ld		hl, LABEL_60AC  ;push this as the return address for the sub
	push	hl
	ex		de, hl
	jp		(hl)			;jump to subroutine

LABEL_67B1:	 ;triggers loading tiles for a monitor or chaos emerald
	ld		l, (ix+$0E)
	ld		h, (ix+$0F)
	ld		a, (hl)		 ;which tiles should we load?
	inc		hl
	ld		(ix+$0E), l
	ld		(ix+$0F), h
	ld		(PatternLoadCue), a	 ;the tiles to load
	jp		LABEL_6087

LABEL_67C5:	 ;command sequence $FF $09 - play a sound
	ld		l, (ix+$0E)
	ld		h, (ix+$0F)
	ld		a, (hl)		 ;the sound to play
	inc		hl
	ld		(ix+$0E), l	 ;store the pointer to the next frame
	ld		(ix+$0F), h
	bit		7, a			;is the sound value > $80?
	jr		z, +
	bit		6, (ix+$04)
	jp		nz, LABEL_6087
	ld		($DD04), a	  ;play the sound
	jp		LABEL_6087

+:  or	  $80			 ;set bit 7
	ld		($DD04), a
	jp		LABEL_6087

LABEL_67EC:
	res		4, (ix+$04)
	ret		

LABEL_67F1:
	set		4, (ix+$04)
	ret		

LABEL_67F6:
	ld		a, (ix+$04)
	xor		$10			 ;toggle bit 4 of (ix+4)
	ld		(ix+$04), a
	ret		

;************************************************
;*  Update an object's position in the level.   *
;*  Adds the object's x- & y-velocities to its  *
;*  current position.						   *
;*											  *
;*  in  IX	  Pointer to object's descriptor. *
;*  destroys	A, B, DE, HL					*
;************************************************
Engine_UpdateObjectPosition:		;$67FF
	ld		l, (ix+$10)	 ;update horizontal position
	ld		h, (ix+$11)
	ld		e, (ix+$16)	 ;get horizontal speed
	ld		d, (ix+$17)
	ld		b, (ix+$12)	 ;3rd byte of hpos
	ld		a, d
	and		$80
	rlca	
	dec		a
	cpl		
	add		hl, de		  ;add h-velocity to hpos
	adc		a, b
	ld		(ix+$12), a
	ld		(ix+$10), l
	ld		(ix+$11), h
	
	ld		l, (ix+$13)	 ;update vertical position
	ld		h, (ix+$14)
	ld		e, (ix+$18)
	ld		d, (ix+$19)
	ld		b, (ix+$15)
	ld		a, d
	and		$80
	rlca	
	dec		a
	cpl		
	add		hl, de
	adc		a, b
	ld		(ix+$15), a
	ld		(ix+$13), l
	ld		(ix+$14), h
	ret		


;****************************************************
;*  Test for a collision between an object and the  *
;*  player.											*
;*													*
;*  in	IX		Pointer to object descriptor.		*
;*  out			Updates player & object descriptors.*
;*  destroys	A, BC, DE, HL						*
;****************************************************
Engine_CheckCollision:	  ;$6840
	ld		a, ($D532)	  ;check for invincibility power up
	cp		$02
	jr		nz, +

	ld		hl, $D503
	set		1, (hl)		 ;flag player as invulnerable
	set		7, (hl)
	
+:  xor	 a
	ld		(ix+$20), a	 ;reset colliding object index
	ld		a, (ix+$21)	 ;clear collision axis flags (lower 4 bits)
	and		$F0
	ld		(ix+$21), a
	
	ld		a, ($D501)	  ;return if player has lost a life
	cp		PlayerState_LostLife
	ret		z
	
	cp		PlayerState_Drowning
	ret		z			   ;return if player is drowning

	bit		6, (ix+$03)
	ret		nz
	
	bit		7, (ix+$03)
	jr		nz, +

	ld		a, ($D503)
	bit		6, a
	ret		nz

+:  ld	  hl, ($D511)	 ;hl = player's hpos
	ld		e, (ix+$11)	 ;de = object's hpos
	ld		d, (ix+$12)
	xor		a
	sbc		hl, de
	jr		c, Engine_CheckCollision_Left   ;jump if object is left of the player.
	
	ld		a, h			;object is to the right of the player.
	or		a			   ;test proximity.
	jp		nz, Engine_CheckCollision_Return	;not close enough - bail out.
	
	ld		a, ($D52C)	  ;add the player's & the object's width in tiles
	add		a, (ix+$2C)
	cp		l			   ;test proximity.
	jp		c, Engine_CheckCollision_Return ;not close enough - bail out.
	
	ld		c, l
	set		2, (ix+$21)	 ;flag a collision at the object's right edge
	jp		Engine_CheckCollision_Bottom


;Tests for a collision at the objects' left-edge
Engine_CheckCollision_Left:	 ;$6899
	ld		a, h
	inc		a
	jp		nz, Engine_CheckCollision_Return
	ld		a, l
	neg		
	jp		z, Engine_CheckCollision_Return
	ld		l, a
	ld		a, ($D52C)	  ;add the player's width to the object's width
	add		a, (ix+$2C)
	cp		l			   ;test proximity
	jp		c, Engine_CheckCollision_Return
	ld		c, l
	set		3, (ix+$21)	 ;flag collision to left of object


;Tests for a collision at the object's bottom edge
Engine_CheckCollision_Bottom:   ;$68B4
	ld		hl, ($D514)	 ;player's vertical position
	ld		e, (ix+$14)	 ;current object's vertical position
	ld		d, (ix+$15)
	xor		a
	sbc		hl, de
	jr		c, Engine_CheckCollision_Top	;jump if player is above object
	ld		a, h
	or		a
	jr		nz, Engine_CheckCollision_Return	;not close enough - bail out
	ld		a, ($D52D)	  ;test against player object height
	cp		l
	jr		c, Engine_CheckCollision_Return	 ;not close enough - bail out
	set		1, (ix+$21)	 ;flag collision at bottom-edge of object
	jp		Engine_CheckCollision_UpdateObjectFlags

;Tests for a collision at the top of the object
Engine_CheckCollision_Top:	  ;$68D3
	ld		a, h
	inc		a
	jr		nz, Engine_CheckCollision_Return	;not close enough - bail out
	ld		a, l
	neg		
	jr		z, Engine_CheckCollision_Return	 ;not close enough - bail out
	ld		l, a
	ld		a, (ix+$2D)	 ;test against object's height
	cp		l
	jr		c, Engine_CheckCollision_Return	 ;not close enough - bail out
	set		0, (ix+$21)	 ;flag collision at top-edge of object

;updates flags on both objects after a collision
Engine_CheckCollision_UpdateObjectFlags:	;$68E7
	ld		a, l
	cp		c
	ld		b, $0C
	jr		c, +			;jump if L < C (collision on Y-axis)
	ld		b, $03			;collision was on X-axis
	
+:  ld		a, (ix+$21)		;keep only the vertical or horizontal
	and		b				;flags, depending on the collision
	ld		(ix+$21), a
	
	ld		a, ($D503)		;is player invincible?
	bit		7, a
	jr		nz, +
							;record a collision with the player object
	ld		(ix+$20), $01   ;in the object's descriptor
	
+:  bit		7, (ix+$03)
	jr		nz, +

	push	ix				;calculate the object's index (descriptor
	pop		hl				;slot number).
	call	Engine_GetObjectIndexFromPointer
	ld		($D520), a		;store the object's index in the player
							;object's descriptor structure

+:  ld		a, (ix+$21)		;get the object's collision flags
	and		$0F				;we're only interested in the lower 4 bits
	ld		b, a
	and		$03				;A = y-axis flags
	ld		c, $0C
	jr		z, +			;jump if no collision on Y axis
	ld		c, $03
	
+:  ld		a, b
	xor		c				;invert the flags
	rlca					;shift the flags into the upper 4 bits
	rlca	
	rlca	
	rlca	
	ld		b, a			;copy the upper 4 flag bits into the 
	ld		a, ($D521)		;upper 4 bits of the player object's
	and		$0F				;collision flags
	or		b
	ld		($D521), a
	ret		

Engine_CheckCollision_Return:	   ;$692F
	ld		a, (ix+$21)	 ;clear the lower 4 bits of the
	and		$F0			 ;object's collision flags
	ld		(ix+$21), a
	ret		



LABEL_6938:
	ld		b, (ix+$22)	 ;b = background collision flags
	ld		a, ($D3B9)
	or		a
	jr		nz, +
	bit		1, (ix+$03)
	jr		nz, ++
	
+:  ld	  a, (ix+$21)	 ;a = object collision flags
	rrca
	rrca
	rrca
	rrca
	and		$0F
	or		b
	ld		b, a
	
++: ld	  (ix+$23), b	 ;copy collision flags here
	ret		


;SHZ-2 wind
Engine_UpdateSHZ2Wind:
LABEL_6956:
	ld		a, (CurrentLevel)   ;check for SHZ-2
	dec		a
	ret		nz
	ld		a, (CurrentAct)
	dec		a
	ret		nz
	call	LABEL_6B61
	ld		a, ($D440)		  ;wind
	and		$03
	add		a, a
	ld		e, a
	ld		d, $00
	ld		hl, LABEL_6975
	add		hl, de
	ld		a, (hl)
	inc		hl
	ld		h, (hl)
	ld		l, a
	jp		(hl)

LABEL_6975:
.dw LABEL_697D 
.dw LABEL_698F 
.dw LABEL_69F5
.dw LABEL_6B47

LABEL_697D: 
	ld		a, ($DB2C)
	cp		$E0
	ret		z
	ld		a, $E0
	ld		hl, $DB2C
	ld		b, $08
-:  ld	  (hl), a
	inc		hl
	djnz	-
	ret		

LABEL_698F:
	ld		b, $08
	ld		de, DATA_6B27
	exx		
	ld		de, ($D176)
	exx		
	ld		ix, $D445
-:  ld	  a, (de)
	exx		
	ld		l, a
	ld		h, $00
	add		hl, de
	ld		(ix+$00), l
	ld		(ix+$01), h
	exx		
	inc		ix
	inc		ix
	inc		de
	inc		de
	djnz	-
	ld		b, $08
	ld		de, DATA_6B27+1
	exx		
	ld		de, ($D174)
	exx		
	ld		ix, $d455
-:  ld	  a, (de)
	exx		
	ld		l, a
	ld		h, $00
	add		hl, de
	ld		(ix+$00), l
	ld		(ix+$01), h
	exx		
	inc		ix
	inc		ix
	inc		de
	inc		de
	djnz	-
	ld		b, $08
	ld		hl, $db99
-:  ld	  a, $f6
	add		a, b
	ld		(hl), a
	inc		hl
	inc		hl
	djnz	-
	ld		a, $02
	ld		($D440), a
	ld		a, $08
	ld		($D444), a
	ld		hl, $0078
	ld		($D442), hl
	ret
	
LABEL_69F5:
	ld		a, ($D441)
	inc		a
	ld		($D441), a
	ld		b, $08
	ld		ix, $D445
	ld		iy, $D455
	ld		hl, $DB98
-:  push	hl
	call	LABEL_6A7E
	pop		hl
	ld		a, ($D441)
	and		$01
	call	z, LABEL_6B17
	inc		hl
	inc		hl
	inc		ix
	inc		ix
	inc		iy
	inc		iy
	djnz	-
	jp		LABEL_6A25  ;FIXME: why bother with this?
	
LABEL_6A25:
	ld		b, $08
	ld		ix, $D445
	ld		de, ($d176)
	exx		
	ld		de, $DB2C
	exx		
-:  ld	  l, (ix+$00)
	ld		h, (ix+$01)
	xor		a
	sbc		hl, de
	ld		a, l
	exx		
	ld		(de), a
	inc		de
	exx		
	inc		ix
	inc		ix
	djnz	-
	ld		b, $08
	ld		ix, $D455
	ld		de, ($D174)
	exx		
	ld		de, $DB98
	exx		
-:  ld	  l, (ix+$00)
	ld		h, (ix+$01)
	xor		a
	sbc		hl, de
	ld		a, l
	exx		
	ld		(de), a
	inc		de
	inc		de
	exx		
	cp		$08
	jr		nc, +
	ld		a, ($D444)
	cp		b
	jr		nc, +
	exx		
	dec		de
	ld		a, $FE
	ld		(de), a
	inc		de
	exx		
+:  inc	 ix
	inc		ix
	djnz	-
	ret		

LABEL_6A7E:
	ld		l, (ix+$00)
	ld		h, (ix+$01)
	ld		de, $FFFC
	add		hl, de
	ld		(ix+$00), l
	ld		(ix+$01), h
	ld		de, $0040
	add		hl, de
	ld		de, ($D176)
	xor		a
	sbc		hl, de
	jp		c, LABEL_6ACD
	ld		de, $0010
	xor		a
	sbc		hl, de
	jp		c, LABEL_6ACD
	ld		l, (iy+$00)
	ld		h, (iy+$01)
	ld		de, $0005
	add		hl, de
	ld		(iy+$00), l
	ld		(iy+$01), h
	ld		de, $0040
	add		hl, de
	ld		de, ($D174)
	xor		a
	sbc		hl, de
	jp		c, LABEL_6ACD
	ld		de, $0140
	xor		a
	sbc		hl, de
	jp		nc, LABEL_6ACD
	ret		

LABEL_6ACD:
	push	ix
	pop		hl
	ld		de, $D445
	xor		a
	sbc		hl, de
	ld		a, ($D441)
	add		a, l
	ld		c, a
	ld		a, r	;point of interest - used for random value?
	add		a, c
	ld		c, a
	ld		a, ($D511)
	add		a, c
	ld		c, a
	ld		a, (LevelTimer)
	add		a, c
	ld		c, a
	ld		a, ($D2BC)
	add		a, c
	and		$0F
	add		a, a
	ld		hl, DATA_6B27
	add		a, l
	ld		l, a
	ld		a, $00
	adc		a, h
	ld		h, a
	ld		a, (hl)
	inc		hl
	ld		c, (hl)
	ld		e, a
	ld		d, $00
	ld		hl, ($D176)
	add		hl, de
	ld		(ix+$00), l
	ld		(ix+$01), h
	ld		e, c
	ld		d, $00
	ld		hl, ($D174)
	add		hl, de
	ld		(iy+$00), l
	ld		(iy+$01), h
	ret		

LABEL_6B17:
	inc		hl
	ld		a, (hl)
	cp		$FE
	jr		z, +
	inc		a
	cp		$F9
	jr		c, ++
	ld		a, $F6
++: ld	  (hl), a
+:  dec	 hl
	ret		

DATA_6B27:
.db $E0, $00, $E0, $20, $C0, $40, $E0, $60
.db $C0, $80, $30, $00, $68, $08, $80, $10
.db $D0, $10, $C8, $28, $D0, $48, $C8, $50
.db $90, $00, $C4, $40, $68, $00, $A8, $08
	
LABEL_6B47:
	xor		a
	ld		($D444), a
	ld		hl, ($D442)
	dec		hl
	ld		($D442), hl
	ld		a, h
	and		$80
	jr		nz, +
	ld		a, h
	or		l
	jp		nz, LABEL_69F5
+:  xor	 a
	ld		($d440), a
	ret		

LABEL_6B61:
	ld		hl, ($D174)
	ld		a, h
	and		$0f
	sla		l
	rla		
	sla		l
	rla		
	ld		e, a
	ld		d, $00
	ld		hl, DATA_6BB2
	add		hl, de
	ld		a, (hl)
	inc		a
	and		$07
	add		a, a
	ld		e, a
	ld		d, $00
	ld		hl, LABEL_6B85
	add		hl, de
	ld		a, (hl)
	inc		hl
	ld		h, (hl)
	ld		l, a
	jp		(hl)

LABEL_6B85:
.dw LABEL_6B95
.dw LABEL_6B96
.dw LABEL_6B9B
.dw LABEL_6B95
.dw LABEL_6BA7
.dw LABEL_6B95
.dw LABEL_6B95
.dw LABEL_6B95

LABEL_6B95:
	ret

LABEL_6B96:
	xor		a
	ld		($d440), a
	ret		

LABEL_6B9B:
	ld		a, ($d440)
	cp		$02
	ret		z
	ld		a, $01
	ld		($d440), a
	ret

LABEL_6BA7:
	ld		a, ($d440)
	or		a
	ret		z
	ld		a, $03
	ld		($d440), a
	ret		

DATA_6BB2:
.db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.db $FF, $FF, $FF, $03, $01, $03, $00, $FF
.db $FF, $FF, $FF, $03, $01, $01, $03, $00
.db $FF, $FF, $FF, $FF, $01, $01, $01, $03
.db $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $03
.db $01, $01, $01, $01, $03, $01, $03, $00
.db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

LABEL_6BF2: ;collision with ring object?
	call	LABEL_6C3C
	call	Player_CheckHorizontalLevelCollision
	call	Player_CheckTopLevelCollision
	call	LABEL_7378
	jp		LABEL_6938

LABEL_6C01:
	ld		a, ($D36D)
	and		a
	jp		p, +
	neg		
+:  cp	  $04
	jp		nc, LABEL_6C2D
	bit		0, (ix+$07)
	jr		z, LABEL_6C21
	call	LABEL_6C3C
	call	Player_CheckTopLevelCollision
	call	LABEL_7378
	jp		LABEL_6938

LABEL_6C21:
	call	LABEL_6C3C
	call	Player_CheckHorizontalLevelCollision
	call	LABEL_7378
	jp		LABEL_6938

LABEL_6C2D:
	call	LABEL_6C3C
	call	Player_CheckHorizontalLevelCollision
	call	Player_CheckTopLevelCollision
	call	LABEL_7378
	jp		LABEL_6938

LABEL_6C3C:
	ld		a, ($D363)	  ;get the speed modifier value
	ld		($D364), a
	xor		a
	ld		($D363), a
	ld		bc, $0000	   ;horiz. offset
	ld		de, $0000	   ;vert. offset
	call	Engine_GetCollisionDataForBlock
	ld		a, ($D353)	  ;get current block value
	ld		($D365), a
	ld		($D367), a
	call	LABEL_6F82
	ld		a, ($D35E)
	ld		($D366), a
	and		$7F
	add		a, a
	ld		l, a
	ld		h, $00
	ld		de, DATA_6C70
	add		hl, de
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	ex		de, hl
	jp		(hl)
	
DATA_6C70:
.dw LABEL_6DAA  ;$00
.dw LABEL_6CA0  ;$01 - solid block
.dw LABEL_6CA1  ;
.dw LABEL_6C9C
.dw LABEL_6C9C
.dw LABEL_6CE2  ;$05 - spikes
.dw LABEL_6DAA  ;$06 - 
.dw LABEL_6DAA
.dw LABEL_6D49  ;$08 - ALZ slippery slope (unused?)
.dw LABEL_6CA2  ;$09 - vertical spring
.dw LABEL_6DAA  ;$0A - horizontal spring
.dw LABEL_6C9C  ;$0B
.dw LABEL_6D52  ;$0C - falling platform (e.g. SHZ bridge)
.dw LABEL_6CF7  ;$0D - breakable block
.dw LABEL_6D0D  ;$0E
.dw LABEL_6C9C
.dw LABEL_6E30
.dw LABEL_6C9C
.dw LABEL_6C9D
.dw LABEL_6EB1  ;$13 - SEZ pipes
.dw LABEL_6CAD  ;$14 - diagonal spring
.dw LABEL_6C9C

LABEL_6C9C:
	ret

LABEL_6C9D:
	jp		LABEL_6CA1	  ;FIXME: pointless
	
LABEL_6CA0:
	ret		

LABEL_6CA1:
	ret		

LABEL_6CA2:				 ;hit vertical spring
	bit		1, (ix+$22)
	ret		z
	ld		hl, $F880	   ;jump velocity
	jp		Player_SetState_VerticalSpring  


LABEL_6CAD:				 ;diagonal spring
	bit		1, (ix+$22)
	ret		z
	ld		hl, $F880
	set		4, (ix+$04)
	ld		a, ($d365)
	cp		$80
	jr		nc, +
	ld		hl, $0780
	res		4, (ix+$04)
+:  ld	  (ix+$16), l		 ;horizontal velocity
	ld		(ix+$17), h
	ld		hl, $FAF0
	ld		a, (CurrentLevel)
	cp		$03				 ;check to see if we're on GHZ
	jr		z, +
	ld		hl, $F900		   
+:  ld	  a, SFX_Spring	   ;play spring "bounce" sound
	ld		($DD04), a
	jp		Player_SetState_DiagonalSpring


LABEL_6CE2:				 ;hit spikes
	ld		a, ($D365)
	and		$fe
	cp		$f4
	ret		z
	bit		1, (ix+$22)
	ret		z
	bit		7, (ix+$03)
	ret		nz
	jp		Player_SetState_Hurt
	
LABEL_6CF7:				 ;hit breakable block
	bit		1, (ix+$03)
	ret		z			   ;return if player is not rolling
	ld		hl, $FBC0
	ld		($D518), hl	 ;set vertical speed
	res		1, (ix+$22)
	set		0, (ix+$03)
	jp		Player_CollideBreakableBlock_UpdateMappings	 ;update level layout

LABEL_6D0D:
	bit		1, (ix+$22)
	ret		z
	ld		a, ($D365)	  ;search within 8 bytes of $6D41 for the value at ($D365)
	ld		hl, DATA_6D41
	ld		bc, $0008
	cpir	
	jr		z, +
	ld		hl, $0100
	jr		++
+:  ld	  hl, $ff00
++: ld	  c, $00
	bit		7, h
	jr		z, +
	dec		c
+:  xor	 a
	ld		de, ($D510)
	add		hl, de
	ld		($D510), hl
	ld		a, $00
	adc		a, c
	add		a, (ix+$12)
	ld		(ix+$12), a
	ret		

DATA_6D41:
.db $DF, $E0, $E3, $E4, $E5, $E6, $E7, $F0

LABEL_6D49:	 ;alz slippery slope
	ld		a, (ix+$02)
	cp		$1A
	ret		z
	jp		LABEL_318F

LABEL_6D52:
	ld		a, ($D362)	  ;vertical collision value
	cp		$20
	ret		nz
	ld		a, ($D365)
	ld		c, $FF
	cp		$EF
	jr		nz, +
	ld		a, ($D511)	  ;get player h-pos
	ld		c, $ED
	and		$10
	jr		z, +
	inc		c
+:  push	bc
	res		1, (ix+$22)
	call	Engine_AllocateObjectLowPriority
	pop		bc
	ret		c
	ld		a, $B1
	ld		($DD04), a
	ld		(iy+$00), $2d
	jp		LABEL_6D81

LABEL_6D81:
	ld		a, ($D12B)
	push	af
	ld		a, ($D162)  ;bank with 32x32 mappings
	call	Engine_SwapFrame2
	ld		a, c
	ld		hl, ($D354)
	ld		(hl), a
	ld		l, a
	ld		h, $00
	add		hl, hl
	ld		a, ($D164)  ;BC = pointer to 32x32 mappings
	ld		c, a
	ld		a, ($D165)
	ld		b, a
	add		hl, bc
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	call	Engine_UpdateMappingBlock
	pop		af
	call	Engine_SwapFrame2
	jp		LABEL_6DD5

LABEL_6DAA:
	res		1, (ix+$22)
	ld		a, ($D501)
	cp		PlayerState_Rolling
	jr		z, +
	cp		PlayerState_JumpFromRamp
	jr		z, +
	jr		LABEL_6DD5
+:  ld	  a, ($D364)
	or		a
	jr		z, LABEL_6DD5
	bit		7, (ix+$17)
	jr		nz, LABEL_6DCC
	bit		1, a
	jr		z, LABEL_6DD5
	jp		Player_RampLaunch

LABEL_6DCC:
	bit		1, a
	jr		nz, LABEL_6DD5
	jp		Player_RampLaunch

LABEL_6DD5: 
	call	LABEL_6938
	bit		1, (ix+$23)
	ret		nz
	bit		0, (ix+$03)	 ;player in air?
	ret		nz
	ld		a, (ix+$01)
	cp		PlayerState_Rolling
	jp		nz, Player_SetState_Falling
	jp		LABEL_3ACA

;called when launching from a ramp
Player_RampLaunch:
LABEL_6DED:
	ld		l, (ix+$16)
	ld		h, (ix+$17)
	bit		7, h				;is horizontal velocity negative?
	jr		nz, LABEL_6E10
	ld		d, h			;take horizontal velocity, divide by 2 and add to vertical velocity
	ld		e, l
	srl		h
	rr		l
	add		hl, de
	dec		hl
	ld		a, h
	cpl		
	ld		h, a
	ld		a, l
	cpl		
	ld		l, a
	ld		($D518), hl
	ld		a, SFX_Jump
	ld		($DD04), a
	jp		Player_SetState_JumpFromRamp

;launch from ramp with negative velocity
LABEL_6E10:
	dec		hl		  ;2's comp horizontal velocity, divide by 2 and
	ld		a, h		;add to vertical velocity.
	cpl		
	ld		h, a
	ld		a, l
	cpl		
	ld		l, a
	ld		d, h
	ld		e, l
	srl		h
	rr		l
	add		hl, de
	dec		hl
	ld		a, h
	cpl		
	ld		h, a
	ld		a, l
	cpl		
	ld		l, a
	ld		($D518), hl
	ld		a, SFX_Jump		 ;play jump sound
	ld		($DD04), a
	jp		Player_SetState_JumpFromRamp
	
LABEL_6E30:
	ld		a, ($D362)
	bit		7, a
	ret		nz
	bit		1, (ix+$22)
	ret		z
	ld		a, ($D365)
	cp		$2D
	ret		nz
	ld		hl, ($D516)
	bit		7, h
	ret		nz
	ld		a, h
	neg		
	ld		h, a
	ld		a, l
	neg		
	ld		l, a
	ld		($D516), hl
	ld		($D518), hl
	ret		
	
LABEL_6E56:
	ld		a, ($D362)
	bit		6, a
	jr		nz, LABEL_6E8B
	and		$3F
	ld		b, a
	ld		a, ($D358)
	and		$1F
	add		a, b
	cp		$20
	ret		c
	sub		$20
	ld		c, a
	ld		b, $00
	ld		h, (ix+$15)
	ld		l, (ix+$14)
	xor		a
	sbc		hl, bc
	ld		(ix+$15), h
	ld		(ix+$14), l
	set		1, (ix+$22)
	call	LABEL_6938
	ld		a, ($D100)
	ld		($D363), a
	ret		

LABEL_6E8B:
	and		$3F
	ld		b, a
	ld		a, ($D358)
	and		$1F
	add		a, c
	sub		b
	ret		nc
	neg		
	ld		c, a
	ld		b, $00
	ld		h, (ix+$15)
	ld		l, (ix+$14)
	xor		a
	sbc		hl, bc
	ld		(ix+$15), h
	ld		(ix+$14), l
	set		1, (ix+$22)
	jp		LABEL_6938

LABEL_6EB1:
	ld		a, ($D365)
	ld		($D367), a


;************************************************************
;*  Tests to see if the player is entering or leaving a	 *
;*  pipe.												   
;************************************************************
Player_EnterPipe:	   ;$6EB7
	res		1, (ix+$22)
	set		0, (ix+$03)
	ld		a, ($D353)	  ;get current mapping index
	cp		$3B
	jr		z, Player_EnterPipe_Top	 ;vertical entrance - top
	cp		$3C
	jr		z, Player_EnterPipe_Bottom  ;vertical entrance - bottom
	cp		$3D
	jr		z, Player_EnterPipe_Left	;horizontal entrance - left
	cp		$3E
	jp		z, Player_EnterPipe_Right   ;horizontal entrance - right
	jp		Player_EnterPipe_Return


;****************************************
;*  Player entering pipe from below.	*
;****************************************
Player_EnterPipe_Bottom:		;$6ED6
	ld		a, SFX_Roll
	ld		($DD04), a
	ld		a, (ix+$01)		 ;check to see if the player
	cp		PlayerState_InPipe  ;is already in the pipe
	jp		z, Player_EnterPipe_Return
	bit		7, (ix+$19)
	jp		z, Player_EnterPipe_Return	  ;bail out if player is moving down
	ld		(ix+$02), PlayerState_InPipe	;set player state
	ld		hl, $FA00		   ;set vertical speed
	ld		(ix+$18), l
	ld		(ix+$19), h
	ld		hl, $0000		   ;set horizontal speed
	ld		(ix+$16), l
	ld		(ix+$17), h
	jp		Player_EnterPipe_Return


;****************************************
;*  Player entering pipe from above.	*
;****************************************
Player_EnterPipe_Top:	   ;$6F03
	ld		a, SFX_Roll
	ld		($DD04), a
	ld		a, (ix+$01)		 ;check to see if the player
	cp		PlayerState_InPipe  ;is already in the pipe
	jr		z, Player_EnterPipe_Return
	bit		7, (ix+$19)
	jr		nz, Player_EnterPipe_Return	 ;bail out if player is moving up	
	ld		(ix+$02), PlayerState_InPipe	;set player state
	ld		hl, $0600		   ;set vertical speed
	ld		(ix+$18), l
	ld		(ix+$19), h
	ld		hl, $0000		   ;set horizontal speed
	ld		(ix+$16), l
	ld		(ix+$17), h
	jp		Player_EnterPipe_Return


;************************************
;*  Player entering pipe from left. *
;************************************
Player_EnterPipe_Left:	  ;$6F2E
	ld		a, SFX_Roll
	ld		($DD04), a
	ld		a, (ix+$01)		 ;check to see if the player
	cp		PlayerState_InPipe  ;is already in the pipe
	jr		z, Player_EnterPipe_Return
	bit		7, (ix+$17)
	jr		nz, Player_EnterPipe_Return	 ;bail out if player is moving left
	ld		(ix+$02), PlayerState_InPipe	;set player state
	ld		hl, $0600		   ;set horizontal speed
	ld		(ix+$16), l
	ld		(ix+$17), h
	ld		hl, $0000		   ;set vertical speed
	ld		(ix+$18), l
	ld		(ix+$19), h
	jp		Player_EnterPipe_Return


;****************************************
;*  Player entering pipe from right.	*
;****************************************
Player_EnterPipe_Right:	 ;$6F59
	ld		a, SFX_Roll
	ld		($DD04), a
	ld		a, (ix+$01)		 ;check to see if the player
	cp		PlayerState_InPipe  ;is already in the pipe
	jr		z, Player_EnterPipe_Return
	bit		7, (ix+$17)
	jr		z, Player_EnterPipe_Return	  ;bail out if player is moving right
	ld		(ix+$02), PlayerState_InPipe	;set player state
	ld		hl, $FA00		   ;set horizontal speed
	ld		(ix+$16), l
	ld		(ix+$17), h
	ld		hl, $0000		   ;set vertical speed
	ld		(ix+$18), l
	ld		(ix+$19), h

Player_EnterPipe_Return:	;$6F81
	ret


;A == mapping number
LABEL_6F82:
	cp		$F2
	jr		nc, +			   ;jump if mapping >= $F2 (ugz lava block)
	
	cp		$DF				 ;jump if mapping >= $DF & < $F2
	jr		nc, LABEL_6FCE	  ;i.e. the GMZ conveyor belts
	
	cp		$88				 ;return if mapping >= $88 & < $DF
	ret		nc

	cp		$78				 ;jump if mapping >= $78 & < $88
	jr		nc, ++			  ;e.g. springs & spikes

	cp		$70				 ;return if mapping >= $70 & < $78
	ret		nc				  ;i.e. ring blocks

++: cp	  $40				 ;jump if mapping >= $40 & < $70
	jp		nc, LABEL_6FCE

+:  ld	  a, ($D362)		  ;get the block's collision value
	and		$3F
	cp		$20
	call	z, LABEL_7010
	ld		a, ($D358)		  ;get the lo-byte of the vertical position
	and		$1F
	ld		c, a				;c = position on the block
	ld		a, ($D362)		  ;a = collision value
	and		$3F
	add		a, c				;a += c
	cp		$20
	ret		c				   ;return if a < $20
	sub		$20				 ;calculate a projection value 
	ld		c, a
	ld		b, $00
	ld		hl, ($D514)
	xor		a
	sbc		hl, bc
	ld		($D514), hl		 ;adjust the vertical position
	set		1, (ix+$22)		 ;flag the collision
	call	LABEL_6938
	ld		a, ($D100)
	ld		($D363), a
	ret		

LABEL_6FCE:
	bit		7, (ix+$19)
	ret		nz				  ;return if the player is moving up
	ld		a, ($D362)		  ;get vert collision value
	and		$3F
	call	z, LABEL_7010
	res		1, (ix+$22)
	ld		a, (ix+$19)		 ;hi-byte of vertical velocity
	add		a, $09
	ld		b, a
	ld		a, ($D358)		  ;lo-byte of adjusted vert. pos
	and		$1F				 ;calculate current position in block
	ld		c, a
	ld		a, ($D362)		  ;get vert projection value
	add		a, c
	cp		$20
	ret		c
	sub		$20
	cp		b
	ret		nc
	ld		c, a
	ld		b, $00
	ld		hl, ($D514)		 ;adjust vertical pos in level
	xor		a
	sbc		hl, bc
	ld		($D514), hl
	set		1, (ix+$22)
	call	LABEL_6938
	ld		a, ($D100)
	ld		($D363), a
	ret		

;collide with level tiles - set vertical position
LABEL_7010:
	push	bc
	ld		a, ($D12B)	  ;store current frame for later
	push	af
	
	ld		a, :Bank30
	ld		($D12B), a
	ld		($FFFF), a
	
	ld		hl, ($D354)	 ;get address of mapping in level data
	ld		de, ($D16A)	 ;get 2's comp level width in blocks
	add		hl, de		  ;adjust pointer to previous row of blocks
	ld		a, (hl)		 ;get the value of the block
	
	ld		l, a
	ld		h, $00
	add		hl, hl
	ld		de, ($D2D4)	 ;pointer to collision data
	add		hl, de
	
	ld		e, (hl)		 ;get pointer to block's collision data 
	inc		hl
	ld		d, (hl)
	ex		de, hl
	ld		a, (hl)		 ;get block collision data
	
	cp		$82
	jr		z, LABEL_706F
	bit		7, a
	jr		z, LABEL_7066
	
	inc		hl			  ;get speed modifier value
	ld		a, (hl)
	ld		($D100), a
	
	inc		hl			  ;BC = pointer to collision data
	ld		c, (hl)
	inc		hl
	ld		b, (hl)

	ex		de, hl
	ld		a, ($D356)	  ;horizontal position (for collision)
	and		$1F			 ;calculate position on current block
	ld		l, a
	ld		h, $00
	add		hl, bc		  ;get collision data for current position
	ld		a, (hl)
	
	and		$3F
	jr		z, LABEL_7066
	ld		c, a
	ld		b, $00
	ld		h, (ix+$15)	 ;adjust vertical position
	ld		l, (ix+$14)
	xor		a
	sbc		hl, bc
	ld		(ix+$15), h
	ld		(ix+$14), l
LABEL_7066:
	pop		af
	ld		($D12B), a
	ld		($FFFF), a
	pop		bc
	ret		

LABEL_706F:
	inc		hl
	inc		hl
	ld		c, (hl)		 ;read the pointer
	inc		hl
	ld		b, (hl)
	ex		de, hl
	
	ld		a, ($D356)	  ;get horizontal position
	and		$1F			 ;get position in current block
	ld		l, a
	ld		h, $00
	
	add		hl, bc		  ;get collision data for current position
	ld		a, (hl)
	and		$3F
	jr		z, LABEL_7066
	ld		b, a
	add		a, $20
	ld		($D362), a	  ;store vert projection value
	ld		b, a
	jp		LABEL_7066
	
LABEL_708D:
	cp		$88
	ret		nc
	cp		$40
	jp		nc, Engine_Collision_AdjustVerticalPos
	ld		a, ($D362)
	and		$3F
	cp		$20
	call	z, LABEL_7010
	ld		a, ($D358)
	and		$1F
	ld		c, a
	ld		a, ($D362)
	and		$3F
	add		a, c
	cp		$20
	ret		c
	sub		$20
	ld		c, a
	ld		b, $00
	ld		h, (ix+$15)	 ;move the player on the y-axis
	ld		l, (ix+$14)
	xor		a
	sbc		hl, bc
	ld		(ix+$15), h
	ld		(ix+$14), l
	set		1, (ix+$22)
	ret		

Engine_Collision_AdjustVerticalPos:	 ;70C7
	bit		7, (ix+$19)
	ret		nz
	ld		a, ($D362)	  ;vert projection value
	and		$3F
	call	z, LABEL_7010
	
	ld		a, (ix+$19)	 ;hi-byte of vertical velocity
	add		a, $07
	ld		b, a
	
	ld		a, ($D358)	  ;get lo-byte of adjusted vertical position
	and		$1F			 ;get current position on block
	ld		c, a
	ld		a, ($D362)	  ;vert projection value
	add		a, c
	cp		$20
	ret		c
	
	sub		$20			 ;do we need to adjust the vertical
	cp		b			   ;position?
	ret		nc
	
	ld		c, a			;adjust vertical position
	ld		b, $00
	ld		h, (ix+$15)
	ld		l, (ix+$14)
	xor		a
	sbc		hl, bc
	ld		(ix+$15), h
	ld		(ix+$14), l
	set		1, (ix+$22)
	ret		


;****************************************************
;*  Tests for a collision on the X-axis between the *
;*  player object and a level block.				*
;****************************************************
Player_CheckHorizontalLevelCollision:	   ;$7102
	ld		hl, $D522
	res		2, (hl)		 ;clear "right-edge collision" flag
	res		3, (hl)		 ;clear "left-edge collision" flag
;first check for a collision at the left edge of the player object
;then check the right edge
	call	Player_CheckHorizontalLevelCollision_Left
	
	ld		bc, $000A	   ;check for a collision at the right-hand
	ld		de, $FFF4	   ;edge of the player
	call	Engine_GetCollisionDataForBlock
	ld		a, ($D35E)
	cp		$81	 ;solid block
	jr		z, Player_CollideRightWithSolidBlock
	cp		$0A	 ;horizontal spring
	jr		z, Player_CollideRightWithSolidBlock
	cp		$05	 ;spikes
	jp		z, Player_CollideRightWithSpikeBlock
	cp		$8D	 ;breakable block
	jp		z, Player_CollideRightBreakableBlock
	cp		$13	 ;SEZ tubes
	jp		z, Player_CollideHorizontalWithPipeBlock
	ret		

;************************************************************
;*  Handle a collision with a pipe block (e.g. ALZ2 or SEZ) *
;************************************************************
Player_CollideHorizontalWithPipeBlock:	  ;$7130
	ld		a, ($D353)	  ;copy current block value
	ld		($D367), a	  ;here
	jp		Player_EnterPipe


;************************************************************
;*  Handle a collision with a solid (or horizontal spring)  *
;*  block at the right-edge of the player object.		   *
;************************************************************
Player_CollideRightWithSolidBlock:  ;$7139
	ld		a, ($D356)		;get adjusted hpos
	and		$1F
	ld		c, a			;c = position on current block
	ld		a, ($D361)
	ld		b, a			;b = horizontal collision value
	and		$3F
	ret		z				;return if collision value == 0
	cp		$20
	jr		z, +
	bit		6, b
	ret		z				;return if value < $40
+:	add		a, c			;collision value += position on block
	cp		$20
	ret		c				;return if result is < $20
	sub		$20
	ld		c, a			;c = object projection value
	ld		b, $00
	ld		hl, ($D511)
	xor		a
	sbc		hl, bc			;subtract the value from the object's hpos
	ld		($D511), hl		;move the object on the X-axis
	set		2, (ix+$22)		;set the "right-edge collision" flag
	call	LABEL_6938
	ld		a, ($D35E)		;get the block surface type
	cp		$0A				;is the block an horizontal spring type?
	ret		nz				;return if block is not an horizontal spring
	
	ld		hl, $FA00		;block is a spring - move player accordingly
	jp		Player_SetState_HorizontalSpring


;********************************************************
;*  Tests for a collision at the player's left edge.	*
;********************************************************
Player_CheckHorizontalLevelCollision_Left:
LABEL_7172:
	ld		bc, $FFF6	   ;check for collision at left-hand
	ld		de, $FFF4	   ;edge of player
	call	Engine_GetCollisionDataForBlock
	ld		a, ($D35E)	  ;get block type
	cp		$81	 ;solid block
	jr		z, Player_CollideLeftSolidBlock
	cp		$0A	 ;horizontal spring
	jr		z, Player_CollideLeftSolidBlock
	cp		$05	 ;spikes
	jp		z, Player_CollideLeftWithSpikeBlock
	cp		$8D	 ;breakable block
	jr		z, Player_CollideLeftBreakableBlock
	cp		$13
	jp		z, Player_CollideHorizontalWithPipeBlock
	ret


;************************************************************
;*  Handle a collision with a solid (or horizontal spring)  *
;*  block at the left-edge of the player object.			*
;************************************************************
Player_CollideLeftSolidBlock:	   ;$7195
	ld		a, ($D356)	  ;get horizontal position
	and		$1F			 ;calculate position on current block
	ld		c, a
	ld		a, ($D361)	  ;get horizontal collision value
	ld		b, a
	and		$3F
	ret		z
	cp		$20
	jr		z, +
	bit		6, b
	ret		nz
+:  cp	  c
	ret		c			   ;return if A < C
	sub		c
	ld		c, a
	ld		b, $00
	ld		hl, ($D511)	 ;get horizontal pos in level
	add		hl, bc		  ;adjust horizontal pos
	ld		($D511), hl
	set		3, (ix+$22)
	call	LABEL_6938
	ld		a, ($D35E)	  ;surface type?
	cp		$0A			 ;check for horizontal spring
	ret		nz
	ld		hl, $0600
	jp		LABEL_3119  ;seems to be identical to subroutine "Player_HitHorizontalSpring"


;****************************************************
;*  Handle a collision with a breakable block at	*
;*  the player's right edge.						*
;****************************************************
Player_CollideRightBreakableBlock:	  ;$71C9
	bit		1, (ix+$03)
	jp		z, Player_CollideRightWithSolidBlock
	ld		a, ($D517)
	bit		7, a
	jr		z, +
	neg		
+:  cp	  $03
	jp		c, Player_CollideRightWithSolidBlock
	ld		hl, ($D516)
	ld		a, h
	cp		$07
	jr		nc, +
	ld		bc, $0040
	add		hl, bc
	ld		($D516), hl
+:  jr	  Player_CollideBreakableBlock_UpdateMappings


;****************************************************
;*  Handle a collision with a breakable block at	*
;*  the player's left edge.						 *
;****************************************************
Player_CollideLeftBreakableBlock:	   ;$71EF
	bit		1, (ix+$03)	 ;check to see if the player is rolling
	jp		z, Player_CollideLeftSolidBlock	 ;not rolling - act as solid block
	
	ld		a, ($D517)
	bit		7, a			;check player's direction
	jr		z, +
	neg		;negate value if player moving left
+:  cp	  $03			 ;check player's speed
	jp		c, Player_CollideLeftSolidBlock	 ;not fast enough - act as solid
	ld		hl, ($D516)
	ld		a, h
	neg		
	cp		$07
	jr		nc, Player_CollideBreakableBlock_UpdateMappings
	ld		bc, $FFC0
	add		hl, bc
	ld		($D516), hl


;****************************************************
;*  Updates the level layout mappings after a	   *
;*  collision with a breakable block.			   *
;****************************************************
Player_CollideBreakableBlock_UpdateMappings:	;$7215
	ld		a, ($D162)	  ;load bank with 32x32 mappings
	call	Engine_SwapFrame2
	ld		a, $FD		  ;the block value to replace with
	ld		hl, ($D354)	 ;address of current block in layout data
	ld		(hl), a		 ;replace the value in the layout
	
	ld		l, a
	ld		h, $00
	add		hl, hl
	
	ld		a, ($D164)	  ;get pointer to mappings
	ld		c, a
	ld		a, ($D165)
	ld		b, a
							;calculate the mapping pointer
	add		hl, bc		  ;for the current block (i.e. $FD)
	
	ld		e, (hl)		 ;update the block in VRAM
	inc		hl
	ld		d, (hl)
	call	Engine_UpdateMappingBlock
	
	ld		hl, ($D356)	 ;get the collision hpos
	ld		a, l
	and		$E0			 ;calculate the x-coord of the block
	ld		l, a			;involved in the collision
	ld		($D35A), hl	 ;and store here

	ld		hl, ($D358)	 ;get the collision vpos
	ld		a, l
	and		$E0			 ;calculate the y-coord of the block
	ld		l, a			;involved in the collision
	ld		($D35C), hl	 ;and store here


;****************************************************
;*  Create the block fragment objects that are	  *
;*  displayed after a collision with a breakable	*
;*  block.										  *
;****************************************************
Engine_CreateBlockFragmentObjects:	  ;$7248
	ld		c, $04
	ld		a, ($D353)	  ;get block type
	cp		$F7
	jr		nz, +
	ld		c, Object_BlockFragment2		;create the block fragment objects
+:  ld	  h, $00
	call	Engine_AllocateObjectHighPriority
	ld		h, $01
	call	Engine_AllocateObjectHighPriority
	ld		h, $02
	call	Engine_AllocateObjectHighPriority
	ld		h, $03
	jp		Engine_AllocateObjectHighPriority


;********************************************************
;*  Handle a collision between the player's right edge  *
;*  and a spike block that points either up or down.	*
;********************************************************
Player_CollideRightWithSpikeBlock	   ;$7267
	ld		a, ($D353)	  ;get the block type
	and		$FE
	cp		$F2
	jr		z, +
	;check to see if the player is riding the mine cart.
	;the spike blocks act as breakable blocks if the
	;collision occurred while riding the minecart.
	ld		a, ($D502)
	cp		PlayerState_InMineCart
	jp		z, Player_CollideRightBreakableBlock
	
	cp		PlayerState_Hurt
	ret		z			   ;return if the player is hurt
	
+:  call	Player_CollideRightWithSolidBlock   ;spikes act like a solid block
	call	LABEL_6938
	
	ld		a, ($D353)	  ;get the block type
	cp		$F4			 ;check for a collision with left-facing spikes
	ret		nz			  ;return if not block type $F4
	jp		Player_CollideSpikeBlock_PlayerHurt


;********************************************************
;*  Handle a collision between the player's left edge   *
;*  and a spike block that points either up or down.	*
;********************************************************
Player_CollideLeftWithSpikeBlock:	   ;$728A
	ld		a, ($D353)	  ;get the block type
	and		$FE
	cp		$F2
	jr		z, +
	;check to see if the player is riding the mine cart.
	;the spike blocks act as breakable blocks if the
	;collision occurred while riding the minecart.
	ld		a, ($D502)	  ;current player state
	cp		PlayerState_InMineCart
	jp		z, Player_CollideLeftBreakableBlock
	
	cp		PlayerState_Hurt
	ret		z			   ;return if player is hurt

+:  call	Player_CollideLeftSolidBlock	;spikes act like a solid block
	call	LABEL_6938

	ld		a, ($D353)	  ;get the block type
	cp		$F5			 ;check for a collision with right-facing spikes
	ret		nz			  ;return if not block type $F5

;************************************************
;*  Player collided with spikes - cause damage. *
;************************************************
Player_CollideSpikeBlock_PlayerHurt:	;$72AA
	bit		7, (ix+$03)
	ret		nz
	ld		hl, $0100
	ld		($D518), hl
	jp		Player_SetState_Hurt


;****************************************************
;*  Tests for a collision on between the top of the *
;*  player object and a level block.				*
;****************************************************
Player_CheckTopLevelCollision:		  ;$72B8
	bit		1, (ix+$22)
	ret		nz
	res		0, (ix+$22)
	ld		bc, $0000	   ;check for collision at top edge
	ld		de, $FFE8	   ;of player object
	call	Engine_GetCollisionDataForBlock
	ld		a, ($D35E)	  ;get block type
	cp		$81	 ;solid block
	jr		z, Player_CollideTopSolidBlock
	cp		$8D	 ;breakable block
	jp		z, Player_CollideBreakableBlock_UpdateMappings
	cp		$15	 ;vertical spring on ceiling
	jp		z, Player_CollideTopVerticalSpring
	cp		$13	 ;SEZ/ALZ pipes
	jp		z, Player_CollideVerticalWithPipeBlock
	cp		$05	 ;spike block
	jp		z, Player_CollideTopWithSpikeBlock
	ret		


;************************************************************
;*  Handle a collision with a solid block at the top-edge   *
;*  of the player object.								   *
;************************************************************
Player_CollideTopSolidBlock:	;$72E6
	ld		a, ($D358)	  ;adjusted vertical pos
	and		$1F			 ;get offset on block
	ld		c, a			;c = vert pos on block
	ld		a, ($D362)	  ;get block's vert. heightmap
	ld		b, a
	and		$3F
	ret		z
	cp		$20
	jr		z, +
	bit		6, b
	ret		nz
+:	cp		c
	ret		c
	sub		c
	ld		c, a
	ld		b, $00
	ld		l, (ix+$14)	 ;get sprite's vpos
	ld		h, (ix+$15)
	add		hl, bc		  ;calculate the new vpos
	ld		(ix+$14), l
	ld		(ix+$15), h
	set		0, (ix+$22)
	call	LABEL_6938

LABEL_7314:
	ld		hl, $0100
	ld		($D518), hl
	ret		


;************************************************************
;*  Handle a collision with a downward-facing spring at the *
;*  top edge of the player object.						  *
;************************************************************
Player_CollideTopVerticalSpring:	;$731B
	ld		hl, $0780
	ld		($D518), hl	 ;set player vertical speed
	ld		a, SFX_Spring
	ld		($DD04), a
	jp		Player_SetState_JumpFromRamp


;********************************************************
;*  Handle a collision between the top of the player	*
;*  object and a spike block.						   *
;********************************************************
Player_CollideTopWithSpikeBlock:		;$7329
	ld		a, ($D358)	  ;get lo-byte of adjusted vert pos
	and		$1F
	ld		c, a			;c = object position on block
	
	ld		a, ($D362)	  ;a = vertical collision value
	ld		b, a			;b = vertical collision value
	and		$3F
	ret		z
	
	cp		$20
	jr		z, +
	bit		6, b
	ret		z
+:  cp	  c
	ret		c			   ;return if a < c (player not colliding with block)
	sub		c			   ;calculate number of pixels to move player
	ld		c, a			;BC = projection value
	ld		b, $00
	ld		l, (ix+$14)
	ld		h, (ix+$15)
	add		hl, bc
	ld		(ix+$14), l	 ;move the player out of the collision
	ld		(ix+$15), h
	
	set		0, (ix+$22)	 ;flag a collision at the top of the player
	call	LABEL_6938

	ld		a, (ix+$01)	 ;return if the player is hurt
	cp		PlayerState_Hurt
	ret		z

	ld		a, ($D353)	  ;get current block number
	and		$FE			 ;check to see if the block was one of the
	cp		$F4			 ;wall spikes (mappings 244 & 245)
	jp		z, LABEL_7314
	bit		7, (ix+$03)	 ;check to see if player is invincible
	ret		nz
	jp		Player_SetState_Hurt


;************************************************************
;*  Handle a vertical collision with a pipe block (e.g.	 *
;*  ALZ2 or SEZ)											*
;************************************************************
Player_CollideVerticalWithPipeBlock:		;$736F
	ld		a, ($D353)	  ;copy current block value
	ld		($D367), a	  ;here
	jp		Player_EnterPipe


LABEL_7378:
	ld		bc, $0000
	ld		de, $FFE6
	bit		0, (ix+$07)
	jr		z, +
	ld		de, $FFF0
+:	ld		a, ($D465)		  ;copy the previous collision value.
	ld		($D466), a
	call	Engine_GetCollisionValueForBlock	;collide with background tiles
	ld		($D465), a		  ;store block collision value here
	cp		$07				 ;was the collision with a block of rings?
	jr		z, Player_CollideWithRingBlock
	jp		Logic_ALZ_WaterBounce


;********************************************************
;*  Handles a player-ring block collision. Increments   *
;*  the ring counter and updates the level layout to	*
;*  remove the ring.									*
;********************************************************
Player_CollideWithRingBlock:			;$739A
	ld		a, ($D162)		  ;bank with 32x32 mappings
	call	Engine_SwapFrame2
	ld		a, ($D353)		  ;get the block number
	sub		$70				 ;subtract 112 (ring mappings start at index 112).
	ld		($D352), a		  ;store the ring block number.
	ld		l, a
	ld		h, $00
	add		hl, hl
	add		hl, hl
	ld		de, DATA_7407
	add		hl, de
	ld		a, ($D356)		  ;get lo-byte of adjusted hpos
	rrca	
	rrca	
	rrca	
	rrca	
	and		$01
	ld		c, a
	ld		b, $00
	add		hl, bc
	ld		a, ($D358)		  ;get lo-byte of adjusted vpos
	rrca	
	rrca	
	rrca	
	and		$02
	ld		e, a
	ld		d, $00
	add		hl, de
	ld		a, (hl)
	or		a
	ret		z
	ex		de, hl
	add		hl, bc
	ex		de, hl
	ld		bc, $0020
	add		hl, bc
	ld		a, (hl)
	ld		hl, ($D354)		 ;get address of the 32x32 block
	ld		(hl), a			 ;and change it
	ld		l, a
	ld		h, $00
	add		hl, hl
	ld		a, ($D164)		  ;get pointer to mappings into BC
	ld		c, a
	ld		a, ($D165)
	ld		b, a
	add		hl, bc
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	call	Engine_UpdateMappingBlock
	ld		hl, ($D356)		 ;store copy of adjusted hpos
	ld		($D35A), hl
	ld		hl, ($D358)		 ;store copy of adjusted vpos
	ld		($D35C), hl
	ld		c, Object_RingSparkle   ;display a ring "sparkle"
	ld		h, $00
	call	Engine_AllocateObjectHighPriority
	ld		a, SFX_Ring		 ;play "got ring" sound
	ld		($DD04), a
	jp		IncrementRingCounter

;****************************************************
;* Mapping indices used by the above routine to	 *
;* remove "collected" rings from the level layout   *
;****************************************************
DATA_7407:
.db $FF, $FF, $00, $00
.db $00, $00, $FF, $FF
.db $FF, $00, $00, $FF
.db $00, $FF, $FF, $00
.db $FF, $00, $00, $00
.db $00, $FF, $00, $00
.db $00, $00, $FF, $00
.db $00, $00, $00, $FF
.db $75, $74, $FE, $FE
.db $FE, $FE, $77, $76
.db $77, $FE, $FE, $74
.db $FE, $76, $75, $FE
.db $FE, $FE, $FE, $FE
.db $FE, $FE, $FE, $FE
.db $FE, $FE, $FE, $FE
.db $FE, $FE, $FE, $FE


Logic_ALZ_WaterBounce:	  ;$7447
	ld		a, (CurrentLevel)
	cp		$02				 ;compare to ALZ
	ret		nz
	
	ld		a, ($D353)		  ;get current block value
	or		$01				 ;check for the "water" block
	cp		$8F
	ret		nz
	
	ld		a, ($D466)
	cp		$06
	ret		z
	ld		a, ($D519)		  ;is sonic moving up or down?
	bit		7, a
	jr		nz, +			   ;jump if moving up
	ld		c, $0B			  ;show the splash sprite
	ld		h, $00
	call	Engine_AllocateObjectHighPriority	   ;find an open sprite slot
+:  bit	 1, (ix+$03)		 ;is sonic rolling?
	ret		z
	ld		a, ($D517)		  ;is sonic travelling left or right?
	bit		7, a
	jr		z, +
	neg		
+:  cp	  $03				 ;bail out if sonic's not moving fast enough
	ret		c
	ld		hl, $FD00		   ;set the vertical velocity so that sonic
	ld		($D518), hl		 ;bounces off of the water
	ret		

;read collision attributes for the current mapping
;bc = horizontal position adjustment
;de = vertical position adjustment
Engine_GetCollisionDataForBlock:		;$7481
	ld		a, ($D12B)		  ;save current page for later
	push	af
	
	ld		a, :Bank30
	ld		($D12B), a
	ld		($FFFF), a
	ld		h, (ix+$12)		 ;horizontal pos in level
	ld		l, (ix+$11)
	add		hl, bc			  ;adjust horiz. position
	ld		($D356), hl		 ;store position
	
	sla		l   ;hl *= 2		calculate block on the x-axis
	rl		h
	sla		l   ;hl *= 2
	rl		h
	sla		l   ;hl *= 2
	rl		h
	ld		b, h				;B = abs(hl / 32)
	
	ld		h, (ix+$15)		 ;vertical pos in level
	ld		l, (ix+$14)
	add		hl, de			  ;adjust vertical position
	ld		de, $0012
	add		hl, de
	ld		($D358), hl
	
	sla		l				   ;calculate block on the y-axis
	rl		h
	sla		l
	rl		h
	sla		l
	rl		h
	
	ld		a, h
	add		a, a
	ld		l, a
	ld		h, $00
	ld		de, ($D168)		 ;pointer to the row offsets
	add		hl, de
	ld		e, (hl)			 ;get offset for current row of blocks
	inc		hl
	ld		d, (hl)
	ld		l, b
	ld		h, $00
	add		hl, de
	ld		de, $C001		   ;offset into level layout in work RAM
	add		hl, de
	
	ld		a, h
	and		$F0				 ;make sure we're not overflowing the
	cp		$C0				 ;layout size
	jp		nz, Engine_GetCollisionData_HandleOverflow
	
	ld		($D354), hl		 ;store address of block
	ld		a, (hl)			 ;get the block value...
	ld		($D353), a		  ;...and store here
	
	ld		l, a				;calculate index into collision data
	ld		h, $00
	add		hl, hl
	ld		de, ($D2D4)		 ;get pointer to the collision data
	add		hl, de	  
	ld		e, (hl)			 ;get the pointer for the current block
	inc		hl
	ld		d, (hl)
	ex		de, hl
	
	ld		a, (hl)
	ld		($D35E), a	  ;surface type?
	inc		hl
	ld		a, (hl)
	ld		($D100), a
	inc		hl
	ld		c, (hl)		 ;get first pointer
	inc		hl
	ld		b, (hl)
	
	ex		de, hl
	ld		a, ($D356)	  ;get adjusted horiz. position
	and		$1F			 ;get position on current block
	ld		l, a
	ld		h, $00
	add		hl, bc		  ;offset into the collision data
	ld		a, (hl)
	ld		($D362), a	  ;store block's vertical collision value for this point
	
	ex		de, hl
	inc		hl
	ld		c, (hl)		 ;get second pointer
	inc		hl
	ld		b, (hl)
	ex		de, hl
	
	
	ld		a, ($D358)	  ;get lo-byte of adjusted vertical position
	and		$1F			 ;get current position on block
	ld		l, a
	ld		h, $00
	add		hl, bc		  ;offset into collision data
	ld		a, (hl)
	ld		($D361), a	  ;store horizontal collision value
	
	ex		de, hl
	inc		hl
	ld		c, (hl)		 ;get third pointer...
	inc		hl
	ld		b, (hl)
	ld		($D35F), bc	 ;...and store here.
	
	pop		af			  ;restore previous page
	ld		($D12B), a
	ld		($FFFF), a
	ret		


;****************************************************************
;*	Gets the block type value for the mapping that the object	*
;*	is currently colliding with.								*
;*																*
;*	in	BC		Horizontal position adjustment.					*
;*	in	DE		Vertical position adjustment.					*
;*	out	A		Block type.										*
;*	out	DE		Pointer to mapping's collision data.			*
;*	out	($D353)	Mapping number.									*
;*	out	($D354)	Address of current mapping in level layout.		*
;*	out	($D356)	Adjusted horizontal position.					*
;*	out	($D358)	Adjusted vertical position.						*
;*	out	($D35E)	Block type.										*
;*	destroys	BC, HL											*
;****************************************************************
Engine_GetCollisionValueForBlock:	   ;$752E
	ld		a, ($D12B)		;save current bank number for later
	push	af
	ld		a, :Bank30
	ld		($D12B), a
	ld		($FFFF), a
	
	ld		h, (ix+$12)		;Horizontal position in level
	ld		l, (ix+$11)
	add		hl, bc			;adjust position...
	ld		($D356), hl		;...and store here
	
	sla		l				;calculate current block on
	rl		h				;the x-axis.
	sla		l
	rl		h
	sla		l
	rl		h
	ld		b, h			;B = current block
	
	ld		h, (ix+$15)		;vertical position in level
	ld		l, (ix+$14)
	add		hl, de			;adjust position...
	ld		de, $0012
	add		hl, de
	ld		($D358), hl		;...and store here
	
	sla		l				;calculate current block on
	rl		h				;the y-axis.
	sla		l
	rl		h
	sla		l
	rl		h
	
	ld		a, h			;get the row address offset
	add		a, a			;for the current block
	ld		l, a
	ld		h, $00
	ld		de, ($D168)		;get the pointer to the level's row offsets
	add		hl, de
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	
	ld		l, b			;add the x-axis value
	ld		h, $00
	add		hl, de
	ld		de, $C001		;offset into the level layout data
	add		hl, de			;HL = address of current mapping block
	
	ld		a, h			;make sure we're not overflowing
	and		$F0				;the layout data area
	cp		$C0
	jp		nz, Engine_GetCollisionData_HandleOverflow
	
	ld		($D354), hl		;store address of mapping here
	ld		a, (hl)
	ld		($D353), a		;store mapping value here
	
	ld		l, a
	ld		h, $00
	add		hl, hl
	ld		de, ($D2D4)		;get pointer to collision data
	add		hl, de
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	ld		a, (de)			;get collision value for block...
	ld		($D35E), a		;...and store here

Engine_GetCollisionData_CleanUp:			;$759F
	pop		af				;restore the previous frame
	ld		($D12B), a
	ld		($FFFF), a
	ld		a, ($D35E)		;restore collision value to A
	ret		

Engine_GetCollisionData_HandleOverflow:	 ;$75AA
	ld		hl, $CFFF		;store as address of block
	ld		($D354), hl
	ld		a, $FF			;store as value of block
	ld		($D353), a
	ld		a, $00			;store as collision value
	ld		($D35E), a
	ld		a, $00			;FIXME: pointless opcode
	ld		($D361), a		;store horizontal collision value
	ld		($D362), a		;store vertical collision value
	jp		Engine_GetCollisionData_CleanUp

;--------------------------------------------

;gets called when player is hurt
LABEL_75C5:
	res		1, (ix+$22)		;reset the "bottom collision" flag
	ld		bc, $0000
	ld		de, $0000
	call	Engine_GetCollisionDataForBlock	;collide with level tiles
;FIXME: this routine expects A to contain the mapping number but
;Engine_GetCollisionDataForBlock returns the current bank number 
;in the A register. Is this a bug or deliberate?
	call	LABEL_708D
	ld		a, ($D35E)		;get block type value
	and		$7F
	add		a, a			;calculate a jump based on the
	ld		l, a			;block type
	ld		h, $00
	ld		de, DATA_75E7
	add		hl, de
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	ex		de, hl
	jp		(hl)
	
DATA_75E7:
.dw LABEL_7614
.dw LABEL_7613
.dw LABEL_7613
.dw LABEL_763E
.dw LABEL_763E
.dw LABEL_763E
.dw LABEL_763E
.dw LABEL_763E
.dw LABEL_763E
.dw LABEL_763E
.dw LABEL_763E
.dw LABEL_763E
.dw LABEL_763E
.dw LABEL_763E
.dw LABEL_763E
.dw LABEL_763E
.dw LABEL_763E
.dw LABEL_763E
.dw LABEL_7613
.dw LABEL_763E
.dw LABEL_763E
.dw LABEL_763E

LABEL_7613:
	ret

LABEL_7614:
	bit		0, (ix+$03)
	ret		nz
	set		4, (ix+$03)
	ret		

LABEL_761E:	 ;seems to be unused
	bit		1, (ix+$22)		;test for a collision at the bottom edge
	ret		z				;return if no collision
	ld		hl, $FF00	   
	ld		a, ($D353)		;get the current mapping number
	cp		$F0				;check for the conveyor belt block (240)
	jr		z, +

	ld		hl, $0100

+:  ld		e, (ix+$11)		;adjust the object's hpos
	ld		d, (ix+$12)
	add		hl, de
	ld		(ix+$11), l
	ld		(ix+$12), h
	ret		

LABEL_763E:
	ret		


;************************************************************
;* Load a level's tileset (both background and sprites).	*
;************************************************************
Engine_LoadLevelTiles:	 ;763F
	di
	call	ClearVRAM   
	ld		a, (CurrentLevel)	;calculate the offset of the tileset header.
	ld		b, a
	add		a, a
	add		a, b
	ld		b, a
	ld		a, (CurrentAct)
	add		a, b
	ld		l, a
	ld		h, $00
	ld		c, a
	ld		b, $00
	add		hl, hl
	add		hl, hl
	add		hl, hl
	xor		a
	sbc		hl, bc
	ld		de, LevelTilesets
	add		hl, de
	push	hl
	pop		iy
	ld		a, (iy+0)		;bank number
	call	Engine_SwapFrame2
	ld		l, (iy+1)		;VRAM address
	ld		h, (iy+2)
	call	VDP_SetVRAMPointer
	ld		l, (iy+3)		;tile source
	ld		h, (iy+4)
	xor		a
	call	LoadTiles
	ld		l, (iy+5)		;pointer to tileset entries
	ld		h, (iy+6)
	push	hl
	pop		iy
-:	ld		a, (iy+0)		;bank number/indexed tile flag
	cp		$FF				;continue until we reach an $FF byte
	ret		z
	
	and		LastBankNumber		;get the bank number and page it in
	call	Engine_SwapFrame2

	ld		l, (iy+1)			;VRAM address
	ld		h, (iy+2)
	di
	call	VDP_SetVRAMPointer	  ;set the VRAM pointer
	ld		l, (iy+3)	   ;tile source
	ld		h, (iy+4)
	ld		a, (iy+0)	   ;indexed tile flag
	and		$80
	call	LoadTiles	   ;decompress & copy the tiles to VRAM
	ld		bc, $0005	   ;move to the next tileset entry
	add		iy, bc
	jr		-



LoadLevelPalette:	   ;$76AD
	ld		a, (CurrentLevel)
	ld		b, a
	add		a,  a
	add		a, b
	ld		b, a
	ld		a, (CurrentAct)
	add		a, b
	ld		l, a
	ld		h, $00
	add		hl, hl
	ld		de, LevelPaletteValues
	add		hl, de
	ld		a, (hl)			 ;change palettes
	ld		(BgPaletteIndex), a
	inc		hl
	ld		a, (hl)
	ld		(FgPaletteIndex), a
	ld		hl, BgPaletteControl	;fade both palettes to colour.
	ld		(hl), $00
	set		7, (hl)
	inc		hl
	inc		hl
	ld		(hl), $00
	set		7, (hl)
	ret

;******************************************
;* Loads the level select font into VRAM.
;******************************************
LevelSelect_LoadFont:	   ;76D7
	di
	ld		a, :Bank09				 ;Page in the bank containing the font
	call	Engine_SwapFrame2	  
	ld		hl, $2400				  ;Prepare to write to VRAM Address $2400
	call	VDP_SetVRAMPointer
	ld		hl, Art_LevelSelect_Font
	xor		a
	call	LoadTiles				  ;Load tiles into VRAM
	ret


TitleCard_LoadTiles:		;76EB
	di
	ld		a, :Bank09
	call	Engine_SwapFrame2
	ld		hl, $2000	   ;set up to write to VRAM at $2000
	call	VDP_SetVRAMPointer
	ld		hl, Art_TitleCard_Text_Tiles
	xor		a
	call	LoadTiles
	ld		hl, $3020	   ;set up to write to VRAM at $3020
	call	VDP_SetVRAMPointer
	ld		hl, Art_TitleCard_Unknown
	xor		a
	call	LoadTiles
	ld		hl, $30C0	   ;set up to write to VRAM at $30C0
	call	VDP_SetVRAMPointer
	ld		hl, Art_TitleCard_Unknown2
	xor		a
	call	LoadTiles
	ld		a, :Bank07
	call	Engine_SwapFrame2
	ld		hl, $1000
	call	VDP_SetVRAMPointer
	ld		hl, Art_Scrolling_Text_Background
	xor		a
	call	LoadTiles
	ld		a, (GameState)	  ;check to see if we need to display the score card
	bit		2, a
	jp		z, ScoreCard_LoadMappings
	ld		a, :Bank25		  ;load the level picture
	call	Engine_SwapFrame2
	ld		hl, $0000
	call	VDP_SetVRAMPointer
	ld		a, (CurrentLevel)	   ;which level do we need the picture for?
	add		a, a					;calcuate the offset into the pointer array
	add		a, a
	ld		l, a
	ld		h, 0
	ld		de, TitleCard_PicturePointers
	add		hl, de
	ld		e, (hl)	 ;get the pointer to the mappings
	inc		hl
	ld		d, (hl)
	push	de
	inc		hl		  ;get the pointer to the tiles
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	ex		de, hl
	xor		a
	call	LoadTiles	   ;load the tiles into VRAM
	pop		de			  ;load the mappings into VRAM
	ld		bc, $0810
	ld		hl, $3B90
	call	Engine_LoadCardMappings
	ret


TitleCard_PicturePointers:
_DATA_7761:
;   Mappings
;	  |   Tiles
;  |------|-----|
;.dw $B806, $8000
;.dw $B906, $89A0
;.dw $BA06, $9410
;.dw $BB06, $9DC0
;.dw $BC06, $A446
;.dw $BD06, $AC26
;.dw $BE06, $B0A6

.dw UGZ_Title_Pic_Mappings, UGZ_Title_Pic_Art
.dw SHZ_Title_Pic_Mappings, SHZ_Title_Pic_Art
.dw ALZ_Title_Pic_Mappings, ALZ_Title_Pic_Art
.dw GHZ_Title_Pic_Mappings, GHZ_Title_Pic_Art
.dw GMZ_Title_Pic_Mappings, GMZ_Title_Pic_Art
.dw SEZ_Title_Pic_Mappings, SEZ_Title_Pic_Art
.dw CEZ_Title_Pic_Mappings, CEZ_Title_Pic_Art

GameOverScreen_LoadTiles:   ;777D
	di
	ld		a, :Bank15				 ;switch to bank 15
	call	Engine_SwapFrame2
	ld		hl, $2000				  ;write to VRAM at $2000
	call	VDP_SetVRAMPointer
	ld		hl, GameOverScreen_Data_GameOverTiles
	xor		a
	call	LoadTiles				  ;load the art
	ret

;Used by end of game sequence?
ContinueScreen_LoadTiles:   ;7791
	di
	ld		a, :Bank15
	call	Engine_SwapFrame2
	ld		hl, $2000
	call	VDP_SetVRAMPointer
	ld		hl, ContinueScreen_Data_ContinueTiles
	xor		a
	call	LoadTiles
	ret

ContinueScreen_LoadNumberTiles:	 ;77A5
	di
	ld		a, :Bank15
	call	Engine_SwapFrame2
	ld		hl, $2240
	call	VDP_SetVRAMPointer
	ld		hl, ContinueScreen_Data_NumberTiles
	xor		a
	call	LoadTiles
	ret

ScoreCard_LoadMappings:	 ;77B9
	ld		hl, $3B90
	ld		de, DATA_2D98
	ld		bc, $0205
	call	Engine_LoadCardMappings
	ld		hl, $3C10
	ld		de, DATA_2DAC
	ld		bc, $0205
	call	Engine_LoadCardMappings
	ld		hl, $3C90
	ld		de, DATA_2DC0
	ld		bc, $0205
	call	Engine_LoadCardMappings
	ld		hl, $3BA8
	ld		de, DATA_2DD4
	ld		bc, $0604
	call	Engine_LoadCardMappings
	call	LABEL_1D4F
	call	LABEL_1D60
	call	LABEL_1D6F
	ret
	
LABEL_77F3_16:
ClearVRAM:
	;reset contents of VRAM.
	di
	call	_VDP_Set_Register_1_flags_0_to_5
	ld		hl, $0000
	ld		de, $0000
	ld		bc, $0400
	call	VDP_SetVRAMPointer
-:	ld		a, e
	out		($BE), a
	out		($BE), a
	out		($BE), a
	out		($BE), a
	out		($BE), a
	out		($BE), a
	out		($BE), a
	out		($BE), a
	out		($BE), a
	out		($BE), a
	out		($BE), a
	out		($BE), a
	out		($BE), a
	out		($BE), a
	out		($BE), a
	out		($BE), a
	dec		bc
	ld		a, b
	or		c
	jr		nz, -
	call	SetDisplayVisible
	ret

LABEL_782D_12:
ClearPaletteRAM:
	di
	;write to VRAM at address $C000
	ld		hl, $C000
	;write $0 to VRAM
	ld		de, $0000
	;loop 32 times
	ld		bc, $0020
	call	VDP_WriteToVRAM
	ret


/**************************************************************************
			START OF PLC HANDLER CODE
***************************************************************************/
.def PatternLoadCue		$D3AB   ;PLC index
.def PLC_BankNumber		$D3AC   ;Bank number to load tile data from
.def PLC_VRAMAddr		$D3B0   ;Destination VRAM address
.def PLC_SourceAddr		$D3AE   ;Source ROM address (in bank 2 - i.e. >$8000)
.def PLC_ByteCount		$D3AD   ;Number of bytes to copy
.def PLC_Descriptor		$D3B2   ;pointer to current PLC descriptor


Engine_HandlePLC:	   ;$783B
	ld		a, (PatternLoadCue)
	or		a
	ret		z						;return if the PLC is zero

	ld		a, (PLC_BankNumber)		;jump if the bank is zero (load boss,
	or		a						;chaos emeralds or monitors).
	call	z, Engine_HandlePLC_NoBank

	ld		a, (PatternLoadCue)		;the PLC NoBank handler may have changed
	or		a						;the PatternLoadCue variable so we need to
	ret		z						;check it again.

	ld		a, (PLC_ByteCount)		;if byte count is zero load from a PLC
	or		a						;descriptor (address of which stored at $D3B2)
	call	z, Engine_HandlePLC_ParseDescriptor

	di		;no interrupts - we're accessing VRAM here

	ld		a, (PLC_BankNumber)		;if the msb of the bank number is set we 
	bit		7, a					;need to mirror the tile horizontally
	jr		nz, Engine_HandlePLC_CopyMirrored


	call	Engine_SwapFrame2		;swap the correct bank into page 2
	ld		hl, (PLC_VRAMAddr)
	call	VDP_SetVRAMPointer		;set the VRAM pointer
	ld		hl, (PLC_SourceAddr)
	ld		a, (PLC_ByteCount)		;check for >0 bytes
	or		a
	jp		z, Engine_HandlePLC_CleanUp ;bail out if nothing to do
	cp		$04
	jr		c, +
	ld		a, $04					;copy 4 bitplanes
+:	ld		b, a
--:	ld		c, $20					;do this 32 times
-:	ld		a, (hl)					;get a byte from the source...
	out		($BE), a				;...and copy to VRAM.
	inc		hl
	dec		c
	jp		nz, -
	djnz	--

LABEL_7881:
	ei

	ld		(PLC_SourceAddr), hl	;hl points to next tile. Store as new SourceAddr.
	ld		hl, (PLC_VRAMAddr)
	ld		bc, $0080
	add		hl, bc					;calculate offset of next tile in VRAM...
	ld		(PLC_VRAMAddr), hl		;...and store as new VRAMAddr

	ld		a, (PLC_ByteCount)
	sub		$04
	ld		(PLC_ByteCount), a		;subtract 4 bytes from ByteCount
	ret		nc						;return if >= 0

	xor		a
	ld		(PLC_ByteCount), a		;reset ByteCount to 0
	ret

;takes the tile data and, in effect "flips" it horizontally
;on the fly to create a mirrored sprite
Engine_HandlePLC_CopyMirrored:		;$789D
	and		LastBankNumber			;cap bank number
	call	Engine_SwapFrame2

	ld		hl, (PLC_VRAMAddr)		;set the VRAM pointer
	call	VDP_SetVRAMPointer

	ld		hl, (PLC_SourceAddr)

	ld		a, (PLC_ByteCount)		;make sure that bytecount > 0
	or		a
	jr		z, Engine_HandlePLC_CleanUp

	cp		$04				;loop a minimum of 4 times
	jr		c, +
	ld		a, $04

+:	ld		b, a			;b = number of tiles to copy

							;set up to load data from $100 onwards
	ld		d, Data_TileMirroringValues >> 8

--:	ld		c, $20			;loop 32 times (copy one tile)

-:	ld		e, (hl)			;get the index stored at HL
	ld		a, (de)			;index into data at $100
	out		($BE), a		;copy value to VRAM
	inc		hl				;move to next index address
	dec		c
	jp		nz, -			;copy next byte

	djnz	--				;copy next tile

	jp		LABEL_7881
	
;load monitor, chaos emerald or boss tiles
Engine_HandlePLC_NoBank:	;$78CA
	ld		a, (PatternLoadCue)

	cp		$10			 ;if PLC < 10, load monitor art
	jp		c, Engine_HandlePLC_MonitorArt

	cp		$20			 ;if PLC >= 20, load chaos emerald
	jp		nc, Engine_HandlePLC_ChaosEmerald

	sub		$10			 ;PLC between 0 and $10
	add		a, a			;load end-of-level art (boss/signpost)
	ld		l, a
	ld		h, $00
	ld		de, PLC_EndOfLevelPatterns
	add		hl, de
	ld		e, (hl)		 ;get a pointer to the pattern descriptor
	inc		hl
	ld		d, (hl)
	ld		(PLC_Descriptor), de

	jp		Engine_HandlePLC_ParseDescriptor		;FIXME: why bother with this?

;parse a PLC descriptor and set the variables in RAM
Engine_HandlePLC_ParseDescriptor:   ;$78EB
	ld		hl, (PLC_Descriptor)

	ld		a, (hl)				 ;check for the $FF terminator byte
	cp		$FF
	jr		z, Engine_HandlePLC_CleanUp

	ld		(PLC_BankNumber), a	 ;Store bank number
	inc		hl
	ld		a, (hl)
	ld		(PLC_ByteCount), a	  ;store the byte count
	inc		hl
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	ld		(PLC_VRAMAddr), de	  ;destination VRAM address
	inc		hl
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	ld		(PLC_SourceAddr), de	;source address
	inc		hl
	ld		(PLC_Descriptor), hl	;store pointer to next descriptor in chain
	ret		

Engine_HandlePLC_CleanUp:	   ;$7910
	xor		a
	ld		(PatternLoadCue),a
	ld		($D3AC),a
	ld		(PLC_ByteCount),a
	ld		hl, $0000
	ld		(PLC_VRAMAddr),hl
	ld		(PLC_SourceAddr),hl
	ret		

;PLC descriptor chains for end-of-level events
PLC_EndOfLevelPatterns:	 ;$7924
.dw PLC_EOL_PrisonCapsule		   ; $3A, $79  ;End of boss level part1
.dw PLC_EOL_PrisonCapsuleAnimals	; $41, $79  ;End of boss level part2
.dw PLC_EOL_SignPost				; $48, $79  ;End-of-level signpost
.dw PLC_EOL_GMZ_Boss				; $4F, $79  ;GMZ Boss
.dw PLC_EOL_SHZ_Boss				; $5C, $79  ;SHZ Boss
.dw PLC_EOL_ALZ_Boss				; $63, $79  ;ALZ Boss
.dw PLC_EOL_GHZ_Boss				; $70, $79  ;GHZ boss
.dw PLC_EOL_UGZ_Boss				; $77, $79  ;UGZ boss
.dw PLC_EOL_SEZ_Boss				; $7E, $79
.dw PLC_EOL_Unknown_2			   ; $8B, $79
.dw PLC_EOL_Unknown_3			   ; $8C, $79


;   Bank	 VRAM Address	   Terminator
;	 | Count	 |	 ROM Addr.   |
;  |----|----|---------|---------|----|
;   $aa, $bb, $cc, $cc, $dd, $dd, $FF

PLC_EOL_PrisonCapsule:
.db :Art_Prison_Capsule
	.db $46
	.dw $0C40
	.dw Art_Prison_Capsule
.db $FF ;End of boss prison capsule

PLC_EOL_PrisonCapsuleAnimals:   ;End of boss prison capsule animals
.db :Art_Animals
	.db $30
	.dw $1500
	.dw Art_Animals
.db $FF

PLC_EOL_SignPost:	   ;End-of-level signpost
.db :Art_Signpost
	.db $64
	.dw $0C40
	.dw Art_Signpost
.db $FF

PLC_EOL_GMZ_Boss:
.db :Art_GMZ_Boss
	.db $4A
	.dw $0C40
	.dw Art_GMZ_Boss
.db :Art_GMZ_Boss + $80	 ;mirror the tiles
	.db $4A
	.dw $1580
	.dw Art_GMZ_Boss
.db $FF ;$794A - GMZ Boss

PLC_EOL_SHZ_Boss:
.db :Art_SHZ_Boss
	.db $6E
	.dw $0C40
	.dw Art_SHZ_Boss	;$8940
.db $FF	 ;$795C - SHZ Boss

PLC_EOL_ALZ_Boss:
.db :Art_ALZ_Boss
	.db $4C
	.dw $0C40
	.dw Art_ALZ_Boss
.db :Art_ALZ_Boss + $80	 ;mirror the tiles
	.db $4C
	.dw $15C0
	.dw Art_ALZ_Boss
.db $FF	 ;$7963 - ALZ Boss

PLC_EOL_GHZ_Boss:	   ;$7970 - GHZ Boss
.db :Art_GHZ_Boss
	.db $96
	.dw $0C40
	.dw Art_GHZ_Boss	;$A080
.db $FF

PLC_EOL_UGZ_Boss:	   ;$7977 - UGZ Boss
.db :Art_Boss_UGZ
	.db $6A
	.dw $0C40
	.dw Art_Boss_UGZ	;$A102
.db $FF

PLC_EOL_SEZ_Boss:
.db :Art_SilverSonic
	.db $44
	.dw $0C40
	.dw Art_SilverSonic
.db :Art_SilverSonic + $80	  ;mirror the tiles
	.db $44
	.dw $14C0
	.dw Art_SilverSonic
.db $FF

PLC_EOL_Unknown_2:
.db $FF

PLC_EOL_Unknown_3:
.db :Art_Tails
	.db $48
	.dw $0C40
	.dw Art_Tails   ;$B48A
.db $FF


Engine_HandlePLC_ChaosEmerald:  ;$7993
	di		;Disable interrupts - we're accessing VRAM

	ld		a, :Bank20
	call	Engine_SwapFrame2	   ;swap in bnak 20

	ld		a, (PatternLoadCue)	 ;subract 20 from PLC value and calculate
	sub		$20					 ;an offset into the pointer array
	add		a, a
	ld		l, a
	ld		h, $00
	ld		de, ChaosEmeraldData

	add		hl, de
	ld		e, (hl)				 ;get the source address
	inc		hl
	ld		d, (hl)
	ex		de, hl
	ld		de, $0A80			   ;VRAM address
	ld		bc, $0080			   ;byte count
	call	VDP_CopyToVRAM

	ei		;enable interrupts
	jp		Engine_HandlePLC_CleanUp

.include "src\chaos_emerald_pointers.asm"


Engine_HandlePLC_MonitorArt:	;$79C7
	di		;Disable interrupts - we're accessing VRAM

	ld		a, :Bank07			  ;swap in bank 7
	call	Engine_SwapFrame2

	ld		a, (PatternLoadCue)	 ;calculate an offset into the pointer array
	add		a, a
	ld		l, a
	ld		h, $00
	ld		de, Monitor_Art_Pointers-2
	add		hl, de

	ld		e, (hl)				 ;source address
	inc		hl
	ld		d, (hl)
	ex		de, hl
	ld		de, $0A80			   ;VRAM destination
	ld		bc, $00C0			   ;byte count
	call	VDP_CopyToVRAM

	ei		;enable interrupts
	jp		Engine_HandlePLC_CleanUp

Monitor_Art_Pointers:	   ;$79E9
.dw Art_Monitor_0
.dw Art_Monitor_1
.dw Art_Monitor_2
.dw Art_Monitor_3
.dw Art_Monitor_4
.dw Art_Monitor_5
.dw Art_Monitor_6
.dw Art_Monitor_7
.dw Art_Monitor_8


/**************************************************************************
			END OF PLC HANDLER CODE
***************************************************************************/


LevelTilesets:			;$79FB
.include "src\zone_tilesets.asm"



LevelPaletteValues:		;$7CAD
.db $0E, $09
.db $0E, $09
.db $0E, $09
;shz
.db $0F, $05
.db $10, $06
.db $0F, $05
;alz
.db $11, $07
.db $12, $08
.db $11, $07
;ghz
.db $13, $04
.db $13, $04
.db $13, $04

.db $14, $0A
.db $14, $0A
.db $14, $0A

.db $15, $0B
.db $15, $0B
.db $15, $0B

.db $16, $0C
.db $16, $0C
.db $17, $0D

.db $24, $25
.db $24, $25
.db $24, $25

.db $16, $0C
.db $16, $0C
.db $17, $0D

.db $1A, $18
.db $1B, $19
.db $1B, $19



Engine_UpdateCyclingPalettes:	  ;$7CE9
	;check to see if we have palettes that should cycle
	ld		a, (BgPaletteControl)
	or		a
	ret		nz
	ld		iy, $D4A6  ;first cycling palette index
	ld		b, $02	 ;update 2 cycling palettes
-:	push	bc
	call	UpdateCyclingPaletteBank
	ld		bc, $0008
	add		iy, bc
	pop		bc
	djnz	-
	ret

UpdateCyclingPaletteBank:	   ;$7D01
	ld		a, (iy+0)  ;get palette index number
	add		a, a
	ld		l, a
	ld		h, $00
	ld		de, UpdateCyclingPalette_JumpVectors
	add		hl, de
	ld		e, (hl)
	inc		hl
	ld		d, (hl)
	ex		de, hl
	jp		(hl)


;Jump vectors to code that updates a specific cycling palette
UpdateCyclingPalette_JumpVectors:
.dw UpdateCyclingPalette_DoNothing
.dw UpdateCyclingPalette_DoNothing2
.dw UpdateCyclingPalette_Rain			;SHZ2 rain palette
.dw UpdateCyclingPalette_SHZ_Lightning	;SHZ2 lightning
.dw UpdateCyclingPalette_Lava			;UGZ lava palette
.dw UpdateCyclingPalette_Water			;ALZ water palette
.dw UpdateCyclingPalette_Unknown2
.dw UpdateCyclingPalette_Conveyor		;GMZ conveyor & wheel palette
.dw UpdateCyclingPalette_Orb			;CEZ1 orb palette
.dw UpdateCyclingPalette_Lightning		;CEZ3 boss lightening palette
.dw UpdateCyclingPalette_Lightning2		;CEZ3 boss lightening palette
.dw UpdateCyclingPalette_WallLighting	;CEZ3 wall lighting
.dw UpdateCyclingPalette_Orb			;CEZ1 orb palette
.dw LABEL_7F46							;ending sequence
.dw LABEL_7F7E
.dw UpdateCyclingPalette_DoNothing

UpdateCyclingPalette_DoNothing:
	ret

LABEL_7D32:
	xor		a	  ;clear the palette indices
	ld		($D4A6), a 
	ld		($D4AE), a
	ld		hl, $0000
	ld		($D397), hl
	ret

UpdateCyclingPalette_DoNothing2:
	ret

;Update the cycling palette for SHZ2's rain
UpdateCyclingPalette_Rain:	  ;$7D41
	inc		(iy+$03)
	ld		a, (iy+$03)
	cp		$04
	ret		c
	ld		(iy+$03), $00
	ld		a, (iy+$02)
	inc		a
	cp		$03
	jr		c, $01
	xor		a
	ld		(iy+$02), a
	add		a, a
	add		a, (iy+$02)
	ld		e, a
	ld		d, $00
.IFEQ Version 2.2
	ld		hl, $AECA
.ELSE
	ld		hl, DATA_B30_AF4A
.ENDIF
	add		hl, de
	ld		de, $D4CA
	ld		bc, $0003
	ldir
	ld		a, $FF
	ld		(PaletteUpdatePending), a
	ret

;unknown palette. gets called in SHZ2
UpdateCyclingPalette_SHZ_Lightning:	 ;$7D73
	inc		(iy+$03)
	ld		a, (iy+$03)
	cp		$78
	ret		c
	inc		(iy+$02)
	ld		a, $3C
	ld		bc, $330F
	bit		1, (iy+$02)
	jr		nz, $02
	ld		a, $10
	ld		bc, $1010
	ld		hl, $D4D1
	ld		(hl),a
	ld		a, $FF
	ld		(PaletteUpdatePending),a
	ld		a, (iy+$02)
	cp		$10
	ret		c
	ld		(iy+$03), $00
	ld		(iy+$02), $00
	ret

;Update the cycling palette for UGZ's lava
UpdateCyclingPalette_Lava:	  ;$7DA7
	inc		(iy+$03)
	ld		a, (iy+$03)
	cp		$08
	ret		c	  ;update every 8th frame
	ld		(iy+$03), $00
	ld		a, (iy+$02)
	inc		a
	cp		$03
	jr		c, +
	xor		a	  ;reset counter
+:	ld		(iy+$02), a
	add		a, a
	add		a, (iy+$02)
	ld		e, a
	ld		d, $00
.IFEQ Version 2.2
	ld		hl, $AEC1
.ELSE
	ld		hl, DATA_B30_AF41
.ENDIF
	add		hl, de
	ld		de, $D4D3  ;update 3 colours in CRAM
	ld		bc, $0003
	ldir	
	ld		a, $FF
	ld		(PaletteUpdatePending), a
	ret
	
;update the cycling palette for ALZ's water
UpdateCyclingPalette_Water:	 ;$7DD9
	inc		(iy+$03)
	ld		a, (iy+$03)
	cp		$08
	ret		c
	ld		(iy+$03), $00
	ld		a, (iy+$02)
	inc		a
	cp		$03
	jr		c, $01
	xor		a
	ld		(iy+$02), a
	add		a,a
	add		a, (iy+$02)
	ld		e,a
	ld		d, $00
	ld		hl, DATA_B30_AF53
	add		hl, de
	ld		de, $D4D3
	ld		bc, $0003
	ldir	
	ld		a, $FF
	ld		(PaletteUpdatePending), a
	ret		

;Update the GMZ conveyor belt and wheel palette
UpdateCyclingPalette_Conveyor:	  ;$7E0B
	inc		(iy+$03)
	ld		a, (iy+$03)
	cp		$04
	ret		c
	ld		(iy+$03), $00
	ld		a, (iy+$02)
	inc		a
	cp		$03
	jr		c, $01
	xor		a
	ld		(iy+$02), a
	add		a,a
	add		a, (iy+$02)
	ld		e, a
	ld		d, $00
	ld		hl, DATA_B30_AF5C
	add		hl, de
	ld		de, $D4D3
	ld		bc, $0003
	ldir
	ld		a, $FF
	ld		(PaletteUpdatePending), a
	ret

UpdateCyclingPalette_Unknown2:	  ;$7E3D
	inc		(iy+$03)
	ld		a, (iy+$03)
	cp		$04
	ret		c
	ld		(iy+$03), $00
	ld		a, (iy+$02)
	inc		a
	cp		$0C
	jr		c, $01
	xor		a
	ld		(iy+$02), a
	add		a, a
	ld		e, a
	ld		d, $00
	ld		hl, DATA_B30_AF65
	add		hl, de
	ld		de, $D4D1
	ld		bc, $0002
	ldir	
	ld		a, $FF
	ld		(PaletteUpdatePending), a
	ret

;Update the CEZ3 wall lights
UpdateCyclingPalette_WallLighting:	  ;$7E6C
	inc		(iy+$03)
	ld		a, (iy+$03)
	cp		$04
	ret		c
	ld		(iy+$03), $00
	ld		a, (iy+$02)
	inc		a
	cp		$06
	jr		c, $01
	xor		a
	ld		(iy+$02), a
	ld		e, a
	ld		d, $00
	ld		hl, DATA_B30_AF7D
	add		hl, de
	ld		a, (hl)
	ld		de, $D4CA
	ld		(de), a
	ld		a, $FF
	ld		(PaletteUpdatePending), a
	ret

;update the CEZ1 orb cycling palette
UpdateCyclingPalette_Orb:	   ;$7E97
	inc		(iy+$03)
	ld		a, (iy+$03)
	cp		$04
	ret		c
	ld		(iy+$03), $00
	ld		a, (iy+$02)
	inc		a
	cp		$0e
	jr		c, $01
	xor		a
	ld		(iy+$02), a
	add		a, a
	ld		e, a
	ld		d, $00
	ld		hl, DATA_B30_AF83
	add		hl, de
	ld		de, $D4D3
	ld		bc, $0002
	ldir	
	ld		a, $FF
	ld		(PaletteUpdatePending), a
	ret

;Update palette for CEZ3 boss lightening
UpdateCyclingPalette_Lightning:	 ;$7EC6
	inc		(iy+$03)
	ld		a, (iy+$03)
	cp		$02
	ret		c
	ld		(iy+$03), $00
	ld		a, (iy+$02)
	inc		a
	cp		$03
	jr		c, $01
	xor		a
	ld		(iy+$02), a
	add		a, a
	add		a, a
	add		a, a
	add		a, a
	ld		e, a
	ld		d, $00
	ld		hl, DATA_B30_AF9F
	add		hl, de
	ld		de, WorkingCRAM
	ld		bc, $0010
	ldir
	ld		a, $FF
	ld		(PaletteUpdatePending), a
	ret

;Update palette for CEZ3 boss lightning (part 2)
UpdateCyclingPalette_Lightning2:		;$7EF8
	ld		hl, DATA_B30_AF9F
	ld		de, WorkingCRAM
	ld		bc, $0010
	ldir
	ld		a, $FF
	ld		(PaletteUpdatePending), a
	ld		(iy+$00), $00
	ld		(iy+$03), $00
	ld		(iy+$02), $00
	ret

UpdateCyclingPalette_ScrollingText:	 ;$7F15
	ld		a, ($D12F)		;get the frame counter
	and		$03
	ret		nz

	ld		a, ($D12B)		;save current bank so that we can swap it back in later
	push	af
	ld		a, :Bank30
	call	Engine_SwapFrame2

	ld		hl, DATA_B30_AFCF

	ld		a, ($D12F)			;use the frame counter to alternate
	bit		2, a				;the palettes
	jr		z, +

	ld		hl, DATA_B30_AFD5	;copy the palette to working copy of CRAM

+:	ld		de, WorkingCRAM + $09
	ld		bc, $0006
	ldir

	ld		a, $FF		  ;flag for a VRAM palette update
	ld		(PaletteUpdatePending), a

	pop		af			  ;page the previous bank bank in
	ld		($D12B), a
	ld		($FFFF), a
	ret

LABEL_7F46:	 ;update the palette for the end sequence
	ld		l, (iy+$04)
	ld		h, (iy+$05)
	inc		hl
	ld		(iy+$04), l
	ld		(iy+$05), h
	ld		bc, $0280
	xor		a
	sbc		hl, bc
	ret		c
	ld		(iy+$04), $00
	ld		(iy+$05), $00
	inc		(iy+$02)
	ld		a, (iy+$02)
	cp		$0A
	jr		c, LABEL_7F74
	xor		a
	ld		(iy+$00), a
	ld		(iy+$02), a
	ret

LABEL_7F74:
	add		a, $25		  ;load palette $25
	ld		hl, BgPaletteControl
	set		5, (hl)		 ;reset palette
	inc		hl
	ld		(hl), a
	ret

LABEL_7F7E:
	inc		(iy+$03)
	ld		a, (iy+$03)
	cp		$06
	ret		c
	ld		(iy+$03), $00
	ld		a, (iy+$02)
	inc		a
	cp		$06
	jr		c, $01
	xor		a
	ld		(iy+$02), a
	add		a, a
	ld		e, a
	ld		d, $00
	ld		hl, DATA_B30_AFDB
	add		hl, de
	ld		a, (hl)
	ld		($D4CF), a
	inc		hl
	ld		a, (hl)
	ld		($D4D5), a
	ld		a, $FF
	ld		($D4EA), a
	ret


;****************************************
;*	Updates a level's ring art in VRAM	*
;****************************************
Engine_AnimateRingArt:		;$7FAE
	ld		a, ($D12F)		;update the ring art every 7th frame
	and		$07
	ret		nz

	ld		a, ($D351)		;increase the ring art frame number
	inc		a
	cp		$06				;max of 6 frames
	jr		c, +
	
	xor		a				;reset the art frame number

+:	ld		($D351), a		;get the ring art frame number
	add		a, a			;calculate the offset from the source address
	add		a, a
	add		a, a
	add		a, a
	add		a, a
	ld		l, a
	ld		h, $00
	add		hl, hl
	add		hl, hl
	ld		de, (RingArt_SrcAddress)
	add		hl, de
	
	ld		de, (RingArt_DestAddress)

	ld		a, d				;return if destination == 0
	or		e
	ret		z

	ld		a, :Bank29			;page in the bank with the ring art
	ld		($FFFF), a
	ld		a, e				;prepare to write to VRAM at DestAddress
	out		($BF), a
	ld		a, d
	or		$40
	out		($BF), a		
	ld		b, $80				;write $80 bytes from HL
	ld		c, $BE				;to port $BE
	otir
	ret



.ORG $3FF0	  ;offset within current bank

ROM_HEADER:				;$7FF0
.db "TMR SEGA" 
.db $00, $00			;reserved
.IFEQ Version 1.0
	.db $99, $5F		;checksum
.ELSE
	.db $6C, $9E
.ENDIF
.db $15, $90			;product code
.IFEQ Version 1.0
	.db $00				;version
.ELSE
	.db $01
.ENDIF
.db $40			 ;region code/rom size


;===========================================================================
;   Bank 02 - Sound Driver
;===========================================================================
.include "src\sound_driver.asm"

;===========================================================================
;   Includes for remaining banks.
;===========================================================================
.include "src\includes\banks.asm"

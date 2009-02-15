;**********************************
;*	Variables
;**********************************
.def	CursorPos	$D2C2
.def	HoldTime	$D46A	;keep a track of how long up/down buttons are held

LevelSelectMenu:
LABEL_A2C:
	di
	call LevelSelect_LoadFont
    call Engine_ClearLevelAttributes
    call Engine_ClearWorkingVRAM
    call Engine_ClearScreen
    ld   a, $01					;tile attributes
    ld   ($D2C7), a
    ld   hl, $3808				;VRAM destination
    ld   de, LevelSelect_Title	;source data
    ld   bc, LevelSelect_DrawEntry1 - LevelSelect_Title	;char count
    call DrawText
	jr   LevelSelect_DrawEntry1

LevelSelect_Title:
.db " - SONIC THE HEDGEHOG - "

LevelSelect_DrawEntry1:
	ld   a, $01
	ld   ($D2C7), a
	ld   hl, $3888
	ld   de, LevelSelect_Entry1
	ld   bc, LevelSelect_DrawEntry2 - LevelSelect_Entry1
	call DrawText
	jr   LevelSelect_DrawEntry2

LevelSelect_Entry1:
.db "UNDER GROUND ZONE  ACT-1"

LevelSelect_DrawEntry2:
	ld   a, $01
	ld   ($D2C7), a
	ld   hl, $38C8
	ld   de, LevelSelect_Entry2
	ld   bc, LevelSelect_DrawEntry3 - LevelSelect_Entry2
	call DrawText
	jr   LevelSelect_DrawEntry3
	
LevelSelect_Entry2:
.db "                   ACT-2"

LevelSelect_DrawEntry3:
	ld   a, $01
	ld   ($D2C7), a
	ld   hl, $3908
	ld   de, LevelSelect_Entry3
	ld   bc, LevelSelect_DrawEntry4 - LevelSelect_Entry3
	call DrawText
	jr   LevelSelect_DrawEntry4
	
LevelSelect_Entry3:
.db	"                   ACT-3"

LevelSelect_DrawEntry4:
	ld   a, $01
	ld   ($D2C7), a
	ld   hl, $3948
	ld   de, LevelSelect_Entry4
	ld   bc, LevelSelect_DrawEntry5 - LevelSelect_Entry4
	call DrawText
	jr   LevelSelect_DrawEntry5
	
LevelSelect_Entry4:
.db "SKY HIGH ZONE      ACT-1"

LevelSelect_DrawEntry5:
	ld   a, $01
	ld   ($D2C7), a
	ld   hl, $3988
	ld   de, LevelSelect_Entry5
	ld   bc, LevelSelect_DrawEntry6 - LevelSelect_Entry5
	call DrawText
	jr   LevelSelect_DrawEntry6
	
LevelSelect_Entry5:
.db "                   ACT-2"

LevelSelect_DrawEntry6:
	ld   a, $01
	ld   ($D2C7), a
	ld   hl, $39C8
	ld   de, LevelSelect_Entry6
	ld   bc, LevelSelect_DrawEntry7 - LevelSelect_Entry6
	call DrawText
	jr   LevelSelect_DrawEntry7

LevelSelect_Entry6:
.db "                   ACT-3"

LevelSelect_DrawEntry7
	ld   a, $01
	ld   ($D2C7), a
	ld   hl, $3A08
	ld   de, LevelSelect_Entry7
	ld   bc, LevelSelect_DrawEntry8 - LevelSelect_Entry7
	call DrawText
	jr   LevelSelect_DrawEntry8

LevelSelect_Entry7:
.db "AQUA LAKE ZONE     ACT-1"

LevelSelect_DrawEntry8:
	ld   a, $01
	ld   ($D2C7), a
	ld   hl, $3A48
	ld   de, LevelSelect_Entry8
	ld   bc, LevelSelect_DrawEntry9 - LevelSelect_Entry8
	call DrawText
	jr   LevelSelect_DrawEntry9

LevelSelect_Entry8:
.db "                   ACT-2"

LevelSelect_DrawEntry9:
	ld   a, $01
	ld   ($D2C7), a
	ld   hl, $3A88
	ld   de, LevelSelect_Entry9
	ld   bc, LevelSelect_DrawEntry10 - LevelSelect_Entry9
	call DrawText
	jr   LevelSelect_DrawEntry10

LevelSelect_Entry9:
.db "                   ACT-3"

LevelSelect_DrawEntry10:
	ld   a, $01
	ld   ($D2C7), a
	ld   hl, $3AC8
	ld   de, LevelSelect_Entry10
	ld   bc, LevelSelect_DrawEntry11 - LevelSelect_Entry10
	call DrawText
	jr   LevelSelect_DrawEntry11
	
LevelSelect_Entry10:
.db "GREEN HILLS ZONE   ACT-1"

LevelSelect_DrawEntry11:
	ld   a, $01
	ld   ($D2C7), a
	ld   hl, $3B08
	ld   de, LevelSelect_Entry11
	ld   bc, LevelSelect_DrawEntry12 - LevelSelect_Entry11
	call DrawText
	jr   LevelSelect_DrawEntry12
	
LevelSelect_Entry11:
.db "                   ACT-2"

LevelSelect_DrawEntry12:
	ld   a, $01
	ld   ($D2C7), a
	ld   hl, $3B48
	ld   de, LevelSelect_Entry12
	ld   bc, LevelSelect_DrawEntry13 - LevelSelect_Entry12
	call DrawText
	jr   LevelSelect_DrawEntry13

LevelSelect_Entry12:
.db "                   ACT-3"

LevelSelect_DrawEntry13:
	ld   a, $01
	ld   ($D2C7), a
	ld   hl, $3B88
	ld   de, LevelSelect_Entry13
	ld   bc, LevelSelect_DrawEntry14 - LevelSelect_Entry13
	call DrawText
	jr   LevelSelect_DrawEntry14
	
LevelSelect_Entry13;
.db "GIMMICK MT. ZONE   ACT-1"

LevelSelect_DrawEntry14:
	ld   a, $01
	ld   ($D2C7), a
	ld   hl, $3BC8
	ld   de, LevelSelect_Entry14
	ld   bc, LevelSelect_DrawEntry15 - LevelSelect_Entry14
	call DrawText
	jr   LevelSelect_DrawEntry15
	
LevelSelect_Entry14:
.db "                   ACT-2"

LevelSelect_DrawEntry15:
	ld   a, $01
	ld   ($D2C7), a
	ld   hl, $3C08
	ld   de, LevelSelect_Entry15
	ld   bc, LevelSelect_DrawEntry16 - LevelSelect_Entry15
	call DrawText
	jr   LevelSelect_DrawEntry16
	
LevelSelect_Entry15:
.db "                   ACT-3"

LevelSelect_DrawEntry16:
	ld   a, $01
	ld   ($D2C7), a
	ld   hl, $3C48
	ld   de, LevelSelect_Entry16
	ld   bc, LevelSelect_DrawEntry17 - LevelSelect_Entry16
	call DrawText
	jr   LevelSelect_DrawEntry17
	
LevelSelect_Entry16:
.db "SCRAMBLED EGG ZONE ACT-1"

LevelSelect_DrawEntry17:
	ld   a, $01
	ld   ($D2C7), a
	ld   hl, $3C88
	ld   de, LevelSelect_Entry17
	ld   bc, LevelSelect_DrawEntry18 - LevelSelect_Entry17
	call DrawText
	jr   LevelSelect_DrawEntry18
	
LevelSelect_Entry17:
.db "                   ACT-2"

LevelSelect_DrawEntry18:
	ld   a, $01
	ld   ($D2C7), a
	ld   hl, $3CC8
	ld   de, LevelSelect_Entry18
	ld   bc, LevelSelect_DrawEntry19 - LevelSelect_Entry18
	call DrawText
	jr   LevelSelect_DrawEntry19
	
LevelSelect_Entry18:
.db "                   ACT-3"

LevelSelect_DrawEntry19:
	ld   a, $01
	ld   ($D2C7), a
	ld   hl, $3D08
	ld   de, LevelSelect_Entry19
	ld   bc, LevelSelect_DrawEntry20 - LevelSelect_Entry19
	call DrawText
	jr   LevelSelect_DrawEntry20

LevelSelect_Entry19:
.db "CRYSTAL EGG ZONE   ACT-1"

LevelSelect_DrawEntry20:
	ld   a, $01
	ld   ($D2C7), a
	ld   hl, $3D48
	ld   de, LevelSelect_Entry20
	ld   bc, LevelSelect_DrawEntry21 - LevelSelect_Entry20
	call DrawText
	jr   LevelSelect_DrawEntry21

LevelSelect_Entry20:
.db "                   ACT-2"

LevelSelect_DrawEntry21:
	ld   a, $01
	ld   ($D2C7), a
	ld   hl, $3D88
	ld   de, LevelSelect_Entry21
	ld   bc, LevelSelect_DrawEntry22 - LevelSelect_Entry21
	call DrawText
	jr   LevelSelect_DrawEntry22
	
LevelSelect_Entry21:
.db "                   ACT-3"

LevelSelect_DrawEntry22:
	ld   hl, $D4E6
	ld   (hl), $00
	set  7, (hl)
	inc  hl
	ld   (hl), $02
	ld   hl, $D4E8
	ld   (hl), $00
	set  7, (hl)
	inc  hl
	ld   (hl), $02
	ei
	xor  a
	ld   (CursorPos), a
	call LevelSelect_MainLoop
	ld   a, (CursorPos)
	add  a, a
	ld   e, a
	ld   d, $00
	ld   hl, LevelSelect_Values
	add  hl, de
	ld   a, (hl)
	ld   (CurrentLevel), a
	inc  hl
	ld   a, (hl)
	ld   (CurrentAct), a
	ret

LevelSelect_Values:
.db $00, $00	;Under Ground Zone - Act 1
.db $00, $01	;Under Ground Zone - Act 2
.db $00, $02	;Under Ground Zone - Act 3
.db $01, $00	;Sky High Zone - Act 1
.db $01, $01	;Sky High Zone - Act 2
.db $01, $02	;Sky High Zone - Act 3
.db $02, $00	;Aqua Lake Zone - Act 1
.db $02, $01	;Aqua Lake Zone - Act 2
.db $02, $02	;Aqua Lake Zone - Act 3
.db $03, $00	;Green Hills Zone - Act 1
.db $03, $01	;Green Hills Zone - Act 2
.db $03, $02	;Green Hills Zone - Act 3
.db $04, $00	;Gimmick Mt. Zone - Act 1
.db $04, $01	;Gimmick Mt. Zone - Act 2
.db $04, $02	;Gimmick Mt. Zone - Act 3
.db $05, $00	;Scrambled Egg Zone - Act 1
.db $05, $01	;Scrambled Egg Zone - Act 2
.db $05, $02	;Scrambled Egg Zone - Act 3
.db $06, $00	;Crystal Egg Zone - Act 1
.db $06, $01	;Crystal Egg Zone - Act 2
.db $06, $02	;Crystal Egg Zone - Act 3

LevelSelect_MainLoop:	;0E46
	call WaitForInterrupt
	call _CheckInput
	call _DrawCursor
	ld   a, ($D147)
	bit  5, a		;defaults to only allow button 2 on the menu
	;and	 $30	;PATCH: enable both button 1 and 2 on the menu
	jr   z, LevelSelect_MainLoop
	ld   a, $FF
	ld   ($D294), a
	ret

_CheckInput:	;$0E5C
	ld   a, ($D147)
	bit  0, a
	jr   nz, _MoveCursorUp
	bit  1, a
	jr   nz, _MoveCursorDown
	ld   a, ($D137)
	and  $03						;check to see if up/down buttons are held
	jr   z, _ResetCursorVelocity	;nothing held - reset cursor velocity
	ld   a, (HoldTime)
	inc  a
	ld   (HoldTime), a
	cp   $28
	ret  c							;cap cursor velocity at $27
	ld   a, $26
	ld   (HoldTime), a
	ld   a, ($D137)
	bit  0, a
	jr   nz, _MoveCursorUp
	bit  1, a
	jr   nz, _MoveCursorDown
	ret

_ResetCursorVelocity:	;$0E89
	xor  a
	ld   (HoldTime), a
	ret

_MoveCursorUp:
	ld   a, (CursorPos)
	or   a
	ret  z
	dec  a
	ld   (CursorPos), a
	ret

_MoveCursorDown:
	ld   a, (CursorPos)
	cp   $14
	ret  nc
	inc  a
	ld   (CursorPos), a
	ret

_DrawCursor:
	ld   a, (CursorPos)
	ld   l, a				;calculate VRAM address
	ld   h, $00
	add  hl, hl
	add  hl, hl
	add  hl, hl
	add  hl, hl
	add  hl, hl
	add  hl, hl
	ld   de, $3878
	add  hl, de
	ld   de, _TileMappings	;source
	ld   bc, $0301			;rows/cols
	call Engine_LoadCardMappings	;copy to VRAM
	ret

_TileMappings:
;.db $00, $01, $3C, $01, $00, $01
.dw $0100	;tile used above the cursor
.dw $013C	;tile used for the cursor
.dw $0100	;tile used below the cursor
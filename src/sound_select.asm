;================================================
;	Quick and dirty sound test code. Replaces 
;	level select code.
;================================================

;*	Variables
;**********************************
.def	SoundValue	$D2C2
.def	HoldTime	$D46A	;keep a track of how long up/down buttons are held

LevelSelectMenu:
LABEL_A2C:
	di
	call LevelSelect_LoadFont
    call Engine_ClearLevelAttributes
    call Engine_ClearWorkingVRAM			;clear RAM from $D300 -> $DBBF
    call VDP_ClearScreen
    ld   a, $01					;tile attributes
    ld   ($D2C7), a
    ld   hl, $3808				;VRAM destination
    ld   de, _Title				;source data
    ld   bc, $10
    call VDP_DrawText
	jr   SoundTest_DrawEntry1

_Title:
.db " - SOUND TEST - "

SoundTest_DrawEntry1:
	ld   a, $01
	ld   ($D2C7), a
	ld   hl, $3888
	ld   de, SoundTest_Entry1
	ld   bc, SoundTest_DrawEntry2 - SoundTest_Entry1
	call VDP_DrawText
	jr   SoundTest_DrawEntry2

SoundTest_Entry1:
.db "SOUND: "

SoundTest_DrawEntry2:
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
	ld  a, $81
	ld   (SoundValue), a
	call SoundTest_MainLoop
	ret

SoundTest_MainLoop:
	call 	WaitForInterrupt
	call 	_CheckInput
	call 	DrawSoundValue
	ld   	a, ($D147)
	bit		5, a
	jr   	nz, +
	bit		4, a
	jr		z, ++
	ld   	a, (SoundValue)
	ld   	($DD04), a
++:	jr		SoundTest_MainLoop
+:	ret

_CheckInput:
	ld   a, ($D147)
	bit  0, a
	jr   nz, IncreaseSoundValue
	bit  1, a
	jr   nz, DecreaseSoundValue
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
	jr   nz, IncreaseSoundValue
	bit  1, a
	jr   nz, DecreaseSoundValue
	ret

_ResetCursorVelocity:
	xor  a
	ld   (HoldTime), a
	ret

IncreaseSoundValue:
	ld   a, (SoundValue)
	inc  a
	ld   (SoundValue), a
	ret

DecreaseSoundValue:
	ld   a, (SoundValue)
	dec  a
	ld   (SoundValue), a
	ret

DrawSoundValue:
	ld   	a, (SoundValue)
	rrca
	rrca
	rrca
	rrca
	and		$0F
	ld		hl, CHARS
	ld		e, a
	ld		d, $00
	add		hl, de
	ex		de, hl
	ld		hl, $3896
	ld		bc, $0001
	call	VDP_DrawText
	
	ld		a, (SoundValue)
	and		$0F
	ld		hl, CHARS
	ld		e, a
	ld		d, $00
	add		hl, de
	ex		de, hl
	ld		hl, $3898
	ld		bc, $0001
	call	VDP_DrawText
	
	ret

CHARS:
.DB "0123456789ABCDEF"

.orga $0ec3
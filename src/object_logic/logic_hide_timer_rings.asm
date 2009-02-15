;****************************************************
;*	Special Object $06 - Spawned after a boss by 	*
;*	the prison capsule to hide the timer and ring	*
;*	counter.										*
;****************************************************
Logic_HideTimerRings:			;$AF3B
.dw HideTimerRings_State_00
.dw HideTimerRings_State_01

HideTimerRings_State_00:		;$AF3F
.db $01, $00
	.dw HideTimerRings_Init
.db $FF, $00

HideTimerRings_State_01:		;$AF45
.db $80, $00
	.dw HideTimerRings_MoveSprites
.db $FF, $00


;initialiser
HideTimerRings_Init:			;AF4B
	xor     a				;reset level timer update trigger
	ld      ($D2B8), a

	set     1, (ix+$04)
	ld      (ix+$02), $01	;set state = 1
	ret     

HideTimerRings_MoveSprites:		;$AF58
	bit     0, (ix+$07)		;get frame display counter
	ret     z				;return if counter % 2 == 0

	ld      hl, $DB38		;start at the 56th SAT vpos entry
	ld      b, $08			;and work backwards

-:	dec		(hl)			;move the sprite up
	inc     hl				;move to the next sprite entry
	djnz    -

	ld      hl, $DB38		;check the first sprite's vpos attribute
	ld      a, (hl)
	cp      $D8
	ret     nc				;return if the vpos attribute < 216

	ld      (ix+$00), $FF	;destroy this object
	ret

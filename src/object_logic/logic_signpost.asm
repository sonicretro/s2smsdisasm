;****************************************
;*	Logic for the end-of-act signpost.	*
;****************************************
Logic_Signpost:		;$B899
.dw Signpost_State_00
.dw Signpost_State_01
.dw Signpost_State_02
.dw Signpost_State_03
.dw Signpost_State_04
.dw Signpost_State_05

Signpost_State_00:		;$B8A5
.db $01, $00
	.dw Signpost_State_00_Logic_01
.db $FF, $05
	.db $04
.db $FF, $00

Signpost_State_01:		;$B8AE
.db $E0, $01
	.dw Signpost_State_01_Logic_01
.db $FF, $00

Signpost_State_02:		;$B8B4
.db $02, $01
	.dw Signpost_State_02_Logic_01		;calculate which signpost to display
.db $FF, $09
	.db SFX_Tick
.db $02, $02
	.dw Signpost_State_02_Logic_01
.db $02, $03
	.dw Signpost_State_02_Logic_01
.db $FF, $09
	.db SFX_Tick
.db $02, $04
	.dw Signpost_State_02_Logic_01
.db $02, $03
	.dw Signpost_State_02_Logic_01
.db $FF, $09
	.db SFX_Tick
.db $02, $02
	.dw Signpost_State_02_Logic_01
.db $FF, $00

Signpost_State_03:		;$B8D7
.db $FF, $07
	.dw Signpost_State_03_Logic_01	;set frame display count to 7 & copy state from (ix+$1E)
	.dw VF_DoNothing		;does nothing
.db $FF, $07
	.dw Signpost_State_03_Logic_02	;set frame display count to $E0 & copy state from (ix+$1E)
	.dw Signpost_State_03_Logic_03	;Set the player's state & play end of level music
.db $FF, $00

Signpost_State_04:		;$B8E5
.db $01, $00
	.dw Signpost_State_04_Logic_01
.db $FF, $00

Signpost_State_05:		;B8EB
.db $FF, $08
	.db $12
.db $01, $00
	.dw VF_DoNothing
.db $FF, $05		;set state = $01
	.db $01
.db $FF, $00

Signpost_State_04_Logic_01:		;$B8F7
	bit     6, (ix+$04)
	ret     nz
	ld      (ix+$02), $05
	ret     

LABEL_B31_B901:
	ld      a, (CurrentLevel)
	cp      $04
	jr      nz, LABEL_B31_B912
	ld      a, (CurrentAct)
	or      a
	jr      nz, LABEL_B31_B912
	call    VF_Engine_SetMaximumCameraX
	ret     

LABEL_B31_B912:
	call    VF_Engine_SetMinimumCameraX
	ret

Signpost_State_00_Logic_01:		;$B916
	set     7, (ix+$03)
	ret     

Signpost_State_01_Logic_01:		;$B91B
	call    LABEL_B31_B901
	call    VF_Engine_CheckCollision
	ld      a, (ix+$21)
	and     $0f
	ret     z
	xor     a
	ld      ($D2B8), a
	ld      (ix+$02), $02
	ld      a, $FC
	ld      (ix+$19), a
	jp      LABEL_B31_BA23

;calculate which signpost to display
Signpost_State_02_Logic_01:		;$B937
	xor     a
	ld      ($D469), a
	ld      de, $0010
	ld      bc, $0600
	call    VF_Engine_SetObjectVerticalSpeed
	call    VF_Engine_UpdateObjectPosition
	ld      l, (ix+$3C)
	ld      h, (ix+$3D)
	ld      e, (ix+$14)			;get vert position.
	ld      d, (ix+$15)
	xor     a
	sbc     hl, de
	ret     nc
	ld      l, (ix+$3C)
	ld      h, (ix+$3D)
	ld      (ix+$14), l
	ld      (ix+$15), h
	ld      (ix+$02), $03		;set state to $03
	ld      a, $A9
	ld      ($DD04), a
	call    LABEL_B31_B981		;Should we show the Tails signpost?
	jr      c, +
	call    LABEL_B31_B9A0		;Should we show the Sonic signpost?
	jr      c, +
	call    LABEL_B31_B9C2		;Should we show the ring signpost?
	jr      c, +
	ld      b, $06				;signpost art
+:	ld      (ix+$1E), b
	ret     


;************************************************************
;*	If player has same number of lives as when starting act	*
;*	and has 77 rings, show Tails signpost & add 1 continue.	*
;************************************************************
LABEL_B31_B981:
	ld      hl, $D297		;number of lives when starting act
	ld      a, (hl)			;is the player's life count the same as at the start of the act?
	inc     hl
	cp      (hl)
	jr      nz, LABEL_B31_B9F3 	;bail out
	ld      a, ($D299)		;has the player got 77 rings?
	cp      $77
	jr      nz, LABEL_B31_B9F3 	;bail out
	ld      a, ($D2BD)		;add 1 continue
	inc     a
	ld      ($D2BD), a
	ld      a, $02
	ld      ($D2A3), a
	ld      b, $07			;which signpost art?
	scf     
	ret     

;****************************************************
;*	If the player lost 2 lives on this act, show	*
;*	the sonic signpost and increment the life 		*
;*	counter.										*
;****************************************************
LABEL_B31_B9A0:
	ld      hl, $D297		;number of lives when starting act
	ld      a, (hl)			;check to see if the player lost 2 lives
	inc     hl				;on this act
	ld      c, (hl)
	sub     c
	jr      z, LABEL_B31_B9F3 	;bail out
	jr      c, LABEL_B31_B9F3 	;bail out
	cp      $02
	jr      nz, LABEL_B31_B9F3 	;bail out
	ld      a, ($D298)		;add 1 life
	inc     a
	ld      ($D298), a
	ld      a, SFX_ExtraLife
	ld      ($DD04), a
	call    LABEL_200 + $010B
	ld      b, $05			;which signpost art?
	scf     
	ret     

;********************************************************
;*	If the player's ring count is a power of 10, show	*
;*	the ring signpost & add 10 rings to the counter.	*
;********************************************************
LABEL_B31_B9C2:
	ld      a, ($D299)		;check for a multiple of 10 rings.
	and     $0F
	jr      nz, LABEL_B31_B9F3	;bail out
	ld      a, ($D299)		;add 10 rings to the counter
	add     a, $10
	daa     
	ld      ($D299), a
	ld      a, SFX_Ring
	ld      ($DD04), a
	call    LABEL_200 + $010E
	ld      a, ($D299)		;if the ring count wrapped past 99
	or      a				;add 1 life.
	jr      nz, +
	ld      a, ($D298)
	inc     a
	ld      ($D298), a
	ld      a, SFX_ExtraLife
	ld      ($DD04), a
	call    LABEL_200 + $010B
+:  ld      b, $08			;which signpost art?
	scf     
	ret     

LABEL_B31_B9F3:
	scf     
	ccf     
	ret     

Signpost_State_03_Logic_01:		;$B9F6
	ld      (ix+$07), $08	;set frame display count
	ld      a, (ix+$1E)		;set current frame of animation
	ld      (ix+$06), a
	ret     

Signpost_State_03_Logic_02:		;$BA01
	ld      (ix+$07), $E0	;set frame display count
	ld      a, (ix+$1E)		;set current frame of animation
	ld      (ix+$06), a
	ret     

Signpost_State_03_Logic_03:		;$BA0C
	ld      a, ($D501)
	cp      PlayerState_EndOfLevel
	ret     z
	ld      a, ($D503)
	bit     0, a
	ret     nz
	ld      a, PlayerState_EndOfLevel
	ld      ($D502), a
	ld      a, Music_EndOfLevel
	ld      ($DD04), a
	ret     

LABEL_B31_BA23:	;set the camera position
	ld      a, (CurrentLevel)
	add     a, a
	add     a, a
	add     a, a
	ld      e, a
	ld      a, (CurrentAct)
	add     a, a
	add     a, a
	add     a, e
	ld      e, a
	ld      d, $00
	ld      hl, DATA_B31_BA42
	add     hl, de
	ld      c, (hl)
	inc     hl
	ld      b, (hl)
	inc     hl
	ld      e, (hl)
	inc     hl
	ld      d, (hl)
	call    LABEL_200 + $F6		;lock camera & raise up
	ret     

DATA_B31_BA42:
.db $00, $14, $DE, $00
.db $00, $14, $40, $01
.db $00, $0B, $F0, $01
.db $00, $0F, $C8, $00
.db $00, $0F, $E0, $02
.db $00, $08, $50, $00
.db $00, $1F, $E0, $00
.db $00, $1F, $00, $01
.db $00, $00, $E0, $03
.db $00, $0F, $00, $03
.db $00, $04, $00, $00
.db $00, $0F, $1E, $00
.db $00, $14, $40, $01
.db $00, $06, $A0, $01

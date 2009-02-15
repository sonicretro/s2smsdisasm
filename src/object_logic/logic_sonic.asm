Logic_Sonic:		;$A6A6
.dw DATA_B31_A70E		;$00
.dw Sonic_State_01		;$01
.dw Sonic_State_02		;$02
.dw Sonic_State_03
.dw Sonic_State_04
.dw Sonic_State_05
.dw Sonic_State_06
.dw Sonic_State_07
.dw Sonic_State_08
.dw Sonic_State_09
.dw Sonic_State_0A
.dw Sonic_State_0B
.dw DATA_B31_A78E
.dw Sonic_State_0D
.dw Sonic_State_0E
.dw DATA_B31_A819
.dw DATA_B31_A863
.dw DATA_B31_A875
.dw DATA_B31_A87B
.dw DATA_B31_A895
.dw DATA_B31_A8A7
.dw DATA_B31_A8B9
.dw DATA_B31_A8CB
.dw DATA_B31_A8D5
.dw Sonic_State_01
.dw DATA_B31_A71A
.dw DATA_B31_A993
.dw DATA_B31_A772		;$1B
.dw DATA_B31_A788
.dw DATA_B31_A8DD
.dw DATA_B31_A8E5
.dw DATA_B31_A8EB
.dw DATA_B31_A903
.dw DATA_B31_A90B
.dw DATA_B31_A921
.dw DATA_B31_A937
.dw DATA_B31_A953
.dw DATA_B31_A987
.dw DATA_B31_A99D		;$26
.dw DATA_B31_A9B7
.dw DATA_B31_A8F1
.dw DATA_B31_A9D1
.dw DATA_B31_A9D1
.dw DATA_B31_A9D1
.dw DATA_B31_A9E9
.dw DATA_B31_AA09
.dw DATA_B31_AA31
.dw DATA_B31_AB7A
.dw DATA_B31_AB84
.dw DATA_B31_AA97
.dw DATA_B31_AAB1
.dw DATA_B31_AAF6

DATA_B31_A70E:
.db $FF, $02
	.dw LABEL_200 + $66
.db $FF, $03
Sonic_State_01:		;$A714
.db $08, $0A
	.dw VF_Player_HandleStanding
.db $FF, $00

DATA_B31_A71A:
.db $10, $5F
	.dw VF_Player_HandleBalance
.db $10, $60
	.dw VF_Player_HandleBalance
.db $FF, $00

Sonic_State_02:		;$A724
.db $10, $08
	.dw VF_Player_HandleIdle
.db $10, $09
	.dw VF_Player_HandleIdle
.db $FF, $00
DATA_B31_A73E:
.db $FF, $00

Sonic_State_03:		;$A730
.db $06, $0B
	.dw VF_Player_HandleLookUp
.db $FF, $00

Sonic_State_04:		;$A736
.db $06, $10
	.dw VF_Player_HandleCrouched
.db $FF, $00

Sonic_State_05:		;$A73C
.db $FF, $07
	.dw VF_Logic_ChangeFrameDisplayTime
	.dw VF_Player_HandleWalk
.db $FF, $00

Sonic_State_06:		;$A744
.db $04, $0C
	.dw VF_Player_HandleRunning
.db $04, $0D
	.dw VF_Player_HandleRunning
.db $04, $0E
	.dw VF_Player_HandleRunning
.db $04, $0F
	.dw VF_Player_HandleRunning
.db $FF, $00

Sonic_State_07:		;$A756
.db $08, $16
	.dw VF_Player_HandleSkidRight
.db $08, $17
	.dw VF_Player_HandleSkidRight
.db $FF, $00

Sonic_State_08:		;$A760
.db $08, $16
	.dw VF_Player_HandleSkidLeft
.db $08, $17
	.dw VF_Player_HandleSkidLeft
.db $FF, $00

Sonic_State_09:		;$A76A
.db $FF, $07
	.dw VF_Player_CalculateBalanceOnObject
	.dw VF_Player_HandleRolling
.db $FF, $00

DATA_B31_A772:
.db $FF, $07
	.dw VF_Player_CalculateBalanceOnObject
	.dw LABEL_200 + $E1
.db $FF, $00

Sonic_State_0A:		;$A77A
.db $FF, $07
	.dw	VF_Player_CalculateBalanceOnObject
	.dw VF_Player_HandleJumping
.db $FF, $00

Sonic_State_0B:		;$A782
.db $08, $1D
	.dw VF_Player_HandleVerticalSpring
.db $FF, $00

DATA_B31_A788:
.db $08, $1D
	.dw LABEL_200 + $A5
.db $FF, $00

DATA_B31_A78E:		;loop state
.db $FF, $07
	.dw VF_Player_CalculateLoopFrame
	.dw LABEL_200 + $B4
.db $FF, $00


;called when sonic is at bottom of a loop.
;makes sonic move backwards
Sonic_State_0D:		;$A796
.db $03, $01
	.dw VF_Player_SetState_MoveBack
.db $FF, $00

Sonic_State_0E:		;$A79C
.db $08, $01
	.dw VF_Player_HandleFalling
.db $08, $02
	.dw VF_Player_HandleFalling
.db $FF, $09 
	.db SFX_Fall
.db $08, $03
	.dw VF_Player_HandleFalling
.db $08, $04
	.dw VF_Player_HandleFalling
.db $08, $05
	.dw VF_Player_HandleFalling
.db $08, $06
	.dw VF_Player_HandleFalling
.db $08, $01
	.dw VF_Player_HandleFalling
.db $08, $02
	.dw VF_Player_HandleFalling
.db $08, $03
	.dw VF_Player_HandleFalling
.db $08, $04
	.dw VF_Player_HandleFalling
.db $08, $05
	.dw VF_Player_HandleFalling
.db $08, $06
	.dw VF_Player_HandleFalling
.db $08, $01
	.dw VF_Player_HandleFalling
.db	$08, $02
	.dw VF_Player_HandleFalling
.db $08, $03,
	.dw VF_Player_HandleFalling
.db $08, $04
	.dw VF_Player_HandleFalling
.db	$08, $05
	.dw VF_Player_HandleFalling
.db $08, $06
	.dw VF_Player_HandleFalling
.db $08, $01
	.dw VF_Player_HandleFalling
.db $08, $02
	.dw VF_Player_HandleFalling
.db $08, $03
	.dw VF_Player_HandleFalling
.db $08, $04
	.dw VF_Player_HandleFalling
.db $08, $05
	.dw VF_Player_HandleFalling
.db $08, $06
	.dw VF_Player_HandleFalling
.db $08, $01
	.dw VF_Player_HandleFalling
.db	$08, $02
	.dw VF_Player_HandleFalling
.db $08, $03
	.dw VF_Player_HandleFalling
.db $08, $04
	.dw VF_Player_HandleFalling
.db $08, $05
	.dw VF_Player_HandleFalling
.db $08, $06
	.dw VF_Player_HandleFalling
.db $FF, $00

DATA_B31_A819:
.db $06, $4B
	.dw LABEL_200 + $C6
.db $06, $4C
	.dw LABEL_200 + $C6
.db $06, $4D
	.dw LABEL_200 + $C6
.db $06, $4E
	.dw LABEL_200 + $C6
.db $06, $4F
	.dw LABEL_200 + $C6
.db $06, $50
	.dw LABEL_200 + $C6
.db $06, $4B
	.dw LABEL_200 + $C6
.db $06, $4C
	.dw LABEL_200 + $C6
.db $06, $4D
	.dw LABEL_200 + $C6
.db $06, $4E
	.dw LABEL_200 + $C6
.db $06, $4F
	.dw LABEL_200 + $C6
.db $06, $50
	.dw LABEL_200 + $C6
.db $06, $51
	.dw LABEL_200 + $C6
.db $06, $52
	.dw LABEL_200 + $C6
.db $06, $53
	.dw LABEL_200 + $C6
.db $06, $4E
	.dw LABEL_200 + $C6
.db $06, $4F
	.dw LABEL_200 + $C6
.db $06, $50
	.dw LABEL_200 + $C6
.db $FF, $00

DATA_B31_A863:
.db $04, $54
	.dw LABEL_200 + $C9
.db $04, $55
	.dw LABEL_200 + $C9
.db $04, $56
	.dw LABEL_200 + $C9
.db $04, $57
	.dw LABEL_200 + $C9
.db $FF, $00

DATA_B31_A875:
.db $06, $44
	.dw LABEL_200 + $96
.db $FF, $00

DATA_B31_A87B:
.db $06, $42
	.dw LABEL_200 + $9C
.db $06, $43
	.dw LABEL_200 + $9C
.db $06, $44
	.dw LABEL_200 + $9C
.db $06, $45
	.dw LABEL_200 + $9C
.db $06, $46
	.dw LABEL_200 + $9C
.db $06, $47
	.dw LABEL_200 + $9C
.db $FF, $00

DATA_B31_A895:
.db $06, $3F
	.dw LABEL_200 + $93
.db $06, $40
	.dw LABEL_200 + $93
.db $06, $3F
	.dw LABEL_200 + $93
.db $06, $41
	.dw LABEL_200 + $93
.db $FF, $00

DATA_B31_A8A7:
.db $06, $3C
	.dw LABEL_200 + $99
.db $06, $3D
	.dw LABEL_200 + $99
.db $06, $3C
	.dw LABEL_200 + $99
.db $06, $3E
	.dw LABEL_200 + $99
.db $FF, $00

DATA_B31_A8B9:
.db $06, $48
	.dw LABEL_200 + $90
.db $06, $49
	.dw LABEL_200 + $90
.db $06, $48
	.dw LABEL_200 + $90
.db $06, $4A
	.dw LABEL_200 + $90
.db $FF, $00

DATA_B31_A8CB:
.db $08, $58
	.dw LABEL_200 + $D2
.db $FF, $02
	.dw LABEL_200 + $81
.db $FF, $03
DATA_B31_A8D5:
.db $FF, $07
	.dw LABEL_200 + $DB
	.dw LABEL_200 + $D5
.db $FF, $00

DATA_B31_A8DD:
.db $FF, $07
	.dw VF_Player_CalculateLoopFallFrame
	.dw LABEL_200 + $C0
.db $FF, $00

DATA_B31_A8E5:
.db $06, $1B
	.dw LABEL_200 + $8A
.db $FF, $00 

DATA_B31_A8EB:
.db $80, $63
	.dw LABEL_200 + $87
.db $FF, $00

DATA_B31_A8F1:
.db $08, $18
	.dw LABEL_200 + $108
.db $08, $19
	.dw LABEL_200 + $108
.db $FF, $06
	.db $0A
	.dw $0000
	.dw $0000
	.db $03
.db	$FF, $00

DATA_B31_A903:
.db $FF, $07
	.dw LABEL_200 + $F9
	.dw LABEL_200 + $BD
.db $FF, $00

DATA_B31_A90B:
.db $03, $11
	.dw LABEL_200 + $AE
.db $03, $12
	.dw LABEL_200 + $AE
.db $03, $13
	.dw LABEL_200 + $AE
.db $03, $14
	.dw LABEL_200 + $AE
.db $03, $15
	.dw LABEL_200 + $AE
.db $FF, $00

DATA_B31_A921:
.db $03, $11
	.dw LABEL_200 + $A2
.db $03, $12
	.dw LABEL_200 + $A2
.db $03, $13
	.dw LABEL_200 + $A2
.db $03, $14
	.dw LABEL_200 + $A2
.db $03, $15
	.dw LABEL_200 + $A2
.db $FF, $00

DATA_B31_A937:
.db $FF, $04
	.dw $0000
	.dw $0000
.db $03, $11 
	.dw VF_DoNothing
.db $03, $12
	.dw VF_DoNothing
.db $03, $13 
	.dw VF_DoNothing
.db $03, $14
	.dw VF_DoNothing
.db $03, $15 
	.dw VF_DoNothing
.db $FF, $00

DATA_B31_A953:
.db $FF, $04
	.dw $0000
	.dw $0000
.db $FF, $07 
	.dw LABEL_B31_A967
	.dw LABEL_200 + $E7
.db $FF, $07
	.dw LABEL_B31_A96E
	.dw LABEL_200 + $E7
.db $FF, $00


LABEL_B31_A967:
	ld		(ix+$06), $61
	jp		LABEL_B31_A972

LABEL_B31_A96E:
	ld		(ix+$06), $62
LABEL_B31_A972:
	ld		b, $0C
	ld		a, ($D137)
	and		$03
	jr		z, $08
	ld		b, $10
	and		$01
	jr		z, $02
	ld		b, $08
	ld		(ix+$07), b
	ret


DATA_B31_A987:
.db $FF, $09
	.db SFX_BreatheBubble
.db $0C, $1A
	.dw LABEL_200 + $EA
.db $FF, $05 
	.db $0E
.db $FF, $00

/***************************************** */
;FIXME:
;	These commands will execute jumps to	;
;	$1C08 and $00FF which are invalid.		;
;	Check to see if these are used!!		;
/***************************************** */
DATA_B31_A993:
.db $08, $1B
.db $FF, $02
	.db $08, $1C
.db $FF, $02
	.db $FF, $00
/***************************************** */

DATA_B31_A99D:
.db $08, $01
	.dw LABEL_B31_AB34
.db $08, $02
	.dw LABEL_B31_AB34
.db $08, $03
	.dw LABEL_B31_AB34
.db $08, $04
	.dw LABEL_B31_AB34
.db $08, $05
	.dw LABEL_B31_AB34
.db $08, $06
	.dw LABEL_B31_AB34
.db $FF, $00

DATA_B31_A9B7:
.db $08, $01
	.dw LABEL_B31_AB4C
.db $08, $02
	.dw LABEL_B31_AB4C
.db $08, $03
	.dw LABEL_B31_AB4C
.db $08, $04
	.dw LABEL_B31_AB4C
.db $08, $05
	.dw LABEL_B31_AB4C
.db $08, $06
	.dw LABEL_B31_AB4C
.db $FF, $00

DATA_B31_A9D1:
.db $FF, $04 
	.dw $0400
	.dw $0000
.db $04, $0C
	.dw LABEL_B31_AA41
.db $04, $0D
	.dw LABEL_B31_AA41
.db $04, $0E
	.dw LABEL_B31_AA41
.db $04, $0F
	.dw LABEL_B31_AA41
.db $FF, $00

DATA_B31_A9E9:
.db $FF, $04 
	.dw $0100
	.dw $0000
.db $08, $01
	.dw LABEL_B31_AA54
.db $08, $02
	.dw LABEL_B31_AA54
.db $08, $03
	.dw LABEL_B31_AA54
.db $08, $04
	.dw LABEL_B31_AA54
.db $08, $05
	.dw LABEL_B31_AA54
.db $08, $06
	.dw LABEL_B31_AA54
.db $FF, $00

DATA_B31_AA09:
.db $FF, $04 
	.dw $0000
	.dw $0000
.db $FF, $02 
	.dw LABEL_B31_AA37
.db $08, $16
	.dw VF_DoNothing
.db $08, $17
	.dw VF_DoNothing
.db $08, $16
	.dw VF_DoNothing
.db $08, $17
	.dw VF_DoNothing
.db $FF, $02
	.dw LABEL_B31_AA3C
.db $E0, $0B
	.dw VF_DoNothing
.db $E0, $0B
	.dw LABEL_B31_AA6D
.db $FF, $00

DATA_B31_AA31:
.db $E0, $0B
	.dw VF_DoNothing
.db $FF, $00


LABEL_B31_AA37:
	set     4, (ix+$04)
	ret

LABEL_B31_AA3C:
	res     4, (ix+$04)
	ret

LABEL_B31_AA41:
	call    LABEL_B31_AA81
	ld      a, ($D46D)
	cp      $04
	ret     nz
	ld      (ix+$02), $2C
	ld      a, $0A
	ld      ($D702), a
	ret     

LABEL_B31_AA54:
	call    LABEL_B31_AA81
	ld      hl, ($D174)
	ld      de, $0008
	xor     a
	sbc     hl, de
	ld      a, h
	or      l
	ret     nz
	ld      (ix+$02), $2D
	ld      a, $02
	ld      ($D702), a
	ret

LABEL_B31_AA6D:
	ld      bc, ($D174)
	ld      de, $0008
	call    LABEL_200 + $F6
	ld      (ix+$02), $2E
	ld      a, $03
	ld      ($D702), a
	ret

LABEL_B31_AA81
	call    LABEL_200 + $57
	ld      hl, ($D511)
	ld      de, $FF70
	add     hl, de
	ld      a, h
	and     $01
	ld      h, a
	ld      de, $0090
	add     hl, de
	ld      ($D511), hl
	ret     

	
DATA_B31_AA97:
.db $06, $01
	.dw LABEL_B31_AB06
.db $06, $02
	.dw LABEL_B31_AB06
.db $06, $03
	.dw LABEL_B31_AB06
.db $06, $04
	.dw LABEL_B31_AB06
.db $06, $05
	.dw LABEL_B31_AB06
.db $06, $06
	.dw LABEL_B31_AB06
.db $FF, $00

DATA_B31_AAB1:
.db $80, $0B
	.dw VF_DoNothing
.db $80, $0B
	.dw VF_DoNothing
.db $C0, $0B
	.dw VF_DoNothing
.db $C0, $0B
	.dw VF_DoNothing
.db $80, $10
	.dw VF_DoNothing
.db $04, $0A
	.dw VF_DoNothing
.db $08, $10
	.dw VF_DoNothing
.db $04, $0A
	.dw VF_DoNothing
.db $80, $0B
	.dw VF_DoNothing
.db $A0, $0B
	.dw VF_DoNothing
.db $A0, $0A
	.dw VF_DoNothing
.db $80, $0A
	.dw VF_DoNothing
.db $10, $09
	.dw VF_DoNothing
.db $10, $08
	.dw VF_DoNothing
.db $FF, $02
	.dw LABEL_B31_AB00
.db $FF, $05
	.db $33
.db $10, $08
	.dw VF_DoNothing
.db $FF, $00

DATA_B31_AAF6:
.db $10, $09
	.dw VF_DoNothing
.db $10, $08
	.dw VF_DoNothing
.db $FF, $00

LABEL_B31_AB00:
	ld      hl, $D293
	set     4, (hl)
	ret

LABEL_B31_AB06:
	res     4, (ix+$04)
	ld      hl, $0200
	ld      (ix+$16), l
	ld      (ix+$17), h
	ld      hl, $0300
	ld      (ix+$18), l
	ld      (ix+$19), h
	call    LABEL_200 + $60
	call    VF_Engine_UpdateObjectPosition
	ld      l, (ix+$11)
	ld      h, (ix+$12)
	ld      de, $0450
	xor     a
	sbc     hl, de
	ret     c
	ld      (ix+$02), $32
	ret     

LABEL_B31_AB34:
	call    LABEL_B31_AB64
	ld      l, (ix+$14)
	ld      h, (ix+$15)
	ld      de, $0190
	xor     a
	sbc     hl, de
	ret     c
	ld      (ix+$02), $0e
	call    LABEL_200 + $75
	ret     

LABEL_B31_AB4C:
	call    LABEL_B31_AB64
	ld      l, (ix+$14)
	ld      h, (ix+$15)
	ld      de, $0260
	xor     a
	sbc     hl, de
	ret     c
	ld      (ix+$02), $0e
	call    LABEL_200 + $75
	ret     

LABEL_B31_AB64:
	call    VF_Engine_UpdateObjectPosition
	ld      de, $0020
	ld      bc, $0500
	call    VF_Engine_SetObjectVerticalSpeed
	ld      bc, $0000
	ld      (ix+$16), c		;set horizontal speed to 0
	ld      (ix+$17), b
	ret     

DATA_B31_AB7A:
.db $10, $08
	.dw LABEL_B31_ABA2
.db $10, $09
	.dw LABEL_B31_ABA2
.db $FF, $00

DATA_B31_AB84:
.db $FF, $07
	.dw LABEL_B31_AB8C
	.dw	LABEL_B31_ABC6
.db $FF, $00

LABEL_B31_AB8C:
	ld      hl, $D52F
	inc     (hl)
	ld      a, (hl)
	cp      $04
	jr      c, +
	xor     a
	ld      (hl), a
	
+:	add     a, $0C			;set player animation = running
	ld      ($D506), a
	
	ld      a, $04			;set frame display timer
	ld      ($D507), a
	ret     

LABEL_B31_ABA2:
	ld      hl, $0080		;set player's hpos
	ld      ($D511), hl

	ld      hl, $00A0		;set player's vpos
	ld      ($D514), hl

	ld      hl, $0000
	ld      ($D516), hl		;set player's horiz & vert speed to 0
	ld      ($D518), hl

	ld      a, ($D2BD)		;check level timer frame counter
	bit     7, a
	ret     z				;return if value is positive

	ld      (ix+$02), $30
	ld      (ix+$1F), $00
	ret     

LABEL_B31_ABC6:
	inc     (ix+$1F)
	ld      a, (ix+$1F)
	cp      $78
	ret     c
	ld      (ix+$1F), $78
	ld      hl, ($D516)		;player's horizontal speed
	ld      de, $00A0
	add     hl, de
	ld      ($D516), hl
	call    VF_Engine_UpdateObjectPosition
	ret

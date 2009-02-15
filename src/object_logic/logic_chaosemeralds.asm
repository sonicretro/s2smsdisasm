;************************************
;*	Logic for the Chaos Emeralds.	*
;************************************
Logic_ChaosEmerald:			;$B7D2
.dw ChaosEmerald_State_00
.dw ChaosEmerald_State_01
.dw	ChaosEmerald_State_02

ChaosEmerald_State_00:		;$B7D8
.db $E0, $00
	.dw ChaosEmerald_State_00_Logic_01
.db $FF, $00

ChaosEmerald_State_01:		;$B7DE
.db $E0, $01
	.dw ChaosEmerald_State_01_Logic_01
.db $FF, $00

ChaosEmerald_State_02:		;$B7E4
.db $F0, $00
	.dw VF_DoNothing
.db $60, $00
	.dw ChaosEmerald_State_02_Logic_01
.db $FF, $00


ChaosEmerald_State_00_Logic_01:		;$B7EE
	ld      (ix+$02), $01
	ld      a, (CurrentLevel)
	cp      $05
	jr      nz, LABEL_B31_B800
	add     a, $20
	ld      (PatternLoadCue), a
	jr      LABEL_B31_B809

LABEL_B31_B800:
	ld      a, (CurrentLevel)	;calculate which tiles to load
	add     a, $20				;see subroutine at 783B (Engine_LoadSpriteTiles)
	ld      b, a
	call    LABEL_B31_B7BE
LABEL_B31_B809:
	set     7, (ix+$03)
	res     4, (ix+$04)
	set     5, (ix+$04)
	ld      (ix+$08), $00
	ld      a, (CurrentLevel)
	cp      $05
	ret     nz
	ld      hl, $FA00
	ld      (ix+$18), l			;set vertical velocity
	ld      (ix+$19), h
	ret     

ChaosEmerald_State_01_Logic_01:		;$B829
	ld      a, (CurrentLevel)		;calculate the tiles to load
	add     a, $20
	ld      b, a
	call    LABEL_B31_B7BE
	bit     6, (ix+$04)
	ret     nz
	ld      a, (CurrentLevel)
	cp      $05
	call    z, LABEL_B31_B883
	call    VF_Engine_CheckCollision
	ld      a, (ix+$21)
	and     $0f
	ret     z
	ld      (ix+$02), $02
	ld      a, $FF
	ld      ($D2C6), a
	set     1, (ix+$04)
	xor     a
	ld      ($D532), a
	ld      a, (CurrentLevel)
	cp      $05
	jr      z, LABEL_B31_B866
	ld      a, Music_Emerald
	ld      ($DD04), a
	ret     

LABEL_B31_B866:
	ld      a, Music_EndOfLevel
	ld      ($DD04), a
	ld      hl, $D293
	set     4, (hl)
	ret     

ChaosEmerald_State_02_Logic_01:		;$B871
	ld      (ix+$3E), $00
	ld      (ix+$00), $FF
	ld      a, (CurrentLevel)
	cp      $05
	ret     z
	call    VF_Engine_ChangeLevelMusic
	ret     

LABEL_B31_B883:
	call    VF_Engine_CheckCollision
	call    VF_Engine_UpdateObjectPosition
	ld      de, $0040
	ld      bc, $0600
	call    VF_Engine_SetObjectVerticalSpeed
	ld      hl, $0080
	call    LABEL_200 + $12
	ret     

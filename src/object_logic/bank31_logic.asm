.include "src\object_logic\logic_sonic.asm"

.include "src\object_logic\logic_ring_sparkle.asm"

.include "src\object_logic\logic_block_fragment.asm"

DATA_B31_ACEB:
.dw DATA_B31_ACEF
.dw DATA_B31_ACF8

DATA_B31_ACEF:
.db $FF, $09
	.db SFX_BreakBlock
.db $01, $00
	.dw BlockFragment_State_00_Logic_01
.db $FF, $00

DATA_B31_ACF8:
.db $FF, $07
	.dw LABEL_B31_AD00
	.dw BlockFragment_State_01_Logic_01
.db $FF, $00


LABEL_B31_AD00:
	ld      a, (CurrentLevel)
	or      a
	jr      nz, +
	ld      a, $88			;tile index
	ld      (ix+$08), a		;set tile index for right-facing sprite
	ld      (ix+$09), a		;set tile index for left-facing sprite
	ld      a, (ix+$3F)
	ld      (ix+$06), a
	ld      (ix+$07), $80
	ret     

+:	ld      a, (CurrentLevel)		;$AD19
	cp      $04
	jr      nz, +
	ld      a, $F6
	ld      (ix+$08), a
	ld      (ix+$09), a
	ld      a, (ix+$3F)
	ld      (ix+$06), a
	ld      (ix+$07), $80
	ret     

+:	ld      (ix+$00), $ff			;$AD33
	ret     


.include "src\object_logic\logic_speedshoes_stars.asm"


.include "src\object_logic\logic_invincibility_stars.asm"	


.include "src\object_logic\logic_hide_timer_rings.asm"


.include "src\object_logic\logic_dropped_ring.asm"


.include "src\object_logic\logic_air_countdown.asm"


;ALZ air bubbles
.include "src\object_logic\logic_alz_bubble.asm"


.include "src\object_logic\logic_water_splash.asm"


DATA_B31_B513:
.dw DATA_B31_B517
.dw DATA_B31_B51D

DATA_B31_B517:
.db $01, $00
	.dw LABEL_B31_B523
.db $FF, $00

DATA_B31_B51D:
.db $80, $01
	.dw LABEL_B31_B53E
.db $FF, $00


LABEL_B31_B523:
	ld      hl, ($D174)			;copy camera hpos
	ld      (ix+$11), l			;to this object's hpos
	ld      (ix+$12), h

	ld      hl, $0120			;set vpos = 288
	ld      (ix+$14), l
	ld      (ix+$15), h

	ld      (ix+$08), $70		;set vram tile index

	ld      (ix+$02), $01		;set state 01
	ret     

LABEL_B31_B53E:
	inc     (ix+$1F)
	ld      a, (ix+$1F)
	and     $0F
	ld      l, a
	ld      h, $00
	add     hl, hl
	ld      bc, DATA_B31_B590
	add     hl, bc
	ld      c, (hl)
	inc     hl
	ld      b, (hl)

	ld      hl, ($D174)			;get camera hpos
	add     hl, bc
	ld      (ix+$11), l			;set this object's hpos
	ld      (ix+$12), h

	ld      l, (ix+$14)			;copy object's vpos...
	ld      h, (ix+$15)
	ld      ($D4A4), hl			;to the act's water level

	ld      hl, ($D176)			;get camera vpos
	ld      de, $0040			;add 64
	add     hl, de
	ld      de, ($D4A4)			;compare with act's water level
	xor     a
	sbc     hl, de
	jr      nc, LABEL_B31_B584	;jump if camera below water level
	
	dec     hl
	ld      a, h
	cpl     
	ld      h, a
	ld      a, l
	cpl     
	ld      l, a
	
	ld      a, h
	or      a
	jr      nz, LABEL_B31_B58A		
	ld      a, l
	ld      ($D132), a
	ret     

LABEL_B31_B584:
	ld      b, $FF
	ld      ($D132), a
	ret     

LABEL_B31_B58A:
	ld      b, $FF		;FIXME: identical to subroutine at B584
	ld      ($D132), a
	ret     

DATA_B31_B590:
.db $00, $00, $80, $00, $10, $00, $90, $00
.db $20, $00, $A0, $00, $30, $00, $B0, $00
.db $40, $00, $C0, $00, $50, $00, $D0, $00
.db $60, $00, $E0, $00, $70, $00, $F0, $00


;underground zone fireball logic
.include "src\object_logic\logic_ugz_fireball.asm"


;Explosion logic
.include "src\object_logic\logic_explosion.asm"


;Monitor logic
.include "src\object_logic\logic_monitors.asm"


;Emerald logic
.include "src\object_logic\logic_chaosemeralds.asm"


;Signpost logic
.include "src\object_logic\logic_signpost.asm"


Logic_FallingSpike:		;$BA7A
DATA_B31_BA7A:
.dw FallingSpike_State_00
.dw FallingSpike_State_01
.dw FallingSpike_State_02
.dw FallingSpike_State_03
.dw FallingSpike_State_04
.dw FallingSpike_State_05
DATA_B31_BA86:
.dw DATA_B31_BA8A
.dw DATA_B31_BA90

DATA_B31_BA8A:
.db $01, $00
	.dw LABEL_B31_BA96
.db $FF, $00

DATA_B31_BA90:
.db $E0, $02
	.dw LABEL_B31_BB40
.db $FF, $00


LABEL_B31_BA96:
	ld      (ix+$02), $01
	ld      hl, $FF40
	ld      (ix+$16), l
	ld      (ix+$17), h
	ld      hl, $FB80
	ld      (ix+$18), l
	ld      (ix+$19), h
	ret     


FallingSpike_State_00:		;$BAAD
.db $01, $00
	.dw FallingSpike_Init
.db $FF, $00

FallingSpike_State_01:		;$BAB3
.db $E0, $01
	.dw LABEL_B31_BB61
.db $FF, $00

FallingSpike_State_02:		;$BAB9
.db $02, $01
	.dw FallingSpike_CheckCollision
.db $02, $04
	.dw FallingSpike_CheckCollision
.db $02, $01
	.dw FallingSpike_CheckCollision
.db $02, $04
	.dw FallingSpike_CheckCollision
.db $02, $01
	.dw FallingSpike_CheckCollision
.db $02, $04
	.dw FallingSpike_CheckCollision
.db $02, $01
	.dw FallingSpike_CheckCollision
.db $02, $04
	.dw FallingSpike_CheckCollision
.db $FF, $05
	.db $03
.db $FF, $00

FallingSpike_State_03:		;$BADE
.db $04, $01
	.dw LABEL_B31_BB0B
.db $FF, $00

FallingSpike_State_04:		;$BAE4
.db $04, $03
	.dw VF_DoNothing
.db $FF, $06
	.db $1A
	.dw $0000
	.dw	$0000
	.db $00
.db $FF, $05
	.db $05
.db $FF, $00

FallingSpike_State_05:		;$BAF5
.db $E0, $03
	.dw LABEL_B31_BB40
.db $FF, $00


FallingSpike_Init:		;$BAFB
LABEL_B31_BAFB:
	ld      a, (ix+$3F)			;jump if the option byte has been set
	or      a
	jp      nz, LABEL_B31_BB29
	
	ld      (ix+$02), $01		;set state = 01
	ret     


FallingSpike_CheckCollision:		;$BB07
	call    VF_Engine_CheckCollision
	ret     

LABEL_B31_BB0B:
	call    VF_Engine_CheckCollision
	ld      a, (ix+$21)
	and     $0F					;jump if a collision has occurred
	jr      nz, LABEL_B31_BB29

	ld      de, $0050
	ld      bc, $0600
	call    VF_Engine_SetObjectVerticalSpeed
	call    VF_Engine_UpdateObjectPosition
	call    LABEL_200 + $60
	bit     1, (ix+$22)
	ret     z

LABEL_B31_BB29:
	ld      (ix+$02), $04		;set state 04
	
	ld      hl, $00B0			;set horizontal speed = 176
	ld      (ix+$16), l
	ld      (ix+$17), h
	
	ld      hl, $FC00			;set vertical speed = -64
	ld      (ix+$18), l
	ld      (ix+$19), h
	ret

LABEL_B31_BB40:
	ld      de, $0050
	ld      bc, $0600
	call    VF_Engine_SetObjectVerticalSpeed
	call    VF_Engine_UpdateObjectPosition
	bit     6, (ix+$04)
	ret     z
	ld      a, (ix+$3e)
	or      a
	jr      nz, LABEL_B31_BB5C
	ld      (ix+$00), $ff
	ret     

LABEL_B31_BB5C:
	ld      (ix+$00), $FE
	ret     

LABEL_B31_BB61:
	bit     6, (ix+$04)
	ret     nz				;return if object is not visible

	ld      hl, ($D514)		;get player's vpos
	ld      e, (ix+$14)		;get spikes' vpos
	ld      d, (ix+$15)
	xor     a
	sbc     hl, de			;compare player's vpos to spikes' vpos
	ret     c				;return if spikes are below player

	ld      a, h
	or      a
	ret     nz				;return if hi-byte != 0 (not close enough)

	ld      b, l
	srl     b

	ld      de, ($D516)		;get player's horizontal speed

	bit     7, d
	jr      z, +
	dec     de
	ld      a, d
	cpl     
	ld      d, a
	ld      a, e
	cpl     
	ld      e, a
+:	ld      hl, $0180
	xor     a
	sbc     hl, de
	jr      nc, +
	ld      a, b
	add     a, a
	ld      b, a
	ld      hl, $0380
	xor     a
	sbc     hl, de
	jr      nc, +
	ld      a, b
	add     a, b
	ld      b, a
	jr      nc, +
	ld      b, $ff
+:	ld      hl, ($d511)
	ld      e, (ix+$11)
	ld      d, (ix+$12)
	xor     a
	sbc     hl, de
	jr      nc, +
	ex      de, hl
	ld      hl, $0000
	xor     a
	sbc     hl, de
+:	ld      a, h
	or      a
	ret     nz
	ld      a, l
	cp      b
	ret     nc
	ld      (ix+$02), $02
	ld      (ix+$1f), $10
	ret     

DATA_B31_BBC6:
.dw DATA_B31_BBCA
.dw DATA_B31_BBD0

DATA_B31_BBCA:
.db $01, $00
	.dw LABEL_B31_BBD6
.db $FF, $00

DATA_B31_BBD0:
.db $10, $01
	.dw LABEL_B31_BBF9
.db $FF, $00

LABEL_B31_BBD6:
	ld      hl, $0080
	ld      a, r
	and     $f8
	add     a, l
	ld      l, a
	ld      (ix+$11), l
	ld      (ix+$12), h
	ld      hl, $0054
	ld      a, r
	and     $07
	add     a, l
	ld      l, a
	ld      (ix+$14), l
	ld      (ix+$15), h
	ld      (ix+$02), $01
	ret     

LABEL_B31_BBF9:
	call    LABEL_B31_BCA2
	ld      l, (ix+$11)		;get hpos
	ld      h, (ix+$12)
	
	dec     hl
	
	ld      a, ($D12F)		;get frame counter value
	and     $01
	jr      nz, +			;jump if frame counter % 2 != 0
	
	dec     hl
	
+:	ld      (ix+$11), l		;set hpos
	ld      (ix+$12), h
	ret     


Logic_IntroCloudsAndPalette:		;$BC12
.dw IntroCloudsAndPalette_State_00
.dw IntroCloudsAndPalette_State_01

IntroCloudsAndPalette_State_00:		;$BC16
.db $01, $00
	.dw IntroCloudsAndPalette_Init
.db $FF, $00

IntroCloudsAndPalette_State_01:		;$BC1C
.db $10, $01
	.dw LABEL_B31_BC45
.db $FF, $00


IntroCloudsAndPalette_Init:			;$BC22
	ld      hl, $0000		;set a random hpos between $0000 and $00FF
	ld      a, r
	ld      l, a
	ld      (ix+$11), l
	ld      (ix+$12), h

	ld      hl, $004C
	
	push    ix				;BC = IX
	pop     bc
	
	ld      a, c			;Set vpos based on the object's slot
	rrca    
	rrca    
	rrca    
	add     a, l
	ld      l, a
	ld      (ix+$14), l
	ld      (ix+$15), h

	ld      (ix+$02), $01	;set state 01
	ret     

LABEL_B31_BC45:
	call    VF_UpdateCyclingPalette_ScrollingText
	call    LABEL_B31_BCA2
	
	ld      l, (ix+$11)		;get hpos
	ld      h, (ix+$12)
	dec     hl
	ld      a, ($D12F)
	and     $07
	jr      nz, +
	dec     hl
+:	ld      (ix+$11), l
	ld      (ix+$12), h
	ret


;logic for the intro screen tree
Logic_IntroTree:		;$BC61
.dw IntroTree_State_00
.dw IntroTree_State_01

IntroTree_State_00:		;$BC65
.db $01, $00
	.dw IntroTree_Init
.db $FF, $00

IntroTree_State_01:		;$BC6B
.db $10, $01
	.dw IntroTree_AdjustHpos
.db $FF, $00


;state 0 - initialiser. sets hpos to random position
IntroTree_Init:				;$BC71
	ld      hl, $0080			;set the hpos to a random value
	ld      a, r				;between $0080 and $00B0
	and     $30
	add     a, l
	ld      l, a
	ld      (ix+$11), l
	ld      (ix+$12), h

	ld      hl, $007A
	ld      (ix+$14), l
	ld      (ix+$15), h			;set vpos to 122

	ld      (ix+$02), $01		;set state 01
	ret     

IntroTree_AdjustHpos:		;$BC8E
	call    LABEL_B31_BCA2
	ld      l, (ix+$11)
	ld      h, (ix+$12)
	dec     hl
	dec     hl
	dec     hl
	dec     hl
	ld      (ix+$11), l
	ld      (ix+$12), h
	ret     

LABEL_B31_BCA2:
	bit     6, (ix+$04)
	ret     nz					;return if object is not visible
	
	ld      l, (ix+$1A)			;check the object's horizontal position
	ld      h, (ix+$1B)			;on screen and return if it is < $40
	ld      bc, $0040
	xor     a
	sbc     hl, bc
	ret     nc

	ld      l, (ix+$11)			;get object hpos
	ld      h, (ix+$12)
	ld      bc, $00C0			;add a random value between
	ld      a, r				;$00C0 and $00DF to the object's
	and     $1F					;hpos
	add     a, c
	ld      c, a
	add     hl, bc
	ld      (ix+$11), l
	ld      (ix+$12), h

	ret

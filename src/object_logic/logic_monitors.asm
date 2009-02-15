Logic_Monitors:			;$B710
.dw Monitors_State_00
.dw Monitors_State_01
.dw Monitors_State_02


Monitors_State_00:		;$B716
.db $01, $00
	.dw Monitors_State_00_Logic_01
.db $FF, $00


Monitors_State_01:		;$B71C
.db $01, $00
	.dw Monitors_State_01_Logic_01
.db $FF, $00

Monitors_State_02:		;$B722
.db $05, $02
	.dw Monitors_State_02_Logic_01
.db $02, $01
	.dw Monitors_State_02_Logic_01
.db $04, $02
	.dw Monitors_State_02_Logic_01
.db $02, $01
	.dw Monitors_State_02_Logic_01
.db $03, $02
	.dw Monitors_State_02_Logic_01
.db $02, $01
	.dw Monitors_State_02_Logic_01
.db $FF, $00


;Initialiser
Monitors_State_00_Logic_01:		;$B73C
	set     7, (ix+$03)
	ld      (ix+$02), $01		;set state = 1
	ret

;Sets the PLC
Monitors_State_01_Logic_01:		;$B745
	ld      b, (ix+$3F)
	call    LABEL_B31_B7BE
	ld      (ix+$02), $02
	ret

;Handles collisions
Monitors_State_02_Logic_01:		;$B750
	ld      b, (ix+$3F)
	call    LABEL_B31_B7BE
	bit     6, (ix+$04)
	ret     nz
	
	call    VF_Engine_CheckCollisionAndAdjustPlayer
	
	ld      a, ($D503)
	bit     1, a
	ret     z
	
	ld      a, (ix+$21)		;was there a collision?
	and     $0F
	ret     z
	
	cp      $02				;was the collision below the object
	jr      nz, LABEL_B31_B775	;jump if collision above

	ld      hl, $0200		;make player bounce back down
	ld      ($D518), hl		;set player's vertical speed
	ret     


LABEL_B31_B775:
	ld      hl, ($D518)		;get player's vertical speed
	ld      a, l
	or      h
	ret     z				;return if player not moving

	ld      a, h
	and     $80
	ret     nz				;return if player moving up

	call    Monitor_SetCollisionValue
	ld      (ix+$3F), $40	;FIXME: this is done in the Monitor_SetCollisionValue routine.
	
	ld      a, ($D501)		;if current state == $09 display
	cp      $09				;the explosion object
	jp      z, VF_Engine_DisplayExplosionObject

	ld      hl, $FC00		;make player bounce up
	ld      ($D518), hl

	jp      VF_Engine_DisplayExplosionObject


Monitor_SetCollisionValue:		;$B797
	ld      a, (ix+$3F)		;get monitor type
	cp      $0A
	ret     nc				;return if type >= 10

	ld      e, a			;calculate index into array
	ld      d, $00
	ld      hl, Logic_Data_MonitorTypes
	add     hl, de

	ld      a, ($D39D)		;set monitor collision value
	or      (hl)
	ld      ($D39D), a

	ld      (ix+$3F), $00	;set monitor type to $40
	set     6, (ix+$3F)		;FIXME: this could be done in the previous op
	ret     

;collision value for each monitor type
Logic_Data_MonitorTypes:
.db $00		;nothing
.db $00		;nothing
.db $01		;10-rings
.db $02		;extra life
.db $04		;speed shoes
.db $08		;invincibility
.db $10		;extra continue
.db $20
.db $40
.db $00		;nothing


LABEL_B31_B7BE:
	ld      c, (ix+$24)
	ld      a, (ix+$04)
	ld      (ix+$24), a
	bit     6, a
	ret     nz
	bit     6, c
	ret     z
	ld      a, b
	ld      (PatternLoadCue), a	;used by subroutine 783B to decide which tiles to load
	ret     

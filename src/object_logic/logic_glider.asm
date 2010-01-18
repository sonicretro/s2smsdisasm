DATA_B28_8762:
.dw LABEL_B28_876A
.dw LABEL_B28_8770
.dw LABEL_B28_8776
.dw LABEL_B28_877C

LABEL_B28_876A:
.db $01, $00
	.dw LABEL_B28_878E
.db $FF, $00

LABEL_B28_8770:
.db $F0, $01
	.dw LABEL_B28_8793
.db $FF, $00

LABEL_B28_8776:
.db $F0, $00
	.dw LABEL_B28_87B3
.db $FF, $00

LABEL_B28_877C:
.db $08, $01
	.dw LABEL_B28_87EF
.db $08, $02
	.dw LABEL_B28_87EF
.db $08, $03
	.dw LABEL_B28_87EF
.db $08, $04
	.dw LABEL_B28_87EF
.db $FF, $00


LABEL_B28_878E:
	ld      (ix + Object.StateNext), 1
	ret     

LABEL_B28_8793:
    ; check for a collision with the player object
	call    VF_Engine_CheckCollision
	ld      a, (ix + Object.SprColFlags)
	or      a
	ret     z
    
	xor     a
	ld      (ix + Object.SprColFlags), a
	ld      (Player.SprColFlags), a
    
	ld      a, $11
	ld      (Player.StateNext), a
	call    LABEL_200 + $7E
	ld      (ix + Object.StateNext), $02
	set     7, (ix+$04)
	ret     

LABEL_B28_87B3:
    ; set the glider's initial position variables
	call    VF_Engine_MoveObjectToPlayer
	ld      bc, (Player.X)
	ld      de, (Player.Y)
	ld      (ix + Object.InitialX), c
	ld      (ix + Object.InitialX + 1), b
	ld      (ix + Object.InitialY), e
	ld      (ix + Object.InitialY + 1), d
    
    ; make sure that the player is in the correct state
	ld      a, (Player.State)
	cp      $11
	ret     nc
    
    ; set the object's velocity
	ld      hl, (Player.VelX)
	ld      de, -$80
	add     hl, de
	ld      (ix + Object.VelX), l
	ld      (ix + Object.VelX + 1), h
    
	ld      bc, -$100
	ld      (ix + Object.VelY), c
	ld      (ix + Object.VelY + 1), b
    
    ; change to the next state
	ld      (ix + Object.StateNext), 3
	res     7, (ix + Object.Flags04)
	ret

LABEL_B28_87EF:
	ld      l, (ix+$18)
	ld      h, (ix+$19)
	ld      de, $0008
	add     hl, de
	ld      (ix+$18), l
	ld      (ix+$19), h
	jp      VF_Engine_UpdateObjectPosition

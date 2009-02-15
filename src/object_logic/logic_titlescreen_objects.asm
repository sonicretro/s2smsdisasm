Logic_Title_SonicHand:		;$8D97
.dw Title_SonicHand_State_00
.dw Title_SonicHand_State_01

Title_SonicHand_State_00:	;$8D9B
.db $01, $00
	.dw LABEL_B30_8DB3
.db $FF, $00


Title_SonicHand_State_01:	;$8DA1
.db $0C, $01
	.dw LABEL_B30_8DCE
.db $04, $02
	.dw LABEL_B30_8DCE
.db $0C, $03
	.dw LABEL_B30_8DCE
.db $04, $02
	.dw LABEL_B30_8DCE
.db $FF, $00

LABEL_B30_8DB3:
	ld      hl, $0082
	ld      (ix+$11), l
	ld      (ix+$12), h
	ld      hl, $007C
	ld      (ix+$14), l
	ld      (ix+$15), h
	ld      (ix+$08), $10
	ld      (ix+$02), $01
	ret     

LABEL_B30_8DCE:
	ret     


Logic_Title_TailsEye:		;$8DCF
.dw DATA_B30_8DD3
.dw DATA_B30_8DD9

DATA_B30_8DD3:
.db $01, $00
	.dw LABEL_B30_8E0F
.db $FF, $00

DATA_B30_8DD9:
.db $40, $03
	.dw LABEL_B30_8E2A
.db $04, $02
	.dw LABEL_B30_8E2A
.db $04, $01
	.dw LABEL_B30_8E2A
.db $04, $02
	.dw LABEL_B30_8E2A
.db $40, $03
	.dw LABEL_B30_8E2A
.db $02, $02
	.dw LABEL_B30_8E2A
.db $04, $01
	.dw LABEL_B30_8E2A
.db $04, $02
	.dw LABEL_B30_8E2A
.db $04, $03
	.dw LABEL_B30_8E2A
.db $04, $02
	.dw LABEL_B30_8E2A
.db $04, $01
	.dw LABEL_B30_8E2A
.db $04, $02
	.dw LABEL_B30_8E2A
.db $40, $03
	.dw LABEL_B30_8E2A
.db $FF, $00

LABEL_B30_8E0F:
	ld      hl, $009A
	ld      (ix+$11), l
	ld      (ix+$12), h
	ld      hl, $006B
	ld      (ix+$14), l
	ld      (ix+$15), h
	ld      (ix+$08), $2E
	ld      (ix+$02), $01
	ret     

LABEL_B30_8E2A:
	ret

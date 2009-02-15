/****************************************************************
 *	Starting positions for screen & Sonic for each zone/act.	*
 ****************************************************************/

;-------------------------------
;    pointers for each zone
;-------------------------------
LevelLayout_Data_InitPos:		;$5401
.dw LevelLayout_Data_InitPos_UGZ
.dw LevelLayout_Data_InitPos_SHZ
.dw LevelLayout_Data_InitPos_ALZ
.dw LevelLayout_Data_InitPos_GHZ
.dw LevelLayout_Data_InitPos_GMZ
.dw LevelLayout_Data_InitPos_SEZ
.dw LevelLayout_Data_InitPos_CEZ
.dw DATA_543F 
.dw DATA_5445 
.dw DATA_544B


;-------------------------------
;    pointers for each act
;-------------------------------
LevelLayout_Data_InitPos_UGZ:	;$5415
.dw LevelLayout_Data_InitPos_UGZ1
.dw LevelLayout_Data_InitPos_UGZ2
.dw LevelLayout_Data_InitPos_UGZ3

LevelLayout_Data_InitPos_SHZ:	;$541B
.dw LevelLayout_Data_InitPos_SHZ1
.dw LevelLayout_Data_InitPos_SHZ2
.dw LevelLayout_Data_InitPos_SHZ3

LevelLayout_Data_InitPos_ALZ:	;$5421
.dw LevelLayout_Data_InitPos_ALZ1
.dw LevelLayout_Data_InitPos_ALZ2
.dw LevelLayout_Data_InitPos_ALZ3

LevelLayout_Data_InitPos_GHZ:	;$5427
.dw LevelLayout_Data_InitPos_GHZ1
.dw LevelLayout_Data_InitPos_GHZ2
.dw LevelLayout_Data_InitPos_GHZ3

LevelLayout_Data_InitPos_GMZ:	;$542D
.dw LevelLayout_Data_InitPos_GMZ1
.dw LevelLayout_Data_InitPos_GMZ2
.dw LevelLayout_Data_InitPos_GMZ3

LevelLayout_Data_InitPos_SEZ:	;$5433
.dw LevelLayout_Data_InitPos_SEZ1
.dw LevelLayout_Data_InitPos_SEZ2
.dw LevelLayout_Data_InitPos_SEZ3

LevelLayout_Data_InitPos_CEZ:	;$5439
.dw LevelLayout_Data_InitPos_CEZ1
.dw LevelLayout_Data_InitPos_CEZ2
.dw LevelLayout_Data_InitPos_CEZ3

DATA_543F:
.dw DATA_54F9
.dw DATA_54F9
.dw DATA_54F9

DATA_5445:
.dw DATA_5501
.dw DATA_5509
.dw DATA_5511

DATA_544B:
.dw DATA_5519
.dw DATA_5521
.dw DATA_5529



;-------------------------------------
;         The position data
;--------------------------------------
;		,-- Initial cam horiz. offset
;       |       ,- Intial cam vert. offset
;		|		|			,- Initial sprite horiz offset
;		|		|			|		 ,- Initial sprite vert. offset
;  |--------|---------|---------|---------|
;   $00, $00, $30, $00, $88, $00, $A8, $00

LevelLayout_Data_InitPos_UGZ1:	;$5451
.db $00, $00, $30, $00, $88, $00, $A8, $00
LevelLayout_Data_InitPos_UGZ2:	;$5459
.db $00, $00, $70, $00, $84, $00, $08, $01
LevelLayout_Data_InitPos_UGZ3:	;$561
.db $00, $00, $10, $00, $84, $00, $88, $00

LevelLayout_Data_InitPos_SHZ1:	;$5469
.db $00, $00, $DE, $03, $80, $00, $4E, $04
LevelLayout_Data_InitPos_SHZ2:
.db $00, $00, $75, $00, $72, $00, $EE, $00
LevelLayout_Data_InitPos_SHZ3:
.db $00, $00, $20, $00, $80, $00, $A8, $00

LevelLayout_Data_InitPos_ALZ1:	;$5481
.db $00, $00, $E0, $00, $38, $00, $68, $01
LevelLayout_Data_InitPos_ALZ2:	;$5489
.db $00, $00, $18, $00, $88, $00, $A8, $00
LevelLayout_Data_InitPos_ALZ3:	;$5491
.db $00, $00, $30, $00, $48, $00, $A8, $00

LevelLayout_Data_InitPos_GHZ1:	;$5499
.db $00, $00, $80, $00, $70, $00, $08, $01
LevelLayout_Data_InitPos_GHZ2:	;$54A1
.db $00, $00, $E0, $00, $60, $00, $68, $01
LevelLayout_Data_InitPos_GHZ3:	;$54A9
.db $20, $00, $D8, $01, $A0, $00, $68, $02

LevelLayout_Data_InitPos_GMZ1:	;$54B1
.db $00, $00, $B0, $02, $50, $00, $28, $03
LevelLayout_Data_InitPos_GMZ2:	;$54B9
.db $00, $00, $78, $02, $90, $00, $08, $03
LevelLayout_Data_InitPos_GMZ3:	;$54C1
.db $00, $00, $08, $00, $90, $00, $58, $00

LevelLayout_Data_InitPos_SEZ1:	;$54C9
.db $00, $00, $E0, $0A, $90, $00, $68, $0B
LevelLayout_Data_InitPos_SEZ2:	;$54D1
.db $A8, $00, $1E, $02, $24, $01, $AE, $02
LevelLayout_Data_InitPos_SEZ3:	;$54D9
.db $00, $00, $B8, $0D, $78, $00, $48, $0E

LevelLayout_Data_InitPos_CEZ1:	;$54E1
.db $00, $00, $38, $00, $88, $00, $C8, $00
LevelLayout_Data_InitPos_CEZ2:	;$54E9
.db $70, $00, $9E, $07, $F4, $00, $2E, $08
LevelLayout_Data_InitPos_CEZ3:	;$54F1
.db $00, $00, $38, $00, $88, $00, $C8, $00

DATA_54F9
.db $00, $00, $00, $01, $B0, $00, $70, $01

DATA_5501
.db $80, $00, $00, $00, $80, $00, $80, $00
DATA_5509
.db $80, $00, $00, $00, $80, $00, $80, $00
DATA_5511
.db $80, $00, $00, $00, $80, $00, $80, $00

DATA_5519
.db $00, $00, $2C, $00, $70, $00, $8C, $00
DATA_5521
.db $00, $00, $2C, $00, $80, $00, $8C, $00
DATA_5529
.db $00, $00, $2C, $00, $80, $00, $8C, $00

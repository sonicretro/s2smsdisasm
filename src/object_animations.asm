;=============================================
;	Pointers to object animation sequences.
;	Used by routine at $60AC.
;=============================================
ObjectAnimations:
.dw DATA_B31_87A3
.dw DATA_B31_80C0			;$01 - Sonic
.dw DATA_B31_85D1			;$02 - Ring sparkle
.dw DATA_B31_85EF			;$03 - Speed shoes stars
.dw DATA_B31_8793			;$04 - Block fragments
.dw DATA_B31_85EF			;$05 - Invincibility stars
.dw DATA_B31_87A3			;$06
.dw DATA_B31_87A5			;$07
.dw DATA_B31_87DF			;$08
.dw DATA_B31_8821			;$09
.dw DATA_B31_8877			;$0A
.dw DATA_B31_88DD			;$0B
.dw DATA_B31_88FB			;$0C
.dw DATA_B31_890C			;$0D
.dw DATA_B31_892C			;$0E
.dw AnimData_Explosion		;$0F - Explosion
.dw AnimData_Monitors		;$10 - Monitors
.dw AnimData_Monitors
.dw AnimData_Monitors
.dw AnimData_Monitors
.dw DATA_B31_89AE
.dw DATA_B31_89BF
.dw DATA_B31_89BF
.dw DATA_B31_8A34
.dw DATA_B31_9615
.dw DATA_B31_8AA1
.dw DATA_B31_8AB8
.dw DATA_B31_8AB8
.dw DATA_B31_8AF1
.dw DATA_B31_8B02
.dw DATA_B31_8B12
.dw DATA_B31_8B2A
.dw DATA_B31_8B62
.dw DATA_B31_8B62
.dw DATA_B31_8B62
.dw DATA_B31_8B97
.dw DATA_B31_8BD2
.dw DATA_B31_8E9D
.dw DATA_B31_8BF0
.dw DATA_B31_8C32
.dw DATA_B31_8C88
.dw DATA_B31_8C98
.dw DATA_B31_8CF2
.dw DATA_B31_8D1E
.dw DATA_B31_96CA
.dw DATA_B31_8D3E
.dw DATA_B31_8D4F
.dw DATA_B31_8D7E
.dw DATA_B31_8D8B
.dw DATA_B31_8D8B
.dw DATA_B31_8D9C
.dw DATA_B31_8DDE
.dw DATA_B31_8E20
.dw DATA_B31_8E52
.dw DATA_B31_98D9
.dw DATA_B31_8EBB
.dw DATA_B31_8EDB
.dw DATA_B31_8F23
.dw DATA_B31_8F4B
.dw DATA_B31_8F73
.dw DATA_B31_8F85
.dw DATA_B31_8EDB
.dw DATA_B31_8F85
.dw DATA_B31_8F95
.dw DATA_B31_8F95
.dw DATA_B31_980B
.dw DATA_B31_96FB
.dw DATA_B31_8FF6
.dw DATA_B31_9014
.dw DATA_B31_90B7
.dw DATA_B31_98D9
.dw DATA_B31_992F
.dw DATA_B31_994D
.dw DATA_B31_99FA
.dw DATA_B31_953E
.dw DATA_B31_9129
.dw DATA_B31_919E
.dw DATA_B31_91AF
.dw DATA_B31_9218
.dw DATA_B31_95E6
.dw DATA_B31_92F5
.dw DATA_B31_932E
.dw DATA_B31_935D
.dw DATA_B31_9381
.dw DATA_B31_93C3
.dw DATA_B31_9BED
.dw DATA_B31_93E3
.dw DATA_B31_93FE
.dw DATA_B31_942D
.dw DATA_B31_946B
.dw DATA_B31_946B
.dw DATA_B31_946B
.dw DATA_B31_9A26
.dw DATA_B31_9A4C
.dw DATA_B31_9C9E
.dw DATA_B31_9CFA


;=============================================
;	Animation sequences for Sonic object
;=============================================
DATA_B31_80C0:
.dw AnimData_BlankFrame		;sequence 00 
.dw DATA_B31_8188			;sequence 01
.dw DATA_B31_8193			;sequence 02
.dw DATA_B31_819E			;sequence 03
.dw DATA_B31_81A9			;sequence 04
.dw DATA_B31_81B4			;sequence 05
.dw DATA_B31_81BF			;sequence 06
.dw DATA_B31_81CA			;sequence 07
.dw DATA_B31_81D5			;sequence 08
.dw DATA_B31_81E0			;sequence 09
.dw DATA_B31_81EB			;sequence 0A
.dw DATA_B31_81F6
.dw DATA_B31_8201
.dw DATA_B31_820C
.dw DATA_B31_8217
.dw DATA_B31_8222
.dw DATA_B31_822D
.dw DATA_B31_8238
.dw DATA_B31_8243
.dw DATA_B31_824E
.dw DATA_B31_8259
.dw DATA_B31_8264
.dw DATA_B31_826F
.dw DATA_B31_827A
.dw DATA_B31_8285
.dw DATA_B31_8290
.dw DATA_B31_829B
.dw DATA_B31_82A6
.dw DATA_B31_82B1
.dw DATA_B31_82BC
.dw DATA_B31_82C7
.dw DATA_B31_82D2
.dw DATA_B31_82DD
.dw DATA_B31_82E8
.dw DATA_B31_82F3
.dw DATA_B31_82FE
.dw DATA_B31_8309
.dw DATA_B31_8314
.dw DATA_B31_831F
.dw DATA_B31_832A
.dw DATA_B31_8335
.dw DATA_B31_8340
.dw DATA_B31_834B
.dw DATA_B31_8356
.dw DATA_B31_8361
.dw DATA_B31_836C
.dw DATA_B31_8377
.dw DATA_B31_8382
.dw DATA_B31_838D
.dw DATA_B31_8398
.dw DATA_B31_83A3
.dw DATA_B31_83AE
.dw DATA_B31_83B9
.dw DATA_B31_83C4
.dw DATA_B31_83CF
.dw DATA_B31_83DA
.dw DATA_B31_83E5
.dw DATA_B31_83F0
.dw DATA_B31_83FB
.dw DATA_B31_8406
.dw DATA_B31_8411
.dw DATA_B31_841C
.dw DATA_B31_8427
.dw DATA_B31_8432
.dw DATA_B31_843D
.dw DATA_B31_8448
.dw DATA_B31_8453
.dw DATA_B31_845E
.dw DATA_B31_8469
.dw DATA_B31_8474
.dw DATA_B31_847F
.dw DATA_B31_848A
.dw DATA_B31_8495
.dw DATA_B31_84A0
.dw DATA_B31_84AB
.dw DATA_B31_84B6
.dw DATA_B31_84C1
.dw DATA_B31_84CC
.dw DATA_B31_84D7
.dw DATA_B31_84E2
.dw DATA_B31_84ED
.dw DATA_B31_84F8
.dw DATA_B31_8503
.dw DATA_B31_850E
.dw DATA_B31_8519
.dw DATA_B31_8524
.dw DATA_B31_852F
.dw DATA_B31_853A
.dw DATA_B31_8545
.dw DATA_B31_8550
.dw DATA_B31_855B
.dw DATA_B31_8566
.dw DATA_B31_8571
.dw DATA_B31_857C
.dw DATA_B31_8587
.dw DATA_B31_8592
.dw DATA_B31_859D
.dw DATA_B31_85A8
.dw DATA_B31_85B3
.dw DATA_B31_85BE

;	   
; 	  ,- Number of sprites
;    |      ,- ?
;    |     |     ,- ?
;    |     |    |       ,- Pointer to arrangement data for each sprite
;    |     |    |      |          ,- Object vertical offset
;    |     |    |      |         |         ,- Object horizontal offset
;    |     |    |      |         |        |         ,- Pointer to VRAM char codes for each sprite
;    |     |    |      |         |        |        |
;  |----|----|----|---------|---------|---------|--------|
;.db $06, $04, $1C, $BE, $9D, $00, $00, $00, $00, $C9, $85

DATA_B31_8188:
.db $06, $04, $1C
	.dw SprArrange_3x2_BC	;sprite arrangement
	.dw $0000				;vertical offset
	.dw $0000				;horizontal offset
	.dw DATA_B31_85C9		;pointer to char codes
DATA_B31_8193:
.db $06, $04, $1C
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_819E:
.db $06, $04, $1C
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_81A9:
.db $06, $04, $1C
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_81B4:		;walking
.db $06, $04, $1C
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_81BF:
.db $06, $04, $1C
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_81CA:
.db $06, $04, $1C
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_81D5:
.db $06, $04, $1C
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_81E0:
.db $06, $04, $1C
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_81EB:
.db $06, $04, $1C
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_81F6:
.db $06, $04, $1C
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_8201:
.db $06, $04, $1C
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_820C:
.db $06, $04, $1C
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_8217:
.db $06, $04, $1C
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_8222:
.db $06, $04, $1C
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_822D:
.db $06, $04, $1C
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_8238:
.db $06, $04, $12
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_8243:
.db $06, $04, $12
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_824E:
.db $06, $04, $12
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_8259:
.db $06, $04, $12
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_8264:
.db $06, $04, $12
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_826F:
.db $06, $04, $1C
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_827A:
.db $06, $04, $1C
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_8285:
.db $06, $04, $1C
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_8290:
.db $06, $04, $1C
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_829B:
.db $06, $04, $1C
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_82A6:
.db $06, $04, $1C
	.dw SprArrange_3x2_BC
	.dw $0004
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_82B1:
.db $06, $04, $1C
	.dw SprArrange_3x2_BC
	.dw $0004
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_82BC:
.db $06, $04, $1C
	.dw SprArrange_2x3
	.dw $0010
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_82C7:
.db $08, $04, $02
	.dw SprArrange_4x2
	.dw $0002
	.dw $FFF4
	.dw DATA_B31_85C9
DATA_B31_82D2:
.db $08, $04, $02
	.dw SprArrange_4x2
	.dw $0004
	.dw $FFF4
	.dw DATA_B31_85C9
DATA_B31_82DD:
.db $08, $04, $02
	.dw SprArrange_4x2
	.dw $0008
	.dw $FFF8
	.dw DATA_B31_85C9
DATA_B31_82E8:
.db $08, $04, $02
	.dw SprArrange_4x2
	.dw $0008
	.dw $FFF8
	.dw DATA_B31_85C9
DATA_B31_82F3:
.db $08, $04, $02
	.dw SprArrange_4x2
	.dw $0010
	.dw $FFF0
	.dw DATA_B31_85C9
DATA_B31_82FE:
.db $08, $04, $02
	.dw SprArrange_4x2
	.dw $0010
	.dw $FFF0
	.dw DATA_B31_85C9
DATA_B31_8309:
.db $08, $04, $02
	.dw SprArrange_4x2
	.dw $0018
	.dw $FFF0
	.dw DATA_B31_85C9
DATA_B31_8314:
.db $08, $04, $02
	.dw SprArrange_4x2
	.dw $0017
	.dw $FFF0
	.dw DATA_B31_85C9
DATA_B31_831F:
.db $08, $04, $02
	.dw SprArrange_4x2
	.dw $0016
	.dw $FFF2
	.dw DATA_B31_85C9
DATA_B31_832A:
.db $08, $04, $02
	.dw SprArrange_4x2
	.dw $0016
	.dw $FFF2
	.dw DATA_B31_85C9
DATA_B31_8335:
.db $08, $04, $02
	.dw SprArrange_4x2
	.dw $001A
	.dw $FFF4
	.dw DATA_B31_85C9
DATA_B31_8340:
.db $08, $04, $02
	.dw SprArrange_4x2
	.dw $001A
	.dw $FFF8
	.dw DATA_B31_85C9
DATA_B31_834B:
.db $08, $04, $02
	.dw SprArrange_4x2
	.dw $001E
	.dw $FFF6
	.dw DATA_B31_85C9
DATA_B31_8356:
.db $08, $04, $02
	.dw SprArrange_4x2
	.dw $001E
	.dw $FFF6
	.dw DATA_B31_85C9
DATA_B31_8361:
.db $08, $04, $02
	.dw SprArrange_4x2
	.dw $0020
	.dw $FFFC
	.dw DATA_B31_85C9
DATA_B31_836C:
.db $08, $04, $02
	.dw SprArrange_4x2
	.dw $0020
	.dw $FFFC
	.dw DATA_B31_85C9
DATA_B31_8377:
.db $08, $04, $02
	.dw SprArrange_4x2
	.dw $001C
	.dw $0004
	.dw DATA_B31_85C9
DATA_B31_8382:
.db $08, $04, $02
	.dw SprArrange_4x2
	.dw $001C
	.dw $0004
	.dw DATA_B31_85C9
DATA_B31_838D:
.db $08, $04, $02
	.dw SprArrange_4x2
	.dw $001C
	.dw $000A
	.dw DATA_B31_85C9
DATA_B31_8398:
.db $08, $04, $02
	.dw SprArrange_4x2
	.dw $001C
	.dw $000A
	.dw DATA_B31_85C9
DATA_B31_83A3:
.db $08, $04, $02
	.dw SprArrange_4x2
	.dw $0016
	.dw $000E
	.dw DATA_B31_85C9
DATA_B31_83AE:
.db $08, $04, $02
	.dw SprArrange_4x2
	.dw $0016
	.dw $000E
	.dw DATA_B31_85C9
DATA_B31_83B9:
.db $08, $04, $02
	.dw SprArrange_4x2
	.dw $000E
	.dw $0010
	.dw DATA_B31_85C9
DATA_B31_83C4:
.db $08, $04, $02
	.dw SprArrange_4x2 
	.dw $000E
	.dw $0010
	.dw DATA_B31_85C9
DATA_B31_83CF:
.db $08, $04, $02
	.dw SprArrange_4x2
	.dw $0006
	.dw $000C
	.dw DATA_B31_85C9
DATA_B31_83DA:
.db $08, $04, $02
	.dw SprArrange_4x2
	.dw $0006
	.dw $000C
	.dw DATA_B31_85C9
DATA_B31_83E5:
.db $08, $04, $02
	.dw SprArrange_4x2 
	.dw $0004
	.dw $0006
	.dw DATA_B31_85C9
DATA_B31_83F0:
.db $08, $04, $02
	.dw SprArrange_4x2 
	.dw $0004
	.dw $0006
	.dw DATA_B31_85C9
DATA_B31_83FB:
.db $08, $04, $02
	.dw SprArrange_4x2 
	.dw $0002
	.dw $0002
	.dw DATA_B31_85C9
DATA_B31_8406:
.db $08, $04, $02
	.dw SprArrange_4x2 
	.dw $0002
	.dw $0002
	.dw DATA_B31_85C9
DATA_B31_8411:
.db $08, $04, $1C
	.dw SprArrange_4x2 
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_841C:
.db $08, $04, $1C,
	.dw SprArrange_4x2 
	.dw $0000
	.dw $0000,
	.dw DATA_B31_85C9
DATA_B31_8427:
.db $08, $04, $1C
	.dw SprArrange_4x2 
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_8432:
.db $08, $04, $1C
	.dw SprArrange_4x2 
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_843D:
.db $08, $04, $1C
	.dw SprArrange_4x2 
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_8448:
.db $08, $04, $1C
	.dw SprArrange_4x2 
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_8453:
.db $08, $04, $1C
	.dw SprArrange_4x2 
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_845E:
.db $08, $04, $1C
	.dw SprArrange_4x2 
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_8469:
.db $08, $04, $1C
	.dw SprArrange_4x2 
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_8474:
.db $08, $04, $1C
	.dw SprArrange_4x2 
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_847F:
.db $08, $04, $1C
	.dw SprArrange_4x2 
	.dw $0000
	.dw $0000,
	.dw DATA_B31_85C9
DATA_B31_848A:
.db $08, $04, $1C
	.dw SprArrange_4x2 
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_8495:
.db $08, $04, $1C
	.dw SprArrange_4x2 
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_84A0:
.db $08, $04, $1C
	.dw SprArrange_4x2 
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_84AB:
.db $08, $04, $1C
	.dw SprArrange_4x2
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_84B6:
.db $04, $04, $1C
	.dw SprArrange_2x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_84C1:
.db $04, $04, $1C
	.dw SprArrange_2x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_84CC:
.db $04, $04, $1C
	.dw SprArrange_2x2_BC
	.dw $0000,
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_84D7:
.db $04, $04, $1C
	.dw SprArrange_2x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_84E2:
.db $04, $04, $1C
	.dw SprArrange_2x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_84ED:
.db $04, $04, $1C
	.dw SprArrange_2x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_84F8:
.db $04, $04, $1C
	.dw SprArrange_2x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_8503:
.db $04, $04, $1C
	.dw SprArrange_2x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_850E:
.db $04, $04, $1C
	.dw SprArrange_2x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_8519:
.db $04, $04, $1C
	.dw SprArrange_2x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_8524:
.db $04, $04, $1C
	.dw SprArrange_2x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_852F:
.db $04, $04, $1C
	.dw SprArrange_2x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_853A
.db $04, $04, $1C
	.dw SprArrange_2x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_8545:
.db $08, $04, $1C
	.dw DATA_B31_A676
	.dw $000A
	.dw $0000
	.dw $D3A0
DATA_B31_8550:
.db $08, $04, $1C
	.dw DATA_B31_A676 
	.dw $000A
	.dw $0000
	.dw $D3A0
DATA_B31_855B:
.db $08, $04, $1C
	.dw DATA_B31_A676
	.dw $000A
	.dw $0000
	.dw $D3A0
DATA_B31_8566:
.db $08, $04, $1C
	.dw DATA_B31_A676
	.dw $000A
	.dw $0000
	.dw $D3A0
DATA_B31_8571:
.db $08, $04, $1C
	.dw DATA_B31_A676
	.dw $000A
	.dw $0000
	.dw $D3A0
DATA_B31_857C:
.db $08, $04, $1C
	.dw DATA_B31_A676
	.dw $000A
	.dw $0000
	.dw $D3A0
DATA_B31_8587:
.db $08, $04, $1C
	.dw DATA_B31_A676
	.dw $000A
	.dw $0000
	.dw $D3A0
DATA_B31_8592:
.db $08, $04, $1C
	.dw SprArrange_4x2
	.dw $0000
	.dw $0002
	.dw DATA_B31_85C9
DATA_B31_859D:
.db $08, $04, $1C
	.dw SprArrange_4x2
	.dw $0000
	.dw $0002
	.dw DATA_B31_85C9
DATA_B31_85A8:
.db $08, $04, $1C
	.dw SprArrange_4x2
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_85B3:
.db $08, $04, $1C
	.dw SprArrange_4x2
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9
DATA_B31_85BE:
.db $06, $04, $1C
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85C9

DATA_B31_85C9:		;mappings for sonic sprite
.db $00, $02, $04, $06, $08, $0A, $0C, $0E


DATA_B31_85D1:
.dw AnimData_BlankFrame
.dw DATA_B31_85D7
.dw DATA_B31_85E2


DATA_B31_85D7:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85ED
DATA_B31_85E2:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_85EE

DATA_B31_85ED:
.db $2C
DATA_B31_85EE:
.db $2E


DATA_B31_85EF:
.dw AnimData_BlankFrame
.dw DATA_B31_8631
.dw DATA_B31_863C
.dw DATA_B31_8647
.dw DATA_B31_8652
.dw DATA_B31_865D
.dw DATA_B31_8668
.dw DATA_B31_8673
.dw DATA_B31_867E
.dw DATA_B31_8689
.dw DATA_B31_8694
.dw DATA_B31_869F
.dw DATA_B31_86AA
.dw DATA_B31_86B5
.dw DATA_B31_86C0
.dw DATA_B31_86CB
.dw DATA_B31_86D6
.dw DATA_B31_86E1
.dw DATA_B31_86EC
.dw DATA_B31_86F7
.dw DATA_B31_8702
.dw DATA_B31_870D
.dw DATA_B31_8718
.dw DATA_B31_8723
.dw DATA_B31_872E
.dw DATA_B31_8739
.dw DATA_B31_8744
.dw DATA_B31_874F
.dw DATA_B31_875A
.dw DATA_B31_8765
.dw DATA_B31_8770
.dw DATA_B31_877B
.dw DATA_B31_8786

DATA_B31_8631:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $FFE7
	.dw $0001
	.dw DATA_B31_8791
DATA_B31_863C:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $FFEB
	.dw $000B
	.dw DATA_B31_8791
DATA_B31_8647:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $FFF6
	.dw $000F
	.dw DATA_B31_8791
DATA_B31_8652:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $0001
	.dw $000B
	.dw DATA_B31_8791
DATA_B31_865D:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $0005
	.dw $0000
	.dw DATA_B31_8791
DATA_B31_8668:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $FFF5
	.dw DATA_B31_8791
DATA_B31_8673:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $FFF6
	.dw $FFF1
	.dw DATA_B31_8791
DATA_B31_867E:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $FFEB
	.dw $FFF6
	.dw DATA_B31_8791
DATA_B31_8689:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $FFE7
	.dw $0003
	.dw DATA_B31_8791
DATA_B31_8694:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $FFED
	.dw $000D
	.dw DATA_B31_8791
DATA_B31_869F:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $FFF9
	.dw $000F
	.dw DATA_B31_8791
DATA_B31_86AA:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $0003
	.dw $0009
	.dw DATA_B31_8791
DATA_B31_86B5:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $0005
	.dw $FFFD
	.dw DATA_B31_8791
DATA_B31_86C0:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $FFFE
	.dw $FFF3
	.dw DATA_B31_8791
DATA_B31_86CB:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $FFF3
	.dw $FFF1
	.dw DATA_B31_8791
DATA_B31_86D6:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $FFE9
	.dw $FFF8
	.dw DATA_B31_8791
DATA_B31_86E1:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $FFE8
	.dw $0006
	.dw DATA_B31_8791
DATA_B31_86EC:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $FFF1
	.dw $000E
	.dw DATA_B31_8791
DATA_B31_86F7:
.db $01, $00, $00
	.dw SprArrange_1x1_BC 
	.dw $FFFC
	.dw $000E
	.dw DATA_B31_8791
DATA_B31_8702:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $0004
	.dw $0005
	.dw DATA_B31_8791
DATA_B31_870D:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $0004
	.dw $FFFA
	.dw DATA_B31_8791
DATA_B31_8718:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $FFFB
	.dw $FFF2
	.dw DATA_B31_8791
DATA_B31_8723:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $FFF0
	.dw $FFF2
	.dw DATA_B31_8791
DATA_B31_872E:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $FFE8
	.dw $FFFB
	.dw DATA_B31_8791
DATA_B31_8739:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $FFEA
	.dw $0009
	.dw DATA_B31_8791
DATA_B31_8744:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $FFF4
	.dw $000F
	.dw DATA_B31_8791
DATA_B31_874F:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $FFFF
	.dw $000C
	.dw DATA_B31_8791
DATA_B31_875A:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $0005
	.dw $0002
	.dw DATA_B31_8791
DATA_B31_8765:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $0002
	.dw $FFF7
	.dw DATA_B31_8791
DATA_B31_8770:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $FFF8
	.dw $FFF1
	.dw DATA_B31_8791
DATA_B31_877B:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $FFED
	.dw $FFF4
	.dw DATA_B31_8791
DATA_B31_8786:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $FFE7
	.dw $FFFE
	.dw DATA_B31_8791


DATA_B31_8791:
.db $32, $32


DATA_B31_8793:
.dw AnimData_BlankFrame
.dw DATA_B31_8797

DATA_B31_8797:
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_87A2

DATA_B31_87A2:
.db $60

DATA_B31_87A3:
.dw AnimData_BlankFrame
DATA_B31_87A5:
.dw AnimData_BlankFrame
.dw DATA_B31_87AF
.dw DATA_B31_87BA
.dw DATA_B31_87C5
.dw DATA_B31_87D0

DATA_B31_87AF:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_87DB
DATA_B31_87BA:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_87DC
DATA_B31_87C5:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_87DD
DATA_B31_87D0:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_87DE

DATA_B31_87DB:
.db $02
DATA_B31_87DC:
.db $04
DATA_B31_87DD:
.db $02
DATA_B31_87DE:
.db $04


DATA_B31_87DF:
.dw AnimData_BlankFrame
.dw DATA_B31_87ED
.dw DATA_B31_87F8
.dw DATA_B31_8803
.dw DATA_B31_880E
.dw DATA_B31_85D7
.dw DATA_B31_85E2

DATA_B31_87ED:
.db $02, $00, $00
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8819
DATA_B31_87F8:
.db $02, $00, $00
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_881B
DATA_B31_8803:
.db $02, $00, $00
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_881D
DATA_B31_880E:
.db $02, $00, $00
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_881F

DATA_B31_8819:
.db $3E, $40
DATA_B31_881B:
.db $42, $44
DATA_B31_881D:
.db $46, $48
DATA_B31_881F:
.db $4A, $4C


DATA_B31_8821:
.dw AnimData_BlankFrame
.dw DATA_B31_882F
.dw DATA_B31_883A
.dw DATA_B31_8845
.dw DATA_B31_8850
.dw DATA_B31_885B
.dw DATA_B31_8866

DATA_B31_882F:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8871
DATA_B31_883A:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8872
DATA_B31_8845:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8873
DATA_B31_8850:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8874
DATA_B31_885B:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8875
DATA_B31_8866:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8876


DATA_B31_8871:
.db $02
DATA_B31_8872:
.db $04
DATA_B31_8873:
.db $06
DATA_B31_8874:
.db $08
DATA_B31_8875:
.db $0A
DATA_B31_8876:
.db $0C


DATA_B31_8877:
.dw AnimData_BlankFrame
.dw DATA_B31_8885
.dw DATA_B31_8890
.dw DATA_B31_889B
.dw DATA_B31_88A6
.dw DATA_B31_88B1
.dw DATA_B31_88BC

DATA_B31_8885:
.db $06, $02, $10
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_88C7
DATA_B31_8890:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_88CD
DATA_B31_889B:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_88CF
DATA_B31_88A6:
.db $06, $0C, $20
	.dw $D3CE
	.dw $FFF8
	.dw $FFFC
	.dw DATA_B31_88CF
DATA_B31_88B1:
.db $08, $02, $10
	.dw SprArrange_4x2
	.dw $0000
	.dw $0000
	.dw DATA_B31_88D5
DATA_B31_88BC:
.db $02, $08, $10
	.dw SprArrange_2x1_Diag
	.dw $0000
	.dw $0000
	.dw DATA_B31_88CF


DATA_B31_88C7:
.db $02, $04, $06, $08, $0A, $0C
DATA_B31_88CD:
.db $0E, $10
DATA_B31_88CF:
.db $12, $12, $12, $12, $12, $12
DATA_B31_88D5:
.db $14, $16, $18, $1A, $1C, $1E, $20, $22


DATA_B31_88DD:
.dw AnimData_BlankFrame
.dw DATA_B31_88E3
.dw DATA_B31_88EE

DATA_B31_88E3:
.db $02, $04, $10
	.dw $A696
	.dw $0008
	.dw $0000
	.dw DATA_B31_88F9
DATA_B31_88EE:
.db $02, $04, $10
	.dw $A69E
	.dw $0008
	.dw $0000
	.dw DATA_B31_88F9

DATA_B31_88F9:
.db $00, $02


DATA_B31_88FB:
.dw AnimData_BlankFrame
.dw DATA_B31_88FF

DATA_B31_88FF:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_890A

DATA_B31_890A:
.db $02, $04


DATA_B31_890C:
.dw AnimData_BlankFrame
.dw DATA_B31_8912
.dw DATA_B31_891D

DATA_B31_8912:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8928

DATA_B31_891D:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_892A

DATA_B31_8928:
.db $02, $04
DATA_B31_892A:
.db $06, $08


DATA_B31_892C:
.dw AnimData_BlankFrame
.dw DATA_B31_8934
.dw DATA_B31_893F
.dw DATA_B31_894A

DATA_B31_8934:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8955
DATA_B31_893F:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8956
DATA_B31_894A:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8957

DATA_B31_8955:
.db $00
DATA_B31_8956:
.db $02
DATA_B31_8957:
.db $04


;*****************************************
AnimData_Explosion:			;$8958
.dw AnimData_BlankFrame
.dw AD_Explosion_01
.dw AD_Explosion_02
.dw AD_Explosion_03

AD_Explosion_01:			;$8960
.db $01, $00, $00
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw AD_Explosion_01_CharCodes

AD_Explosion_02:			;$896B
.db $02, $00, $00
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw AD_Explosion_02_CharCodes

AD_Explosion_03:			;$8976
.db $02, $00, $00
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw AD_Explosion_03_CharCodes

AD_Explosion_01_CharCodes:	;$8981
.db $34
AD_Explosion_02_CharCodes:	;$8982
.db $36, $38
AD_Explosion_03_CharCodes:	;$8984
.db $3A, $3C


;*****************************************
AnimData_Monitors:			;$8986
.dw AnimData_BlankFrame
.dw DATA_B31_898C
.dw DATA_B31_8997

DATA_B31_898C:
.db $06, $0C, $18
	.dw SprArrange_3x2_BC
	.dw $0008
	.dw $0000
	.dw DATA_B31_89A2
DATA_B31_8997:
.db $06, $0C, $18
	.dw SprArrange_3x2_BC
	.dw $0008
	.dw $0000
	.dw DATA_B31_89A8

DATA_B31_89A2:
.db $4E, $50, $52, $5A, $5C, $5E
DATA_B31_89A8:
.db $54, $56, $58, $5A, $5C, $5E


;*****************************************
DATA_B31_89AE:
.dw AnimData_BlankFrame
.dw DATA_B31_89B2

DATA_B31_89B2:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_89BD

DATA_B31_89BD:
.db $54, $56


DATA_B31_89BF:
.dw AnimData_BlankFrame
.dw DATA_B31_89CF
.dw DATA_B31_89DA
.dw DATA_B31_89E5
.dw DATA_B31_89F0
.dw DATA_B31_89FB
.dw DATA_B31_8A06
.dw DATA_B31_8A11

DATA_B31_89CF:
.db $02, $02, $20
	.dw SprArrange_1x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8A1C
DATA_B31_89DA:
.db $02, $04, $20
	.dw SprArrange_1x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8A1E
DATA_B31_89E5:
.db $04, $08, $20
	.dw SprArrange_2x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8A20
DATA_B31_89F0:
.db $08, $10, $20
	.dw SprArrange_4x2
	.dw $0000
	.dw $0000
	.dw DATA_B31_8A24
DATA_B31_89FB:
.db $04, $08, $20
	.dw SprArrange_2x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8A2C
DATA_B31_8A06:
.db $02, $04, $20
	.dw SprArrange_1x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8A30
DATA_B31_8A11:
.db $02, $02, $20
	.dw SprArrange_1x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8A32

DATA_B31_8A1C:
.db $00, $00
DATA_B31_8A1E:
.db $02, $02
DATA_B31_8A20:
.db $04, $06, $04, $06
DATA_B31_8A24:
.db $08, $06, $06, $0A, $08, $06, $06, $0A
DATA_B31_8A2C:
.db $06, $0C, $06, $0C
DATA_B31_8A30:
.db $0E, $0E
DATA_B31_8A32:
.db $10, $10


DATA_B31_8A34:
.dw AnimData_BlankFrame
.dw DATA_B31_8A44
.dw DATA_B31_8A4F
.dw DATA_B31_8A5A
.dw DATA_B31_8A65
.dw DATA_B31_8A70
.dw DATA_B31_8A7B
.dw DATA_B31_8A86

DATA_B31_8A44:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8A91
DATA_B31_8A4F:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8A93
DATA_B31_8A5A:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8A95
DATA_B31_8A65:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8A97
DATA_B31_8A70:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8A9B
DATA_B31_8A7B:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8A9D
DATA_B31_8A86:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8A9F

DATA_B31_8A91:
.db $00, $00
DATA_B31_8A93:
.db $02, $02
DATA_B31_8A95:
.db $04, $04
DATA_B31_8A97:
.db $06, $06
DATA_B31_8A99:
.db $08, $08
DATA_B31_8A9B:
.db $0A, $0A
DATA_B31_8A9D:
.db $0C, $0C
DATA_B31_8A9F:
.db $0E, $0E


DATA_B31_8AA1:
.dw AnimData_BlankFrame
.dw DATA_B31_8AA5

DATA_B31_8AA5:
.db $08, $10, $20
	.dw SprArrange_4x2
	.dw $0000
	.dw $0000
	.dw DATA_B31_8AB0

DATA_B31_8AB0:
.db $02, $04, $06, $08, $0A, $0C, $0E, $10


DATA_B31_8AB8:
.dw AnimData_BlankFrame
.dw DATA_B31_8AC2
.dw DATA_B31_8ACD
.dw DATA_B31_8AD8
.dw DATA_B31_8AE3

DATA_B31_8AC2:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8AEE
DATA_B31_8ACD:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8AEF
DATA_B31_8AD8:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8AF0
DATA_B31_8AE3:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0002
	.dw DATA_B31_8AEE

DATA_B31_8AEE:
.db $00
DATA_B31_8AEF:
.db $02
DATA_B31_8AF0:
.db $04


DATA_B31_8AF1:
.dw AnimData_BlankFrame
.dw DATA_B31_8AF5

DATA_B31_8AF5:
.db $02, $18, $20
	.dw SprArrange_2x1_BC
	.dw $0008
	.dw $0000
	.dw DATA_B31_8B00

DATA_B31_8B00:
.db $10, $12


DATA_B31_8B02:
.dw AnimData_BlankFrame
.dw DATA_B31_8B06

DATA_B31_8B06:
.db $01, $18, $20
	.dw SprArrange_1x1_BC
	.dw $0008
	.dw $0000
	.dw DATA_B31_8B11

DATA_B31_8B11:
.db $14


DATA_B31_8B12:
.dw AnimData_BlankFrame
.dw DATA_B31_8B16

DATA_B31_8B16:
.db $09, $18, $20
	.dw SprArrange_3x3
	.dw $0008
	.dw $0000
	.dw DATA_B31_8B21

DATA_B31_8B21:
.db $16, $18, $1A, $1C, $1E, $20, $22, $24, $26


DATA_B31_8B2A:
.dw AnimData_BlankFrame
.dw DATA_B31_8B30
.dw DATA_B31_8B3B

DATA_B31_8B30:
.db $1C, $18, $20
	.dw DATA_B31_A606
	.dw $0008
	.dw $0000
	.dw DATA_B31_8B46
DATA_B31_8B3B:
.db $1C, $18, $20
	.dw DATA_B31_A606
	.dw $0008
	.dw $0000
	.dw DATA_B31_8B46

DATA_B31_8B46:
.db $10, $12, $14, $16, $18, $1A, $1C, $1E
.db $20, $22, $24, $26, $28, $2A, $2C, $2E
.db $30, $32, $34, $36, $38, $3A, $3C, $3E
.db $40, $42, $44, $46


DATA_B31_8B62:
.dw AnimData_BlankFrame
.dw DATA_B31_8B6A
.dw DATA_B31_8B75
.dw DATA_B31_8B80

DATA_B31_8B6A:
.db $04, $10, $10
	.dw SprArrange_4x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_8B8B
DATA_B31_8B75:
.db $04, $10, $10
	.dw SprArrange_4x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_8B8F
DATA_B31_8B80:
.db $04, $10, $10
	.dw SprArrange_4x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_8B93

DATA_B31_8B8B:
.db $00, $02, $04, $06
DATA_B31_8B8F:
.db $08, $0A, $0C, $0E
DATA_B31_8B93:
.db $10, $12, $14, $16


DATA_B31_8B97:
.dw AnimData_BlankFrame
.dw DATA_B31_8B9F
.dw DATA_B31_8BAA
.dw DATA_B31_8BB5

DATA_B31_8B9F:
.db $06, $0C, $18
	.dw SprArrange_3x2_BC
	.dw $0008
	.dw $0000
	.dw DATA_B31_8BC0
DATA_B31_8BAA:
.db $06, $0C, $18
	.dw SprArrange_3x2_BC
	.dw $0008
	.dw $0000
	.dw DATA_B31_8BC6
DATA_B31_8BB5:
.db $06, $0C, $18
	.dw SprArrange_3x2_BC
	.dw $0008
	.dw $0000
	.dw DATA_B31_8BCC

DATA_B31_8BC0:
.db $00, $02, $04, $06, $08, $0A
DATA_B31_8BC6:
.db $0C, $0E, $10, $12, $14, $16
DATA_B31_8BCC:
.db $18, $1A, $1C, $1E, $20, $0A


DATA_B31_8BD2:
.dw AnimData_BlankFrame
.dw DATA_B31_8BD8
.dw DATA_B31_8BE3

DATA_B31_8BD8:
.db $01, $04, $08
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8BEE
DATA_B31_8BE3:
.db $01, $04, $08
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8BEF

DATA_B31_8BEE:
.db $22
DATA_B31_8BEF:
.db $24


DATA_B31_8BF0:
.dw AnimData_BlankFrame
.dw DATA_B31_8BFA
.dw DATA_B31_8C05
.dw DATA_B31_8C10
.dw DATA_B31_8C1B

DATA_B31_8BFA:
.db $02, $04, $20
	.dw SprArrange_1x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8C26
DATA_B31_8C05:
.db $02, $04, $20
	.dw SprArrange_1x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8C28
DATA_B31_8C10:
.db $04, $10, $08
	.dw SprArrange_4x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_8C2A
DATA_B31_8C1B:
.db $04, $10, $08
	.dw SprArrange_4x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_8C2E

DATA_B31_8C26:
.db $00, $02
DATA_B31_8C28:
.db $02, $04
DATA_B31_8C2A:
.db $06, $08, $0A, $0C
DATA_B31_8C2E:
.db $08, $0A, $0C, $0E


DATA_B31_8C32:
.dw AnimData_BlankFrame
.dw DATA_B31_8C3C
.dw DATA_B31_8C47
.dw DATA_B31_8C52
.dw DATA_B31_8C5D

DATA_B31_8C3C:
.db $08, $08, $18
	.dw SprArrange_4x2
	.dw $000A
	.dw $0000
	.dw DATA_B31_8C68
DATA_B31_8C47:
.db $08, $08, $18
	.dw SprArrange_4x2
	.dw $000A
	.dw $0000
	.dw DATA_B31_8C70
DATA_B31_8C52:
.db $08, $08, $18
	.dw SprArrange_4x2
	.dw $000A
	.dw $0000
	.dw DATA_B31_8C78
DATA_B31_8C5D:
.db $08, $08, $18
	.dw SprArrange_4x2
	.dw $000A
	.dw $0000
	.dw DATA_B31_8C80

DATA_B31_8C68:
.db $02, $04, $06, $08, $00, $0A, $00, $00
DATA_B31_8C70:
.db $0C, $0E, $10, $12, $00, $14, $00, $00
DATA_B31_8C78:
.db $16, $18, $1A, $1C, $00, $00, $1E, $00
DATA_B31_8C80:
.db $20, $22, $24, $26, $00, $28, $2A, $00


DATA_B31_8C88:
.dw AnimData_BlankFrame
.dw DATA_B31_8C8C

DATA_B31_8C8C:
.db $01, $14, $1A
	.dw SprArrange_1x1_BC
	.dw $FFFC
	.dw $FFFF
	.dw DATA_B31_8C97

DATA_B31_8C97:
.db $34


DATA_B31_8C98:
.dw AnimData_BlankFrame
.dw DATA_B31_8CA4
.dw DATA_B31_8CAF
.dw DATA_B31_8CBA
.dw DATA_B31_8CC5
.dw DATA_B31_8CD0

DATA_B31_8CA4:
.db $05, $0C, $14
	.dw SprArrange_3x1_2x1
	.dw $000A
	.dw $0000
	.dw DATA_B31_8CDB
DATA_B31_8CAF:
.db $05, $0C, $14
	.dw SprArrange_3x1_2x1
	.dw $000A
	.dw $0000
	.dw DATA_B31_8CE0
DATA_B31_8CBA:
.db $05, $0C, $14
	.dw SprArrange_3x1_2x1
	.dw $000A
	.dw $0000
	.dw DATA_B31_8CE5
DATA_B31_8CC5:
.db $05, $0C, $14
	.dw SprArrange_3x1_2x1
	.dw $000A
	.dw $0000
	.dw DATA_B31_8CEA
DATA_B31_8CD0:
.db $03, $00, $00
	.dw SprArrange_3x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_8CEF

DATA_B31_8CDB:
.db $00, $02, $04, $06, $08
DATA_B31_8CE0:
.db $00, $02, $04, $0A, $0C
DATA_B31_8CE5:
.db $00, $02, $04, $0E, $10
DATA_B31_8CEA:
.db $00, $02, $04, $12, $14
DATA_B31_8CEF:
.db $16, $18, $1A


DATA_B31_8CF2:
.dw AnimData_BlankFrame
.dw DATA_B31_8CF8
.dw DATA_B31_8D03

DATA_B31_8CF8:
.db $08, $08, $10
	.dw SprArrange_4x2
	.dw $000A
	.dw $0000
	.dw DATA_B31_8D0E
DATA_B31_8D03:
.db $08, $08, $10
	.dw SprArrange_4x2
	.dw $000A
	.dw $0000
	.dw DATA_B31_8D16

DATA_B31_8D0E:
.db $00, $02, $04, $06, $08, $0A, $0C, $0E
DATA_B31_8D16:
.db $00, $10, $12, $06, $08, $14, $16, $0E


DATA_B31_8D1E:
.dw AnimData_BlankFrame
.dw DATA_B31_8D24
.dw DATA_B31_8D2F

DATA_B31_8D24:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8D3A
DATA_B31_8D2F:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8D3C

DATA_B31_8D3A:
.db $00, $02
DATA_B31_8D3C:
.db $04, $06


DATA_B31_8D3E:
.dw AnimData_BlankFrame
.dw DATA_B31_8D42

DATA_B31_8D42:
.db $02, $0C, $08
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8D4D

DATA_B31_8D4D:
.db $00, $02


DATA_B31_8D4F:
.dw AnimData_BlankFrame
.dw DATA_B31_8D57
.dw DATA_B31_8D62
.dw DATA_B31_8D6D

DATA_B31_8D57:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8D78
DATA_B31_8D62:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8D7A
DATA_B31_8D6D:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8D7C

DATA_B31_8D78:
.db $00, $02
DATA_B31_8D7A:
.db $04, $06
DATA_B31_8D7C:
.db $08, $0A


DATA_B31_8D7E:
.dw AnimData_BlankFrame


;************************************
;*	A single empty animation frame.	*
;************************************
AnimData_BlankFrame:	;$8D80
.db $00, $00, $00
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw $0000


DATA_B31_8D8B:
.dw AnimData_BlankFrame
.dw DATA_B31_8D8F

DATA_B31_8D8F:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8D9A

DATA_B31_8D9A:
.db	$00, $02


DATA_B31_8D9C:
.dw	AnimData_BlankFrame
.dw DATA_B31_8DA6
.dw DATA_B31_8DB1
.dw DATA_B31_8DBC
.dw DATA_B31_8DC7

DATA_B31_8DA6:
.db $03, $0C, $10
	.dw SprArrange_3x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_8DD2
DATA_B31_8DB1:
.db $03, $0C, $10
	.dw SprArrange_3x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_8DD5
DATA_B31_8DBC:
.db $03, $0C, $10
	.dw SprArrange_3x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_8DD8
DATA_B31_8DC7
.db $03, $0C, $10
	.dw SprArrange_3x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_8DDB

DATA_B31_8DD2:
.db $02, $04, $06
DATA_B31_8DD5:
.db $08, $0A, $0C
DATA_B31_8DD8:
.db $0E, $10, $12
DATA_B31_8DDB:
.db $14, $16, $18


DATA_B31_8DDE:
.dw AnimData_BlankFrame
.dw DATA_B31_8DE8
.dw DATA_B31_8DF3
.dw DATA_B31_8DFE
.dw DATA_B31_8E09

DATA_B31_8DE8:
.db $03, $0C, $10
	.dw SprArrange_3x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_8E14
DATA_B31_8DF3:
.db $03, $0C, $10
	.dw SprArrange_3x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_8E17
DATA_B31_8DFE:
.db $03, $0C, $10
	.dw SprArrange_3x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_8E1A
DATA_B31_8E09:
.db $03, $0C, $10
	.dw SprArrange_3x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_8E1D

DATA_B31_8E14:
.db $02, $04, $06
DATA_B31_8E17:
.db $08, $0A, $0C
DATA_B31_8E1A:
.db $0E, $10, $12
DATA_B31_8E1D:
.db $14, $16, $18


DATA_B31_8E20:
.dw AnimData_BlankFrame
.dw DATA_B31_8E28
.dw DATA_B31_8E33
.dw DATA_B31_8E3E

DATA_B31_8E28:
.db $03, $0C, $10
	.dw SprArrange_3x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_8E49
DATA_B31_8E33:
.db $03, $0C, $10
	.dw SprArrange_3x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_8E4C
DATA_B31_8E3E:
.db $03, $0C, $10
	.dw SprArrange_3x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_8E4F

DATA_B31_8E49:
.db $00, $02, $04
DATA_B31_8E4C:
.db $06, $08, $0A
DATA_B31_8E4F:
.db $0C, $02, $0E


DATA_B31_8E52:
.dw AnimData_BlankFrame
.dw DATA_B31_8E5C
.dw DATA_B31_8E67
.dw DATA_B31_8E72
.dw DATA_B31_8E7D

DATA_B31_8E5C:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8E88
DATA_B31_8E67:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8E8E
DATA_B31_8E72:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8E94
DATA_B31_8E7D:
.db $03, $0C, $10
	.dw SprArrange_3x1
	.dw $FFF0
	.dw $0000
	.dw DATA_B31_8E9A

DATA_B31_8E88:
.db $00, $02, $04, $06, $08, $08
DATA_B31_8E8E:
.db $00, $02, $0A, $06, $08, $08
DATA_B31_8E94:
.db $0C, $0E, $10, $12, $08, $08
DATA_B31_8E9A:
.db $14, $16, $18


DATA_B31_8E9D:
.dw AnimData_BlankFrame
.dw DATA_B31_8EA3
.dw DATA_B31_8EAE

DATA_B31_8EA3:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8EB9
DATA_B31_8EAE:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8EBA

DATA_B31_8EB9:
.db $00
DATA_B31_8EBA:
.db $02


DATA_B31_8EBB:
.dw AnimData_BlankFrame
.dw DATA_B31_8EC1
.dw DATA_B31_8ECC

DATA_B31_8EC1:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8ED7
DATA_B31_8ECC:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8ED9

DATA_B31_8ED7:
.db $00, $02
DATA_B31_8ED9:
.db $00, $04


DATA_B31_8EDB:
.dw AnimData_BlankFrame
.dw DATA_B31_8EE5
.dw DATA_B31_8EF0
.dw DATA_B31_8EFB
.dw DATA_B31_8F06

DATA_B31_8EE5:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8F11
DATA_B31_8EF0:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8F17
DATA_B31_8EFB:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8F1D
DATA_B31_8F06:
.db $03, $0C, $10
	.dw SprArrange_3x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_8F11

DATA_B31_8F11:
.db $00, $02, $04, $06, $08, $0A
DATA_B31_8F17:
.db $00, $02, $04, $0C, $0E, $10
DATA_B31_8F1D:
.db $00, $02, $04, $12, $14, $16


DATA_B31_8F23:
.dw AnimData_BlankFrame
.dw DATA_B31_8F2D
.dw DATA_B31_8F38
.dw DATA_B31_8F2D
.dw DATA_B31_8F38

DATA_B31_8F2D:
.db $04, $08, $18
	.dw SprArrange_2x2_BC
	.dw $0008
	.dw $0000
	.dw DATA_B31_8F43
DATA_B31_8F38:
.db $04, $08, $18
	.dw SprArrange_2x2_BC
	.dw $0008
	.dw $0000
	.dw DATA_B31_8F47

DATA_B31_8F43:
.db $00, $02, $04, $06
DATA_B31_8F47:
.db $00, $08, $0A, $0C


DATA_B31_8F4B:
.dw AnimData_BlankFrame
.dw DATA_B31_8F51
.dw DATA_B31_8F5C

DATA_B31_8F51:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8F67
DATA_B31_8F5C:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8F6D

DATA_B31_8F67:
.db $00, $02, $04, $06, $08, $0A
DATA_B31_8F6D:
.db $0C, $0E, $10, $12, $14, $16


DATA_B31_8F73:
.dw AnimData_BlankFrame
.dW DATA_B31_8F79
.dw DATA_B31_8F79

DATA_B31_8F79:
.db $01, $04, $08
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8F84

DATA_B31_8F84:
.db $0E


DATA_B31_8F85:
.dw AnimData_BlankFrame
.dw DATA_B31_8F89

DATA_B31_8F89:
.db $01, $04, $08
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_8F94

DATA_B31_8F94:
.db $1A


DATA_B31_8F95:
.dw AnimData_BlankFrame
.dw DATA_B31_8F9D
.dw DATA_B31_8FA8
.dw DATA_B31_8FB3

DATA_B31_8F9D:
.db $14, $18, $30
	.dw SprArrange_1x6_1x8_1x6
	.dw $0000
	.dw $0000
	.dw DATA_B31_8FBE
DATA_B31_8FA8:
.db $14, $18, $30
	.dw SprArrange_1x6_1x8_1x6
	.dw $0000
	.dw $0000
	.dw DATA_B31_8FD2
DATA_B31_8FB3:
.db $10, $18, $30
	.dw SprArrange_6x1_8x1_1x1_1x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_8FE6

DATA_B31_8FBE:
.db $02, $04, $06, $08, $0A, $0C, $0E, $10
.db $12, $14, $16, $18, $1A, $1C, $1E, $20
.db $22, $24, $26, $28
DATA_B31_8FD2:
.db $02, $04, $06, $08, $0A, $0C, $0E, $10
.db $2A, $2C, $2E, $30, $1A, $1C, $1E, $32
.db $34, $36, $38, $28
DATA_B31_8FE6:
.db $02, $04, $06, $08, $0A, $0C, $0E, $10
.db $3A, $3C, $3E, $40, $1A, $1C, $42, $44


DATA_B31_8FF6:
.dw AnimData_BlankFrame
.dw DATA_B31_8FFC
.dw DATA_B31_9007

DATA_B31_8FFC:
.db $01, $02, $06
	.dw SprArrange_1x1_BC
	.dw $0004
	.dw $0000
	.dw DATA_B31_9012
DATA_B31_9007:
.db $01, $02, $06
	.dw SprArrange_1x1_BC
	.dw $0004
	.dw $0000
	.dw DATA_B31_9013

DATA_B31_9012:
.db $94
DATA_B31_9013:
.db $96


DATA_B31_9014:
.dw AnimData_BlankFrame
.dw DATA_B31_9024
.dw DATA_B31_902F
.dw DATA_B31_903A
.dw DATA_B31_9045
.dw DATA_B31_9050
.dw DATA_B31_905B
.dw DATA_B31_9066

DATA_B31_9024:
.db $0A, $14, $20
	.dw SprArrange_5x2
	.dw $FFFE
	.dw $0000
	.dw DATA_B31_9071
DATA_B31_902F:
.db $0A, $14, $20
	.dw SprArrange_5x2
	.dw $0000
	.dw $0000
	.dw DATA_B31_907B
DATA_B31_903A:
.db $0A, $14, $20
	.dw SprArrange_5x2
	.dw $FFFE
	.dw $0000
	.dw DATA_B31_9085
DATA_B31_9045:
.db $0A, $14, $20
	.dw SprArrange_5x2
	.dw $0000
	.dw $0000
	.dw DATA_B31_908F
DATA_B31_9050
.db $0A, $14, $20
	.dw SprArrange_5x2
	.dw $0004
	.dw $0000
	.dw DATA_B31_9099
DATA_B31_905B:
.db $0A, $14, $20
	.dw SprArrange_5x2
	.dw $0004
	.dw $0000
	.dw DATA_B31_90A3
DATA_B31_9066:
.db $0A, $14, $20
	.dw SprArrange_5x2
	.dw $0004
	.dw $0000
	.dw DATA_B31_90AD

DATA_B31_9071:
.db $02, $04, $06, $08, $0A, $0C, $0E, $10, $12, $14
DATA_B31_907B:
.db $02, $04, $06, $08, $0A, $0C, $16, $10, $12, $14
DATA_B31_9085:
.db $02, $04, $06, $08, $0A, $0C, $18, $10, $1A, $14
DATA_B31_908F:
.db $02, $04, $06, $08, $0A, $0C, $1C, $10, $1A, $14
DATA_B31_9099:
.db $1E, $20, $22, $24, $26, $28, $2A, $2C, $2E, $14
DATA_B31_90A3:
.db $30, $32, $34, $36, $26, $28, $2A, $2C, $2E, $14
DATA_B31_90AD:
.db $30, $32, $34, $38, $26, $28, $2A, $2C, $2E, $14


DATA_B31_90B7:
.dw AnimData_BlankFrame
.dw DATA_B31_90C9
.dw DATA_B31_90D4
.dw DATA_B31_90DF
.dw DATA_B31_90EA
.dw DATA_B31_90F5
.dw DATA_B31_9100
.dw DATA_B31_910B
.dw DATA_B31_9116

DATA_B31_90C9:
.db $01, $04, $08
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9121
DATA_B31_90D4:
.db $01, $04, $08
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9122
DATA_B31_90DF:
.db $01, $04, $08
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9123
DATA_B31_90EA:
.db $01, $04, $08
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9124
DATA_B31_90F5:
.db $01, $04, $08
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9125
DATA_B31_9100:
.db $01, $04, $08
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9126
DATA_B31_910B:
.db $01, $04, $08
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9127
DATA_B31_9116:
.db $01, $04, $08
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9128

DATA_B31_9121:
.db $3A
DATA_B31_9122:
.db $3C
DATA_B31_9123:
.db $3E
DATA_B31_9124:
.db $40
DATA_B31_9125:
.db $42
DATA_B31_9126:
.db $44
DATA_B31_9127:
.db $46
DATA_B31_9128:
.db $48


DATA_B31_9129:
.dw AnimData_BlankFrame
.dw DATA_B31_9133
.dw DATA_B31_913E
.dw DATA_B31_9149
.dw DATA_B31_9154

DATA_B31_9133:
.db $0B, $14, $18
	.dw SprArrange_1x1_5x2
	.dw $0000
	.dw $0000
	.dw DATA_B31_915F
DATA_B31_913E:
.db $14, $14, $28
	.dw DATA_B31_A14A
	.dw $0020
	.dw $0000
	.dw DATA_B31_916A
DATA_B31_9149:
.db $10, $14, $20
	.dw SprArrange_1x1_5x3
	.dw $0010
	.dw $0000
	.dw DATA_B31_917E
DATA_B31_9154:
.db $10, $14, $20
	.dw SprArrange_1x1_5x3
	.dw $0010
	.dw $0000
	.dw DATA_B31_918E

DATA_B31_915F:
.db $02, $04, $06, $08, $0A, $0C, $0E, $10, $12, $14, $16
DATA_B31_916A:
.db $02, $04, $06, $08, $0A, $0C, $0E, $10, $12, $14, $16, $18, $1A, $1C, $1E, $20, $22, $24, $26, $28
DATA_B31_917E:
.db $02, $04, $06, $08, $0A, $0C, $0E, $10, $12, $14, $16, $2A, $2C, $2E, $30, $32
DATA_B31_918E:
.db $02, $04, $06, $08, $0A, $0C, $0E, $10, $12, $14, $16, $32, $30, $34, $2C, $2A


DATA_B31_919E:
.dw AnimData_BlankFrame
.dw DATA_B31_91A2

DATA_B31_91A2:
.db $02, $04, $08
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_91AD

DATA_B31_91AD:
.db $36, $38


DATA_B31_91AF:
.dw AnimData_BlankFrame
.dw DATA_B31_91BB
.dw DATA_B31_91C6
.dw DATA_B31_91D1
.dw DATA_B31_91DC
.dw DATA_B31_91E7

DATA_B31_91BB:
.db $0A, $10, $38
	.dw SprArrange_1x1_1x1_4x1_2x2
	.dw $0000
	.dw $0000
	.dw DATA_B31_91F2
DATA_B31_91C6:
.db $08, $08, $40
	.dw SprArrange_2x4
	.dw $0000
	.dw $0000
	.dw DATA_B31_91FC
DATA_B31_91D1:
.db $0A, $10, $38
	.dw SprArrange_1x1_1x1_4x1_2x2
	.dw $0000
	.dw $0000
	.dw DATA_B31_9204
DATA_B31_91DC:
.db $0A, $18, $30
	.dw SprArrange_6x1_2x2
	.dw $0000
	.dw $0000
	.dw DATA_B31_920E
DATA_B31_91E7:
.db $0A, $10, $38
	.dw SprArrange_1x1_1x1_4x1_2x2
	.dw $0002
	.dw $0000
	.dw DATA_B31_9204

DATA_B31_91F2:
.db $3A, $3C, $3E, $40, $42, $44, $46, $48, $4A, $4C
DATA_B31_91FC:
.db $4E, $50, $52, $54, $46, $48, $4A, $4C
DATA_B31_9204:
.db $3A, $3C, $3E, $56, $58, $44, $5A, $5C, $4A, $4C
DATA_B31_920E:
.db $5E, $60, $62, $64, $66, $68, $46, $48, $4A, $4C


DATA_B31_9218:
.dw AnimData_BlankFrame
.dw DATA_B31_9232
.dw DATA_B31_923D
.dw DATA_B31_9248
.dw DATA_B31_9253
.dw DATA_B31_925E
.dw DATA_B31_925E
.dw DATA_B31_9295
.dw DATA_B31_9269
.dw DATA_B31_9274
.dw DATA_B31_927F
.dw DATA_B31_928A
.dw DATA_B31_92A0

DATA_B31_9232:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_92AB
DATA_B31_923D:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_92B1
DATA_B31_9248:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_92B7
DATA_B31_9253:
.db $08, $18, $20
	.dw SprArrange_4x2
	.dw $0000
	.dw $0004
	.dw DATA_B31_92BD
DATA_B31_925E:
.db $0A, $20, $20
	.dw SprArrange_5x2
	.dw $0000
	.dw $0008
	.dw DATA_B31_92C5
DATA_B31_9269:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_92CF
DATA_B31_9274:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_92D5
DATA_B31_927F:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_92DB
DATA_B31_928A:
.db $08, $0C, $20
	.dw SprArrange_4x2
	.dw $0000
	.dw $0000
	.dw DATA_B31_92E1
DATA_B31_9295:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0008
	.dw $0000
	.dw DATA_B31_92E9
DATA_B31_92A0:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0008
	.dw $0000
	.dw DATA_B31_92EF

DATA_B31_92AB:
.db $02, $04, $06, $08, $0A, $0C
DATA_B31_92B1:
.db $0E, $10, $12, $14, $16, $18
DATA_B31_92B7:
.db $02, $04, $06, $08, $0A, $1A
DATA_B31_92BD:
.db $02, $04, $06, $00, $08, $0A, $1C, $1E
DATA_B31_92C5:
.db $02, $04, $06, $00, $00, $08, $0A, $1C, $20, $22
DATA_B31_92CF:
.db $02, $04, $06, $24, $26, $0C
DATA_B31_92D5:
.db $02, $04, $06, $08, $28, $0C
DATA_B31_92DB:
.db $02, $04, $06, $2A, $0A, $0C
DATA_B31_92E1:
.db $00, $02, $04, $06, $2C, $2E, $0A, $0C
DATA_B31_92E9:
.db $30, $32, $34, $36, $38, $3A
DATA_B31_92EF:
.db $30, $3C, $3E, $36, $40, $42


DATA_B31_92F5:
.dw AnimData_BlankFrame
.dw DATA_B31_92FD
.dw DATA_B31_9308
.dw DATA_B31_9313

DATA_B31_92FD:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_931E
DATA_B31_9308:
.db $04, $08, $20
	.dw SprArrange_2x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9324
DATA_B31_9313:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9328

DATA_B31_931E:
.db $02, $04, $00, $06, $08, $0A
DATA_B31_9324:
.db $0C, $0E, $10, $12
DATA_B31_9328:
.db $00, $14, $16, $18, $1A, $1C


DATA_B31_932E:
.dw AnimData_BlankFrame
.dw DATA_B31_9336
.dw DATA_B31_9341
.dw DATA_B31_934C

DATA_B31_9336:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9357
DATA_B31_9341:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9359
DATA_B31_934C:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_935B

DATA_B31_9357:
.db $02, $04
DATA_B31_9359:
.db $06, $08
DATA_B31_935B:
.db $0A, $0C


DATA_B31_935D:
.dw AnimData_BlankFrame
.dw DATA_B31_9363
.dw DATA_B31_936E

DATA_B31_9363:
.db $04, $10, $10
	.dw SprArrange_4x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_9379
DATA_B31_936E
.db $04, $10, $10
	.dw SprArrange_4x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_937D

DATA_B31_9379:
.db $02, $04, $06, $08
DATA_B31_937D:
.db $0A, $0C, $0E, $10


DATA_B31_9381:
.dw AnimData_BlankFrame
.dw DATA_B31_938B
.dw DATA_B31_9396
.dw DATA_B31_93A1
.dw DATA_B31_93AC

DATA_B31_938B:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_93B7
DATA_B31_9396:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_93B8
DATA_B31_93A1:
.db $05, $0C, $10
	.dw $D3CE
	.dw $FFF8
	.dw $FFFC
	.dw DATA_B31_93B9
DATA_B31_93AC:
.db $05, $0C, $10
	.dw $D3CE
	.dw $FFF8
	.dw $FFFC
	.dw DATA_B31_93BE

DATA_B31_93B7:
.db $6C
DATA_B31_93B8:
.db $6E
DATA_B31_93B9:
.db $6C, $6E, $6C, $6E, $6E
DATA_B31_93BE:
.db $6E, $6C, $6E, $6C, $6E


DATA_B31_93C3:
.dw AnimData_BlankFrame
.dw DATA_B31_93C9
.dw DATA_B31_93D4

DATA_B31_93C9:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_93DF
DATA_B31_93D4:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_93E1

DATA_B31_93DF:
.db $70, $72
DATA_B31_93E1:
.db $74, $76


DATA_B31_93E3:
.dw AnimData_BlankFrame
.dw DATA_B31_93E7

DATA_B31_93E7:
.db $12, $10, $20
	.dw SprArrange_6x2
	.dw $0000
	.dw $0000
	.dw DATA_B31_93F2

DATA_B31_93F2:
.db $02, $04, $06, $08, $0A, $0C, $0E, $10, $12, $14, $16, $18


DATA_B31_93FE:
.dw AnimData_BlankFrame
.dw DATA_B31_9406
.dw DATA_B31_9411
.dw DATA_B31_941C

DATA_B31_9406:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9427
DATA_B31_9411:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9429
DATA_B31_941C:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_942B

DATA_B31_9427:
.db $02, $04
DATA_B31_9429:
.db $06, $08
DATA_B31_942B:
.db $0A, $0C


DATA_B31_942D:
.dw AnimData_BlankFrame
.dw DATA_B31_9437
.dw DATA_B31_9442
.dw DATA_B31_944D
.dw DATA_B31_9458

DATA_B31_9437:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9463
DATA_B31_9442:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9465
DATA_B31_944D
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9467
DATA_B31_9458:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9469

DATA_B31_9463:
.db $02, $04
DATA_B31_9465:
.db $06, $08
DATA_B31_9467:
.db $0A, $0C
DATA_B31_9469:
.db $0E, $10


DATA_B31_946B:
.dw AnimData_BlankFrame
.dw DATA_B31_9483
.dw DATA_B31_948E
.dw DATA_B31_9499
.dw DATA_B31_94A4
.dw DATA_B31_94AF
.dw DATA_B31_94BA
.dw DATA_B31_94C5
.dw DATA_B31_94D0
.dw DATA_B31_94DB
.dw DATA_B31_94E6
.dw DATA_B31_94F1

DATA_B31_9483:
.db $04, $08, $20
	.dw SprArrange_2x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_94FC
DATA_B31_948E:
.db $02, $04, $20
	.dw	SprArrange_1x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9500
DATA_B31_9499:
.db $04, $08, $20
	.dw SprArrange_2x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9502
DATA_B31_94A4:
.db $08, $10, $20
	.dw SprArrange_4x2
	.dw $0000
	.dw $0000
	.dw DATA_B31_9506
DATA_B31_94AF:
.db $04, $08, $20
	.dw SprArrange_2x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_950E
DATA_B31_94BA:
.db $04, $08, $20
	.dw SprArrange_2x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9512
DATA_B31_94C5:
.db $08, $10, $20
	.dw SprArrange_4x2
	.dw $0000
	.dw $0000
	.dw DATA_B31_9516
DATA_B31_94D0:
.db $08, $10, $20
	.dw SprArrange_4x2
	.dw $0000
	.dw $0000
	.dw DATA_B31_951E
DATA_B31_94DB:
.db $08, $10, $20
	.dw SprArrange_4x2
	.dw $0000
	.dw $0000
	.dw DATA_B31_9526
DATA_B31_94E6:
.db $08, $10, $20
	.dw SprArrange_4x2
	.dw $0000
	.dw $0000
	.dw DATA_B31_952E
DATA_B31_94F1:
.db $08, $10, $20
	.dw SprArrange_4x2
	.dw $0000
	.dw $0000
	.dw DATA_B31_9536

DATA_B31_94FC:
.db $02, $04, $06, $08
DATA_B31_9500:
.db $0A, $0C
DATA_B31_9502:
.db $0E, $10, $12, $14
DATA_B31_9506:
.db $16, $18, $1A, $1C, $1E, $20, $22, $24
DATA_B31_950E:
.db $0E, $10, $12, $14
DATA_B31_9512:
.db $02, $04, $06, $08
DATA_B31_9516:
.db $16, $26, $28, $1C, $1E, $2A, $2C, $24
DATA_B31_951E:
.db $16, $2E, $30, $1C, $1E, $32, $34, $24
DATA_B31_9526:
.db $36, $38, $3A, $3C, $3E, $40, $42, $44
DATA_B31_952E:
.db $16, $46, $48, $1C, $1E, $4A, $4C, $24
DATA_B31_9536:
.db $16, $4E, $50, $1C, $1E, $52, $54, $24


DATA_B31_953E:
.dw AnimData_BlankFrame
.dw DATA_B31_9552
.dw DATA_B31_955D
.dw DATA_B31_9568
.dw DATA_B31_9573
.dw DATA_B31_957E
.dw DATA_B31_9589
.dw DATA_B31_9594
.dw DATA_B31_959F
.dw DATA_B31_95AA

DATA_B31_9552:
.db $05, $0C, $20
	.dw SprArrange_2x1_3x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_95B5
DATA_B31_955D:
.db $05, $0C, $20
	.dw SprArrange_2x1_3x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_95BA
DATA_B31_9568:
.db $06, $10, $20
	.dw SprArrange_3x1_3x1
	.dw $0000
	.dw $0004
	.dw DATA_B31_95BF
DATA_B31_9573:
.db $05, $0C, $20
	.dw SprArrange_2x1_3x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_95C5
DATA_B31_957E:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_95CA
DATA_B31_9589:
.db $05, $14, $10
	.dw SprArrange_5x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_95D0
DATA_B31_9594:
.db $03, $0C, $10
	.dw SprArrange_3x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_95D5
DATA_B31_959F:
.db $07, $0C, $30
	.dw SprArrange_2x2_1x3
	.dw $0000
	.dw $0000
	.dw DATA_B31_95D8
DATA_B31_95AA:
.db $07, $0C, $30
	.dw SprArrange_2x2_1x3
	.dw $0000
	.dw $0000
	.dw DATA_B31_95DF

DATA_B31_95B5:
.db $02, $04, $06, $08, $0A
DATA_B31_95BA:
.db $0C, $0E, $10, $12, $14
DATA_B31_95BF:
.db $16, $18, $1A, $06, $1C, $1E
DATA_B31_95C5:
.db $20, $22, $10, $12, $14
DATA_B31_95CA:
.db $24, $26, $28, $2A, $2C, $2E
DATA_B31_95D0:
.db $30, $32, $34, $36, $38
DATA_B31_95D5:
.db $3A, $3C, $3E
DATA_B31_95D8:
.db $40, $42, $20, $22, $10, $12, $14
DATA_B31_95DF:
.db $44, $46, $20, $22, $10, $12, $14


DATA_B31_95E6:
.dw AnimData_BlankFrame
.dw DATA_B31_95EE
.dw DATA_B31_95F9
.dw DATA_B31_9604

DATA_B31_95EE:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_960F
DATA_B31_95F9:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9611
DATA_B31_9604:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9613

DATA_B31_960F:
.db $40, $42
DATA_B31_9611:
.db $44, $46
DATA_B31_9613:
.db $48, $4A


DATA_B31_9615:
.dw AnimData_BlankFrame
.dw DATA_B31_9627
.dw DATA_B31_9632
.dw DATA_B31_963D
.dw DATA_B31_9648
.dw DATA_B31_9653
.dw DATA_B31_965E
.dw DATA_B31_9669
.dw DATA_B31_9674

DATA_B31_9627:
.db $0C, $10, $30
	.dw SprArrange_4x3
	.dw $0000
	.dw $0000
	.dw DATA_B31_967F
DATA_B31_9632:
.db $06, $08, $30
	.dw SprArrange_2x3
	.dw $0000
	.dw $0000
	.dw DATA_B31_968B
DATA_B31_963D:
.db $03, $04, $30
	.dw SprArrange_1x1_1x1_1x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_9691
DATA_B31_9648:
.db $06, $08, $30
	.dw SprArrange_2x3
	.dw $0000
	.dw $0000
	.dw DATA_B31_9694
DATA_B31_9653:
.db $0C, $10, $30
	.dw SprArrange_4x3
	.dw $0000
	.dw $0000
	.dw DATA_B31_969A
DATA_B31_965E:
.db $0C, $10, $30
	.dw SprArrange_4x3
	.dw $0000
	.dw $0000
	.dw DATA_B31_96A6
DATA_B31_9669:
.db $0C, $10, $30
	.dw SprArrange_4x3
	.dw $0000
	.dw $0000
	.dw DATA_B31_96B2
DATA_B31_9674:
.db $0C, $10, $30
	.dw SprArrange_4x3
	.dw $0000
	.dw $0000
	.dw DATA_B31_96BE

DATA_B31_967F:
.db $02, $04, $06, $08, $0A, $0C, $0E, $10, $00, $12, $14, $00
DATA_B31_968B:
.db $16, $18, $1A, $1C, $12, $14
DATA_B31_9691:
.db $1E, $20, $22
DATA_B31_9694:
.db $24, $26, $28, $2A, $12, $14
DATA_B31_969A:
.db $2C, $2E, $30, $32, $34, $36, $38, $3A, $00, $12, $14, $00
DATA_B31_96A6:
.db $3C, $3E, $40, $42, $44, $46, $48, $4A, $00, $12, $14, $00
DATA_B31_96B2:
.db $4C, $4E, $50, $52, $54, $56, $58, $5A, $00, $12, $14, $00
DATA_B31_96BE:
.db $02, $5C, $5E, $08, $0A, $60, $62, $10, $00, $12, $14, $00


DATA_B31_96CA:
.dw AnimData_BlankFrame
.dw DATA_B31_96D2
.dw DATA_B31_96DD
.dw DATA_B31_96E8

DATA_B31_96D2:
.db $08, $10, $20
	.dw SprArrange_4x2
	.dw $FFFE
	.dw $0000
	.dw DATA_B31_96F3
DATA_B31_96DD:
.db $08, $10, $20
	.dw SprArrange_4x2
	.dw $FFFE
	.dw $FFFE
	.dw DATA_B31_96F3
DATA_B31_96E8:
.db $08, $10, $20
	.dw SprArrange_4x2
	.dw $FFFE
	.dw $0002
	.dw DATA_B31_96F3

DATA_B31_96F3:
.db $00, $02, $04, $06, $08, $0A, $0C, $0E


DATA_B31_96FB:
.dw AnimData_BlankFrame
.dw DATA_B31_9719
.dw DATA_B31_9724
.dw DATA_B31_972F
.dw DATA_B31_973A
.dw DATA_B31_9745
.dw DATA_B31_9750
.dw DATA_B31_975B
.dw DATA_B31_9766
.dw DATA_B31_9771
.dw DATA_B31_977C
.dw DATA_B31_9787
.dw DATA_B31_9792
.dw DATA_B31_979D
.dw DATA_B31_97A8

DATA_B31_9719:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_97B3
DATA_B31_9724:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_97B9
DATA_B31_972F:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_97BF
DATA_B31_973A:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_97C5
DATA_B31_9745:
.db $08, $10, $20
	.dw SprArrange_4x2
	.dw $0000
	.dw $0000
	.dw DATA_B31_97CB
DATA_B31_9750:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_97D3
DATA_B31_975B:
.db $08, $10, $20
	.dw SprArrange_4x2
	.dw $0000
	.dw $0000
	.dw DATA_B31_97D9
DATA_B31_9766:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_97E1
DATA_B31_9771:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_97E7
DATA_B31_977C:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_97ED
DATA_B31_9787:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_97F3
DATA_B31_9792:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_97F9
DATA_B31_979D:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_97FF
DATA_B31_97A8:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9805

DATA_B31_97B3:
.db $02, $04, $06, $08, $0A, $0C
DATA_B31_97B9:
.db $0E, $04, $10, $12, $0A, $14
DATA_B31_97BF:
.db $16, $18, $1A, $1C, $1E, $20
DATA_B31_97C5:
.db $02, $22, $10, $24, $0A, $14
DATA_B31_97CB:
.db $26, $28, $2A, $2C, $2E, $30, $32, $34
DATA_B31_97D3:
.db $0E, $36, $06, $12, $0A, $0C
DATA_B31_97D9:
.db $38, $3A, $3C, $3E, $40, $42, $44, $46
DATA_B31_97E1:
.db $48, $4A, $4C, $4E, $50, $52
DATA_B31_97E7:
.db $54, $56, $58, $5A, $5C, $5E
DATA_B31_97ED:
.db $54, $60, $58, $62, $64, $66
DATA_B31_97F3:
.db $68, $6A, $6C, $6E, $70, $72
DATA_B31_97F9:
.db $74, $76, $78, $7A, $7C, $7E
DATA_B31_97FF:
.db $74, $80, $82, $84, $86, $88
DATA_B31_9805:
.db $8A, $8C, $8E, $90, $92, $94


DATA_B31_980B:
.dw AnimData_BlankFrame
.dw DATA_B31_983D
.dw DATA_B31_9848
.dw DATA_B31_98AB
.dw DATA_B31_98B6
.dw DATA_B31_983D
.dw DATA_B31_9848
.dw DATA_B31_9853
.dw DATA_B31_985E
.dw DATA_B31_9895
.dw DATA_B31_98A0
.dw DATA_B31_987F
.dw DATA_B31_988A
.dw DATA_B31_9869
.dw DATA_B31_9874
.dw DATA_B31_98AB
.dw DATA_B31_98B6
.dw DATA_B31_983D
.dw DATA_B31_9848
.dw DATA_B31_9853
.dw DATA_B31_985E
.dw DATA_B31_98B6
.dw DATA_B31_9895
.dw DATA_B31_98A0
.dw DATA_B31_98AB

DATA_B31_983D:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_98C1
DATA_B31_9848:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_98C3
DATA_B31_9853:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_98C5
DATA_B31_985E:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_98C7
DATA_B31_9869:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_98C9
DATA_B31_9874:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_98CB
DATA_B31_987F:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_98CD
DATA_B31_988A:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_98CF
DATA_B31_9895:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_98D1
DATA_B31_98A0:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_98D3
DATA_B31_98AB:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_98D5
DATA_B31_98B6:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_98D7

DATA_B31_98C1:
.db $46, $48
DATA_B31_98C3:
.db $4A, $4C
DATA_B31_98C5:
.db $4E, $50
DATA_B31_98C7:
.db $52, $54
DATA_B31_98C9:
.db $56, $58
DATA_B31_98CB:
.db $5A, $5C
DATA_B31_98CD:
.db $5E, $60
DATA_B31_98CF:
.db $62, $64
DATA_B31_98D1:
.db $66, $68
DATA_B31_98D3:
.db $6A, $6C
DATA_B31_98D5:
.db $6E, $70
DATA_B31_98D7:
.db $72, $74


DATA_B31_98D9:
.dw AnimData_BlankFrame
.dw DATA_B31_98E7
.dw DATA_B31_98F2
.dw DATA_B31_98FD
.dw DATA_B31_9908
.dw DATA_B31_9913
.dw DATA_B31_991E

DATA_B31_98E7:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9929
DATA_B31_98F2:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_992A
DATA_B31_98FD:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_992B
DATA_B31_9908:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_992C
DATA_B31_9913:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_992D
DATA_B31_991E:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_992E

DATA_B31_9929:
.db $02
DATA_B31_992A:
.db $04
DATA_B31_992B:
.db $06
DATA_B31_992C:
.db $08
DATA_B31_992D:
.db $0A
DATA_B31_992E:
.db $0C


DATA_B31_992F:
.dw AnimData_BlankFrame
.dw DATA_B31_9935
.dw DATA_B31_9940

DATA_B31_9935:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_994B
DATA_B31_9940:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_994C

DATA_B31_994B:
.db $0E
DATA_B31_994C:
.db $10


DATA_B31_994D:
.dw AnimData_BlankFrame
.dw DATA_B31_9961
.dw DATA_B31_996C
.dw DATA_B31_9977
.dw DATA_B31_9982
.dw DATA_B31_996C
.dw DATA_B31_9982
.dw DATA_B31_998D
.dw DATA_B31_9998
.dw DATA_B31_99A3

DATA_B31_9961:
.db $0A, $10, $40
	.dw SprArrange_4x1_2x3
	.dw $0000
	.dw $0000
	.dw DATA_B31_99AE
DATA_B31_996C:
.db $0A, $10, $40
	.dw SprArrange_4x1_2x3
	.dw $0000
	.dw $0000
	.dw DATA_B31_99B8
DATA_B31_9977:
.db $0A, $10, $40
	.dw SprArrange_4x1_2x3
	.dw $0000
	.dw $0000
	.dw DATA_B31_99C2
DATA_B31_9982:
.db $0A, $10, $40
	.dw SprArrange_4x1_2x3
	.dw $0000
	.dw $0000
	.dw DATA_B31_99CC
DATA_B31_998D:
.db $0C, $10, $30
	.dw SprArrange_4x3
	.dw $0000
	.dw $0000
	.dw DATA_B31_99D6
DATA_B31_9998:
.db $0C, $10, $30
	.dw SprArrange_4x3
	.dw $0000
	.dw $0000
	.dw DATA_B31_99E2
DATA_B31_99A3:
.db $0C, $10, $30
	.dw SprArrange_4x3
	.dw $0000
	.dw $0000
	.dw DATA_B31_99EE

DATA_B31_99AE:
.db $12, $14, $16, $18, $1A, $1C, $1A, $1C, $1A, $1C
DATA_B31_99B8:
.db $12, $1E, $16, $18, $1A, $1C, $1A, $1C, $1A, $1C
DATA_B31_99C2:
.db $12, $14, $20, $22, $1A, $1C, $1A, $1C, $1A, $1C
DATA_B31_99CC:
.db $12, $24, $20, $22, $1A, $1C, $1A, $1C, $1A, $1C
DATA_B31_99D6:
.db $40, $42, $44, $46, $48, $4A, $4C, $4E, $00, $50, $52, $54
DATA_B31_99E2:
.db $40, $42, $44, $46, $48, $56, $58, $5A, $00, $5C, $5E, $60
DATA_B31_99EE:
.db $40, $42, $44, $46, $48, $62, $64, $66, $00, $68, $6A, $6C


DATA_B31_99FA:
.dw AnimData_BlankFrame
.dw DATA_B31_9A02
.dw DATA_B31_9A0D
.dw DATA_B31_9A0D

DATA_B31_9A02:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9A23
DATA_B31_9A0D:
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9A24
DATA_B31_9A18:		;NOTE: seems to be unused
.db $01, $04, $10
	.dw SprArrange_1x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9A25

DATA_B31_9A23:
.db $3A
DATA_B31_9A24:
.db $3C
DATA_B31_9A25:
.db $3E


DATA_B31_9A26:
.dw AnimData_BlankFrame
.dw DATA_B31_9A2A

DATA_B31_9A2A:
.db $0C, $10, $40
	.dw SprArrange_6x2
	.dw $0000
	.dw $0000
	.dw DATA_B31_9A40
DATA_B31_9A35:
.db $0C, $10, $40
	.dw SprArrange_2x2_2x2_2x2_Diag
	.dw $0000
	.dw $0000
	.dw DATA_B31_9A40

DATA_B31_9A40:
.db $02, $04, $06, $08, $0A, $0C, $0E, $10, $12, $14, $16, $18


DATA_B31_9A4C:
.dw AnimData_BlankFrame
.dw DATA_B31_9A78
.dw DATA_B31_9A83
.dw DATA_B31_9A8E
.dw DATA_B31_9A99
.dw DATA_B31_9AA4
.dw DATA_B31_9AAF
.dw DATA_B31_9ABA
.dw DATA_B31_9AC5
.dw DATA_B31_9AD0
.dw DATA_B31_9ADB
.dw DATA_B31_9AE6
.dw DATA_B31_9AF1
.dw DATA_B31_9AFC
.dw DATA_B31_9B07
.dw DATA_B31_9B12
.dw DATA_B31_9B1D
.dw DATA_B31_9B28
.dw DATA_B31_9A2A
.dw DATA_B31_9A35
.dw DATA_B31_9B33
.dw DATA_B31_9B3E

DATA_B31_9A78:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9B49
DATA_B31_9A83:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9B4F
DATA_B31_9A8E:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9B55
DATA_B31_9A99:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9B5B
DATA_B31_9AA4:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9B61
DATA_B31_9AAF:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw  DATA_B31_9B67
DATA_B31_9ABA:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9B6D
DATA_B31_9AC5:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9B73
DATA_B31_9AD0:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9B79
DATA_B31_9ADB:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0002
	.dw $0000
	.dw DATA_B31_9B7F
DATA_B31_9AE6:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0002
	.dw $0000
	.dw DATA_B31_9B85
DATA_B31_9AF1:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0002
	.dw $0000
	.dw DATA_B31_9B8B
DATA_B31_9AFC:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0002
	.dw $0000
	.dw DATA_B31_9B91
DATA_B31_9B07:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9B97
DATA_B31_9B12:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9B9D
DATA_B31_9B1D:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9BA3
DATA_B31_9B28:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9BA9
DATA_B31_9B33:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9BAF
DATA_B31_9B3E:
.db $06, $0C, $20
	.dw SprArrange_3x2_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9BB5

DATA_B31_9B49:
.db $02, $04, $00, $06, $08, $0A
DATA_B31_9B4F:
.db $0C, $0E, $00, $06, $08, $0A
DATA_B31_9B55:
.db $10, $12, $00, $14, $16, $0A
DATA_B31_9B5B:
.db $18, $1A, $00, $1C, $1E, $0A
DATA_B31_9B61:
.db $20, $22, $00, $24, $26, $28
DATA_B31_9B67:
.db $2A, $2C, $00, $2E, $30, $0A
DATA_B31_9B6D:
.db $32, $34, $00, $36, $38, $3A
DATA_B31_9B73:
.db $3C, $3E, $00, $40, $42, $0A
DATA_B31_9B79:
.db $02, $04, $00, $44, $46, $0A
DATA_B31_9B7F:
.db $48, $4A, $4C, $4E, $50, $52
DATA_B31_9B85:
.db $54, $56, $58, $5A, $5C, $5E
DATA_B31_9B8B:
.db $60, $62, $64, $66, $68, $6A
DATA_B31_9B91:
.db $6C, $6E, $70, $72, $74, $76
DATA_B31_9B97:
.db $78, $7A, $7C, $7E, $80, $82
DATA_B31_9B9D:
.db $78, $84, $86, $7E, $88, $8A
DATA_B31_9BA3:
.db $78, $8C, $8E, $7E, $90, $92
DATA_B31_9BA9:
.db $78, $94, $96, $7E, $98, $9A
DATA_B31_9BAF:
.db $9E, $A0, $A2, $A4, $A6, $A8
DATA_B31_9BB5:
.db $AC, $AE, $B0, $B2, $B4, $B6


DATA_B31_9BBB:
.dw AnimData_BlankFrame
.dw DATA_B31_9BC1
.dw DATA_B31_9BCC

DATA_B31_9BC1:
.db $0B, $20, $30
	.dw SprArrange_4x2_3x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_9BD7
DATA_B31_9BCC:
.db $0B, $20, $30
	.dw SprArrange_4x2_3x1
	.dw $0000
	.dw $0000
	.dw DATA_B31_9BE2

DATA_B31_9BD7:
.db $02, $04, $06, $00, $08, $0A, $0C, $0E, $10, $12, $14
DATA_B31_9BE2:
.db $02, $04, $06, $00, $16, $0A, $18, $1A, $1C, $1E, $20


DATA_B31_9BED:
.dw AnimData_BlankFrame
.dw DATA_B31_9C03
.dw DATA_B31_9C0E
.dw DATA_B31_9C19
.dw DATA_B31_9C24
.dw DATA_B31_9C24
.dw DATA_B31_9C2F
.dw DATA_B31_9C3A
.dw DATA_B31_9C45
.dw DATA_B31_9C50
.dw DATA_B31_9C5B

DATA_B31_9C03:
.db $04, $1C, $40
	.dw SprArrange_4x1
	.dw $FFCE
	.dw $0004
	.dw DATA_B31_9C66
DATA_B31_9C0E:
.db $04, $1C, $40
	.dw SprArrange_4x1
	.dw $FFCE
	.dw $0004
	.dw DATA_B31_9C6A
DATA_B31_9C19:
.db $08, $1C, $40
	.dw SprArrange_4x2
	.dw $FFCE
	.dw $0004
	.dw DATA_B31_9C6E
DATA_B31_9C24:
.db $08, $1C, $40
	.dw SprArrange_4x2
	.dw $FFCE
	.dw $0004
	.dw DATA_B31_9C76
DATA_B31_9C2F:
.db $08, $10, $20
	.dw SprArrange_4x2
	.dw $0000
	.dw $0000
	.dw DATA_B31_9C7E
DATA_B31_9C3A:
.db $08, $10, $20
	.dw SprArrange_4x2
	.dw $0000
	.dw $0000
	.dw DATA_B31_9C86
DATA_B31_9C45:
.db $08, $10, $20
	.dw SprArrange_4x2
	.dw $0000
	.dw $0000
	.dw DATA_B31_9C8E
DATA_B31_9C50:
.db $08, $10, $20
	.dw SprArrange_4x2
	.dw $0000
	.dw $0000
	.dw DATA_B31_9C96
DATA_B31_9C5B:
.db $08, $10, $20
	.dw SprArrange_4x2
	.dw $FFDE
	.dw $0000
	.dw DATA_B31_9C96

DATA_B31_9C66:
.db $02, $04, $06, $08
DATA_B31_9C6A:
.db $0A, $0C, $0E, $10
DATA_B31_9C6E:
.db $12, $14, $16, $18, $1A, $1C, $1E, $20
DATA_B31_9C76:
.db $22, $00, $24, $26, $28, $2A, $2C, $2E
DATA_B31_9C7E:
.db $30, $32, $34, $36, $38, $3A, $3C, $3E
DATA_B31_9C86:
.db $40, $42, $44, $46, $48, $4A, $4C, $4E
DATA_B31_9C8E
.db $50, $52, $54, $56, $58, $5A, $5C, $5E
DATA_B31_9C96:
.db $60, $62, $64, $66, $68, $5A, $6A, $5E


DATA_B31_9C9E:
.dw AnimData_BlankFrame
.dw DATA_B31_9CAC
.dw DATA_B31_9CB7
.dw DATA_B31_9CC2
.dw DATA_B31_9CCD
.dw DATA_B31_9CD8
.dw DATA_B31_9CE3

DATA_B31_9CAC:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9CEE
DATA_B31_9CB7:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9CF0
DATA_B31_9CC2:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9CF2
DATA_B31_9CCD:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9CF4
DATA_B31_9CD8:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9CF6
DATA_B31_9CE3:
.db $02, $08, $10
	.dw SprArrange_2x1_BC
	.dw $0000
	.dw $0000
	.dw DATA_B31_9CF8

DATA_B31_9CEE:
.db $02, $04
DATA_B31_9CF0:
.db $06, $08
DATA_B31_9CF2:
.db $0A, $0C
DATA_B31_9CF4:
.db $0E, $10
DATA_B31_9CF6:
.db $12, $14
DATA_B31_9CF8:
.db $16, $18


DATA_B31_9CFA:
.dw AnimData_BlankFrame
.dw DATA_B31_9D00
.dw DATA_B31_9D0B

DATA_B31_9D00:
.db $0C, $10, $30
	.dw SprArrange_4x3
	.dw $0000
	.dw $0000
	.dw DATA_B31_9D16
DATA_B31_9D0B:
.db $0C, $10, $30
	.dw SprArrange_4x3
	.dw $0000
	.dw $0000
	.dw DATA_B31_9D22

DATA_B31_9D16:
.db $02, $04, $06, $00, $08, $0A, $0C, $0E, $00, $10, $12, $14
DATA_B31_9D22:
.db $02, $04, $06, $00, $16, $0A, $18, $1A, $00, $1C, $1E, $20


.include "src\sprite_arrangement_data.asm"
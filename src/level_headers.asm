LevelHeaders:		;$55E5
.dw	LevelHeaders_UGZ
.dw LevelHeaders_SHZ
.dw LevelHeaders_ALZ
.dw LevelHeaders_GHZ
.dw LevelHeaders_GMZ
.dw LevelHeaders_SEZ
.dw LevelHeaders_CEZ
.dw LevelHeaders_UNK1
.dw LevelHeaders_UNK2
.dw LevelHeaders_Intro_Title

LevelHeaders_UGZ:
.dw LevelHeader_UGZ1
.dw LevelHeader_UGZ2
.dw LevelHeader_UGZ3

LevelHeaders_SHZ:
.dw LevelHeader_SHZ1
.dw LevelHeader_SHZ2
.dw LevelHeader_SHZ3

LevelHeaders_ALZ:
.dw LevelHeader_ALZ1
.dw LevelHeader_ALZ2
.dw LevelHeader_ALZ3

LevelHeaders_GHZ:
.dw LevelHeader_GHZ1
.dw LevelHeader_GHZ2
.dw LevelHeader_GHZ3

LevelHeaders_GMZ:
.dw LevelHeader_GMZ1
.dw LevelHeader_GMZ2
.dw LevelHeader_GMZ3

LevelHeaders_SEZ:
.dw LevelHeader_SEZ1
.dw LevelHeader_SEZ2
.dw LevelHeader_SEZ3

LevelHeaders_CEZ:
.dw LevelHeader_CEZ1
.dw LevelHeader_CEZ2
.dw LevelHeader_CEZ3

LevelHeaders_UNK1:
.dw LevelHeader_5803
.dw LevelHeader_5819
.dw LevelHeader_5803

LevelHeaders_UNK2:
.dw LevelHeader_SEZ1
.dw LevelHeader_SEZ2
.dw LevelHeader_SEZ3

LevelHeaders_Intro_Title:
.dw LevelHeader_Intro
.dw LevelHeader_Title
.dw LevelHeader_Title


;LevelHeader_UGZ1:
;.db :Mappings32_UGZ	;bank number for 32x32 mappings
;.dw Mappings32_UGZ		;pointer to 32x32 mappings
;.db :Layout_UGZ1		;bank number for level layout
;.dw Layout_UGZ1		;level layout pointer
;.dw $00A8				;level width in blocks
;.dw $FF58				;2's comp level width in blocks
;.dw $0498				;vertical offset into layout - i.e. the row
						;that appears at the bottom of the screen when
						;the player starts the level (7 * level width).
;.dw $0008				;minimum camera x pos
;.dw $0008				;minimum camera y pos
;.dw $1400				;max camera x pos
;.dw $0210				;max camera ypos
;.dw MultTable_168		;pointer to block row offsets (must point to 
						;table of multiples of level width)


LevelHeader_GHZ1:
.db :Mappings32_GHZ
.dw Mappings32_GHZ
.db :Layout_GHZ1
.dw Layout_GHZ1
.dw $0100
.dw $FF00
.dw $0700
.dw $0008
.dw $0008
.dw $1F00
.dw $0110
.dw MultTable_256

LevelHeader_GHZ2:
.db :Mappings32_GHZ
.dw Mappings32_GHZ
.db :Layout_GHZ2
.dw Layout_GHZ2
.dw $0100
.dw $FF00
.dw $0700
.dw $0008
.dw $0008
.dw $1F00
.dw $0110
.dw MultTable_256

LevelHeader_GHZ3:
.db :Mappings32_GHZ
.dw Mappings32_GHZ
.db :Layout_GHZ3
.dw Layout_GHZ3
.dw $00A8
.dw $FF58
.dw $0498
.dw $0008
.dw $0008
.dw $1400
.dw $0210
.dw MultTable_168

LevelHeader_SHZ1:
.db :Mappings32_SHZ1_3
.dw Mappings32_SHZ1_3
.db :Layout_SHZ1
.dw Layout_SHZ1
.dw $0060
.dw $FFA0
.dw $02A0
.dw $0008
.dw $0008
.dw $0B00
.dw $0410
.dw MultTable_96

LevelHeader_SHZ2:
.db :Mappings32_SHZ2
.dw Mappings32_SHZ2
.db :Layout_SHZ2
.dw Layout_SHZ2
.dw $0080
.dw $FF80
.dw $0380
.dw $0008
.dw $0008
.dw $0F00
.dw $0310
.dw MultTable_128

LevelHeader_SHZ3:
.db :Mappings32_SHZ1_3
.dw Mappings32_SHZ1_3
.db :Layout_SHZ3
.dw Layout_SHZ3
.dw $0060
.dw $FFA0
.dw $02A0
.dw $0008
.dw $0008
.dw $0B00
.dw $0210
.dw MultTable_96


LevelHeader_ALZ1:
.db :Mappings32_ALZ
.dw Mappings32_ALZ
.db :Layout_ALZ1
.dw Layout_ALZ1
.dw $0080
.dw $FF80
.dw $0380
.dw $0008
.dw $0008
.dw $0F00
.dw $0310
.dw MultTable_128

LevelHeader_ALZ2:
.db :Mappings32_ALZ2
.dw Mappings32_ALZ2
.db :Layout_ALZ2
.dw Layout_ALZ2
.dw $0048
.dw $FFB8
.dw $01F8
.dw $0008
.dw $0008
.dw $0800
.dw $0610
.dw MultTable_72

LevelHeader_ALZ3:
.db :Mappings32_ALZ
.dw Mappings32_ALZ
.db :Layout_ALZ3
.dw Layout_ALZ3
.dw $0080
.dw $FF80
.dw $0380
.dw $0008
.dw $0008
.dw $0F00
.dw $0310
.dw MultTable_128


LevelHeader_UGZ1:
.db :Mappings32_UGZ		;bank number for 32x32 mappings
.dw Mappings32_UGZ		;pointer to 32x32 mappings
.db :Layout_UGZ1		;bank number for level layout
.dw Layout_UGZ1			;level layout pointer
.dw $00A8				;level width in blocks?
.dw $FF58				;2's comp level width in blocks
.dw $0498				;vertical offset into layout
.dw $0008				;minimum camera x pos
.dw $0008				;minimum camera y pos
.dw $1400				;max camera x pos
.dw $0210				;max camera ypos
.dw MultTable_168			;pointer to block row offsets


LevelHeader_UGZ2:
.db :Mappings32_UGZ
.dw Mappings32_UGZ
.db :Layout_UGZ2
.dw Layout_UGZ2
.dw $00A8
.dw $FF58
.dw $0498
.dw $0008
.dw $0008
.dw $1400
.dw $0210
.dw MultTable_168

LevelHeader_UGZ3:
.db :Mappings32_UGZ
.dw Mappings32_UGZ
.db :Layout_UGZ3
.dw Layout_UGZ3
.dw $0080
.dw $FF80
.dw $0380
.dw $0008
.dw $0008
.dw $0F00
.dw $0310
.dw	MultTable_128

LevelHeader_GMZ1:
.db :Mappings32_GMZ
.dw Mappings32_GMZ
.db :Layout_GMZ1
.dw Layout_GMZ1
.dw $0060
.dw $FFA0
.dw $02A0
.dw $0008
.dw $0008
.dw $0B00
.dw $0410
.dw MultTable_96

LevelHeader_GMZ2:
.db :Mappings32_GMZ
.dw Mappings32_GMZ
.db :Layout_GMZ2
.dw Layout_GMZ2
.dw $0080
.dw $FF80
.dw $0380
.dw $0008
.dw $0008
.dw $0F00
.dw $0310
.dw MultTable_128

LevelHeader_GMZ3:
.db :Mappings32_GMZ
.dw Mappings32_GMZ
.db :Layout_GMZ3
.dw Layout_GMZ3
.dw $0028
.dw $FFD8
.dw $0118
.dw $0008
.dw $0008
.dw $0400
.dw $0510
.dw MultTable_40


LevelHeader_SEZ1:
.db :Mappings32_SEZ1_3
.dw Mappings32_SEZ1_3
.db :Layout_SEZ1
.dw Layout_SEZ1
.dw $0028
.dw $FFD8
.dw $0118
.dw $0008
.dw $0008
.dw $0400
.dw $0B10
.dw MultTable_40

LevelHeader_SEZ2:
.db :Mappings32_SEZ2
.dw Mappings32_SEZ2
.db :Layout_SEZ2
.dw Layout_SEZ2
.dw $0080
.dw $FF80
.dw $0380
.dw $0008
.dw $0008
.dw $0F00
.dw $0310
.dw MultTable_128

LevelHeader_SEZ3:
.db :Mappings32_SEZ1_3
.dw Mappings32_SEZ1_3
.db :Layout_SEZ3
.dw Layout_SEZ3
.dw $0018
.dw $FFE8
.dw $00A8
.dw $0008
.dw $0008
.dw $0200
.dw $0E10
.dw MultTable_24

LevelHeader_CEZ1:
.db :Mappings32_CEZ1_2
.dw Mappings32_CEZ1_2
.db :Layout_CEZ1
.dw Layout_CEZ1
.dw $00A8
.dw $FF58
.dw $0498
.dw $0008
.dw $0008
.dw $1400
.dw $0210
.dw MultTable_168

LevelHeader_CEZ2:
.db :Mappings32_CEZ1_2
.dw Mappings32_CEZ1_2
.db :Layout_CEZ2
.dw Layout_CEZ2
.dw $0038
.dw $FFC8
.dw $0188
.dw $0008
.dw $0008
.dw $0600
.dw $0810
.dw MultTable_56

LevelHeader_CEZ3:
.db :Mappings32_CEZ3
.dw Mappings32_CEZ3
.db :Layout_CEZ3
.dw Layout_CEZ3
.dw $0028
.dw $FFD8
.dw $0118
.dw $0008
.dw $0008
.dw $0400
.dw $0110
.dw MultTable_40

LevelHeader_5803:
.db :Mappings32_Ending
.dw Mappings32_Ending
.db :Layout_Bad_Ending
.dw Layout_Bad_Ending
.dw $0020
.dw $FFE0
.dw $00E0
.dw $0008
.dw $0008
.dw $0300
.dw $0110
.dw MultTable_32

LevelHeader_5819:
.db :Mappings32_Ending
.dw Mappings32_Ending
.db :Layout_Good_Ending
.dw Layout_Good_Ending
.dw $0020
.dw $FFE0
.dw $00E0
.dw $0008
.dw $0008
.dw $0300
.dw $0110
.dw MultTable_32

LevelHeader_Intro:
.db :Mappings32_Intro
.dw Mappings32_Intro
.db :Layout_Intro
.dw Layout_Intro
.dw $0010
.dw $FFF0
.dw $0070
.dw $0008
.dw $0008
.dw $0100
.dw $0110
.dw MultTable_16

LevelHeader_Title:
.db :Mappings32_Title
.dw Mappings32_Title
.db :Layout_Title
.dw Layout_Title
.dw $0010
.dw $FFF0
.dw $0070
.dw $0008
.dw $0008
.dw $0100
.dw $0110
.dw MultTable_16

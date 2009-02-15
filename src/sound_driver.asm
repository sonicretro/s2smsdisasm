.BANK 2 SLOT 2
.ORG $0000
Bank2:

LABEL_8000_92:
	ld   hl, $DD08
	ld   a, (hl)
	or   a
	jr   z, +
	ret  p					;return if MSB of $DD08 is set

	dec  (hl)
	jp   Sound_ResetChannels

+:	call LABEL_809F_94		;load sound value into control byte
	call LABEL_8086_97		;tempo? increments counter for each channel
	call LABEL_80D0_99		;
	call LABEL_8139_109
	ld   a, ($DE91)
	or   a
	jp   z, LABEL_8038_122
	ld   a, ($DE92)
	inc  a
	cp   $05
	jr   z, LABEL_802D_123
	ld   ($DE92), a
	jp   LABEL_8038_122

LABEL_802D_123:
	xor  a
	ld   ($DE92), a
	call LABEL_8038_122
	call LABEL_8038_122
	ret

LABEL_8038_122:
	ld   ix, $DD40
	bit  7, (ix+0)
	call nz, LABEL_84D4_124		;tone 0 - music
	ld   ix, $DD70
	bit  7, (ix+0)
	call nz, LABEL_84D4_124		;tone 1 - music
	ld   ix, $DDA0
	bit  7, (ix+0)
	call nz, LABEL_84D4_124		;tone 2	- music
	ld   ix, $DDD0
	bit  7, (ix+0)
	call nz, LABEL_865C_178		;noise
	ld   ix, $DE00
	bit  7, (ix+0)
	call nz, LABEL_84D4_124		;tone 0 - SFX
	ld   ix, $DE30
	bit  7, (ix+0)
	call nz, LABEL_84D4_124
	ld   ix, $DE60
	bit  7, (ix+0)
	call nz, LABEL_84D4_124
	ret



LABEL_8086_97:
	ld		hl, $DD01		;decrement counter value
	ld		a, (hl)
	or		a
	ret		z
	dec		(hl)
	ret		nz
	ld		a, ($DD02)		;restore counter value
	ld		(hl), a
	ld		hl, $DD4A		;increment the counter value
	ld		de, $0030		;for the 4 channels
	ld		b, $04
-:	inc		(hl)
	add		hl, de
	djnz	-
	ret


LABEL_809F_94:
	ld   de, $DD04	;current track number
	ld   ix, $DD0F
	ld   iy, $DD03
	call LABEL_80B0_95
	call LABEL_80B0_95
LABEL_80B0_95:
	ld   a, (de)		;get current sound number
	and  $7F			;ignore MSB
	jr   z, +			;jump if sound number $00
	
	dec  a				;use A to calculate pointer to data
	ld   hl, DATA_8B95
	ld   c, a
	ld   b, $00
	add  hl, bc
	
	ld   a, (hl)
	cp   (ix+0)
	jr   c, +			;jump if $DD0F < A
	and  $7F
	ld   (ix+0), a		;DD0F
	ld   a, (de)
	ld   (iy+0), a		;DD03
+:	xor  a
	ld   (de), a
	inc  de
	ret

LABEL_80D0_99:
	ld		a, ($DD09)			;volume fade out?
	or		a
	ret		z
	ld		hl, $DE00
	ld		b, $03
	ld		de, $0030
LABEL_80DD_103:
	bit		7, (hl)
	jp		z, LABEL_8104_100
	push	hl
	inc		hl
	ld		a, (hl)
	cp		$A0
	jp		nz, LABEL_80F2_101
	ld		hl, $DD70
	res		2, (hl)
	jp		LABEL_8101_102

LABEL_80F2_101:
	cp   $E0
	jp   nz, LABEL_80FC_108
	ld   hl, $DDD0
	res  2, (hl)
LABEL_80FC_108:
	ld   hl, $DDA0
	res  2, (hl)
LABEL_8101_102:
	pop  hl
	xor  a
	ld   (hl), a
LABEL_8104_100:
	add  hl, de
	djnz LABEL_80DD_103
	ld   a, ($DD0A)
	dec  a
	jr   z, LABEL_8111_104
	ld   ($DD0A), a
	ret

LABEL_8111_104:
	ld   a, ($DD0B)
	ld   ($DD0A), a
	ld   a, ($DD09)
	dec  a
	ld   ($DD09), a
	jp   z, Sound_ResetAll
	ld   hl, $DD46
	ld   de, $0030
	ld   b, $03
LABEL_8129_107:
	call LABEL_8132_106
	add  hl, de
	djnz LABEL_8129_107
	ld   hl, $DD16
LABEL_8132_106:
	ld   a, (hl)
	inc  a
	cp   $0C
	ret  nc
	ld   (hl), a
	ret

LABEL_8139_109:
	ld   a, ($DD03)
	bit  7, a
	jp   z, Sound_ResetAll
	cp   $9A
	jr   c, $43
	cp   $C0
	jp   c, LABEL_81C7_111
	cp   $C4
	jp   nc, Sound_ResetAll
	sub  $C0
	ld   hl, DATA_8158
	call LABEL_842F_112
	jp   (hl)


DATA_8158:
.dw LABEL_8160
.dw Sound_ResetAll
.dw LABEL_8170
.dw $7000

LABEL_8160:
	ld	 a, $0C
	ld   ($DD09), a
	ld	 a, $12
	ld	 ($DD0A), a
	ld	 ($DD0B), a
	jp	 StopMusic

LABEL_8170:
	ld	 iy, $DE00
	ld	 de, $0030
	ld	 b, $03
	ld	 hl, LABEL_8187
-:	ld	 (iy+$03), l
	ld	 (iy+$04), h
	add	 iy, de
	djnz -
	ret

LABEL_8187:
	jp	 p, LABEL_81D6
	ret  m
	ex   af, af'
	call Sound_ResetAll
	ex   af, af'
	ld   hl, $8BD4
	ld   c, a
	ex   af, af'
	call LABEL_8439_119
	ld   ($DD01), a
	ld   ($DD02), a
	ex   af, af'
	ld   hl, $8BE7
	call LABEL_842F_112
	inc  hl
	inc  hl
	ld   b, (hl)
	inc  hl
	inc  hl
	ld   a, (hl)
	ex   af, af'
	inc  hl
	ld   a, (hl)
	ld   ($DD01), a
	ld   ($DD02), a
	ld   iy, DATA_8284
	inc  hl
	ld   de, $DD40
LABEL_81BC_121:
	call LABEL_824C_120
	djnz LABEL_81BC_121
LABEL_81C1_9:
StopMusic:
	ld		a, $80		
	ld		($DD03), a
	ret

LABEL_81C7_111:
	ld		($DD0D), a
	sub		$9A
	ld		hl, $8C0D
	call	LABEL_842F_112
	inc		hl
	inc		hl
	ld		a, (hl)
	inc		hl
LABEL_81D6:
	ex		af, af'
	ld		b, (hl)
	inc		hl
LABEL_81D9_117:
	inc		hl
	ld		a, (hl)
	dec		hl
	cp		$A0
	jr		z, LABEL_8208_113
	cp		$C0
	jr		z, LABEL_81ED_114
	ld		de, $DE60
	ld		iy, $DDD0
	jr		LABEL_820F_115

LABEL_81ED_114:
	ld		iy, $DE60
	bit		6, (iy+0)
	jr		nz, LABEL_81FF_118
	set		2, (iy+0)
	ld		a, $FF			;noise volume = off
	out		($7F), a
LABEL_81FF_118:
	ld		de, $DE30
	ld		iy, $DDA0
	jr		LABEL_820F_115

LABEL_8208_113:
	ld		de, $DE00
	ld		iy, $DD70
LABEL_820F_115:
	call	LABEL_8217_116
	djnz	LABEL_81D9_117
	jp		StopMusic

LABEL_8217_116:
	set		2, (iy+0)
	ld		c, $36
	push	de
	pop		ix
	ldi
	ldi
	ex		af, af'
	ld		(de), a
	inc		de
	ex		af, af'
	xor		a
	ldi
	ldi
	ldi
	ldi
	ld		(de), a
	inc		de
	ld		(de), a
	inc		de
	ld		a, c
	ld		(de), a
	inc		de
	xor		a
	ld		(ix+39), a
	ld		(ix+40), a
	ld		(ix+41), a
	inc		a
	ld		(de), a
	push	hl
	ld		hl, $0026
	add		hl, de
	ex		de, hl
	pop		hl
	ret

LABEL_824C_120:
	ld		c, $34
	push	de
	pop		ix
	ld		a, $80
	ld		(de), a
	inc		de
	ld		a, (iy+0)
	ld		(de), a
	inc		de
	inc		iy
	ex		af, af'
	ld		(de), a
	inc		de
	ex		af, af'
	xor		a
	ldi
	ldi
	ldi
	ldi
	ld		(de), a
	inc		de
	ld		(de), a
	inc		de
	ld		a, c
	ld		(de), a
	inc		de
	xor		a
	ld		(ix+39), a
	ld		(ix+40), a
	ld		(ix+41), a
	inc		a
	ld		(de), a
	push	hl
	ld		hl, $0026
	add		hl, de
	ex		de, hl
	pop		hl
	ret


DATA_8284:
.db $80, $A0, $C0, $E0


LABEL_8288_141:
	bit		7, (ix+7)
	ret		z
	bit		1, (ix+0)
	ret		nz
	ld		e, (ix+$10)
	ld		d, (ix+$11)
	push	ix
	pop		hl
	ld		b, $00
	ld		c, $14
	add		hl, bc
	ex		de, hl
	ldi
	ldi
	ldi
	ld		a, (hl)
	srl		a
	ld		(de), a
	xor		a
	ld		(ix+$12), a
	ld		(ix+$13), a
	ret

LABEL_82B3_142:
	bit		7, (ix+$08)
	ret		z

	bit		1, (ix+$00)
	ret		nz

	bit		7, (ix+$1D)
	ret		nz

	ld		a, $FF
	ld		(ix+$1F), a
	and		$10
	or		(ix+$1E)
	ld		(ix+$1D), a
	ret

LABEL_82D0_145:
	ld		l, (ix+$0B)
	ld		h, (ix+$0C)

	ld		a, (ix+$07)
	or		a
	ret		z

	jp		p, LABEL_8326_146

	dec		(ix+$14)	;return if ix+$14 != 1
	ret		nz

	inc		(ix+$14)	;ix+$14 = 1
	
	push	hl
	
	ld		l, (ix+$12)
	ld		h, (ix+$13)
	
	dec		(ix+$15)		;if (--(ix+$15) == 0) {
	jr		nz, +

	ld		e, (ix+$10)		;	IY = (IX+$10)
	ld		d, (ix+$11)
	push	de
	pop		iy
	
	ld		a, (iy+$01)		;	(IX+$15) = (IY+$01)
	ld		(ix+$15), a

	ld		a, (ix+$16)
	ld		c, a
	and		$80
	rlca
	neg
	ld		b, a
	add		hl, bc
	ld		(ix+$12), l
	ld		(ix+$13), h
							;}
+:	pop		bc				;BC = previous HL value ( ix+$0B )

	add		hl, bc
	dec		(ix+$17)
	ret		nz
	
	ld		a, (iy+$03)
	ld		(ix+$17), a
	ld		a, (ix+$16)
	neg
	ld		(ix+$16), a
	ret

LABEL_8326_146:
	dec  a
	ex   de, hl
	ld   hl, DATA_88DE
	call LABEL_842F_112
	jr   LABEL_8333_148

LABEL_8330_153:
	ld   (ix+21), a
LABEL_8333_148:
	push hl
	ld   c, (ix+21)
	call LABEL_8439_119
	pop  hl
	bit  7, a
	jr   z, LABEL_835A_149
	cp   $83
	jr   z, LABEL_834F_150
	jr   nc, LABEL_8356_151
	cp   $80
	jr   z, LABEL_8353_152
	set  5, (ix+0)
	pop  hl
	ret

LABEL_834F_150:
	inc  de
	ld   a, (de)
	jr   LABEL_8330_153

LABEL_8353_152:
	xor  a
	jr   LABEL_8330_153

LABEL_8356_151:
	ld   h, $FF
	jr   LABEL_835C_154

LABEL_835A_149:
	ld   h, $00
LABEL_835C_154:
	ld   l, a
	add  hl, de
	inc  (ix+21)
	ret

LABEL_8362_126:
	res  1, (ix+0)
	res  4, (ix+0)
	ld   e, (ix+$03)	;read tone pointer
	ld   d, (ix+$04)
LABEL_8370:
	ld   a, (de)		;read tone
	inc  de
	cp   $E0			;control byte?
	jp   nc, LABEL_86E8_127
	bit  3, (ix+0)
	jp   nz, LABEL_83DC_128
	cp   $80
	jr   c, LABEL_83A6_129
	jr   z, LABEL_83D7_130
	ex   af, af'
	ld   a, (ix+$1D)
	and  $7F
	ld   (ix+$1D), a
	ex   af, af'
	call LABEL_8427_131
	ld   (ix+$0B), l
	ld   (ix+$0C), h
LABEL_8397_136:
	ld   a, (de)
	inc  de
	or   a
	jp   p, LABEL_83A6_129
	ld   a, (ix+$0D)
	ld   (ix+$0A), a
	dec  de
	jr   LABEL_83AF_132

LABEL_83A6_129:
	call LABEL_843E
	ld   (ix+$0A), a
	ld   (ix+$0D), a
LABEL_83AF_132:
	ld   (ix+$03), e		;store tone pointer
	ld   (ix+$04), d
	bit  1, (ix+0)
	ret  nz

	bit  6, (ix+0)
	jr   nz, LABEL_83C4_133
	res  5, (ix+0)
LABEL_83C4_133:
	ld   a, (ix+$0F)
	ld   (ix+$0E), a
	xor  a
	ld   (ix+$15), a
	bit  7, (ix+8)
	ret  nz

	ld   (ix+$1F), a
	ret

LABEL_83D7_130:
	call LABEL_85F8_134
	jr   LABEL_8397_136

LABEL_83DC_128:
	ld   h, a
	ld   a, (de)
	inc  de
	ld   l, a
	or   h
	jr   z, LABEL_83EF_139
	ld   b, $00
	ld   a, (ix+5)
	or   a
	ld   c, a
	jp   p, LABEL_83EE_140
	dec  b
LABEL_83EE_140:
	add  hl, bc
LABEL_83EF_139:
	ld   (ix+$0B), l
	ld   (ix+$0C), h
	ld   a, (de)
	inc  de
	jp   LABEL_83A6_129

;************************************************************
;*	Resets all control bytes and turns all channels off.	*
;************************************************************
Sound_ResetAll:
LABEL_83FA_105:
	push hl
	push bc
	push de
	ld   hl, $DD03		;reset the control bytes
	ld   de, $DD04
	ld   bc, $018C
	ld   (hl), $00
	ldir
	pop  de
	pop  bc
	pop  hl
Sound_ResetChannels:	;$840D
	push hl
	push bc
	ld   hl, Sound_Data_DefaultChannelValues
	ld   b, $0A
	ld   c, $7F
	otir
	pop  bc
	pop  hl
	jp   StopMusic

Sound_Data_DefaultChannelValues:
.db $80, $00	;set tone 0 = 0
.db $A0, $00	;set tone 1	= 0
.db $C0, $00	;set tone 2 = 0
.db $9F			;set tone 0 volume = off
.db $BF			;set tone 1 volume = off
.db $DF			;set tone 2 volume = off
.db $FF			;set noise volume = off

LABEL_8427_131:
	and  $7F
	add  a, (ix+5)
	ld   hl, DATA_8448
LABEL_842F_112:
	ld   c, a
	ld   b, $00
	add  hl, bc
	add  hl, bc
	ld   c, (hl)
	inc  hl
	ld   h, (hl)
	ld   l, c
	ret

LABEL_8439_119:
	ld		b, $00
	add		hl, bc
	ld		a, (hl)
	ret

LABEL_843E:
	ld		b, (ix+$02)
	dec		b
	ret		z

	ld		c, a
-:	add		a, c
	djnz	-
	ret


DATA_8448:
.db $56, $03, $26, $03, $F9, $02, $CE, $02, $A5, $02, $80, $02, $5C, $02, $3A, $02
.db $1A, $02, $FB, $01, $DF, $01, $C4, $01, $AB, $01, $93, $01, $7D, $01, $67, $01
.db $53, $01, $40, $01, $2E, $01, $1D, $01, $0D, $01, $FE, $00, $EF, $00, $E2, $00
.db $D6, $00, $C9, $00, $BE, $00, $B4, $00, $A9, $00, $A0, $00, $97, $00, $8F, $00
.db $87, $00, $7F, $00, $78, $00, $71, $00, $6B, $00, $65, $00, $5F, $00, $5A, $00
.db $55, $00, $50, $00, $4B, $00, $47, $00, $43, $00, $40, $00, $3C, $00, $39, $00
.db $36, $00, $33, $00, $30, $00, $2D, $00, $2B, $00, $28, $00, $26, $00, $24, $00
.db $22, $00, $20, $00, $1F, $00, $1D, $00, $1B, $00, $1A, $00, $18, $00, $17, $00
.db $16, $00, $15, $00, $13, $00, $12, $00, $11, $00, $00, $00

;Decrement the note duration counter. When the counter
; reaches 0 the next note is loaded.
Sound_DecrementNoteDuration:
LABEL_84D4_124:
	dec		(ix+$0A)		;decrement counter value
	jr		nz, LABEL_84EE_125
	call	LABEL_8362_126
	bit		4, (ix+0)
	ret		nz
	
	bit		2, (ix+0)
	ret		nz
	
	call	LABEL_8288_141
	call	LABEL_82B3_142
	jr		Sound_WriteChannelData

LABEL_84EE_125:
	bit		2, (ix+0)
	ret		nz
	ld		a, (ix+$0E)
	or		a
	jr		z, +
	dec		(ix+$0E)
	call	z, LABEL_85F8_134
+:	ld		a, (ix+$07)
	or		a
	jr		z, LABEL_853A_144
	bit		5, (ix+$00)
	jr		nz, LABEL_853A_144


Sound_WriteChannelData:		;$850B
	bit		6, (ix+0)
	jr		nz, LABEL_853A_144
	call	LABEL_82D0_145
	
	ld		d, $00
	
	ld		a, (ix+$25)	;relative jump value
	or		a
	jp		p, ++		;make sure to sign-extend
	
	dec		d
	
++:	ld		e, a
	add		hl, de		;HL = data to write to sound channel
	
	ld		a, (ix+$01)	;get the channel number
	cp		$E0			;check to see if it's a noise channel latch byte
	jr		nz, ++		;jump if this is not a noise channel 
	
						;the byte is for the noise channel.
	ld		a, $C0		;change to update tone channel 2
	
++:	ld		c, a

	ld		a, l		;get the low 4-bits of data and add them
	and		$0F			;to the latch byte
	or		c
	
	out		($7F), a	;write latch/data byte
	
	ld		a, l		;get the upper 4 bits of the first
	and		$F0			;byte of data and add them to the
	or		h			;second byte.
	rrca				;rotate into the correct position
	rrca
	rrca
	rrca
	
	out		($7F), a	;write data byte
	
LABEL_853A_144:
	call	LABEL_8558_157
	bit		2, (ix+0)
	ret		nz
	bit		4, (ix+0)
	ret		nz
	add		a, (ix+6)
	bit		4, a
	jr		z, LABEL_8550_176
	ld		a, $0F
LABEL_8550_176:
	or		(ix+1)
	add		a, $10
	out		($7F), a
	ret

LABEL_8558_157:
	ld		a, (ix+$08)		;is a volume update required?
	or		a
	ret		z

	jp		p, LABEL_860F_158
	bit		4, (ix+$1D)
	jr		z, LABEL_8580_159
	ld		d, (ix+$20)		;get volume adjustment value
	ld		a, (ix+$1F)		;get current volume value
	sub		d
	jr		nc, +

	xor		a				;result was < 0. reset to 0

+:	or		a
	ld		(ix+$1F), a		;set current volume
	jr		nz, LABEL_85EE_161
	
	ld		a, (ix+$1D)		;flip bits 4 & 5
	xor		$30
	ld		(ix+$1D), a

	jr		LABEL_85EE_161


LABEL_8580_159:
	bit  5, (ix+$1D)
	jr   z, LABEL_85B0_162
	ld   a, (ix+$1F)
	ld   d, (ix+$21)
	ld   e, (ix+$22)
	add  a, d
	jr   c, LABEL_8595_163
	cp   e
	jr   c, LABEL_8596_164
LABEL_8595_163:
	ld   a, e
LABEL_8596_164:
	cp   e
	ld   (ix+31), a
	jr   nz, LABEL_85EE_161
	ld   a, (ix+29)
	bit  3, (ix+29)
	jr   z, LABEL_85A9_165
	xor  $30
	jr   LABEL_85AB_166

LABEL_85A9_165:
	xor  $60
LABEL_85AB_166:
	ld   (ix+29), a
	jr   LABEL_85EE_161

LABEL_85B0_162:
	bit  6, (ix+29)
	jr   z, LABEL_85D2_167
	ld   a, (ix+31)
	ld   d, (ix+35)
	add  a, d
	jr   nc, LABEL_85C1_168
	ld   a, $FF
LABEL_85C1_168:
	cp   $FF
	ld   (ix+31), a
	jr   nz, LABEL_85EE_161
	ld   a, (ix+29)
	and  $8F
	ld   (ix+29), a
	jr   LABEL_85EE_161

LABEL_85D2_167:
	ld		a, (ix+31)
	ld		d, (ix+36)
	add		a, d
	jr		nc, LABEL_85EB_169
	ld		a, (ix+29)
	and		$0F
	ld		(ix+29), a
	ld		a, $FF
	ld		(ix+31), a
	jp		LABEL_864B_135

LABEL_85EB_169:
	ld		(ix+31), a
LABEL_85EE_161:
	ld		a, (ix+31)
	rrca
	rrca
	rrca
	rrca
	and		$0F
	ret

LABEL_85F8_134:
	bit		1, (ix+0)
	ret		nz
	bit		7, (ix+$08)
	jp		z, LABEL_864B_135
	ld		a, (ix+$1D)
	and		$0F
	or		$80
	ld		(ix+$1D), a
	ret

LABEL_860F_158:
	dec  a
	ld   hl, $8A2F
	call LABEL_842F_112
	jr   LABEL_861B_170

LABEL_8618_175:
	ld   (ix+31), a
LABEL_861B_170:
	push hl
	ld   c, (ix+31)
	call LABEL_8439_119
	pop  hl
	bit  7, a
	jr   z, LABEL_8647_171
	cp   $82
	jr   z, LABEL_8637_172
	cp   $81
	jr   z, LABEL_8641_173
	cp   $80
	jr   z, LABEL_863E_174
	inc  de
	ld   a, (de)
	jr   LABEL_8618_175

LABEL_8637_172:
	set  4, (ix+0)
	pop  hl
	jr   LABEL_864B_135

LABEL_863E_174:
	xor  a
	jr   LABEL_8618_175

LABEL_8641_173:
	set  4, (ix+0)
	pop  hl
	ret

LABEL_8647_171:
	inc  (ix+31)
	ret

LABEL_864B_135:
	set  4, (ix+0)
	bit  2, (ix+0)
	ret  nz
	ld   a, $1F			;volume?
	add  a, (ix+1)
	out  ($7F), a
	ret

LABEL_865C_178:
	dec  (ix+10)
	jp   nz, LABEL_853A_144
	res  4, (ix+0)
	ld   e, (ix+3)
	ld   d, (ix+4)
	ld   a, (de)
	inc  de
	cp   $E0
	jr   nc, LABEL_867D_179
	cp   $80
	jp   c, LABEL_83A6_129
	call LABEL_8686_180
	jp   LABEL_8397_136

LABEL_867D_179:
	ld   hl, $8683
	jp   LABEL_86EB_188


; Data from 8683 to 8685 (3 bytes)
.db $13, $18, $E6

LABEL_8686_180:
	bit  0, a
	jr   nz, LABEL_86C9_181
	bit  1, a
	jr   nz, LABEL_86A9_182
	bit  2, a
	jr   nz, LABEL_86C1_183
	bit  3, a
	jr   nz, LABEL_86A1_184
	bit  4, a
	jr   nz, LABEL_86B9_185
	bit  5, a
	jr   nz, LABEL_86B1_186
	jp   LABEL_864B_135

LABEL_86A1_184:
	ld   a, $03
	ld   b, $02
	ld   c, $E4
	jr   LABEL_86CF_187

LABEL_86A9_182:
	ld   a, $03
	ld   b, $02
	ld   c, $E4
	jr   LABEL_86CF_187

LABEL_86B1_186:
	ld   a, $04
	ld   b, $04
	ld   c, $E4
	jr   LABEL_86CF_187

LABEL_86B9_185:
	ld   a, $03
	ld   b, $03
	ld   c, $E6
	jr   LABEL_86CF_187

LABEL_86C1_183:
	ld   a, $02
	ld   b, $02
	ld   c, $E5
	jr   LABEL_86CF_187

LABEL_86C9_181:
	ld   a, $01
	ld   b, $02
	ld   c, $E4
LABEL_86CF_187:
	ld   (ix+8), a
	ld   a, ($DD16)
	add  a, b
	ld   (ix+6), a
	bit  2, (ix+0)
	ret  nz
	ld   a, ($DD15)
	add  a, c
	ld   ($DD11), a
	out  ($7F), a
	ret

LABEL_86E8_127:
	ld		hl, LABEL_86FC
LABEL_86EB_188:
	push	hl
	sub		$E0
	ld		hl, DATA_8700
	add		a, a
	ld		c, a
	ld		b, $00
	add		hl, bc
	ld		c, (hl)
	inc		hl
	ld		h, (hl)
	ld		l, c
	ld		a, (de)
	jp		(hl)

LABEL_86FC:
	inc		de
	jp		LABEL_8370
	
DATA_8700:
.dw LABEL_88BB 
.dw LABEL_88B0
.dw LABEL_8740 
.dw LABEL_874F 
.dw LABEL_8750 
.dw LABEL_88D5 
.dw LABEL_8740 
.dw LABEL_88AA 
.dw LABEL_8892 
.dw LABEL_874F 
.dw LABEL_874F 
.dw LABEL_874F 
.dw LABEL_874F 
.dw LABEL_88B4 
.dw LABEL_874F 
.dw DATA_88DE 
.dw LABEL_889C 
.dw DATA_88DE 
.dw LABEL_87DB 
.dw LABEL_8766 
.dw LABEL_87C3 
.dw LABEL_87BF 
.dw LABEL_87C7 
.dw LABEL_887B 
.dw LABEL_884E 
.dw LABEL_8868 
.dw LABEL_8762 
.dw LABEL_875B 
.dw LABEL_874F 
.dw LABEL_87CD 
.dw LABEL_874F 
.dw LABEL_874F
	

; Data from 86FC to BFFF (14596 bytes)
;.incbin "Sonic the Hedgehog 2 (UE) [!].sms.dat.21"
LABEL_8740:
	ex      af, af'
	ld      a, ($DD09)
	or      a
	ret     nz
	ex      af, af'
	add     a, (ix+$06)
	and     $0F
	ld      (ix+$06), a
LABEL_874F:
	ret

LABEL_8750:
	ld      c, a
	ld      a, ($DD16)
	add     a, c
	and     $0F
	ld      ($DD16), a
	ret

LABEL_875B:
	add     a, (ix+$05)
	ld      (ix+$05), a
	ret

LABEL_8762:
	ld      (ix+$02), a
	ret 

LABEL_8766:
	ex      af, af'
	ld      a, ($DD0D)
	or      a
	jp      m, LABEL_878F
	ex      af, af'
	or      $FC
	inc     a
	jr      nz, LABEL_878F
	ld      hl, $DE30
	bit     7, (hl)
	jr      z, LABEL_878F
	ld      hl, $DDD0
	res     2, (hl)
	set     4, (hl)
	xor     a
	ld      (ix+$00), a
	dec     a
	out     ($7F), a
	ld      ($DD0D), a
	pop     hl
	pop     hl
	ret

LABEL_878F:
	ld      a, (de)
	out     ($7F), a
	ld      hl, $DDA0
	ld      iy, $DE30
	or      $FC
	inc     a
	jr      nz, LABEL_878D
	ld      a, $DF			;tone 2 volume = off
	out     ($7F), a
	res     6, (ix+$00)
	set     2, (hl)
	set     2, (iy+$00)
	ret

LABEL_878D:		
	set     6, (ix+$00)
	bit     7, (iy+$00)
	jr      nz, LABEL_87BA
	res     2, (hl)
	ret

LABEL_87BA:
	res     2, (iy+$00)
	ret   

LABEL_87BF:
	ld      (ix+$08), a
	ret

LABEL_87C3:
	ld      (ix+$07), a
	ret

LABEL_87C7:
	ex      de, hl
	ld      e, (hl)
	inc     hl
	ld      d, (hl)
	dec     de
	ret

LABEL_87CD:
	cp      $01
	jr      nz, LABEL_87D6
	set     3, (ix+$00)
	ret

LABEL_87D6:
	res     3, (ix+$00)
	ret

LABEL_87DB:
	ld      a, (ix+$01)
	cp      $A0
	jr      z, LABEL_881A
	cp      $C0
	jr      z, LABEL_880E
	bit     6, (ix+$00)
	jr      nz, +
	ld      hl, $DE30
	bit     7, (hl)
	jp      nz, +
	ld      hl, $DDA0
	res     2, (hl)
	res     6, (hl)
	set     4, (hl)
	ld      hl, $DE30
	ld      (hl), $00
+:  push    af
	ld      a, ($DD11)
	out     ($7F), a
	pop     af
	ld      hl, $DDD0
	jr      LABEL_881D

LABEL_880E:
	ld      hl, $DE60
	bit     7, (hl)
	jr      nz, LABEL_881D
	ld      hl, $DDA0
	jr      LABEL_881D

LABEL_881A:
	ld      hl, $DD70
LABEL_881D:
	res     2, (hl)
	set     4, (hl)
	or      $1F			;volume = off
	out     ($7F), a
	xor     a
	ld      (ix+$00), a
	ld      ix, $DE00
	bit     7, (ix+$00)
	jr      nz, +
	ld      ix, $DE30
	bit     7, (ix+$00)
	jr      nz, +
	ld      ix, $DE60
	bit     7, (ix+$00)
	jr      nz, +
	xor     a
	ld      ($DD0F), a
+:	pop     bc
	pop     bc
	ret

LABEL_884E:
	ld      c, a
	inc     de
	ld      a, (de)
	ld      b, a
	push    bc
	push    ix
	pop     hl
	dec     (ix+$09)
	ld      c, (ix+$09)
	dec     (ix+$09)
	ld      b, $00
	add     hl, bc
	ld      (hl), d
	dec     hl
	ld      (hl), e
	pop     de
	dec     de
	ret

LABEL_8868:
	push    ix
	pop     hl
	ld      c, (ix+$09)
	ld      b, $00
	add     hl, bc
	ld      e, (hl)
	inc     hl
	ld      d, (hl)
	inc     (ix+$09)
	inc     (ix+$09)
	ret

LABEL_887B:
	inc     de
	add     a, $27
	ld      c, a
	ld      b, $00
	push    ix
	pop     hl
	add     hl, bc
	ld      a, (hl)
	or      a
	jr      nz, +
	ld      a, (de)
	ld      (hl), a
+:	inc     de
	dec     (hl)
	jp      nz, LABEL_87C7
	inc     de
	ret

LABEL_8892:
	call    LABEL_843E
	ld      (ix+$0E), a
	ld      (ix+$0F), a
	ret

LABEL_889C:
	ld      (ix+$10), e
	ld      (ix+$11), d
	ld      (ix+$07), $80
	inc     de
	inc     de
	inc     de
	ret

LABEL_88AA:
	set     1, (ix+$00)
	dec     de
	ret

LABEL_88B0:
	ld      (ix+$25), a
	ret

LABEL_88B4:
	ld      ($DD02), a
	ld      ($DD01), a
	ret

LABEL_88BB:
	ld      (ix+$08), $80
	push    ix
	pop     hl
	ld      b, $00
	ld      c, $20
	add     hl, bc
	ex      de, hl
	ldi     
	ldi     
	ldi     
	ldi     
	ldi     
	ex      de, hl
	dec     de
	ret

LABEL_88D5:
	or      a
	jr      z, +
	ld      a, $08
+:	ld      (ix+$1E), a
	ret

	
DATA_88DE:
.incbin "unknown\s2_88DE.bin"

DATA_8B95:
.incbin "unknown\s2_8B95.bin"


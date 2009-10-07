; =============================================================================
;  VDP_InitRegisters()
; -----------------------------------------------------------------------------
;  Sets the VDP registers to known values.
; -----------------------------------------------------------------------------
;  In:
;    None.
;  Out:
;    None.
; -----------------------------------------------------------------------------
VDP_InitRegisters:
    ;read/clear VDP status flags
    in    a, ($BF)
    ; loop 11 times to copy to each register
    ld    b, $0B            ; FIXME: more efficient to load BC with one opcode
    ; load C with the first latch byte
    ld    c, $80
    ; load DE with a pointer to the RAM cached copies 
    ; of the VDP registers
    ld    de, VDPRegister0
    
    ld    hl, _VDP_InitRegisters_RegValues
    
    ; loop over each register
-:  ld    a, (hl)
    out   (Ports_VDP_Control), a
    ld    (de), a
    ld    a, c
    out   (Ports_VDP_Control), a
    inc   c
    inc   de
    inc   hl
    djnz  -
    
    ret

_VDP_InitRegisters_RegValues:
.db $26, $82, $FF, $FF, $FF, $FF, $FB, $00, $00, $00, $FF


; =============================================================================
;  VDP_SetRegister(uint8 register, uint8 data)                       UNUSED
; -----------------------------------------------------------------------------
;  Sets a VDP register.
; -----------------------------------------------------------------------------
;  In:
;    B   - The value.
;    C   - The register number.
;  Out:
;    None.
;  Destroys:
;    A
; -----------------------------------------------------------------------------
VDP_SetRegister:        ; $1310
    push  bc
    push  hl
    
    ;update the VDP Register
    ld    a, b
    out   (Ports_VDP_Control), a
    ld    a, c
    or    $80
    out   (Ports_VDP_Control), a
    
    ;update the RAM copy
    ld    a, b
    ld    b, $00
    ld    hl, VDPRegister0
    add   hl, bc
    ld    (hl), a
    pop   hl
    pop   bc

    ret


; =============================================================================
;  VDP_ReadStatus()                                                  UNUSED
; -----------------------------------------------------------------------------
;  Reads the VDP status flags.
; -----------------------------------------------------------------------------
;  In:
;    None.
;  Out:
;    A   - The status byte.
; -----------------------------------------------------------------------------
VDP_ReadStatus:     ; $1325
    in    a, (Ports_VDP_Control)
    ret


; =============================================================================
;  VDP_SetAddress(uint16 address)
; -----------------------------------------------------------------------------
;  Sets the VRAM address pointer.
; -----------------------------------------------------------------------------
;  In:
;    HL  - The new address.
;  Out:
;    None.
;  Destroys:
;    None.
; -----------------------------------------------------------------------------
VDP_SetAddress:     ; $1328
    push  af
    
    ld    a, l
    out   (Ports_VDP_Control), a
    ld    a, h
    or    $40
    out   (Ports_VDP_Control), a
    
    pop   af
    
    ret


; =============================================================================
;  VDP_SendRead(uint16 address)
; -----------------------------------------------------------------------------
;  Sends a read command to the VDP.
; -----------------------------------------------------------------------------
;  In:
;    HL  - The address to read from.
;  Out:
;    None.
;  Destroys:
;    A
; -----------------------------------------------------------------------------
VDP_SendRead:		   ;$1333
    ld    a, l
    out   (Ports_VDP_Control), a
    ld    a, h
    and   $3F
    out   (Ports_VDP_Control), a
    
    push  af            ; FIXME: pointless stack activity/timing related?
    pop   af
	
    ret


; =============================================================================
;  VDP_WriteByte(uint16 address, uint8 data)                         UNUSED
; -----------------------------------------------------------------------------
;  Sets the VDP address pointer and writes a value.
; -----------------------------------------------------------------------------
;  In:
;    A   - The data to write.
;    HL  - The address to read from.
;  Out:
;    None.
;  Destroys:
;    None.
; -----------------------------------------------------------------------------
VDP_WriteByte:      ; $133E
    ; set the VDP adderess pointer
    push  af                  ;FIXME: this push/pop is unnecessary as
    call  VDP_SetAddress      ; VDP_SetAddress does the same thing.
    pop   af
    ; write the data
    out   (Ports_VDP_Data), a
    ret


; =============================================================================
;  VDP_ReadByte(uint16 address)                                      UNUSED
; -----------------------------------------------------------------------------
;  Sets the VDP address pointer and reads a value.
; -----------------------------------------------------------------------------
;  In:
;    HL  - The address to read from.
;  Out:
;    A   - Data read from the address.
;  Destroys:
;    None.
; -----------------------------------------------------------------------------
VDP_ReadByte:       ; $1346
    call  VDP_SendRead
    in    a, (Ports_VDP_Data)
    ret


; =============================================================================
;  VDP_WriteAndSkip(uint8 data, uint16 address, uint16 count)        UNUSED
; -----------------------------------------------------------------------------
;  Writes a value to every other byte, starting from <address> (i.e. writes
;  one byte, skips the next address, writes a byte, skips...)
; -----------------------------------------------------------------------------
;  In:
;    A   - The data.
;    BC  - Number of bytes to write. When the function returns, the VRAM
;          addess pointer will be HL + 2*BC.
;    HL  - The address to start writing from.
;  Out:
;    None.
;  Destroys:
;    A, BC
; -----------------------------------------------------------------------------
VDP_WriteAndSkip:       ; $134C
    push  de
    
    push  af                ;FIXME: this push/pop is unnecessary
    call  VDP_SetAddress
    pop   af
    
    ld    d, a
    
-:  ld    a, d
    ; write the data to VRAM
    out   (Ports_VDP_Data), a
    push  af
    pop   af
    
    ; skip the next VRAM address
    in    a, (Ports_VDP_Data)
    
    ; decrement BC and loop back if != 0
    dec   bc
    ld    a, b
    or    c
    jr    nz, -
    
    pop   de
    ret


; =============================================================================
;  VDP_Write(uint16 data, uint16 address, uint16 count)
; -----------------------------------------------------------------------------
;  Writes a 16 bit value to a section of VRAM.
; -----------------------------------------------------------------------------
;  In:
;    DE  - The value.
;    BC  - Number of words to write.
;    HL  - The address to start writing from.
;  Out:
;    None.
;  Destroys:
;    A, BC
; -----------------------------------------------------------------------------
VDP_Write:		;$1361
    call  VDP_SetAddress
    
-:  ; write the low-order byte
    ld    a, e
    out   (Ports_VDP_Data), a
    push  af 
    pop   af
    
    ; write the hi-order byte
    ld    a, d
    out   (Ports_VDP_Data), a
	
    ; decrement BC and loop back if != 0
    dec   bc
    ld    a, b
    or    c
    jr    nz, -

    ret


; =============================================================================
;  VDP_Copy(uint16 src, uint16 dest, uint16 count)
; -----------------------------------------------------------------------------
;  Copies a block of data to VRAM.
; -----------------------------------------------------------------------------
;  In:
;    Hl  - Source address.
;    DE  - VRAM destination address.
;    BC  - Number of bytes to copy.
;  Out:
;    None.
;  Destroys:
;    A, BC, DE
; -----------------------------------------------------------------------------
VDP_Copy:		 ;$1372
    ex    de, hl		 ;set the VRAM pointer
    call  VDP_SetAddress
	
-:  ; read a byte from the source
    ld    a, (de)
    ; ...and copy to the VDP
    out   (Ports_VDP_Data), a
    
    ; move the source pointer
    inc   de
    
    ; decrement BC and loop back if != 0
    dec   bc
    ld    a, b
    or    c
    jr    nz, -
    
    ret


; =============================================================================
;  VDP_SetMode2Reg_DisplayOn()
; -----------------------------------------------------------------------------
;  Sets the VDP's Mode Control 2 register and turns the display on.
; -----------------------------------------------------------------------------
;  In:
;    None.
;  Out:
;    None.
; -----------------------------------------------------------------------------
VDP_SetMode2Reg_DisplayOn:      ; $1381
	;set register VDP(1) - mode control register 2
	ld		hl, VDPRegister1
	ld		a, (hl)
	;change all flags - make sure display is visible
	or		VDP_DisplayVisibleBit
	ld		(hl), a
	out		(Ports_VDP_Control), a
	ld		a, $81
	out		(Ports_VDP_Control), a
	ret


; =============================================================================
;  VDP_SetMode2Reg_DisplayOff()
; -----------------------------------------------------------------------------
;  Sets the VDP's Mode Control 2 register but leaves the display turned off.
; -----------------------------------------------------------------------------
;  In:
;    None.
;  Out:
;    None.
; -----------------------------------------------------------------------------
VDP_SetMode2Reg_DisplayOff:
	;set register VDP(1) - mode control register 2
	ld		hl, VDPRegister1
	ld		a, (hl)
	; set each of the flags except for the "Display Visible" bit
    ; i.e. leave the display turned off
	and		VDP_DisplayVisibleBit ~ $FF
	ld		(hl), a
    
	out		(Ports_VDP_Control), a
	ld		a, $81
	out		(Ports_VDP_Control), a
	ret


; =============================================================================
;  VDP_EnableFrameInterrupt()
; -----------------------------------------------------------------------------
;  Sets the VDP's Mode Control 2 register, ensuring frame interrupts are 
;  enabled.
; -----------------------------------------------------------------------------
;  In:
;    None.
;  Out:
;    None.
; -----------------------------------------------------------------------------
VDP_EnableFrameInterrupt:
	ld		hl, VDPRegister1
	ld		a, (hl)
	or		VDP_FrameInterruptsBit
	ld		(hl), a
	out		(Ports_VDP_Control), a
	ld		a, $81
	out		(Ports_VDP_Control), a

	ret


; =============================================================================
;  VDP_DisableFrameInterrupt()                                       UNUSED
; -----------------------------------------------------------------------------
;  Sets the VDP's Mode Control 2 register, ensuring frame interrupts are 
;  disabled.
; -----------------------------------------------------------------------------
;  In:
;    None.
;  Out:
;    None.
; -----------------------------------------------------------------------------
VDP_DisableFrameInterrupt:      ; $13AA
	ld		hl, VDPRegister1
	ld		a, (hl)
	and		VDP_FrameInterruptsBit ~ $FF
	ld		(hl), a
	out		(Ports_VDP_Control), a
	ld		a, $81
	out		(Ports_VDP_Control), a
	ret


; =============================================================================
;  VDP_DrawText()
; -----------------------------------------------------------------------------
;  Copies char strings to the VDP. Disables interrupts. Calling functions
;  will need to re-enable interrupts afterwards.
; -----------------------------------------------------------------------------
;  In:
;    HL  - VRAM address.
;    DE  - Pointer to char data.
;    BC  - Char count.
;  Out:
;    None.
;  Destroys:
;    A
; -----------------------------------------------------------------------------
VDP_DrawText:       ; $13B8
	di
    
	call	VDP_SetAddress
    
	push	de
	push	bc
    
-:	; copy a byte from RAM to the VDP
    ld		a, (de)
	out		(Ports_VDP_Data), a	;write a char to the VDP memory
	
    ; copy the tile attribute byte to the VDP
    ld		a, (VDP_DefaultTileAttribs)
    nop
	nop
	nop
	out		(Ports_VDP_Data), a
	
    ; increment the source pointer
    inc		de
    
    ; decrement the counter and loop back if != 0
	dec		bc
	ld		a, c
	or		b
	jr		nz, -

	pop		bc
	pop		de
	ret


; =============================================================================
;  VDP_UNKNOWN(uint16 vdp_address, uint16 char_ptr, uint16 count)    UNUSED
; -----------------------------------------------------------------------------
;  Unknown use. Copies chars to VDP. Seems to wait for a button press
;  before copying each char.
; -----------------------------------------------------------------------------
;  In:
;    HL  - VRAM address.
;    DE  - Pointer to char data.
;    BC  - Char count.
;  Out:
;    None.
;  Destroys:
;    A
; -----------------------------------------------------------------------------
LABEL_13D2:
    push	de
    push	bc
    
-:  ld		a, ($D292)
    bit		7, a
    jr		nz, +

    di
    
    call	VDP_SetAddress
 
    ; copy a byte from RAM to the VDP
    ld		a, (de)
    out		(Ports_VDP_Data), a
    
    ; copy the default tile attribs to the VDP
    ld		a, (VDP_DefaultTileAttribs)
    nop
    nop
    nop
    out		(Ports_VDP_Data), a

    ei

    push	bc
    push	de
    push	hl

    ; wait 6 frames for a button press?
    ld		b, $06
--: ei
    halt
    ld		a, ($D137)
    and		$80
    jr		nz, ++

    djnz  --

++: pop   hl
    pop   de
    pop   bc

    inc   hl
    inc   hl
    inc   de

    ; decrement the counter and loop back if != 0
    dec   bc
    ld    a, c
    or    b
    jr    nz, -

+:  pop   bc
    pop   de
    ret


; =============================================================================
;  VDP_UpdateSAT()
; -----------------------------------------------------------------------------
;  Copies the working copy of the SAT, stored in RAM, to the VDP.
; -----------------------------------------------------------------------------
;  In:
;    None.
;  Out:
;    None.
; -----------------------------------------------------------------------------
VDP_UpdateSAT:      ; $1409
    ; check the SAT update trigger. don't bother updating
    ; if it is 0
    ld		hl, VDP_SATUpdateTrig
    xor		a
    or		(hl)
    ret		z
	
    ; reset the trigger
    ld		(hl), $00
	
    
    ; check the frame counter. if it's odd do a descending update
    ld		a, (Engine_FrameCounter)
    rrca
    jp		c, VDP_UpdateSAT_Descending
	
    ; set the VDP's address pointer to the SAT
    ld		a, VDP_SATAddress & $FF
    out		(Ports_VDP_Control), a
    ld		a, VDP_SATAddress >> 8
    or		$40
    out		(Ports_VDP_Control), a
    
    
    ; copy 64 v-pos attributes to the VDP
    ld		hl, VDP_WorkingSAT_VPOS	   ;copy 64 VPOS bytes.
    ld		c, Ports_VDP_Data
.rept 64
    outi
.endr

    ;set VRAM pointer to SAT + $80
    ld		a, $80
    out		(Ports_VDP_Control), a
    ld		a, VDP_SATAddress >> 8
    or		$40
    out		(Ports_VDP_Control), a
    
    ; copy 64 h-pos and char code attributes to the VDP
    ld		hl, VDP_WorkingSAT_HPOS
    ld		c, Ports_VDP_Data
.rept 128
    outi
.endr

    ret


VDP_UpdateSAT_Descending:	;$15B7
    ; set the VDP address pointer to the SAT
	ld		a, VDP_SATAddress & $FF
	out		(Ports_VDP_Control), a
	ld		a, VDP_SATAddress >> 8
	or		$40
	out		(Ports_VDP_Control), a
    
    ; copy the 8 player sprites first (so that they always
    ; appear on top).
	ld		hl, VDP_WorkingSAT_VPOS
	ld		c, Ports_VDP_Data
.rept 8
	outi
.endr

    ; copy the remaining 56 sprites in descending order
	ld		hl, VDP_WorkingSAT_VPOS + $3F
	ld		c, Ports_VDP_Data               ; FIXME - opcode not required
.rept 56
	outd
.endr

    ; set VDP address pointer to SAT + $80
	ld		a, $80
	out		(Ports_VDP_Control), a
	ld		a, VDP_SATAddress >> 8
	or		$40
	out		(Ports_VDP_Control), a
    
    ; copy hpos and char codes for the 8 player sprites
	ld		hl, VDP_WorkingSAT_HPOS
	ld		c, Ports_VDP_Data
.rept 16
	outi
.endr

    ; copy the remaining 56 hpos and char codes in descending order
	ld		hl, VDP_WorkingSAT_HPOS + $7E
	ld		de, -4
	ld		c, Ports_VDP_Data
.REPEAT 56
	outi
	outi
	add		hl, de
.ENDR

	ret

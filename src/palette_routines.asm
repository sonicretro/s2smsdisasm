Palette_Update:
	ld      hl, $D2C9		;counter for smooth fade
	inc     (hl)
	ld      a, ($D2C8)		;palette fade timeout value (will fade when counter = timeout value)
	cp      (hl)
	ret     nc
	ld      (hl), $00
	ld      ix, BgPaletteControl
	ld      iy, WorkingCRAM
	ld      b, $02
-:	push    bc
	push    iy
	ld      a, (ix+$00)
	or      a
	jr      z, +
	call    Palette_UpdateColours
	ld      a, $FF
	ld      (Palette_UpdateTrig), a
+:	ld      de, $0002		;check FgPaletteControl
	add     ix, de
	pop     iy
	ld      de, $0010
	add     iy, de
	pop     bc
	djnz    -
	ret

Palette_UpdateColours:	
	bit     7, a			;check for fade to colour
	jr      nz, Palette_FadeToColour
	bit     6, a			;check for fade to black
	jp      nz, Palette_FadeToBlack
	bit     5, a			;reset to indexed palette
	jr      nz, Palette_Reset
	ret

Palette_Reset:				;$8044
+:	call    Palette_CalculateOffset
	push    iy
	pop     de
	ld      bc, $0010
	ldir    
	ld      (ix+$00), $00	;reset the palette control byte
	ret

Palette_FadeToColour:		;$8054
	call    Palette_CalculateOffset
	ld      b, $10
-:	push    bc
    ld      a, (ix+$00)
    and     $03
    ld      c, a
    ld      a, (hl)
    and     $03
    xor     $03
    ld      b, a
    ld      a, c
    sub     b
    jr      nc, +
    xor     a
+:  and     $03
    ld      (iy+$00), a
    ld      a, (hl)
    and     $0C
    xor     $0C
    rrca    
    rrca    
    ld      b, a
    ld      a, c
    sub     b
    jr      nc, +
    xor     a
+:	rlca    
    rlca    
    and     $0c
    or      (iy+$00)
    ld      (iy+$00), a
    ld      a, (hl)
    and     $30
    xor     $30
    rrca    
    rrca    
    rrca    
    rrca    
    ld      b, a
    ld      a, c
    sub     b
    jr      nc, +
    xor     a
+:	rlca    
	rlca    
	rlca    
	rlca    
	and     $30
	or      (iy+$00)
	ld      (iy+$00), a
	inc     iy
	inc     hl
	pop     bc
	djnz    -
	inc     (ix+$00)
	ld      a, (ix+$00)
	and     $07
	cp      $04
	ret     nz
	ld      (ix+$00), $00
	ret

Palette_FadeToBlack:		;80B8
	call    Palette_CalculateOffset		;get a pointer to the palette into HL
	ld      b, $10				;loop over all 16 colours
-:  ld      a, (iy+$00)			
	and     $3C					;keep hold of R and G components
	ld      c, a
	ld      a, (iy+$00)
	and     $03					;get the B component
	jr      z, +
	sub     $01					;fade the B component
	and     $03
	or      c					;recombine with the R and G components
	ld      (iy+$00), a			;store updated colour
+:  ld      a, (iy+$00)
	and     $33					;keep hold of the R and B components
	ld      c, a
	ld      a, (iy+$00)
	and     $0C
	jr      z, +
	sub     $04					;fade the G component
	and     $0C
	or      c					;recombine with the R and B components
	ld      (iy+$00), a			;store updated colour
+:  ld      a, (iy+$00)
	and     $0F					;keep hold of the G and B 
	ld      c, a
	ld      a, (iy+$00)
	and     $30
	jr      z, +
	sub     $10					;fade the R component
	and     $30
	or      c					;recombine with the G and B components
	ld      (iy+$00), a			;store updated colour
+:  inc     iy
	djnz    -					;move to next colour
	inc     (ix+$00)
	ld      a, (ix+$00)
	and     $03
	cp      $03
	ret     nz
	ld      (ix+$00), $00
	ret 

Palette_CalculateOffset:		;$8110
    ld      a, (ix+$01)			;get the palette index number
    ld      l, a				;calculate the offset into the array
    ld      h, $00
    add     hl, hl
    add     hl, hl
    add     hl, hl
    add     hl, hl
    ld      de, Palettes
    add     hl, de
    ret

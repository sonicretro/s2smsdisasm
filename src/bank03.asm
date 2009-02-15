LABEL_B3_8000:
 	push    bc
	push    de
	push    hl
	ld      l, $05
	ld      de, DATA_B3_805E
	ld      bc, $3E7F
	
	ld      a, $81			;write $01 to tone channel 0
	out     ($7F), a
	ld      a, $00
	out     ($7F), a
	
	ld      a, $A1			;write $01 to tone channel 1
	out     ($7F), a
	ld      a, $00
	out     ($7F), a
	
	ld      a, $C1			;write $01 to tone channel 2
	out     ($7F), a
	ld      a, $00
	out     ($7F), a
	
LABEL_B3_8023:
	ld      a, (de)
	push    bc
	cpl     
	rrca    
	rrca    
	rrca    
	rrca    
	ld      b, l
-:	djnz    -
	and     $0F
	or      $90			;set volume of tone channel 0
	out     ($7F), a
	add     a, $20
	out     ($7F), a	;CHECK: sets volume to 0?
	add     a, $20
	out     ($7F), a	;CHECK: sets volume to 0?
	ld      b, l
-:	djnz    -
	ld      a, (de)
	cpl     
	and     $0F
	or      $90
	out     ($7F), a
	add     a, $20
	out     ($7F), a
	add     a, $20
	out     ($7F), a
	pop     bc
	inc     de
	dec     bc
	ld      a, c
	or      b
	jp      nz, LABEL_B3_8023
	xor     a
	ld      ($DE04), a
	pop     hl
	pop     de
	pop     bc
	ret

DATA_B3_805E:
.incbin "unknown\bank3.bin"
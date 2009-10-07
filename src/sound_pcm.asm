; this isn't used by the SMS version

Sound_PlaySegaSound:        ; $8000
 	push    bc
	push    de
	push    hl
    
	ld      l, $05
	ld      de, Sound_Data_SegaPCM
	ld      bc, $3E7F
	
	ld      a, $81			;write $01 to tone channel 0
	out     (Ports_PSG), a
	ld      a, $00
	out     (Ports_PSG), a
	
	ld      a, $A1			;write $01 to tone channel 1
	out     (Ports_PSG), a
	ld      a, $00
	out     (Ports_PSG), a
	
	ld      a, $C1			;write $01 to tone channel 2
	out     (Ports_PSG), a
	ld      a, $00
	out     (Ports_PSG), a

Sound_PlaySegaSound_PlaySample:     ; $8023
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
	or      $90
	out     (Ports_PSG), a
	add     a, $20
	out     (Ports_PSG), a
	add     a, $20
	out     (Ports_PSG), a
	ld      b, l
    
-:	djnz    -

	ld      a, (de)
	cpl     
	and     $0F
	or      $90
	out     (Ports_PSG), a
	add     a, $20
	out     (Ports_PSG), a
	add     a, $20
	out     (Ports_PSG), a
	pop     bc
	inc     de
    
	dec     bc
	ld      a, c
	or      b
	jp      nz, Sound_PlaySegaSound_PlaySample
    
	xor     a
	ld      ($DE04), a
 
	pop     hl
	pop     de
	pop     bc
	ret


Sound_Data_SegaPCM:     ; $805E
.incbin "misc/sega_sound.bin"

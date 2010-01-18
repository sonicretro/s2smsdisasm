;****************************************************
;*    Loops through each entry in the current act's    *
;*    object layout and loads objects as necessary.    *
;****************************************************
Engine_UpdateObjectLayout:            ;$8000
    ld    a, (CurrentLevel)
    cp    LastLevel             ;return if level >= 7
    ret   nc

    add   a, a                  ;get a pointer to the level's
    ld    e, a                  ;object placement data
    ld    d, $00
    ld    hl, Data_ObjectLayouts        
    add   hl, de
    ld    a, (hl)
    inc   hl
    ld    h, (hl)
    ld    l, a                  ;HL = pointer for current level

    
    ld    a, (CurrentAct)       ;get a pointer to the current
    add   a, a                  ;act's placement data
    ld    e, a
    add   hl, de
    ld    a, (hl)
    inc   hl
    ld    h, (hl)
    ld    l, a                  ;HL = pointer for current act

    ld    bc, $D400             ;store a pointer to the active objects 
                                ;array
    exx

    ld    hl, (Camera_X)        ;get camera hpos
    ld    de, $FF80
    add   hl, de
    jr    c, +                  ;jump if hpos was >= 128
    
    ld    hl, $0000
    
+:  ex    de, hl

    ld    hl, (Camera_Y)        ;get camera vpos
    ld    bc, $FF80
    add   hl, bc
    jr    c, +                  ;jump if camera vpos >= 128
    
    ld    hl, $0000

+:  exx

-:  ld    a, (hl)               ;read the object number
    inc   a
    jr    z, +                  ;check for $FF terminator byte

    ld    a, (bc)               ;check the active objects array to see
    or    a                     ;if the slot is available
    
    push  hl                    ;preserve pointer
    call  z, ObjectLayout_CheckLoadObject        ;jump if the slot is available
    pop   hl                    ;restore pointer
    
    inc   bc                    ;move to next element in active objects array
    
    ld    de, $0009             ;move to the next sprite header
    add   hl, de
    jr    -

+:  ret


;read an object placement descriptor
ObjectLayout_CheckLoadObject:        ;$804D
    inc   hl
    ld    e, (hl)
    inc   hl
    ld    d, (hl)               ;DE = object hpos

    ld    a, d
                                ;test horizontal proximity
    exx
    cp    d                     ;compare with hi-byte of current screen pos
    exx

    jp    c, ObjectLayout_Return    ;jump if cam pos > object pos

    or    a
    jr    nz, +                 ;jump if hi-byte of obj hpos != 0

    ld    a, e                  ;compare with lo-byte of current screen pos
    exx
    cp    e
    exx

    jp    c, ObjectLayout_Return    ;jump if cam pos > object pos

+:  exx
    ld    a, d
    exx

    inc   a
    inc   a
    cp    d
    jp    c, ObjectLayout_Return

    or    a
    jr    nz, +

    ld    a, e
    exx
    cp    e
    exx     
    jp    nc, ObjectLayout_Return


+:  inc   hl                    ;test vertical proximity
    ld    e, (hl)
    inc   hl
    ld    d, (hl)               ;DE = object vpos    

    ld    a, d
    exx
    cp    h
    exx
    jp    c, ObjectLayout_Return

    or    a
    jr    nz, +

    ld    a, e
    exx
    cp    l
    exx
    jp    c, ObjectLayout_Return

+:  exx     
    ld    a, h
    exx
    inc   a
    inc   a
    cp    d
    jp    c, ObjectLayout_Return

    or    a
    jr    nz, +

    ld    a, e
    exx
    cp    l
    exx
    jp    nc, ObjectLayout_Return

+:  ld    de, $FFFC             ;move the pointer back 4 bytes
    add   hl, de
    ld    a, (hl)               ;read the object number
    
    inc   a                     ;jump if object != FE
    inc   a
    jr    nz, ObjectLayout_LoadObject

    ld    a, $FF                ;copy $FF to the active objects array
    ld    (bc), a

    ld    de, $0005             ;skip to object flags byte
    add   hl, de
    ex    de, hl
    
    ld    a, (de)               ;read flags

    add   a, a                  ;use flags to calculate a jump
    ld    hl, DATA_80BE
    add   a, l
    ld    l, a
    ld    a, $00
    adc   a, h
    ld    h, a
    ld    a, (hl)
    inc   hl
    ld    h, (hl)
    ld    l, a
    jp    (hl)


DATA_80BE:
.dw LABEL_812E
.dw ObjectLayout_DoNothing
.dw ObjectLayout_DoNothing
.dw ObjectLayout_DoNothing
.dw ObjectLayout_DoNothing
.dw ObjectLayout_DoNothing
.dw ObjectLayout_DoNothing
.dw ObjectLayout_DoNothing
.dw ObjectLayout_DoNothing
.dw ObjectLayout_DoNothing
.dw ObjectLayout_DoNothing
.dw ObjectLayout_DoNothing
.dw ObjectLayout_DoNothing
.dw ObjectLayout_DoNothing
.dw ObjectLayout_DoNothing
.dw ObjectLayout_DoNothing


ObjectLayout_LoadObject:    ;$80DE
    push  bc
    ;find an empty object slot. Carry flag is set if
    ;no slots are available. Pointer to slot stored in IY.
    call  VF_Engine_AllocateObjectLowPriority
    pop   bc
    jr    c, ObjectLayout_Return        ;no slots available - return.

    ; set the object type
    ld    a, (hl)
    ld    (iy + Object.ObjID), a
    ld    (bc), a
    inc   hl

    ; set the object's horizontal position
    ld    a, (hl)
    ld    (iy + Object.InitialX), a
    ld    (iy + Object.X), a
    inc   hl
    ld    a, (hl)
    ld    (iy + Object.InitialX + 1), a
    ld    (iy + Object.X + 1), a
    inc   hl

    ; set the object's vertical position
    ld    a, (hl)
    ld    (iy + Object.InitialY), a
    ld    (iy + Object.Y), a
    inc   hl
    ld    a, (hl)
    ld    (iy + Object.InitialY + 1), a
    ld    (iy + Object.Y + 1), a
    inc   hl

    ; make sure object is not visible by default
    ld    a, (hl)
    or    $40
    ld    (iy + Object.Flags04), a
    inc   hl

    ; set the parameter byte
    ld    a, (hl)
    ld    (iy + Object.ix3F), a
    inc   hl

    ; set the vram tile indices
    ld    a, (hl)
    ld    (iy + Object.RightFacingIdx), a
    inc   hl
    ld    a, (hl)
    ld    (iy + Object.LeftFacingIdx), a

    ld    l, c                ;calculate index into active objects array
    ld    h, b
    ld    de, $D400
    xor   a
    sbc   hl, de
    inc   l
    ld    (iy + Object.ActvObjIdx), l            ;index of object in active objects array
ObjectLayout_Return:        ;$812C
    ret


ObjectLayout_DoNothing:        ;$812D
    ret


;jumps using a word from the object placement data
;only called when object $FE with flags $00 is
;encountered in the object layout data. This never
;happens in the base sonic 2 layouts.
LABEL_812E:
    ex    de, hl
    inc   hl
    ld    e, (hl)
    inc   hl
    ld    d, (hl)
    ex    de, hl
    jp    (hl)
    

Data_ObjectLayouts:        ;$8135
.dw Data_ObjectLayout_UGZ 
.dw Data_ObjectLayout_SHZ
.dw Data_ObjectLayout_ALZ 
.dw Data_ObjectLayout_GHZ 
.dw Data_ObjectLayout_GMZ 
.dw Data_ObjectLayout_SEZ 
.dw Data_ObjectLayout_CEZ 
.dw Data_ObjectLayout_CEZ 
.dw Data_ObjectLayout_CEZ 
.dw Data_ObjectLayout_CEZ

Data_ObjectLayout_UGZ:    ;$8149
.dw Data_ObjectLayout_UGZ1
.dw Data_ObjectLayout_UGZ2 
.dw Data_ObjectLayout_UGZ3 

Data_ObjectLayout_SHZ:    ;$814F
.dw Data_ObjectLayout_SHZ1
.dw Data_ObjectLayout_SHZ2
.dw Data_ObjectLayout_SHZ3

Data_ObjectLayout_ALZ:    ;$8155
.dw Data_ObjectLayout_ALZ1 
.dw Data_ObjectLayout_ALZ2 
.dw Data_ObjectLayout_ALZ3 

Data_ObjectLayout_GHZ:    ;$815B
.dw Data_ObjectLayout_GHZ1 
.dw Data_ObjectLayout_GHZ2 
.dw Data_ObjectLayout_GHZ3 

Data_ObjectLayout_GMZ:    ;$8161
.dw Data_ObjectLayout_GMZ1 
.dw Data_ObjectLayout_GMZ2 
.dw Data_ObjectLayout_GMZ3 

Data_ObjectLayout_SEZ:    ;$8167
.dw Data_ObjectLayout_SEZ1 
.dw Data_ObjectLayout_SEZ2 
.dw Data_ObjectLayout_SEZ3 

Data_ObjectLayout_CEZ:    ;$816D
.dw Data_ObjectLayout_CEZ1 
.dw Data_ObjectLayout_CEZ2 
.dw Data_ObjectLayout_CEZ3


Data_ObjectLayout_UGZ1:    ;$8173
.incbin "layout/ugz/object_layout_ugz1.bin"
Data_ObjectLayout_UGZ2:    ;$82C1
.incbin "layout/ugz/object_layout_ugz2.bin"
Data_ObjectLayout_UGZ3:    ;$840F
.incbin "layout/ugz/object_layout_ugz3.bin"

Data_ObjectLayout_SHZ1:    ;$848E
.incbin "layout/shz/object_layout_shz1.bin"
Data_ObjectLayout_SHZ2:    ;$84E9
.incbin "layout/shz/object_layout_shz2.bin"
Data_ObjectLayout_SHZ3:    ;$8568
.incbin "layout/shz/object_layout_shz3.bin"

Data_ObjectLayout_ALZ1:    ;$8584
.incbin "layout/alz/object_layout_alz1.bin"
Data_ObjectLayout_ALZ2:    ;$8666
.incbin "layout/alz/object_layout_alz2.bin"
Data_ObjectLayout_ALZ3:    ;$87BD
.incbin "layout/alz/object_layout_alz3.bin"

Data_ObjectLayout_GHZ1:    ;$87F4
;.incbin "layout/ghz/object_layout_ghz1.bin"
.include "layout/ghz/object_layout_ghz1.asm"
Data_ObjectLayout_GHZ2:    ;$88C4
.incbin "layout/ghz/object_layout_ghz2.bin"
Data_ObjectLayout_GHZ3:    ;$8970
.incbin "layout/ghz/object_layout_ghz3.bin"

Data_ObjectLayout_GMZ1:    ;$8983
.incbin "layout/gmz/object_layout_gmz1.bin"
Data_ObjectLayout_GMZ2:    ;$8A4A
.incbin "layout/gmz/object_layout_gmz2.bin"
Data_ObjectLayout_GMZ3:    ;$8AFF
.incbin "layout/gmz/object_layout_gmz3.bin"

Data_ObjectLayout_SEZ1:    ;$8B24
.incbin "layout/sez/object_layout_sez1.bin"
Data_ObjectLayout_SEZ2:    ;$8BE2
.incbin "layout/sez/object_layout_sez2.bin"
Data_ObjectLayout_SEZ3:    ;$8C7C
.incbin "layout/sez/object_layout_sez3.bin"

Data_ObjectLayout_CEZ1:    ;$8C8F
.incbin "layout/cez/object_layout_cez1.bin"
Data_ObjectLayout_CEZ2:    ;$8D20
.incbin "layout/cez/object_layout_cez2.bin"
Data_ObjectLayout_CEZ3: ;$8D8D
.incbin "layout/cez/object_layout_cez3.bin"

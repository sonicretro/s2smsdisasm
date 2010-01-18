Logic_Monitors:            ;$B710
.dw Monitors_State_00
.dw Monitors_State_01
.dw Monitors_State_02


Monitors_State_00:        ;$B716
.db $01, $00
    .dw Monitor_Init
.db $FF, $00


Monitors_State_01:        ;$B71C
.db $01, $00
    .dw Monitor_LoadTiles
.db $FF, $00


Monitors_State_02:        ;$B722
.db $05, $02
    .dw Monitor_CheckCollisions
.db $02, $01
    .dw Monitor_CheckCollisions
.db $04, $02
    .dw Monitor_CheckCollisions
.db $02, $01
    .dw Monitor_CheckCollisions
.db $03, $02
    .dw Monitor_CheckCollisions
.db $02, $01
    .dw Monitor_CheckCollisions
.db $FF, $00


;Initialiser
Monitor_Init:       ; $B73C
    set   OBJ_F3_BIT7, (ix + Object.Flags03)
    ld    (ix + Object.StateNext), 1
    ret

;Sets the PLC
Monitor_LoadTiles:      ; $B745
    ld    b, (ix + Object.ix3F)
    call  Monitor_Emerald_CheckLoadTiles
    
    ld    (ix + Object.StateNext), 2
    ret

;Handles collisions
Monitor_CheckCollisions:        ; $B750
    ld    b, (ix + Object.ix3F)
    call  Monitor_Emerald_CheckLoadTiles
    
    bit   OBJ_F4_BIT6, (ix + Object.Flags04)
    ret   nz
    
    call  VF_Engine_CheckCollisionAndAdjustPlayer
    
    ld    a, (Player.Flags03)
    bit   OBJ_F3_BIT1, a
    ret   z
    
    ld    a, (ix + Object.SprColFlags)    ;was there a collision?
    and   %00001111
    ret   z
    
    ; was the collision from above or below?
    cp    $02
    jr    nz, Monitor_CheckCollisions_Above

    ; make player bounce down
    ld    hl, $200
    ld    (Player.VelY), hl
    ret


Monitor_CheckCollisions_Above:      ; $B775
    ; if the player is not moving down dont do anything
    ld    hl, (Player.VelY)
    ld    a, l
    or    h
    ret   z

    ld    a, h
    and   $80
    ret   nz
    
    ; handle the collision
    call  Monitor_SetCollisionValue
    ld    (ix + Object.ix3F), $40    ;FIXME: this is done in the Monitor_SetCollisionValue routine.
    
    ; if player is rolling just display the explosion object
    ld    a, (Player.State)
    cp    PlayerState_Rolling
    jp    z, VF_Engine_DisplayExplosionObject

    ; make player bounce up
    ld    hl, -$400
    ld    (Player.VelY), hl

    jp    VF_Engine_DisplayExplosionObject


Monitor_SetCollisionValue:        ;$B797
    ; check that the monitor type is within bounds
    ld    a, (ix + Object.ix3F)
    cp    10
    ret   nc

    ; calculate index into array
    ld    e, a
    ld    d, $00
    ld    hl, Logic_Data_MonitorTypes
    add   hl, de

    ; set the monitor type flag
    ld    a, (Engine_MonitorCllsnType)
    or    (hl)
    ld    (Engine_MonitorCllsnType), a

    ; set monitor type to $40
    ld    (ix + Object.ix3F), $00
    set   6, (ix + Object.ix3F)        ;FIXME: this could be done in the previous op
    ret     

;collision value for each monitor type
Logic_Data_MonitorTypes:
.db $00        ;nothing
.db $00        ;nothing
.db $01        ;10-rings
.db $02        ;extra life
.db $04        ;speed shoes
.db $08        ;invincibility
.db $10        ;extra continue
.db $20
.db $40
.db $00        ;nothing


Monitor_Emerald_CheckLoadTiles:     ; $B7BE
    ld    c, (ix + Object.ix24)
    ld    a, (ix + Object.Flags04)
    ld    (ix + Object.ix24), a
    
    bit   OBJ_F4_BIT6, a
    ret   nz
    
    bit   OBJ_F4_BIT6, c
    ret   z
    
    ld    a, b
    ld    (PatternLoadCue), a 
    ret

Logic_ChaosEmerald:            ;$B7D2
.dw ChaosEmerald_State_00
.dw ChaosEmerald_State_01
.dw ChaosEmerald_State_02


; constructor
ChaosEmerald_State_00:      ;$B7D8
.db $E0, $00
    .dw ChaosEmerald_Init
.db $FF, $00

; main logic
ChaosEmerald_State_01:      ;$B7DE
.db $E0, $01
    .dw ChaosEmerald_CheckCollisions
.db $FF, $00

; destructor
ChaosEmerald_State_02:      ;$B7E4
.db $F0, $00
    .dw VF_DoNothing
.db $60, $00
    .dw ChaosEmerald_Destruct
.db $FF, $00


ChaosEmerald_Init:      ;$B7EE
    ; change to the next state
    ld      (ix + Object.StateNext), 1
    
    ; if level is SEZ we don't need to bother loading the tiles
    ld      a, (CurrentLevel)
    cp      Level_SEZ
    jr      nz, +
    
    add     a, $20
    ld      (PatternLoadCue), a
    jr      ++

+:
    ld      a, (CurrentLevel)    ;calculate which tiles to load
    add     a, $20                ;see subroutine at 783B (Engine_LoadSpriteTiles)
    ld      b, a
    call    Monitor_Emerald_CheckLoadTiles

++:
    set     OBJ_F3_BIT7, (ix + Object.Flags03)
    res     OBJ_F4_FACING_LEFT, (ix + Object.Flags04)
    set     OBJ_F4_FLASHING, (ix + Object.Flags04)
    
    ld      (ix + Object.RightFacingIdx), 0
    
    ld      a, (CurrentLevel)
    cp      Level_SEZ
    ret     nz
    
    ; if this is SEZ make the emerald bounce up first
    ld      hl, -$600
    ld      (ix + Object.VelY), l
    ld      (ix + Object.VelY + 1), h
    ret     


ChaosEmerald_CheckCollisions:       ; $B829
    ; make sure that the emerald's tiles are loaded
    ld      a, (CurrentLevel)
    add     a, $20
    ld      b, a
    call    Monitor_Emerald_CheckLoadTiles
    
    
    bit     OBJ_F4_BIT6, (ix + Object.Flags04)
    ret     nz
    
    ld      a, (CurrentLevel)
    cp      Level_SEZ
    call    z, ChaosEmerald_CheckCollisions_CEZ
    
    ; check for a collision with the player object
    call    VF_Engine_CheckCollision
    ld      a, (ix + Object.SprColFlags)
    and     %00001111
    ret     z
    
    ; change to the next state
    ld      (ix + Object.StateNext), 2
    
    ; set the "has emerald" trigger
    ld      a, $FF
    ld      (HasEmeraldTrg), a
    
    set     1, (ix+$04)
    xor     a
    ld      (Player.PowerUp), a
    
    ; if this is SEZ then the emerald marks the end of the level
    ld      a, (CurrentLevel)
    cp      Level_SEZ
    jr      z, ChaosEmerald_NextLevel
    
    ; play the emerald sound
    ld      a, Music_Emerald
    ld      (Sound_MusicTrigger1), a
    ret     


ChaosEmerald_NextLevel:     ; $B866
    ld      a, Music_EndOfLevel
    ld      (Sound_MusicTrigger1), a
    ld      hl, GlobalTriggers
    set     GT_NEXT_LEVEL_BIT, (hl)
    ret     


ChaosEmerald_Destruct:      ; $B871
    ; destroy the emerald object
    ld      (ix + Object.ActvObjIdx), 0
    ld      (ix + Object.ObjID), $FF
    
    ld      a, (CurrentLevel)
    cp      Level_SEZ
    ret     z
    
    call    VF_Engine_ChangeLevelMusic
    ret     


ChaosEmerald_CheckCollisions_CEZ:       ; $B883
    call    VF_Engine_CheckCollision
    call    VF_Engine_UpdateObjectPosition
    ld      de, $0040
    ld      bc, $0600
    call    VF_Engine_SetObjectVerticalSpeed
    ld      hl, $0080
    call    LABEL_200 + $12
    ret     

/*
    These structures are used by the level loading routines to
    load the locate the compressed art for each zone.
*/


.struct TilesetHeader
    BankNum            db        ;ROM bank to load tiles from
    VRAMAddress        dw        ;Address to copy tiles to
    SourceAddress    dw
    Entries            dw        ;pointer to the chain of tileset entries
.endst

.struct TilesetEntry
    BankNum            db        ;ROM Bank to load from. Bit 7 is the indexed tiles flag that is passed to the LoadTiles routine.
    VRAMAddress        dw        ;Address to copy tiles to
    SourceAddress    dw
.endst

/*
    Used by the sprite loading routine at $10BF to load the player
    sprites into VRAM at $0000.
*/
.struct SpriteDef
    BankNum            db
    SourceAddress    dw
    LineCount        db        ;LineCount = TileCount/2 (two tiles are copied for each line).
.endst


; =============================================================================
;  LEVEL STRUCTURE & FLAGS
; -----------------------------------------------------------------------------
.struct LevelDescriptor
    ViewportFlags   db
    ix01            db
    MetaTileX       db  ; x-index of metatile (see: Engine_Mappings_GetBlockXY)
    MetaTileY       db  ; y-index of metatile (see: Engine_Mappings_GetBlockXY)
    MetaTileBank    db
    LayoutBank      db
    MetaTilePtr     dw
    LayoutPtr       dw
    StrideTable     dw
    WidthNeg        dw
    Width           dw
    DataOffset      dw
.endst

; Viewport Flag bits
.def LVP_SCROLL_UP              0
.def LVP_SCROLL_DOWN            1
.def LVP_SCROLL_LEFT            2
.def LVP_SCROLL_RIGHT           3
.def LVP_ROW_UPDATE_PENDING     4
.def LVP_COL_UPDATE_PENDING     5
.def LVP_CAMERA_UPDATE_RQD      6
.def LVP_CAMERA_LOCKED          7


; =============================================================================
;  OBJECT STRUCTURE & FLAGS
; -----------------------------------------------------------------------------
.struct Object
    ObjID           db      ; $00 - object number
    State           db      ; $01
    StateNext       db      ; $02
    Flags03         db      ; $03
    Flags04         db      ; $04
    SpriteCount     db      ; $05
    AnimFrame       db      ; $06
    FrameCounter    db      ; $07
    RightFacingIdx  db      ; $08
    LeftFacingIdx   db      ; $09
    ix0A            db      ; movement flags?
    ix0B            db
    LogicPtr        dw      ; $0C - Pointer to logic subroutine.
    LogicSeqPtr     dw      ; $0E - Pointer to logic sequence data
    SubPixelX       db      ; $10 - fractional part of xpos
    X               dw      ; $11 - x pos in level
    SubPixelY       db      ; $13 - fractional part of ypos
    Y               dw      ; $14 - y pos in level
    VelX            dw      ; $16 - x velocity (Q8.8)
    VelY            dw      ; $18 - y velocity (Q8.8)
    ScreenX         dw      ; $1A - x offset on screen
    ScreenY         dw      ; $1C - y offset on screen
    ix1E            db
    ix1F            db
    CollidingObj    db      ; $20 - index of colliding object
    SprColFlags     db      ; $21 - background collision flags
    BgColFlags      db      ; $22 - sprite collision flags
    ix23            db      ; $23 - bg + obj collision flags?
    ix24            db
    ix25            db
    ix26            db
    ix27            db
    SprMappgPtr     dw      ; $28 - pointer to sprite mapping data for current anim frame
    SprOffsets      dw      ; $2A - pointer to sprite SAT offsets (2 words in object anim data)
    Width           db      ; $2C
    Height          db      ; $2D
    FlashCounter    db      ; $2E - counter used to toggle sprite visibility
    ix2F            db
    D530            db
    D531            db
    PowerUp         db      ; $32 - current power-up 
    D533            db
    D534            db
    D535            db
    D536            db
    D537            db
    D538            db
    D539            db
    InitialX        dw      ; $3A - initial x coordinate
    InitialY        dw      ; $3C - initial y coordinate
    ActvObjIdx      db      ; $3E - index of object within active objects array
    ix3F            db
.endst


; ---------------------------------------------------------
;  Object Flag Byte F3 bits
; ---------------------------------------------------------
.def OBJ_F3_IN_AIR      0
.def OBJ_F3_BIT1        1
.def OBJ_F3_BIT2        2
.def OBJ_F3_BIT3        3
.def OBJ_F3_BIT4        4
.def OBJ_F3_BIT5        5
.def OBJ_F3_BIT6        6
.def OBJ_F3_BIT7        7

; ---------------------------------------------------------
;  Object Flag Byte F4 bits
; ---------------------------------------------------------
.def OBJ_F4_BIT0        0
.def OBJ_F4_BIT1        1
.def OBJ_F4_BIT2        2
.def OBJ_F4_BIT3        3
.def OBJ_F4_FACING_LEFT 4
.def OBJ_F4_FLASHING    5
.def OBJ_F4_BIT6        6
.def OBJ_F4_VISIBLE     7

; ---------------------------------------------------------
;  Collision flags (SprColFlags)
; ---------------------------------------------------------
.def OBJ_COL_TOP        0
.def OBJ_COL_BOTTOM     1
.def OBJ_COL_RIGHT      2
.def OBJ_COL_LEFT       3

; ---------------------------------------------------------
;  Object Flag Byte ix23 bits
; ---------------------------------------------------------
.def OBJ_F23_BIT0       0

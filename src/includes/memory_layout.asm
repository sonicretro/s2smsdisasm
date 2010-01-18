; =============================================================================
;  Memory Layout
; -----------------------------------------------------------------------------
;  This file contains memory address definitions for variables.
; -----------------------------------------------------------------------------

.enum $C001
	LevelLayout			dsb $1000
;----------------------------------------------------------
	unk_01				dsb $0129	;//////////////////////
;----------------------------------------------------------
    Frame1Page          db
    Frame2Page          db
	LevelSelectTrg		db
;----------------------------------------------------------
	unk_02				dsb 2		;//////////////////////
;----------------------------------------------------------
	FrameCounter		db
;----------------------------------------------------------
	unk_03				db			;//////////////////////
;----------------------------------------------------------
	PaletteResetTrg		db
;----------------------------------------------------------
	unk_04				dsb $2C		;//////////////////////
;----------------------------------------------------------
	LevelAttributes		instanceof LevelDescriptor
;----------------------------------------------------------
	unk_05				dsb 2		;//////////////////////
;----------------------------------------------------------
	
; =========================================================
;  VDP Variables
; ---------------------------------------------------------
	VDP_VScroll			db
	VDP_HScroll			db
	VDP_ViewportX		dw
	VDP_ViewportY		dw
	VDP_TileColBuffer	dsb	64      ; holds a column of tile indices before copying to the VDP
	VDP_TileRowBuffer	dsb	72      ; holds a row of tile indices before copying to the VDP

;----------------------------------------------------------
	unk_06				dsb 58		;//////////////////////
;----------------------------------------------------------

	CurrentMetaTileAddr	dw
	
    
    SOUND_DRIVER_START: .dw
.ende


.def  Engine_ObjCharCodePtr                 $D110

.def  VDP_SATUpdateTrig                     $D134
.def  Engine_InterruptServiced              $D135       ; byte - set when the interrupt has been serviced
.def  Engine_UpdateSoundOnly                $D136       ; byte - when set only sound driver will update on vsync
.def  Engine_InputFlags                     $D137       ; byte - current controller input flags
.def  Engine_InputFlagsLast                 $D147       ; byte - input flags from the previous frame

.def  Camera_X                              $D174       ; word
.def  Camera_Y                              $D176       ; word
.def  Camera_MetatileColBuffer              $D178       ; 64 b - a buffer to hold tile data from a column of metatiles.

.def  Camera_MetatilePtr                    $D278       ; word - points to a metatile in the layout data (see: Engine_Mappings_GetBlockXY)

.def  GlobalTriggers                        $D293       ; byte - bitfield of various trigger flags (e.g. load level, kill player, etc).
.def  CurrentLevel                          $D295       ; byte - current level number
.def  CurrentAct                            $D296       ; byte - current act number
.def  LivesOnEntry                          $D297       ; byte - player's life counter on entry to the level
.def  LifeCounter                           $D298       ; byte - player's life counter
.def  RingCounter                           $D299       ; byte - player's ring counter (BCD)

.def  ContinueCounter                       $D2BD       ; byte - number of continues remaining.
.def  EmeraldFlags                          $D2C5       ; byte - one bit flag for each emerald.
.def  HasEmeraldTrg                         $D2C6       ; byte - set by the chaos emerald collision routines.
.def  VDP_DefaultTileAttribs                $D2C7       ; byte

.def  Engine_CollisionDataPtr               $D2D4       ; word - pointer to collision data for current level

.def  Engine_DemoSeq_Bank                   $D2D8

.def  Engine_RingAnimFrame                  $D351       ; byte - ring animation frame number.
.def  Cllsn_RingBlock                       $D352       ; byte - used by ring<>player collision routines to store ring metatile number.
.def  Cllsn_MetatileIndex                   $D353       ; byte - the metatile number stored at (Cllsn_LevelMapBlockPtr)
.def  Cllsn_LevelMapBlockPtr                $D354       ; word - pointer to the current metatile block in the level data
.def  Cllsn_AdjustedX                       $D356       ; word - object's x-coordinate + an adjustment value
.def  Cllsn_AdjustedY                       $D358       ; word - object's y-coordinate + an adjustment value
.def  Cllsn_MetaTileX                       $D35A       ; word - metatile's x coordinate
.def  Cllsn_MetaTileY                       $D35C       ; word - metatile's y coordinate
.def  Cllsn_MetaTileSurfaceType             $D35E       ; byte - surface type value for the colliding metatile.
.def  Cllsn_HeaderPtr3                      $D35F       ; word - 3rd pointer in the metatile's collision header
.def  Cllsn_CollisionValueY                 $D361       ; byte - vertical collision value for the current position within the metatile.
.def  Cllsn_CollisionValueX                 $D362       ; byte - horizontal collision value for the current position within the metatile.


.def  Engine_UpdateSpriteAttribs_vpos_ptr   $D369       ; word
.def  Engine_UpdateSpriteAttribs_hpos_ptr   $D36B       ; word
.def  Player_MaxVelX                        $D36D       ; word
.def  Player_DeltaVX                        $D36F       ; word - player object x delta-v?
.def  Player_MetaTileDeltaVX                $D371       ; word - delta-v for platform (gradient/slope)

.def  Engine_UpdateSpriteAttribs_adj_pos    $D393       ; word
.def  Engine_RingArt_Src                    $D395       ; word - pointer to uncompressed ring art data.
.def  Engine_RingArt_Dest                   $D397       ; word - vram destination pointer for ring art tiles.

.def  Player_HurtTrigger                    $D3A8       ; byte - trigger causes player to lose rings or die
.def  Player_FlashCounter                   $D3A9       ; byte

.def  Engine_MonitorCllsnType               $D39D       ; byte - set by monitor collision routines to indicate monitor type.

.def  Player_UnderwaterFlag                 $D467       ; byte
.def  Player_AirTimerLo                     $D468       ; byte
.def  Player_AirTimerHi     				$D469		; byte - incremented when lo byte = $78 (~2 seconds)

.def  Player_KillTrigger                    $D49F       ; byte - causes player to die, regardless of ring count.

.def  UpdatePalettesOnly                    $D4A3

.def  Engine_PowerUpTimer                   $D4A0       ; byte - timer for invincibility

.def  Engine_DynPalette_0                   $D4A6       ; byte

.def  Engine_DynPalette_1                   $D4AE       ; byte

.def  Palette_UpdateTrig                    $D4EA       ; causes a CRAM update with the next vblank


; ---------------------------------------------------------
.def  Engine_ObjectSlots                    $D500

.enum Engine_ObjectSlots
PlayerObj:              .dw
    Player              instanceof Object
.ende
; ---------------------------------------------------------


.def  VDP_WorkingSAT            $DB00
.def  VDP_WorkingSAT_VPOS       VDP_WorkingSAT
.def  VDP_WorkingSAT_HPOS       VDP_WorkingSAT + 64

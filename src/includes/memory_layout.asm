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
	Engine_FrameCounter		db
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
	VDP_TileColBuffer	dsb	64
	VDP_TileRowBuffer	dsb	72

;----------------------------------------------------------
	unk_06				dsb 58		;//////////////////////
;----------------------------------------------------------

	CurrentMetaTileAddr	dw
	
    
    SOUND_DRIVER_START: .dw
.ende

.def  VDP_SATUpdateTrig         $D134

.def  VDP_DefaultTileAttribs    $D2C7

.def  UpdatePalettesOnly        $D4A3
.def  Palette_UpdateTrig        $D4EA       ; causes a CRAM update with the next vblank

.def  VDP_WorkingSAT            $DB00
.def  VDP_WorkingSAT_VPOS       VDP_WorkingSAT
.def  VDP_WorkingSAT_HPOS       VDP_WorkingSAT + 64

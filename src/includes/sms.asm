; =========================================================
;  IO Ports
; ---------------------------------------------------------
.def    Ports_GG_Start      $00
.def    Ports_GG_Stereo     $06

.def    Ports_IO_Control    $3F

.def    Ports_IO1           $DC
.def    Ports_IO2           $DD

.def    Ports_VDP_VCounter  $7E
.def    Ports_VDP_HCounter  $7F

.def    Ports_PSG           $7F

.def    Ports_VDP_Data      $BE
.def    Ports_VDP_Control   $BF


; =========================================================
;  Input Bitfield
; ---------------------------------------------------------
.def    BTN_UP_BIT          0
.def    BTN_DOWN_BIT        1
.def    BTN_LEFT_BIT        2
.def    BTN_RIGHT_BIT       3
.def    BTN_1_BIT           4
.def    BTN_2_BIT           5

.def    BTN_UP              1 << BTN_UP_BIT
.def    BTN_DOWN            1 << BTN_DOWN_BIT
.def    BTN_LEFT            1 << BTN_LEFT_BIT
.def    BTN_RIGHT           1 << BTN_RIGHT_BIT
.def    BTN_1               1 << BTN_1_BIT
.def    BTN_2               1 << BTN_2_BIT


; =========================================================
;  Display Mode Bitfields
; ---------------------------------------------------------
.def	VDP_DispMode_M1			$01
.def	VDP_DispMode_M2			$02
.def	VDP_DispMode_M3			$04
.def	VDP_DispMode_M4			$08
;SMS mode, 224-line display
.def	VDP_DispMode_SMS_224	VDP_DispMode_M4 | VDP_DispMode_M2 | VDP_DispMode_M1
;SMS mode, 240-line display
.def	VDP_DispMode_SMS_240	VDP_DispMode_M4 | VDP_DispMode_M3 | VDP_DispMode_M2

; =========================================================
;  Mode Control Register 1 (VDP R0) Flags
; ---------------------------------------------------------
.def	VDP_SyncEnableBit		$01
.def	VDP_ExtraHeightBit		$02
.def	VDP_Mode4Bit			$04
.def	VDP_SpriteShiftBit		$08
.def	VDP_LineInterruptsBit	$10
.def	VDP_MaskColumn0Bit		$20
.def	VDP_HScrollBit			$40
.def	VDP_VScrollBit			$80

; =========================================================
;  Mode Control Register 2 (VDP R1) Flags
; ---------------------------------------------------------
.def	VDP_SpriteDoublingBit	$01
.def	VDP_LargeSpritesBit		$02
.def	VDP_240LineSelectBit	$08
.def	VDP_224LineSelectBit	$10
.def	VDP_FrameInterruptsBit	$20
.def	VDP_DisplayVisibleBit	$40



.def    VDP_ScreenMap           $3800
.def    VDP_SATAddress          $3F00

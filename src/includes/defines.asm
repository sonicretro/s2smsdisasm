; =============================================================================
;  Global Engine Definitions
; -----------------------------------------------------------------------------
;  Constant values used throughout the program code.
; -----------------------------------------------------------------------------


; ---------------------------------------------------------
;  Timing Definitions (based on 60hz display)
; ---------------------------------------------------------
.def  Time_1Second              60
.def  Time_2Seconds             120
.def  Time_3Seconds             180

; ---------------------------------------------------------
;  Global Triggers Bitfield
; ---------------------------------------------------------
.def  GT_BIT_0                  0
.def  GT_BIT_1                  1
.def  GT_TITLECARD_BIT          2
.def  GT_KILL_PLAYER_BIT        3
.def  GT_NEXT_LEVEL_BIT         4
.def  GT_NEXT_ACT_BIT           5
.def  GT_GAMEOVER_BIT           6
.def  GT_END_SEQUENCE_BIT       7

.def  GT_0                      1 << GT_BIT_0
.def  GT_1                      1 << GT_BIT_1
.def  GT_TITLECARD              1 << GT_TITLECARD_BIT
.def  GT_KILL_PLAYER            1 << GT_KILL_PLAYER_BIT
.def  GT_NEXT_LEVEL             1 << GT_NEXT_LEVEL_BIT
.def  GT_NEXT_ACT               1 << GT_NEXT_ACT_BIT
.def  GT_GAMEOVER               1 << GT_GAMEOVER_BIT
.def  GT_END_SEQUENCE           1 << GT_END_SEQUENCE_BIT

; ---------------------------------------------------------
;  Monitor Types
; ---------------------------------------------------------
.def  MonitorType_None0         0
.def  MonitorType_None1         1
.def  MonitorType_Rings         2

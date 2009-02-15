.def	PlayerState_Standing		$01
.def	PlayerState_Idle			$02	;idle animation
.def	PlayerState_LookUp			$03
.def	PlayerState_Crouch			$04
.def	PlayerState_Walking			$05
.def	PlayerState_Running			$06
.def	PlayerState_SkiddingRight	$07
.def	PlayerState_SkiddingLeft	$08
.def	PlayerState_Rolling			$09
.def	PlayerState_Jumping			$0A
.def	PlayerState_VerticalSpring	$0B ;set after collision with vertical spring
.def	PlayerState_OnLoop			$0C	;sprite rotated 45 degrees CCW.

.def	PlayerState_Falling			$0E

.def	PlayerState_HangGlider		$13	;set after touching hang glider
.def	PlayerState_HangGliderBack	$14	;set when pressing left with hang glider
.def	PlayerState_HangGliderFwd	$15	;set when pressing right with hang glider
.def	PlayerState_EnterMineCart	$16
.def	PlayerState_InMineCart		$17
.def	PlayerState_Balance			$19
.def	PlayerState_ALZSlope		$1A	;set on ALZ slippery slope
.def	PlayerState_JumpFromRamp	$1B	;e.g. in UGZ-3 before boss & when exiting SEZ/ALZ tube
.def	PlayerState_DiagonalSpring	$1C	;set after collision with diagonal spring
.def	PlayerState_FallFromLoop	$1D	;set if a player falls from loop (not moving fast enough).
.def	PlayerState_Hurt			$1E
.def	PlayerState_LostLife		$1F
.def	PlayerState_EndOfLevel		$20	;Set at end of level. CPU controlled movement off of screen.
.def	PlayerState_InPipe			$21	;Set in ALZ/SEZ on entering a pipe.

.def	PlayerState_UGZ_Boss		$23	;Set when caught by robotnik in UGZ-3
.def	PlayerState_ALZ_Bubble		$24	;Set on collision with ALZ big bubble

.def	PlayerState_SHZ3_Boss_Fall	$26	;Set by SHZ boss during state $06

.def	PlayerState_Drowning		$28

.def	PlayerState_EndSequence		$2B

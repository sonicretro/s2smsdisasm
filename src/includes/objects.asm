; =============================================================================
;  Object Definitions
; -----------------------------------------------------------------------------
;  
; -----------------------------------------------------------------------------

.def	Object_Sonic				$01
.def	Object_RingSparkle			$02
.def	Object_SpeedShoesStar		$03
.def	Object_BlockFragment		$04
.def	Object_InvincibilityStar	$05
.def	SpecObj_HideTimerRings		$06		;special object. spawned by prison capsule after boss to hide ring counter & timer.
.def	Object_BlockFragment2		$07
.def	Object_DroppedRing			$08
.def	Object_AirCountdown			$09		;air timer countdown
.def	Object_ALZ_Bubble			$0A		;ALZ big bubble
.def	Object_WaterSplash			$0B		;ALZ water splash

;.def    Object_Fireball?            $0D     ; same logic as $0E
.def    Object_UGZFireball          $0E
.def	Object_Explosion			$0F
.def	Object_Monitor				$10
.def    Object_ChaosEmerald1        $11
.def    Object_ChaosEmerald2        $12
.def    Object_ChaosEmerald3        $13
.def    Object_ChaosEmerald4        $14
;.def    Object_Signpost2            $15     ; same logic as signpost, different anims
;.def    Object_Signpost3            $16     ; same logic as signpost, different anims
;.def    Object_Signpost4            $17     ; same logic as signpost, different anims
.def    Object_Signpost             $18

.def    Object_IntroClouds          $1D     ; intro sequence clouds
.def    Object_IntroTree            $1E     ; intro sequence tree
;.def    Object_Invalid              $1F     ; invalid object (logic pointer points into data)

;********************************************
;*		Objects $20 - $3F: Badniks			*
;********************************************
.def	Object_Crab					$23
.def	Object_CrabProjectile		$24

.def	Object_Glider				$27

.def	Object_MineCart				$29

.def    Object_Motobug              $34     ;motobug badnik
.def	Object_Newtron				$35		;newtron badnik
.def	Object_SHZ3_SmallBird1		$36		;used during the SHZ boss along with $46 - spawned by $48

.def	Object_Newtron_Fireball		$3C		;fireballs created by object $35

;********************************************
;*		Objects $40 -$??: Bosses			*
;********************************************
.def	Object_PrisonCapsule		$40
.def	Object_PrisonAnimals		$41

.def	Object_SHZ3_SmallBird2		$46		;used alongside $36 - spawned by $47
.def	Object_SHZ3_EggCapsule		$47
.def	Object_SHZ3_Boss			$48
.def	Object_SHZ3_Boss_Fireball	$49
.def	Object_ALZ3_Boss			$4A
.def	Object_UGZ_Robotnik			$4B
.def	Object_UGZ_CannonBall		$4C
.def	Object_UGZ_Pincers			$4D

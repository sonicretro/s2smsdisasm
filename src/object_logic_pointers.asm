
;Bank 31 objects
.dw Logic_Sonic					;01 - sonic
.dw Logic_RingSparkle			;02 - Ring sparkle
.dw Logic_SpeedShoesStars		;03 - speed shoes stars
.dw Logic_BlockFragment			;04 - Fragment of broken block
.dw Logic_InvincibilityStars	;05 - invincibility stars
.dw Logic_HideTimerRings		;06 - Special object - hide rings & timer
.dw DATA_B31_ACEB				;07 - Fragment of broken block (different logic to $04).
.dw Logic_DroppedRing			;08	- Dropped ring
.dw Logic_AirCountdown			;09 - Air timer countdown
.dw Logic_ALZ_Bubble			;0A
.dw Logic_WaterSplash			;0B
.dw DATA_B31_B513				;0C
.dw Logic_UGZ_Fireball			;0D - same logic as $0E
.dw Logic_UGZ_Fireball			;0E - used in UGZ
.dw Logic_Explosion				;0F
.dw Logic_Monitors				;10
.dw Logic_ChaosEmerald			;11
.dw Logic_ChaosEmerald			;12
.dw Logic_ChaosEmerald			;13
.dw Logic_ChaosEmerald			;14
.dw Logic_Signpost				;15
.dw Logic_Signpost				;16
.dw Logic_Signpost				;17
.dw Logic_Signpost				;18
.dw DATA_B31_BA7A				;19
.dw DATA_B31_BA86				;1A
.dw DATA_B31_BA7A				;1B
.dw DATA_B31_BBC6				;1C
.dw Logic_IntroCloudsAndPalette	;1D
.dw Logic_IntroTree				;1E
.dw Data_PlayerSprites			;1F ($BCCB) - invalid (not logic!)

;Bank 28 objects
.dw DATA_B28_8000				;20
.dw DATA_B28_8200				;21
.dw DATA_B28_83C5				;22
.dw Logic_Crab					;23
.dw Logic_CrabProjectile		;24
.dw DATA_B28_85F3				;25
.dw DATA_B28_8645				;26
.dw DATA_B28_8762				;27
.dw DATA_B28_8802				;28
.dw Logic_Minecart				;29
.dw DATA_B28_8B5A				;2A
.dw DATA_B28_8CB5				;2B
.dw DATA_B28_8DBD				;2C
.dw DATA_B28_8EB1				;2D
.dw DATA_B28_8EF1				;2E
.dw DATA_B28_901C				;2F
.dw DATA_B28_ACB8				;30
.dw DATA_B28_ACB8				;31
.dw DATA_B28_ACB8				;32
.dw DATA_B28_AEB5				;33
.dw Logic_Motobug				;34 - Motobug badnik
.dw Logic_Newtron				;35 - newtron badnik
.dw DATA_B28_B443				;36	- SHZ - small birds (same as boss?)
.dw DATA_B28_B6AF				;37
.dw DATA_B28_B73A				;38
.dw DATA_B28_B8E2				;39
.dw DATA_B28_B9CC				;3A
.dw DATA_B28_BB2C				;3B
.dw DATA_B28_BD8E				;3C
.dw DATA_B28_BDF0				;3D
.dw DATA_B28_BEEA				;3E
.dw DATA_B28_BFAC				;3F - FIXME: This is an invalid pointer - points to the padding at the end of bank 28
.dw Logic_PrisonCapsule			;40 - End of level prison capsule
.dw Logic_PrisonAnimals			;41	- End of level prison capsule animals
.dw DATA_B28_9419				;42
.dw DATA_B28_97C1				;43
.dw DATA_B28_97C1				;44
.dw DATA_B28_9A8A				;45
.dw Logic_SHZ3_BirdRobot2		;46 - SHZ boss small bird robots
.dw Logic_SHZ3_EggCapsule		;47 - SHZ boss egg capsules
.dw Logic_SHZ3_Boss				;48 - SHZ boss big bird
.dw Logic_SHZ3_Fireball			;49 - SHZ boss big bird's fireball
.dw DATA_B28_9FB8				;4A - ALZ boss (sea lion)
.dw Logic_UGZ3_Robotnik			;4B	- UGZ-3 boss - Robotnik
.dw Logic_UGZ3_CannonBall		;4C - UGZ-3 boss - cannon ball
.dw Logic_UGZ3_Pincers			;4D	- UGZ-3 boss - pincers
.dw DATA_B28_A813				;4E
.dw DATA_B28_9FCC				;4F

;Bank 30 objects
.dw Logic_Title_SonicHand		;50 - Sonic's hand (title screen)
.dw Logic_Title_TailsEye		;51 - Tails' eye (title screen)


.dw DATA_B28_9419				;52 - FIXME: check this


.dw DATA_B30_8E2B				;53
.dw DATA_B30_8FC6				;54
.dw DATA_B30_903D				;55


.dw Logic_SHZ3_BirdRobot2		;56 - FIXME: check these -
.dw Logic_SHZ3_EggCapsule		;57		all point into bank 28
.dw Logic_SHZ3_Boss				;58		but bank 30 will be paged in
.dw Logic_SHZ3_Fireball			;59		before they are called.
.dw DATA_B28_9FB8				;5A
.dw Logic_UGZ3_Robotnik			;5B
.dw Logic_UGZ3_CannonBall		;5C


.dw DATA_B30_9456			;5D
.dw DATA_B30_9671			;5E
.dw DATA_B30_96FC			;5F

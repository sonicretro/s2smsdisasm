;************************************************************
;*   Main logic vtable - used extensively by object logic   *
;************************************************************
.org $0200
LABEL_200:
VF_Engine_AllocateObjectHighPriority:           ;$200 - find an available object slot from $D540 onwards
    jp  Engine_AllocateObjectHighPriority                           
VF_Engine_AllocateObjectLowPriority:            ;$203 - find an available object slot from $D700 onwards
    jp  Engine_AllocateObjectLowPriority
VF_Engine_DeallocateObject:                     ;$206
    jp  Engine_DeallocateObject
VF_Engine_MoveObjectToPlayer:                   ;$209
    jp  Engine_MoveObjectToPlayer
VF_Logic_CheckDestroyObject:                    ;$20C
    jp  Logic_CheckDestroyObject
VF_Engine_SetObjectVerticalSpeed:
    jp  Engine_SetObjectVerticalSpeed           ;$20F
    jp  LABEL_631A                              ;$212
    jp  LABEL_6344                              ;$215
VF_Engine_CheckCollisionAndAdjustPlayer:        ;$218
    jp  Engine_CheckCollisionAndAdjustPlayer
    jp  LABEL_6355                              ;$21B
    jp  LABEL_635B                              ;$21E
    jp  LABEL_63A9                              ;$221
    jp  LABEL_63C0                              ;$224
VF_Engine_AdjustPlayerAfterCollision:           ;$227
    jp  Engine_AdjustPlayerAfterCollision
VF_DoNothing:                                   ;$22A
    jp  DoNothingStub
    jp  LABEL_64B1                              ;$22D
VF_Engine_GetObjectIndexFromPointer:            ;$230
    jp  Engine_GetObjectIndexFromPointer
VF_Engine_GetObjectDescriptorPointer:           ;$233
    jp  Engine_GetObjectDescriptorPointer
    jp  LABEL_64D4                              ;$236
    jp  LABEL_6544                              ;$239
VF_Logic_UpdateObjectDirectionFlag              ;$23C
    jp  Logic_UpdateObjectDirectionFlag
VF_Logic_ChangeDirectionTowardsPlayer:          ;$23F
    jp  Logic_ChangeDirectionTowardsPlayer
VF_Logic_ChangeDirectionTowardsObject:          ;$242
    jp  Logic_ChangeDirectionTowardsObject
VF_Logic_MoveHorizontalTowardsPlayerAt0400      ;$245
    jp  Logic_MoveHorizontalTowardsPlayerAt0400
VF_Logic_MoveHorizontalTowardsObject:           ;$248
    jp  Logic_MoveHorizontalTowardsObject
VF_Logic_MoveVerticalTowardsObject:             ;$24B
    jp  Logic_MoveVerticalTowardsObject
VF_Logic_SetObjectFacingRight:                  ;$24E
    jp  Logic_SetObjectFacingRight
VF_Logic_SetObjectFacingLeft:                   ;$251
    jp  Logic_SetObjectFacingLeft
VF_Logic_ToggleObjectDirection:                 ;$254
    jp  Logic_ToggleObjectDirection
VF_Engine_UpdateObjectPosition:
    jp  Engine_UpdateObjectPosition             ;$257
VF_Engine_CheckCollision:
    jp  Engine_CheckCollision                   ;$25A
VF_Engine_DisplayExplosionObject:
    jp  Engine_DisplayExplosionObject           ;$25D
    jp  LABEL_75C5                              ;$260
VF_Engine_GetCollisionValueForBlock:
    jp  Engine_GetCollisionValueForBlock        ;$263 - collide with background tiles
    jp  LABEL_2FCB                              ;$266
VF_Player_HandleStanding:
    jp  Player_HandleStanding                   ;$269
VF_Engine_IncrementRingCounter:
    jp  IncrementRingCounter                    ;$26C
VF_Player_CalculateLoopFrame:                   ;$26F
    jp  Player_CalculateLoopFrame
VF_Player_CalculateLoopFallFrame:               ;$272
    jp  Player_CalculateLoopFallFrame
VF_Engine_LockCamera:                           ;$275
    jp  Engine_LockCamera
VF_Engine_ReleaseCamera:
    jp  Engine_ReleaseCamera                    ;$278
VF_Player_PlayHurtAnimation:
    jp  Player_PlayHurtAnimation                ;$27B
    jp  LABEL_4037                              ;$27E
    jp  LABEL_46BB                              ;$281
VF_Player_HandleVerticalSpring:
    jp  Player_HandleVerticalSpring             ;$284
    jp  LABEL_34DA                              ;$287
    jp  LABEL_3484                              ;$28A
VF_Player_HandleFalling:
    jp  Player_HandleFalling                    ;$28D
    jp  LABEL_41DD                              ;$290
    jp  LABEL_40D6                              ;$293
    jp  LABEL_408E                              ;$296
    jp  LABEL_4199                              ;$299
    jp  LABEL_40B2                              ;$29C
VF_Player_HandleJumping:
    jp  Player_HandleJumping                    ;$29F
    jp  LABEL_424A                              ;$2A2
VF_Player_HandleDiagonalSpring:                 ;$2A5
    jp  Player_HandleDiagonalSpring
VF_Player_HandleCrouched:
    jp  Player_HandleCrouched                   ;$2A8
VF_Player_HandleLookUp:
    jp  Player_HandleLookUp                     ;$2AB
    jp  LABEL_438A                              ;$2AE
VF_Player_HandleRolling:
    jp  Player_HandleRolling                    ;$2B1
    jp  LABEL_359B                              ;$2B4 - loop motion
VF_Player_SetState_MoveBack:                    ;$2B7
    jp  Player_SetState_MoveBack
VF_Player_HandleRunning:
    jp  Player_HandleRunning                    ;$2BA
VF_Player_HandleEndOfLevel:                     ;$2BD
    jp  Player_HandleEndOfLevel
    jp  LABEL_3467                              ;$2C0
VF_Player_HandleIdle:
    jp  Player_HandleIdle                       ;$2C3
VF_Player_Nop:
    jp  Player_Nop                              ;$2C6
    jp  LABEL_375F                              ;$2C9
VF_Player_HandleSkidRight:
    jp  Player_HandleSkidRight                  ;$2CC
VF_Player_HandleSkidLeft:
    jp  Player_HandleSkidLeft                   ;$2CF
    jp  LABEL_46C0                              ;$2D2
    jp  LABEL_46EA                              ;$2D5
VF_Player_HandleWalk:
    jp  Player_HandleWalk                       ;$2D8
    jp  Player_MineCart_Handle                  ;$2DB
VF_UpdateCyclingPalette_ScrollingText:          ;$2DE
    jp  UpdateCyclingPalette_ScrollingText
    jp  LABEL_33B7                              ;$2E1
VF_Engine_CreateBlockFragmentObjects
    jp  Engine_CreateBlockFragmentObjects       ;$2E4 - spawn the 4 block fragment objects
    jp  LABEL_348F                              ;$2E7
    jp  LABEL_34A4                              ;$2EA - collide with air bubble - reset air timer.
    jp  LABEL_20FB                              ;$2ED
VF_Player_HandleBalance:                        ;$2F0
    jp  Player_HandleBalance
    jp  LABEL_49CF                              ;$2F3
VF_Engine_SetCameraAndLock:                     ;$2F6
    jp  Engine_SetCameraAndLock
VF_Player_ChangeFrameDisplayTime:               ;$2F9 - change frame display time based on speed
    jp  Player_ChangeFrameDisplayTime
VF_Player_Anim_CalcBalanceFrame:                ;$2FC
    jp  Player_Anim_CalcBalanceFrame
    jp  LABEL_34A9                              ;$2FF
VF_Engine_SetMinimumCameraX:
    jp  Engine_SetMinimumCameraX                ;$302
VF_Engine_SetMaximumCameraX:
    jp  Engine_SetMaximumCameraX                ;$305
    jp  LABEL_34E1                              ;$308
VF_Engine_CapLifeCounterValue                   ;$30B
    jp  Engine_CapLifeCounterValue
VF_Engine_UpdateRingCounterSprites:             ;$30E
    jp  Engine_UpdateRingCounterSprites         ;$30E
VF_Engine_RemoveBreakableBlock:                 ;$311
    jp  Engine_RemoveBreakableBlock
VF_Engine_ChangeLevelMusic:
    jp  Engine_ChangeLevelMusic                 ;$314
VF_Score_AddBadnikValue:
    jp  Score_AddBadnikValue                    ;$317
VF_Score_AddBossValue:
    jp  Score_AddBossValue                      ;$31A
    jp  LABEL_1CC4                              ;$31D
    jp  LABEL_1CCA                              ;$320

sfx_jump_bin:
.dw $8A2F
.db $01        ;num channels
.db $01
.db $80
.db $A0

sfx_jump_bin_Channel0_Header:
.dw sfx_jump_bin_Channel0
.db $00        ; pitch adjustment
.db $01        ; volume adjustment

sfx_jump_bin_Channel0:
    PitchBend       1, 1, -7, 1
    Rest
        .db $01
        
    ReadLiteral_On
    
    .db $00, $CE
        .db $13
    
    PitchBend           3, 2, 2, 7

sfx_jump_bin_LABEL_BB60:
    RepeatLast      0
    
    .db $CE, $02
    
    AdjustVolume    2
    Loop            0, 7, sfx_jump_bin_LABEL_BB60
    Stop


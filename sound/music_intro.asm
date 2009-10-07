; BASE $A7C6
.dw $8A2F

.db $04     ; channels
.db 0
.db $02     ; tempo
.db 0

; CHANNEL 0 HEADER
.dw Channel0_Data   ; channel data ptr
.db $FF     ; global pitch adjustment
.db $04     ; global volume adjustment

; CHANNEL 1 HEADER
.dw Channel1_Data   ; channel data ptr
.db $FF     ; global pitch adjustment
.db $03     ; global volume adjustment

; CHANNEL 2 HEADER
.dw Channel2_Data
.db $FF
.db $03

; CHANNEL 3 HEADER (noise)
.dw Channel3_Data
.db 0
.db 0


Channel0_Data:  ; $A7DC
.db $F8     ; branch
    .dw Channel0_Intro
.db $F7     ; loop
    .db 0                   ; slot number
    .db 8                   ; counter
    .dw Channel0_Data       ; loop address
.db $E6
    .db $FF
.db $F5         ; set volume effect
    .db $08     ; volume envelope 8
.db $F0     ; detune
    .db $09     ; apply after 9 ticks
    .db $01     ; apply with each tick
    .db $01     ; step of 1 unit
    .db $05     ; depth of 5 steps
.db $9F                 ;F#5
    .db $01             ; hold for 1 tick
.db $A0                 ;G5
    .db $0B             ; hold for 11 ticks
.db $9F                 ;F#5
    .db $01
.db $A0                 ;G5
    .db $08
.db $9E                 ;F5
    .db $09
.db $9D                 ;E5
    .db $06
.db $9D                 ;E5
    .db $01
.db $9E                 ;F5
    .db $05
.db $9D
    .db $0C
.db $99
.db $94
    .db $12
.db $F0     ; detune
    .db $01     ; on 1st tick
    .db $01     ; with each tick
    .db $FB     ; step of -5
    .db $01     ; depth of 1 == 256 steps
.db $94
    .db $0C
.db $F0
    .db $09
    .db $01
    .db $01
    .db $05
.db $A0
.db $9F
    .db $01
.db $A0
    .db $08
.db $9E
    .db $09
.db $9D
    .db $06
.db $9D
    .db $01
.db $9E
    .db $05
.db $9D
    .db $2A
.db $F0
    .db $01
    .db $01
    .db $FB
    .db $01
.db $94
    .db $0C
.db $F0
    .db $09
    .db $01
    .db $01
    .db $05
.db $9F
    .db $01
.db $A0
    .db $0B
.db $9F
    .db $01
.db $A0
    .db $08
.db $9E
    .db $09
.db $9D
    .db $06
.db $9D
    .db $01
.db $9E
    .db $05
.db $9D
    .db $0C
.db $99
.db $94
    .db $12
.db $F0
    .db $01
    .db $01
    .db $FB
    .db $01
.db $94
    .db $0C
.db $F0
    .db $09
    .db $01
    .db $01
    .db $05
.db $A0
.db $9F
    .db $01
.db $A0
    .db $08
.db $9E
    .db $09
.db $9D
    .db $06
.db $9D
    .db $01
.db $9E
    .db $0B
.db $F5
    .db $03
.db $9E
    .db $06
.db $A0
    .db $09
.db $A4
.db $A5
    .db $06
.db $E6
    .db $02
.db $F7             ; loop
    .db $00
    .db $06
    .dw $A85E
.db $F2

Channel0_Intro:      ; $A768
.db $F5         ; set volume effect
    .db $03     ; envelope 3
.db $A0         ;G5
    .db $03     ; hold for 3 ticks
.db $A7         ;C6
.db $AA         ;F6
.db $AC         ;G6
.db $B1         ;C7
.db $AC         ;G6
.db $AA         ;F6
.db $A7         ;C6
.db $F9     ;return



Channel2_Data:      ; $A874
.db $F5
    .db $07
.db $88
    .db $02
.db $80
    .db $01
.db $88
    .db $02
.db $80
    .db $01
.db $E6             ; set volume adjust
    .db $02
.db $88
    .db $05
.db $80
    .db $01
.db $E6
    .db $02
.db $88
    .db $05
.db $80
    .db $01
.db $E6
    .db $FC
.db $88
    .db $02
.db $80
    .db $01
.db $88
    .db $02
.db $80
    .db $01
.db $E6
    .db $02
.db $88
    .db $05
.db $80
    .db $01
.db $E6
    .db $FE
.db $85
    .db $06
.db $86
.db $87
.db $F7         ; loop
    .db $00
    .db $04
    .dw Channel2_Data
Channel2_Loop1:
.db $81
    .db $06
.db $88
.db $8B
.db $8D
    .db $03
.db $81
    .db $06
.db $81
    .db $03
.db $88
    .db $06
.db $8B
.db $8D
.db $F7
    .db $00
    .db $07
    .dw Channel2_Loop1
.db $88
    .db $06
.db $88
.db $80
    .db $03
.db $88
    .db $09
Channel2_Loop2:
.db $81
    .db $06
.db $E6
    .db $02
.db $F7
    .db $00
    .db $06
    .dw Channel2_Loop2
.db $F2


Channel1_Data:      ; $A8C9
.db $F8     ; jump
    .dw $A991
.db $FB     ; alter pitch adjustment
    .db $02
.db $F8     ; jump
    .dw $A991
.db $F5
    .db $03
.db $FB     ; alter pitch
    .db $FE
.db $98
    .db $03
.db $98
.db $E6
    .db $02
.db $98
    .db $06
.db $E6
    .db $02
.db $98
    .db $06
.db $E6
    .db $FC
.db $98
    .db $03
.db $98
.db $E6
    .db $02
.db $98
    .db $06
.db $E6
    .db $02
.db $98
    .db $06
.db $E6
    .db $FC
.db $F5
    .db $06
.db $F0
    .db $08
    .db $01
    .db $F8
    .db $01
.db $94
    .db $0C
Channel1_Loop1:     ; $A8F8
.db $F0
    .db $0B
    .db $03
    .db $05
    .db $01
.db $AC
    .db $0C
.db $F0
    .db $00
    .db $00
    .db $00
    .db $00
.db $E6
    .db $02
.db $F7         ; loop
    .db $00
    .db $04
    .dw Channel1_Loop1
.db $E6
    .db $F8
.db $F5
    .db $08
.db $E6
    .db $01
.db $F0
    .db $09
    .db $01
    .db $01
    .db $05
.db $9C
    .db $01
.db $9D
    .db $0B
.db $9C
    .db $01
.db $9D
    .db $08
.db $9B
    .db $09
.db $99
    .db $06
.db $99
    .db $01
.db $9B
    .db $05
.db $99
    .db $0C
.db $94
.db $91
    .db $12
.db $F0
    .db $01
    .db $01
    .db $FB
    .db $01
.db $91
    .db $0C
.db $F0
    .db $09
    .db $01
    .db $01
    .db $05
.db $9D
.db $9C
    .db $01
.db $9D
    .db $08
.db $9B
    .db $09
.db $99
    .db $06
.db $99
    .db $01
.db $9B
    .db $05
.db $99
    .db $2A
.db $F0
    .db $01
    .db $01
    .db $FB
    .db $01
.db $91
    .db $0C
.db $F0
    .db $09
    .db $01
    .db $01
    .db $05
.db $9C
    .db $01
.db $9D
    .db $0B
.db $9C
    .db $01
.db $9D
    .db $08
.db $9B
    .db $09
.db $99
    .db $06
.db $99
    .db $01
.db $9B
    .db $05
.db $99
    .db $0C
.db $94
.db $91
    .db $12
.db $F0
    .db $01
    .db $01
    .db $FB
    .db $01
.db $91
    .db $0C
.db $F0
    .db $09
    .db $01
    .db $01
    .db $05
.db $9D
.db $9C
    .db $01
.db $9D
    .db $08
.db $9B
    .db $09
.db $99
    .db $06
.db $99
    .db $01
.db $9B
    .db $0B
.db $F5
    .db $03
.db $98
    .db $06
.db $9B
    .db $09
.db $A0
Channel1_Loop2:
.db $A9
    .db $06
.db $E6
    .db $02
.db $F7         ; loop
    .db $00
    .db $06
    .dw Channel1_Loop2
.db $F2

; SEEMS TO BE UNREFERENCED DATA
.db $F5 
    .db $03
.db $94
    .db $03
.db $94
.db $E6
    .db $02
.db $94
    .db $06
.db $E6
    .db $02
.db $94
    .db $06
.db $E6
    .db $FC
.db $94
    .db $03
.db $94
.db $E6
    .db $02
.db $94
    .db $06
.db $E6
    .db $02
.db $94
    .db $06
.db $E6
    .db $FC
.db $94
    .db $03
.db $94
.db $E6
    .db $02
.db $94
    .db $06
.db $E6
    .db $FE
.db $F9


Channel3_Data:      ; $A9B7
.db $88         ;long
    .db $03
.db $88         ;long
.db $81         ;short
.db $81         ;short
.db $81
.db $81
.db $88
.db $88
.db $81
.db $81
.db $88
.db $81
.db $88
.db $81
.db $88
.db $81
.db $F7
    .db $00
    .db $03
    .dw Channel3_Data
.db $88
    .db $03
.db $81
.db $81
.db $81
.db $88
.db $81
.db $81
.db $81
.db $88
.db $81
.db $88
.db $81
.db $88
.db $88
.db $88
.db $88
Channel3_Loop1:     ; $A9DE
.db $81
.db $81
.db $88
.db $81
.db $81
.db $81
.db $88
.db $81
.db $81
.db $81
.db $88
.db $81
.db $81
.db $81
.db $88
.db $81
.db $F7
    .db $00
    .db $07
    .dw Channel3_Loop1
.db $88
.db $81
.db $88
.db $81
.db $81
.db $88
.db $81
.db $81
.db $88
    .db $18
.db $80
    .db $30
.db $F2

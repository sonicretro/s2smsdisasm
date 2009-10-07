; BASE $A7C6
.dw $8A2F

.db $04     ; channels
.db 0
.db $03     ; tempo ( 3 = 120 BPM)
.db 0


; CHANNEL 0 HEADER
.dw Channel0_Data   ; channel data ptr
.db $FF     ; global pitch adjustment
.db $03     ; global volume adjustment

; CHANNEL 1 HEADER
.dw Channel1_Data   ; channel data ptr
.db $FF     ; global pitch adjustment
.db $02     ; global volume adjustment

; CHANNEL 2 HEADER
.dw Channel2_Data
.db $FF
.db $04

; CHANNEL 3 HEADER (noise)
.dw Channel3_Data
.db 0
.db 0


Channel0_Data:
    Stop

Channel2_Data:
Channel3_Data:
    Stop


Channel1_Data:
    Stop
;----------------------------
Channel1_Pattern0:
    D6
        .db 6
    E6
        .db 26
    C6
        .db 16
    D6
;----------------------------
Channel1_Pattern1:
    Rest
        .db 4
    G5
        .db 2
    Rest
    A5
    Rest
    G5
    Rest
    C6
    Rest
    C6
    Rest
    D6
    E6
    Rest
        .db 8
    D6
    A5
        .db 2
    Rest
    C6
        .db 1
    Rest
    C6
        .db 2
    Rest
    D6
        .db 4
    Rest
        .db 6
;----------------------------
Channel1_Pattern2:
    Rest
        .db 10
    B5
        .db 2
    C6
    B5
    D6
    Rest
    C6
    Rest
    B5
    C6
    Rest
    A5
        .db 26
    Rest
        .db 8
;----------------------------
    Loop            0, 2, Channel1_Pattern1
;----------------------------
Channel1_Pattern3:
    Rest
        .db 4
    G6
        .db 2
    Rest
    G6
        .db 4
    A6
        .db 2
    Rest
    C7
    Rest
    C7
        .db 4
    D7
    C7
    E7
    D7
    Rest
    A6
        .db 20
;----------------------------
Channel1_Pattern4:
    Rest
        .db 4
    B6
        .db 2
    Rest
    B6
        .db 4
    C7
    D7
    C7
    B6
        .db 2
    C7
        .db 3
    Rest
    A6
        .db 32
;----------------------------
    Loop            0, 2, Channel1_Pattern3
    Branch          Channel1_Pattern5
    Branch          Channel1_Pattern6
    Branch          Channel1_Pattern5
    Jump            Channel1_Pattern7
;----------------------------
Channel1_Pattern5:
    C7
        .db 12
    A6
        .db 4
    Rest
        .db 10
    A6
        .db 2
    C7
        .db 4
    B6
    C7
        .db 2
    B6
        .db 10
    B5
        .db 4
    C6
        .db 2
    B5
        .db 10
    Return
;----------------------------
Channel1_Pattern6:
    B5
        .db 8
    B6
        .db 4
    C7
    D7
    C7
    B6
    D7
    C7
        .db 2
    Rest
    C7
        .db 8
    A6
        .db 20
    Return
;----------------------------
Channel1_Pattern7:
    E7
        .db 2
    D7
        .db 4
    A6
        .db 26
    Rest
        .db 32
    Jump            Channel1_Pattern1
;----------------------------
    Stop

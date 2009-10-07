sfx_ring_bin:
.dw $8A2F
.db $01        ;num channels
.db $01
.db $80
.db $A0

sfx_ring_bin_Channel0_Header:
.dw sfx_ring_bin_Channel0
.db $00        ; pitch adjustment
.db $00        ; volume adjustment

sfx_ring_bin_Channel0:
.db $F5         ; set volume envelope
    .db $07
.db $F0         ; pitch bend
    .db $01         ; on first tick
    .db $01         ; with each tick
    .db $FF         ; step -1
    .db $04         ; 4 steps deep
sfx_ring_bin_LABEL_BAFB:
.db $AA    ; F6
    .db $03
.db $AF    ; As6
.db $B3    ; D7
.db $E6         ; adjust volume attenuation
    .db $02
.db $F7         ; loop 7 times
    .db $00
    .db $07
    .dw sfx_ring_bin_LABEL_BAFB
.db $F2


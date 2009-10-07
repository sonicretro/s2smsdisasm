; Note values modified according to Maxim's PSG tuning research.
; See: http://www.smspower.org/forums/viewtopic.php?p=52176
.dw $3F9        ;A2
.dw $3C0        ;As2
.dw $38A        ;B2
.dw $357        ;C3
.dw $327        ;Cs3
.dw $2FA        ;D3
.dw $2CF        ;Ds3
.dw $2A7        ;E3
.dw $281        ;F3
.dw $25D        ;Fs3
.dw $23B        ;G3
.dw $21B        ;Gs3
.dw $1FC        ;A3
.dw $1E0        ;As3
.dw $1C5        ;B3
.dw $1AC        ;C4
.dw $194        ;Cs4
.dw $17D        ;D4
.dw $168        ;Ds4
.dw $153        ;E4
.dw $140        ;F4
.dw $12E        ;Fs4
.dw $11D        ;G4
.dw $10D        ;Gs4
.dw $0FE        ;A4
.dw $0F0        ;As4
.dw $0E2        ;B4
.dw $0D6        ;C5
.dw $0CA        ;Cs5
.dw $0BE        ;D5
.dw $0B4        ;Ds5
.dw $0AA        ;E5
.dw $0A0        ;F5
.dw $097        ;Fs5
.dw $08F        ;G5
.dw $087        ;Gs5
.dw $07F        ;A5
.dw $078        ;As5
.dw $071        ;B5
.dw $06B        ;C6
.dw $065        ;Cs6
.dw $05F        ;D6
.dw $05A        ;Ds6
.dw $055        ;E6
.dw $050        ;F6
.dw $04C        ;Fs6
.dw $047        ;G6
.dw $043        ;Gs6
.dw $040        ;A6
.dw $03C        ;As6
.dw $039        ;B6
.dw $035        ;C7
.dw $032        ;Cs7
.dw $030        ;D7
.dw $02D        ;Ds7
.dw $02A        ;E7
.dw $028        ;F7
.dw $026        ;Fs7
.dw $024        ;G7
.dw $022        ;Gs7
.dw $020        ;A7
.dw $01E        ;As7
.dw $01C        ;B7
.dw $01B        ;C8
.dw $019        ;Cs8
.dw $018        ;D8
.dw $016        ;Ds8
.dw $015        ;E8
.dw $014        ;F8
.dw $013        ;Fs8
.dw $012        ;G8
.dw $011        ;Gs8
.dw $010        ;A8
.dw $00F        ;As8
.dw $00E        ;B8
.dw $00D        ;C9
.dw $00D        ;Cs9
.dw $00C        ;D9
.dw $00B        ;Ds9
.dw $00B        ;E9
.dw $00A        ;F9
.dw $009        ;Fs9
.dw $009        ;G9
.dw $008        ;Gs9
.dw $008        ;A9
.dw $007        ;As9
.dw $007        ;B9
.dw $007        ;C10
.dw $006        ;Cs10
.dw $006        ;D10
.db $0


; =============================================================================
;  MIDI NOTE MACROS
; -----------------------------------------------------------------------------
.macro A2
.db $81
.endm

.macro As2
.db $82
.endm

.macro B2
.db $83
.endm

.macro C3
.db $84
.endm

.macro Cs3
.db $85
.endm

.macro D3
.db $86
.endm

.macro Ds3
.db $87
.endm

.macro E3
.db $88
.endm

.macro F3
.db $89
.endm

.macro Fs3
.db $8A
.endm

.macro G3
.db $8B
.endm

.macro Gs3
.db $8C
.endm

.macro A3
.db $8D
.endm

.macro As3
.db $8E
.endm

.macro B3
.db $8F
.endm

.macro C4
.db $90
.endm

.macro Cs4
.db $91
.endm

.macro D4
.db $92
.endm

.macro Ds4
.db $93
.endm

.macro E4
.db $94
.endm

.macro F4
.db $95
.endm

.macro Fs4
.db $96
.endm

.macro G4
.db $97
.endm

.macro Gs4
.db $98
.endm

.macro A4
.db $99
.endm

.macro As4
.db $9A
.endm

.macro B4
.db $9B
.endm

.macro C5
.db $9C
.endm

.macro Cs5
.db $9D
.endm

.macro D5
.db $9E
.endm

.macro Ds5
.db $9F
.endm

.macro E5
.db $A0
.endm

.macro F5
.db $A1
.endm

.macro Fs5
.db $A2
.endm

.macro G5
.db $A3
.endm

.macro Gs5
.db $A4
.endm

.macro A5
.db $A5
.endm

.macro As5
.db $A6
.endm

.macro B5
.db $A7
.endm

.macro C6
.db $A8
.endm

.macro Cs6
.db $A9
.endm

.macro D6
.db $AA
.endm

.macro Ds6
.db $AB
.endm

.macro E6
.db $AC
.endm

.macro F6
.db $AD
.endm

.macro Fs6
.db $AE
.endm

.macro G6
.db $AF
.endm

.macro Gs6
.db $B0
.endm

.macro A6
.db $B1
.endm

.macro As6
.db $B2
.endm

.macro B6
.db $B3
.endm

.macro C7
.db $B4
.endm

.macro Cs7
.db $B5
.endm

.macro D7
.db $B6
.endm

.macro Ds7
.db $B7
.endm

.macro E7
.db $B8
.endm

.macro F7
.db $B9
.endm

.macro Fs7
.db $BA
.endm

.macro G7
.db $BB
.endm

.macro Gs7
.db $BC
.endm

.macro A7
.db $BD
.endm

.macro As7
.db $BE
.endm

.macro B7
.db $BF
.endm

.macro C8
.db $C0
.endm

.macro Cs8
.db $C1
.endm

.macro D8
.db $C2
.endm

.macro Ds8
.db $C3
.endm

.macro E8
.db $C4
.endm

.macro F8
.db $C5
.endm

.macro Fs8
.db $C6
.endm

.macro G8
.db $C7
.endm

.macro Gs8
.db $C8
.endm

.macro A8
.db $C9
.endm

.macro As8
.db $CA
.endm

.macro B8
.db $CB
.endm

.macro C9
.db $CC
.endm

.macro Cs9
.db $CD
.endm

.macro D9
.db $CE
.endm

.macro Ds9
.db $CF
.endm

.macro E9
.db $D0
.endm

.macro F9
.db $D1
.endm

.macro Fs9
.db $D2
.endm

.macro G9
.db $D3
.endm

.macro Gs9
.db $D4
.endm

.macro A9
.db $D5
.endm

.macro As9
.db $D6
.endm

.macro B9
.db $D7
.endm

.macro C10
.db $D8
.endm

.macro Cs10
.db $D9
.endm

.macro D10
.db $DA
.endm


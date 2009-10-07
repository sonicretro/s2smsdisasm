;****************************************************************
;*  The following table serves as a lookup table that is used   *
;*  by tile loading routines to mirror tiles horizontally on    *
;*  the-fly. Each byte represents the mirrored data for each    *
;*  possible byte of tile data. For example, if the byte of     *
;*  tile data was $D6 (1101 0110 in binary), its mirrored value *
;*  would be $6B (0110 1011 in binary).                         *
;*  This array needs to be aligned to a 256 byte boundary in    *
;*  order for the addressing mechanism to work properly.        *
;****************************************************************
.ORGA $100
Engine_Data_ByteFlipLUT:       ;$0100
.db $00, $80, $40, $C0, $20, $A0, $60, $E0
.db $10, $90, $50, $D0, $30, $B0, $70, $F0
.db $08, $88, $48, $C8, $28, $A8, $68, $E8
.db $18, $98, $58, $D8, $38, $B8, $78, $F8
.db $04, $84, $44, $C4, $24, $A4, $64, $E4
.db $14, $94, $54, $D4, $34, $B4, $74, $F4
.db $0C, $8C, $4C, $CC, $2C, $AC, $6C, $EC
.db $1C, $9C, $5C, $DC, $3C, $BC, $7C, $FC
.db $02, $82, $42, $C2, $22, $A2, $62, $E2
.db $12, $92, $52, $D2, $32, $B2, $72, $F2
.db $0A, $8A, $4A, $CA, $2A, $AA, $6A, $EA
.db $1A, $9A, $5A, $DA, $3A, $BA, $7A, $FA
.db $06, $86, $46, $C6, $26, $A6, $66, $E6
.db $16, $96, $56, $D6, $36, $B6, $76, $F6
.db $0E, $8E, $4E, $CE, $2E, $AE, $6E, $EE
.db $1E, $9E, $5E, $DE, $3E, $BE, $7E, $FE
.db $01, $81, $41, $C1, $21, $A1, $61, $E1
.db $11, $91, $51, $D1, $31, $B1, $71, $F1
.db $09, $89, $49, $C9, $29, $A9, $69, $E9
.db $19, $99, $59, $D9, $39, $B9, $79, $F9
.db $05, $85, $45, $C5, $25, $A5, $65, $E5
.db $15, $95, $55, $D5, $35, $B5, $75, $F5
.db $0D, $8D, $4D, $CD, $2D, $AD, $6D, $ED
.db $1D, $9D, $5D, $DD, $3D, $BD, $7D, $FD
.db $03, $83, $43, $C3, $23, $A3, $63, $E3
.db $13, $93, $53, $D3, $33, $B3, $73, $F3
.db $0B, $8B, $4B, $CB, $2B, $AB, $6B, $EB
.db $1B, $9B, $5B, $DB, $3B, $BB, $7B, $FB
.db $07, $87, $47, $C7, $27, $A7, $67, $E7
.db $17, $97, $57, $D7, $37, $B7, $77, $F7
.db $0F, $8F, $4F, $CF, $2F, $AF, $6F, $EF
.db $1F, $9F, $5F, $DF, $3F, $BF, $7F, $FF

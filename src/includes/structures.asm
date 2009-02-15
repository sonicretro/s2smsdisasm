/*
	These structures are used by the level loading routines to
	load the locate the compressed art for each zone.
*/


.STRUCT TilesetHeader
	BankNum			db		;ROM bank to load tiles from
	VRAMAddress		dw		;Address to copy tiles to
	SourceAddress	dw
	Entries			dw		;pointer to the chain of tileset entries
.ENDST

.STRUCT TilesetEntry
	BankNum			db		;ROM Bank to load from. Bit 7 is the indexed tiles flag that is passed to the LoadTiles routine.
	VRAMAddress		dw		;Address to copy tiles to
	SourceAddress	dw
.ENDST

/*
	Used by the sprite loading routine at $10BF to load the player
	sprites into VRAM at $0000.
*/
.STRUCT SpriteDef
	BankNum			db
	SourceAddress	dw
	LineCount		db		;LineCount = TileCount/2 (two tiles are copied for each line).
.ENDST

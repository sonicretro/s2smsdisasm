Mappings32_ALZ2:
;.incbin "mappings\alz\mappings32_alz2.bin"
.include "mappings\alz\mappings32_alz2.asm"

Mappings32_UGZ:
;.incbin "mappings\ugz\mappings32_ugz.bin"
.include "mappings\ugz\mappings32_ugz.asm"


;tile data for the "GAME OVER" text
GameOverScreen_Data_GameOverTiles:		;3380
.incbin "art\continue_gameover\gameover_screen_tiles.bin"

;tile data for the "CONTINUE" text
ContinueScreen_Data_ContinueTiles:		;3570
.incbin "art\continue_gameover\continue_tiles.bin"

;just padding?
.db $00, $00

ContinueScreen_Data_NumberTiles:		;375A
.incbin "art\continue_gameover\continue_screen_tiles_2.bin"

GameOverScreen_Data_TextMappings:		;3B7E
.incbin "mappings\continue_gameover\gameover_screen_text_mappings.bin"

ContinueScreen_Data_TextMappings:		;3BC6
.incbin "mappings\continue_gameover\continue_screen_text_mappings.bin"

ContinueScreen_Data_NumberMappings:		;3C0D
.incbin "mappings\continue_gameover\continue_screen_number_mappings.bin"
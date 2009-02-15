;routines to load a level's object layout
.include "src\object_layout_routines.asm"

.include "src\object_logic\bank30_logic.asm"

DATA_B30_9841:
.include "src\collision_data.asm"


.include "src\cycling_palette_data.asm"


DemoControlSequence_SEZ:
.incbin "demo\demo_control_sequence_sez.bin"

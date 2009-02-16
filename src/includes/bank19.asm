Layout_GMZ1:
.IFEQ Version 2.2
.incbin "layout\gmz\layout_gmz1_2.2.bin"
.ELSE
.incbin "layout\gmz\layout_gmz1.bin"
.ENDIF

Layout_GMZ2:
.incbin "layout\gmz\layout_gmz2.bin"

Layout_SEZ1:
.incbin "layout\sez\layout_sez1.bin"

Layout_SEZ2:
.incbin "layout\sez\layout_sez2.bin"

Art_Intro_Tails:
.incbin "art\intro_title\art_intro_tails.bin"

Art_Intro_Tails_Eggman:
.incbin "art\intro_title\art_intro_tails_eggman.bin"

RingArtPointers:
;pointers for each level
.dw RingArtPointers_UGZ
.dw RingArtPointers_SHZ
.dw RingArtPointers_ALZ
.dw RingArtPointers_GHZ
.dw RingArtPointers_GMZ
.dw RingArtPointers_SEZ
.dw RingArtPointers_CEZ	;same?
.dw DATA_231A
.dw RingArtPointers_CEZ	;same?
.dw DATA_2320

;pointers for each act
RingArtPointers_UGZ:
.dw RingArtPointers_UGZ1
.dw RingArtPointers_UGZ2
.dw RingArtPointers_UGZ3

RingArtPointers_SHZ:
.dw RingArtPointers_SHZ1
.dw RingArtPointers_SHZ2
.dw RingArtPointers_SHZ3

RingArtPointers_ALZ:
.dw RingArtPointers_ALZ1
.dw RingArtPointers_ALZ2
.dw RingArtPointers_ALZ3

RingArtPointers_GHZ:
.dw RingArtPointers_GHZ1
.dw RingArtPointers_GHZ2
.dw RingArtPointers_GHZ3

RingArtPointers_GMZ:
.dw RingArtPointers_GMZ1
.dw RingArtPointers_GMZ2
.dw RingArtPointers_GMZ3

RingArtPointers_SEZ
.dw RingArtPointers_SEZ1
.dw RingArtPointers_SEZ2
.dw RingArtPointers_SEZ3

RingArtPointers_CEZ:
.dw RingArtPointers_CEZ1
.dw RingArtPointers_CEZ2
.dw RingArtPointers_CEZ3

DATA_231A:
.dw DATA_23F8
.dw DATA_23F8
.dw DATA_23F8

DATA_2320:
.dw DATA_2402
.dw DATA_240C
.dw DATA_240C

;ring art headers for each level/act
;	2 bytes	-	pointer to collision data
;	2 bytes -	source address
;   2 bytes -	vram dest address
;	1 byte	-	first cycling palette index
;	1 byte	-	second cycling palette index
;	1 byte	-	third cycling palette index?
;	1 byte	-	fourth cycling palette index?
RingArtPointers_GHZ1:
.dw DATA_B30_9841, Art_Rings_GHZ, $2880, $0000, $0000
RingArtPointers_GHZ2:
.dw DATA_B30_9841, Art_Rings_GHZ, $2880, $0000, $0000
RingArtPointers_GHZ3:
.dw DATA_B30_9841, Art_Rings_GHZ, $2880, $0000, $0000

RingArtPointers_SHZ1:
.dw DATA_B30_9841, Art_Rings_SHZ1_3, $2A80, $0000, $0000
RingArtPointers_SHZ2:
.dw DATA_B30_9841, Art_Rings_SHZ2, $27C0, $0302, $0000
RingArtPointers_SHZ3:
.dw DATA_B30_9841, Art_Rings_SHZ1_3, $2A80, $0000, $0000

RingArtPointers_ALZ1:
.dw DATA_B30_9841, Art_Rings_ALZ, $2940, $0005, $0000
RingArtPointers_ALZ2:
.dw DATA_B30_9A41, Art_Rings_ALZ, $2940, $0005, $0000
RingArtPointers_ALZ3:
.dw DATA_B30_9841, Art_Rings_ALZ, $2940, $0005, $0000

RingArtPointers_UGZ1:
.dw DATA_B30_9841, Art_Rings_UGZ, $2DE0, $0004, $0000
RingArtPointers_UGZ2:
.dw DATA_B30_9841, Art_Rings_UGZ, $2DE0, $0004, $0000
RingArtPointers_UGZ3:
.dw DATA_B30_9841, Art_Rings_UGZ, $2DE0, $0004, $0000

RingArtPointers_GMZ1:
.dw DATA_B30_9841, Art_Rings_GMZ, $2860, $0706, $0000
RingArtPointers_GMZ2:
.dw DATA_B30_9841, Art_Rings_GMZ, $2860, $0706, $0000
RingArtPointers_GMZ3:
.dw DATA_B30_9841, Art_Rings_GMZ, $2860, $0706, $0000

RingArtPointers_SEZ1:
.dw DATA_B30_9841, Art_Rings_SEZ, $30A0, $0008, $0000
RingArtPointers_SEZ2:
.dw DATA_B30_9841, Art_Rings_SEZ, $3120, $0008, $0000
RingArtPointers_SEZ3:
.dw DATA_B30_9841, Art_Rings_SEZ, $30A0, $0008, $0000

RingArtPointers_CEZ1:
.dw DATA_B30_9841, Art_Rings_CEZ, $29A0, $000C, $0000
RingArtPointers_CEZ2:
.dw DATA_B30_9841, Art_Rings_CEZ, $29A0, $000C, $0000
RingArtPointers_CEZ3:
.dw DATA_B30_9841, Art_Rings_CEZ, $0000, $0B00, $0000

DATA_23F8:
.dw DATA_B30_9841, Art_Rings_CEZ, $0000, $0000, $0000
DATA_2402:
.dw DATA_B30_9841, Art_Rings_GHZ, $0000, $0000, $0000
DATA_240C:
.dw DATA_B30_9841, Art_Rings_GHZ, $0000, $0000, $0000


;enemiePointerGFX
org $868b45
dw enemyGFX1,enemyGFX2,enemyGFX4,enemyGFX4,enemyGFX4,enemyGFX31,enemyGFX31,enemyGFX8 		;stage 1
dw enemyGFX9,enemyGFX10,enemyGFX11,enemyGFX11												;stage 2
dw enemyGFX13,enemyGFX14,enemyGFX15,enemyGFX16,enemyGFX17,enemyGFX18						;stage 3
dw enemyGFX19,enemyGFX20,enemyGFX20,enemyGFX2,enemyGFX23,enemyGFX24							;stage 4
dw enemyGFX25,enemyGFX26																	;stage 5
dw enemyGFX27,enemyGFX31,enemyGFX29,enemyGFX30,enemyGFX31,enemyGFX32,enemyGFX34,enemyGFX63,enemyGFX5	;stage 6
dw enemyGFX36,enemyGFX36,enemyGFX38,enemyGFX41,enemyGFX41,enemyGFX39,enemyGFX42				;stage 7
dw enemyGFX43,enemyGFX45,enemyGFX44,enemyGFX43												;stage 8
dw enemyGFX49,enemyGFX49,enemyGFX49,enemyGFX50,enemyGFX50,enemyGFX50,enemyGFX53,enemyGFX55	;stage 9
dw enemyGFX55,enemyGFX58,enemyGFX57,enemyGFX58,enemyGFX59,enemyGFX32						;stage a
dw enemyGFX62,enemyGFX62,enemyGFX63,enemyGFX64,enemyGFX65,enemyGFX66,enemyGFX31,enemyGFX68 	;stage b

;enemiePointerAssembly
org $868bcd
dw enemyAssembly1,enemyAssembly2,enemyAssembly4,enemyAssembly4,enemyAssembly4,enemyAssembly31,enemyAssembly31,enemyAssembly8		;stage 1
dw enemyAssembly9,enemyAssembly10,enemyAssembly11,enemyAssembly11																	;stage 2
dw enemyAssembly13,enemyAssembly14,enemyAssembly15,enemyAssembly16,enemyAssembly17,enemyAssembly18									;stage 3
dw enemyAssembly19,enemyAssembly20,enemyAssembly20,enemyAssembly2,enemyAssembly23,enemyAssembly24									;stage 4
dw enemyAssembly25,enemyAssembly26																									;stage 5
dw enemyAssembly27,enemyAssembly31,enemyAssembly29,enemyAssembly30,enemyAssembly31,enemyAssembly32,enemyAssembly34,enemyAssembly63,enemyAssembly5 ;stage 6
dw enemyAssembly36,enemyAssembly36,enemyAssembly38,enemyAssembly41,enemyAssembly41,enemyAssembly39,enemyAssembly42					;stage 7
dw enemyAssembly43,enemyAssembly45,enemyAssembly44,enemyAssembly43																	;stage 8
dw enemyAssembly49,enemyAssembly49,enemyAssembly49,enemyAssembly50,enemyAssembly50,enemyAssembly50,enemyAssembly53,enemyAssembly55	;stage 9												
dw enemyAssembly55,enemyAssembly58,enemyAssembly57,enemyAssembly58,enemyAssembly59,enemyAssembly32 									;stage a
dw enemyAssembly62,enemyAssembly62,enemyAssembly63,enemyAssembly64,enemyAssembly65,enemyAssembly66,enemyAssembly31,enemyAssembly68 	;stage b

;formatGFX
;00 AA BB CC DE
;AA=PPU Offset $10=1 Tile Forward
;BB=PPU Tile Line Number ($10 byte eatch)
;CC=LowGFX pointer will start 3byte before graphic. Probably does read size first. 
;DD=MiddleByte GFX Pointer
;EE=BankNumber GFX Pointer

;ExampleBlocks and Rings:	006c9d97aa
;Format						AABBCCDDEE

;stage 1
org $868C56	; lvl 0
	enemyGFX1:
	db $00,$00
	db $00,$20,$1D,$86,$A8 ;bg?
	db $00,$30,$D0,$FF,$A0
	db $00,$6A,$7D,$C6,$A8 ;ring, block and bubbles
	db $00,$6C,$9D,$CA,$A8 ;moon
	db $00,$70,$3D,$D2,$A8 ;bridgeChain
	db $00,$72,$5d,$ee,$c6 ;stairs
	db $00,$74,$7d,$e0,$c9,$ff,$ff	;oldMan,$FF,$FF ;stairs
	enemyAssembly1:
	db $05,$37,$14,$04,$06,$0d

;org $68C77	; lvl 1
	enemyGFX2:
	db $00,$00
	db $00,$6a,$9d,$97,$aa	;bat
	db $00,$6c,$7d,$c6,$a8	;ring, block and bubbles
	db $00,$6e,$9d,$de,$bb ;swordSkelly
	db $00,$74,$3d,$c0,$af ;medusa
	db $00,$76,$fd,$9b,$aa	;skelly
	db $00,$7e,$7d,$ab,$aa,$ff,$ff ;dirt
	enemyAssembly2:
	db $05,$0c,$03,$31,$07,$12	


	enemyGFX3:

	enemyAssembly3:

	
;org $68CAA	; lvl 3
	enemyGFX4:
	db $00,$00
	db $00,$6a,$9d,$ca,$a8 	;moon
	db $00,$6c,$9d,$97,$aa	;bat
	db $00,$6e,$fd,$9b,$aa	;skelly
	db $00,$74,$7d,$c6,$a8	;ring, block and bubbles
	db $00,$76,$1d,$ee,$ab  ;bonePillar
;	db $00,$7a,$fd,$f7,$ac,$ff,$ff	;clubGuy 73
	db $00,$7a,$3d,$c0,$af ;medusa
	db $00,$7c,$1d,$ea,$b0 ;spider
	db $00,$7e,$7d,$ab,$aa,$ff,$ff ;dirt
	enemyAssembly4:
	db $07,$2e,$0c,$12,$03,$0b,$07,$43
	
	enemyGFX5:
	db $00,$00
;	db $00,$6a,$9d,$ca,$a8 	;moon
	db $00,$6a				 ;platform
	dl NewPlatform1			;platform
	db $00,$6c,$9d,$97,$aa	;bat
	db $00,$6e,$fd,$9b,$aa	;skelly
	db $00,$74,$7d,$c6,$a8	;ring, block and bubbles
	db $00,$76,$1d,$ee,$ab  ;bonePillar
;	db $00,$7a,$fd,$f7,$ac,$ff,$ff	;clubGuy 73
	db $00,$7a,$3d,$c0,$af ;medusa
	db $00,$7c,$1d,$ea,$b0 ;spider
;	db $00,$7e,$7d,$ab,$aa,$ff,$ff ;dirt
	dw $ffff 
	enemyAssembly5:
	db $06,$17,$0c,$12,$03,$0b,$07

;org $68CF0	; lvl 5
;	enemyGFX6:
;	db $00,$00 
;	db $00,$6a,$9d,$ca,$a8 ;moon
;	db $00,$6c,$dd,$a1,$ae ;snakeBush
;	db $00,$6e,$7d,$a5,$ae ;ghost
;	db $00,$70,$dd,$a9,$ae ;horseHead
;	db $00,$72,$3d,$ae,$ae,$ff,$ff ;dog
;	enemyAssembly6:
;	db $05,$2e,$32,$08,$6f,$0a
	
;org $68D13	; lvl 6
;	enemyGFX7:
;	db $00,$00 
;	db $00,$6a,$9d,$ca,$a8 ;moon
;	db $00,$6c,$dd,$a1,$ae ;snakeBush
;	db $00,$6e,$7d,$a5,$ae ;ghost
;	db $00,$70,$1d,$bc,$af ;trapDoor
;	db $00,$72,$3d,$c0,$af ;medusa
;	db $00,$74,$fd,$f7,$ac,$ff,$ff ;clubGuy
;	enemyAssembly7:
;	db $06,$2e,$32,$08,$3b,$07,$73
	
;org $68D3C ; lvl 7
	enemyGFX8:
	db $00,$00 
	db $00,$6a,$9d,$ca,$a8 ;moon
	db $00,$6c,$dd,$a1,$ae ;snakeBush 32
;	db $00,$6e,$7d,$a5,$ae ;ghost
	db $00,$6e,$3d,$e2,$b0 ;zombieEarth
	db $00,$72,$1d,$b3,$b2 ;frog $30,
	db $00,$74,$dd,$a1,$ae ;snakeBush
	db $00,$76,$7d,$e0,$c9,$ff,$ff	;oldMan,$FF,$FF ;stairs $7d,$e0,$c9
;	db $00,$70,$1d,$bc,$af,$ff,$ff ;trapDoor ,$3b
	enemyAssembly8:
	db $06,$2e,$32,$70,$30,$32,$0d

;stage 2 Greavyard
;org $68D59 ; lvl 8
	enemyGFX9:
	db $00,$00 
	db $00,$6a,$bd,$c5,$b0 ;grabingGraveHand
;	db $00,$6e,$1d,$ce,$b0 ;bushMonster 3c
;	db $00,$6e,$7d,$d6,$b0 ;spinnyRoller 09
	db $00,$6e,$7d,$c6,$a8	;ring, block and bubbles
	db $00,$70,$dd,$da,$b0 ;bird
	db $00,$74,$3d,$e2,$b0 ;zombieEarth
	db $00,$78,$1d,$ea,$b0 ;spider
	db $00,$7a,$fd,$9b,$aa,$ff,$ff	;skelly
	enemyAssembly9:
	db $06,$66,$03,$10,$70,$43,$12 
	
;org $68D82 ; lvl 9 Swamp
	enemyGFX10:
	db $00,$00
	db $00,$6a,$5d,$b0,$b2 ;platform
	db $00,$6c,$bd,$c2,$b9 ;fishMan
;	db $00,$6c,$dd,$da,$b0 ;bird $10,
;	db $00,$70,$1d,$b3,$b2 ;frog $30,
	db $00,$72,$7d,$9b,$b6 ;drip
	db $00,$74,$7d,$d6,$b0 ;spinnyRoller
	db $00,$76,$9d,$97,$aa ;bat
	db $00,$78,$fd,$9b,$aa ;skelly
;	db $00,$7c,$bd,$b6,$b2 ;plant $35,
	db $00,$7e,$7d,$c6,$a8,$ff,$ff	;ring, block and bubbles
	enemyAssembly10:
	db $07,$17,$4c,$3f,$09,$0c,$12,$03
	
;org $68DB1 ; lvl a
	enemyGFX11:
	db $00,$00 
	db $00,$6a,$7d,$81,$b4 ;gargoyl
;	db $00,$70,$1d,$b3,$b2 ;frog ,$30
	db $00,$70,$fd,$9b,$aa ;skelly
	db $00,$76,$bd,$8d,$b4 ;hand 
	db $00,$78,$7d,$c6,$a8 ;ring, block and bubbles
	db $00,$7a,$5d,$b0,$b2 ;platform
	db $00,$7c,$7d,$e0,$c9 ;NPC 
;	dl gfxNPC2
	dw $ffff 
	enemyAssembly11:
	db $06,$3e,$12,$6e,$03,$17,$0d
	
;org $68DD4 ; lvl b
;	enemyGFX12:
;	db $00,$00
;	db $00,$6a,$7d,$81,$b4 ;gargoyl
;	db $00,$70,$9d,$97,$aa ;bat
;	db $00,$72,$1d,$b3,$b2 ;frog
;	db $00,$74,$1d,$ee,$ab ;bonePillar
;	db $00,$78,$bd,$8d,$b4 ;hand
;	db $00,$7a,$7d,$c6,$a8,$ff,$ff ;ring, block and bubbles
;	enemyAssembly12:
;	db $06,$3e,$0c,$30,$0b,$6e,$03

;stage 3	
;org $68DFD ; lvl c Cave
	enemyGFX13:
	db $00,$00
;	db $00,$6a,$1d,$de,$c0 ; crusher 16
	db $00,$6a,$7d,$c6,$a8 ;ring, block and bubbles

	db $00,$6c,$7d,$9b,$b6 ;drip
	db $00,$6e,$9d,$97,$aa ;bat
;	db $00,$76,$fd,$ab,$b6 ;newbat
	db $00,$70,$1d,$ee,$ab ;bonePillar
;	db $00,$7c,$7d,$a5,$ae,$ff,$ff ;ghost 08
	db $00,$74,$1d,$97,$b6 ;stalaktit
	db $00,$76,$1d,$ea,$b0 ;spider
	db $00,$78,$5d,$b0,$b2 ;platform
;	db $00,$7a,$9d,$9f,$b6,$ff,$ff ;mudMan ,$34
	db $00,$7a
	dl gfxNPCWizard
	dw $ffff						; $7d,$e0,$c9,$ff,$ff	;oldMan,$FF,$FF ;stairs
	enemyAssembly13:
	db $08,$03,$3f,$0c,$0b,$44,$43,$17,$0d
	
;org $68E2C ; lvl d Waterfall
	enemyGFX14: 
	db $00,$00
	db $00,$6a,$7d,$c6,$a8 ;ring, block and bubbles

;	db $00,$6c,$dd,$f7,$b7 ;fallingBridge 3a
;	db $00,$72,$9d,$97,$aa ;bat
;	db $00,$72,$5d,$b0,$b2 ;platform 17
;	db $00,$74,$1d,$ee,$ab ;bonePillar $0b
	db $00,$6c,$1d,$bc,$af ;trapDoor
	db $00,$6e,$bd,$fa,$b7 ;fuzzyBall $6d
;	db $00,$76,$bd,$b6,$b2;plant $35
	db $00,$70,$DD,$BD,$E5  ;stoneGolem
	db $00,$76				; $BD,$8B,$E3 ;headlessKinght
	dl gfxHeadlessKnight2	
	dw $ffff
	enemyAssembly14:
	db $05,$03,$67,$6d,$7f,$7e
	
	
;org $68E5B ; lvl e 
	enemyGFX15:
	db $00,$00
	db $00,$6a,$7d,$c6,$a8 ;ring, block and bubbles
	db $00,$6c,$9d,$bf,$b9 ;fallingPiller
	db $00,$6e,$bd,$c2,$b9 ;fishMan
	db $00,$74,$bd,$fa,$b7 ;fuzzyBall
	db $00,$76,$1d,$cf,$b9 ;boneDragon
	db $00,$7a,$3d,$d7,$b9,$ff,$ff ;eye
	enemyAssembly15:
	db $06,$03,$39,$4c,$6d,$5d,$72
	
;org $68E84 ; lvl f
	enemyGFX16:
	db $00,$00
	db $00,$6a,$7d,$c6,$a8 ;ring, block and bubbles
	db $00,$6c,$1d,$cf,$b9 ;boneDragon
	db $00,$70,$bd,$c2,$b9 ;fishMan
	db $00,$76,$bd,$fa,$b7 ;fuzzyBall
	db $00,$78,$7d,$a5,$ae ;ghost
	db $00,$7a,$dd,$a9,$ae,$ff,$ff ;horseHead
;	db $00,$78,$3d,$d7,$b9 ;eye ,$72
;	db $00,$7a,$bd,$b6,$b2,$ff,$ff ;plant ,$35
	enemyAssembly16:
	db $06,$03,$5d,$4c,$6d,$08,$6f
	
;org $68EAD ; lvl 10
	enemyGFX17:
	db $00,$00
	db $00,$6a,$7d,$c6,$a8 ;ring, block and bubbles
	db $00,$6c,$1d,$ee,$ab ;bonePillar
	db $00,$70,$fd,$9b,$aa ;skelly
	db $00,$76,$fd,$f7,$ac ;clubGuy

	db $00,$7a,$9d,$97,$aa	 ;bat
	db $00,$7c,$1d,$ea,$b0,$ff,$ff ;spider
	enemyAssembly17:
	db $06,$03,$0b,$12,$73,$0c,$43
	
;org $68ECA ; lvl 11		Full Sprite Slot
	enemyGFX18:
	db $00,$00
	db $00,$6a,$7d,$c6,$a8 ;ring, block and bubbles
	db $00,$6c,$bd,$fa,$b7 ;fuzzyBall
	db $00,$6e,$dd,$da,$b0 ;bird
	db $00,$72,$1d,$cf,$b9 ;boneDragon
	db $00,$76,$1d,$ee,$ab ;bonePillar
	db $00,$7a,$9d,$de,$bb,$ff,$ff ;swordSkelly
	enemyAssembly18:
	db $06,$03,$6d,$10,$5d,$0b,$31
	
; stage 4 	
;org $68EF3 ; lvl 12
	enemyGFX19:
	db $00,$00
	db $00,$6a,$1d,$ec,$bc ;trapDoor2
	db $00,$6c,$5d,$b0,$b2 ;platform
	db $00,$6e,$7d,$c6,$a8 ;ring, block and bubbles
	db $00,$70,$3d,$c0,$af ;medusa
;	db $00,$6e,$fd,$f7,$ac ;clubGuy 73
	db $00,$72,$5d,$f0,$bc ;wallHugger
	db $00,$78,$9d,$de,$bb ;swordSkelly
	db $00,$7e,$9d,$97,$aa,$ff,$ff ;bat
	enemyAssembly19:
	db $07,$3b,$17,$03,$07,$2c,$31,$0c
	
;org $68F16 ; lvl 13
	enemyGFX20:
	db $00,$00
	db $00,$6a,$1d,$ec,$bc ;trapDoor2
	db $00,$6c,$5d,$b0,$b2 ;platform
	db $00,$6e,$7d,$c6,$a8 ;ring, block and bubbles
	db $00,$70,$fd,$9b,$aa ;skelly
	db $00,$78,$9d,$97,$aa ;bat
	db $00,$7a,$3d,$8e,$cf,$ff,$ff	;shildGargoyl
;	db $00,$70,$3d,$c0,$af ;medusa
;	db $00,$6e,$fd,$f7,$ac ;clubGuy 73
;	db $00,$72,$5d,$f0,$bc ;wallHugger
;	db $00,$78,$9d,$de,$bb ;swordSkelly
	enemyAssembly20:
	db $06,$3b,$17,$03,$56,$0c,$75	
;org $68F33	; lvl 14
;	enemyGFX21:
;	db $00,$00
;	db $00,$6a,$1d,$ec,$bc ;trapDoor2
;	db $00,$6c,$5d,$b0,$b2 ;platform
;	db $00,$6e,$9d,$de,$bb ;swordSkelly
;	db $00,$74,$9d,$97,$aa ;bat
;	db $00,$76,$7d,$e0,$c9,$ff,$ff	;oldMan,$FF,$FF ;stairs
;
;	enemyAssembly21:
;	db $05,$3b,$17,$31,$0c,$0d
	
;org $68F50 ; lvl 15 Rotating Room
	enemyGFX22:

	enemyAssembly22:
	
;org $68F61 ; lvl 16 CastleWashingMachine
	enemyGFX23:
	db $00,$00
	db $00,$6a,$dd,$d9,$bf ;fallingPlatform
	db $00,$6c,$fd,$9b,$aa ;skelly
	db $00,$74,$3d,$c0,$af ;medusa
	db $00,$76,$7d,$c6,$a8,$ff,$ff ;ring, block and bubbles
	enemyAssembly23:
	db $04,$06,$56,$07,$03
	
;org $68F78 ; lvl 17 Falling BG
	enemyGFX24:
	db $00,$00
	db $00,$6a,$1d,$de,$c0 ;crusher
	db $00,$6c,$7d,$c6,$a8 ;ring, block and bubbles
	db $00,$6e,$1d,$ee,$ab ;bonePillar
	db $00,$72,$BD,$8B,$E3 ;headlessKinght
	db $00,$78,$1d,$cf,$b9 ;boneDragon
;	db $00,$72,$fd,$9b,$aa ;skelly 12
;	db $00,$78,$fd,$f7,$ac ;clubGuy 73

	db $00,$7c,$9d,$97,$aa,$ff,$ff	 ;bat

	enemyAssembly24:
	db $06,$16,$03,$0b,$7e,$5e,$0c
;Stage 5	
;org $68F95 ; lvl 18 Garden	
	enemyGFX25:		;full PPU Slot
	db $00,$00
;	db $00,$6a,$fd,$a6,$c2 ;eagle 57
	db $00,$6a,$7d,$c6,$a8 ;ring 
	db $00,$6c,$7d,$c2,$c5 ;axeKnight
	db $00,$72,$7d,$81,$b4 ;gargoyl
	db $00,$78,$1d,$ee,$ab ;bonePillar
	db $00,$7c
	dl NewPlatform1			;platform
;	db $00,$7c,$bd,$b6,$b2 ;plant 35
	db $00,$7e,$3d,$d7,$b9,$ff,$ff ;eye
;	db $00,$7c,$bd,$8d,$b4 ;hand 6e
;	db $00,$7e,$1d,$b3,$b2,$ff,$ff ;frog 30
	enemyAssembly25:
	db $06,$03,$52,$3e,$0b,$17,$72
	
;org $68FB8	; lvl 19
	enemyGFX26:
	db $00,$00
	db $00,$6a,$7d,$c6,$a8 ;ring 
	db $00,$6c,$fd,$a6,$c2 ;eagle 57
	db $00,$74,$9d,$97,$aa ;bat	
	db $00,$76,$9d,$de,$bb ;swordSkelly
	db $00,$7e,$3d,$c0,$af,$ff,$ff ;medusa

	enemyAssembly26:
	db $05,$03,$57,$4e,$31,$07
	
;org $68FCF ; lvl 1a Castle Entrance
	enemyGFX27:
	db $00,$00
	db $00,$6a,$dd,$ba,$c5 ;zombieGhost
	db $00,$6e,$7d,$c2,$c5 ;axeKnight
	db $00,$74,$3d,$ae,$ae ;dog
	db $00,$7a,$9d,$97,$aa,$ff,$ff ;bat
;	db $00,$7c,$fd,$ab,$b6,$ff,$ff ;newbat 4b
	enemyAssembly27:
	db $04,$54,$52,$0a,$4e
	
;org $68FEC	; lvl 1b Chandelires
	enemyGFX28:

	enemyAssembly28:
	
;org $68FFD ; lvl 1c
	enemyGFX29:
	db $00,$00
	db $00,$6a,$3d,$f6,$c7  ;skikeTrap
	db $00,$6c,$1d,$fa,$c7	;slyingGhostWomen 
	db $00,$72,$bd,$85,$c8	;slyingGhostMan
	db $00,$74,$fd,$f0,$c6 ;ring, block and bubbles 2
;	db $00,$74,$1d,$8a,$c8	;fallingChandelire
	db $00,$76,$7d,$c2,$c5	;axeKnight
	db $00,$7c,$9d,$97,$aa	;bat
	db $00,$7e,$fd,$ab,$b6,$ff,$ff ;newbat 4b
	enemyAssembly29:
	db $07,$4a,$5a,$5b,$03,$52,$0c,$4b
	
;org $69026 ; lvl 1d
	enemyGFX30:
	db $00,$00
	db $00,$6a,$fd,$f0,$c6 ;ring, block and bubbles 2
	db $00,$6c,$fd,$9b,$aa ;skelly
;	db $00,$72,$bd,$8f,$c9 ;coffine 33
	db $00,$74,$3d,$8e,$cf	;shildGargoyl
;	db $00,$7c,$9d,$97,$aa ;bat
	db $00,$7e,$fd,$ab,$b6,$ff,$ff ;newbat 4b
;	db $00,$7e,$bd,$8d,$b4 ;hand 6e
	enemyAssembly30:
	db $04,$37,$56,$75,$4b
	
;org $69049 ; lvl 1e secret
	enemyGFX31:
	db $00,$00
	db $00,$6a,$9d,$ca,$a8 ;moon
	db $00,$6c,$7d,$e0,$c9	;oldMan
	db $00,$72,$1d,$8a,$c8	;fallingChandelire
	db $00,$74,$7D,$C6,$A8 ;ring, block and bubbles	
	db $00,$76,$dd,$ab,$cc ;tableChairs
	db $00,$7e
	dl sheepGFX
	db $ff,$ff ;platform $5d,$b0,$b2

;	db $00,$70,$3d,$ae,$ae,$ff,$ff ;dog a
	enemyAssembly31:
	db $06,$2e,$0d,$4d,$03,$42,$17
	
;org $6905A	; lvl 1f SkellyHallWay
	enemyGFX32:
	db $00,$00
	db $00,$6a,$9d,$cd,$ca	;redSkelly
	db $00,$70,$fd,$f0,$c6 ;ring, block and bubbles 2
	db $00,$72
	dl NewPlatform1			;platform
	db $00,$74,$3d,$c0,$af ;medusa
	db $00,$76,$fd,$9b,$aa,$ff,$ff ;skelly
	enemyAssembly32:
	db $05,$69,$03,$17,$07,$56
	
;org $6906B ; lvl 20
;	enemyGFX33:
;	db $00,$00
;	db $00,$6a,$5d,$da,$cb ;grabingHand
;	db $00,$6c,$9d,$de,$bb ;swordSkelly
;	db $00,$72,$9d,$cd,$ca,$ff,$ff ;redSkelly
;	enemyAssembly33:
;	db $03,$5c,$31,$69
	
;org $69082 ;lvl 21
	enemyGFX34:
	db $00,$00
	db $00,$6a,$5d,$9f,$cc ;dancingCopple
	db $00,$70,$7d,$c6,$a8 ;ring 
	db $00,$72,$7d,$c2,$c5 ;axeKnight
	db $00,$78,$1d,$ee,$ab ;bonePillar
	db $00,$7c,$dd,$a9,$ae ;horseHead
	db $00,$7e,$9d,$97,$aa,$ff,$ff ;bat
;	db $00,$70,$bd,$8f,$c9 ;coffine 7b
;	db $00,$78,$dd,$ab,$cc,$ff,$ff ;tableChairs 42
	enemyAssembly34:
	db $06,$76,$03,$52,$0b,$6f,$0c
	
;org $69099 ; lvl 22
	enemyGFX35:

	enemyAssembly35:

	
; Stage 7 Liberary	
;org $690A4 ; lvl 23 
	enemyGFX36:
	db $00,$00
;	db $00,$6a,$1d,$f9,$cd	;spearKnight 59
	db $00,$6a,$fd,$f0,$c6 ;ring, block and bubbles 2
	db $00,$6c,$3d,$c0,$af ;medusa
	db $00,$6e,$9d,$97,$aa ;bat
	
	db $00,$70,$7d,$c2,$c5	;axeKnight
	db $00,$76,$7d,$a5,$ae	;ghost
	db $00,$78,$dd,$8a,$cf	;bookBird
	db $00,$7a,$9d,$de,$bb,$ff,$ff ;swordSkelly
	enemyAssembly36:
	db $07,$03,$07,$0c,$52,$08,$0f,$31
	
;org $690C1 ; lvl 24
;	enemyGFX37:
;	db $00,$00
;	db $00,$6a,$dd,$8a,$cf	;bookBird
;	db $00,$6c,$3d,$8e,$cf	;shildGargoyl
;	db $00,$72,$9d,$de,$bb,$ff,$ff ;swordSkelly
;	enemyAssembly37:
;	db $03,$0f,$75,$31
	
;org $690D8 ; lvl 25
	enemyGFX38:
	db $00,$00
	db $00,$6a,$5d,$db,$cf	;bookPlatform
	db $00,$6c,$fd,$f0,$c6 	;ring, block and bubbles 2
	db $00,$6e,$1d,$ea,$b0 	;spider
	db $00,$70,$dd,$8a,$cf	;bookBird
	db $00,$72,$fd,$9b,$aa ;skelly
;	db $00,$6c,$7d,$c2,$c5	;axeKnight $52
;	db $00,$72,$1d,$f9,$cd	;spearKnight 59
	db $00,$7a,$9d,$cd,$ca,$ff,$ff ;redSkelly
	enemyAssembly38:
	db $06,$17,$03,$43,$0f,$56,$69


	enemyGFX39:
	db $00,$00
;	db $00,$6a,$9d,$ca,$a8 ;moon
	db $00,$6a
	dl gfxNPCWizard					;$7d,$e0,$c9	;oldMan
	db $00,$70,$1d,$8a,$c8	;fallingChandelire
	db $00,$72,$7D,$C6,$A8 ;ring, block and bubbles	
	db $00,$74,$dd,$ab,$cc ;tableChairs
;	db $00,$7c
;	dl sheepGFX
	db $ff,$ff ;platform $5d,$b0,$b2

	enemyAssembly39:
	db $04,$0d,$4d,$03,$42

	
;org $690F5	;	lvl 26 less books
;	enemyGFX39:
;	db $00,$00
;	db $00,$6a,$5d,$df,$d0 ;trapHand
;	db $00,$6c,$7d,$c2,$c5 ;axeKnight
;	db $00,$72,$7d,$e3,$d0 ;candleDog
;	db $00,$78,$9d,$97,$aa ;bat
;	db $00,$7a,$fd,$f7,$ac,$ff,$ff ;clubGuy
;	enemyAssembly39:
;	db $05,$68,$52,$6b,$4e,$73
;	
;;org $69118 ; lvl 27 
;	enemyGFX40:				;full PPU Slot
;	db $00,$00
;	db $00,$6a,$5d,$df,$d0 ;trapHand
;	db $00,$6c,$1d,$bc,$af ;trapDoor
;	db $00,$6e,$5d,$f1,$d1 ;catapiller
;	db $00,$70,$7d,$e3,$d0 ;candleDog
;	db $00,$76,$7d,$c2,$c5 ;axeKnight
;	db $00,$7c,$fd,$f7,$ac,$ff,$ff ;clubGuy
;	enemyAssembly40:
;	db $06,$68,$3b,$74,$6b,$52,$73
	
;org $69141 ; lvl 28
	enemyGFX41:
	db $00,$00
	db $00,$6a,$5d,$df,$d0 ;trapHand
	db $00,$6c,$1d,$bc,$af ;trapDoor
;	db $00,$6e,$9d,$97,$aa ;bat
	db $00,$6e,$fd,$f0,$c6 	;ring, block and bubbles 2
	db $00,$70,$fd,$9b,$aa ;skelly
	db $00,$78,$7d,$a5,$ae ;ghost
	db $00,$7a,$dd,$da,$b0,$ff,$ff ;bird
;	db $00,$7c,$7d,$e3,$d0,$ff,$ff ;candleDog 6b
;	db $00,$7c,$7d,$e0,$c9,$ff,$ff	;oldMan,$FF,$FF 
	enemyAssembly41:
	db $06,$68,$3b,$03,$56,$08,$10
	
;org $69152 ; lvl 29
	enemyGFX42:
	db $00,$00
	db $00,$6a,$7d,$c2,$c5 ;axeKnight
	db $00,$70,$5d,$db,$cf ;platform
;	dl NewPlatform1
	db $00,$72,$fd,$f0,$c6 	;ring, block and bubbles 2
	db $00,$74,$9d,$de,$bb ;swordSkelly
	db $00,$7a,$7d,$a5,$ae ;ghost
	db $00,$7c,$dd,$8a,$cf,$ff,$ff	;bookBird
;	db $00,$7c,$dd,$da,$b0,$ff,$ff ;bird 10

	enemyAssembly42:
	db $06,$52,$17,$03,$31,$08,$0f

;stage 8
;org $6916F	; lvl 2a
	enemyGFX43:
	db $00,$00
	db $00,$6a,$5d,$f8,$d3 ;crusher2 Spikes swingSpikes
;	db $00,$6e,$7d,$9b,$b6 ;drip 3f
	db $00,$6e,$1d,$b3,$b2 ;frog $30,
	db $00,$70,$1d,$ea,$b0 ;spider
	db $00,$72,$fd,$f0,$c6 ;ring, block and bubbles 2
;	db $00,$72,$3d,$d7,$b9 ;eye 72

	db $00,$74,$7d,$c2,$c5 ;axeKnight
	db $00,$7a,$1d,$ee,$ab ;bonePillar
;	db $00,$7e,$bd,$b6,$b2,$ff,$ff ;plant 35
	db $00,$7e,$dd,$a1,$ae,$ff,$ff ;snakeBush 32
	enemyAssembly43:
	db $07,$62,$30,$43,$03,$52,$0b,$32

	
;org $6919E ; lvl 2b
	enemyGFX44:
	db $00,$00
;	db $00,$6a,$5d,$f8,$d3 ;crusher2 Spikes swingSpikes 62
	db $00,$6a
	dl $EDCA3D				; puwexil boss 1 
	db $00,$70,$7d,$9b,$b6 ;drip
	db $00,$72,$fd,$f0,$c6 ;ring, block and bubbles 2 06
;	db $00,$72,$1d,$cf,$b9 ;boneDragon 5d
;	db $00,$76,$3d,$d7,$b9 ;eye 72
	db $00,$74,$9d,$97,$aa ;bat
	db $00,$76,$5d,$f8,$d3 ;crusher2 Spikes swingSpikes 62
;	db $00,$7a,$1d,$ee,$ab,$ff,$ff ;bonePillar 0b
	dw $ffff
	enemyAssembly44:
	db $05,$31,$3f,$03,$0c,$62	; sword skelly as place holder for boss sprite 3 slots ID31
	
org $691CD ; lvl 2c
	enemyGFX45:
	db $00,$00
	db $00,$6a,$5d,$f8,$d3 ;crusher2 Skikes swingSpikes
	db $00,$6e,$3d,$fe,$bd ;highFiveSkelly
;	db $00,$72,$bd,$b6,$b2 ;plant 35
	db $00,$72,$fd,$f0,$c6 ;ring, block and bubbles 2 
	db $00,$74,$1d,$cf,$b9 ;boneDragon
	db $00,$78,$3d,$c0,$af ;medusa
;	db $00,$7a,$dd,$a1,$ae ;snakeBush 32
	db $00,$7a,$7d,$9b,$b6 ;drip 3f	
	db $00,$7c
	dl NewPlatform2			; $5d,$b0,$b2 ;platform
	db $00,$7e,$3d,$d7,$b9,$ff,$ff ;eye
	
	enemyAssembly45:
	db $08,$62,$36,$03,$5d,$07,$3f,$17,$72
	
;org $691F6 ; lvl 2d
;	enemyGFX46: 
;
;	enemyAssembly46:

	
;stage 9	
;org $69219 ; lvl 2e 
;	enemyGFX47:
;
;	enemyAssembly47:

	
;org $69236 ; lvl 2f same as 2e
;	enemyGFX48:
;
;	enemyAssembly48:

	
;org $69253 ; lvl 30
	enemyGFX49:
	db $00,$00
	db $00,$6a,$7d,$9b,$d8 ;spark,suckHole
	db $00,$6e,$fd,$f0,$c6 ;ring, block and bubbles 2
	db $00,$70,$fd,$9b,$aa ;skelly
	db $00,$76,$1d,$cf,$b9 ;boneDragon
;	db $00,$7a,$1d,$ee,$ab ;bonePillar 0b
	db $00,$7a
	dl NewPlatform2						; $5d,$b0,$b2 ;platform
	db $00,$7c,$9d,$97,$aa,$ff,$ff ;bat
	enemyAssembly49:
	db $06,$63,$03,$12,$5d,$17,$0c
	
;org $6927C ; lvl 31
	enemyGFX50:
	db $00,$00
	db $00,$6a,$7d,$9b,$d8 ;spark,suckHole
	db $00,$6e,$fd,$f0,$c6 ;ring, block and bubbles 2
	db $00,$70,$bd,$8f,$c9 ;coffine
	db $00,$78,$1d,$cf,$b9 ;boneDragon
	db $00,$7c,$1d,$ee,$ab,$ff,$ff ;bonePillar
	enemyAssembly50:
	db $05,$63,$03,$33,$5d,$0b
	
;org $69299 ; lvl 32 same as 31
	enemyGFX51:

	enemyAssembly51:

	
;org $692B6 ; lvl 33
	enemyGFX52:

	enemyAssembly52:

	
;org $692D9 ; lvl 34 climb
	enemyGFX53: 
	db $00,$00
	db $00,$6a,$9d,$d3,$dc  ;spark,suckHole2
	db $00,$6e,$5d,$db,$dc  ;ring, block and bubbles 2
	db $00,$70,$7d,$df,$dc  ;skelly3
	db $00,$76,$fd,$ee,$dc ;boneDragon
	db $00,$7a,$3d,$8e,$cf,$ff,$ff	;shildGargoyl
	enemyAssembly53:
	db $05,$63,$03,$12,$5d,$75

;org $692F6 ; lvl 35 
	enemyGFX54:

	enemyAssembly54:


;org $69301 ; lvl 36 secret
	enemyGFX55:
	db $00,$00
;	db $00,$6a,$9d,$d3,$dc  ;spark,suckHole2 $63
	db $00,$6a,$5d,$db,$dc  ;ring, block and bubbles 2
	db $00,$6c,$7d,$e0,$c9	;oldMan
;	db $00,$72,$7d,$df,$dc,$ff,$ff  ;skelly3 ,$56
	db $00,$72
	dl gfxNPC2
	dw $ffff 
	enemyAssembly55:
	db $04,$03,$0d

;stage A ClockTower	
;org $69312 ; lvl 37
	enemyGFX56:

	enemyAssembly56:

	
;org $69323 ; lvl 38
	enemyGFX57:
	db $00,$00
	db $00,$6a,$bd,$be,$df ;smallGear
	db $00,$6e,$5d,$db,$dc ;looseGear
	db $00,$70,$1d,$ee,$ab ;bonePillar2
	db $00,$74,$fd,$ee,$dc ;boneDragon2
	db $00,$78,$9d,$de,$bb,$ff,$ff ;swordSkelly
	enemyAssembly57:
	db $05,$7c,$37,$0b,$5d,$31
	
;org $69346 ; lvl 39
	enemyGFX58:
	db $00,$00
	db $00,$6a,$fd,$b8,$de ;bigGears
	db $00,$6e,$5d,$db,$dc ;ring, block and bubbles4
	db $00,$70,$9d,$97,$aa ;bat
	db $00,$72,$dd,$a9,$ae ;horseHead
;	db $00,$70,$9d,$de,$bb ;swordSkelly
;	db $00,$76,$7d,$df,$dc ;skelly3
;	db $00,$74,$bd,$8f,$c9 ;coffine
	db $00,$74,$3d,$c0,$af ;medusa
	db $00,$76,$7d,$81,$b4 ;gargoyl	
	db $00,$7c
	dl gradiusIVGFX
	db $ff,$ff
	enemyAssembly58:
	db $06,$7c,$03,$0c,$6f,$07,$3e


;org $69369 ; lvl 3a
	enemyGFX59:
	db $00,$00
	db $00,$6a,$bd,$be,$df ;smallGear
	db $00,$6e,$5d,$db,$dc ;looseGear
	db $00,$70,$fd,$ee,$dc ;boneDragon2
	db $00,$74,$7d,$c2,$c5 ;axeKnight
	db $00,$7a,$3d,$c0,$af,$ff,$ff ;medusa
	enemyAssembly59:
	db $05,$7c,$03,$5d,$52,$07

;org $6938C
	enemyGFX60:

	enemyAssembly60:


;stage B	
;org $693A3
	enemyGFX61:

	enemyAssembly61:
	
;org $693B4
	enemyGFX62:
	db $00,$00
	db $00,$6A,$9D,$99,$E4 ;bridgeCrumbles
	db $00,$6C,$9D,$97,$AA ;bat
	db $00,$6e,$5D,$DB,$DC ;ring, block and bubbles4
	db $00,$70,$BD,$8B,$E3 ;headlessKinght
	db $00,$76,$fd,$a6,$c2,$FF,$FF ;eagle
	enemyAssembly62:
	db $05,$7D,$0C,$37,$7e,$57
	
;org $693C5
	enemyGFX63:
	db $00,$00
;	db $00,$6A,$DD,$BD,$E5 ;stoneGolem $7F
	db $00,$6a,$BD,$8B,$E3 ;headlessKinght
	db $00,$70,$3D,$CA,$E5 ;platform, rings, crumbleStairs
	db $00,$72,$9D,$97,$AA ;bat
	db $00,$74,$7D,$DF,$DC ;skelly3
	db $00,$7a,$3d,$8e,$cf,$FF,$FF ;shildGargoyl
;	db $00,$7E,$5D,$CE,$E5 ;skikeGear $8D
	enemyAssembly63:
	db $05,$7e,$03,$0c,$12,$75

warnpc $8693E6	;error if you go over this	
	
org $6FFFF
	enemyGFX64:
	
org $6FFFF
	enemyGFX65:
	
org $6FFFF
	enemyGFX66:
	
org $6FFFF
	enemyGFX67:
	
org $6FFFF
	enemyGFX68:
	
	
org $68c55	
	enemyAssembly64:
	enemyAssembly65:
	enemyAssembly66:
	enemyAssembly67:
	enemyAssembly68:
	
;mainSpritePaletteExpansion ; -----------------------------------	
org $818715
	db $01,$00,$00
;	db $8c,$c9				;orginal
	dw HUD_Palette			;New
	db $02,$22
;	db $aa,$c8				;orginal
	dw paletteSpriteMain	;New
	db $00,$23
	db $00,$00,$01

org $81f759
	db $01,$00,$00
	dw paletteTiles_1a
	db $20,$22 ; pointerdata?
	dw paletteSpriteExtra_1a
	db $A0,$23 ; tile pallete pointer
	db $00,$00

org $81F6BB
    dw $EE86,$23E0 			; paletteDataSpriteTilesStagel01_Stable;81F6BB|        |86E232; change for chandelire palette 
org $81F77A
	dw $E73C ;$E136					; $EE86 using sprite palette from stage one for middle entrance castle

;orginal Location ; -----------------------------------
org $86c8aa 	;Main
;	paletteSpriteMain:
	db $df,$00	;size Orginal df
org $86c98c
	HUD_Palette:
	db $1d,$00 ;size Orginal 1d

org $86de7e 	
	paletteSpriteExtra_1a: 
	db $1F,$00 ;size
	db $01,$00,$51,$4B,$BF,$53,$9A,$32,$00,$00,$BA,$01,$00,$00,$4E,$01 ;palette zombieGhost
	db $66,$00,$00,$00,$00,$00,$00,$00,$F3,$5B,$8B,$32,$66,$1D,$A2,$10

org $86ec9a
	paletteTiles_1a:
	db $9F,$00 ;size ($1f = 1 palette)

;expanded Location -----------------------------------------
org $86fd80 ;This is expanded to have a base color at the last sprite slot
paletteSpriteMain:
	db $ff,$00 ;size
	;Simon
	db $00,$00,$F8,$3D,$6A,$08,$1F,$43,$3C,$1E,$F1,$1C,$02,$00,$7E,$5F
	db $B8,$77,$70,$4E,$28,$25,$62,$04,$44,$00,$00,$00,$00,$00,$00,$00
	;9
	db $00,$00,$38,$67,$1A,$53,$76,$3E,$B2,$29,$EC,$14,$65,$04,$EA,$3D
	db $27,$25,$72,$00,$5B,$01,$3F,$02,$62,$14,$A5,$18,$0A,$00,$41,$08
	;a
	db $00,$00,$D3,$3E,$0D,$2E,$20,$19,$78,$53,$5F,$01,$F7,$5E,$73,$4E
	db $4A,$29,$3F,$3F,$7D,$2A,$A0,$08,$75,$11,$8C,$04,$61,$10,$40,$00
	;b
	db $00,$00,$9F,$4F,$1B,$2E,$75,$1D,$D2,$0C,$6D,$08,$47,$00,$03,$00
	db $DC,$32,$F3,$00,$0D,$00,$9B,$01,$DF,$26,$91,$4D,$78,$62,$0A,$35
	;c
	db $00,$00,$BE,$63,$19,$4F,$33,$36,$6D,$21,$C7,$10,$43,$04,$20,$04
	db $3F,$02,$36,$0D,$AF,$04,$49,$00,$9F,$43,$76,$2A,$4B,$15,$0D,$4C
	;d
	db $00,$00,$92,$36,$8C,$19,$66,$08,$B4,$14,$DC,$5B,$2F,$56,$E8,$0C
	db $43,$04,$7C,$05,$3F,$47,$37,$32,$6F,$1D,$9F,$26,$8B,$04,$40,$00
	;e
	db $00,$00,$9F,$2E,$7B,$15,$B5,$00,$10,$00,$0A,$00,$05,$00,$02,$00
	db $5D,$0D,$FA,$7E,$F0,$59,$2C,$49,$65,$20,$9D,$5B,$13,$2A,$0C,$0D
	;f	;NewExtraLastPalette
	db $0F,$00,$D6,$1D,$33,$11,$B1,$0C,$6D,$24,$8B,$00,$07,$0C,$03,$10
	db $55,$3A,$84,$14,$00,$00,$7D,$57,$BD,$2E,$34,$09,$B0,$00,$48,$00	

; ----------------------------------------	
org $F3C6FD
;    fontGFXdata2bpp: 	show one more character
		dw $0303		; $F3,$02,$80                       ;F3C6FD|        |      ;  
		db $80
org $FE913d
	sheepGFX:	
		db $04,$04,$80		; 3c4 bytes??	
		
org $FE955d
	gradiusIVGFX:
		db $04,$08,$80 
		
org $FE9D6d	
	gfxNPC2:
		dw $0c03			; size 
		db $80 

org $FEA98d
	gfxNPCWizard:
		dw $0c03			; size 
		db $80 

org $FEB5AD
	gfxHeadlessKnight2:
		dw $1003
		db $80 
org $a8c2bd
	NewPlatform1:
		db $44,$02,$80

org $A8C31D
	NewPlatform2:	
		db $84,$02,$80

org $BDFE3d
		dw $07c4			; high five skelly extra space for a fireball 
		db $80 
	
org $86806C				; experiment moving assets 	
	dw $8206			; blockMabSrcDestPointer19          ;86806C|        |868206;  
	dw $8216			; blockMabSrcDestPointer1a          ;86806E|        |868216;  
	dw $8216			; blockMabSrcDestPointer1a          ;868070|        |868216;  
	dw $8216			; blockMabSrcDestPointer1a          ;868072|        |868216;  
	dw $8216			; blockMabSrcDestPointer1a          ;868074|        |868216;  	

org $869453	
    dw $F7CE			; paletteTilesStagel09_zapfBatQuater;869453|        |81F7CE;  
    dw $F7DF			; paletteTilesStagel0A_clockTower   ;869455|        |81F7DF;  
    dw $F7DF			; paletteTilesStagel0A_clockTower   ;869457|        |81F7DF;  
    dw $F7DF			; paletteTilesStagel0A_clockTower   ;869459|        |81F7DF;  
    dw $F7DF			; paletteTilesStagel0A_clockTower   ;86945B|        |81F7DF;  	
	
org $868908
	dw $8A96			; gfxLevel25                        ;868908|        |868A96;  
    dw $8AA9			; gfxLevel26                        ;86890A|        |868AA9;  
    dw $8AA9			; gfxLevel26                        ;86890C|        |868AA9;  
    dw $8AA9			; gfxLevel26                        ;86890E|        |868AA9;  
    dw $8AA9			; gfxLevel26                        ;868910|        |868AA9;  	
	
	

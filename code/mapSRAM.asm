; ----------------------------- hijacks ---------------------------------

org $80ffd8				;Header Modefication
		db $03				;SRAM 2000 byte 

org $8283CB				
		JSL.L startUpSetup ;Hijack for all the WRAM menu stuff.. setting up at power on and reset	

org $808757		
;		JML.L CODE_83821F                    ;808757|5C1F8283|83821F;  
		jml removePWScreenWithMapScreen

org $809BB2
 ;       LDA.B $28    	; button current frame read					 ;809BB2|A528    |000028;  
 ;       BIT.W #$1080                         ;809BB4|898010  |      ;  
		jsl newMapExitBehavier
		nop
	    bra +      
        LDA.W #$000E                         ;809BB9|A90E00  |      ;  
        STA.W $1C00                          ;809BBC|8D001C  |811C00;  
    +                                                


org $809BBF
	introScreenTitleScreenRoutine: 
		LDA.W $1C00                          ;809BBF|AD001C  |811C00;  
        PHX                                  ;809BC2|DA      |      ;  
        ASL A                                ;809BC3|0A      |      ;  
        TAX                                  ;809BC4|AA      |      ;  
        LDA.L introScreenTitleScreenTable,X  ;809BC5|BFCF9B80|809BCF;  
        PLX                                  ;809BC9|FA      |      ;  
        STA.B $00                            ;809BCA|8500    |000000;  
        JMP.W ($0000)                        ;809BCC|6C0000  |000000;  
introScreenTitleScreenTable: 
		dw introScreenState00                ;809BCF|        |809BED;  
        dw introScreenState01                ;809BD1|        |809D66;  
        dw introScreenState02                ;809BD3|        |809D79;  
        dw introScreenState03                ;809BD5|        |809D81;  
        dw introScreenState04                ;809BD7|        |809E12;  
        dw introScreenState02                ;809BD9|        |809D79;  
        dw introScreenState06                ;809BDB|        |809E6D;  
        dw introScreenState07                ;809BDD|        |809F2A;  
        dw introScreenState02                ;809BDF|        |809D79;  
        dw introScreenState09                ;809BE1|        |809F48;  
        dw introScreenState0a                ;809BE3|        |809FA1;  
        dw introScreenState02                ;809BE5|        |809D79;  
        dw introScreenState0b                ;809BE7|        |809FE1;  
        dw introScreenState02                ;809BE9|        |809D79;  
        dw introScreenState0c                ;809BEB|        |809FF6;  
		
org $809BED		
		introScreenState00:	
org $809D66     
		introScreenState01:
org $809D79     
		introScreenState02:
			jml mapControll
org $809D81     
		introScreenState03:
org $809E12     
		introScreenState04:

org $809E6D     
		introScreenState06:
org $809F2A     
		introScreenState07:

org $809F48     
		introScreenState09:
org $809FA1     
		introScreenState0a:

org $809FE1     
		introScreenState0b:

org $809FF6     
		introScreenState0c:
		;	jml extraGFXLoad


org $86B6F5					; level loading sequents						
		phx
		phy
		jsl	levelJobLoad	; put hijacks here
		
		ply
		plx
		BRL CODE_86B79A  
		
		padbyte $ea			; remove check on stairs if timer is 000 to not trigger transition
		pad $86B79A
	CODE_86B79A:		
		
		
pullPC 			; freeSpace	
;	extraGFXLoad:
;		jsl loadEquipmentGFX	; fix initial GFX load for candles that would be missing when starting the game from continue 	
;		lda #$0006
;		sta $70 
;		rtl 
		
	mapControll:
		lda $f2 
		beq normalMapBehavier
		lda $1c00
		cmp #$0002
		bne endMapLevelSelect
		
		jsl writeMapTextUpdateTable
		
		LDA.B $28    	; exit map with start or A 
        BIT.W #$1080                       
	    beq +      
        lda #$0000                       
        sta $1c00                        
		sta $f2			; reset with normal map behavior 

	+	lda $28
		bit #$0400
		beq ++
		lda.l $700002
		cmp $700000
		bcc +
		lda #$ffff
	+	clc
		adc #$0001	
		sta $700002
    ++  lda $28
		bit #$0800
		beq endMapLevelSelect 
		lda.l $700002
		sec 
		sbc #$0001
		cmp #$FFFF
		bne ++
		lda $700000		; reset to highest level avalible 
	++	sta $700002	
    endMapLevelSelect:   
		rtl                         
	normalMapBehavier:
		DEC.B $68                            ;809D79|C668    |000068;  
        BNE +
        INC.W $1C00                          ;809D7D|EE001C  |811C00;  
	+	rtl 
	
	newMapExitBehavier:
		lda $f2			; disable in level secect mode
		bne + 
		LDA.B $28    	; button current frame read					 ;809BB2|A528    |000028;  
        BIT.W #$1080                         ;809BB4|898010  |      ;  
	    BEQ +      
        
	;	jsl loadEquipmentGFX
		
		LDA.W #$000E                         ;809BB9|A90E00  |      ;  
        STA.W $1C00                          ;809BBC|8D001C  |811C00;  
	+	rtl 
	
	loadEquipmentGFX:
		phx 
		ldx #$B3E2
		JSL.L $8280e8
		plx 
		rtl 
	
	updateMapTextPointer:
		lda $20						; output help text till first input 
		beq +
		
		lda $86
		asl
		asl
		asl
		tax
		lda.l equipmentLevels,x
		sta $f2
	+	rtl 
	
	
	writeMapTextUpdateTable:
		phx
		phy
		
;		jsl SetDataBanktoA0
		jsl SetDataBanktoA4
		
		ldy #$000d					; write first line
		ldx #$001a
	-	lda levelSelectText00,y
		and #$00ff
		
		phx							; find character
		asl 
		tax
		lda.l asciiLookUpTable,x
		plx 
		
		sta.l $7fff88,x				; write to updater table 
		dey
		dex 
		dex
		bpl -
		
		lda $700002					; update selected level in update table 
		pha
		and #$000f
		inc 
		ora #$2000
		sta $7fffa0
		pla
		lsr
		lsr
		lsr
		lsr
		inc 
		ora #$2000
		sta $7fff9e 
		
		ldy #$000d					; write second line 
		ldx #$001a
	-	LDA ($F2),Y		; read Ascii Character from text-table
	;	lda levelSelectText01,y
		and #$00ff
		
		phx							; find character
		asl 
		tax
		lda.l asciiLookUpTable,x
		plx 
		
		sta.l $7fffa4,x
		dey
		dex 
		dex
		bpl -
		
		lda $700002					; SRAM 
		asl
		tax 
		lda levelTable,x 
		and #$00ff
		sta $86
		lda levelTable,x 
		and #$0f00
		lsr
		lsr
		lsr
		lsr
		
		lsr		
		lsr
		lsr
		lsr 
		sta $1c02					; offset by a byte 
		lda levelTable,x  
		and #$f000
		clc 
		rol
		rol
		rol
		rol
		rol 
		sta $13d4
		
		jsl updateMapTextPointer
		
		jsl SetDataBankto81
		
		ply
		plx 
		rtl 
	
	levelTable:
		dw $0005 		;0 	new level order with map sceene to choose. Format=Entrance,Map,level ..XYZZ 
		dw $0006	    ;1	
		dw $0008	    ;2	
		dw $0009	    ;3	
		dw $0003        ;4
		dw $0002        ;5
		dw $0004        ;6
		dw $0018        ;7
		dw $000d        ;8
		dw $010c        ;9	; cave 
		dw $010b        ;a
		dw $010a        ;b
		dw $0112        ;c
		dw $0113        ;d
		dw $0114        ;e
		dw $0111        ;f
		dw $1110        ;10
		dw $110f        ;11
		dw $1101        ;12
		dw $1207        ;13
		dw $0319        ;14		;  $3205 I could go to the correct level but it breaks level finding.. 
		dw $2319        ;15
		dw $041d        ;16		; castle start
		dw $141c        ;17
		dw $041f        ;18
		dw $0420        ;19
		dw $0421        ;1a		
		dw $1422        ;1b		; dancer Boss
		dw $0423        ;1c		; libery 
		dw $0424        ;1d
		dw $0425        ;1e
		dw $0426        ;1f
		dw $0427        ;20
		dw $0528        ;21
		dw $0527        ;22
		dw $0528        ;23
		dw $0529        ;24
		dw $052a        ;25
		dw $052b        ;26
		dw $052c        ;27
		dw $052d        ;28
		dw $052e        ;29
		dw $052f        ;2a
		dw $0530        ;2b
		dw $0531        ;2c
		dw $0532        ;2d
		dw $0633        ;2e
		dw $0634        ;2f
		dw $0635        ;30
		dw $0636        ;31
		dw $0637        ;32
		dw $0738        ;33
		dw $0739        ;34
		dw $073a        ;35
		dw $073b        ;36
		dw $073c        ;37
		dw $073d        ;38
		dw $073e        ;39
		dw $083f        ;3a
		dw $0841        ;3b
		dw $0842        ;3c
		dw $0842        ;3d
		dw $0842        ;3e
		dw $0942        ;3f
		dw $0a42        ;41
		dw $0a42        ;42
		dw $0a42        ;43
		dw $0a42	    ;44
	
	removePWScreenWithMapScreen:
		lda $1c00
		cmp #$0004
		bne +
		lda #$0000 ; set start map
		sta $1c00 
		sta $1c02
		lda #$000b ; set main map 
		sta $70 
		lda #$0004	; set game state 
		sta $32
		lda #$0001
		sta $7c 	; life counter else it goes to gameover screen
		lda #$0005
		sta $13F2	; heart default 
		lda.l textMapHowTo
		sta $f2		; set level slect to be active 
		jsl loadEquipmentGFX	; fix initial GFX load (candles) that would be missing when starting like this 
		rtl 
	+	JML.L $83821F		; CODE_83821F

	levelSelectText00:
		db "MAP SELECT   "
	
	levelSelectText01:
		db "UP DOWN START"	
	
	textMapHowTo:
		dw levelSelectText01

	startUpSetup:		 
		PHA                                   
		PHP                                  
		REP #$30                             
         
		jsl clearSRAM						; this should be in the SRAM file		 
		jsr cleanWRAM                    
		
		PLP                                  
		PLA                                  
		JSL.L $82858F 					; what code??    Loading sequentz at the beginning of the game..               
		RTL                           	
	
	cleanWRAM:  		
		phx
		phy
	
		lda #$0000	;byte to be moved forward. Clear Trick
		sta $7FF300
		
	
		LDX #$f300   ; Set X to $f300
		LDY #$f302   ; Set Y to $f302
		LDA #$0cfd   ; Set A to $cfe bytes to be cleared
		MVN $7f,$7f  ; The values at $7f xxxx
    
		ply
		plx
		
		SEP #$20	;clearing the end of WRAM did change the dataBank so we recover what we had before
		LDA #$00
		PHA     
		PLB     
		REP #$30                        
		rts               	


	clearSRAM:		; first use clear
		lda $70000e			; we do that at startup clearCheck. It is included in the TEXT Engine
;		cmp $80FFDC
		cmp #$4337
		beq SRAMCLEARED
	eraseSRAM:	
		phx
		phy
		
		lda #$0000	;byte to be moved forward. Clear Trick
		sta $700000
		
		LDX #$0000   ; Set X to $28C0
		LDY #$0002   ; Set Y to $28C2
		LDA #$01fe   ; Set A to $00f0 bytes to be cleared
		MVN $70,$70  ; 
		
		ply
		plx
		
;		lda.l $80ffdc	; signe SRAM 
		lda #$4337
		sta.l $70000e
		
		SEP #$20	;Change data bank restore $81 I guess
		LDA #$81
		PHA     
		PLB     
		REP #$30
	SRAMCLEARED:	
		rtl 

	
	
;---------------------------------- old job asm 
	saveProgress:
		ldx #$0086						; start max level 
 
	-	lda.l levelTable,x				; find current level you are in 
		and #$00ff 
		dex
		dex
		bmi endSaveProgress				; end when we checked every level 
		cmp $86							; check level 
		bne -
		txa 
		lsr 							; make index to current level number 
		inc 							; reverse index adjustment to get current level 
		sec 
		cmp.l $700000					; ech if we advanced more allready 
		bcc endSaveProgress 
		sta.l $700000
		sta.l $700002					; update progress too 
	endSaveProgress:	
		rtl 
	
	levelJobLoad:
;		lda $0086
;		bne +
;		lda #$0002							; level 00 setup
;		sta !ownedWhipTypes
;		lda #$0000
;		sta !whipLeanth
;		sta !armorType
;		sta !allSubweapon			
;	+
		jsl saveProgress
		
		lda !flagSkipBoss					; clear flag in a new level
		cmp $86
		beq +
		stz !flagSkipBoss
		
	+	ldy !textEngineState
		cpy #$0000
		beq +
		ldy #$0003							; fix when u die while talking
		sty !textEngineState
		stz $f0				
		stz $f2
		stz $f4
		stz $f6 		

	+	lda $86 
		ldy #$0000		
		asl
		asl
		asl
		tax
	-	lda.l equipmentLevels,x
		sta !jobTable00,y					; 1e40
		inx
		inx
		iny
		iny
		cpy #$0008
		bne -
		and #$000f
;		sta $008e							; give subweapon 1.dagger, 2.axe, 3.holy, 4.cross, 5.clock
		ora !ownedWhipTypes
		sta !ownedWhipTypes
		
		lda !jobTable03
		and #$00f0
;		clc									; cumulative curse secondquest.. I think that is stupid..
;		adc $84
		cmp #$00f0
		bne +
		lda #$0100							; lets show a 100 curse instead.. 
	+	sta $84
	
	+	jsl updateCurseHud
							
		lda !backUpButtonMapJump			; restire buttonmaping
		sta $be
		lda !backUpButtonMapWhip
		sta $c0		
		lda !backUpButtonMapSubWe
		sta $c2		
		
		lda !jobTable03
		and #$0f00
		cmp #$0100
		bne +
		stz $be
	+	cmp #$0200
		bne +
		stz $c0 
	+	cmp #$0300
		bne +
		stz $c2 
	+	cmp #$0400
		bne +
		stz $be		; disable jump and whip 
		stz $c0 
		
		 
;	+	lda !jobTable02		  ; set level specials 01 bg rising plaform, 03 garden BG tiles 
;		and #$000f
;		ora $ae 
;		sta $ae 
	
	+	lda !jobTable00
		BEQ endJobTextUpdater	; end if u reach NULL in text
		
;		jsl SetDataBanktoA0
		jsl SetDataBanktoA4
		
		lda !jobTable00
		sta $f0
		jsl secondTownPointerFix	; since we use the same level for two towns.. 
		ldy #$0000
		tyx
	-	lda ($f0),Y 
		and #$00ff
		cmp #$0000
		beq endJobTextUpdater
		
		phx
		asl a			; Look up character for PPU
		tax
		LDA.l asciiLookUpTable,x	
		plx 	
				
		sta.l $7fff88,X   
		iny 
		inx
		inx 
		bra -
			
	endJobTextUpdater:	
		stz $f0 
		jsl SetDataBankto81
		rtl
		
	updateCurseHud:
		lda $84								; show current curse in HUD prepare tiles. The update is in the text engine.asm
		and #$00f0
		lsr
		lsr
		lsr
		lsr
		inc
		ora #$2c00
		sta $7fff84
		lda $84								; show current curse in HUD
		and #$000f
		inc
		ora #$2c00
		sta $7fff86
		
		lda $85								; show current curse in HUD
		and #$00f0
		lsr
		lsr
		lsr
		lsr
		inc
		ora #$2c00
		sta $7fff80
		
		lda $85								; show current curse in HUD
		and #$000f
		inc
		ora #$2c00
		sta $7fff82
		rtl 
		
	equipmentLevels:					;current XXxx XXxx XXxx XX= disableAction 1j2w3s, x=Curse,x=whip Type
		dw emptyText,$0000,$0000,$0003	;lvl 0
		dw textDitch,$0000,$0000,$0002	;lvl 1
		dw textFirstTower,$0000,$0000,$0000          ;lvl 2
		dw textFirstTower,$0000,$0000,$0000	        ;lvl 3
		dw textFirstTower,$0000,$0000,$0000          ;lvl 4
		dw textTown,$0000,$0000,$0000   ;lvl 5
		dw textTutorial,$0000,$0000,$0000         ;lvl 6
	fixSecondTownText:	
		dw textTown2,$0000,$0000,$0002	;lvl 7
		dw textParkour,$0000,$0000,$0000     ;lvl 8	gravyard
		dw textSwamp,$0000,$0000,$0000    ;lvl 9	swamp
		dw textRifer,$0000,$0000,$0002         ;lvl a	waterslide
		dw textRifer,$0000,$0000,$0002	  ;lvl b
		dw textCave,$0000,$0000,$0000	 ;lvl c	cave
		dw textViper,$0000,$0000,$0000	  ;lvl d
		dw textAquaduct,$0000,$0000,$0002	     ;lvl e	aqua
		dw textAquaduct,$0000,$0000,$0002	      ;lvl f
		dw textAquaduct,$0000,$0000,$0002	     ;lvl 10
		dw textAquaduct,$0000,$0000,$0002	      ;lvl 11
		dw textBodley,$0000,$0000,$0002	      ;lvl 12 tower puw
		dw textBodley,$0000,$0000,$0002	      ;lvl 13
		dw textBodley,$0000,$0000,$0002	     ;lvl 14
		dw emptyText,$0000,$0000,$0013	  ;lvl 15	rotating
		dw emptyText,$0000,$0000,$0013	       ;lvl 16
		dw textKoranotsLayer,$0000,$0000,$0003	      ;lvl 17
		dw textPreCastle,$0000,$0000,$0000	  ;lvl 18 blue
		dw textSecretTunnle,$0000,$0000,$0003	  ;lvl 19
		dw emptyText,$0000,$0000,$0013	      ;lvl 1a
		dw emptyText,$0000,$0000,$0013	      ;lvl 1b chandelire
		dw backEntranceCastle,$0000,$0000,$0013	  ;lvl 1c
		dw backEntranceCastle,$0000,$0000,$0013	  ;lvl 1d
		dw emptyText,$0000,$0000,$0013	   ;lvl 1e secret 00
		dw textWickedWing,$0000,$0000,$0013	      ;lvl 1f dance quater
		dw textWickedWing,$0000,$0000,$0013	  ;lvl 20
		dw textWickedWing,$0000,$0000,$0013	      ;lvl 21
		dw textWickedWing,$0000,$0000,$0013	      ;lvl 22
		dw textBottomLess,$0000,$0000,$0013	      ;lvl 23 liberarry
		dw textBottomLess,$0000,$0000,$0013	     ;lvl 24
		dw textBottomLess,$0000,$0000,$0013	  ;lvl 25
		dw textSecretMeating,$0000,$0000,$0003	    ;lvl 26 graqulQuater
		dw textSecretMeating,$0000,$0000,$00f3	  ;lvl 27
		dw textSecretMeating,$0000,$0000,$00f3	  ;lvl 28
		dw textGrakulsQuater,$0000,$0000,$0013	      ;lvl 29
		dw emptyText,$0000,$0000,$0013	   ;lvl 2a dungeon
		dw emptyText,$0000,$0000,$0013	  ;lvl 2b
		dw emptyText,$0000,$0000,$0013	  ;lvl 2c frankQuater
		dw emptyText,$0000,$0000,$0013	      ;lvl 2d
		dw emptyText,$0000,$0000,$0013	    ;lvl 2e gold
		dw emptyText,$0000,$0000,$0013	  ;lvl 2f
		dw emptyText,$0000,$0000,$0013	  ;lvl 30
		dw emptyText,$0000,$0000,$0013	  ;lvl 31 zapfQuater
		dw emptyText,$0000,$0000,$0013	    ;lvl 32
		dw emptyText,$0000,$0000,$0013	      ;lvl 33
		dw emptyText,$0000,$0000,$0013	  ;lvl 34
		dw emptyText,$0000,$0000,$0013	  ;lvl 35
		dw emptyText,$0000,$0000,$0013	          ;lvl 36 secret 01
		dw CVshooterText,$0000,$0000,$0013	      ;lvl 37 ClockTower
		dw emptyText,$0000,$0000,$0013	  ;lvl 38
		dw emptyText,$0000,$0000,$0013	  ;lvl 39
		dw emptyText,$0000,$0000,$0013	  ;lvl 3a
		dw emptyText,$0000,$0000,$0013	      ;lvl 3b MummyRoom
		dw emptyText,$0000,$0000,$0013	  ;lvl 3c Bridge
		dw emptyText,$0000,$0000,$0013	      ;lvl 3d
		dw emptyText,$0000,$0000,$0013	  ;lvl 3e FinalTower
		dw emptyText,$0000,$0000,$0013	      ;lvl 3f Slog
		dw emptyText,$0000,$0000,$0013	   ;lvl 41	Gai
		dw emptyText,$0000,$0000,$0013	      ;lvl 42  Death
		dw emptyText,$0000,$0000,$0013	  ;lvl 43
		dw emptyText,$0000,$0000,$0013	  ;lvl 44 Drac                                          
	

	
	textTown:
		db "ALBA INN       ",$00
	textTown2:
		db "DOINA INN      ",$00
	textTutorial:
		db "TUTORIAL       ",$00
	jobDeath:
		db "CHOOP CHOOP    ",$00
	jobDrac:
		db "CHICKEN DINNER ",$00
	textParkour:
		db "PARKOUR CAVE   ",$00 
	textSwamp:
		db "WET FEET TOUR  ",$00	
	textFirstTower:
		db "SPOOKY TOWERS  ",$00			
	textAquaduct:
		db "CURSED WATER   ",$00	
	textCave:
		db "DOINA CAVE     ",$00
	textViper:	
		db "WICKED FALLS   ",$00
	textRifer:
		db "MURDER RIFER   ",$00
	textPreCastle:
		db "DEBORAH CLIFF  ",$00
	textBodley:	
		db "BODLEY MENSION ",$00
	textDitch:
		db "WICKED DITCH   ",$00
	emptyText:
		db "               ",$00
	textSecretTunnle:
		db "SECRET PATH    ",$00
	textKoranotsLayer:
		db "KORANOT LAYER  ",$00
	backEntranceCastle:
		db "BACK ENTRANCE  ",$00
	textWickedWing:	
		db "WICKED WING    ",$00
	CVshooterText:
		db "GRADIUS IV     ",$00
	textBottomLess:
		db "DARK LIBERARY  ",$00
	textSecretMeating:
		db "GHOST MEATING  ",$00		
	textGrakulsQuater:
		db "GRAKUL LAYER   ",$00
		
	secondTownPointerFix:
		lda $86
		cmp #$0005
		bne +
		lda $13D4
		cmp #$0003
		bne +
		lda.l fixSecondTownText
		sta $f0 
	+	rtl 
	
	
pushPC 		
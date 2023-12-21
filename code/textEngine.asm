;freeSpace 


pullPC

	cleartable
	; $f0	text pointer
	; $f2	action pointer
	; $f4   action list pointer (npcAction for each npc)
	
	; $32 textPos
	; $34 pointerPos in actionList
	; $36 curserPos 

	table "code/text_asc.txt"	;[,rtl/ltr]
	;!equal = $5b				; in game text 
	;!dot = $5c
	;!heart = $5d
	;!questionmark = $5e
	
{	; textEngine PPU Routines ---------------------------------------------------------
	mainTextEngine:                  
		PHD                                  
		PHB                                  
		REP #$30                             
		PEA.W $a000       		; Push Effective Absolute Address
		PLB                                  
		PLB                                  
		
		LDA.L !textEngineState                        
		BNE runTextEngine                      
        jsr.w mapScreenText
		
		lda $32					; only run game mode 
		cmp #$0004
		bne endTextEngine
		
		lda RAM_simonSlot_State	; gradius and elevator can glitch so we do not run when simon is in that state
		sec 
		sbc #$0011 
		bcs runTextEngine

		lda #$0001				; run text engine and text display on different frames 
		bit $3a
		bne +
	
		jsr.w hudUpdater  	
		BRA endTextEngine 
		
	+	jsr.w jobTextDisplay
		BRA endTextEngine              
	
	runTextEngine: 
        cmp #$0002
		beq runTextDisplay
		jsl clearText
		
		BRA endTextEngine         
	
	runTextDisplay:          
		JSR.W textDraw2PPU               
		
	endTextEngine: 	
		PLB            		; set old bank                  
        PLD                 ; fix stack          
        LDA.W $4210          	           
        REP #$20                        
        JML.L $8081CF                   
	    	
	textDraw2PPU:                                         
        LDX.W #$0000     	; line 1                                     
	   
        SEP #$20                             
        REP #$10                             		
		LDA.B #$80                           
        STA.W $2115                          
        LDX.W #$5948                         
        STX.W $2116                          
        LDA.B #$7F                           
        LDX.W #$FF00                         
        LDY.W #$0020  		; size of data to transphere                       
        STX.W $4302                          
        STA.W $4304                          
        STY.W $4305                          
        LDA.B #$18                           
        STA.W $4301                          
        LDA.B #$01                           
        STA.W $4300                          
        STA.W $420B                          
       
        LDX.W #$5968       	; line 2                   
        STX.W $2116                          
        LDA.B #$7F                           
        LDX.W #$FF20                         
        LDY.W #$0020  		; size of data to transphere                       
        STX.W $4302                          
        STA.W $4304                          
        STY.W $4305                          
        LDA.B #$18                           
        STA.W $4301                          
        LDA.B #$01                           
        STA.W $4300                          
        STA.W $420B          

		LDX.W #$5988       	; line 3                   
        STX.W $2116                          
        LDA.B #$7F                           
        LDX.W #$FF40                         
        LDY.W #$0020  		; size of data to transphere                       
        STX.W $4302                          
        STA.W $4304                          
        STY.W $4305                          
        LDA.B #$18                           
        STA.W $4301                          
        LDA.B #$01                           
        STA.W $4300                          
        STA.W $420B          
		
		LDX.W #$59a8       	; line 4                   
        STX.W $2116                          
        LDA.B #$7F                           
        LDX.W #$FF60                         
        LDY.W #$0020  		; size of data to transphere                       
        STX.W $4302                          
        STA.W $4304                          
        STY.W $4305                          
        LDA.B #$18                           
        STA.W $4301                          
        LDA.B #$01                           
        STA.W $4300                          
        STA.W $420B          
		
		RTS                                  

	hudUpdater:
;		lda $552			; garbage hotfix issue with scrolling. Probably to many updates running 
;		cmp #$0011
;		beq +
		
		lda $70				; only run while in game mode
		cmp #$0005
		bne +
		    	                                                    
        SEP #$20                             
        REP #$10                
		
		LDX.W #$583b       	; line 5                   
        STX.W $2116                          
        LDA.B #$7F                           
        LDX.W #$FF80                         
        LDY.W #$0008  		; size of data to transphere                       
        STX.W $4302                          
        STA.W $4304                          
        STY.W $4305                          
        LDA.B #$18                           
        STA.W $4301                          
        LDA.B #$01                           
        STA.W $4300                          
        STA.W $420B          
		
	+	rts 
     
	jobTextDisplay: 
		lda $70				; only run while in game mode
		cmp #$0004			; 5 ?? 
		bne +
		lda !jobTable00
		beq +  
			
		lda $66				; dont run while pause
		bne +
		
        SEP #$20                             
        REP #$10                
		
;		LDX.W #$5802       	; line 5                   
		ldx #$5821
        STX.W $2116                          
        LDA.B #$7F                           
        LDX.W #$FF88                         
        LDY.W #$001E  		; size of data to transphere     text size is 1c                   
        STX.W $4302                          
        STA.W $4304                          
        STY.W $4305                          
        LDA.B #$18                           
        STA.W $4301                          
        LDA.B #$01                           
        STA.W $4300                          
        STA.W $420B          		
	+	rts
	
	mapScreenText:
		lda $70
		cmp #$000b
		bne +
;		lda $1c00
;		cmp #$0002
		lda $f2
		beq +
		
		SEP #$20                             
        REP #$10                
		
		LDX.W #$5b29       	;             
        STX.W $2116                          
        LDA.B #$7F                           
        LDX.W #$FF88                         
        LDY.W #$001b  		; size of data to transphere                       
        STX.W $4302                          
        STA.W $4304                          
        STY.W $4305                          
        LDA.B #$18                           
        STA.W $4301                          
        LDA.B #$01                           
        STA.W $4300                          
        STA.W $420B          		
		
		LDX.W #$5b49       	;             
        STX.W $2116                          
        LDA.B #$7F                           
        LDX.W #$FFa4                         
        LDY.W #$001b  		; size of data to transphere                       
        STX.W $4302                          
        STA.W $4304                          
        STY.W $4305                          
        LDA.B #$18                           
        STA.W $4301                          
        LDA.B #$01                           
        STA.W $4300                          
        STA.W $420B          		
		
	+	sep #$30
		rep #$30
		
	+	rts 
	
	clearText:
		ldx #$007e
		lda #$0000
	-	
		sta $7fff00,x 
		dex
		dex
		bpl -
		jsr textDraw2PPU
		stz !textEngineState
		rtl
	
	clearTextOnly:
		phx 
		ldx #$007e
		lda #$0000
	-	
		sta $7fff00,x 
		dex
		dex
		bpl -
		plx 
		rtl  
	
;	startUpSetup:		 
;		PHA                                   
;		PHP                                  
;		REP #$30                             
;         
;		jsl clearSRAM						; this should be in the SRAM file		 
;		jsr cleanWRAM                    
;		
;		PLP                                  
;		PLA                                  
;		JSL.L $82858F 					; what code??    Loading sequentz at the beginning of the game..               
;		RTL                           	
;		
;	cleanWRAM:  		
;		phx
;		phy
;	
;		lda #$0000	;byte to be moved forward. Clear Trick
;		sta $7FF300
;		
;	
;		LDX #$f300   ; Set X to $f300
;		LDY #$f302   ; Set Y to $f302
;		LDA #$0cfd   ; Set A to $cfe bytes to be cleared
;		MVN $7f,$7f  ; The values at $7f xxxx
;    
;		ply
;		plx
;		
;		SEP #$20	;clearing the end of WRAM did change the dataBank so we recover what we had before
;		LDA #$00
;		PHA     
;		PLB     
;		REP #$30                        
;		rts               	
;		
;	clearSRAM:		; first use clear
;		lda $70000e			; we do that at startup clearCheck. It is included in the TEXT Engine
;		cmp $80FFDC
;		beq SRAMCLEARED
;	eraseSRAM:	
;		phx
;		phy
;		
;		lda #$0000	;byte to be moved forward. Clear Trick
;		sta $700000
;		
;		LDX #$0000   ; Set X to $28C0
;		LDY #$0002   ; Set Y to $28C2
;		LDA #$01fe   ; Set A to $00f0 bytes to be cleared
;		MVN $70,$70  ; 
;		
;		ply
;		plx
;		
;		SEP #$20	;Change data bank restore $81 I guess
;		LDA #$81
;		PHA     
;		PLB     
;		REP #$30
;	SRAMCLEARED:	
;		rtl 


; ------------ end textEngine PPU Stuffs -----------------


}

		
asciiLookUpTable:		
dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000		; replaced character 0CFE with 0C00
dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
dw $0000,$0000,$0000
dw $0CFF,$0CFD,$0C00,$0C00,$0C0A,$0C00,$0C00,$0CFC,$0C00,$0C00 
dw $0C00,$0CFB,$2026,$0CFA,$0C00	
dw $2001,$2002,$2003,$2004,$2005 
dw $2006,$2007,$2008,$2009,$200A
dw $0C00,$0C00,$0C00,$0C00,$0C00
dw $0C00,$0C00,$200B,$200C,$200D,$200E,$200F,$2010,$2011,$2012
dw $2013,$2014,$2015,$2016,$2017,$2018,$2019,$201A,$201B,$201C
dw $201D,$201E,$201F,$2020,$2021,$2022,$2023,$2024,$2025,$2026,$2027,$202e,$202f


;		dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000		; made by redguy 
;		dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
;		dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
;		dw $0000,$0000,$0000
;		dw $0CFF,$0CFD,$0CFE,$0CFE,$0C0A,$0CFE,$0CFE,$0CFC,$0CFE,$0CFE ;??
;		dw $0CFE,$0CFB,$2026,$0CFA,$0CFE
;		dw $2001,$2002,$2003,$2004,$2005 
;		dw $2006,$2007,$2008,$2009,$200A
;		dw $0CFE,$0CFE,$0CFE,$0CFE,$0CFE
;		dw $0CFE,$0CFE,$200B,$200C,$200D,$200E,$200F,$2010,$2011,$2012
;		dw $2013,$2014,$2015,$2016,$2017,$2018,$2019,$201A,$201B,$201C
;		dw $201D,$201E,$201F,$2020,$2021,$2022,$2023,$2024,$2025,$2026,$2027,$202e



{	; NPC Main ------------------------------------------------------------------------	
	mainNPC:
	    LDA.B $12,X                      ; jumpTable 
        PHX                               
        ASL A                             
        TAX                               
        LDA.L mainNPCStateTable,X            
        PLX                               
        STA.B $00                         
       
		jsl SetDataBanktoA0				; routine is in mainEvent --- general Routines ---
		jsl jumpTableMainNPC
				
		jsl SetDataBankto81				; restor 
		rtl									; exit event here
		
	jumpTableMainNPC:
		JMP.W ($0000)                     
		rtl
	
	checkMultiSpawn:
		phx 					; make it always appear 
		lda $30,x   
		tax 
		stz $1500,x		
		plx 
		
		
		phy 
		ldy #$0540
		
	-	tya
		clc 
		adc #$0040
		cmp #$0f00
		beq ++
		tay 
		lda $10,x 				; check ID
		cmp $0010,y 
		bne -
		lda $14,x				; check subID
		cmp $0014,y 
		bne -
		txa 					; check if not orginal event 
		sta $00
		cpy $00 
		beq -
		
		ply 
		jml clearSelectedEventSlotAll		; terminate multispawn 
	++	ply 
		rtl 
	

    NPCState00:
		lda $14,x 
		asl
		tay 
		lda npcSpriteIDlist,y 	
		sta $00,x
		
		lda $14,x 
		clc 
		adc #$0002				; the first two states are used for spawn and text, so we add them to the index and use subID to count NPC states/ID
		sta $12,x 
		
		lda $542				; Sprite Priority??
		sta $02,x 		
		
;		lda #$0010				; health.. seems not the reason for despawning.. still need to figure this out.. 
;		sta $06,x 
		jsl checkMultiSpawn
;		jsl checkType2Multiples ; doesnt work for some reason.. 
		rtl
		
	NPCText01:	                                                                                
		LDA $32,X		; load TextPos                                                    
		PHX
		PHY
		TAY
		LDA ($F0),Y		; read Ascii Character from text-table
		AND #$00FF
		BEQ endTextNPC	; end if u reach NULL in text
;		cmp #$00fe
;		bne +
;		jsr findEndOfLine
;+
		ASL A			; Look up character for PPU
		TAY
		LDA asciiLookUpTable,Y
		PHA				; phus character
		
		LDA $32,X		; load TextPos scale up to write to bigger table 
		ASL A			
		TAX
		
		PLA				; pull character and write to WRAM page
		STA $7FFF00,X
		
		TXA				; advance textPos 
		LSR A
		INC A
		PLY
		PLX
		STA $32,X
		PHX
		PHY

	endTextNPC:
		PLY
		PLX
		
		jsr curserPos
		jsr textStateUpdater
		
		LDA $28			; check B press to run action/advance 
		BIT #$8000
		BEQ +
		JMP ($00F2)
	+	rtl 
	
;	findEndOfLine:
;		
;		lda #$0000
;		STA $7FFF00,X
;		
;		cpx #$10
;		beq +
;		cpx #$20
;		beq +
;		cpx #$30
;		beq +
;				
;	+	rts 

	NPCTextTrigger:	
		lda !textEngineState
		bne +				; make sure not to run twice or it will crash
		
		lda $54a 
		adc #$0020			; check if Simon is near in the xpos
		SEC                    
		SBC.B $0A,X            
		BMI +                  
		CMP.W #$0040           
		BPL +        

		lda $54e 
		adc #$0020			; check if Simon is near in the ypos
		SEC                    
		SBC.B $0E,X            
		BMI +                  
		CMP.W #$0030           
		BPL +        

		lda $28				; check up input to start text
		bit #$0800
		beq +
		
		lda #$0001		    ; make player stuck on ground 
		sta $1fa2
		jsr loadTextPointer			
	
	+	rtl
	

	loadTextPointer:		
		lda #$0002		; start update 2 PPU
		sta !textEngineState
		lda #$0001		; load textState for NPCs 		
		sta $12,x			
		
		lda $14,x 
		asl a
		tay 
		lda actionListMainNPC,y 
		sta $f4  
		lda #$00a0		; set bank NPC text/action list  Pointer
		sta $f6	
		
		stz $32,x		; make sure we start to write at the beginning		
		
		LDA $34,x 		; load Pointers and store them to RAM
		ASL A
		TAY
		LDA [$f4],y	; $f4 current NPC text/action list  Pointer
		STA $F0
		INY
		INY
		LDA [$f4],y 
		STA $F2	
				
		rts 
		
;	goNextTextSetBGMode2:	
;		stz.w $46 
;		jsl goNextText
;		jsr textStateUpdater
;		JMP ($00F2)		
	goNextTextSet30:
		inc $30,x 
	goNextText:
		inc $34,X
		inc $34,X
		
		jsr loadTextPointer			
		jsl clearTextOnly
		rtl				; actions also end the state..
		
}

{	; NPC Text ------------------------------------------------------------------------
	npcSpriteIDlist:			; list is based in subID $14																		
		dw oldMan3Fr1,jungLadyFr1,oldManFr1,jungLadyFr1					; 00$8f15
		dw oldManFr1,oldMan3Fr1,jungLadyFr1,jungLadyFr1					; 04
		dw jungLadyFr1,oldMan3Fr1,$89f0,jungLadyFr1						; 08
		dw $89f0,jungLadyFr1,oldManBrawnPents00,oldMan3Fr1					; 0c
		dw doorSpriteAssembly,oldManFr1,AssGuy,oldManFr1					; 10
		dw oldMan3Fr1,oldManFr1,AssPaul,doorSpriteAssembly					; 14
		dw jungLadyFr1,jungLadyFr1,jungLadyFr1,jungLadyFr1					; 18
		dw doorSpriteAssembly,AssAramus00,$8af4,oldManBrawnPents00			; 1c 
		dw headlessKnightNPC,chillSkellyAss,ddSprite00,fishSprite		; 20
		dw $0000,chillSkellyAss,oldManFr1,oldManFr1						; 24
		dw $0000,oldManFr1,$9ac7,oldManBrawnPents00					; 28
		dw $0000				; 2c 
	npcSpriteIDlist2:	
		dw oldMan3Fr2,jungLadyFr1,oldManFr2,jungLadyFr1					; 00 zombie Walk $96a0,$968b 
		dw oldManFr2,oldMan3Fr2,jungLadyFr1,jungLadyFr1					; 04
		dw jungLadyFr1,oldMan3Fr2,$968b,jungLadyFr1						; 08 $8f2e	
		dw $968b,jungLadyFr1,oldManBrawnPents01,oldMan3Fr2					; 0c 
		dw doorSpriteAssembly,oldManFr2,AssGuy,oldManFr1					; 10
		dw oldMan3Fr2,oldManFr1,AssPaul,doorSpriteAssembly					; 14
		dw jungLadyFr1,jungLadyFr1,jungLadyFr1,jungLadyFr1					; 18	
		dw doorSpriteAssembly,AssAramus01,$8af4,oldManBrawnPents01													; 1c 
		dw headlessKnightNPC,chillSkellyAss,ddSprite01,fishSprite
		dw $0000,chillSkellyAss,oldManFr2,oldManFr2
		dw $0000,oldManFr2,$9ae5,oldManBrawnPents00	
		dw $0000
	
	mainNPCStateTable: 
		dw NPCState00			; 00 init			
		dw NPCText01	   		; 00 mainText
		dw NPCStateOldMan02	   	; 00 man sells cheats
		dw NPCStateOldMan03		; 00 lady gives cheats
		dw NPCRedguy			; 01 redguy aka town wizard
		dw MoonLady				; 02
		dw RedguysBrother		; 03
		dw BarKeeper00			; 04
		dw TutorialLeady00		; 05
		dw TutorialLeady01		; 06
		dw TutorialLeady02		; 07
		dw BarKeeper02Doina		; 08	
		dw ZombieManDoina		; 09
		dw ZombieManDoinaWife	; 0a
		dw ZombieManDoinaHunter	; 0b
		dw ZombieManDoinaWifeSecond	; 0c
		dw BarManDoinaKeySeller	; 0e
		dw BuilderManDoina		; 0f
		dw door					; 10
		dw RedguyLiftingCurse   ; 11
		dw TipLeady00			; 12
		dw TipLeady01			; 13
		dw ArmorSeller			; 14
		dw ArmorSeller  		; 15
		dw Paul					; 16
		dw door2				; 17
		dw moonLadyCastle		; 18
		dw TutorialLadyControls ; 19
		dw Tinnue 				; 1a
		dw hooker				; 1b
		dw door2				; 1c
		dw aramus				; 1d 
		dw skellyHurb			; 1e
		dw NPCbossQuestGiver	; 1f	
		dw headlessNPC			; 20
		dw ChillSkelly			; 21
		dw DDnu					; 22
		dw Fish					; 23
		dw evilRedguy			; 24
		dw skellyBeforeDrac		; 25
		dw brotherBeforeDrac	; 26
		dw panikGuy				; 27 also batBa/transformed if spawned in editor 
		dw pipBat				; 28	
		dw evilRedguyEnding		; 29
		dw dungeonSkelly		; 2a
		dw afterSlogRoom		; 2b 
		dw finalBoss			; 2c 
		
	actionListMainNPC:
		dw actionSeller,actionListGivingLady 	; 01
		dw actionListRedguy						; 02
		dw actionListMoonLady					; 03
		dw actionListRedguysBrother				; 04
		dw actionListBarKeeper00				; 05
		dw actionListTutorialLeady00			; 06
		dw actionListTutorialLeady01			; 07
		dw actionListTutorialLeady02			; 08
		dw actionListBarKeeper02				; 09
		dw actionListZombieManDoina				; 0a
		dw actionListZombieManDoinaWife			; 0b
		dw actionListZombieManDoinaHunter		; 0c
		dw actionListZombieManDoinaWifeSecond	; 0d 
		dw actionListBarManDoinaKeySeller		; 0e
		dw actionListBuilderManDoina			; 0f 
		dw $0000								; 10
		dw actionRedguyLiftingCurse				; 11
		dw actionListTipLeady00					; 12
		dw actionListTipLeady01					; 13
		dw actionListArmorSeller				; 14
		dw actionListArmorSeller				; 15
		dw actionListPaul						; 16
		dw $0000								; door2 17 
		dw actionListmoonLadyCastle				; 18
		dw actionListTutorialLadyControls		; 19
		dw actionListTinnue						; 1a
		dw actionListhooker						; 1b
		dw $0000								; door2 1c 	
		dw actionListAramus						; 1d
		dw actionListSkellyHurb					; 1e 
		dw actionListNPCbossQuestGiver			; 1f 
		dw actionListHeadlessNPC				; 20
		dw actionListChillSkelly				; 21		
		dw actionListDDnu
		dw $0000
		dw actionListevilRedguy
		dw actionListSkellyBeforeDrac
		dw actionListbrotherBeforeDrac
		dw actionListBatBa
		dw $0000
		dw $0000
		dw dungeonSkellyActionScript
		dw afterSlogRoomActionScript
		dw finalBossActionScript
pushPC
org $a0c440
		db "all the game text is mostly here."
	actionSeller:
;		dw text00,goNextText
;		dw text01,goNextText
		dw text02,initCurser
		dw text03,shopRoutine
		dw text04,goNextText
		dw text05,endText
		dw textNoMoney,endText
	
	text00:
		db "DO YOU NEED     "
		db "ME TO LIFT      "
		db "THE CURSE       ",$00
	text01:
		db "I CAN DO THAT   "
		db "IF YOU CAN PAY  "
		db "ME WITH GOLD    ",$00	
	text02:
		db "I SELL STUFF TO "
		db "IMPROVE DRACULAS"
		db "DEVENDS SYSTEM  ",$00	
	text03:
		db "  1 NOTHING     "
		db "  2 BIG WHIP 20K"
		db "  3 ARMOR    15K"
		db "  4 DONATE ITEMS",$00	
	text04:	
		db "GOOD BYE SIR    ",$00
	text05:	
		db "YOU CAN COME    "
		db "BACK ANY TIME   "
		db "YOU LIKE        ",$00				
	textNoMoney:	
		db "YOU NEED MORE   "
		db "MONEY GO KILL   "
		db "MONSTERS        "
		db "GOOD BYE SIR",$00
	
	actionListGivingLady:
		dw guideMan01,goNextText
		dw guideMan02,initCurser
		dw guideMan03,giftRoutine	
		dw guideMan04,endText
		dw guideMan05,endText
		dw guideMan06,endText		

	
	guideMan01:	
		db "GOOD EVENING    "
		db "I CAN GIVE YOU  "
		db "STUFF FOR FREE",$00
		
	guideMan02:	
		db "IN CASE YOU ARE "
		db "NOT UP FOR THE  "
		db "TRUE CHELLANGE!",$00
		
	guideMan03:	
		db "  1 NOTHING     "
		db "  2 BIG WHIP    "
		db "  3 ARMORE      "
		db "  4 REMOVE CHEAT",$00

	guideMan04:
		db "GL ON YOUR RUN!",$00

	guideMan05:	
		db "THE BIG WHIP    "
		db "JUST DOES A LOT "
		db "OF DAMAGE..",00

		
	guideMan06:	
		db "PRESS L AND     "
		db "D PAD TO CHOOSE "
		db "SUBWEAPONS.",00
;		db "A FOR STOPWATCH ",$00	

	actionListRedguy:
		dw redguyText00,goNextText
		dw redguyText01,goNextText
		dw redguyText02,goNextText
		dw redguyText03,goNextText
		dw redguyText04,goNextText
		dw redguyText05,goNextText
		dw redguyText06,goNextTextWithSoundGetWhip2
		dw redguyText07,goNextText
		dw redguyText08,goNextText
		dw redguyText09,goNextText
		dw redguyText10,goNextText
		dw redguyText11,goNextText
		dw redguyText12,goNextText
		dw redguyText13,goNextText
		dw redguyText14,endText
	
	redguyText00:	
		db "HELLO WARRIOR   "
		db "YES I AM        "
		db "THE WIZARD      "		
		db "OF THE TOWN.",00	
	redguyText01:
		db "I DID COME TO   "
		db "FIND THE DRAGON."
		db "AND TAME IT!!",00
	redguyText02:		
		db "HOPFULLY NO ONE "
		db "KILLS THAT OLD  "
		db "BEAST..",00
	redguyText03:		
		db ".. WHAT IS THAT "
		db "SHINY ROCK?     "
		db "OHH.. YOU DID   "
		db "KILL IT!!",00
	redguyText04:	
		db "I HAD LIKE TO   "
		db "REVIEVE THE     "
		db "DRAGON! BUT I   "
		db "WILL NEED THE",00
	redguyText05:		
		db "DEAMON ORB! IF  "
		db "YOU GIVE ME     "
		db "THE ORB. AS A   "
		db "EXCHANGE",00 
	redguyText06:		
		db "I GIVE YOU A    "
		db "MAGIC WHIP.     "
		db "THE WHIP IS.    "
		db "EMPOWERED.",00
	redguyText07:
		db "THE WHIP LOSES  "
		db "POWER WHEN YOU  "
		db "DIE.",00
	redguyText08:
		db "THEN YOU NEED   "
		db "TO POWER IT UP  "
		db "AGAIN! OR COME  "
		db "BACK TO ME.",00
	redguyText09:
		db "PRESSING SELECT "
		db "WILL LET YOU    "
		db "SWITCH YOUR     "
		db "WHIPS.",$00
	redguyText10:
		db "WHAT I HAVE IN  "
		db "MIND WITH THE   "
		db "DRAGON?",00		
	redguyText11:	
		db "I RATHER HAVE   "
		db "IT IN MY CONTROL"
		db "THEN DRACULA    "
		db "USING IT..",00
	redguyText12:
		db "QUICK GO NORTH. "
		db "I SEND MY ALLY  "
		db "FOR SUPLIES.",00
	redguyText13:
		db "THE TOWN IS     "
		db "CURSED. EVIL    "
		db "GETS STRONGER   "
		db "EVERY MINUTE..",00	
	redguyText14:
		db "I HAVE A BAD    "
		db "FEELING.",00
;	redguyText15:	
	
	
;	redguyText08:	
;		db "MY ALLY HEADED  "
;		db "NORTH TO THE    "
;		db "NEXT TAVERN.",$00
;	redguyText09:	
;		db "I WONDER WHAT   "
;		db "HAPPEN TO HIM.  "
;		db "HE IS AWAY FOR  "
;		db "WAY TOO LONG.",$00
;	redguyText10:	
;		db "IF YOU FIND HIM "
;		db "DRUNK THEN MAKE "
;		db "US OF THAT WHIP."
;		db "TELL HIM",$00
;	redguyText11:	
;		db "THAT THE DRAGON "
;		db "IS DEAD AND WE  "
;		db "WILL NEED TO",$00
;	redguyText12:	
;		db "FIND A OTHER    "
;		db "WAY TO FIGHT    "
;		db "DRACULA.",$00

	actionListMoonLady:	
		dw MoonLadyText00,goNextText
		dw MoonLadyText01,goNextText
		dw MoonLadyText02,endText,$00
	MoonLadyText00:
		db "LOOK AT THE RED "
		db "MOON. IT IS LIKE"
		db "THIS SINCE I    "
		db "LEFT THE GRAVE",$00
	MoonLadyText01:
		db "IS IT MY FAULT? "
		db "IT STARTED WITH "
		db "THE TOWNS WIZARD"
		db "ASSISTENT.",$00
	MoonLadyText02:
		db "THAT FOOL HAD A "
		db "CRUSH ON ME. I  "
		db "NEEDED TO DO    "
		db "SOMETHING..",$00

	actionListRedguysBrother:
		dw RedguysBrotherText00,goNextText
		dw RedguysBrotherText01,goNextText
		dw RedguysBrotherText02,goNextText
		dw RedguysBrotherText03,goNextText
		dw RedguysBrotherText04,goNextText
		dw RedguysBrotherText05,endText
		
	RedguysBrotherText00:
		db "OUR WIZARD LEFT "
		db "TOWN TO GO TO   "
		db "THE CAVES.",00
	RedguysBrotherText01:
		db "THINGS GETTING  "
		db "WORSE WITHOUT   "
		db "HIM HERE.",00
	RedguysBrotherText02:	
		db "HE DID KNOW TO  "
		db "FIGHT OFF THIS  "
		db "MONSTERS..",00
	RedguysBrotherText03:
		db "THE WIZARD IS MY"
		db "BROTHER BUT..",00	
	RedguysBrotherText04:
		db ".. I AM NOTHING "
		db "LIKE HIM!!",00
	RedguysBrotherText05:
		db "WE GONA DIE !!",$00

	actionListBarKeeper00:
		dw BarKeeperText00,goNextText
		dw BarKeeperText01,goNextText
		dw BarKeeperText02,goNextTextWithSound
		dw BarKeeperText03,goNextText
		dw BarKeeperText04,goNextText
		dw BarKeeperText05,goNextText
		dw BarKeeperText06,goNextText
		dw BarKeeperText07,goNextText
		dw BarKeeperText08,goNextText
		dw BarKeeperText09,endText
		
	BarKeeperText00:
		db "I HAVE NEVER    "
		db "SEEN SOMEONE GO "
		db "OVER MY BAR LIKE"
		db "THIS!",00
	BarKeeperText01:	
		db "ARE YOU THAT    "
		db "THIRSTY? HE HE",00
	BarKeeperText02:	
		db "THIS ONE IS ON  "
		db "THE HOUSE.",00
	BarKeeperText03:
		db "UP STAIRS IS A  "
		db "HIDOUT.",00
	BarKeeperText04:	
		db "MY DAUGHTER     "
		db "LIKES TO SHOW   "
		db "YOU A VIEW      "
		db "TRICKS.",00 
	BarKeeperText05:
		db "YOU CAN GET BACK"
		db "HERE ANY TIME.  "
		db "JUST HOLD SELECT"
		db "WHILE PAUSE.",00		
	BarKeeperText06:
		db "ALSO ONCE LEVELS"
		db "ARE UNLOCKED.   "
		db "PRESS SELECT IN "
		db "THE MAP TO",00
	BarKeeperText07:	
		db "TOGGLE BETWEEN  "
		db "HARD OR NORMAL  "
		db "VERSIONS.",00
	BarKeeperText08:
		db "THE BACKDOOR    "
		db "WILL LEED YOU TO"
		db "THE GRAVYARD.",00
	BarKeeperText09:
		db "HOPFULLY YOU    "
		db "MANAGE TO LIFT  "
		db "THE CURSES      "
		db "AROUND HERE.",00

	actionListTutorialLeady00:
		dw TutorialLeadyText00,initCurser
		dw TutorialLeadyText01,setTutorialChoice
		
	
	TutorialLeadyText00:	
		db "DO A FULL SWING "
		db "ON A RING TO LET"
		db "GO AND HIT THE  "
		db "RING ABOVE.",$00
	TutorialLeadyText01:	
		db "   LET ME TRY!  "
		db "   SHOW ME HOW! "
		db "   REC          "
		db "   PLAY",$00	
	
	actionListTutorialLeady01:
		dw TutorialLeadyText02,goNextText
		dw TutorialLeadyText03,goNextText
		dw TutorialLeadyText04,goNextText
		DW TutorialLeadyTextff,initCurser
		dw TutorialLeadyText01,setTutorialChoice

;	TutorialLeadyText02:	
;		db "WHEN YOU WHIP   "
;		db "DOWN OR LIMP    "
;		db "WHIP AT THE     "
;		db "CENTER ABOVE",$00
;	TutorialLeadyText03:	
;		db "THE RING. YOU   "
;		db "CAN FLOAT STILL "
;		db "IF YOU DO NOT   "
;		db "USE THE DPAD.",$00
;	TutorialLeadyText04:	
;		db "THEN TAPING THE "
;		db "OPPOSIT SIDE ON "
;		db "THE DPAD YOU    "
;		db "LIKE TO MOVE.",$00	
	TutorialLeadyText02:
		db "WHIP DOWN ON A  "
		db "RING. TO FLOAT  "
		db "ABOVE IT!",$00
	TutorialLeadyText03:
		db "A SECRET TRICK  "
		db "IS AS LONG YOU  "
		db "DO NOT USE",$00		
	TutorialLeadyText04:
		db "THE D PAD. YOU  "
		db "FLOAT STILL.",$00
	TutorialLeadyTextff:
		db "THEN TAB THE    "
		db "OPPOSITE SIDE   "
		db "YOU LIKE TO GO.",00


	actionListTutorialLeady02:	
		dw TutorialLeadyText05,goNextText
		dw TutorialLeadyText06,goNextText
		dw TutorialLeadyText07,goNextText
		dw TutorialLeadyText08,goNextText
		dw TutorialLeadyText09,initCurser
		dw TutorialLeadyText01,setTutorialChoiceHeart
;		dw TutorialLeadyText10,spawnSmallHeartAndText
;		dw TutorialLeadyText11,endText
	
	TutorialLeadyText05:
		db "YOU CAN RING    "
		db "GLITCH WHILE ON "
		db "A RING TOO.",00

	TutorialLeadyText06:	
		db "FOR THIS PULL   "
		db "CLOSE. AT THE   "
		db "PEAK OF THE     "
		db "SWING. LET GO.",00
		
	TutorialLeadyText07:	
		db "DO A DIAGONAL   "
		db "DOWN WHIP. INTO "
		db "A DOWN WHIP.",00
	
	TutorialLeadyText08:	
		db "YOU SHOULD SIT  "		
		db "STILL ON THE    "
		db "RING.",00
	TutorialLeadyText09:	
		db "THIS SHOULD NOT "
		db "BE REQUIERT BUT "
		db "A GOOD SKILL TO "
		db "SAVE SITUATIONS.",$00
;	TutorialLeadyText10:
;		db "I DID PREPARE A "	
;		db "PARKOUR AT THE  "
;		db "GRAVYARD TO     "
;		db "PRACTICE MORE.",$00
;	TutorialLeadyText11:
;		db "GOOD LUCK AND   "	
;		db "HAVE FUN TO     "
;		db "MASTER YOUR     "
;		db "WHIP SKILLS.",$00	
	
	actionListTutorialLadyControls:
		dw textControlLady00,goNextText
		dw textControlLady01,initCurser
		dw textControlLady02,switchControlls 
		dw textControlLady03,endText
	
	textControlLady00:
		db "IF YOU ARE NOT  "
		db "HAPPY WITH THE  "
		db "CONTROLS!",00
	textControlLady01:
		db "I CAN SWITCH SO "
		db "RIGHT IS RIGHT  "
		db "AND LEFT IS LEFT",00
	textControlLady02:
		db "   ORGINAL      "
		db "   LOGIC CONTROL",$00
	textControlLady03:
		db "COME BACK ANY   "
		db "TIME!",00	
	
	
	actionListBarKeeper02:
		dw BarKeeper02Text00,goNextText
		dw BarKeeper02Text01,goNextText
		dw BarKeeper02Text02,goNextText
		dw BarKeeper02Text03,endText
		dw BarKeeper02Text04,goNextText
		dw BarKeeper02Text05,endText
		
	BarKeeper02Text00:
		db "THANKS FOR THE  "
		db "HELP. HE HAS    "
		db "TERRORIESED US  "
		db "FOR A WHILE.",$00
	BarKeeper02Text01:
		db "DEAT AND ALIVE. "
		db "HAHA.. WELL     "
		db "EVER SINCE THIS "
		db "GUY SHOWED UP",$00
	BarKeeper02Text02:
		db "WE GOT MORE     "
		db "PROBLEMS. OUR   "
		db "HUNTER KNOWS    "
		db "MORE. BUT HE",$00
	BarKeeper02Text03:
		db "GOT WUNDED BY A "
		db "ZOMBIE. HE ALSO "
		db "HAS THE KEY FOR "
		db "THE DOOR BEHIND.",$00
	BarKeeper02Text04:
		db "I GUESS THERE   "
		db "WAS NOTHING THAT"
		db "COULD HAD SAVED."
		db "HIM.",$00
	BarKeeper02Text05:
		db "NO KEY BUT USE  "
		db "THE NEW WHIP ON "
		db "THE DOOR. GOOD  "
		db "LUCK OUT THERE.",$00		
		
			
	actionListZombieManDoina:
		dw ListZombieManDoinaText00,endText

	ListZombieManDoinaText00:
		db "RUN RUN !!!!    "
		db "I WILL TURN INTO"
		db "A ZOMBIE SOON.",$00

	actionListZombieManDoinaWife:
		dw ZombieManDoinaWifeText00,goNextText
		dw ZombieManDoinaWifeText01,endText
		
	ZombieManDoinaWifeText00:
		db "MOST OF US ARE  "
		db "HIDDEN. OUR     "
		db "DEAD MASTER     "
		db "ROWDIN IS ON",$00
	ZombieManDoinaWifeText01:
		db "THE WAY. HE     "
		db "WILL FIND AND   "
		db "TAKE US ALL..",$00
		
	actionListZombieManDoinaHunter:
		dw ZombieManDoinaHunterText00,goNextText
		dw ZombieManDoinaHunterText01,goNextText
		dw ZombieManDoinaHunterText02,goNextText
		dw ZombieManDoinaHunterText03,goNextText
		dw ZombieManDoinaHunterText04,goNextTextGetSecondWhip
		dw ZombieManDoinaHunterText05,goNextText
		dw ZombieManDoinaHunterText06,goNextText
		dw ZombieManDoinaHunterText07,goNextText
		dw ZombieManDoinaHunterText08,endTextAndTransform
		
		
	ZombieManDoinaHunterText00:		; 0c 
		db "GUESS YOU LIKE  "
		db "TO KNOW WHAT IS "
		db "GOING ON. THIS  "
		db "GUY WHO ARRIVED ",$00	
	ZombieManDoinaHunterText01:	
		db "SEEMED TO BE A  "
		db "POOR SOUL. STILL"
		db "HE DOES EAT OUT "
		db "OF THE DEVILS",$00
	ZombieManDoinaHunterText02:		
		db "HAND! HE DOMED  "
		db "US HERE WITH HIS"
		db "BLIND ACTIONS!",00
	ZombieManDoinaHunterText03:		
		db "HE IS ON THE WAY"
		db "TO THE CASTLE.  "
		db "HE HAS OUR      "
		db "DEAMON ORBS..",$00
	ZombieManDoinaHunterText04:		
		db "STOP HIM PLEASE "
		db "I LOST THE KEY  "
		db "TAKE THIS WHIP. "
		db "BREAK DOWN THE",$00
	ZombieManDoinaHunterText05:		
		db "DOOR AND USE THE"
		db "PASSAGE. IT WILL"
		db "LEAD TO THE     "
		db "CASTLE.",$00
	ZombieManDoinaHunterText06:		
		db "KILL ME BEFORE  "
		db "I DO SOMETHING  "
		db "TO MY FAMELIE.  "
		db "AHHHH..",$00
	ZombieManDoinaHunterText07:		
		db "IT TAKES OVER   "
		db "MY NIGHTMARES   "
		db "BECOME LUST.",$00
	ZombieManDoinaHunterText08:		
		db "SOON I AM A     "
		db "OTHER MARIONAT  "
		db "OF THE DEVIL.",$00
	

	actionListZombieManDoinaWifeSecond:	
		dw ZombieManDoinaWifeSecondText00,goNextText
		dw ZombieManDoinaWifeSecondText01,goNextText
		dw ZombieManDoinaWifeSecondText02,endText
		dw ZombieManDoinaWifeSecondText03,goNextText
		dw ZombieManDoinaWifeSecondText04,endTextSimonHurt
		dw ZombieManDoinaWifeSecondText05,endTextSimonHurt
		
	ZombieManDoinaWifeSecondText00:
		db "WE NEED TO FIND "
		db "A CURE FOR MY   "
		db "MAN.. PLEASE HE "
		db "MEANS EVERYTHING",$00
	ZombieManDoinaWifeSecondText01:	
		db "TO ME. HE WAS   "
		db "HUMBLE AND DID  "
		db "BRING LOVE IN   "
		db "DARK TIMES.",$00
	ZombieManDoinaWifeSecondText02:
		db "WE MIGHT NOT    "
		db "MAKE IT WITHOUT "
		db "HIM.. PLEASE .. "
		db "UAHHH HA.. CRY..",$00
	
	ZombieManDoinaWifeSecondText03:
		db "THIS IS A WEAPON"
		db "MY MAN USED TO  "
		db "PROTECT US!!",$00	
	ZombieManDoinaWifeSecondText04:
		db "YOU MONSTER YOU "
		db "KILLED HIM!!",$00
	ZombieManDoinaWifeSecondText05:
		db "STOP KILLING HIM"
		db "OVER AND OVER   "
		db "WILL NOT HELP!!",$00
		
		
	actionListBarManDoinaKeySeller:
		dw BarManDoinaText00,goNextText
		dw BarManDoinaText01,goNextText
		dw BarManDoinaText02,goNextText
		dw BarManDoinaText03,initCurser
		dw BarManDoinaText04,shopRoutineKey
		dw BarManDoinaText05,endText
		dw BarManDoinaText06,endText
		dw textNoMoney,endText
		dw BarManDoinaText07,endText
	
	BarManDoinaText00:
		db "HELLO WELCOME   "
		db "DID YOU NOTICE  "
		db "THE SKELLETON   "
		db "UNDER THE TABLE?",$00
	BarManDoinaText01:	
		db "HE WENT TO THE  "
		db "CASTLE BUT DID  "
		db "NOT SAY A WORD  "
		db "SINCE HE IS BACK",$00
	BarManDoinaText02:	
		db "THEN HIS FLASH  "
		db "BURNED AWAY FROM"
		db "THE SUNLIGHT... "
		db "IN HIS REMAINS",$00
	BarManDoinaText03:	
		db "WE FOUND THIS   "
		db "KEY. I SELL IT  "
		db "SO I CAN MAKE UP"
		db "SOME DEPTS.",$00
	BarManDoinaText04:
		db "   NO KEY       "
		db "   YES 5000 GOLD",$00
	BarManDoinaText05:	
		db "COME BACK IF YOU"
		db "DECIDE OTHERWISE",00
	BarManDoinaText06:	
		db "NO CLUE WHERE IT"
		db "MIGHT FIT.",00
	BarManDoinaText07:
		db "OHH I SOLD IT.. "
		db "TO SOMEONE THAT "
		db "JUST LOOKS LIKE "
		db "YOU..",00
	
	
	actionListBuilderManDoina:	
		dw BuilderManDoinaText00,goNextText
		dw BuilderManDoinaText01,goNextText
		dw BuilderManDoinaText02,goNextText
		dw BuilderManDoinaText03,goNextText
		dw BuilderManDoinaText04,endText,$00
		
	BuilderManDoinaText00:
		db "I CLOSED UP SOME"
		db "HOLES.. NOW THE "
		db "MONSTERS COME   "
		db "THROUGH SLOWER",$00		
	BuilderManDoinaText01:
		db "THE OTHER DAY   "
		db "I DID SEE A ROCK"
		db "GOLEM NOT FAR   "
		db "FROM HERE AS",$00	
	BuilderManDoinaText02:
		db "I WAS COLLECTING"
		db "STONES..        "
		db "I DID THROW A   "
		db "ROCK..",$00
	BuilderManDoinaText03:	
		db "IT SEEMED NOT   "
		db "TO LIKE IT!!    "	
		db "BUT A WHIP WOULD"
		db "NOT EVEN MAKE",$00
	BuilderManDoinaText04:
		db "A SCRATCH!!     "
		db "EVEN METAL IS   "
		db "NOT AS HARD AS  "
		db "HIS SKIN!!",$00
;	BuilderManDoinaText01:
;		db "I DID USE A SPY "
;		db "GLASS TO LOOK AT"
;		db "THE CASTLE. I   "
;		db "WONDER HOW IT",$00
;	BuilderManDoinaText02:	
;		db "STAND AT ALL    "
;		db "THAT MANY HOLES "
;		db "IT HAS.",$00
;	BuilderManDoinaText03:	
;		db "SOMETHING LIFING"
;		db "IN THE WALLS    "
;		db "UP THERE TO KEEP"
;		db "IT STANDING..",$00
	
	actionListTinnue:
		dw textTinnue00,goNextText
		dw textTinnue01,endText
	
	textTinnue00:
		db "MY SHEEP DID EAT"
		db "ALL MY COFFEE   "
		db "BEENS!",00
	textTinnue01:
		db "NOW IT WONT STOP"
		db "BOUNCING HAHA.. "
		db "WUAHA.. CRY CRY "
		db "MY COFFEE!!",00
	actionListhooker:
		dw textHooker00,goNextText
		dw textHooker01,goNextText
		dw textHooker02,spawnSmallHeartAndText
	textHooker00:
		db "IT IS HARD TO   "
		db "GET PAUL AWAY   "
		db "FORM WOW THIS   "
		db "DAYS..",00
	textHooker01:
		db "HIS CASTLEVANIA "
		db "ADDICTION COULD "
		db "USE SOME WHIPING"
		db "ACTION.",00
	textHooker02:
		db "BACK IN THE DAYS"
		db "I TOOK MY WHIP  "
		db "OUT AND HE WAS  "
		db "ALL MINE!",00		
		
	
	actionRedguyLiftingCurse:
		dw liftCurseText00,liftCurse
		dw liftCurseText01,goNextText
		dw liftCurseText02,goNextText
		dw liftCurseText03,goNextText
		dw liftCurseText04,goNextText
		dw liftCurseText05,goNextText
		dw liftCurseText06,goNextText
		dw liftCurseText07,goNextText
		dw liftCurseText08,goNextText
		dw liftCurseText09,endText

	liftCurseText00:		
		db "DID MY OLD LADY "
		db "BOTHER YOU?     "
		db "I CAN LIFT THE  "
		db "CURSE.",$00
	liftCurseText01:		
		db "HOW AM I HERE   "
		db "BEFORE YOU?     "
		db "THERE IS A PATH "
		db "FROM THE CAVE..",$00	
	liftCurseText02:		
		db "I DID HEAR THAT "
		db "ROWDIN MARCH THE"
		db "LAND AND GOT A  "
		db "GOOD IDEA OF",$00
	liftCurseText03:		
		db "WHAT HAPPEN. I  "
		db "DID SEE THAT MY "
		db "ALLY IS HOSTAG  "
		db "IN THE DUNGEON.",$00	
	liftCurseText04:		
		db "HE WAS GOOD BUT "
		db "SEEKING LOVE WAS"
		db "HIS DOWNFALL. HE"
		db "SEEMED NOT TO",$00	
	liftCurseText05:		
		db "TELL APART FROM "
		db "A DEAMON OR A   "
		db "LOVLY WOMAN..",$00
	liftCurseText06:		
		db "BETTER LEAVE HIM"
		db "THERE IF YOU DO "
		db "NOT SEEK MORE   "
		db "TROUBLE.",$00
	liftCurseText07:		
		db "TO DEFEAT DRAC  "
		db "YOU NEED TO FIND"
		db "AS MANY DEAMON  "
		db "ORBS AS YOU CAN.",$00
	liftCurseText08:	
		db "I NEED THEM TO  "
		db "EMPOWER YOUR    "
		db "WHIP.",$00
	liftCurseText09:
		db "ELSE YOU MIGHT  "
		db "NOT VANQUISH    "
		db "DRACULA AT ALL..",$00	
		
	actionListTipLeady00:
		dw oneFrameText00,goNextText
		dw oneFrameText01,endText		
	oneFrameText00:
		db "DID YOU KNOW    "
		db "HOLDING THE JUMP"
		db "BUTTON FOR ONLY "
		db "ONE OR TWO",$00 
	oneFrameText01:
		db "FRAMES WILL MAKE"
		db "YOUR JUMP       "
		db "SHORTER.",$00 
	
	afterSlogRoomActionScript:
		dw afSlogText00,goNextText
		dw afSlogText01,goNextText
		dw afSlogText02,goNextText
		dw afSlogText03,goNextText
		dw afSlogText04,goNextText
		dw afSlogText05,goNextText
		dw afSlogText06,endText

	afSlogText00:
		db "I CANT STOP TO  "
		db "SPY AROUND THIS "
		db "CASTLE!!",00
	afSlogText01:
		db "A BON VOYAGE    "
		db "FOR YOU FROM    "
		db "A GUY WHO       "
		db "JOGGED BY HERE..",00
	afSlogText02:
		db "HE MAY LEAVE A  "
		db "STRANGE GIFT    "
		db "AT THE GATE AS  "
		db "HE LEAFES.",00
	afSlogText03:
		db "TRUE EVIL IS NOT"
		db "IN THIS CASTLE! "
		db "BUT ORIGINATES  "
		db "FROM TOWN!",00
	afSlogText04:	
		db "LAY FOGGY SIGHT "
		db "AT SOME CRIME   "
		db "SCENE IN TOWN   "
		db "AND FOLLOW",$00
	afSlogText05:	
		db "THE LEAD..",00
	afSlogText06:	
		db "BE CAREFULL!!",00
	
	
	actionListTipLeady01:
		dw whipText00,goNextText
		dw whipText01,goNextText
		dw whipText02,goNextText
		dw whipText03,goNextText
		dw whipText04,goNextText
		dw whipText05,goNextText		
		dw whipText06,endText	
	
	whipText00:
		db "IT IS GETTING   "
		db "DARK REALLY     "
		db "QUICK HERE..",00
	whipText01:		
		db "YOU GOT MY      "
		db "BROTERS WHIP?   "
		db "THE LEATHER     "		
		db "WHIP IS",00 	
	whipText02:	
		db "BETTER SUITER   "
		db "FOR PLATFORMING.",00		

	whipText03:
		db "FULLY EXTANDED  "
		db "THE LATHER WHIP "
		db "ALLIGNES WELL",00
	whipText04:
		db "TO MOVE FROM ONE"
		db "RING TO A OTHER.",00
	whipText05:	
		db "ALSO LOOK UP    "		
		db "THIS TREE. HAVE "
		db "YOU EVER SEEN   " 
		db "A TREE",00
	whipText06:
		db "THIS TALL!!?    "
		db "I WONDER WHAT IS"
		db "ON TOP OF IT?",00

	actionListArmorSeller:
		dw armorText00,goNextText
		dw armorText01,initCurser
		dw armorText02,shopArmor
		dw armorText03,endText
		dw textNoMoney,endText
		dw textNoMoney,endText
		
	armorText00:		
		db "I WISH I COULD  "
		db "UPGRADE YOUR    "
		db "ARMOR.",00
	armorText01:		
		db "BUT ALL I CAN DO"
		db "GIVING IT A     "
		db "FRESH PAINT. IF "
		db "YOU HAVE GOLD.",00			
	armorText02:
		db "  1 NOTHING     "
		db "  2 RUBY    2000"
		db "  3 EMEROLD 2000"
		db "  4 DIAMOND 2000",00	
	armorText03:		
		db "THANKS COME     "
		db "BACK ANY TIME",00
	
	actionListPaul:
		dw paulText00,goNextText
		dw paulText01,goNextText
		dw paulText02,goNextText
		dw paulText03,endText
		
	paulText00:
		db "HEY PAUL WHY    "
		db "DID YOU MOVE TO "
		db "DRCULAS GOLD    "
		db "CHAMBER?",00
	paulText01:
		db "OHH NO MONEY    "
		db "ISSUES ANYMORE..",00
	paulText02:
		db "SORRY I DO NOT  "
		db "NEED A WOW      "
		db "CLASSIC GUIDE   "
		db "RIGHT NOW..",00
	paulText03:
		db "BUT I CAN COME  "
		db "BACK WHEN THE   "
		db "CURSE ARE LIFTED"
		db "AROUND HERE.",00
		
	actionListmoonLadyCastle:
		dw moon2Text00,goNextText
		dw moon2Text01,goNextText
		dw moon2Text02,goNextText
		dw moon2Text03,goNextText
		dw moon2Text04,goNextText
		dw moon2Text05,goNextText
		dw moon2Text06,goNextText
		dw moon2Text07,goNextText	
		dw moon2Text08,goNextText	
		dw moon2Text09,goNextText	
		dw moon2Text0a,endText
		
	moon2Text00:
		db "THE MOON TURNED "
		db "WHITE AGAIN SOON"
		db "AFTER YOU LEFT.",00
	moon2Text01:
		db "I DO NOT FEAR   "
		db "VAMPIRES. I OWN "
		db "THE BIGGEST",00
	moon2Text02:
		db "GARLIC PLANTAGE "
		db "IN TRANSELFANIA."
		db "WE DO SELL",00
	moon2Text03:	
		db "VAMPIRE VACCIN  "		
		db "OR DESIRE. WHAT "
		db "EVER FITS YOUR  "
		db "NEED.",00
	moon2Text04:	
		db "ABOUT THE GUY..",00			
	moon2Text05:
		db "HE IS MARKED AND"
		db "HE WILL TURNE   "
		db "INTO A VAMPIRE.",00
	moon2Text06:
		db "DO NOT TRY TO   "
		db "SAVE HIM. IT IS "
		db "A TRAP.",00 		
	moon2Text07:
		db "THE ONLY THING  "
		db "TO FIND DOWN    "
		db "THERE..",00 
	moon2Text08:	
		db "IS YOUR DEATH!!",00
	moon2Text09:	
		db "JUST GO AFTER   "
		db "THE COUNT AS    "
		db "LONG HE DOES",00	
	moon2Text0a:
		db "NOT GROW TOO    "
		db "POWERFULL..     "
		db "WE NEED YOU     "
		db "ALIVE!!",00
	

	actionListAramus:
		dw crossText00,goNextText
		dw crossText01,initCurser
		dw crossText02,crossDowngradeUpgrade
		dw crossText03,endText
		dw crossText04,endText
		
	crossText00:
		db "I AM A BELMONT  "
		db "TOO. THEY CALL  "
		db "ME ARAMUS.",00	
		
	crossText01:
		db "DO YOU TRUST    "
		db "THE CROSS?",00
	
	crossText02:
		db "  YES STRONGEST "
		db "  SUBWEAPON!!   " 
		db "                "
		db "  NO! IT IS EVIL",00	
	
	crossText03:
		db "THE CROSS IS    "
		db "EVIL!",00

	crossText04:
		db "I RECOMMAND NOT "
		db "USING THE CROSS "
		db "AT ALL. JUST TO "
		db "BE SAVE.",00

	actionListSkellyHurb:
		dw hurbText00,goNextText
		dw hurbText01,goNextText
		dw hurbText02,goNextText
		dw hurbText03,transForm2Skelly	
	
	hurbText00:
		db "A BELMONT! WELL "
		db "SINCE YOU ARE   "
		db "HERE I GUESS YOU"
		db "LOOK FOR CURE.",00		
	hurbText01:
		db "I HAVE A HURB TO"
		db "MAKE ZOMBIES ACT"
		db "LIKE A HUMAN    "
		db "AGAIN HEHEHA!!",00
	hurbText02:
		db "BUT IT WILL COST"
		db "YOUR LIFE! HE HE"
		db "HAR HA HA!",00 
	hurbText03:
		db "WHAT YOU HAVE   "
		db "INVINITE LIFES? "	
		db "LET ME TEST     "
		db "THAT!!",00	
			
	actionListNPCbossQuestGiver:
		dw questText00,goNextText	
		dw questText01,giveLeash
		dw questText02,goNextText	
		dw questText03,goNextText	
		dw questText04,endText	
		
	questText00:
		db "THEY VANISHED!  "
		db "BEEN A STRANGE  "
		db "COPPLE..",00 
	questText01:
		db "HERE IS A DOG   "
		db "LEASH. NOW YOU  "
		db "CAN MANAGE YOUR " 
		db "ANNOYING DOG!",00 
	questText02:
		db "PRESS L ONCE OR " 
		db "TWICE TO WRAP   "
		db "YOUR DOG. LIKE  "
		db "THIS HE",00
	questText03:
		db "HE WILL NOT     "
		db "BOTHER YOU WHILE"
		db "FIGHTING.",00 		
	questText04:
		db "DO IT AGAIN WHEN"
		db "YOU MISS THE    "
		db "FURRY COMPANION.",00		
	
	actionListHeadlessNPC:
		dw headlessText00,goNextText						; goNextTextSetBGMode2	
		dw headlessText01,goNextText
		dw headlessText02,goNextText
		dw headlessText03,goNextText
		dw headlessText04,goNextText
		dw headlessText05,goNextText
		dw headlessText06,goNextText
		dw headlessText07,endText
	
	headlessText00:	
		db "SHOOT!! GRANDPAA"
		db "IS IT YOU?",00		
	headlessText01:
		db "DO NOT STEP ON  "
		db "MY HEAD! IT IS  "		
		db "HAVING A DRINK  "
		db "SOMEWHERE..",00
	headlessText02:
		db "WE LOOK FOR THAT"
		db "BELMONT GUY. HE "
		db "IS CRAZY STRONG!"
		db "I DID SEE HIM.",00
	headlessText03:
		db "SWING AROUND A  "
		db "RING AND THE    "
		db "CLOSER HE IS TO "
		db "THE PEAK",00
	headlessText04:	
		db "THE HIGHER HE   "
		db "LUNCHES IN THE  "
		db "AIR AGAIN!",00
	headlessText05:	
		db "HIS LEFT SIDE   "
		db "SWING IS A LOT  "
		db "WEAKER THOUGH..",00	
	headlessText06:	
		db "BUT ON THE RIGHT"
		db "HE SEEMS TO     "
		db "SLING AROUND",00
	headlessText07:		
		db "PLATFORMS. LIKE "
		db "A NINJA.",00	
	
	actionListChillSkelly:
		dw chillText00,goNextText
		dw chillText01,goNextText
		dw chillText02,goNextText
		dw chillText03,goNextText
		dw chillText04,endText
		dw chillText05,goNextText
		dw chillText06,endText
	
	chillText00:
		db "EVEN A HUMAN CAN"
		db "GO THROUGH A    "
		db "SOLID WALL!",00
	chillText01:	
		db "ONCE YOU ARE IN "
		db "IT LOOK AT THE  "
		db "OPPOSIT SIDE..",00
	chillText02:
		db "AND ZIIP SEE YOU"
		db "ON THE OTHER    "
		db "SIDE! HAH HA HA!",00	
	chillText03:
		db "SOME ALSO SAY   "
		db "IF YOU DUCK IN  "
		db "THE GRASS YOU   "
		db "FLY LIKE MY ASS.",00
	chillText04:
		db "JOKES ASIDE.. IF"
		db "YOU PRESS DOWN  "
		db "AND JUMP YOU CAN"
		db "LAND A COFFINE!",00		
	chillText05:
		db "GET THAT DOG    "
		db "AWAY FROM ME!!",00
	chillText06:
		db "OK NOW LETS     "
		db "ESCAPE BEFORE HE"
		db "GETS BACK!!",00

	actionListDDnu:
		dw ddText00,goNextText	
		dw ddText01,goNextText	
		dw ddText02,goNextText	
		dw ddText03,endText	
		dw ddText04,goNextText
		dw ddText05,endText
		dw ddText06,goNextText
		dw ddText07,goNextText
		dw ddText08,goNextText
		dw ddText09,goNextText
		dw ddText0A,endText
		
	ddText00:
		db "THE DRACONIC GOD"
		db "FOOLED ME!      "
		db "I TRY TO GET A  "
		db "SECRET PIZZA",00
	ddText01:	
		db "RECEPIE BUT HE  "
		db "STARTED TO EAT  "
		db "SNOWFLAKES..", 00		
	ddText02:	
		db "HELP ME TO GET  "
		db "HIS ATTATION!!",00
	ddText03:
		db "YOUR LEATHER    "
		db "WHIP LOOKS LIKE "
		db "A BIG WORM!     "
		db "HMMM...",00

	ddText04:
		db "OHH SHIT!! YOU  "
		db "MADE HIM ANGRY  "
		db "GO I TRY TO CALM"
		db "HIM DOWN.",00		
	ddText05:
		db "I SHARE THE     "
		db "SECRET WITH YOU "
		db "WHEN YOU COMPLET"
		db "THE PARKOURE!",00			

	ddText06:
		db "TO SPICY UP THE "
		db "DOUGH USE BBQ   "
		db "SOUCE.",00
	ddText07:
		db "SMOKIN STAMPEDE "
		db "BEER 8 CHIPOTLE "
		db "IS DRACONIANS   "
		db "FAVORITE!",00
	ddText08:
		db "THAT MIGHT SPICY"
		db "UP YOUR WHIP    "
		db "TOO.. BUT!",00
	ddText09:
		db "YOU ARE A VIEW  "
		db "CENTERIES TO",00
	ddText0A:
		db "JUNG FOR THIS   "
		db "KIND OF MAGIC.",00
	
	actionListevilRedguy:
		dw evilText00,goNextText	
		dw evilText01,goNextText
		dw evilText02,goNextText
		dw evilText03,evilRedguyEndingCheck
		dw evilText04,goNextText		
		dw evilText05,endText	
		dw evilGoodText00,engageWizzardAction
		dw evilGoodText01,goNextText 	
		dw evilGoodText02,changeSpritesBatBa	
		dw evilGoodText03,endText
	evilText00:
		db "IT IS ABOUT TIME"
		db "TO MAKE IT HERE."
		db "DAWN AWAITS IN  "
		db "A VIEW HOURS.",00
	evilText01:
		db "WE DO NOT WANT  "
		db "DRACULA TO      "
		db "ESCAPE AS HIS   "
		db "FORCES WEAKEN!",00
	evilText02:
		db "DID YOU GET SOME"
		db "ORB? VERY GOOD  "
		db "GIVE THEM TO ME "
		db "SO I CAN..",00	
	evilText03:
		db "PREPARE YOU FOR "
		db "THE LAST BATTLE!"
		db "SNACK!!...",00
	evilText04:
		db "MUAHH HAHA HAR!!"
		db "THANKS BELMONT.."		
		db "NOW THERE IS",00	
	evilText05:
		db "NOTHING IN THE  "
		db "WAY TO STOP ME! "				
		db "JUST GO DIE MY  "
		db "FOOL!!",00	

	evilGoodText00:
		db "HUU? FLUFFY ORB!"
		db "NO!! DOG!!!",00
	evilGoodText01:	
		db "GET AWAY WITH   "
		db "THAT MONSTER IT "				
		db "MESSES WITH MY  "
		db "SPELLS!",00	
	evilGoodText02:	
		db "AAAAAHHH NOT!!  "
		db "NOT THAT SPELL!!",$00				
	evilGoodText03:
		db "ZZZH!! WOOOSH!! " 
		db "I HATE THE      "
		db "SMELL OF EVIL   "
		db "WIZZARDS!!",00
	
		
	actionListSkellyBeforeDrac:
		dw skellyBeforeDrac00,goNextText	
		dw skellyBeforeDrac01,goNextText	
		dw skellyBeforeDrac02,goNextText	
		dw skellyBeforeDrac03,goNextText
		dw skellyBeforeDrac04,endText			
		
	skellyBeforeDrac00:
		db "HAR HAR HAR..   "
		db "YOU WILL NEVER  "
		db "FIND OUR MASTER.",00
	skellyBeforeDrac01:
		db "BUT YOU MIGHT   "
		db "STUMBLE UP ON   "
		db "HIM. WHEN YOU",00
	skellyBeforeDrac02:	
		db "YOU ARE NOT	    "
		db "LOCKING?  HE HE "	
		db "HAR HAR HAR..",00
	skellyBeforeDrac03:
		db "DO A MOONWALK   "
		db "FOR ME. HOLD THE"
		db "A BUTTON AND    "
		db "DANCE! PLEASE?.",00
	skellyBeforeDrac04:	
		db "ELSE I MAKE YOU "
		db "KNEEL BEFORE ME!"
		db "HAR HAR HAR..",00
	
	actionListbrotherBeforeDrac:
		dw brotherBeforeDrac00,goNextText
		dw brotherBeforeDrac01,goNextText
		dw brotherBeforeDrac02,goNextText
		dw brotherBeforeDrac03,goNextText
		dw brotherBeforeDrac04,endText
		dw brotherBeforeDrac01,goNextText
		dw brotherBeforeDrac05,goNextText
		dw brotherBeforeDrac06,endText

		
	brotherBeforeDrac00:	
		db "THAT SKELLY HAD "
		db "TOO MUCH WINE.",00
	
	brotherBeforeDrac01:
		db "I HAD NO IDEA   "
		db "THAT MY BROTHER "
		db "IS THAT EVIL!",00
	
	brotherBeforeDrac02:		; STORRY CHICES SETUP.. 
		db "HE SEEMS TO BE  "
		db "AFRAID OF DOGS. "	
		db "MIGHT HAVE BEEN "
		db "A HINT!",00
	
	brotherBeforeDrac03:
		db "I THINK WHEN YOU"
		db "LOOK DOWN THE   "
		db "CORDIDOR WHILE  "
		db "WALKING.",00
	
	brotherBeforeDrac04:
		db "YOU WARP        "
		db "BETWEEN A       "
		db "OTHER CASTLE.",00			
	
	brotherBeforeDrac05:		; STORRY CHICES SETUP.. 
		db "THANKS!",00		
	brotherBeforeDrac06:
		db "NOW THE ONLY    "
		db "ORTHER EVIL     "
		db "SEEMS DRACULA!",00 
	actionListBatBa:
		dw batBa00,goNextText
		dw batBa01,spawnPipNextText
		dw batBa02,goNextText
		DW batBa02_HALF,goNextText
		dw batBa03,goNextText
		dw batBa04,goNextText
		dw batBa05,goNextText
		dw batBa06,goNextText
		dw batBa07,goNextText
		dw batBa08,goNextText
		dw batBa09,endText 
	batBa00:
		db "THAT BASTARD OF "
		db "A WIZZARD TURNED"
		db "INTO A ORB AND  "
		db "EXCAPED!",$00
	batBa01:
		db "I AM A BATBARIAN"
		db "BAT.. WHY ARE   "
		db "YOU SO BIG?",$00 
	batBa02:	
		db "WHERE IS PIP MY "
		db "BAT? THERE SHE  "
		db "IS!",00
	batBa02_HALF:	
		db "SHE SEEMS TO    "
		db "LIKE YOU!",$00 
	batBa03:	
		db "I WOULD LIKE TO "
		db "TELL YOU A STORY"
		db "BUT THEN..",$00
	batBa04:	
		db "I DO NOT TRUST  "
		db "A MAN WITH A    "
		db "WHIP AND NO     "
		db "PENTS!",00
	batBa05:	
		db "THAT TELEPORT   "
		db "SPELL.. I NEED  "
		db "THE ORB..",00
	batBa06:	
		db "THEN I MIGHT BE "
		db "ABLE TO REVERSE "
		db "IT AND INPRSION",00		
	batBa07:	
		db "THE WIZZARD IN  "
		db "THIS RUNIC      "
		db "DEAMON ORB!",00	
	batBa08:	
		db "THEN SEALE IT   "
		db "AND HIS POWERS  "
		db "AWAY.",00		
	batBa09:
		db "PIP WILL CARRY  "
		db "THE ORB TO ME   "
		db "IF YOU CATCH IT!",$00	
	
	dungeonSkellyActionScript:
		dw dungeonSkelly00,goNextText
		dw dungeonSkelly01,goNextText
		dw dungeonSkelly02,goNextText
		dw dungeonSkelly03,goNextText
		dw dungeonSkelly04,goNextText
		dw dungeonSkelly05,goNextText
		dw dungeonSkelly06,goNextText
		dw dungeonSkelly07,goNextText
		dw dungeonSkelly08,endText
	
	dungeonSkelly00:
		db "I AM DOOMED!!!  "
		db "QUIET LITTERERLY"
		db "HE STUFFED ME   "
		db "IN HERE..",$00
	dungeonSkelly01:
		db "THEN HE ESCAPED "
		db "HE TOLD ME I CAN"
		db "USE HIS BRAIN!",00
	dungeonSkelly02:
		db "SINCE I LOST    "
		db "MINE QUITE SOME "
		db "TIME AGO.",$00
	dungeonSkelly03:
		db "THEN HE USED HIS"
		db "FEET. GRABED A  "
		db "BONE TO BURST   "
		db "THE LOCK..",00
	dungeonSkelly04:	
		db "MAN I WISH I HAD"
		db "HIS LEGS TOO..",00
	dungeonSkelly05:
		db "SOOO FAST!!!",00	
	dungeonSkelly06:	
		db "YEHA I LOST THEM"
		db "TOO.. STOLEN!!! "
		db "THAT BASTARD IN "
		db "THE SWAMP AREA..",00
	dungeonSkelly07:
		db "TO FIND HIM GET "
		db "A LIFT FROM A   "
		db "BAT IN THE WET  "
		db "FEET TOUR.",00
	dungeonSkelly08:	
		db "IN THE TOP LEFT "
		db "IS A SECRET PATH"
		db "TO HIS HIDEOUT!!",00
		
	finalBossActionScript:	
		dw finalBossText00,goNextText
		dw finalBossText01,goNextText
		dw finalBossText02,goNextText
		dw finalBossText03,goNextText
		dw finalBossText04,goNextText
		dw finalBossText05,goNextText
		dw finalBossText06,goNextText
		dw finalBossText07,endTextMakeHitable
		
	finalBossText00:
		db "MEGALOVANIA     "
		db "MUSIC STARTS    "
		db "PLAYING!",00
	finalBossText01:
		db "SIMON FORMS INTO"			; I AM NOT MOTIVATED ATT ALL TO FINISH THIS SO.. WHY NOT!!
		db "A HEART AND     "
		db "MOVES INTO THE  "			; THE IDEA IS TO MAKE A BOX AND TURN SIMON INTO A HEART TO DODGE THIGNS.. 
		db "TEXT BOX!",00	
	finalBossText02:
		db "THEN SURVIVE..  "
		db "FIND OUT THAT   "	
		db "THIS LADY IS A  "
		db "GREEDY BEAST!",00
	finalBossText03:
		db "EVEN MADE SOME  "
		db "CONTRACT WITH   "
		db "DRACULA..",00
	finalBossText04:
		db "THE TOWNS ARE   "
		db "STILL DOOMED IF "	
		db "WE CAN NOT PUT  "
		db "A END TO IT!!",00		
	finalBossText05:
		db "SORRY FOR NOT   "
		db "FLASHING THIS   "
		db "GAME OUT..",00 	
	finalBossText06:
		db "BUT I DO NOT    "
		db "LIKE WRITING    "
		db "ASSEMBLY..      "
		db "ALL WEEK AGAIN..",00 
	finalBossText07:
		db "WHY DO WE NOT   "
		db "REPLAY          "
		db "UNTDERTALE      "
		db "INSTEAD?",00 


		
warnPC $a0ffc0	
pullPC 		
}
	
	
{	; Shop and Text Routines ----------------------------------------------------------
	
	curserPos:
		lda $36,x 
		and #$00ff
		beq ++
		
		tay  			
		lda #$0000				; clear old Curser
		sta $7fff00
		sta $7fff20
		sta $7fff40
		sta $7fff60
		
		lda #$2c27 				; 2c2e set Curser
		cpy #$0001
		bne skipLine01
		sta $7fff00
	skipLine01:
		cpy #$0002
		bne skipLine02
		sta $7fff20		
	skipLine02:
		cpy #$0003
		bne skipLine03
		sta $7fff40
	skipLine03:
		cpy #$0004
		bne skipLine04
		sta $7fff60	
	skipLine04:			
		
		lda $28				; check up inputs to move curser 
		bit #$0800
		bne checkDownInputCurser 
		lda $36,x 
		inc a
		cmp #$0005		
		bne storeCurserPos01
		lda #$0001			; set to pos 1
	storeCurserPos01:
		sta $36,x 
	
	checkDownInputCurser: 	; check down inputs to move curser 
		lda $28
		bit #$0400
		bne ++
		lda $36,x 
		dec  
		cmp #$0000
		bne storeCurserPos02
		lda #$0004			; set to pos 4
	storeCurserPos02:
		sta $36,x 
		lda #$0001			; show score while shoping 
	++  sta !ShowScore
		rts	
	
	textStateUpdater:
		lda $36,x 
		xba 
		and #$00ff
		beq +
						; here we could ilustrate number form ram values 		
		lda #$0000		; clear old Curser first we clear states 
		sta $7fff00
		sta $7fff20
		sta $7fff40
		sta $7fff60
		sta $7fff02
		sta $7fff22
		sta $7fff42
		sta $7fff62
				
	+	rts 
	
	
	goNextTextWithSound:
		LDA #$0010
		STA $13F4		; ALSO REFILL HEALTH
		lda #$0030		; 8e 
		JSL.L $8085E3
		jmp goNextText
	

	goNextTextGetSecondWhip:
		inc $34,X
		inc $34,X
		
		lda #$0003
		ora !ownedWhipTypes
		sta !ownedWhipTypes	
		lda #$0002
		sta $92

		phx
		LDX.W #$FF27						                     
        JSL.L $8280e8 						; miscGFXloadRoutineXPlus81Bank	
		plx 
	
		LDA.W #$0084      ; SoundID  
		JSL.L $8085E3 		
		jsr loadTextPointer			
		jsl clearTextOnly
		rtl				; actions also end the state..
	
	goNextTextWithSoundGetWhip2:
		inc $34,X
		inc $34,X
		
		lda #$0002
		ora !ownedWhipTypes
		sta !ownedWhipTypes	
		lda #$0001
		sta $92
		lda #$0006
		sta !whipLeanth
		phx
		LDX.W #$B3FE						                     
        JSL.L $8280e8 						; miscGFXloadRoutineXPlus81Bank	
		plx 
	
		LDA.W #$0084      ; SoundID 1a 
		JSL.L $8085E3 		
		jsr loadTextPointer			
		jsl clearTextOnly
		rtl				; actions also end the state..


	initCurser:
		jsl goNextText
		lda #$0001
		sta $36,x 
		rtl

	switchControlls:
		lda #$0000			; set Vanilla 
		sta !logicRingControlls
		
		lda $36,x 
		stz $36,x 
		cmp #$0002
		bne +
		lda #$0001			; set logic controll 
		sta !logicRingControlls
		
	+	jml goNextText
	
	shopRoutineKey:
		lda $36,x 
		stz $36,x 
		tay 
		cpy #$0002
		bne endShopRoutine
		
		lda RAM_simon_multiShot		; only get item once 
		cmp #$0002
		beq +
		lda #$5000   			; Cost	; curse remove	
		jsr checkCash
		bcs endShopRoutine	
		jsr giveKey
		inc $34,x 				; answare for shoping 
		inc $34,x 

		bra endShopRoutine	
	+	inc $34,x 				; answare for having a key
		inc $34,x 
		inc $34,x 
		inc $34,x 
		inc $34,x 
		inc $34,x 
		bra endShopRoutine

	shopRoutine:
		lda $36,x 
		stz $36,x 				; get rid of curser 
		
		tay 
		cpy #$0001
		bne skipShopItem01
		bra endShopRoutine
	skipShopItem01:
		cpy #$0002
		bne skipShopItem02		
			
		lda #$2000   			; Cost	; curse remove	
		jsr checkCash
		bcs skipShopItem02		
		jsr bigWhip
	
	skipShopItem02:
		cpy #$0003
		bne skipShopItem03	
		lda #$1500	 ; oneUP cost
		jsr checkCash
		bcs skipShopItem03
		jsl getArmor
		
	skipShopItem03:
		cpy #$0004
		bne skipShopItem04	
		lda #$0000	; heart Cost
		jsr checkCash
		bcs skipShopItem04		
;		lda #$0024	; itemID
;		jsr getItemFromShop
		jsl removeCheats
		
	skipShopItem04:		

		
	endShopRoutine:	
		jsl goNextText
		rtl 
	
	checkCash: 
		sta $00
		sed 
		lda $1f40 
		beq check100kRange
		sec
		sbc $00
		bcc check100kRange	
		sta $1f40
	-	cld 
		clc 		; clearCarry for paying
		rts 
	check100kRange: 
		lda $1f42
		beq endChashCheck
		lda $1f40
		sec 
		sbc $00
		sta $1f40
		lda $1f42
		sbc #$0000
		sta $1f42
		bra -
		 
	endChashCheck:	
		cld
		inc $34,x
		inc $34,x
		inc $34,x
		inc $34,x
		LDA.W #$0007      ; SoundID  
		JSL.L $8085E3 		
		
		sec 				; setCarry for having no cash
		rts 

	setTutorialChoiceHeart:
		jsl setTutorialChoice
	spawnSmallHeartAndText:
		jsl endText	
		
		phy		
		jsl $82AFB6		; get empty event onto y register		
		lda #$0018
		sta.w $10,y
		lda $0a,x
		adc #$0020
		sta.w $0a,y
;		lda $0e,x 
;		sbc #$00c0
		lda #$0000
		sta.w $0e,y
		lda $542		; simons current layer 
		sta.w $02,y
		lda #$0009		; hitbox and collectible byte 
		sta.w $28,y
		sta.w $2a,y
		sta.w $2e,y		

		ply
		rtl 
	
	
	giftRoutine:
		lda $36,x 
		stz $36,x 
		
		tay 
		cpy #$0001
		bne skipGiftItem01
		bra endGiftItem04
	skipGiftItem01:
		cpy #$0002
		bne skipGiftItem02		
				
		jsr bigWhip
		lda $34,x		; skip text pointer
		clc 
		adc #$0002
		sta $34,x 
	
	skipGiftItem02:
		cpy #$0003
		bne skipGiftItem03	

		jsl getArmor
		lda $34,x		; skip two text pointer
		clc 
		adc #$0004
		sta $34,x 
		
	skipGiftItem03:
		cpy #$0004
		bne endGiftItem04	
	
		jsl removeCheats
		
	endGiftItem04:		
		jsl goNextText
		rtl 
	giveLeash:
		lda #$0001
		sta !dogLeash
		sta.l $700010		; also save 
		lda #$000e			; play sound 
		jsl lunchSFXfromAccum
		jml goNextText

	crossDowngradeUpgrade:
		lda $36,x 
		stz $36,x 
		tay 
		cpy #$0004
		bne upgradeCross
		lda #$0001
		sta !aramusBelmontCross		
		lda #$0070
		jsl lunchSFXfromAccum
		bra +
	upgradeCross:
		stz.w !aramusBelmontCross	
		lda $34,x		; skip two text pointer
		clc 
		adc #$0002
		sta $34,x 
		
		lda #$0037			; play sound 
		jsl lunchSFXfromAccum
	+	jml goNextText
		
	shopArmor:
		lda $36,x 
		stz $36,x 
		tay 
		cpy #$0001
		beq endArmorShop
		
		lda #$2000   			; Cost
		jsr checkCash
		bcs endArmorShop	
		jsr getColorArmor

	endArmorShop:	
		jsl goNextText
		rtl 
	
	getColorArmor:
		tya 
		sta !armorType		; set flag for blue armor 1e1a
		sta.l $700008		; also save 
		LDA.W #$0072      	; SoundID  ;80DFF2 give armore here
		JSL.L $8085E3 								                  
		rts 
	
	bigWhip:
		lda #$0003
		sta !ownedWhipTypes
		
		LDA.W #$0045      ; SoundID  ;80DFF2
		JSL.L $8085E3 		
		rts
	
	removeCheats:
		lda #$0001
		sta !ownedWhipTypes
	removeCheatsOnlySubWArmor:	
		lda #$0000
		sta !armorType
		sta.l $700008
		sta !allSubweapon
		sta.b RAM_simon_whipType
		
		
;		lda #$77b8		; change armor color directly
;		sta $7e2310 
;		lda #$4e70
;		sta $7e2312
;		lda #$2528
;		sta $7e2314
;		lda #$0482
;		sta $7e2316
		rtl 
	
	getItemFromShop:	
		phy
		
		pha
		jsl $82AFB6		; get empty event onto y register		
		pla
		
		sta.w $10,y
		lda $0a,x
		adc #$0030
		sta.w $0a,y
		lda $0e,x 
		sbc #$0030
		sta.w $0e,y
		lda $542		; simons current layer 
		sta.w $02,y
		lda #$0009		; hitbox and collectible byte 
		sta.w $28,y
		sta.w $2a,y
		sta.w $2e,y
		
		ply
		rts 
	
	getArmor:
		LDA.W #$0072      	; SoundID  ;80DFF2 give armore here
		JSL.L $8085E3 								                  
		lda #$0001
		sta !armorType		; set flag for blue armor 1e1a
		sta.l $700008
		sta !allSubweapon 
		rtl 

	giveKey:
		LDA.W #$0072      	; SoundID  ;80DFF2 give armore here
		JSL.L $8085E3 						
		lda #$0002
		sta $90
		rts 
	
	liftCurse:
		jsl goNextText

		stz.w RAM_simon_DamageDeBuff

		jsl updateCurseHud
		lda #$0037			; play sound 
		JSL.L $8085E3 
		rtl 
	
	endTextAndTransform:
		jsl endText
		lda #$0070		
		sta $10,x 
		lda #$0100
		sta $06,x 
		lda #$0003
		sta $12,x 

;		lda #$0047
;		sta $2e,x 
		rtl 
	endTutorial:
		bra endText
	transForm2Skelly:
		lda #$0011
		sta $10,x 
		stz.w $12,x 
		lda #$0047
		sta RAM_X_event_slot_HitboxID,x 
		lda #$0100
		sta RAM_X_event_slot_event_slot_health,x
		lda #$001e
		sta RAM_X_event_slot_subId,x 
	
	endTextSimonHurt:
		lda #$000c
		sta RAM_simonSlot_State
		lda #$0096
		jsl lunchSFXfromAccum
	
	setTutorialChoice:
		stz.w !ShowScore
		lda $36,x 
		stz $36,x
		cmp #$0002
		bcc endText	
		
		sta $4a 
		
		
		lda RAM_X_event_slot_xPos,x 	; set starting pint for autoplay the same as event 
		sta.w RAM_simonSlot_Xpos
		lda RAM_X_event_slot_yPos,x 
		sta.w RAM_simonSlot_Ypos
		stz.w RAM_simonSlot_subXpos 
		stz.w RAM_simonSlot_subYpos
		
		phx 
		lda $14,x 
		sec
		sbc #$0006
		asl 
		tax 
		lda.l gamPlayDataPointer,x 
		plx 			
;		sta $3e,x 
		
		sta $1c00			
		lda $4a
		cmp #$0003
		bcc +
		lda #$0100				; replay from SRAM 
		sta $1c00

	+	stz.w $1c02
		stz.w $1c06
		stz.b $38
;		lda #$0010				; timer till record starts 
;		sta $1c0e
		
		lda #$0009				; setTutorialShowcase
		sta $70
		lda #$000c
		sta $72

	endText:
		stz $f0			; delete Pointers (section is used in transition and game over)
		stz $f2 		
		stz $f4
		stz $f6 
		
		stz $34,x 
		stz $32,x		; make sure we start to write at the beginning		

		stz $12,x		; reset NPC
;		lda $14,x 
;		clc 
;		adc #$0002
;		sta $12,x 
	
		stz $1fa2		; make player move again 
		lda #$0001		; terminate textUpdate 2 PPU
		sta !textEngineState
		rtl 
	endTextMakeHitable:
		lda #$0046
		sta $2e,x 
		bra endText

}


{	; NPC General Routines ------------------------------------------------------------
	walkBackAndForward:
		lda $78			; run walking every other frame to make it slower
		bit #$0001
		beq ++
		
		lda $3a,x			; waling routine. Make a range of pixle and go up and down
		beq +

		lda #$4000			; flip Sprite
		sta $04,x 
		inc $38,x
		inc $0a,x
		lda $38,x 
		cmp #$0030
		bne ++
		stz $3a,x 
	
	+	lda #$0000			; flip Sprite
		sta $04,x 
		
		dec $38,x
		dec $0a,x
		lda $38,x
		cmp #$ffd0
		bne ++
		lda #$0001
		sta $3a,x 	
		
	++	rts 

	faceSimon:
		stz $04,x 
		lda $54a
		cmp $0a,x
		bmi +
		lda #$4000
		sta $04,x
	+	rtl 

	faceAwayOfSimon:
		stz $04,x 
		lda $54a
		cmp $0a,x
		bpl +
		lda #$4000
		sta $04,x
	+	rtl 

	walkOnSpot:
		lda $78			; run walking every other frame to make it slower
		bit #$0011
		beq ++
		
		lda $3a,x			; waling routine. Make a range of pixle and go up and down
		beq +

		lda #$4000			; flip Sprite
		sta $04,x 
		inc $38,x
		inc $0a,x
		lda $38,x 
		cmp #$0010
		bne ++
		stz $3a,x 
	
	+	lda #$0000			; flip Sprite
		sta $04,x 
		
		dec $38,x
		dec $0a,x
		lda $38,x
		cmp #$fff0
		bne ++
		lda #$0001
		sta $3a,x 	
		
 ++	rts 

	NPCwalkAnimation:
		lda $14,x 			; walk animation 
		asl
		tay 
		lda npcSpriteIDlist,y 	
		sta $00,x 
		
		lda $78				; frame counter bit skip to animate 
		bit #$0020
		beq +

		lda $14,x 
		asl
		tay 
		lda npcSpriteIDlist2,y 		
		sta $00,x 
	+	rts 

	floatInAir:	
		lda RAM_X_event_slot_Movement2c,x 
		bne +
		lda #$0003							; initiate movement and set parameters 
		sta RAM_X_event_slot_Movement2c,x 
		lda $0a,x
		clc
		adc #$0007
		sta $20,x 
		lda $0e,x 
		clc
		adc #$0003
		sta $22,x 
		
	+	lda $0a,x
		cmp $20,x 
		bpl +
	
		lda RAM_81_X_event_slot_xSpdSub,x	; xPos acceleration
		clc 
		adc #$0400
		sta RAM_81_X_event_slot_xSpdSub,x	
		lda #$0000
		adc RAM_81_X_event_slot_xSpd,x	
		sta RAM_81_X_event_slot_xSpd,x	
		bra ++ 
		
	+	lda RAM_81_X_event_slot_xSpdSub,x
		sec  
		sbc #$0400
		sta RAM_81_X_event_slot_xSpdSub,x	
		lda RAM_81_X_event_slot_xSpd,x
		sbc #$0000
		sta RAM_81_X_event_slot_xSpd,x
		
	++	lda $0e,x							; yPos acceleratio
		cmp $22,x 
		bpl +
		
		lda RAM_81_X_event_slot_ySpdSub,x
		clc 
		adc #$0400
		sta RAM_81_X_event_slot_ySpdSub,x	
		lda #$0000
		adc RAM_81_X_event_slot_ySpd,x	
		sta RAM_81_X_event_slot_ySpd,x	
		bra ++
	
	+	lda RAM_81_X_event_slot_ySpdSub,x
		sec  
		sbc #$0400
		sta RAM_81_X_event_slot_ySpdSub,x	
		lda RAM_81_X_event_slot_ySpd,x
		sbc #$0000
		sta RAM_81_X_event_slot_ySpd,x
	++	rts 

; -------------------------- NPC LOGIC MAIN -------------------------------------------
		
	
;	NPCStateOldMan02:		; typical NPC routine
;		jsr NPCwalkAnimation
;		jsr walkBackAndForward
;		jml NPCTextTrigger	; text trigger has rtl at the end what will end the routine

;   NPCStateOldMan03:		
;		jsr NPCwalkAnimation	
;		jsr walkBackAndForward
;		jml NPCTextTrigger
		        
;	NPCRedguy:
;		jsr NPCwalkAnimation		
;		jsr walkBackAndForward
;		jml NPCTextTrigger

	
	MoonLady:
	moonLadyCastle:	
		jsr NPCwalkAnimation		
		jml NPCTextTrigger
	
	brotherBeforeDrac:
		jsl RedguysBrother
		lda $12,x 
		cmp #$0001
		bne +
		lda.l !goodEndingProgress
		beq +
		lda #$0008 		; extra text back here?? When we give the wizzard the dog he will be taken by batbarions 
		sta $34,x 
	+	rtl 
	NPCRedguy:
	NPCStateOldMan03:
	NPCStateOldMan02:
	BarManDoinaKeySeller:
	NPCbossQuestGiver:	
	RedguysBrother:
		
		jsr NPCwalkAnimation		
		jsr walkBackAndForward
		jml NPCTextTrigger		
	BarKeeper00:
	BuilderManDoina:
		jsr walkOnSpot
		jsr NPCwalkAnimation		
		jml NPCTextTrigger		

	aramus:
		jsr NPCwalkAnimation
		jsr walkBackAndForward
		jml NPCTextTrigger	

	hooker:
	Tinnue:
		jsl faceSimon
		lda $04,x 
		ora #$0e00
		sta $04,x 
		jml NPCTextTrigger	
	
	Fish:
		jsl makeItSnowing
		
		LDA.B $24,X                      ; jumpTable 
        PHX                               
        ASL A                             
        TAX                               
        LDA.L fishStateTable,X            
        PLX                               
        STA.B $00 
		jmp.w ($00)

	fishStateTable:
		dw fishSwim,fishGetCatched,fishLunched,fishInHole,fishHit

	fishSwim:		
		lda !fishCatchedFlag
		beq +
		lda #$0004						; in case you leave the screen lets not loose progress 
		sta $24,x 
		jmp fishHit 	
		
	+	lda #$0003
		sta RAM_X_event_slot_Movement2c,x 
		
		jsl fishConfinment
		
		lda RAM_simon_whipType
		bne +++
		lda $212
		cmp #$0005
		bne +++
		
		lda RAM_X_event_slot_xSpd,x 	; make movment slow 
		bmi +
		lda #$0000
		jmp ++
	
	+   lda #$ffff
	++	sta RAM_X_event_slot_xSpd,x
		
		lda $34a				; make fish circle around the whip
		sta $34,x 
		inc $36,x 
		lda $36,x 
		cmp #$00c0
		bcc +
		
		lda $34a			   ; fish needs to be near whip 
		cmp RAM_X_event_slot_xPos,x 
		bne +
		inc $24,x 
		
	+	rtl 
	
	
	+++	lda #$0040				; make fish circle around the pound 
		sta $34,x 		
		stz.w $36,x 
		rtl 
	


	fishGetCatched:
		stz.w $2c,x 
	
		lda $212
		cmp #$0005
		beq +
		inc $24,x 
		
	+	lda $34e			; make fish follow whip tip
		sta $0e,x 
		lda $34a
		sta $0a,x 
	
		lda $35e			; copy speed from whip 
		sta $1e,x 
		lda $35a
		sta $1a,x  
		rtl 
	fishLunched:
		lda #$0003
		sta $2c,x 			; make fish fly 
	
		stz.w $36,x 		; reset timer to get catched again 	
	
		jsl gravetyFallCalculation2000
	
		lda RAM_X_event_slot_yPos,x  
		cmp #$0010
		bcs +
		inc.w $24,x 
		
	+	cmp #$00c4 
	fishFalling2Water:
		bcc + 
		
		stz.w $24,x 		; reset when landing on ground/water 
		stz.w $12,x 
		stz.w RAM_X_event_slot_xPos,x 
		lda #$00f0
		sta RAM_X_event_slot_yPos,x 
		
	+	rtl 

	fishInHole:		
		lda #smallFish
		sta $00,x 
		lda #$0002
		sta $2c,x 
		
		lda RAM_X_event_slot_yPos,x 
		and #$fff0
		cmp #$0060
		bne +
		lda RAM_X_event_slot_xPos,x 
		cmp #$0040
		bcc +
		cmp #$0060
		bcs +
		
		inc.w $24,x 
		
	+	stz.w RAM_X_event_slot_xSpdSub,x 
		stz.w RAM_X_event_slot_xSpd,x 
		stz.w RAM_X_event_slot_ySpdSub,x
		lda #$0001
		sta RAM_X_event_slot_ySpd,x 	
		
		jsl gravetyFallCalculation2000
		lda RAM_X_event_slot_yPos,x  
		cmp #$00a8					; it might look like it lands and land 
		jmp fishFalling2Water 

	fishHit:
		lda RAM_simonSlot_Xpos
		cmp #$0200
		bcs +++
		
		lda $00,x 
		beq +
		stz.w $00,x 
		stz.W $2c,x 
		lda #$001f
		jsl lunchSFXfromAccum
		
		lda #$0001
		sta !fishCatchedFlag

	+	phx
		phy 
		
		lda $3a
		and #$0008
		beq +
		lda #$0031
		jmp ++
		
	+	lda #$0030
	++	ldy #$4928
		jsl $83D1E7
		
		lda #$0038
		ldy #$49a8
		jsl $83D1E7
		
		ply
		plx 

	+++	lda RAM_simonSlot_Xpos
		cmp #$05c0
		bcc +
		lda #$0002
		cmp !fishCatchedFlag
		beq +
		sta !fishCatchedFlag
		lda #$008a
		jsl lunchSFXfromAccum
	+	rtl 

	fishConfinment:
		lda #$00d8						; move like a bat ypos
		sta $30,x 
		
		jsl $86C5DD

		lda RAM_X_event_slot_xSpd,x 
		bmi +
		lda #$4000
		sta $04,x 
		jmp ++
	+	stz $04,x 
		
	++	LDA.B RAM_X_event_slot_xPos,x    ; copy for xpos     		
        CMP $34,x 
        BCS ++

        CLC                                  		
		LDA.B RAM_X_event_slot_xSpdSub,X     
        ADC.W #$1000                         
        STA.B RAM_X_event_slot_xSpdSub,X     
        LDA.B RAM_X_event_slot_xSpd,X        
        ADC.W #$0000                         
        cmp #$0004						; speed limit 
		beq +
		STA.B RAM_X_event_slot_xSpd,X        
	+	jmp restroctMovment2Pound
		
++		SEC                                  
		LDA.B RAM_X_event_slot_xSpdSub,X     
		SBC.W #$1000                         
		STA.B RAM_X_event_slot_xSpdSub,X     
		LDA.B RAM_X_event_slot_xSpd,X        
		SBC.W #$0000                         
		cmp #$fffc						; speed limit 
		beq restroctMovment2Pound
		STA.B RAM_X_event_slot_xSpd,X         	
		
	restroctMovment2Pound:	 			; restrict momvenet to pound 
		lda RAM_X_event_slot_xPos,x 
		cmp #$0080					
		bcc +
	
		lda #$0080
		sta RAM_X_event_slot_xPos,x
		
	+	lda #$0004
		cmp RAM_X_event_slot_xPos,x  
		bcc +
		lda #$0004
		sta RAM_X_event_slot_xPos,x
	
	+	lda RAM_X_event_slot_yPos,x  
		cmp #$00c4 
		bcs +		

		lda #$00c4
		sta RAM_X_event_slot_yPos,x  	
	+	rtl 


	makeItSnowing:
		lda #$0080
		sta.w RAM_X_event_slot_HitboxID,x
		
		inc $32,x 
		lda $32,x 
		cmp #$0020
		bne +				; make a snowflake appear every 0x20 frames 
		
		stz.w $32,x 	
		ldy #$0000
		jsl heartRainEveryFrame	

		cpy #$0000			; check if event has spawned and make it a snow fleak 
		beq +

		lda #$0000
		sta.w RAM_X_event_slot_HitboxID,y			
		lda RAM_X_event_slot_SpriteAdr,x
		sta.w RAM_X_event_slot_SpriteAdr,y
		lda.w #snowFlake
		sta.w $00,y
		sta.w $3e,y 
		lda #$0001			; set flag for no heart sprite updates.. 
		sta.w $20,y 
	+	rtl 
	
		
	DDnu:		
		jsr NPCwalkAnimation
		jsl NPCTextTrigger	
		
		lda !fishCatchedFlag
		beq +++
		cmp #$0002
		bne +
		lda #$000c			; final answare
		bra ++
	+	lda #$0008			; secret 
	++	sta $34,x 
;		lda $30,x  
;		bne +		
;		jsr makeFishAppear
	+++	rtl 

	finalBoss:
		lda $22,x 
		cmp #$0004
		bcs goTextMode
		lda $00,x 
		beq +
		inc $20,x 
		lda $20,x
		cmp #$000c
		bcc +
		inc $22,x 
		stz $20,x 
		stz $00,x 	
		
		lda #$008b
		jsl lunchSFXfromAccum	
			
	+	lda RAM_simon_multiShot
		bit #$0001
		beq +
		and #$0002
		sta RAM_simon_multiShot 
		lda #jungLadyFr1 
		sta $00,x 
		
	+	rtl 
	goTextMode:
		lda #jungLadyFr1 
		sta $00,x 
		BRA afterSlogRoom
	TutorialLeady00:
		jsl loadPalettePracticeRing	
	TipLeady00:		; IS DRESSED AS A MAN LOL dont fix it hehe 
	afterSlogRoom:
	TutorialLeady01:
	TutorialLeady02:
;		jsl tutorialAutoPlay
	
	TutorialLadyControls:
	ArmorSeller:
		jsl faceSimon
		jml NPCTextTrigger	
	
	ChillSkelly:
		lda $38,x 
		bne skellyElevatorMode
		
		lda #$0120				; slot offst 
		sta $26,x 
		jsr floatInAir
		jsl NPCTextTrigger	
		lda $12,x 				; stop movement in text state 
		cmp #$0001
		bne +
		
		stz.b RAM_X_event_slot_Movement2c,x  
		jsl elevatorCardPassCheckNoInput
		bcs +
		lda #$000a				; advanced text to function as elevetar when u have the dog 
		sta $34,x 	
		jsr loadTextPointer
		lda #$0001				; set elevator mode 
		sta $38,x 
		
	+	rtl 

	skellyElevatorMode:
		cmp #$0002
		beq skellyZombieModus
		
		lda #$0012
		sta RAM_simonSlot_State
		
		lda #$9c25
		sta RAM_simonSlot
		lda #$0065 
		sta RAM_simonSlot_AnimationCounter
		
		lda #$0010
		sta RAM_simon_invulnerable_counter
		
		lda #$0700				; set camera look 
		sta $a4 
		
		lda RAM_X_event_slot_yPos,x 
		cmp #$0800
		bcc +++
		sta RAM_simonSlot_Ypos
		
		lda RAM_X_event_slot_xPos,x 
		adc #$0010
		sta RAM_simonSlot_Xpos		

		stz.b RAM_simon_ForceGroundBehavier				; prevent beeing stuck on platforms 
		
		lda $3a
		bit #$0010
		beq +
		ldy #$8000
		jmp ++
	+	ldy #$c000
	++	sty.w RAM_simonSlot_spriteAttributeFlipMirror
	
		lda #$fffd
		sta RAM_X_event_slot_ySpd,x 	
	-	jsr floatInAir

		rtl 
	+++ lda #$0004
		sta RAM_simonSlot_State
		stz.w $212			; fix whip if you hit ring 
		lda #$0002
		sta $38,x 
	skellyZombieModus:
		stz.w $a4 
		jmp -

 

	skellyHurb:
		ldy #$0400
		lda $3a 
		bit #$0008
		beq +
			
		ldy #$0e00
	+	tya 
		sta $04,x 
		jml NPCTextTrigger

	headlessNPC:
		lda #$0160
		sta RAM_X_event_slot_SpriteAdr,x 
		
		lda #$0080
		sta RAM_X_event_slot_HitboxID,x 
		
		lda #$0013				; we need this for the level.. we set it 2 zero in the action list for the text to show 
		sta $46
		
		lda RAM_simonSlot_Ypos	; make a sound when you step on the skull 
		cmp #$0345
		bne +
		lda RAM_simonSlot_Xpos	
		and #$fff0
		cmp #$0100
		bne +
		lda $20,x 
		bne +
		inc.w $20,x 
		lda #$0044
		jsl lunchSFXfromAccum
		
	+	jsl NPCTextTrigger
		lda $12,x 
		cmp #$0001
		bne +
		stz.w $46 
	+	rtl 

	BarKeeper02Doina:
		jsl faceSimon
		jsr NPCwalkAnimation
		
		lda !ownedWhipTypes		; new text hinting to door
		cmp #$0003
		bne +
		lda $34,x 
		cmp #$0008
		bcs +
		lda #$0008
		sta $34,x 
		
	+	jml NPCTextTrigger	
	
	ZombieManDoina:
		lda #$00e0			; hardcoded GFX slot offset  
		sta $26,x 
		
		lda $1fa2
		beq +		
		lda #$96a0
		bra ++
	+	lda #$89f0
	++	sta $00,x 
		
	+	jsl faceSimon
		jml NPCTextTrigger	
	
	ZombieManDoinaWife:
		jsl faceSimon
		jsr NPCwalkAnimation		
		jml NPCTextTrigger		
		
	ZombieManDoinaHunter:
		lda !dogLeash			; story continues in the Castle the leash does unlock future content in the castle so we are don here
		bne clearHunterNPC
		
		lda !ownedWhipTypes
		cmp #$0003
		bne +
		
		lda RAM_simon_subWeapon	; we cclear the hunter NPC altogether and spawn a new one to clear things up and let you progress
		cmp #$0005
		beq clearHunterNPC
		
		lda #$00e0		; fix slot offset 
		sta $26,x 
		lda #$0070
		sta $10,x 
		stz.w $12,x 
		lda #$0019		; give big heart on kill 
		sta.w $14,x 
		jml $83DDFE

	+	jml ZombieManDoina
	clearHunterNPC:
		jml clearSelectedEventSlotAll
	
	ZombieManDoinaWifeSecond:
		lda !dogLeash
		bne clearHunterNPC

		jsl ZombieManDoinaWife

;		lda !ownedWhipTypes
;		cmp #$0003
		lda !killedHusband
		beq +
		lda $34,x 				; new text check and update 
		cmp #$0006
		bcs +
		lda #$0006
		sta $34,x 	

		lda !killedHusband
		cmp #$0006
		bcc +
		lda #$000a
		sta $34,x 	
		
;		lda #$0100				; was thinking to let her count how many times you killed him.. but since I do no furhter content this would be stupid 
;		sta $36,x 

	+	rtl 
		
	door:
		jsr pushSimonOut
		lda $92
		cmp #$0002
		bne +
		
		lda #$0020
		sta $2a,x 
		
		lda #$0002
		sta $2e,x 
		lda $06,x 
		cmp #$0100
		beq ++
		lda #$500
		sta $a0 
		stz.w RAM_X_event_slot_event_slot_health,x 		; make the door die quick
		rtl 
		
	+	stz $2e,x 
	++	rtl 
	
	door2:
		lda $34,x 		; flag door is opening 
		bne +
		
		jsr pushSimonOut
		lda $32,x 		; flag door is touched 
		beq ++
		lda RAM_simon_multiShot
		bit #$0002
		beq ++
	
	+	lda $34,x 		; move door 64 pixle up also use it as flag to skip collusion 
		inc 
		cmp.w #$0032
		beq ++
		sta $34,x 
		dec.w RAM_X_event_slot_yPos,x 
	++	rtl 


	pushSimonOut:
		jsl faceSimon
		lda $04,x 
		bne +
		lda RAM_X_event_slot_xPos,x
		sbc #$0008
		cmp RAM_simonSlot_Xpos
		bcs ++
		
		sta RAM_simonSlot_Xpos
		sta $32,x 						; set sign we touched door
;		jsr stopSimonsMovementSpeedX
		bra +++

	+   lda RAM_simonSlot_Xpos
		sec
		sbc #$0010
		cmp RAM_X_event_slot_xPos,x
		bcs ++
		
		lda RAM_X_event_slot_xPos,x
		clc
		adc #$0010
		sta RAM_simonSlot_Xpos
		sta $32,x 
;		jsr stopSimonsMovementSpeedX		
		bra +++
		
	++	lda #$0000
		sta $32,x 						; dont check door when we are not next to it.. 
	+++	lda #$0000
		sta $04,x 
		rts	

;	stopSimonsMovementSpeedX:
;		stz.w RAM_X_event_slot_xSpd
;		stz.w RAM_X_event_slot_xSpdSub
;		rts 

	RedguyLiftingCurse:
		jsr NPCwalkAnimation		
		jsr walkBackAndForward
		jml NPCTextTrigger	
		jml TutorialLeady01
	
	TipLeady01:
		jsl makePaletteDark
		lda $20,x 
		cmp #$0080			; only talk when dark.. 
		bne +
		jsl faceSimon
		jsl NPCTextTrigger
		jsl	resetBG3Scroll
	+	rtl 
	Paul:			
		jsr paulRoutine
		jml NPCTextTrigger
	resetBG3Scroll:
		lda.l !textEngineState
		beq +
		lda #$0000
		bra ++
	+	lda #$000b
	++	sta $46 		; cheep fix just changing a setting also fixes a issue with restoring this BG since we write to first screen 		; 46 #$0b00
	-	
		rtl 
	
	makePaletteDark:
		lda $15fe		; I think the end of this table will not get used and it is clear on level start
		bne -		
		
		lda $22,x 
		clc 
		adc #$0001
		cmp #$0020
		bne +
		
		stz.w $22,x 	; counter reset write palette offset 
		lda $20,x 
		clc 
		adc #$0020
		sta $20,x 
		bra ++

	+	sta $22,x 	
	++	lda $20,x
		cmp #$0080
		bne +
		stz.w $22,x	; lock counter
		jmp makePaletteBlack

	+	phk
		phx
		phy 
		sep #$20
		lda #$86	
		pha
		plb
		rep #$20
		
		lda #$FE82			;	paletteGetDark:   ;86FE82
		clc 
		adc $20,x 
		sta $00
	
		ldx #$0020
		txy
	-	lda ($00),y  
		sta.l $7e2220,x
		dey
		dey
		dex
		dex
		bpl -
		
		ply 
		plx 
		sep #$20
		plb 
		rep #$20
		rtl 
	makePaletteBlack:
		phx 
		ldx #$0020
		lda #$0000
	-	sta.l $7e2220,x
		dex
		dex 
		bpl -
		plx 
		
		lda #$ffff		; set flag to only trigger once till you die 
		sta $15fe		; I think the end of this table will not get used and it is clear on level start
		rtl 

	paulRoutine:		
		lda $3a			; palette animations 
		and #$1043
		sta.l $7e2200
		
		lda $e6
		and #$4444		
		sta.l $7e2338
		rts
	
;	makeFishAppear:
;		jsl makeNewEventAtEventPossition
;		lda #$0023
;		sta.w $14,y 
;		lda #$000d
;		sta.w $10,y 
;		stz.w RAM_X_event_slot_xPos,y
;		stz.w RAM_X_event_slot_yPos,y 
;		stz $30,x 					; remove spawn flag 
;		
;		lda #$0080
;		sta.w RAM_X_event_slot_HitboxID,y
;		
;		rts 
 
	heartRain:
		lda $3a 
		bit #$000f
		bne +
	heartRainEveryFrame:	
		jsl makeNewEventAtEventPossition
		bcs +
		lda #$0018
		sta.w $10,y
		lda #$0000
		sta.w RAM_X_event_slot_SpriteAdr,y
		sta.w RAM_X_event_slot_yPos,y
		lda RAM_RNG_2
		and #$00ff
		adc RAM_BG1_ScrollingSlot
		sta.w RAM_X_event_slot_xPos,y
		lda #$0008
		sta.w RAM_X_event_slot_HitboxYpos,y
		sta.w RAM_X_event_slot_HitboxXpos,y		
		lda #$0009
		sta.w RAM_X_event_slot_HitboxID,y 

	+	rtl 


		makeNewEventAtEventPossition:
			phx 
			jsl getEmptyEventSlot
			txy 
			plx
			bcs +
 			
			lda RAM_X_event_slot_SpriteAdr,x 
			sta.w RAM_X_event_slot_SpriteAdr,y
			lda RAM_X_event_slot_xPos,x 
			sta.w RAM_X_event_slot_xPos,y
			lda RAM_X_event_slot_yPos,x 
			sta.w RAM_X_event_slot_yPos,y
			lda RAM_simonSlot_spritePriority
			sta $0002,y 

		+	rtl 
		
		changeSpritesBatBa:			
			jsr loadBatBaGFX
			jmp goNextText
		
		spawnPipNextText:
			jsl makeNewEventAtEventPossition
			bcs +
			lda #$000d
			sta $0010,y 
			lda #$0028
			sta $0014,y 
			lda #$004c
			sta $000e,y 
			lda #$0014
			sta $000a,y 	
			
		+	
			jmp goNextText	
		engageWizzardAction:
			jsr makeBatBaAppearGoodEnding
			jmp goNextText	
		
		evilRedguyEndingCheck:
			lda RAM_simon_multiShot			; good ending trigger
			and #$0001
			beq +
			
			lda #$819F
			sta $3e,x 			; flag good ending to change sprite flicker while batba is in slot 
			lda #$000a
			sta $34,x 
			jsl elevatorCardPassCheckNoInput
		
		+	jml goNextText

		
		makeBatBaAppearGoodEnding:
			lda #$0001							; flag good ending 
			sta.l !goodEndingProgress
	;		ldy #$819F
	;		lda $3a 
	;		bit #$0001
	;		beq +		
	;		ldy #$81a4 
	;	+	tya 
	;		sta $00,x 
			lda #$819F
			sta $00,x 
				
			phx 
			txy 
			jsl getEmptyEventSlot		
			bcs ++
			lda $000a,y 
			sta $0a,x
			lda $000e,y 
			sta $0e,x 
			lda #$0027
			sta $14,x 
			lda #$000d
			sta $10,x 
			
			lda $0026,y 
			sta.w RAM_X_event_slot_SpriteAdr,x 
			lda #$0000
			sta $0026,y 
			tya 											; store pointer for action controll  
			sta $3e,x 
		
		++	plx 
			rts 
		loadBatBaGFX:
			phx 
			LDX.W #batBaGFX_dmaPointer           			; leather whip     		
			JSL.L $8280e8
			plx 
			rts 
	
	evilRedguyEnding:
		lda.l !goodEndingProgress
		beq +
		jml clearSelectedEventSlotAll	
	+	jsr NPCwalkAnimation
	pipBat:
		lda #$0080
		sta RAM_X_event_slot_HitboxID,x 
		lda #$0003
		sta RAM_X_event_slot_Movement2c,x 

		lda RAM_simonSlot_spriteAttributeFlipMirror	; make pip lfy behind you 
		beq +
		lda RAM_X_event_slot_xPos,x
		sbc #$0023
		bra ++	
		
	+	lda RAM_X_event_slot_xPos,x
		adc #$0034 
	++	cmp RAM_simonSlot_Xpos
		jsl followXPos
		
		lda RAM_X_event_slot_yPos,x
		adc #$0050
		bpl +
		lda #$0000
	+	cmp RAM_simonSlot_Ypos		
		jsl followYPos

		lda #$0002
		sta $00
		jsl speedLimiter00_X
		jsl speedLimiter00_Y
		
		lda $14,x 			; skip if ending wizzard 
		cmp #$0029
		beq +
		
		jsl faceSimon 
		jsr pipAnim
		
		lda $A2
		cmp #$0700
		beq pipGrabOrb
	+	rtl 
	pipGrabOrb:
		lda $32,x 
		bne bringOrbHome 
		lda $24,x 
		bne ++
		lda #$004b
		sta $00
		lda #$0010
		sta $02
		jsl findEventID_00_02
		bcs +
		lda $00
		sta $24,x 
	++	tay 
		lda RAM_X_event_slot_yPos,x 
		and #$ffe0
		sta $00
		lda.w RAM_X_event_slot_yPos,y  
		and #$ffe0
		cmp $00
		bne +
		
		lda RAM_X_event_slot_xPos,x 
		clc 
		sbc #$0010
		and #$ffe0
		sta $00
		lda.w RAM_X_event_slot_xPos,y  
		clc 
		sbc #$0010
		and #$ffe0
		cmp $00
		bne +
		inc $32,x 		; set flag to bring orb home 
		
	+	rtl 
	bringOrbHome:
		ldy $0024,x 
		lda $0e,x 
		adc #$001c
		sta $000e,y 
		lda $0a,x 
		sta $000a,y 
		
		inc $34,x 
		lda $34,x 
		cmp #$0080
		bcc +
		lda #$0002
		sta $2c,x 
		dec $0a,x 	
		stz.b $04,x 
		
	+	rtl 
	
	
	findEventID_00_02:
		phx 
		
		ldx #$0540		
	-	txa
		clc 
		adc #$0040
		cmp #$0f00
		beq eventIDnotFound
		tax  
		lda $10,x 				; check ID
		cmp $00 
		bne -
		lda $14,x				; check subID
		cmp $02
		bne -
		txa 					
		sta $00
	eventIDFound:	
		clc 
		plx 
		rtl
	eventIDnotFound:	
		sec
		plx 
		rtl		
	
	panikGuy:		
		phx 
		
		lda $3e,x 		; controll wizzard/orb  
		tax 
		
		lda $34,x 
		beq batbaWarpActionDisapear
		cmp #$000c
		bcc batBaNPC 
		jmp batbaWarpAction
			
	batBaNPC:	
		plx 
		rtl 
	teleportAndPaper:
		lda $3a
		bit #$001f
		bne ++	
		jsl makeNewEventAtEventPossition		
		bcs ++
		lda #$0002
		sta $0010,y
		sta $003c,y
;		lda #letter00Assembly
;		sta $0000,y 
		lda RAM_RNG_2
		and #$4000
;		ora #$0e0c
		sta $0004,y 
		
	
	++	rts 
	
	batbaWarpActionDisapear:
;		plx 
;		lda $3c,x 
;		bne +
;		lda $00,x 
;		sta $3c,x 
;		
;	+	lda $3a
;		and #$0004
;		beq +
;		lda $3c,x 
;	+	sta $00,x 	
		plx 
		lda #$0080
		sta.b RAM_X_event_slot_HitboxID,x 
		jsr batbaAnim
		jsl faceAwayOfSimon
		jml NPCTextTrigger
	
	batbaWarpAction:
		sec
		sbc #$000c
		tax 
		lda batbaActionRoutines,x 
		sta $00
		plx 
		jmp ($0000)
	batbaActionRoutines:
		dw runAroundWizzard,runAroundWizzard,runTurnIntoWarp,forceOrb2Ground,TeleportApearing,TeleportApearing,TeleportApearing,TeleportApearing 	
	
	runAroundWizzard:		 
		lda $3e,x 		; controll wizzard/orb  
		tax 
		lda $0e,x	; let orb sink to ground 
		inc 
		cmp #$00bc
		bcs +
		sta $0e,x 	
		
	+	ldx $fc  
		jsr NPCwalkAnimation	; running and loosing stuff routine 	
		jsr NPCwalkAnimation
		jsr walkBackAndForward
		jsr walkBackAndForward
		
		jsr teleportAndPaper
		rtl 
	
	runTurnIntoWarp:
		stz.b $04,x 
		
		ldx $fc 
		ldy #oldManFr2
		lda $3a
		bit #$0002
		beq +
		
		lda RAM_RNG_3
		and #$e000
		sta $04,x 
		ldy #warpAssembly

	+	tya 
		sta $00,x 
		
	;	jsr floatInAir
	;	jsr walkBackAndForward
		rtl 
	
	forceOrb2Ground:
		jsr loadBatBaPalette
		jsl faceAwayOfSimon
		jsr batbaAnim
		ldy $3e,x 
		lda #$00bc 			; force orb ground 
		sta $000e,y 
		rtl 
	TeleportApearing:
		rtl 
	
	loadBatBaPalette:
		phx 
		phb 
	
		sep #$20	
		lda #$81
		pha 
		plb
		rep #$20
		
		ldy #paletteBatba
		ldx #$1260
		jsl bossGetPaletteY2X
		plb 
		plx 
		rts 
	
	batbaAnim:		
		lda $3a
		bit #$000f
		bne ++
		lda $22,x 
		inc 
		cmp #$0006
		bne +
		lda #$0000
	+	sta $22,x 	
	++	lda $22,x 
		asl 
		tax 
		lda.l batBaFrameAnimTable,x 
		ldx $fc 
		sta $00,x 
		rts 
	batBaFrameAnimTable:
		dw batBaAssemblyFrame01,batBaAssemblyFrame02,batBaAssemblyFrame03,batBaAssemblyFrame04,batBaAssemblyFrame03,batBaAssemblyFrame02
	pipAnim:
		inc $20,x 
		lda $20,x 
		cmp #$0007
		bne ++
		stz $20,x 
		lda $22,x 
		inc 
		cmp #$0006
		bne +
		lda #$0000
	+	sta $22,x 	
	++	lda $22,x 
		asl 
		tax 
		lda.l pipFrameAnimTable,x 
		ldx $fc 
		sta $00,x 
		rts 
	pipFrameAnimTable:
		dw PipAssemblyFrame01,PipAssemblyFrame02,PipAssemblyFrame03,PipAssemblyFrame04,PipAssemblyFrame03,PipAssemblyFrame02

	evilRedguyGetBossReady:
;		lda #$05e0			; right camera border till dragon boss 
		lda #$0380 		; set camera to first dragon boss dest
		sta $a2
		lda #$0001
		sta $3c,x 
;		ldx #$e267			; viper whole sprite load 
;		jml $8280E8
		rts 
	
	evilRedguyTransfromOrgTrans:
		lda #$819F
		sta $3e,x 			; flag good ending to change sprite flicker while batba is in slot 
		jsr evilRedguyGetBossReady
		jsr makeBatBaAppearGoodEnding
		jsr loadBatBaGFX
		jsr loadBatBaPalette
		
		bra evilRedguyTransfromOrg
	evilRedguy:
		lda.l !goodEndingProgress
		bne evilRedguyTransfromOrgTrans
		lda $3c,x 
		bne evilRedguyTransfromOrg

		lda #$0027			; dirty hack since we have one frame in state 00 that looks wired in this case while transfrom 
		sta $14,x 
		
		jsr NPCwalkAnimation		
		jsr walkBackAndForward
		lda #$0024
		sta $14,x 
		
		jsl NPCTextTrigger
		lda $12,x 			; check if text state 
		cmp #$0001
		bne +
		jsr evilRedguyGetBossReady
	+	rtl 

	evilRedguyTransfromOrg:
		phx					; set event to not spawn anymore 
		lda RAM_X_event_slot_mask,x 
		tax 
		sep #$10			; write to 8 bit type 1 table 
		lda #$0001			
		sta $1500,x 
		rep #$10
		plx 
		
		lda $3e,x 
		pha 
		lda RAM_X_event_slot_SpriteAdr,x 
		pha 
		lda RAM_X_event_slot_xPos,x 
		pha
		lda RAM_X_event_slot_yPos,x 
		pha
		jsl clearSelectedEventSlotAll		; we switch event for boss 
		lda #$004b
		sta $10,x 
		lda #$0010
		sta $14,x 
		lda #$0080
		sta RAM_X_event_slot_HitboxID,x 
		
		pla 
		sta RAM_X_event_slot_yPos,x
		pla 
		sta RAM_X_event_slot_xPos,x 
		pla 
		sta RAM_X_event_slot_SpriteAdr,x 
		
		pla 
		bne +
		lda #oldManFr2						; animation frame 
	+	sta $3e,x 
		
		lda #$008a 
		jsl lunchSFXfromAccum 
		rtl 				; boss face 

	skellyBeforeDrac:
		lda #$0160				; slot offst 
		sta $26,x 
				 
		jsr floatInAir
		
		lda #$4200
		sta $04,x 
		stz $02,x 
		
		jsl NPCTextTrigger
		
		lda #$0003
		sta.b RAM_X_event_slot_Movement2c,x  		
		lda $12,x 				; stop movement in text state 
		cmp #$0001
		bne +
		stz.b RAM_X_event_slot_Movement2c,x  
	+	rtl 
	
	dungeonSkelly:
		LDA #$8e00
		STA $04,X 
		LDA #$00E0 
		STA $26,X 
		
		lda #$0001
		sta RAM_deathEntrance
		
		
		jsr NPCwalkAnimation
;		jsr walkBackAndForward
		
;		LDA.W #$C033 
;		sta $00
;		JSL.L spriteAnimationRoutine00       ;82B9EE|2269B082|82B069;  hijack Fix 
		
		
		jml NPCTextTrigger
	
}   

{; tutorial AutoPlay stuff ----------------------------------------------
		extraEndingFixes:
			lda !logicRingControlls
			stz.w !logicRingControlls
			pha 			
			jsl $80945B
			pla 
			sta !logicRingControlls
			rtl 
		
		moveOrbState00:
			LDA.W #$009C                         ;85FE61|A99C00  |      ;  
            JSL.L lunchSFXfromAccum              ;85FE64|22E38580|8085E3; stop pounding sound
            JSL.L musicFixFlagCheck              ;85FE68|229E8580|80859E;  
            LDA.W #$0100                         ;85FE6C|A90001  |      ; timer
            jml $85FE74      

		tutorialAutoPlay:						; unsupported ring stuff and scroll is missing.. 			
			lda #$0005
			sta $70
			LDA.B RAM_buttonMapJump              
            PHA                                  
            LDA.B RAM_buttonMapWhip              
            PHA                                  
            LDA.B RAM_buttonMapSubWep            
            PHA                                  
			lda !logicRingControlls
			pha 
			
			stz.w !logicRingControlls
			LDA.W #$8000                         
            STA.B RAM_buttonMapJump              
            LDA.W #$4000                         
            STA.B RAM_buttonMapWhip              
            LDA.W #$0010                         
            STA.B RAM_buttonMapSubWep            
            
			lda $4a
			cmp #$0002
			bne +
			JSL.L $809863              
			bra ++	
		+	cmp #$0003
			bne +
			jsl recordGameplay
			bra ++
		+	jsl playBackRecord		          
			
		++	lda #$0009
			sta $70
			
;			jsl $86C4BA							; afterBossSimonMovStuff ; RTL 

			jsl $80960b							; mainGameLoop 5 
			
			pla                                   
			sta !logicRingControlls
			pla 
			STA.B RAM_buttonMapSubWep                      
			PLA                                  
            STA.B RAM_buttonMapWhip              
            PLA                                  
            STA.B RAM_buttonMapJump    
			
			lda $38								; autoplay finished flag 
			beq +
			lda #$0005							; end autolay 
			sta $70
			stz $72
			stz $4a 
		+	rtl 
				
 
	gamPlayDataPointer: 	
			dw gameplayData00,gameplayData01,gameplayData02
	

		-	sta $1c0c			; starting setup 
			lda #$0005			; play indicator !armorType??			
			sta !armorType
			jsl doBlueSkinL
			lda $20
			sta $1c08
			rtl 
	recordGameplay:			
			lda !armorType			
			cmp #$0005
			bne -
			
;			lda $20,x 			; select to stop recording to prevent softlock 
;			bit #$2000
;			bne endRecording
			
			lda $1c06
			cmp #$0080
			bcc +
					
		endRecording:	
			lda #$0000			; restore amror end recording 
			ldx.w $1c00		
			inx
			inx
			inc $38
			lda $1c0c 			
;			cmp #$0005			; fail save to get back normal armor in case you screw around 
;			bne +
;			lda #$0000			
;		+
			sta !armorType
			lda.l $700100		; fix messed up first input 
			and #$00ff
			sta.l $700100		 
			bra ++			
			
		+	lda $20
			cmp $1c08			; detect different inputs 
			beq endRecord
			sta $1c08			
			
			ldx.w $1c00			; get table offset 
			lda.l $700000,X 
			ora $1c06			; store frames used for last input 
			sta.l $700000,X 
			inx
			inx
			
;			dec $1c06			; fix frame counts since we have extra frame with no input
;			lda $1c06
;			bne +
;			bpl +
;			stz.w $1c06
			
;			lda #$0001			; make frames with no inputs in bettween and record new inputs based on holdinput
;			sta.l $700000,X   
;			inx
;			inx 
			
			lda $20 			       
			and #$cf00
			sta $00
			lda $20
			and #$0010	
			xba		
			ora $00
		++	sta.L $700000,X   
;			inx
;			inx 
			stx $1c00
			stz.w $1c06 
		
		endRecord:	
			inc $1c06
			rtl 	
	playBackRecord:			
;			STZ.B RAM_X_event_slot_HitboxXpos    
;			LDA.B RAM_mainGameState              
;			CMP.W #$0005                         
;			BNE endRecord                     
			lda $20,x 			; select to stop recording to prevent softlock 
			bit #$2000
			beq +
			lda !armorType		; restore in case you come from recording 
			cmp #$0005
			bne ++
			lda $1c0c
			sta !armorType
			bra ++				; end playback 		
			
		+	STZ.B RAM_X_event_slot_HitboxXpos  
			LDA.W $1C06                          
			BNE +                      
			LDX.W $1c00         
			LDA.L $700000,X                      
			BEQ ++                      
			TAY                                  
			AND.W #$00FF                         
			STA.W $1C06                          
			INX                                  
			INX                                  
			STX.W $1c00         
			TYA                                  
			JSR.W decodeSequnetsBits             
			STA.B RAM_X_event_slot_sprite_assembly
			LDA.W $1C02                          
			ORA.B RAM_X_event_slot_sprite_assembly
			AND.B RAM_X_event_slot_sprite_assembly
			STA.B RAM_X_event_slot_HitboxXpos    
			LDA.B RAM_X_event_slot_sprite_assembly
			STA.W $1C02                        
  
		+	LDA.W $1C02                          
			STA.B RAM_X_event_slot_20            
			LDA.W $1C06                          
			DEC A                                
			STA.W $1C06                          
			RTL                                  
  
		++	LDA.W #$0001                         
            STA.B RAM_X_event_slot_38            
            RTL                                 
  decodeSequnetsBits: 
			AND.W #$FF00                         
            TAY                                  
            AND.W #$CF00                         
            STA.B $00
            TYA                                  
            XBA                                  
            AND.W #$0010                         
            ORA.B $00
            RTS                 
			

;asciiLookUpTable02:			; this is wastefull but lets hope I do not more space after this.. 
;		dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
;		dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
;		dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
;		dw $0000,$0000,$0000
;		dw $0CFF,$0CFD,$0CFE,$0CFE,$0C0A,$0CFE,$0CFE,$0CFC,$0CFE,$0CFE ;??
;		dw $0CFE,$0CFB,$2026,$0CFA,$0CFE
;		dw $2001,$2002,$2003,$2004,$2005 
;		dw $2006,$2007,$2008,$2009,$200A
;		dw $0CFE,$0CFE,$0CFE,$0CFE,$0CFE
;		dw $0CFE,$0CFE,$200B,$200C,$200D,$200E,$200F,$2010,$2011,$2012
;		dw $2013,$2014,$2015,$2016,$2017,$2018,$2019,$201A,$201B,$201C
;		dw $201D,$201E,$201F,$2020,$2021,$2022,$2023,$2024,$2025,$2026,$2027,$202e


; -------------------------- END NPC LOGIC MAIN -------------------------------------------

		
	whenGettingHit:		
		STA.B $bc 			; HijackFix RAM_simon_invulnerable_counter ;80DCDC|85BC    |0000BC;  
		STZ.B $80			; HijackFix RAM_simon_ForceGroundBehavier  ;80DCDE|6480    |000080;  		
		phx 				; search NPC slot and end text 
		ldx #$0580
	--	lda $10,x
		cmp #$000d
		beq +
	-	txa
		clc 
		adc #$0040
		tax 
		cpx #$1000
		bne --
		bra ++

	+	jsl clearTextOnly
		stz $12,x 			; reset npc 
		lda #$0003
		sta !textEngineState
		stz $f0				; clear text engine 
		stz $f2
		stz $f4
		stz $f6
		bra -
	++  plx
		rtl 
; ------------- General Routines -----------------

	SetDataBanktoA4:
		SEP #$20		;Change data bank
		LDA #$A4
		PHA     
		PLB     
		REP #$30
		RTL

	SetDataBanktoFF:
		SEP #$20		;Change data bank
		LDA #$ff
		PHA     
		PLB     
		REP #$30
		RTL

	SetDataBanktoA0:
		SEP #$20		;Change data bank
		LDA #$A0
		PHA     
		PLB     
		REP #$30
		RTL
	SetDataBankto81:
		SEP #$20	;Change data bank
		LDA #$81
		PHA     
		PLB     
		REP #$30
		RTL	

	loadPalettePracticeRing:
		lda $24,x
		bne endPaletteBatBa
		lda #$007e
		sta $fa
		lda #$23e0
		sta $f8
		
		ldy #$001e
	-	lda PalettePracticeRing,y 
		sta [$f8],y
		dey
		dey
		cpy #$0000
		bne -
		
		stz $fa
		stz $f8
		inc $24,x 
	endPaletteBatBa:
		rtl
	PalettePracticeRing:	 		; batbaFrames 37e84 palette and here too
;		db $00,$00,$B4,$72,$2F,$5E,$8A,$45,$E6,$34,$23,$11,$83,$08,$62,$04,$9A,$7F,$C4,$14,$00,$00,$7D,$57,$BD,$2E,$34,$09,$B0,$00,$48,$00
		db $C9,$20,$BE,$6F,$95,$42,$B0,$31,$4A,$21,$07,$11,$A2,$14,$62,$04,$36,$01,$CF,$00,$00,$00,$7D,$57,$BD,$2E,$34,$09,$B0,$00,$48,$00


pushPC

; -------------------- Hijacks ---------------------------------

org $8081CA				
		JML.L mainTextEngine
		nop 
;org $8283CB		; moved 2 SRAM.ASM 		
;		JSL.L startUpSetup ;Hijack for all the WRAM menu stuff.. setting up at power on and reset	
org $81A443 
		dl mainNPC					; dl CODE_83ECBE       ;81A443|        |83ECBE; 	ID $d OldMan with Dog		
org $80DCDC
		jsl whenGettingHit


; -------------------------------- automove hijacks 
org $85FE49							; orbRoutine Expansion 
		dw orbState_playWindMusic_00
org $85FE61
		dw orbState0c
warnPC $85FE71		

org $85FFDE							; freeSpace
		orbState0c:
			jml tutorialAutoPlay
		orbState_playWindMusic_00:
			jml moveOrbState00

; ---------------------- auto play ending ----------------------

org $80944D				; $83FBB5
		jsl extraEndingFixes

org $81EB27
pointerAutoPlaySequenceEnding: 					
		dw autoPlaySequenceEnding_data00     ;81EB27|        |9FF10A; ending autoplay data pointer
        dw autoPlaySequenceEnding_data01     ;81EB29|        |9FF11C;  
        dw autoPlaySequenceEnding_data02     ;81EB2B|        |9FF134;  
        dw autoPlaySequenceEnding_data03     ;81EB2D|        |9FF174;  
        dw autoPlaySequenceEnding_data04     ;81EB2F|        |9FF198;  
        dw autoPlaySequenceEnding_data05     ;81EB31|        |9FF1F8;  
        dw autoPlaySequenceEnding_data06     ;81EB33|        |9FF210;  
        dw autoPlaySequenceEnding_data07     ;81EB35|        |9FF230;  
        dw autoPlaySequenceEnding_data08     ;81EB37|        |9FF250;  
        dw autoPlaySequenceEnding_data09     ;81EB39|        |9FF272;  
        dw autoPlaySequenceEnding_data0a     ;81EB3B|        |9FF28E;  
        dw autoPlaySequenceEnding_data0b     ;81EB3D|        |9FF2AC;  
        dw autoPlaySequenceEnding_data0c     ;81EB3F|        |9FF2C8;  
        dw autoPlaySequenceEnding_data0d     ;81EB41|        |9FF2E8;  
        dw autoPlaySequenceEnding_data0e     ;81EB43|        |9FF32C;  
        dw autoPlaySequenceEnding_data0f     ;81EB45|        |9FF33C;  
        dw autoPlaySequenceEnding_data10     ;81EB47|        |9FF366;  
        dw autoPlaySequenceEnding_data11     ;81EB49|        |9FF37E;  

; ---------------------- demo autoplay -------------------------
org $818B31
	titleScreenMenu_data00: 
		dw demoAutoPlayData00                ;818B31|        |9FEF0E;  
		dw demoAutoPlayData01                ;818B33|        |9FEF78;  
		dw demoAutoPlayData02                ;818B35|        |9FF044;  
		dw demoAutoPlayData03                ;818B37|        |9FF084; 
	playDemosIntro_Level: 
		dw $001c,$000b,$0013,$0039           ;818B39|        |      ; 4 levels that are played in the demo
org $9FF10A	
	autoPlaySequenceEnding_data00:
		dw $0210,$8110,$44ff,$400e,$480a,$0810,$0050,$8120,$09cf,$0000
	autoPlaySequenceEnding_data01:
		dw $0168,$0810,$0020,$8080,$8080,$8080,$0000
	autoPlaySequenceEnding_data02:
		dw $0220,$8210,$4020,$0240,8210,$4040,$0008,$8210,$4220,$4650,$0208,$4420,$4118,$0220,$8230,$8230,$0260,$8001,$0010,$4260,$0000
	autoPlaySequenceEnding_data03:
		dw $0000
	autoPlaySequenceEnding_data04:
		dw $0110,$0440,$010c,$0201,$4010,$4120,$0000 
	autoPlaySequenceEnding_data05:
		dw $0000
	autoPlaySequenceEnding_data06:
		dw $0270,$8030,$4930,$0a10,$4140,$0440,$8930,$8240,$0810,$0020,$0000
	autoPlaySequenceEnding_data07:
		dw $4020,$0000
	autoPlaySequenceEnding_data08:
		dw $0190,$8114,$4420,$4220,$0008,$41f0,$0002,$4614,$0000
	autoPlaySequenceEnding_data09:
		dw $0120,$4030,$0110,$8130,$0120,$0040,$4020,$487c,$0104,$4430,$4050,$0000
	autoPlaySequenceEnding_data0a:
		dw $01f0,$0000
	autoPlaySequenceEnding_data0b:
		dw $0222,$0080,$0480,$00ff,$4010,$4120,$4010,$4120,$00ff,$0008,$0000 
	autoPlaySequenceEnding_data0c:
		dw $0530,$0040,$0110,$8230,$4a30,$0000
	autoPlaySequenceEnding_data0d:
		dw $0130,$8108,$4118,$4850,$0130,$4130,$4530,$0003,$4110,$0000
	autoPlaySequenceEnding_data0e:
		dw $0280,$0000
	autoPlaySequenceEnding_data0f:
		dw $0220,$8050,$4846,$4208,$0000
	autoPlaySequenceEnding_data10:
		dw $01a0,$0202,$00ff,$8110,$4a10,$0000
	autoPlaySequenceEnding_data11:
		dw $0208,$4820,$0018,$4840,$0208,$4080,$0240,$0140,$0000
	
org $9FEF0E
	demoAutoPlayData00:
;org $9FEF78
;	demoAutoPlayData01:
;org $9FF044
;	demoAutoPlayData02:
;org $9FF084
	demoAutoPlayData03:
		db $62,$02,$02,$08,$06,$01,$23,$00,$27,$01,$07,$05
		db $12,$45,$0C,$05,$18,$45,$20,$01,$2A,$05,$11,$01,$02,$41,$57,$45
		db $65,$41,$2D,$01,$08,$81,$06,$01,$01,$05,$01,$00,$03,$02,$01,$00
		db $06,$40,$19,$00,$08,$80,$0A,$00,$09,$40,$1E,$00,$0C,$01,$20,$05
		db $01,$04,$08,$00,$06,$80,$02,$00,$03,$01,$0E,$05,$0A,$45,$15,$05
		db $19,$01,$12,$41,$0B,$01,$05,$81,$02,$85,$05,$05,$08,$45,$0A,$05
		db $2F,$01,$05,$00,$13,$02,$0C,$00,$03,$01,$07,$81,$19,$01,$16,$00
		db $07,$80,$0F,$00,$08,$40,$16,$00,$01,$01,$08,$81,$0B,$01,$01,$41
		db $05,$40,$23,$02,$02,$82,$01,$80,$01,$08,$08,$01,$1F,$00,$07,$80
		db $0D,$00,$08,$40,$11,$00,$07,$01,$16,$41,$37,$01,$00,$00,$06,$00
		db $00,$00
	
warnPC $9ff10a 	
		
org $9FF3C4
		gameplayData00:				;  ; AA BC    AA=frames | B=8_jump,4_whip, 1_subweapon | C=D_PAD 
;			dw $0128,$c160,$4a50,$4041,
			db $28					; frame 
			db $01					; action 
			
			db $50					; first grab
			db $c1 
			
			db $04
			db $00 
			
			db $50					; next grab
			db $4a 
			
			db $40
			db $45
			
			db $18
			db $01
			
			db $30					; break 
			db $00
			
			db $18
			db $02
			
			db $30
			db $42

			db $30
			db $46

			db $04
			db $00

			db $40					; next grab
			db $49
			
			db $58
			db $46
			
			db $20
			db $02
		
			
			dw $0000
		gameplayData01:			
			db $1F
			db $00
			db $16
			db $00
			db $43
			db $02
			db $08
			db $82
			db $09
			db $02
			db $1E
			db $00
			db $03
			db $02
			db $06
			db $82
			db $01
			db $86
			db $06
			db $04
			db $44
			db $44
			db $02
			db $04
			db $54
			db $00
			db $02
			db $02
			db $07
			db $82
			db $01
			db $84
			db $07
			db $04
			db $37
			db $44
			db $08
			db $40
			db $08
			db $41
			db $49
			db $40
			db $4D
			db $00
			db $2C
			db $02
			db $04
			db $00
			db $0E
			db $01
			db $26
			db $00
			db $01
			db $01
			db $06
			db $81
			db $01
			db $01
			db $01
			db $05
			db $04
			db $04
			db $37
			db $44
			db $05
			db $40
			db $07
			db $42
			db $5E
			db $40
			db $39
			db $00
			db $06
			db $01
			db $12
			db $00
			db $03
			db $01
			db $07
			db $81
			db $01
			db $80
			db $01
			db $00
			db $0A
			db $04
			db $3B
			db $44
			db $1D
			db $40
			db $13
			db $42
			db $28
			db $40
			db $1C
			db $01
			db $2D
			db $00
			db $1F
			db $02
			db $01
			db $0A
			db $01
			db $08
			db $04
			db $01
			db $00
			db $00
;			db $50			; hand made 
;			db $02 
;			
;			db $18
;			db $82
;			
;			db $20
;			db $00
;			
;			db $10
;			db $82
;			
;			db $60			; first glitch
;			db $44
;			
;			db $30
;			db $45
;			
;			db $10
;			db $00
;			
;			db $10
;			db $01
;			
;			db $0e
;			db $81
;			
;			db $40			; second gitch 
;			db $44
;			
;			db $30
;			db $42			
		gameplayData02:
			db $1F
			db $00
			db $0B
			db $00
			db $19
			db $01
			db $07
			db $81
			db $11
			db $01
			db $03
			db $00
			db $18
			db $40
			db $3E
			db $49
			db $02
			db $48
			db $01
			db $42
			db $03
			db $02
			db $03
			db $06
			db $10
			db $46
			db $02
			db $42
			db $04
			db $02
			db $01
			db $06
			db $09
			db $04
			db $2F
			db $44
			db $04
			db $40
			db $0E
			db $41
			db $16
			db $40
			db $03
			db $42
			db $2E
			db $02
			db $3B
			db $00
			db $1C
			db $01
			db $07
			db $81
			db $01
			db $01
			db $03
			db $00
			db $0C
			db $04
			db $1D
			db $44
			db $05
			db $40
			db $17
			db $42
			db $20
			db $40
			db $01
			db $42
			db $10
			db $46
			db $2A
			db $42
			db $19
			db $02


			dw $0000
		demoAutoPlayData02:			;9FF3C4
			db $03,$00,$0A,$04,$0C,$44,$10,$04,$0E,$44,$0B,$04,$13,$44,$10,$04
			db $16,$44,$03,$04,$0A,$02,$13,$42,$3D,$02,$05,$86,$11,$C6,$02,$46
			db $03,$06,$12,$02,$28,$00,$03,$02,$0A,$82,$1F,$02,$05,$00,$0D,$80
			db $20,$00,$04,$80,$0E,$82,$0B,$40,$11,$00,$09,$80,$01,$82,$04,$06
			db $0C,$46,$05,$06,$01,$02,$0E,$00,$07,$80,$0D,$C0,$0C,$CA,$23,$42
			db $0C,$46,$09,$42,$03,$02,$13,$00,$17,$01,$05,$81,$03,$80,$07,$C0
			db $05,$C4,$22,$44,$01,$46,$08,$42,$18,$40,$04,$00,$19,$02,$01,$0A
			db $04,$01,$01,$00,$15,$40,$07,$00,$1D,$40,$08,$00,$06,$02,$02,$0A
			db $0A,$4A,$04,$42,$03,$40,$16,$00,$14,$02,$05,$00,$11,$01,$05,$81
			db $30,$01
			db $06,$01,$04,$09,$12,$49,$09,$09,$12,$49,$02,$42,$12,$02,$17,$42
			db $0A,$02,$19,$42,$21,$02,$14,$45,$0F,$00,$10,$48,$10,$00,$10,$48
			db $3C,$02,$10,$82,$0D,$02,$0E,$82,$01,$08,$02,$00,$0A,$01,$02,$00
			db $12,$02,$09,$82,$0E,$02,$13,$00,$09,$80,$06,$00,$06,$40,$02,$42
			db $01,$40,$17,$00,$04,$82,$06,$86,$0F,$C6,$03,$46,$01,$06,$32,$02
			db $01,$08,$01,$00,$04,$01,$10,$00,$FF,$08,$00,$00
		demoAutoPlayData01:	
			db $30,$01,$0A,$81,$2D,$01,$33,$00,$1F,$40,$20,$00,$1B,$40,$08,$00
			db $17,$40,$07,$00,$08,$04,$14,$44,$16,$04,$0A,$00,$3A,$48,$06,$40
			db $13,$00,$0A,$02,$09,$00,$06,$01,$03,$00,$0E,$40,$0F,$48,$04,$08
			db $18,$48,$01,$08,$13,$00,$04,$01,$40,$00,$0B,$40,$13,$48,$05,$40
			db $1D,$00,$15,$40,$08,$00,$05,$04,$15,$44,$08,$04,$07,$00,$1C,$40
			db $10,$44,$04,$40,$06,$00,$03,$01,$02,$81,$0A,$85,$10,$C5,$04,$45
			db $01,$05,$59,$01,$08,$81,$01,$01,$1D,$41,$05,$01,$58,$00,$08,$40
			db $2C,$48,$03,$40,$0B,$00,$0E,$40,$03,$48,$04,$4A,$03,$0A,$01,$08
			db $00,$00
	
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
		
	goNextTextSetBGMode2:
		stz.w $46 
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
		dw $89f0,jungLadyFr1,oldManBrawnPents00,oldMan3Fr1				; 0c
		dw doorSpriteAssembly,oldManFr1,AssGuy,oldManFr1				; 10
		dw oldMan3Fr1,oldManFr1,AssPaul,doorSpriteAssembly,jungLadyFr1	; 14
		dw jungLadyFr1,jungLadyFr1,jungLadyFr1,doorSpriteAssembly		; 18
		dw AssAramus00,$8af4,oldManBrawnPents00,headlessKnightNPC								; 1c 
		
	
	npcSpriteIDlist2:	
		dw oldMan3Fr2,jungLadyFr1,oldManFr2,jungLadyFr1					; 00 zombie Walk $96a0,$968b 
		dw oldManFr2,oldMan3Fr2,jungLadyFr1,jungLadyFr1					; 04
		dw jungLadyFr1,oldMan3Fr2,$968b,jungLadyFr1						; 08 $8f2e	
		dw $968b,jungLadyFr1,oldManBrawnPents01,oldMan3Fr2						; 0c 
		dw doorSpriteAssembly,oldManFr2,AssGuy,oldManFr1					; 10
		dw oldMan3Fr2,oldManFr1,AssPaul,doorSpriteAssembly,jungLadyFr1	; 14
		dw jungLadyFr1,jungLadyFr1,jungLadyFr1,doorSpriteAssembly		; 18	
		dw AssAramus01,$8af4,oldManBrawnPents01,headlessKnightNPC													; 1c 
	
	

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
		dw redguyText13,endText
	
	redguyText00:	
		db "HELLO           "
		db "YES I AM        "
		db "THE WIZARD      "		
		db "OF THE TOWN.",$00	
	redguyText01:
		db "I DID COME TO   "
		db "FIND THE DRAGON."
		db "AND TAME IT!!",00
	redguyText02:		
		db "HOPFULLY NO ONE "
		db "KILLS THAT OLD  "
		db "BEAST..",$00
	redguyText03:		
		db ".. WHAT IS THAT "
		db "SHINY ROCK?     "
		db "OHH.. YOU DID   "
		db "KILL IT!!",$00
	redguyText04:	
		db "I HAD LIKE TO   "
		db "REVIEVE THE     "
		db "DRAGON! BUT I   "
		db "WILL NEED THE",00
	redguyText05:		
		db "DEAMON ORB! IF  "
		db "YOU GIVE ME     "
		db "THE ORB. AS A   "
		db "EXCHANGE",$00 
	redguyText06:		
		db "I GIVE YOU A    "
		db "MAGIC WHIP.     "
		db "THE WHIP IS.    "
		db "EMPOWERED.",00
	redguyText07:
		db "IT ALSO LOSES   "
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
		db "SWITCH THE WHIP.",$00
	redguyText10:
		db "I TOKE THE GUY  "
		db "FROM THE TOWN TO"
		db "HELP ME HERE..",00	
	redguyText11:	
		db "HE MANAGED TO   "
		db "SCARE THE DRAGON"
		db "OUT OF THE CAVE.",00		
	redguyText12:
		db "I SEND HIM TO   "
		db "THE TOWN NORTH  "
		db "FROM HERE TO    "
		db "WARN THEM.",00	
	redguyText13:
		db "I DO HAVE A BAD "
		db "FEELING..",00		
	
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
		db "THE CAVE.",00
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
		dw BarKeeperText01,goNextTextWithSound
		dw BarKeeperText02,goNextText
		dw BarKeeperText03,goNextText
		dw BarKeeperText04,endText
		
	BarKeeperText00:
		db "I HAVE NEVER    "
		db "SEEN SOMEONE GO "
		db "OVER MY BAR LIKE"
		db "THIS!",$00
	BarKeeperText01:	
		db "ARE YOU THAT    "
		db "THIRSTY? HEHE   "
		db "ONE IS ON THE   "
		db "HOUSE.",$00
	BarKeeperText02:
		db "UP STAIRS WILL  "
		db "BE TRAINING FOR "
		db "BELMONTS WHO    "
		db "NEED PREPERATION",$00
	BarKeeperText03:
		db "THE BACKDOOR    "
		db "WILL LEED YOU TO"
		db "THE GRAVYARD.",$00
	BarKeeperText04:
		db "HOPFULLY YOU    "
		db "MANAGE TO LIFT  "
		db "THE CURSES      "
		db "AROUND HERE.",$00

	actionListTutorialLeady00:
		dw TutorialLeadyText00,goNextText
		dw TutorialLeadyText01,endText

	
	TutorialLeadyText00:	
		db "WHEN YOU LET GO "
		db "AT THE PEAK OF  "
		db "A SWING. YOU CAN"
		db "WHIP THE RING",$00
	TutorialLeadyText01:	
		db "ABOVE WHEN YOU  "
		db "DIAGONAL WHIP   "
		db "RIGHT AFTER.",$00
	
	actionListTutorialLeady01:
		dw TutorialLeadyText02,goNextText
		dw TutorialLeadyText03,goNextText
		dw TutorialLeadyText04,endText

	TutorialLeadyText02:	
		db "WHEN YOU WHIP   "
		db "DOWN OR LIMP    "
		db "WHIP AT THE     "
		db "CENTER ABOVE",$00
	TutorialLeadyText03:	
		db "THE RING. YOU   "
		db "CAN FLOAT STILL "
		db "IF YOU DO NOT   "
		db "USE THE DPAD.",$00
	TutorialLeadyText04:	
		db "THEN TAPING THE "
		db "OPPOSIT SIDE ON "
		db "THE DPAD YOU    "
		db "LIKE TO MOVE.",$00	

	actionListTutorialLeady02:	
		dw TutorialLeadyText05,goNextText
		dw TutorialLeadyText06,goNextText
		dw TutorialLeadyText07,goNextText
		dw TutorialLeadyText08,goNextText
		dw TutorialLeadyText09,spawnSmallHeartAndText
;		dw TutorialLeadyText10,spawnSmallHeartAndText
;		dw TutorialLeadyText11,endText
	
	TutorialLeadyText05:
		db "YOU CAN RING    "
		db "GLITCH WHEN ON A"
		db "RING TOO. FOR   "
		db "THIS PULL CLOSE",$00
	TutorialLeadyText06:	
		db "TO THE RING. AT "
		db "THE RIGHT SIDE  "
		db "PEAK LET GO AND "
		db "DO A DIAGONAL",$00
	TutorialLeadyText07:	
		db "DOWN WHIP.      "
		db "FOLLOW UP WITH A"
		db "DOWN WHIP AND   "
		db "YOU SHOULD SIT",$00
	TutorialLeadyText08:	
		db "STILL ON THE    "
		db "RING. TRY TO GO "
		db "UP THIS LEDGE   "
		db "AGAIN.",$00
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
		dw BuilderManDoinaText03,endText,$00
		
	BuilderManDoinaText00:
		db "I CLOSED UP SOME"
		db "HOLES.. NOW THE "
		db "MONSTERS COME   "
		db "THROUGH SLOWER",$00
	BuilderManDoinaText01:
		db "I DID USE A SPY "
		db "GLASS TO LOOK AT"
		db "THE CASTLE. I   "
		db "WONDER HOW IT",$00
	BuilderManDoinaText02:	
		db "STAND AT ALL    "
		db "THAT MANY HOLES "
		db "IT HAS.",$00
	BuilderManDoinaText03:	
		db "SOMETHING LIFING"
		db "IN THE WALLS    "
		db "UP THERE TO KEEP"
		db "IT STANDING..",$00
	
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
		db "I DID HERE      "
		db "ROWDIN MARGE THE"
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
		

	actionListTipLeady01:
		dw whipText00,goNextText
		dw whipText01,goNextText
		dw whipText02,goNextText
		dw whipText03,goNextText
		dw whipText04,goNextText	
		dw whipText05,endText	
	
	whipText00:
		db "IT IS GETTING   "
		db "DARK REALLY     "
		db "QUICK HERE..    "
		db "YOU GOT MY",00
	whipText01:	
		db "BROTERS WHIP?   "
		db "REMEMBER THE    "
		db "LEATHER WHIP IS "
		db "BETTER SUITED",00 
	whipText02:		
		db "FOR PLATFORMING."
		db "TRY SWITCHING ON"
		db "DIFFERENT TASKS."
	whipText03:
		db "ON RINGS TRY TO "
		db "FULLY EDTANDED  "
		db "THE WHIP..",00
	whipText04:
		db "THEN IT SHOULD  "
		db "BE EASY TO MOVE "
		db "TO THE NEXT ONE!"
		db "ALSO I NEVER",00
	whipText05:		
		db "SEEN A TREE THIS"
		db "TALL. I WONDER  "
		db "WHAT IS ON TOP  "
		db "OF IT..",00	

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
		db ".. VAMP VACCIN.."		
		db "ABOUT THE GUY..",00		
	moon2Text03:
		db "AS MUCH I LIKE  "
		db "TO SEE HIM GONE "
		db "WHAT HAPPEN IS  "
		db "SO BAD..",00
	moon2Text04:
		db "HE IS MARKED AND"
		db "WILL TURNE INTO "
		db "A VAMPIRE..",00
	moon2Text05:
		db "DO NOT TRY TO   "
		db "SAVE HIM. IT IS "
		db "A TRAP. THE GUY "
		db "WITH THE KEY.",00
	moon2Text06:
		db "HE WAS SEND TO  "
		db "DECIVE YOU. BE  "
		db "WARNED. THERE IS"
		db "ONLY DEATH YOU",00
	moon2Text07:
		db "WILL FIND DOWN  "
		db "THERE. JUST GO  "
		db "AFTER THE COUNT "
		db "AS LONG HE",00	
	moon2Text08:
		db "DOES NOT GROW   "
		db "GROW TOO        "
		db "POWERFULL..",00
	moon2Text09:
		db "YOU SEEM THE    "
		db "ONLY ONE STRONG "
		db "ENOUGH. DO SAVE "
		db "THE LAND",00
	moon2Text0a:
		db "PLEASE DO NOT   "
		db "FALL FOR THIS   "
		db "TRAP. YOU ARE   "
		db "TOO IMPORTANT.",00		

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
		dw headlessText00,goNextTextSetBGMode2	
		dw headlessText01,goNextText
		dw headlessText02,goNextText
		dw headlessText03,goNextText
		dw headlessText04,goNextText
		dw headlessText05,endText
	
	
	headlessText00:	
		db "BUTT!!",00		; noone will see you say butt butt we did 
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
		db "THE CLOSER HE IS"
		db "TO THE PEAK",00
	headlessText04:	
		db "THE HIGHER HE   "
		db "LUNCHES IN THE  "
		db "AIR AGAIN!",00
	headlessText05:	
		db "HIS LEFT SIDE   "
		db "SWING IS A LOT  "
		db "WEAKER THOUGH..",00	
	
	
}
	
	
{	; Shop and Text Routines ----------------------------------------------------------
	
	curserPos:
		lda $36,x 
		and #$00ff
		beq ++
		 
		tay  			
		lda #$0000		; clear old Curser
		sta $7fff00
		sta $7fff20
		sta $7fff40
		sta $7fff60
		
		lda #$2c27 			; 2c2e set Curser
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
	++  rts	
	
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
		stz $36,x 
		
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
		jsr getArmor
		
	skipShopItem03:
		cpy #$0004
		bne skipShopItem04	
		lda #$0000	; heart Cost
		jsr checkCash
		bcs skipShopItem04		
;		lda #$0024	; itemID
;		jsr getItemFromShop
		jsr removeCheats
		
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

		jsr getArmor
		lda $34,x		; skip two text pointer
		clc 
		adc #$0004
		sta $34,x 
		
	skipGiftItem03:
		cpy #$0004
		bne endGiftItem04	
	
		jsr removeCheats
		
	endGiftItem04:		
		jsl goNextText
		rtl 
	giveLeash:
		lda #$0001
		sta !dogLeash
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
		sty !armorType		; set flag for blue armor 1e1a
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
		lda #$0002
		sta !ownedWhipTypes
		stz !armorType
		stz !allSubweapon
		stz $92 
		
		lda #$77b8
		sta $7e2310 
		lda #$4e70
		sta $7e2312
		lda #$2528
		sta $7e2314
		lda #$0482
		sta $7e2316
		rts
	
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
		sta !allSubweapon 
		rts 

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
	endText:
		stz $f0			; delete Pointers (section is used in transition and game over)
		stz $f2 		
		stz $f4
		stz $f6 
		
		stz $34,x 
		stz $32,x		; make sure we start to write at the beginning		
		stz $12,x		; reset NPC
		stz $1fa2		; make player move again 
		lda #$0001		; terminate textUpdate 2 PPU
		sta !textEngineState
		rtl 
	

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
	
	NPCRedguy:
	NPCStateOldMan03:
	NPCStateOldMan02:
	NPCbossQuestGiver:	
	RedguysBrother:
		jsr NPCwalkAnimation		
		jsr walkBackAndForward
		jml NPCTextTrigger		
	BarKeeper00:
		jsr walkOnSpot
		jsr NPCwalkAnimation		
		jml NPCTextTrigger	
	TutorialLeady00:
		jsl faceSimon
		jsr loadPalettePracticeRing		
		jml NPCTextTrigger	

	aramus:
		jsr NPCwalkAnimation
		jsr walkBackAndForward
		bra +

	hooker:
	Tinnue:
		jsl faceSimon
		lda $04,x 
		ora #$0e00
		sta $04,x 
		bra +
	ArmorSeller:
	TutorialLeady01:
	TutorialLeady02:
	TutorialLadyControls:
		jsl faceSimon
+		jml NPCTextTrigger	
	
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
		
	+	jml NPCTextTrigger

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
	
	BarManDoinaKeySeller:		
		jml NPCStateOldMan02
	
	BuilderManDoina:
		jml BarKeeper00
		
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
		cmp #$0002
		bne ++
	
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
		
	TipLeady00:		; IS DRESSED AS A MAN LOL dont fix it hehe 
		jml TutorialLeady01
	
	TipLeady01:
		jsl makePaletteDark
		jsl faceSimon
		jsl NPCTextTrigger
		jsl	resetBG3Scroll
		rtl 
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
 
}   


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
		rts
	PalettePracticeRing:	 		; batbaFrames 37e84 palette and here too
		db $00,$00,$B4,$72,$2F,$5E,$8A,$45,$E6,$34,$23,$11,$83,$08,$62,$04,$9A,$7F,$C4,$14,$00,$00,$7D,$57,$BD,$2E,$34,$09,$B0,$00,$48,$00


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

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
		  
        SEP #$20                             
        REP #$10                
		
		LDX.W #$5802       	; line 5                   
        STX.W $2116                          
        LDA.B #$7F                           
        LDX.W #$FF88                         
        LDY.W #$001C  		; size of data to transphere                       
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
		dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
		dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
		dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
		dw $0000,$0000,$0000
		dw $0CFF,$0CFD,$0CFE,$0CFE,$0C0A,$0CFE,$0CFE,$0CFC,$0CFE,$0CFE ;??
		dw $0CFE,$0CFB,$2026,$0CFA,$0CFE
		dw $2001,$2002,$2003,$2004,$2005 
		dw $2006,$2007,$2008,$2009,$200A
		dw $0CFE,$0CFE,$0CFE,$0CFE,$0CFE
		dw $0CFE,$0CFE,$200B,$200C,$200D,$200E,$200F,$2010,$2011,$2012
		dw $2013,$2014,$2015,$2016,$2017,$2018,$2019,$201A,$201B,$201C
		dw $201D,$201E,$201F,$2020,$2021,$2022,$2023,$2024,$2025,$2026,$2027,$202e



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
		
	
	goNextText:
		inc $34,X
		inc $34,X
		
		jsr loadTextPointer			
		jsl clearTextOnly
		rtl				; actions also end the state..


}

{	; NPC Text ------------------------------------------------------------------------
	npcSpriteIDlist:			; list is based in subID $14																		
		dw oldMan3Fr1,jungLadyFr1,oldManFr1,jungLadyFr1,oldManFr1,oldMan3Fr1,jungLadyFr1,jungLadyFr1,jungLadyFr1,oldMan3Fr1,$89f0,jungLadyFr1
		dw $89f0,jungLadyFr1,oldManFr1,oldMan3Fr1,doorSpriteAssembly,oldManFr1,oldMan3Fr2,oldManFr1
		; $8f15
	npcSpriteIDlist2:	
		dw oldMan3Fr2,jungLadyFr1,oldManFr2,jungLadyFr1,oldManFr2,oldMan3Fr2,jungLadyFr1,jungLadyFr1,jungLadyFr1,oldMan3Fr2,$968b,jungLadyFr1		; $8f2e
		dw $968b,jungLadyFr1,oldManFr2,oldMan3Fr2,doorSpriteAssembly,oldManFr2,$0000,oldManFr1
	; zombie Walk $96a0,$968b 

	mainNPCStateTable: 
		dw NPCState00			; init
		dw NPCText01	   		; mainText
		dw NPCStateOldMan02	   	; man sells cheats
		dw NPCStateOldMan03		; lady gives cheats
		dw NPCRedguy			; redguy aka town wizard
		dw MoonLady
		dw RedguysBrother
		dw BarKeeper00
		dw TutorialLeady00
		dw TutorialLeady01
		dw TutorialLeady02
		dw BarKeeper02Doina	
		dw ZombieManDoina
		dw ZombieManDoinaWife
		dw ZombieManDoinaHunter
		dw ZombieManDoinaWifeSecond	; 0d
		dw BarManDoina
		dw BuilderManDoina
		dw door
		dw RedguyLiftingCurse   ; 11
		dw TipLeady00			; 12
		dw TipLeady01			; 13
		
	actionListMainNPC:
		dw actionSeller,actionListGivingLady
		dw actionListRedguy
		dw actionListMoonLady
		dw actionListRedguysBrother
		dw actionListBarKeeper00
		dw actionListTutorialLeady00
		dw actionListTutorialLeady01
		dw actionListTutorialLeady02
		dw actionListBarKeeper02
		dw actionListZombieManDoina
		dw actionListZombieManDoinaWife
		dw actionListZombieManDoinaHunter
		dw actionListZombieManDoinaWifeSecond
		dw actionListBarManDoina
		dw actionListBuilderManDoina
		dw $0000
		dw actionRedguyLiftingCurse
		dw actionListTipLeady00
		dw actionListTipLeady01

	
	actionSeller:
;		dw text00,goNextText
;		dw text01,goNextText
		dw text02,initCurser
		dw text03,shopRoutine
		dw text04,goNextText
		dw text05,endText
		dw text06,endText
	
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
	text06:	
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
		db "STUFF FOR FREE  ",$00
		
	guideMan02:	
		db "IN CASE YOU ARE "
		db "NOT UP FOR THE  "
		db "TRUE CHELLANGE  ",$00
		
	guideMan03:	
		db "  1 NOTHING     "
		db "  2 BIG WHIP    "
		db "  3 ARMORE      "
		db "  4 REMOVE CHEAT",$00

	guideMan04:
		db "GL ON YOUR RUN  ",$00

	guideMan05:	
		db "THE BIG WHIP    "
		db "JUST DOES A LOT "
		db "OF DAMAGE BUT   "
		db "NEED UPGRADE TOO",$00
		
	guideMan06:	
		db "PRESS L AND     "
		db "D PAD TO CHOOSE "
		db "SUBWEAPONS OR   "
		db "A FOR STOPWATCH ",$00	

	actionListRedguy:
		dw redguyText00,goNextText
		dw redguyText01,goNextText
		dw redguyText02,goNextText
		dw redguyText03,goNextText
		dw redguyText04,goNextText
		dw redguyText05,goNextTextWithSoundGetWhip2
		dw redguyText06,goNextText
		dw redguyText07,goNextText
		dw redguyText08,goNextText
		dw redguyText09,goNextText
		dw redguyText10,goNextText
		dw redguyText11,goNextText
		dw redguyText12,endText
	
	redguyText00:	
		db "HELLO           "
		db "YES I AM        "
		db "THE WIZARD      "		
		db "OF THE TOWN.",$00	
	redguyText01:
		db "I DID COME TO   "
		db "FIND THE DRAGON."
		db "WITH HELP OF MY "
		db "ALLY. WE PLAN",$00
	redguyText02:		
		db "TO TAME IT.     "
		db "HOPFULLY NO ONE "
		db "KILLS THE OLD   "
		db "BEAST.",$00
	redguyText03:		
		db "WHAT IS THAT    "
		db "SHINY ROCK?     "
		db "OHH.. YOU DID?  "
		db "WELL I CAN",$00
	redguyText04:		
		db "REVIEVE IT WHEN "
		db "YOU GIVE ME     "
		db "THE ORB. AS A   "
		db "EXCHANGE",$00 
	redguyText05:		
		db "I GIVE YOU A    "
		db "MAGIC WHIP.     "
		db "THAT IS ALREADY "
		db "FULLY UPGRADET. ",$00

	redguyText06:
		db "PRESSING SELECT "
		db "WILL LET YOU    "
		db "SWITCH THE WHIP.",$00
	redguyText07:
		db "WHEN YOU LOSE   "
		db "YOU NEED TO     "
		db "POWER IT UP     "
		db "AGAIN.",$00
		
	redguyText08:	
		db "MY ALLY HEADED  "
		db "NORTH TO THE    "
		db "NEXT TAVERN.    ",$00
	redguyText09:	
		db "I WONDER WHAT   "
		db "HAPPEN TO HIM.  "
		db "HE IS AWAY FOR  "
		db "WAY TOO LONG.",$00
	redguyText10:	
		db "IF YOU FIND HIM "
		db "DRUNK THEN MAKE "
		db "US OF THAT WHIP."
		db "TELL HIM",$00
	redguyText11:	
		db "THAT THE DRAGON "
		db "IS DEAD AND WE  "
		db "WILL NEED TO",$00
	redguyText12:	
		db "FIND A OTHER    "
		db "WAY TO FIGHT    "
		db "DRACULA.",$00

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
		dw RedguysBrotherText03,endText
		
	RedguysBrotherText00:
		db "OUR WIZARD LEFT "
		db "TOWN TO GO TO   "
		db "THE CAVE. THINGS"
		db "ARE BAD HERE",$00
	RedguysBrotherText01:
		db "SINCE HE LEFT.  "
		db "HE DID KNOW TO  "
		db "FIGHT OFF THIS  "
		db "MONSTERS.",$00
	RedguysBrotherText02:
		db "THE WIZARD IS MY"
		db "BROTHER BUT..",$00	
	RedguysBrotherText03:
		db "I AM NOTHING    "
		db "LIKE HIM..      "
		db "WE GONA DIE..",$00

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
		db "THIS.",$00
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
		db "CENTER ABOVE    ",$00
	TutorialLeadyText03:	
		db "THE RING. YOU   "
		db "CAN FLOAT STILL "
		db "IF YOU DO NOT   "
		db "USE THE DPAD",$00
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
		dw TutorialLeadyText09,goNextText
		dw TutorialLeadyText10,spawnSmallHeartAndText
		dw TutorialLeadyText11,endText
	
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
	TutorialLeadyText10:
		db "I DID PREPARE A "	
		db "PARKOUR AT THE  "
		db "GRAVYARD TO     "
		db "PRACTICE MORE.",$00
	TutorialLeadyText11:
		db "GOOD LUCK AND   "	
		db "HAVE FUN TO     "
		db "MASTER YOUR     "
		db "WHIP SKILLS.",$00	
	
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
		db "RUN RUN..       "
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
		db "TAKE US ALL.",$00
		
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
		db "POOR SOUL. BUT  "
		db "THAT GUY DOES   "
		db "EAT OUT OF THE",$00
	ZombieManDoinaHunterText02:		
		db "HAND OF A DEAMON"
		db "HE DOMED US HERE"
		db "WITH HIS BLIND  "
		db "ACTIONS.",$00
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
		dw ZombieManDoinaWifeSecondText04,endText
		
		
	ZombieManDoinaWifeSecondText00:
		db "WE NEED TO FIND "
		db "A CURE FOR MY   "
		db "MAN.. PLEASE HE "
		db "MEANS EVERYTHING",$00
	ZombieManDoinaWifeSecondText01:	
		db "TO ME. HE WAS   "
		db "HUMBLE AND DID  "
		db "BRING LOVE IN   "
		db "DARK TIMES",$00
	ZombieManDoinaWifeSecondText02:
		db "WE MIGHT NOT    "
		db "MAKE IT WITHOUT "
		db "HIM.. PLEASE .. "
		db "UAHHH HA.. CRY..",$00
	
	ZombieManDoinaWifeSecondText03:
		db "THIS IS A WEAPON"
		db "MY MAN USED TO  "
		db "PROTECT US..",$00	
	ZombieManDoinaWifeSecondText04:
		db "YOU MONSTER YOU "
		db "KILLED HIM..",$00
		
		
	actionListBarManDoina:
		dw BarManDoinaText00,goNextText
		dw BarManDoinaText01,goNextText
		dw BarManDoinaText02,goNextText
		dw BarManDoinaText03,initCurser
		dw BarManDoinaText04,shopRoutineKey
		dw BarManDoinaText05,endText
		dw BarManDoinaText06,endText
		dw text06,endText
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
		db "   YES 20K GOLD ",$00
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
		db "THERE MUST BE   "
		db "SOMETHING LIFING"
		db "IN THE WALLS TO "
		db "KEEP IT STANDING",$00
	
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
		dw whipText03,endText	
	
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
		db "ALSO I NEVER",00
	whipText03:		
		db "SEEN A TREE THIS"
		db "TALL. I WONDER  "
		db "WHAT IS ON TOP  "
		db "OF IT..",00	
	
}
	
	
{	; Shop and Text Routines ----------------------------------------------------------
	
	curserPos:
		lda $36,x 
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
	
	shopRoutineKey:
		lda $36,x 
		stz $36,x 
		tay 
		cpy #$0002
		bne endShopRoutine
		
		lda RAM_simon_multiShot		; only get item once 
		cmp #$0002
		beq +
		lda #$2000   			; Cost	; curse remove	
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
		jsl goNextText
		
		phy		
		jsl $82AFB6		; get empty event onto y register		
		lda #$0018
		sta.w $10,y
		lda $0a,x
		adc #$0020
		sta.w $0a,y
		lda $0e,x 
		sbc #$00c0
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
		lda #$0002
		sta $12,x 
		lda #$0047
		sta $2e,x 
		rtl 
	
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
		
	
	NPCStateOldMan02:		; typical NPC routine
		jsr NPCwalkAnimation
		jsr walkBackAndForward
		jml NPCTextTrigger	; text trigger has rtl at the end what will end the routine

    NPCStateOldMan03:		
		jsr NPCwalkAnimation	
		jsr walkBackAndForward
		jml NPCTextTrigger
		        
	NPCRedguy:
		jsr NPCwalkAnimation		
		jsr walkBackAndForward
		jml NPCTextTrigger
	
	MoonLady:
		jsr NPCwalkAnimation		
		jml NPCTextTrigger
		
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
	TutorialLeady01:
		jsl faceSimon	
		jml NPCTextTrigger	
	TutorialLeady02:
		jsl faceSimon
		jml NPCTextTrigger	
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
		lda !ownedWhipTypes
		cmp #$0003
		bne +
		jsl clearSelectedEventSlotAll
	+	jml ZombieManDoina
		
	ZombieManDoinaWifeSecond:
		jsl ZombieManDoinaWife

		lda !ownedWhipTypes
		cmp #$0003
		bne +
		lda $34,x 
		cmp #$0006
		bcs +
		lda #$0006
		sta $34,x 	

	+	rtl 
	
	BarManDoina:		
		jml NPCStateOldMan02
	
	BuilderManDoina:
		jml BarKeeper00
		
	door:
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
		rtl 
		
	+	stz $2e,x 
	++	rtl 

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

	resetBG3Scroll:
		lda.l !textEngineState
		beq +
		lda #$0000
		bra ++
	+	lda #$000b
	++	sta $46 		; cheep fix just changing a setting also fixes a issue with restoring this BG since we write to first screen 		; 46 #$0b00
		rtl 
	
	makePaletteDark:
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
		rtl 

;		lda $22,x 		; a experiment with palettes.. 
;		bne +
;		lda #$ffff
;		sta $22,x 
;		sta $20,x
;
;	+	lda $3a
;		and #$0001
;		beq ++
;		
;		lda $20,x 
;		sec 
;		sbc #$1111
;		bcc +
;		sta $20,x 
;		
;	+	lda $20,x 
;		sta $00
;		phx 
;		ldx #$0020
;	-	lda.l $7e2220,x 
;		and $00 
;		sta.l $7e2220,x 
;		dex
;		dex
;		bpl -
;		plx
;	++	rtl 
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

; ---------------------------- general Labels for common routines -----------------------------
org $808189
	RNGgetMix00:
org $808C59
	clearSelectedEventSlotAll:	
org $82B3F4
	clearCurrentEventSlot:
org $8090E9	
	bossGetPaletteY2X:
org $82B069
	spriteAnimationRoutine00:
org $81A49A
	dl NewBossMain			; boss fixes for event 2f are in tutorialHackTweaks as well
org $829327
	BossMain:	
org $8085E3
	sfxLunch:
	lunchSFXfromAccum:	
org $8280DD
	musicLunch:
org $80859E
	musicLunchFix:			; wish I would know better what it does and could find a better name 
org $80D7F1
	getEmptyEventSlot:      
org $82B407
	gravetyFallCalculation2000:     ;85DB52|2207B482|82B407;  
org $82B459
	gravetyFallCalculation4000:      ;839895|2259B482|82B459;  
org $82D647
	getPixleOffsetXposAwayFromSimon:		;86C56F|2247D682|82D647;  		
org $80CF86
	readCollusionTable7e4000:       ;8289E5|2286CF80|80CF86;  

org $81f93a					; palette animation chandelire BG dest 
	dw $2200

pullPC 
; ---------------------------- boss routines  ------------------- 
	NewBossMain:			; skip boss with defeated flag
		lda !flagSkipBoss
		beq +
		jsl $808C59		;WipeEventSlot		
		rtl 
	
	+	jml BossMain

{	; bossVIPER
	NewViperShootingInterfall:
		INC.W $09A2                         
        LDA $e6                    
		and #$0177          ; make it based on some bits in RNG
        BEQ +
        RTL                   
	+	jml $82E839			; will shot 3 fireballs	
}

	
{	; bossMEDUSA
	newBossMedusaState00: 
		LDA.W $0590                       
        STA.B $10,X                       
        LDA.W $058A                       
        STA.B $0A,X                       
        LDA.W $058E                       
        STA.B $0E,X                       
        STZ.W $0590                       
        LDY.W #$CBB4                      
        LDX.W #$1240                    
        JSL.L $8090E9 	; bossGetPaletteY2X 
        LDX.W #$0D80                      
        LDA.W #$0003                      
        STA.B $2C,X                       
        LDA.W #$0F13                      
        STA.B $0A,X                       
        LDA.W #$00a1	; $0085                      
        STA.B $0E,X                       
        LDA.W #$0200                      
        STA.B $06,X                       
        STA.B $30,X                       
        LDA.W #$0010                      
        STA.L $8013F6                     
        LDA.W #$0083                      
        STA.B $10,X                       
        LDA.W #$B1AC                      
        STA.B RAM_general,X               
        LDA.W #$0000                      
        STA.B $04,X                       
        LDA.W #$0047                      
        STA.B $2E,X                       
        LDA.W #$0010          		; 20            
        STA.B $28,X      				
        LDA.W #$0018                      
        STA.B $2A,X                       
        LDA.W #$0002                      
        STA.B $12,X                       
        RTL                               
    newBossMedusaState01: 
		JSL.L bossMedusaMovement          
		LDA.W #$CA96                      
		STA.B RAM_general                 
		JSL.L spriteAnimationRoutine00						; spriteAnimationRoutine00     
		JSL.L $82ED4C						; CODE_82ED4C        
		LDA.B RAM_frameCounter_effectiv     ; $78
		AND.W #$0030                         
		LSR A                                
		LSR A                                
		TAY                                  
		LDA.W bossMedusaSpeedTableLeft,Y     
		STA.B $1A,X                          
		LDA.W bossMedusaSpeedSubTableLeft,Y  
		STA.B $18,X                          
		LDA.B $0A,X                          
		CMP.W #$0ED3                         
		BCC +
		RTL                                  
	 
	+	STZ.B $22,X         				 ; start boss routines 
        STZ.B $24,X                            
        LDA.W #$0002                           
        STA.B $12,X                            
        RTL                                    
	
	newBossMedusaState02:
		jsl newActionWhenHit
		JSL.L bossMedusaMovement             
        LDA.W #$CA96                         
        STA.B RAM_general                    
        JSL.L spriteAnimationRoutine00						; spriteAnimationRoutine00       
        JSL.L $82ED4C 						; CODE_82ED4C                    
        LDA.B RAM_frameCounter_effectiv      
        AND.W #$0030                         
        LSR A                                
        LSR A                                
        TAY                                  
        LDA.W bossMedusaSpeedTableLeft,Y     
        STA.B $1A,X                          
        LDA.W bossMedusaSpeedSubTableLeft,Y                
        STA.B $18,X                          
        LDA.B $0A,X                          
        CMP.W #$0E20		; #$0E70  	; left side border                       
        BCC +                      
        LDA.B $22,X                          
        BNE endMedusaState                      
        LDA.B RAM_RNG_2                      
        AND.W #$0007                         
        CMP.W #$0002                         
        BEQ +                      
    endMedusaState: 
		RTL                                   

	+	LDA.W #$0003                         
        STA.B $12,X                          
        RTL                                  
    newBossMedusaState03: 
		jsl newActionWhenHit
		JSL.L bossMedusaMovement             
        LDA.W #$CA96                         
        STA.B RAM_general                    
        JSL.L  spriteAnimationRoutine00		; spriteAnimationRoutine00         
        JSL.L CODE_82ED4C                    
        LDA.B RAM_frameCounter_effectiv      
        AND.W #$0030                         
        LSR A                                
        LSR A                                
        TAY                                  
        LDA.W bossMedusaSpeedTableRight,Y    
        STA.B $1A,X                          
        LDA.W bossMedusaSubSpeedTableRight,Y                
        STA.B $18,X                          
        LDA.B $0A,X                          
        CMP.W #$0F00     	; right Side border                    
        BCS +                      
        LDA.B $22,X                          
        BNE endMedusaState                      
        LDA.B RAM_RNG_2                      
        AND.W #$0007                         
        CMP.W #$0004                         
        BEQ +                      
        RTL                                  
 
	+	LDA.W #$0002                         
        STA.B $12,X                          
        RTL                                  

    CODE_82ED4C: 
		STZ.W $05EC                          
        LDA.B $0A,X                          
        STA.W $05CA                          
        LDA.B $0E,X                          
        STA.W $05CE                          
        LDA.B $04,X                          
        STA.W $05C4                          
        LDX.W #$05C0                         
        LDA.B RAM_subGameState,X             
        BNE CODE_82ED72                      
        LDA.W #$CB64                         
        STA.B RAM_general                    
        JSL.L  spriteAnimationRoutine00		; spriteAnimationRoutine00      
        LDX.W #$0D80                         
        RTL                                  
    CODE_82ED72: 
		DEC.B RAM_subGameState,X             
        LDA.W #$CB76                         
        STA.B RAM_general                    
        JSL.L  spriteAnimationRoutine00		; spriteAnimationRoutine00       
        LDX.W #$0D80                         
        RTL              
	
	bossMedusaMovement: 
		LDY.W #$0700                         
    CODE_82EE2A: 
		LDA.W RAM_81_X_event_slot_ID,Y       
        BNE CODE_82EE3E                      
        JSL.L $82EE4A					; bossMedusaGroundSnake          
        JSL.L $82EE87 					; bossMedusaSnakeAir             
        JSL.L $82EED5					; bossMedusaStoneBeemInitCheck   
        JMP.W CODE_82EE49                  
    CODE_82EE3E: 
		TYA                                
        CLC                                
        ADC.W #$0040                       
        TAY                                
        CPY.W #$0D40					; #$0D40                       
        BCC CODE_82EE2A                    
    CODE_82EE49: 
		RTL                                
	
	newActionWhenHit:						
		lda.l $8013f6					; x 14 health compare 20 free
		cmp $30,x
		bne +
		rtl 
	+	lda #$0005
		sta $12,x
		rtl 
	
	newBossMedusaState05:
		lda $20,x
		bne +
	
		stz $18,x						; init jump 
		stz $1a,x
		stz $1c,x
		lda #$fffb						; start speed 
		sta $1e,x
		
	+	inc $20,x						; count jump frames
		
;		LDY.W #$0700
;		jsl $82EE33						; throw snakes air
		jsr projectilesMedusa
		jsr jumpMovementHight
		jsr jumpMedusaXpos
		

		lda $22,x						; speed up animation tail 
		sec
		sbc #$0003
		bmi +
		sta $22,x
	+	LDA.W #$CA96
		sta $00
		JSL.L spriteAnimationRoutine00					; animation 
		JSL.L $82ED4C					; ldx #$05c0 head update?? 
		rtl 
	
	jumpMovementHight:
		lda $1c,x
		sec
		sbc #$2000
		sta $1c,x
		bcs +
		inc $1e,x					
		
	+	lda $1e,x
		bmi +
		lda $0e,x					; check ground hight
		and #$00f0
		cmp #$00a0
		bne +

		stz $20,x					; end jump state 
		stz $1e,x					; reset speed
		stz $1c,x
		
		lda #$0002					; set walking routine 
		sta $12,x  
	
		lda #$00a1					; set proper hight
		sta $0e,x
		
		jsl faceSimon

;		ldy #$0700
;		jsl $82EEF8				; stoneBeam
	+	rts 
	
	jumpMedusaXpos:
		lda $04,x 
		beq ++
		lda #$2000				; moving right
		clc
		adc $18,x
		sta $18,x
		lda #$0000
		adc $1a,x
		cmp #$0003
		beq +
		sta $1a,x
	+	lda $0a,x
		cmp #$0f00
		bcc +
		stz $18,x
		stz $1a,x
	+	rts 
	++	lda $18,x
		sec
		sbc	#$2000
		sta $18,x
		bcc +
		lda $1a,x
		sec
		sbc #$0001
		cmp #$fffc
		beq +
		sta $1a,x
	+	lda $0a,x
		cmp #$0e20
		bcs +
		stz $18,x
		stz $1a,x
	+	rts 				; moving left 
	
	projectilesMedusa:
		LDY.W #$0700 
	-	LDA.W RAM_81_X_event_slot_ID,Y      
        BNE +                     

        JSL.L $82EE87 		; bossMedusaSnakeAir               
        JSL.L $82EED5		; bossMedusaStoneBeemInitCheck     
        rts 
      
	  + TYA                        
        CLC                        
        ADC.W #$0040               
        TAY                        
        CPY.W #$0D40               
        BCC -                      
		rts                        

    newSnakeThrowSpeedCalc: 
		lda $0e,x
		bne +
		stz $1c,x				; set speed 2 zero before it leaves the screen on top
		stz $1e,x
		
	+	LDA.B $1c,X               ;82B459|B51C    |00001C;  
        CLC                                  ;82B45B|18      |      ;  
        ADC.W #$4000                         ;82B45C|690040  |      ;  
        STA.B $1c,X               ;82B45F|951C    |00001C;  
        LDA.B $1e,X               ;82B461|B51E    |00001E;  
        ADC.W #$0000                         ;82B463|690000  |      ;  
        STA.B $1e,X               ;82B466|951E    |00001E;  
        BMI +                      ;82B468|30C5    |82B42F;  
        LDA.B $1c,X               ;82B46A|B51C    |00001C;  
        SEC                                  ;82B46C|38      |      ;  
        SBC.W #$0000                         ;82B46D|E90000  |      ;  
        LDA.B $1e,X               ;82B470|B51E    |00001E;  
        SBC.W #$0004                         ;82B472|E90400  |      ;  
        BCC +                      ;82B475|90B8    |82B42F;  
        LDA.W #$0000                         ;82B477|A90000  |      ;  
        STA.B $1c,X               ;82B47A|951C    |00001C;  
        LDA.W #$0004                         ;82B47C|A90400  |      ;  
        STA.B $1e,X               ;82B47F|951E    |00001E;  
    +   RTL

	newStoneBeemDirection:
		lda $54a
		cmp $0a,x
		bmi +
		lda #$0002
		bra ++
	+	lda #$fffe
	++	sta.w $001a,y
		rtl 

	newStoneBeemExtras:
		lda #$0000
		sta.w $0032,y 
		lda $0e,x
		and #$00f0
		lsr
		lsr
		lsr
		lsr 
		and #$0006
		phx
		tax
		lda.l stoneBeemYSpeedTable,x
		plx
		sta.w $001e,y 
		rtl 
	stoneBeemYSpeedTable:
;		dw $0004,$0002,$0001,$0000
		dw $0000,$0001,$0002,$0003
}		

{	; bossPUWEXIL 	
	
	puwexilNewHealthHud:
		pha 		; make his sprite non transperant after finishing palette animation 
		lda $1250	
		bne +
		stz $44
	+
		pla 
		lsr
		lsr
		lsr
		lsr
		lsr
		rtl
	
	newPuwexilState03:
		lda $22,x 
		clc
		adc #$0001
		sta $22,x 
		cmp #$0060
		beq +
		JSL.L findSimonsXposFor00 			; moves to simons hight
		LDA.B RAM_X_event_slot_yPos,X       
        CMP.W RAM_81_simonSlot_Ypos          
        BEQ +                   
        BCS ++                     
        STZ.B RAM_X_event_slot_ySpd,X      	; move down constant  
        LDA.W #$A000                         
        STA.B RAM_X_event_slot_ySpdSub,X     
        RTL                                  
	+	jml returnScriptStateStopYposSpeed
	++	jml moveUpConstant6000	


	newPuwexilMentosSpawn:
		LDA.B RAM_frameCounter_effectiv      ;82F881|A578    |000078;  
        AND.W #$000F                         ;82F883|290F00  |      ;  
        STA.W RAM_81_X_event_slot_24,Y       ;82F886|992400  |810024;  
        LDA.W #$0002                         ;82F889|A90200  |      ;  
        STA.W RAM_81_X_event_slot_ID,Y       ;82F88C|991000  |810010;  
        LDA.W #$0003                         ;82F88F|A90300  |      ;  
        STA.W RAM_81_X_event_slot_Movement2c,Y;82F892|992C00  |81002C;  
        LDA.W #$0008                         ;82F895|A90800  |      ;  
        STA.W RAM_81_X_event_slot_HitboxXpos,Y;82F898|992800  |810028;  
        STA.W RAM_81_X_event_slot_HitboxYpos,Y;82F89B|992A00  |81002A;  
        LDA.W #$0000                         ;82F89E|A90000  |      ;  
        STA.W RAM_81_X_event_slot_state,Y    ;82F8A1|991200  |810012;  
        LDA.W #$0047                         ;82F8A4|A94700  |      ;  
        STA.W RAM_81_X_event_slot_HitboxID,Y ;82F8A7|992E00  |81002E;  
        LDA.W #$0001		; #$0001      mentosHealth
        STA.W RAM_81_X_event_slot_event_slot_health,Y;82F8AD|990600  |810006;  
 ;       LDA.W #$0000                         ;82F8B0|A90000  |      ;  
		lda.w $58e			; boss  Ypos 
		STA.W RAM_81_X_event_slot_yPos,Y     ;82F8B3|990E00  |81000E;  
;        LDA.B RAM_RNG_2                      ;82F8B6|A5E8    |0000E8;  
		lda.w $58a			; boss Xpos
		pha 
		lda $04,x
		beq +
		pla 
		sbc #$0018
		bra ++
    +   pla 
		ADC.W #$0018                         ;82F8BC|690003  |      ;  
    ++  STA.W RAM_81_X_event_slot_xPos,Y     ;82F8BF|990A00  |81000A;       
		rtl 
		
	newMentosRoutine:			; let it exalerate around puwexil 
		
;		jsl mentosBoundingBoxYpos
		jsl mentosBoundingBoxXpos
		lda $0a,x
		cmp $58a
		bpl +
	
		lda RAM_81_X_event_slot_xSpdSub,x	; xPos acceleration
		clc 
		adc #$1800
		sta RAM_81_X_event_slot_xSpdSub,x	
		lda #$0000
		adc RAM_81_X_event_slot_xSpd,x	
		sta RAM_81_X_event_slot_xSpd,x	
		bra ++ 
		
	+	lda RAM_81_X_event_slot_xSpdSub,x
		sec  
		sbc #$1800
		sta RAM_81_X_event_slot_xSpdSub,x	
		lda RAM_81_X_event_slot_xSpd,x
		sbc #$0000
		sta RAM_81_X_event_slot_xSpd,x
		
	++	lda $0e,x							; yPos acceleratio
		cmp $58e
		bpl +
		
		lda RAM_81_X_event_slot_ySpdSub,x
		clc 
		adc #$1800
		sta RAM_81_X_event_slot_ySpdSub,x	
		lda #$0000
		adc RAM_81_X_event_slot_ySpd,x	
		sta RAM_81_X_event_slot_ySpd,x	
		bra ++
	
	+	lda RAM_81_X_event_slot_ySpdSub,x
		sec  
		sbc #$1800
		sta RAM_81_X_event_slot_ySpdSub,x	
		lda RAM_81_X_event_slot_ySpd,x
		sbc #$0000
		sta RAM_81_X_event_slot_ySpd,x
		
	++	rtl 
	
	
	mentosBoundingBoxYpos: 
		LDA.B RAM_X_event_slot_yPos,X   
        CMP.W #$0110                    
        BCS setMentosIntoBoundBottom     
        CMP.W #$0000                    
        BCC setPuxilIntoBoundTop        
        RTL                             
   setMentosIntoBoundBottom: 
		LDA.W #$0110                    
        STA.B RAM_X_event_slot_yPos,X   
        RTL                                                                    
   setPuxilIntoBoundTop: 
		LDA.W #$0000                  
        STA.B RAM_X_event_slot_yPos,X   
        RTL 
		
	mentosBoundingBoxXpos:
		LDA.B RAM_X_event_slot_xPos,X   
        CMP.W #$0410                  
        BCS setMentosIntoBoundRight      
        CMP.W #$02f0                
        BCC setMentosIntoBoundLeft       
        RTL                             
	setMentosIntoBoundRight: 
		LDA.W #$0410                  
        STA.B RAM_X_event_slot_xPos,X   
        RTL                             
	setMentosIntoBoundLeft: 
		LDA.W #$02f0                 
        STA.B RAM_X_event_slot_xPos,X   
        RTL                             
 
	newPuwxilIntro:
		lda #$8018			; set sprite prio to be in front of the gate
		sta $02,x 
		jsl faceSimon
		jsl $80FEA5			; speed calc moving up 
		
		LDA.W #$0030 	;#$0090                         ;82F2D0|A99000  |      ;  
        CMP.B RAM_X_event_slot_yPos,X        ;82F2D3|D50E    |00000E;  
        bcs + ; BCC +
        RTL                                  
	
	+	lda $2e,x 
		bne +
		lda #$0047
		sta $2e,x 			; make it hitable and hurt
        lda #$0000
		sta RAM_81_X_event_slot_ySpdSub,x
		sta RAM_81_X_event_slot_ySpd,x

		lda #$0009				; special starting state?
		sta $12,X   
		
		JSL.L CODE_82F250	; spawn a mentos and make it look like it hurt 		
		
	+	stz $02,x			; set prio to be behind again
		jml $82F2D8			; continue routine

	newPuwxilRightMovmentCap:
		SBC.W #$0002                         ;82F3F0|E90300  |      ;  
        BCS +                     ;82F3F3|B001    |82F3F6;  
		rtl 

	+	lda #$0002
		STA.B RAM_X_event_slot_xSpd,X
		lda #$0000
		STA.B RAM_X_event_slot_xSpdSub,X
		
		lda RAM_X_event_slot_xPos,x		; check left screen border
		cmp #$03e0
		bcs +
		rtl 
	+	jml stopPuexilsXposMovment 
		
	newPuwxilLeftMovmentCap:	
		ADC.W #$0002                         ;82F45B|690300  |      ;  
        BCC +                      ;82F45E|9096    |82F3F6;  
		rtl              
	
	+	lda #$FFFD
		STA.B RAM_X_event_slot_xSpd,X
		lda #$0000
		STA.B RAM_X_event_slot_xSpdSub,X
		
		sec 
		lda RAM_X_event_slot_xPos,x		; check right screen border
		cmp #$0320
		bcc +
		rtl 
	+	jml stopPuexilsXposMovment 	
	
	puwexilScript:		
		LDA.B RAM_X_event_slot_32,X          
        CMP.W #$0000   
		bne +	
		jml CODE_82F334 
 ;       jsl firstFacePuw                    
      + CMP.W #$0001                         
       	bne +
		jml CODE_82F32E
;	    jsl secondFacePuw		
      + CMP.W #$0002                         
        bne +         
		jml CODE_82F33A		
      + CMP.W #$0003                         
        bne +
		jml CODE_82F367
	  + CMP.W #$0004                         
        bne +
		jml newPuwexilJump
      + STZ.B RAM_X_event_slot_32,X          		
		RTL

	newPuwexilJump:
		jsl faceSimon
		lda #$FFFC
		sta RAM_X_event_slot_ySpd,X
		lda #$0007
		sta $12,x 
		rtl 

	newPuwexilState07:		
		jsl $80FE74		; speed calc moving down 
		
		lda RAM_X_event_slot_22,X
		clc
		adc #$0001
		sta RAM_X_event_slot_22,X
		cmp #$0030
		
		
		bne +
		
		lda RAM_X_event_slot_32,X 			; reset and finish scrip
		clc
		adc #$0001
		sta RAM_X_event_slot_32,X 
		STZ.B RAM_X_event_slot_36,X          ;82F35B|7436    |000036;  
        STZ.B RAM_X_event_slot_22,X          ;82F35D|7422    |000022;  
        STZ.B RAM_X_event_slot_24,X
		lda #$0002
		sta $12,x 
	+	rtl 
	
;	initateFinalPuwexilForm:
;		lda #$000d				; final form State
;		STA.W $0592  
;		rtl 

	specialStartingState09Puwexil:
		jsl faceSimon
		lda $e6 	; RNGgetMix00
		and #$00ff
		ora #$0300
		sta RAM_X_event_slot_xPos,x
		
		lda RAM_X_event_slot_22,X
		clc
		adc #$0001
		sta RAM_X_event_slot_22,X
		cmp #$0030
		bne +
		
		lda #$0001
		sta $12,x 
		lda #$0000
		sta RAM_X_event_slot_22,X
	+	rtl 

	makeMentosDangerous:		; for final form 
		phx 
		ldx #$a40 
	-	lda #$0047
		sta $2e,x 		; make them hitable and not despawn
		lda #$0001
		sta $06,x 		; give health 
		lda #$0008		; give hitbox 
		sta $28,x
		sta $2a,x
		txa
		clc
		adc #$0040
		tax 
		cmp #$0e40
		bne -
		plx
		rtl 
	
	fixwiredBugPuwexil:
		JSL.L $82FA22                    ;82F672|2222FA82|82FA22;  get rig of skull
		lda #$80d2			; restore something that might need to be cleared.. 
		sta $e80			; fix wired bug what is this even used for. How did it fail to clear?? 	
		rtl 

	finalFightPuwexilState0e:
		phx 
		ldx #$580
		
		lda #$81a4					; orb sprite 
		sta $00,x 
		lda #$0007					; visual remove bg  
		sta $42
		lda #$000b					; transparent 
		sta $44				
		
		lda $58a					; tracking Simon
		cmp $54a
		bpl +
	
		lda RAM_81_X_event_slot_xSpdSub,x	; xPos acceleration
		clc 
		adc #$0800
		sta RAM_81_X_event_slot_xSpdSub,x	
		lda #$0000
		adc RAM_81_X_event_slot_xSpd,x	
		sta RAM_81_X_event_slot_xSpd,x	
		cmp #$0001					; cap speed 
		bne ++
		stz.b RAM_81_X_event_slot_xSpdSub,x
		bra ++ 
		
	+	lda RAM_81_X_event_slot_xSpdSub,x
		sec  
		sbc #$0800
		sta RAM_81_X_event_slot_xSpdSub,x	
		lda RAM_81_X_event_slot_xSpd,x
		sbc #$0000
		sta RAM_81_X_event_slot_xSpd,x
		cmp #$fffe					; cap speed 
		bne ++
		sta RAM_81_X_event_slot_xSpdSub,x
		
	++	lda $58e					; tracking Simon
		adc #$0040					; offset above simon
		cmp $54e
		bpl +
		
		lda RAM_81_X_event_slot_ySpdSub,x
		clc 
		adc #$0400
		sta RAM_81_X_event_slot_ySpdSub,x	
		lda #$0000
		adc RAM_81_X_event_slot_ySpd,x	
		sta RAM_81_X_event_slot_ySpd,x	
		cmp #$0001					; cap speed 
		bne ++
		lda #$ffff
		sta RAM_81_X_event_slot_ySpdSub,x
		bra ++ 
	
	+	lda RAM_81_X_event_slot_ySpdSub,x
		sec  
		sbc #$0400
		sta RAM_81_X_event_slot_ySpdSub,x	
		lda RAM_81_X_event_slot_ySpd,x
		sbc #$0000 
		sta RAM_81_X_event_slot_ySpd,x
		cmp #$fffe					; cap speed 
		bne ++
		lda #$ffff
		sta RAM_81_X_event_slot_ySpdSub,x
		bra ++ 
		
		 			
	++	ldx #$a40 		; calculate enemies killed 
	-	lda $00,x 
		bne +
		inc $5a0
		
	+	txa
		clc
		adc #$0040
		tax 
		cmp #$0e40
		bne -
	
		plx 	
		lda #$0010 		; update heatlh
		sec
		sbc $5a0
		sta $13f6
		cmp #$0000
		bne +
		lda #$0000
		sta $2c,x  
;		sta RAM_81_X_event_slot_xSpd
;		sta RAM_81_X_event_slot_xSpdSub
;		sta RAM_81_X_event_slot_ySpd
;		sta RAM_81_X_event_slot_ySpdSub 
		
		inc.b $12,x 
		JSL.L $808584                    ;82F241|22848580|808584;  
        JSL.L $80859E                    ;82F245|229E8580|80859E;  
		
		LDA.W #$009b		;#$009B                     
        JML.L sfxLunch
		
	+	stz $05a0 		; reset counter for next health calculation 
		rtl 
	
	finalFightPuwexilState0f:		
		lda $580		; move orb ot other slot and let it move up 
		sta $600
		lda $58a
		sta $60a
		lda $58e
		sta $60e
		lda #$0001
		sta $610
		
		lda #$0003
		sta $62c
		lda #$fffe
		sta $61e
		stz $618
		stz $61a
		stz $61c



		stz $580		; remove sprite 	does look fun when the orb is flying off.. might be backed into the lore..
		lda #$0000
		sta $42			; make bg appear again 
		sta $44			; remove transparencies 
		
		lda #$0008
		sta $40				; white conter effect 
		
		stz $05a2
		inc $0592		; new ending state 
		
		lda #$0003		; set new entrance 
		sta $13d4

		lda $86 			; set boss as defeated to not respawn on reloads 
		sta !flagSkipBoss

		
		lda #$0036
		jsl musicLunch
		JML musicLunchFix
		
	
	finalFightPuwexilState10:
		inc $5a2
		lda $5a2 
		cmp #$0100
		bne +
		lda #$0003
		sta $70	
;		lda #$000c
;		sta.w $0592 
	+	rtl 	


		
	finalPuwexilFormTewak:	; should prevent more mentos to be spawned in the final fight 
		sec 
		lda $592
		cmp #$000c
		bcc +
		JSL.L CODE_82F8EB                    ;82F8E0|22EBF882|82F8EB;  
	+	rtl 	

	bossArenaBounderiesMain: 
		LDA.B RAM_X_event_slot_state,X       ;82F1A1|B512    |000012;  
        CMP.W #$000f		; #$000B                         ;82F1A3|C90B00  |      ;  
        BCS +                      ;82F1A6|B00D    |82F1B5;  
        CMP.W #$0002                         ;82F1A8|C90200  |      ;  
        BCC +                      ;82F1AB|9008    |82F1B5;  
  
		JSL.L bossArenaBounderiesXpos                    ;82F1AD|22B6F182|82F1B6;  
		JSL.L bossArenaBounderiesYpos                   ; haveing movment seperated of the boss movement will brake many things
      
	  + RTL                             
		
    bossArenaBounderiesXpos: 						; moved to make space
		LDA.B RAM_X_event_slot_xPos,X   
        CMP.W #$03F0                    
        BCS setPuxilIntoBoundRight      
        CMP.W #$0310                    
        BCC setPuxilIntoBoundLeft       
        RTL                             
                                        
    bossArenaBounderiesYpos: 
		LDA.B RAM_X_event_slot_yPos,X   
        CMP.W #$0090                    
        BCS setPuxilIntoBoundBottom     
        CMP.W #$0010                    
        BCC setMentosIntoBoundTop        
        RTL                             
                                        
	setPuxilIntoBoundRight: 
		LDA.W #$03F0                    
        STA.B RAM_X_event_slot_xPos,X   
        RTL                             
                                        
                                        
   setPuxilIntoBoundLeft: 
		LDA.W #$0310                    
        STA.B RAM_X_event_slot_xPos,X   
        RTL                             
                                        
   setPuxilIntoBoundBottom: 
		LDA.W #$0090                    
        STA.B RAM_X_event_slot_yPos,X   
        RTL                             
                                        
   setMentosIntoBoundTop: 
		LDA.W #$0010                    
        STA.B RAM_X_event_slot_yPos,X   
        RTL  

	upateSpeed2Pixle:
		rtl 		; CODE_80C8B5
}	

{	; bossROWDIN

	newInitRowdin:							
		LDY.W #$C687                         ; palettePointerID
        LDX.W #$1240                         ; UpdateSlot palette
        JSL.L bossGetPaletteY2X                
        LDX.W #$0580                         ; main event Slot
        STZ.B RAM_X_event_slot_Movement2c,X    
        LDA.W #$0810                         ; xPos
        STA.B RAM_X_event_slot_xPos,X          
        STA.W $078A                           
        LDA.W #$00AD                         ; yPos
        STA.B RAM_X_event_slot_yPos,X          
        STA.W $078E                            
        JSL.L bossRowdinInit     ; $82D775 ; horsehead?? Neck??             
        LDA.W #$0080                           
        STA.B RAM_X_event_slot_24,X            
        STA.B RAM_X_event_slot_xSpd,X        ; SpeedXpos
        LDA.W #$0080                         ; rowdinBoss ID
        STA.B RAM_X_event_slot_ID,X            
        LDA.W #$0047                         ; hitBox hitable and hurt
        STA.W $05AE                            
        LDA.W #$0001                           
        STA.W $07AE                            
        LDA.W RAM_81_simonSlot_spritePriority  
        STA.W $0582                            
        STA.W $0782                            
        LDA.W #$0400			; #$0200                         ; bossHealth
        STA.W RAM_81_X_event_slot_event_slot_health,X
        LDA.W #$0010                         ;82D762|A91000  |      ; bossHealthHUD
        STA.L $8013F6                        
        LDA.W #$0003                         
        STA.W $07AC                          
        LDA.W #$0001                         
        STA.B RAM_X_event_slot_state,X       
		
		lda #$fffe  			; initial start speed horse 
		sta $79a	
		lda #$8000
		sta $798
	   
		RTL                                  

	bossHealthHUDRowdin:
		lsr
		lsr
		lsr
		lsr
		lsr
		rtl 

	newRowdinWalkRoutine:		
	+	lda #$00ac 
		sta $0e,x 		; keep horse on level it is sinking.. who knows why?
		
		lda $0a,x 
		cmp #$0780 
		bmi ++
		
		lda $18,x 
		sec 
		sbc #$0400
		sta $18,x 
		lda $1a,x 
		sbc #$0000
		cmp #$fffc
		beq +
		sta $1a,x 
		bra changeStateToWalkOne
			
	+	lda #$fffc			; max speed cap 
		sta $1a,x 
		lda #$ffff
		sta $18,x 
		bra changeStateToWalkOne
		
	++	lda $18,x 
		clc
		adc #$0400 
		sta $18,x
		lda #$0000		
		adc $1a,x 
		cmp #$0003
		beq +
		sta $1a,x 
		bra changeStateToWalkOne
	
	+	lda #$0003		 ; max speed cap 	
		sta $1a,x 
		lda #$0000
		sta $18,x 
		bra changeStateToWalkOne

;		lda #$4000
;		sta $04,x
;		sta $744
;		sta $704
;		sta $6c4
;		sta $684
;		sta $644
;		sta $604
;		sta $5c4
;		sta $584
;		
;		LDA $07B0      		;780 horseBody          
;		BNE rowdHorseWalk2            
;		
;
;		INC $0A,X  			;xpos  
;		INC $0A,X  			
;		LDA $0A,X                
;		CMP #$0810     		;checks right side border          
;		BCS ++             
;		RTL                      
;    
;	++ 	STZ $22,X                
;		LDA #$0001               
;		STA $07B0                
;		JMP changeStateToWalkOne               
;	
;	rowdHorseWalk2:
;		stz $04,x
;		stz $744
;		stz $704
;		stz $6c4
;		stz $684
;		stz $644
;		stz $604
;		stz $5c4
;		stz $584
;		
;		DEC $0A,X 
;		DEC $0A,X 	
;		LDA $0A,X                
;		CMP #$06f0              ;checks left side border
;		BCC +++              
;		RTL                      
;      
;	+++	STZ $22,X                
;		STZ $07B0                
;		JMP changeStateToWalkOne                
	
	changeHorseFacing:
		sta $04,x
		sta $744
		sta $704
		sta $6c4
		sta $684
		sta $644
		sta $604
		sta $5c4
		sta $584
		rts 
	changeStateToWalkOne:
		lda $1a,x 
		bmi +
		lda #$4000
		bra ++

	+	lda #$0000
	++	jsr changeHorseFacing
				
	;	STZ $24,X       	; used in inccrese.. crashs without ??         
	;	LDA #$0001               
	;	STA $0012,X 

		lda $78a			; based on movment Pos.. hacky thing.. 
		sta $7a2 		
;		inc $7a2			; animation 	
		jsl $82E22D
		
	-	
		RTL                      
	
	newFirballLunchCheck:
		lda $584			; lunch when turning 
		cmp $594 
		beq ++
		lda $594
		cmp #$6666			; delay for one frame or the fireball will lunch from the wrong poing 
		beq +
		lda #$6666
		sta $594
		bra ++
	+	lda $584
		sta $594 
		lda #$0001
	++	rtl
	newRowdinLunchFireball:	

		BCS -              
	
		LDA #$0003               
		STA $002C,Y              
		LDA #$0000               
		STA $0012,Y              
		STA $0018,Y              
		
		lda $784
		cmp #$4000
		bne	ShootLeftSide
		lda #$0003
		bra StoreFireballSpeed
	ShootLeftSide:	
		LDA #$FFFd    		;xSpeed           
	StoreFireballSpeed:	
		STA $001A,Y              
		LDA #$4000     	;ySubSpeed  
	;	sta $0018,y		;add some subspeed
		STA $001C,Y              
		LDA #$0000         ;ySpeed      
		STA $001E,Y              
		LDA #$0003			;ID               
		STA $0010,Y              
		LDA #$B02E        ;SpriteID       
		STA $0000,Y              
		LDX #$0580               
		LDA $0A,X                
		STA $000A,Y              
		LDA $08,X                
		STA $0008,Y              
		LDA $0E,X                
		STA $000E,Y              
		LDA $0C,X                
		STA $000C,Y              
		LDX #$0780               
		
		lda $04,x
		sta $0004,y
		
		LDA $26,X                
		STA $0026,Y              
		LDA $02,X                
		STA $0002,Y              
		LDA #$0047               
		STA $002E,Y              
		LDA #$0004               
		STA $0006,Y              
		LDA $0542                
		STA $0002,Y              
		LDA #$0004			;#$0002       ;xhitBox        
		STA $0028,Y              
		LDA #$0004 				;#$0002       ;yhitBox         
		STA $002A,Y              
		RTL          

	newFireBallRowHorse:
		PHY                                  ;82E16A|5A      |      ;  
        INC.B RAM_X_event_slot_24,X          ;82E16B|F624    |000024;  
        LDA.B RAM_X_event_slot_24,X          ;82E16D|B524    |000024;  
        AND.W #$0004                         ;82E16F|290400  |      ;  
        LSR A                                ;82E172|4A      |      ;  
        TAY                                  ;82E173|A8      |      ;  
        LDA.W $81C6AA,Y		; PTR16_81C6AA,Y                 ;82E174|B9AAC6  |81C6AA;  
        STA.B $00,X                          ;82E177|9500    |000000;  
        PLY                                  ;82E179|7A      |      ;
		
		lda $54e 
		cmp $0e,x 
		bmi +
		lda #$0400
		clc 
		adc $1c,x
		sta $1c,x 
		lda #$0000
		adc $1e,x 
		sta $1e,x 
		rtl 

	+	lda $1c,x 
		sec 
		sbc #$0400
		sta $1c,x 
		lda $1e,x
		sbc #$0000 
		sta $1e,x 
		rtl 
	
	headMovmentForBackAndForward:
	    lda $784
		bne +
		
		LDA.W $05A4
		AND.W #$FFFE                         
        CMP.W bossRowdinHeadPosLeft,Y
		rtl 
		
	+	LDA.W $05A4
		AND.W #$FFFE                         
        CMP.W bossRowdinHeadPosRight,Y
		rtl 
;	bossRowdinHeadPosLeft:
;		db $C0,$00,$A0,$00,$E0,$00,$B0,$00,$E0,$00,$80,$00,$B0,$00,$D0,$00,$C0,$00,$F0,$00,$80,$00
;	bossRowdinHeadPosRight:
;		db $40,$00,$30,$00,$20,$00,$50,$00,$10,$00,$80,$00,$50,$00,$30,$00,$40,$00,$20,$00,$80,$00
		
	makeHorseStopWhileDeath:
		stz $798
		stz $79a 
		inc $22,x 
		lda $22,x 
		rtl 
		
	newSpeedRowsinSkellyRight:
		lda #$0001
		sta $1a,x
		lda #$2000
		rtl 
		
	rowdinWhipStonesSpeedup:
		INC.B RAM_X_event_slot_24,X  
		INC.B RAM_X_event_slot_24,X          ;82DF9E|F624    |000024;  
        LDA.B RAM_X_event_slot_24,X
		rtl 
}

{	; bossKoranot

	newKoranotRoutines:
		rtl 
	
	newEventsKornatBoss:
		lda $0010,x 
		cmp #$0001
		bne +
		jml bossKornatFallingStone			; falling Block Routine  85EDA8
	+	cmp #$0002
		beq +
		bra back2RTSKoranot
	+	jml $85ED25							; fall off debries when hit (event ID 3) 

	newStoneThrowRoutine:
		stx $ec
		jml bossKoranotStoneThrowProjectile	; stoneThrowRoutine 85EE5F
		
	back2RTSKoranot:	
		jml $85ED18		



	bossKornatFallingStone: 
		LDA.B RAM_X_event_slot_state,X       ;85EDA8|B512    |000012;  
        PHX                                  ;85EDAA|DA      |      ;  
        ASL A                                ;85EDAB|0A      |      ;  
        TAX                                  ;85EDAC|AA      |      ;  
        LDA.L bossFallingBlockStateTable,X   ;85EDAD|BFB7ED85|85EDB7;  
        PLX                                  ;85EDB1|FA      |      ;  
        STA.B $00                            ;85EDB2|8500    |000000;  
        JMP.W ($0000)                        ;85EDB4|6C0000  |000000;  
	bossFallingBlockStateTable: 
		dw bossFallingBlockState00           ;85EDB7|        |85EDBF;  
        dw bossFallingBlockState02           ;85EDB9|        |85EDF3;  
        dw throwBlockAndDebriesState02       ;85EDBB|        |85EE09;  
        dw throwBlockAndDebriesState03       ;85EDBD|        |85EE33;  
	
	bossFallingBlockState00:
		PHX                                  ;85EDBF|DA      |      ;  
        JSL.L $808189		; RNGgetMix00                    ;85EDC0|22898180|808189;  
        PLX                                  ;85EDC4|FA      |      ;  
        LDA.B RAM_RNG_2                      ;85EDC5|A5E8    |0000E8;  
        AND.W #$001F                         ;85EDC7|291F00  |      ;  
        ORA.W #$0020                         ;85EDCA|092000  |      ;  
        STA.B RAM_X_event_slot_24,X          ;85EDCD|9524    |000024;  
        LDA.B RAM_frameCounter_effectiv      ;85EDCF|A578    |000078;  
        AND.W #$001F                         ;85EDD1|291F00  |      ;  
        STA.B $00                            ;85EDD4|8500    |000000;  
        LDA.B RAM_X_event_slot_xSpdSub       ;85EDD6|A518    |000018;  
        ASL A                                ;85EDD8|0A      |      ;  
        TAY                                  ;85EDD9|A8      |      ;  
        LDA.W $81F35B,Y                ;85EDDA|B95BF3  |81F35B;  
        CLC                                  ;85EDDD|18      |      ;  
        ADC.B $00                            ;85EDDE|6500    |000000;  
        STA.B RAM_X_event_slot_xPos,X        ;85EDE0|950A    |00000A;  
        STZ.B RAM_X_event_slot_yPos,X        ;85EDE2|740E    |00000E;  
        LDA.W #$0002                         ;85EDE4|A90200  |      ;  

	storeMovmentGetCollusionKoranot: 
		STA.B RAM_X_event_slot_Movement2c,X  ;85EDE7|952C    |00002C;  
        LDA.W #$0008                         ;85EDE9|A90800  |      ;  
        STA.B RAM_X_event_slot_HitboxXpos,X  ;85EDEC|9528    |000028;  
        STA.B RAM_X_event_slot_HitboxYpos,X  ;85EDEE|952A    |00002A;  
        INC.B RAM_X_event_slot_state,X       ;85EDF0|F612    |000012;  
        rts                                   ;85EDF2|60      |      ;  

	bossFallingBlockState02: 
		DEC.B RAM_X_event_slot_24,X          ;85EDF3|D624    |000024;  
        BNE +                     ;85EDF5|D011    |85EE08;  
    throwBlockState01: 
		LDA.W #$B7D5                         ;85EDF7|A9D5B7  |      ;  
        STA.B $00,X                          ;85EDFA|9500    |000000;  
        LDA.W #$00C0                         ;85EDFC|A9C000  |      ;  
        STA.B RAM_X_event_slot_SpriteAdr,X   ;85EDFF|9526    |000026;  
        lda #$0007		; set hitbox                       ;85EE01|A90100  |      ;  
        sta $06,x 		; store health 
		STA.B RAM_X_event_slot_HitboxID,X    ;85EE04|952E    |00002E;  
        INC.B RAM_X_event_slot_state,X       ;85EE06|F612    |000012;  
	+	brl back2RTSKoranot                                  ;85EE08|60      |      ;  

	throwBlockAndDebriesState02: 	; falling state
		jsr blockThrowBackRoutine 
		LDA.B RAM_X_event_slot_yPos,X        ;85EE09|B50E    |00000E;  
        CMP.W #$00A8                         ;85EE0B|C9A800  |      ;  
        BCC CODE_85EE23                       ;85EE0E|9013    |85EE23;  
        LDA.W #$00A8                         ;85EE10|A9A800  |      ;  
        STA.B RAM_X_event_slot_yPos,X        ;85EE13|950E    |00000E;  
        LDA.W #$000A                         ;85EE15|A90A00  |      ;  
        STA.B RAM_X_event_slot_24,X          ;85EE18|9524    |000024;  
        STZ.B RAM_X_event_slot_22,X          ;85EE1A|7422    |000022;  
        STZ.B RAM_X_event_slot_Movement2c,X  ;85EE1C|742C    |00002C;  
        STZ.B RAM_X_event_slot_HitboxID,X    ;85EE1E|742E    |00002E;  
        INC.B RAM_X_event_slot_state,X       ;85EE20|F612    |000012;  
        brl back2RTSKoranot                                  ;85EE22|60      |      ;  

	CODE_85EE23: 
		LDA.B RAM_X_event_slot_ySpdSub,X     ;85EE23|B51C    |00001C;  
        CLC                                  ;85EE25|18      |      ;  
        ADC.W #$2000                         ;85EE26|690020  |      ;  
        STA.B RAM_X_event_slot_ySpdSub,X     ;85EE29|951C    |00001C;  
        LDA.B RAM_X_event_slot_ySpd,X        ;85EE2B|B51E    |00001E;  
        ADC.W #$0000                         ;85EE2D|690000  |      ;  
        STA.B RAM_X_event_slot_ySpd,X        ;85EE30|951E    |00001E;  
        brl back2RTSKoranot                                  ;85EE32|60      |      ;  

	throwBlockAndDebriesState03: 	; decay 
		LDA.W #$F367                         ;85EE33|A967F3  |      ;  
        STA.B $00                            ;85EE36|8500    |000000;  
        LDA.W #$0003                         ;85EE38|A90300  |      ;  
        STA.B $02                            ;85EE3B|8502    |000002;  

	CODE_85EE3D: 
		DEC.B RAM_X_event_slot_24,X          ;85EE3D|D624    |000024;  
        BNE +                      ;85EE3F|D01D    |85EE5E;  
        LDA.B RAM_X_event_slot_22,X          ;85EE41|B522    |000022;  
        ASL A                                ;85EE43|0A      |      ;  
        CLC                                  ;85EE44|18      |      ;  
        ADC.B $00                            ;85EE45|6500    |000000;  
        TAY                                  ;85EE47|A8      |      ;  
        LDA.W RAM_81_X_event_slot_sprite_assembly,Y;85EE48|B90000  |810000;  
        STA.B $00,X                          ;85EE4B|9500    |000000;  
        LDA.W #$000A                         ;85EE4D|A90A00  |      ;  
        STA.B RAM_X_event_slot_24,X          ;85EE50|9524    |000024;  
        INC.B RAM_X_event_slot_22,X          ;85EE52|F622    |000022;  
        LDA.B RAM_X_event_slot_22,X          ;85EE54|B522    |000022;  
        CMP.B $02                            ;85EE56|C502    |000002;  
        BCC +                      ;85EE58|9004    |85EE5E;  
        JSL.L clearSelectedEventSlotAll      ;85EE5A|22598C80|808C59;   
	+	brl back2RTSKoranot                                  ;85EE5E|60      |      ;  



	bossKoranotStoneThrowProjectile: 
		LDA.B RAM_X_event_slot_state,X       ;85EE5F|B512    |000012;  
        PHX                                  ;85EE61|DA      |      ;  
        ASL A                                ;85EE62|0A      |      ;  
        TAX                                  ;85EE63|AA      |      ;  
        LDA.L bossThrowBlockJumpTable,X      ;85EE64|BF6EEE85|85EE6E;  
        PLX                                  ;85EE68|FA      |      ;  
        STA.B $00                            ;85EE69|8500    |000000;  
        JMP.W ($0000)                        ;85EE6B|6C0000  |000000;  
	bossThrowBlockJumpTable: 
		dw throwBlockState00                 ;85EE6E|        |85EE76;  
        dw throwBlockState01                 ;85EE70|        |85EDF7;  
        dw throwBlockAndDebriesState02       ;85EE72|        |85EE09;  
        dw throwBlockAndDebriesState03       ;85EE74|        |85EE33;  

    throwBlockState00: 
		LDA.W #$FFFF                         ;85EE76|A9FFFF  |      ;  
        STA.B RAM_X_event_slot_ySpd,X        ;85EE79|951E    |00001E;  
        LDA.W #$0001                         ;85EE7B|A90100  |      ;  
        STA.B RAM_X_event_slot_24,X          ;85EE7E|9524    |000024;  
        LDA.W #$0003                         ;85EE80|A90300  |      ;  
        JSR.W storeMovmentGetCollusionKoranot                    ;85EE83|20E7ED  |85EDE7;  
        BRL throwBlockState01                ;85EE86|826EFF  |85EDF7;  

	blockThrowBackRoutine:
		lda $30,x 							; 
		phx 
		asl a 
		tax 
		lda.l blockThrowbackJampTable,x 
		plx 
		sta $00
		jmp ($0000)
		rts 

	blockThrowbackJampTable:
		dw initBlockThrow,blockThrowBackManip,endBlockThrowBack

	endBlockThrowBack:
		lda #$0000
		sta $32,x
		jsr blockHitDetection
		rts 

	blockThrowBackManip:
		jsr blockHitDetection
	
	+	lda $32,x 
		clc 
		adc #$0001
		sta $32,x 
		cmp #$0010							; set timer for manip 
		bne +
		lda #$0002
		sta $30,x 							; increase state 
	+	lda $20
		and #$0f00

		bit #$0100							; speed increase with input 
		beq +
		
		lda #$4000							; speed multiplier 
		clc 
		adc RAM_81_X_event_slot_xSpdSub,x 
		sta RAM_81_X_event_slot_xSpdSub,x 
		lda #$0000
		adc RAM_81_X_event_slot_xSpd,x 
		sta RAM_81_X_event_slot_xSpd,x 
		lda $20
		and #$0f00
		
	+	bit #$0200
		beq +
		
		lda RAM_81_X_event_slot_xSpdSub,x 	
		sec
		sbc #$4000					; speed multiplier 
		sta RAM_81_X_event_slot_xSpdSub,x 	
		lda RAM_81_X_event_slot_xSpd,x 
		sbc #$0000
		sta RAM_81_X_event_slot_xSpd,x 
		lda $20
		and #$0f00 
		
;	+	bit #$0400					; not sure if falling faster makes sense here.. 
;		beq +

	+	bit #$0800
		beq +
		lda RAM_81_X_event_slot_ySpdSub,x 	
		sec
		sbc #$5000					; speed multiplier 
		sta RAM_81_X_event_slot_ySpdSub,x 	
		lda RAM_81_X_event_slot_ySpd,x 
		sbc #$0000
		sta RAM_81_X_event_slot_ySpd,x 
		lda $20
		and #$0f00 
		
	+	rts 
	
	initBlockThrow:
		lda $06,x							; check block helth to detect hit 
		cmp #$0007
		beq ++
		
		lda #$001d
		jsl $8085E3							; playsound
		
		lda #$0001							; increase State 
		sta $30,x 							
		lda #$0003							; make it move in all directions
		sta RAM_81_X_event_slot_Movement2c,x 
		lda #$0000
		sta RAM_81_X_event_slot_ySpd,x 
		sta RAM_81_X_event_slot_ySpdSub,x 
		lda $578							; 02 means simon is facing left 
		bne +
		lda #$0000
		sta RAM_81_X_event_slot_xSpd,x
		lda #$f000
		sta RAM_81_X_event_slot_xSpdSub,x 
		bra ++
	+	lda #$ffff
		sta RAM_81_X_event_slot_xSpd,x 
	++	rts 	

	blockHitDetection:
		lda RAM_81_X_event_slot_ySpdSub,x ; set gravety new 
		clc
		adc #$2000							; fall speed 
		sta RAM_81_X_event_slot_ySpdSub,x 
		lda #$0000
		adc RAM_81_X_event_slot_ySpd,x 
		sta RAM_81_X_event_slot_ySpd,x 
						; 5a8 xpos 

		lda $58a		; boss xpos 
		clc  
		adc $5a8 
		cmp $0a,x 		; compare xpos
		bmi ++
		
		lda $0a,x 
		clc
		adc $5a8
		cmp $58a  
		bmi ++	
						; 5aa ypos 

		lda $58e		; boss xpos 
		clc  
		adc $5aa 
		cmp $0e,x 		; compare xpos
		bmi ++
		
		lda $0e,x 
		clc
		adc $5aa
		cmp $58e  
		bmi ++
		
		jsr koranotGotHit 
		
	++	rts 

	koranotGotHit:
		lda $586			; substract health
		clc
		sbc #$0040
		sta $586
		jsl clearSelectedEventSlotAll
		rts 
}

{	; bossDancer
	hijackDancerDeath:	
		lda $34,x 
		cmp #$0090		; waiting frames till revive 
		bne ++
		
		lda $14,x 
		cmp #$0002		; number of respawns 
		beq ++
		
		clc
		adc #$0001		; count deaths 
		sta $14,x 
		cmp #$0001
		bne +
		
	+	lda $14,x 
		cmp #$0002
		bne +

		lda #$0060				; last face special
		sta $44
		
		phx 
		ldy.w #$F936                         
        LDX.W #$1200                      
        JSL.L bossGetPaletteY2X  
		plx 
	
	
	+	lda #$0001		; respawn boss 
		sta $12,x 
		lda #$0010
		sta $13f6 
		lda #$0047
		sta $2e,x 
		
		phx 			; increas health 
		lda $14,x 
		asl 
		tax 
		lda.l bossDancerMusicAndHealthList,x 
		and #$0f00
		plx 
		sta $06,x 
		
		phx 
		lda $14,x 
		asl 
		tax 
		lda.l bossDancerMusicAndHealthList,x 
		and #$00ff
		jsl musicLunch
		jsl musicLunchFix
		
;		lda #$001f	; slow down scroll
;		sta $46
				
		plx 		
		
	++	inc $34,x 			; hijack fix 
		lda $34,x 
		rtl 

	bossDancerMusicAndHealthList:
		dw $0000,$0411,$0423	

	newDancerHealthRoutioneHud:
		pha 
		
		lda #$0100			; hotfix camera lock when on ring 
		sta $a2 
		
		lda $14,x 
		beq ++
		cmp #$0001
		beq +
		
	+	lda $54e
		adc #$0020
		eor #$FFFF	; base on simon ypos mosaik effect second face 
		and #$00f0
		ora #$0002
		sta $1e8a
		
		pla			; 400 health
	bossPlus1LSRHealthHudCalc:
		lsr
		lsr
		lsr
		lsr
		lsr
		rtl 
		
	++	pla 		; 200 health 
		lsr
		lsr 
		lsr
		lsr		
		rtl 

	bossPlus3LSRHealthHudCalc:	
		lsr
		lsr
		lsr
		lsr
		lsr
		lsr
		lsr 
		rtl 

	bossPlus2LSRHealthHudCalc:	
		lsr
		lsr
		lsr
		lsr
		lsr
		lsr
		rtl 


	newDancerMovementRoutineYpos:
	    LDA.W RAM_81_RNG_3                   ;85DF91|ADEA00  |8100EA;  
        AND.W #$000F                         ;85DF94|290F00  |      ;  
        STA.W RAM_81_X_event_slot_sprite_assembly;85DF97|8D0000  |810000;  
        LDA.W RAM_81_X_event_slot_xPos,X     ;85DF9A|BD0A00  |81000A;  
        SEC                                  ;85DF9D|38      |      ;  
        SBC.W #$0010                         ;85DF9E|E91000  |      ;  
        CLC                                  ;85DFA1|18      |      ;  
        ADC.W RAM_81_X_event_slot_sprite_assembly;85DFA2|6D0000  |810000;  
        CMP.W RAM_81_simonSlot_Xpos          ;85DFA5|CD4A05  |81054A;  
        BCS ++                    			 ;85DFA8|B031    |85DFDB;  
        LDA.W RAM_81_X_event_slot_xSpdSub,X  ;85DFAA|BD1800  |810018;  
;        CLC                                  ;85DFAD|18      |      ;  
;        ADC.W #$0800                         ;85DFAE|690008  |      ;  
		phx 			; load speed based on current face 
		pha 
		lda $14,x 
		asl 
		tax 
		pla 		
		clc 
		adc.l dancerSpeedTableXpos,x 
		plx 

        STA.W RAM_81_X_event_slot_xSpdSub,X  ;85DFB1|9D1800  |810018;  
        LDA.W RAM_81_X_event_slot_xSpd,X     ;85DFB4|BD1A00  |81001A;  
        ADC.W #$0000                         ;85DFB7|690000  |      ;  
        STA.W RAM_81_X_event_slot_xSpd,X     ;85DFBA|9D1A00  |81001A;  
        BMI +                      			 ;85DFBD|301B    |85DFDA;  
        LDA.W RAM_81_X_event_slot_xSpdSub,X  ;85DFBF|BD1800  |810018;  
        SEC                                  ;85DFC2|38      |      ;  
        SBC.W #$0000                         ;85DFC3|E90000  |      ;  
        LDA.W RAM_81_X_event_slot_xSpd,X     ;85DFC6|BD1A00  |81001A;  
        SBC.W #$0001                         ;85DFC9|E90100  |      ;  
        BCC +                      			 ;85DFCC|900C    |85DFDA;  
        LDA.W #$0000                         ;85DFCE|A90000  |      ;  
        STA.W RAM_81_X_event_slot_xSpdSub,X  ;85DFD1|9D1800  |810018;  
        LDA.W #$0001                         ;85DFD4|A90100  |      ;  
        STA.W RAM_81_X_event_slot_xSpd,X     ;85DFD7|9D1A00  |81001A;  
    + 	RTL                                  ;85DFDA|6B      |      ;  

	++  LDA.W RAM_81_X_event_slot_xSpdSub,X  ;85DFDB|BD1800  |810018;  
;		SEC                                  ;85DFDE|38      |      ;  
;		SBC.W #$0800                         ;85DFDF|E90008  |      ;  
		phx 			; load speed based on current face 
		pha 
		lda $14,x 
		asl 
		tax 
		pla 		
		sec
		sbc.l dancerSpeedTableXpos,x 
		plx 


		STA.W RAM_81_X_event_slot_xSpdSub,X  ;85DFE2|9D1800  |810018;  
		LDA.W RAM_81_X_event_slot_xSpd,X     ;85DFE5|BD1A00  |81001A;  
		SBC.W #$0000                         ;85DFE8|E90000  |      ;  
		STA.W RAM_81_X_event_slot_xSpd,X     ;85DFEB|9D1A00  |81001A;  
		BPL +                      			 ;85DFEE|101B    |85E00B;  
		LDA.W RAM_81_X_event_slot_xSpdSub,X  ;85DFF0|BD1800  |810018;  
		SEC                                  ;85DFF3|38      |      ;  
		SBC.W #$0000                         ;85DFF4|E90000  |      ;  
		LDA.W RAM_81_X_event_slot_xSpd,X     ;85DFF7|BD1A00  |81001A;  
		SBC.W #$FFFF                         ;85DFFA|E9FFFF  |      ;  
		BCS +                      			 ;85DFFD|B00C    |85E00B;  
		LDA.W #$0000                         ;85DFFF|A90000  |      ;  
		STA.W RAM_81_X_event_slot_xSpdSub,X  ;85E002|9D1800  |810018;  
		LDA.W #$FFFF                         ;85E005|A9FFFF  |      ;  
		STA.W RAM_81_X_event_slot_xSpd,X     ;85E008|9D1A00  |81001A;  
	+	RTL     	

	newDancerMovementRoutineXpos:
	   LDA.W RAM_81_RNG_2                   ;85DF16|ADE800  |8100E8;  
       AND.W #$001F                         ;85DF19|291F00  |      ;  
       STA.W RAM_81_X_event_slot_sprite_assembly;85DF1C|8D0000  |810000;  
       LDA.W RAM_81_X_event_slot_yPos,X     ;85DF1F|BD0E00  |81000E;  
       SEC                                  ;85DF22|38      |      ;  
       SBC.W #$0018                         ;85DF23|E91800  |      ;  
       CLC                                  ;85DF26|18      |      ;  
       ADC.W RAM_81_X_event_slot_sprite_assembly;85DF27|6D0000  |810000;  
       CMP.W RAM_81_simonSlot_Ypos          ;85DF2A|CD4E05  |81054E;  
       BCS ++                      			;85DF2D|B031    |85DF60;  
       LDA.W RAM_81_X_event_slot_ySpdSub,X  ;85DF2F|BD1C00  |81001C;  
;       CLC                                  ;85DF32|18      |      ;  
;       ADC.W #$0600                         ;85DF33|690006  |      ;  
	   phx 			; load speed based on current face 
	   pha 
	   lda $14,x 
	   asl 
	   tax 
	   pla 		
	   clc 
	   adc.l dancerSpeedTableYpos,x 
	   plx 
		
       STA.W RAM_81_X_event_slot_ySpdSub,X  ;85DF36|9D1C00  |81001C;  
       LDA.W RAM_81_X_event_slot_ySpd,X     ;85DF39|BD1E00  |81001E;  
       ADC.W #$0000                         ;85DF3C|690000  |      ;  
       STA.W RAM_81_X_event_slot_ySpd,X     ;85DF3F|9D1E00  |81001E;  
       BMI +                      			;85DF42|301B    |85DF5F;  
       LDA.W RAM_81_X_event_slot_ySpdSub,X  ;85DF44|BD1C00  |81001C;  
       SEC                                  ;85DF47|38      |      ;  
       SBC.W #$8000                         ;85DF48|E90080  |      ;  
       LDA.W RAM_81_X_event_slot_ySpd,X     ;85DF4B|BD1E00  |81001E;  
       SBC.W #$0000                         ;85DF4E|E90000  |      ;  
       BCC +                      			;85DF51|900C    |85DF5F;  
       LDA.W #$8000                         ;85DF53|A90080  |      ;  max speed 
       STA.W RAM_81_X_event_slot_ySpdSub,X  ;85DF56|9D1C00  |81001C;  
       LDA.W #$0000                         ;85DF59|A90000  |      ;  
       STA.W RAM_81_X_event_slot_ySpd,X     ;85DF5C|9D1E00  |81001E;  
     + RTL                                  ;85DF5F|6B      |      ;  

    ++ LDA.W RAM_81_X_event_slot_ySpdSub,X  ;85DF60|BD1C00  |81001C;  
;       SEC                                  ;85DF63|38      |      ;  
;       SBC.W #$0600                         ;85DF64|E90006  |      ;  
       phx 			; load speed based on current face 
	   pha 
	   lda $14,x 
	   asl 
	   tax 
	   pla 		
	   sec
	   sbc.l dancerSpeedTableYpos,x 
	   plx 
       
	  
	  
	  STA.W RAM_81_X_event_slot_ySpdSub,X  ;85DF67|9D1C00  |81001C;  
       LDA.W RAM_81_X_event_slot_ySpd,X     ;85DF6A|BD1E00  |81001E;  
       SBC.W #$0000                         ;85DF6D|E90000  |      ;  
       STA.W RAM_81_X_event_slot_ySpd,X     ;85DF70|9D1E00  |81001E;  
       BPL +                      			;85DF73|101B    |85DF90;  
       LDA.W RAM_81_X_event_slot_ySpdSub,X  ;85DF75|BD1C00  |81001C;  
       SEC                                  ;85DF78|38      |      ;  
       SBC.W #$8000                         ;85DF79|E90080  |      ;  
	   LDA.W RAM_81_X_event_slot_ySpd,X     ;85DF7C|BD1E00  |81001E;  
       SBC.W #$FFFF                         ;85DF7F|E9FFFF  |      ;  
       BCS +                      			;85DF82|B00C    |85DF90;  
       LDA.W #$8000                         ;85DF84|A90080  |      ;   max speed 
       STA.W RAM_81_X_event_slot_ySpdSub,X  ;85DF87|9D1C00  |81001C;  
       LDA.W #$FFFF                         ;85DF8A|A9FFFF  |      ;  
       STA.W RAM_81_X_event_slot_ySpd,X     ;85DF8D|9D1E00  |81001E;  
     + RTL                                  ;85DF90|6B      |      ;  
	dancerSpeedTableYpos:
		dw $0600,$0b00,$1200
	dancerSpeedTableXpos:
		dw $0800,$1000,$1400

	bossAnimationSpeedupTable:
		dw $0001,$0001,$0002
	bossActionSpeedupTable:
		dw $0001,$0002,$0004	
	
	
	newAnimationCounterDancer:
		lda $22,x
		phx 			; load speed based on current face 
	    pha 
	    lda $14,x 
	    asl 
	    tax 
	    pla 		
	    clc 
	    adc.l bossAnimationSpeedupTable,x 
	    plx 
		sta $22,x 		
		rtl 

	newActionCounterDancer:
		lda $34,x
		phx 			; load speed based on current face 
	    pha 
	    lda $14,x 
	    asl 
	    tax 
	    pla 		
	    clc 
	    adc.l bossActionSpeedupTable,x 
	    plx 
		sta $34,x 		
		rtl 

	newDeathSplitMovement:		
		LDY.W #$05C0                         ;85E14C|A0C005  |      ;  
	-	LDA.W RAM_81_X_event_slot_ID,Y       ;85E14F|B91000  |810010;  
        cmp #$0002
		beq ++
		cmp #$0000
		BEQ +                      			 ;85E152|F00C    |85E160;  
    --  TYA                                  ;85E154|98      |      ;  
        CLC                                  ;85E155|18      |      ;  
        ADC.W #$0040                         ;85E156|694000  |      ;  
        TAY                                  ;85E159|A8      |      ;  
        CPY.W #$0D00                         ;85E15A|C0000D  |      ;  
        BCC -
        rtl                                	 ;85E15F|        |      ;  
  
	+	 JSL.L clearCurrentEventSlot          ;85E160|22F4B382|82B3F4;  
         CLC                                  ;85E164|18      |      ;  
         RTL                                  ;85E165|6B      |      ;  

				
	++	lda.w $0020,y										; counter to make sprites disapear 
		clc 
		adc #$0001
		sta.w $0020,y 
		cmp #$0070
		beq ++
		cpy #$5c0 
		bne +
		LDA.W RAM_81_X_event_slot_xSpdSub,y  ;85DF2F|BD1C00  |81001C;  
        CLC                                  ;85DF32|18      |      ;  
        ADC.W #$0600                         ;85DF33|690006  |      ;  
        STA.W RAM_81_X_event_slot_xSpdSub,y  ;85DF36|9D1C00  |81001C;  
        LDA.W RAM_81_X_event_slot_xSpd,y     ;85DF39|BD1E00  |81001E;  
        ADC.W #$0000                         ;85DF3C|690000  |      ;  
        STA.W RAM_81_X_event_slot_xSpd,y    
		bra -- 

	+	LDA.W RAM_81_X_event_slot_xSpdSub,y  ;85DF60|BD1C00  |81001C;  
        SEC                                  ;85DF63|38      |      ;  
        SBC.W #$0600                         ;85DF64|E90006  |      ;  
        STA.W RAM_81_X_event_slot_xSpdSub,y  ;85DF67|9D1C00  |81001C;  
        LDA.W RAM_81_X_event_slot_xSpd,y     ;85DF6A|BD1E00  |81001E;  
        SBC.W #$0000                         ;85DF6D|E90000  |      ;  
        STA.W RAM_81_X_event_slot_xSpd,y 
		bra -- 
	++	lda #$0000
		sta.w $0000,y 
		bra --
}

{	; bossGrakul		used RAM $20,x = flagInAir RAM $14,x currentHealthHUD to check if hit 

	newGrakulbossState00Long:
		STX.B RAM_XregSlotCurrent            ;83883D|86FC    |0000FC;  
		LDA.W #$0077                         ;83883F|A97700  |      ;  
		JSL.L $8085E3		; lunchSFXfromAccum              ;838842|22E38580|8085E3;  
		LDX.B RAM_XregSlotCurrent            ;838846|A6FC    |0000FC;  
		LDA.W $0590                          ;838848|AD9005  |810590;  
		STA.B RAM_X_event_slot_ID,X          ;83884B|9510    |000010;  
		LDA.W $058A                          ;83884D|AD8A05  |81058A;  
		STA.B RAM_X_event_slot_xPos,X        ;838850|950A    |00000A;  
		LDA.W $058A                          ;838852|AD8A05  |81058A;  
		STA.B RAM_X_event_slot_xPos,X        ;838855|950A    |00000A;  
		LDY.W #$D2AB                         ;838857|A0ABD2  |      ;  
		LDX.W #$1240                         ;83885A|A24012  |      ;  
		JSL.L bossGetPaletteY2X              ;83885D|22E99080|8090E9;  
		LDX.W #$0580                         ;838861|A28005  |      ;  
		LDA.W #$0003                         ;838864|A90300  |      ;  
		STA.B RAM_X_event_slot_Movement2c,X  ;838867|952C    |00002C;  
		LDA.W #$02A0                         ;838869|A9A002  |      ;  
		STA.B RAM_X_event_slot_xPos,X        ;83886C|950A    |00000A;  
		LDA.W #$00A0                         ;83886E|A9A000  |      ;  
		STA.B RAM_X_event_slot_yPos,X        ;838871|950E    |00000E;  
		LDA.W #$1000                         ;838873|A90004  |      ;  
		STA.B RAM_X_event_slot_event_slot_health,X;838876|9506    |000006;  
		STA.B RAM_X_event_slot_mask,X        ;838878|9530    |000030;  
		LDA.W #$0010                         ;83887A|A91000  |      ;  
		STA.W RAM_81_boss_Health_HUD         ;83887D|8DF613  |8113F6;  
		LDA.W #$008A                         ;838880|A98A00  |      ;  
		STA.B RAM_X_event_slot_ID,X          ;838883|9510    |000010;  
		LDA.W #$0018                         ;838885|A91800  |      ;  
		STA.B RAM_X_event_slot_HitboxXpos,X  ;838888|9528    |000028;  
		LDA.W #$0018                         ;83888A|A92000  |      ;  
		STA.B RAM_X_event_slot_HitboxYpos,X  ;83888D|952A    |00002A;  
		LDA.W #$0080                         ;83888F|A98000  |      ;  
		STA.W $0EF0                          ;838892|8DF00E  |810EF0;  
		LDA.W #$0001                         ;838895|A90100  |      ;  
		STA.B RAM_X_event_slot_state,X       ;838898|9512    |000012;  
		RTL                                  ;83889A|6B      |      ;  

	GrakulBossState0d_jumpLong:
		jsl faceSimon
		lda $20,x 
		bne +++
		
		lda #$0090
		cmp RAM_X_event_slot_yPos,x 		; throw axe on high ground 
		bmi +
		lda #$0006
		bra ++
		
	+	STZ.B RAM_X_event_slot_24,X         ; reset stuff??
        STZ.B RAM_X_event_slot_22,X 
		lda #$0001							; not sure what this is used for in the axe event??
		sta $5d0
		lda #$0004				; jsl $838EDE			; init AxeSlam 						; state to go when landing 
	++	sta $12,x 
		stz.w RAM_X_event_slot_xSpd,x 		; stop movement 
		stz.w RAM_X_event_slot_xSpdSub,x 
		
		lda #$0055
		jsl sfxLunch
		
	+++	jsl grakulJumpXposModulation			; moddle jump here.. 
		rtl

	GrakulBossState0e_jumpLong:
		jsl faceSimon
		lda $20,x 
		bne +++
		
		lda #$0090
		cmp RAM_X_event_slot_yPos,x 		; throw axe on high ground 
		bmi +
		lda #$000c
		bra ++
	+	lda #$000a
	++	sta $12,x 
		stz.w RAM_X_event_slot_xSpd,x 		; stop movement 
		stz.w RAM_X_event_slot_xSpdSub,x 
		
		ldy #$0700	
		jsl bossAxeGroundFire
		lda RAM_X_event_slot_xPos,x 
		sta $70a						; very hacky way to fix them somehow.. 
		sta $74a
		sta $78a
		sta $7ca
		
		lda #$00b8						; fix flames to low 
		sta $70e
		sta $74e
		sta $78e
		sta $7ce
		
		lda #$0055
		jsl sfxLunch

;		jsl bossAxeGroundFire
;		lda RAM_X_event_slot_xPos,x 
;		sta.w RAM_X_event_slot_xPos,y

	+++	jsl grakulJumpXposModulation
		rtl 


	initGrakulsJumpWhenLosingHealthSecondFace:
		sta $14,x 
		
		lda #$000e 				; do not run when already in jump state 
		cmp $12,x 
		beq ++
		
		jsl initiateGrakulJumpVilocity
		lda #$000e				; put grakul in secon face jump state 
		sta $12,x 
	++	rtl 
		
	newHudValueCalcGrakul:
		lsr						; hijackfix 
		lsr						; 100
		lsr						; 200
		lsr						; 400
		
		lsr						; 800
		lsr						; 1000

		pha
		
		lda #$0002
		cmp $592				; dont run as boss spawns 
		bpl +
		
		lda $12,x 				; not jumping while slaming
		cmp #$0004
		beq +
		cmp #$000d				; dont run while jumping 
		beq +
		
		lda $13f6				; check if we did a pip of damage to make him jump 
		cmp $14,x
		beq + 
		
		sta $14,x 
		lda #$000d
		sta $12,x 
		lda #$d51f				; sprite for jumping 
		sta $00,x 
		
		jsl initiateGrakulJumpVilocity
		
	+	pla
		rtl 
	
		
	newHudValueCalcGrakul2:
		lsr						; hijackfix 
		lsr						; 100
		lsr						; 200
		lsr						; 400
		
		lsr						; 800
		lsr						; 1000

		pha
		
		lda $12,x 
		cmp #$000e				; dont run while jumping 
		beq +
		
		lda $13f6				; check if we did a pip of damage to make him jump 
		cmp $14,x
		beq + 
		
		sta $14,x 
		
		lda #$000e
		sta $12,x 

		jsl initiateGrakulJumpVilocity
 
	+	pla
		rtl 

	initiateGrakulJumpVilocity:			
		lda RAM_X_event_slot_yPos,x ; lift of ground to not get grabbed by simplefied ground collusion.. 
		sbc #$0003
		sta RAM_X_event_slot_yPos,x 
		inc.w $20,x 				; set flag that we are in air 
		
		lda #$fffa				; jump 
		sta $1e,x 
		
		lda RAM_simonSlot_Xpos
		cmp $0a,x 
		bmi +

		lda #$0000				; add verticle speed to jump toward Simnon 
		sta $1a,x 
		lda #$c000
		sta $18,x 
		bra ++

	+	lda #$ffff
		sta $1a,x 
		lda #$4000
		sta $18,x 
		
	++	rtl 

	newBossGrakulGravetyRoutine:
		jsl $82B430				; gravety 
		
		
		LDA.B RAM_X_event_slot_xPos,X        
		CMP.W #$0230                         
		BCC grakulIsOnHighGround             
		CMP.W #$02d0                         
		BCS grakulIsOnHighGround             
		
		lda RAM_X_event_slot_yPos,x 
		cmp #$00a0 
		bmi +
		lda #$00a0
		sta RAM_X_event_slot_yPos,x 
		stz.w RAM_X_event_slot_ySpd,x 
		stz.w RAM_X_event_slot_ySpdSub,x 
		stz.w $20,x 			; clear not in air 
		bra +                                

	grakulIsOnHighGround:
   		lda RAM_X_event_slot_yPos,x 
		cmp #$0080 
		bmi +
		lda #$0080
		sta RAM_X_event_slot_yPos,x 
		stz.w RAM_X_event_slot_ySpd,x 
		stz.w RAM_X_event_slot_ySpdSub,x 		
		stz.w $20,x				; clear not in air 
	+	jsl $82B099				; hijack fix screenshake 		
		rtl 

	grakulJumpXposModulation:		
		lda RAM_X_event_slot_xSpd,x 
		bmi +
		
		lda RAM_X_event_slot_ySpd,x 		; runaround on peak 
		bpl +
	-	lda #$1000
		jsl gravetyXposMPlusFromAcum
		bra ++
		

	+	lda RAM_X_event_slot_ySpd,x 		; runaround on peak 
		bpl -
		lda #$1000 
		jsl gravetyXposMinusFromAcum


	++	rtl 
	
	gravetyXposMinusFromAcum:
		sta $00
		LDA.W RAM_81_X_event_slot_xSpdSub,X  
        SEC                                  
		SBC.W $00
;        SBC.W #$0800 		                 
        STA.W RAM_81_X_event_slot_xSpdSub,X  
        LDA.W RAM_81_X_event_slot_xSpd,X     
        SBC.W #$0000                         
        STA.W RAM_81_X_event_slot_xSpd,X            
		rtl 
	
	gravetyXposMPlusFromAcum:
		sta $00
		LDA.W RAM_81_X_event_slot_xSpdSub,X  
        CLC   
		ADC.W $00
;        ADC.W #$0800 		                 
        STA.W RAM_81_X_event_slot_xSpdSub,X  
        LDA.W RAM_81_X_event_slot_xSpd,X     
        ADC.W #$0000                         
        STA.W RAM_81_X_event_slot_xSpd,X            
		rtl 
	
	
	
	noAxeFireSpawnInAir:
		lda RAM_X_event_slot_yPos,x 		; disable high fire spawns.. 
		cmp #$00a0 
		bne +
	bossAxeGroundFire:	
		JSL.L $83922D                    ;838A5B|222D9283|83922D; 	
        JSL.L $838A6C ; CODE_838A6C                    ;838A5F|226C8A83|838A6C;  
        JSL.L $83922D ; CODE_83922D                    ;838A63|222D9283|83922D;  
        JSL.L $838A7C ; bossAxeSpawnRightFire          ;838A67|227C8A83|838A7C; 		
	+	rtl 


}


{	; bossFrank		
	newFrankInit:
		LDA.W #$000C                         ;8392A9|A90C00  |      ;  
        STA.B RAM_transoEffectSprite         ;8392AC|8544    |000044;  
        LDY.W #$D525                         ;8392AE|A025D5  |      ;  
        LDX.W #$1240                         ;8392B1|A24012  |      ;  
        JSL.L bossGetPaletteY2X              ;8392B4|22E99080|8090E9;  
        LDY.W #$D52B                         ;8392B8|A02BD5  |      ;  
        LDX.W #$1260                         ;8392BB|A26012  |      ;  
        JSL.L bossGetPaletteY2X              ;8392BE|22E99080|8090E9;  
        LDX.W #$0580                         ;8392C2|A28005  |      ;  
        LDA.W #$0003                         ;8392C5|A90300  |      ;  
        STA.B RAM_X_event_slot_Movement2c,X  ;8392C8|952C    |00002C;  
        LDA.W #$08C0                         ;8392CA|A9C008  |      ;  
        STA.B RAM_X_event_slot_xPos,X        ;8392CD|950A    |00000A;  
        LDA.W #$008D                         ;8392CF|A98D00  |      ;  
        STA.B RAM_X_event_slot_yPos,X        ;8392D2|950E    |00000E;  
        LDA.W #$0800                         ;8392D4|A90004  |      ;  
        STA.B RAM_X_event_slot_event_slot_health,X;8392D7|9506    |000006;  
        STA.B RAM_X_event_slot_mask,X        ;8392D9|9530    |000030;  
        LDA.W #$0010                         ;8392DB|A91000  |      ;  
        STA.L $8013F6                        ;8392DE|8FF61380|8013F6;  
        LDA.W #$0087                         ;8392E2|A98700  |      ;  
        STA.B RAM_X_event_slot_ID,X          ;8392E5|9510    |000010;  
        LDA.W #$C965                         ;8392E7|A965C9  |      ;  
        STA.B RAM_X_event_slot_sprite_assembly,X;8392EA|9500    |000000;  
        LDA.W #$0000                         ;8392EC|A90000  |      ;  
        STA.B RAM_X_event_slot_flip_mirror_attribute,X;8392EF|9504    |000004;  
        LDA.W #$0010                         ;8392F1|A91000  |      ;  
        STA.B RAM_X_event_slot_HitboxXpos,X  ;8392F4|9528    |000028;  
        LDA.W #$0030                         ;8392F6|A93000  |      ;  
        STA.B RAM_X_event_slot_HitboxYpos,X  ;8392F9|952A    |00002A;  
        LDA.W #$0001                         ;8392FB|A90100  |      ;  
        STA.B RAM_X_event_slot_state,X       ;8392FE|9512    |000012;  
        RTL                

	newBossFrankRoutine:
		lda $7c0
		bne +
		lda #$0000		; make the fakes monster fart cloud disapear when he is not on screen. 
		sta $800
	
	+	lda $592		; fail save if he wont stop walking for some reason.. we put a timer and state check..  
		cmp $5b6
		beq +
		sta $5b6		; state changed we reset timer and update state to compare again 
		lda #$0000
		sta $5b8
		bra ++

	+	inc $5b8
		lda $5b8
		cmp #$01a0
		bne ++
		lda #$0000		;reset timer and throw a starup bottle to reset since the monster been walking for too long 
		sta $5b8
		lda #$0001
		sta $592
	++	

		lda #$064e
		sta $12c0		; hotfix BG since it does scroll wrong once you walk back.. 
		jsl $8395F2 	; hijack fix  
		rtl 

	newBottleThrowScript:
		inc.b $14,x 	; rotate 1-3
		lda $14,x 
		cmp #$0003
		bne +
		stz.b $14,x 
		rtl 
	+	sta $14,x 
		rtl

;	newGroundFireInit:				; seemed to be the single spread fire?? 
;		phx 
;		ldx #$5c0 
;		LDA.W #$0001                         ;83966A|A90100  |      ;  
;		STA.W $12,x   						
;		lda #$0047							; make the fire hitable 
;		sta $2e,x 
;		lda #$0010							; health
;		sta $06,x 
;		plx 
;		rtl 

	newGroundFire4Balls00:
		lda #$0047							; make the fire hitable 
		sta $2e,x 
		lda #$0001							; health
		sta $06,x 	
		sta $12,x 							; increase state 
		
		rtl 
		
	newGroundFire4Balls01:					; add destruction rtouine. Needed??
		lda $06,x 
		bne +
		bra bottleFlameHit
	+	JSL.L gravetyFallCalculation4000   
        LDA.B RAM_X_event_slot_yPos,X       
		CMP.W #$00AA                        
        BCS +                     			
        RTL                                 

	+	LDA.W #$000C                        
        STA.W $0EF0                         
        STZ.B RAM_X_event_slot_xSpd,X       
        STZ.B RAM_X_event_slot_xSpdSub,X    
        STZ.B RAM_X_event_slot_ySpd,X       
        STZ.B RAM_X_event_slot_ySpdSub,X    
        LDA.W #$00AA                        
        STA.B RAM_X_event_slot_yPos,X       
        LDA.W #$0002						; 0001 orginal                         
        STA.B RAM_X_event_slot_state,X      
        LDA.W #$0081                        
        JSL.L lunchSFXfromAccum             
        RTL                                 

	newGroundFire4Balls02:
		lda $06,x 
		bne ++
	bottleFlameHit:
		lda #$0030
		jsl lunchSFXfromAccum
		
		lda $610 
		clc
		adc $650
		adc $690
		adc $6d0
		adc $710
		cmp #$0004			; each ID is 4 on the last flame kill we like to end the routine so the monster can continue the script.. 
		beq +
		
		jml $80E982			; small flame routine 
	+	jml $839856			; end when all flames are hit 
	++	rtl 

	makeGroundSpreadBottleHaveCollusionAgain:
		JSL.L lunchSFXfromAccum   ; hijack fix             ;8396B4|22E38580|8085E3;  
		lda #$0001
		sta $5ee
		
		rtl 


}

{	; bossZapf
	initZapfBatNew:		     
		LDY.W #$F23D                          
        LDX.W #$1260                          
        JSL.L bossGetPaletteY2X               
        LDX.W #$0580                          
        LDA.W #$0003                          
        STA.B RAM_X_event_slot_Movement2c,X  
        LDA.W #$0280                          
        STA.B RAM_X_event_slot_xPos,X        
        LDA.W #$0000                          
        STA.B RAM_X_event_slot_xPosSub,X     
        LDA.W #$0040                          
        STA.B RAM_X_event_slot_yPos,X        
        LDA.W #$0000                          
        STA.B RAM_X_event_slot_yPosSub,X     
        
;		LDA.W #$0410  							; health big bat                         
		lda #$820
		STA.W $0586                           
        STA.W $05BE                           
        
		LDA.W #$0150                        	; health small bats   
;		lda #$2a0 
		STA.W $05C6                           
        STA.W $0606                           
        STA.W $0646                           
		sta $686								; new bat 	
		sta $6c6
		sta $706 

       
		STA.W $05FE                           
        STA.W $063E                           
        STA.W $067E                           
        LDA.W #$0010                          
        STA.W RAM_81_boss_Health_HUD          
        LDA.W #$0086                          
        STA.B RAM_X_event_slot_ID,X          
        LDA.W #$0018                          
        STA.B RAM_X_event_slot_HitboxXpos,X  
        STA.B RAM_X_event_slot_HitboxYpos,X  
  ;      LDY.W #$F223                          
  ;      LDX.W #$1240                          
  ;      JSL.L bossGetPaletteY2X               
        LDX.W #$0580                          
        LDA.W #$0001                          
        STA.B RAM_X_event_slot_state,X       
        LDA.W #$0078                          
        JSL.L lunchSFXfromAccum               
        LDX.W #$0580                          
        RTL                                   

	zapfNewHealthRoutine:
		clc
		adc $686								; new bat 	
		clc
		adc $6c6
		clc 
		adc $706 
		clc
;		adc #$0ff								; shift fix?? 
		jsl bossPlus1LSRHealthHudCalc 
		rtl 
		
	addNewSmallBatsZapf:
		JSL.L $85D903                    ;	hijackFix adding a bat 
		LDA.B RAM_X_event_slot_yPos,X                                   
        ADC.W #$0020                     
        STA.W RAM_81_X_event_slot_yPos,Y 
        LDY.W #$0680                 
        JSL.L $85D903                   
      
		LDA.B RAM_X_event_slot_xPos,X                                   
        sbc #$0020                     
        STA.W RAM_81_X_event_slot_xPos,Y 
        LDY.W #$06c0                 
        JSL.L $85D903          

		LDA.B RAM_X_event_slot_yPos,X                                 
        sbc #$0020                     
        STA.W RAM_81_X_event_slot_yPos,Y 
        LDY.W #$0700                 
        JSL.L $85D903          
		RTL                               

	newHealthHitSmallBat:
		bcs +
		jsl $85DC6B					; hijack fix 	
		
	+	LDX.W #$0680                      
		LDA.B RAM_X_event_slot_state,X     
		CMP.W #$0004                      
		BCS +                      			
		JSL.L $85DC6B		; zapfSmallHealthRoutine         ;85DBFE|226BDC85|85DC6B;  

	+	LDX.W #$06c0                      
		LDA.B RAM_X_event_slot_state,X     
		CMP.W #$0004                      
		BCS +                      			
		JSL.L $85DC6B		; zapfSmallHealthRoutine         ;85DBFE|226BDC85|85DC6B;  

	+	LDX.W #$0700                      
		LDA.B RAM_X_event_slot_state,X     
		CMP.W #$0004                      
		BCS +                      			
		JSL.L $85DC6B		; zapfSmallHealthRoutine         ;85DBFE|226BDC85|85DC6B;  
	+	rtl


	newSmallZapfBatMainRoutine:
        JSL.L $85D954		; hijack fix 			smallBatsStateRoutine          ;85D94C|2254D985|85D954;  
       
		JSL.L RNGgetMix00
		ldx #$680
		jsr YposMovmentAreaSmallZapf		
		JSL.L $85D954

		
		JSL.L RNGgetMix00
		ldx #$6c0
		jsr YposMovmentAreaSmallZapf
		JSL.L $85D954		

		
		JSL.L RNGgetMix00
		ldx #$700
		jsr YposMovmentAreaSmallZapf
		JSL.L $85D954		

		
		LDX.W #$0580                         ;85D950|A28005  |      ;  
		rtl

	YposMovmentAreaSmallZapf:
		lda RAM_X_event_slot_yPos,x 
		cmp #$0060
		bcc +
		lda #$0060
		sta RAM_X_event_slot_yPos,x 
		lda #$fffe
		sta RAM_X_event_slot_ySpd,x 
	+	lda RAM_X_event_slot_yPos,x 
		cmp #$0020
		bcs +
		lda #$0020
		sta RAM_X_event_slot_yPos,x 
	+	rts 

	---	jml $85D989
	--	jml $85D97F
	-	jml $85D993
	newBatRoutineResetTimer:	
		CPX.W #$05C0     		;      smallBatsState00: 	delay before initiating               
        BEQ -                     
        CPX.W #$0600                    
        BEQ --                     

	    CPX.W #$0640                         
        BEQ ---                    
        
		cpx.w #$0680
		beq +

		cpx.w #$06c0
		beq ++

		cpx.w #$0700
		beq +++
	
	+	INC.B RAM_X_event_slot_32,X    
        LDA.B RAM_X_event_slot_32,X    
        CMP.W #$0008                  
        BCS resetSmallZapfStates        
		RTL                             

	++	INC.B RAM_X_event_slot_32,X    
        LDA.B RAM_X_event_slot_32,X    
        CMP.W #$0018                  
        BCS resetSmallZapfStates        
		RTL                               
 
	+++	INC.B RAM_X_event_slot_32,X    
        LDA.B RAM_X_event_slot_32,X    
        CMP.W #$0028                  
        BCS resetSmallZapfStates        
		RTL                  

	resetSmallZapfStates:	
		jml $85D993					;85D99A|6B      |      ;  


	makeSmallBatsDieFinalState:
		phx 

		ldx #$5c0					; since we could not fix healthroutine to be right..
	-	jsl clearSelectedEventSlotAll
		txa
		clc
		adc #$0040
		tax 
		cmp #$740
		bne -
		
		plx 

		INC.B RAM_X_event_slot_32,X          ;85DAB6|F632    |000032;  
        LDA.B RAM_X_event_slot_32,X          ;85DAB8|B532    |000032;  
		rtl 

	timerZapfDebree:
		rtl 
		
	zapfNewDiveRule:
		LDA.B RAM_X_event_slot_ySpdSub,X     ;85D84B|B51C    |00001C;  
		SEC                                  ;85D84F|38      |      ;  
		SBC.W #$0c00                         ;85D850|E90080  |      ;  
		STA.B RAM_X_event_slot_ySpdSub,X     ;85D853|951C    |00001C;  
		LDA.B RAM_X_event_slot_ySpd,X        ;85D855|B51E    |00001E;  
		SBC.W #$0000                         ;85D857|E90000  |      ;  
		STA.B RAM_X_event_slot_ySpd,X        ;85D85A|951E    |00001E;  
		lda RAM_X_event_slot_yPos,x 
		cmp #$0094
		bcc +
		lda #$0093
		sta RAM_X_event_slot_yPos,x 
	+	rtl
;		inc.b $30,x 
;		lda $30,x 
;		cmp #$0030
;		bcc +
;		jsl clearSelectedEventSlotAll
;	+	rtl 

;	smallzapfCheckIfDead:
;		CMP.W #$0005                         ;85DC37|C90500  |      ;  
;        BNE CODE_85DC43                      ;85DC3A|D007    |85DC43;  

;gravetyFallCalculation1000: 
;		LDA.B RAM_X_event_slot_ySpdSub,X   
;        CLC                                 
;        ADC.W #$1000                      
;        STA.B RAM_X_event_slot_ySpdSub,X   
;        LDA.B RAM_X_event_slot_ySpd,X      
;        ADC.W #$0000                      
;        STA.B RAM_X_event_slot_ySpd,X      
;        BMI +                    			
;        LDA.B RAM_X_event_slot_ySpdSub,X   
;        SEC                                 
;        SBC.W #$0000                      
;        LDA.B RAM_X_event_slot_ySpd,X      
;        SBC.W #$0004                      
;        BCC +                  				 
;        LDA.W #$0000                      
;        STA.B RAM_X_event_slot_ySpdSub,X   
;        LDA.W #$0004                      
;        STA.B RAM_X_event_slot_ySpd,X               
;	+	RTL                                 

	defineBossAreaZapf:
		LDA.B RAM_X_event_slot_xPos,X      
        CMP.W #$02F0                      
        BCS +
        CMP.W #$0210                      
        BCC ++                     
	--	LDA.B RAM_X_event_slot_yPos,X
		cmp #$001f 
		bcc +++
	-	jsl $85D587			; hijack fix 
		rtl 
		
	+	LDA.W #$02F0                      
        STA.B RAM_X_event_slot_xPos,X                                      
		bra -- 
        
	++	LDA.W #$0210                    
        STA.B RAM_X_event_slot_xPos,X    
        bra --                              
   +++ 	lda #$0020
		sta RAM_X_event_slot_yPos,X
		bra -
		
	smallBatBoopFindGround:
        phx 
		LDA.B RAM_X_event_slot_yPos,X 
		sec 
		sbc #$0001 
        STA.B $02 
        LDA.B RAM_X_event_slot_xPos,X       
        STA.B $00
        JSL.L readCollusionTable7e4000       
        BEQ ++
		bpl +
		inc a
		bne ++
		
	+	plx
		phx 
		STZ.B RAM_X_event_slot_xSpd,X        
        STZ.B RAM_X_event_slot_xSpdSub,X     
        STZ.B RAM_X_event_slot_ySpd,X        
        STZ.B RAM_X_event_slot_ySpdSub,X     

        LDA.W #$0001                        
        STA.B RAM_X_event_slot_state,X       
		
	++	plx
		jml $85DB07 

}

; --------------------------------------------------------------------------

pushPC		

; --------------------------------------------------------------------------
; -------------------------------- hijacks and OG disASM -------------------
; --------------------------------------------------------------------------

{	; bossZapf

org $85D572
;        JSL.L zapfBatStateRoutine            ;85D572|2287D585|85D587;  
		jsl defineBossAreaZapf 
		
org $85D597
	zapfBatStateTable: 
		dw zapfBatState00                    ;85D597|        |85D5A9;  
        dw zapfBatState01                    ;85D599|        |85D61C;  
        dw zapfBatState02                    ;85D59B|        |85D647;  
        dw zapfBatState03_fly                ;85D59D|        |85D6C1;  
        dw zapfBatState04_wait               ;85D59F|        |85D7E9;  
        dw zapfBatState05_dive               ;85D5A1|        |85D842;  
        dw zapfBatState06_breakUp            ;85D5A3|        |85D878;  
        dw zapfBatState07_smallBats          ;85D5A5|        |85D92F;  
        dw zapfBatState08                    ;85D5A7|        |85DAB3;  	
		; space for new states
	zapfBatState00: 	
		jml initZapfBatNew	
warnPC $85D61B		

org $85D61C
		zapfBatState01:
org $85D647
		zapfBatState02:
org $85D6C1
		zapfBatState03_fly:
org $85D6C5
		CMP.W #$0060     ;Timer check when Big Bat dives 200 default			
		
org $85D7E9
		zapfBatState04_wait:
org $85D7F5			
        CMP.W #$0048                     ;85D7F5|C93000  |      ;  		
org $85D842
		zapfBatState05_dive:	
org $85D846
        CMP.W #$0060                       ;diveTime 

org $85d84b
		jsl zapfNewDiveRule
		bra +
org $85D85C
	+	zapfBatDiveAnimation:
		
org $85D878
		zapfBatState06_breakUp:
org $85D92F 
		zapfBatState07_smallBats:
org $85DAB3 
		zapfBatState08:

org $81F081
;		zapfBatDiveSpeedYpos: 
;			dw $FFFC,$FFFC,$FFFC,$FFFD           ;81F081|        |      ;  
;			dw $FFFD,$FFFE,$FFFE,$FFFF           ;81F089|        |      ;  
			dw $FFFa,$FFFa,$FFFb,$FFFc           
			dw $FFFD,$FFFD,$FFFE,$FFFF          

org $85DB79
		jml smallBatBoopFindGround
		nop 

org $85DAB6                      
		jsl makeSmallBatsDieFinalState

;org $85DC37
;		jsl smallzapfCheckIfDead	
;		nop 
	
org $85DC19
		jsl zapfNewHealthRoutine 

org $85D8FE                     
		jsl addNewSmallBatsZapf

org $85D66E
        LDY.W #$740		; event spawn?? #$0680                         ;85D66E|A08006  |      ;  

org $85DAEE
        LDX.W #$740       	; new event table start since we have more small bats    ; 85DAEE|A28006  |      ;  

org $85DA6F
        LDY.W #$740		; #$0680                         ;85DA6F|A08006  |      ;  
org $85D7A3	
;deathSpawnSythIntervall: 	????
		LDY.W #$0740       ; 85D7A3|A08006  |      ;  

;org $85DCE1
;		nop 	; make sound on death 
		
org $85DBFC
		jsl newHealthHitSmallBat
		nop
		nop

org $85D94C
		jsl newSmallZapfBatMainRoutine

org $85D979
		jml newBatRoutineResetTimer
		nop 

warnPC $85D97E

org $85DB52			; debree fall speed 
        JSL.L gravetyFallCalculation2000     ;85DB52|2207B482|82B407;  
		jsl timerZapfDebree
org $85DD58
;		LDA.W #$0047          ; make debree hitable                ;85DD58|A90100  |      ;               


org $86BA55			; make simon get controll after stairs appear 
		lda #$0005
		sta $70 
		rtl 
}



{	; --------------------- bossFank  -------------------------------------
org $81D3E1
SpriteAnimationTable_bossFrank64: 
		dw $C965 ; sprAssID_834                      ;81D3E1|        |84C965;  
        dw $0008                             ;81D3E3|        |      ;  
        dw $C98A ; sprAssID_835                      ;81D3E5|        |84C98A;  
        dw $0004                             ;81D3E7|        |      ;  
        dw $C9AB ; sprAssID_836                      ;81D3E9|        |84C9AB;  
        dw $0008                             ;81D3EB|        |      ;  
        dw $C9D0 ; sprAssID_837                      ;81D3ED|        |84C9D0;  
                                                            ;      |        |      ;  
bossFrankSpeedTable: 
		dw $0010,$FFFF                       ;81D3EF|        |      ;  
                                                            ;      |        |      ;  
bossFrankSubSpeedTable: 
		dw $0008,$0000,$000A,$0000           ;81D3F3|        |      ;  
        dw $0008,$0000,$000B,$0000           ;81D3FB|        |      ;  
        dw $0008,$0000                       ;81D403|        |      ;  

SpriteAnimationTable65: 
		dw $C9F1 	; sprAssID_838                      ;81D407|        |84C9F1;  
        dw $0010                             ;81D409|        |      ;  
        dw $CA22 	; sprAssID_839                      ;81D40B|        |84CA22;  
        dw $0005                             ;81D40D|        |      ;  
        dw $CA5F	; sprAssID_840                      ;81D40F|        |84CA5F;  
        dw $0005                             ;81D411|        |      ;  
        dw $CA9C	; sprAssID_841                      ;81D413|        |84CA9C;  
        dw $0005                             ;81D415|        |      ;  
        dw $CAD9	; sprAssID_842                      ;81D417|        |84CAD9;  
        dw $0005                             ;81D419|        |      ;  
        dw $CAD9	; sprAssID_842                      ;81D41B|        |84CAD9;  
        dw $0005,$FFFF                       ;81D41D|        |      ;  
                                                            ;      |        |      ;  
SpriteAnimationTable70: 
		dw $CB1B	; sprAssID_844                      ;81D421|        |84CB1B;  
        dw $0004                             ;81D423|        |      ;  
        dw $CB24	; sprAssID_845                      ;81D425|        |84CB24;  
        dw $0004,$FFFF                       ;81D427|        |      ;  
                                                            ;      |        |      ;  
SpriteAnimationTable66: 
		dw $CB1B	; sprAssID_844                      ;81D42B|        |84CB1B;  
        dw $0012                             ;81D42D|        |      ;  
        dw $CB24	; sprAssID_845                      ;81D42F|        |84CB24;  
        dw $0006                             ;81D431|        |      ;  
        dw $CB55	; sprAssID_854                      ;81D433|        |84CB55;  
        dw $0006                             ;81D435|        |      ;  
        dw $CB5E	; sprAssID_855                      ;81D437|        |84CB5E;  
        dw $0006                             ;81D439|        |      ;  
        dw $CB6F	; sprAssID_856                      ;81D43B|        |84CB6F;  
        dw $0006                             ;81D43D|        |      ;  
        dw $CB88	; sprAssID_857                      ;81D43F|        |84CB88;  
        dw $0006                             ;81D441|        |      ;  
        dw $CBA1	; sprAssID_858                      ;81D443|        |84CBA1;  
        dw $0006                             ;81D445|        |      ;  
        dw $CBBA	; sprAssID_859                      ;81D447|        |84CBBA;  
        dw $0006                             ;81D449|        |      ;  
        dw $CBCB	; sprAssID_860                      ;81D44B|        |84CBCB;  
        dw $0006                             ;81D44D|        |      ;  
        dw $CBCB	; sprAssID_860                      ;81D44F|        |84CBCB;  
        dw $0010,$FFFF                       ;81D451| 

org $83948B
;         LDA.W #$0047                         ;83948B|A94700  |      ;  
		lda #$0000		; make bottle without any hitbox interaction 5d0 bottle slot number 

org $839281		
;		JSL.L frankMonsterRoutine00_bossEventRoutine ;839281|22F29583|8395F2;  
		jsl newBossFrankRoutine
org $839299
;frankMonsterStateTable: 
		dw frankMonsterState00               ;839299|        |8392A9;  
        dw frankMonsterState01               ;83929B|        |839301;  
        dw frankMonsterState02_walkLeft      ;83929D|        |83931A;  
        dw frankMonsterState03_walkRight     ;83929F|        |83935C;  
        dw frankMonsterState04_bottleThrow   ;8392A1|        |83941C; botleGroundSpread
        dw frankMonsterState04_bottleThrow   ;8392A3|        |83941C; bottle 4 flames
        dw frankMonsterState04_bottleThrow   ;8392A5|        |83941C; bottle Copy
        dw frankMonsterState07_deathRoutine  ;8392A7|        |839502; 

;org $8392A9
	frankMonsterState00:
		jml newFrankInit
org $839301
	frankMonsterState01:
org $83931A
	frankMonsterState02_walkLeft:
org $83935C
	frankMonsterState03_walkRight:
org $83941C
	frankMonsterState04_bottleThrow:
org $839502
	frankMonsterState07_deathRoutine:

org $839A47
	jsl bossPlus1LSRHealthHudCalc

org $8393B6
	jsl newBottleThrowScript
	nop 

;org $83966A
;	jsl newGroundFireInit
;	rtl 
org $8396B4
	jml makeGroundSpreadBottleHaveCollusionAgain


org $839815
		dw frankSingleGroundFlameState00     
		dw frankSingleGroundFlameState01
		dw frankSingleGroundFlameState02   
	
	frankSingleGroundFlameState00:
			jml newGroundFire4Balls00
	frankSingleGroundFlameState01:
			jml newGroundFire4Balls01
	frankSingleGroundFlameState02:
			jsl newGroundFire4Balls02
			bra frankSingleGroundFlameState01Continue

org $839845
		frankSingleGroundFlameState01Continue:

; frankCopy hijack ---------------------------------------------------
org $839874
	;frankBottle03_copy_StateTable: 
		dw frankBottle03_copy_State00        ;839874|        |83987E;  
        dw frankBottle03_copy_State01        ;839876|        |839889;  
        dw frankBottle03_copy_State02        ;839878|        |8398D7;  
        dw frankBottle03_copy_State03        ;83987A|        |839956;  
        dw frankBottle03_copy_State04        ;83987C|        |8399FE;  
		dw frankBottle03_copy_State03		; inc case a other event will use it 
		dw frankBottle03_copy_State03
		dw frankBottle03_copy_State03
		dw frankBottle03_copy_State03	

		 ;      |        |      ;  
	frankBottle03_copy_State00: 
		JSL.L $839479 			; CODE_839479                    ;83987E|22799483|839479;  
        LDA.W #$0001                         ;839882|A90100  |      ;  
        STA.W $05D2                          ;839885|8DD205  |8105D2;  
        RTL                                  ;839888|6B      |      ;  
                                                            ;      |        |      ;  
	frankBottle03_copy_State01: 
;		 LDA.W $05C6                          ;839889|ADC605  |8105C6;  
;        DEC A                                ;83988C|3A      |      ;  
;        BPL CODE_839892                      ;83988D|1003    |839892;  
;        JMP.W frankBottleGotDestroyed        ;83988F|4C2A96  |83962A;  
                                                            ;      |        |      ;  
                                                            ;      |        |      ;  
    CODE_839892: 
		LDX.W #$05C0                         ;839892|A2C005  |      ;  
        JSL.L gravetyFallCalculation4000     ;839895|2259B482|82B459;  
        LDX.W #$0580                         ;839899|A28005  |      ;  
;        LDA.W $05CE                          ;83989C|ADCE05  |8105CE;  
;        CMP.W #$004A     ; #$00aa                    ;83989F|C9AA00  |      ;  
;        BCS CODE_8398A5                      ;8398A2|B001    |8398A5;  
;        RTL                                  ;8398A4|6B      |      ;  
;                                                            ;      |        |      ;  
;    CODE_8398A5: 
		LDA.W #$000C		; 000c                         ;8398A5|A90C00  |      ;  
        STA.W $0EF0                          ;8398A8|8DF00E  |810EF0;  
        LDA.W #$0000                         ;8398AB|A90000  |      ;  
        STA.W $05E4                          ;8398AE|8DE405  |8105E4;  
        STA.W $05E2                          ;8398B1|8DE205  |8105E2;  
        STA.W $05DA                          ;8398B4|8DDA05  |8105DA;  
        STA.W $05D8                          ;8398B7|8DD805  |8105D8;  
        STA.W $05DE                          ;8398BA|8DDE05  |8105DE;  
        STA.W $05DC                          ;8398BD|8DDC05  |8105DC;  
        STA.W $05EE                          ;8398C0|8DEE05  |8105EE;  
        LDA.W #$00AA			; #$00AA                         ;8398C3|A9AA00  |      ;  
        STA.W $05CE                          ;8398C6|8DCE05  |8105CE;  
        LDA.W #$0002                         ;8398C9|A90200  |      ;  
        STA.W $05D2                          ;8398CC|8DD205  |8105D2;  
        LDA.W #$0081                         ;8398CF|A98100  |      ;  
        JSL.L lunchSFXfromAccum              ;8398D2|22E38580|8085E3;  
        RTL  

org $839956	
	frankBottle03_copy_State03:        ;83987A|        |839956; 
org $8398D7
	frankBottle03_copy_State02:        ;839878|        |8398D7; 
org $839968
	phx
	ldx #$7C0
	jsl $82977D

	stz.b $22,x 
	lda $3a
	and #$0030
	lsr
	lsr
	lsr
	lsr
	sta.b $24,x 
	LDA.W #$D3E1                         ;839979|A9E1D3  |      ;  
    STA.B RAM_X_event_slot_sprite_assembly;83997C|8500    |000000;  
    JSL.L spriteAnimationRoutine00       ;83997E|2269B082|82B069;  


	LDX.W #$0800                         
    LDA.W #$D4d9                         
    STA.B RAM_X_event_slot_sprite_assembly
    JSL.L spriteAnimationRoutine00       
	
	
	lda $7ca
	sta $80a
	lda $7ce 
	adc #$0038
	sta $80e
	lda #$8000
	sta $804
	
;	inc.w $7e0
;	lda $7e0
;	cmp #$0030
;	bne +
;	
;	lda #$0000
;	sta $7e0 	; reset timer and respawn event
;	
;	lda #$0002
;	sta $5d2 
;	
;	lda $0a,x 
;	sta $5ca
;	lda $0e,x 
;	sta $5ce 
	
	
+	plx
	rtl 
		
org $8399FE
	frankBottle03_copy_State04:        ;83987C|        |8399FE;  


}

{	; --------------------- bossGrakul -------------------------------------
org $838821
	GrakulBossStateTable: 
		dw GrakulBossState00                 ;838821|        |83883D;  
;		dw GrakulBossState01_glassShader     ;838823|        |83889B;  
;		dw GrakulBossState02_walkLeft        ;838825|        |838955;  
;		dw GrakulBossState03_walkRight       ;838827|        |838984;  
;		dw GrakulBossState04_AxeSlam         ;838829|        |8389AF;  
;		dw GrakulBossState05_AxeThrow        ;83882B|        |838AD5;  
;		dw GrakulBossState06_AxeThrowInit    ;83882D|        |838BAD;  
;		dw GrakulBossState07_sword           ;83882F|        |838BC8;  
;		dw GrakulBossState08_swordDraw       ;838831|        |838C65;  
;		dw GrakulBossState09_swordWalkLeft   ;838833|        |838C7C;  
;		dw GrakulBossState0a_swordWalkRight  ;838835|        |838CC2;  
;		dw GrakulBossState0b_swardSlash      ;838837|        |838CFC;  
;		dw GrakulBossState0c_swardSlashInit  ;838839|        |838D9C;  

org $83883B	
		dw GrakulBossState0d_jump   
		dw GrakulBossState0e_jump 	
		dw GrakulBossState0f_death           ;83883B|        |838DB8;  
	GrakulBossState00: 
		jsl newGrakulbossState00Long
		rtl
	GrakulBossState0d_jump:
		jsl GrakulBossState0d_jumpLong
		rtl 
	GrakulBossState0e_jump:
		jsl GrakulBossState0e_jumpLong
		rtl 
warnPC $83889A			; end of free space 

org $83880D
		; JSL.L bossRoutine00LastEventSlot     ;83880D|2299B082|82B099;  
		jsl newBossGrakulGravetyRoutine

org $838A5B
		; bossAxeGroundFire: 
		  ;JSL.L CODE_83922D                    ;838A5B|222D9283|83922D;  
		jsl noAxeFireSpawnInAir
		rtl 
org $83921C
        LDA.W #$000f                         ;83921C|A90D00  |      ; deathState Write 
org $83913D
        CMP.W #$000f                         ;83913D|C90D00  |      ; death state skip HUD calculation 
org $839159
        CMP.W #$0008                         ;839159|C90400  |      ; check for second face 

org $83914E
        ;LSR A                                ;83914E|4A      |      ;  
		jsl newHudValueCalcGrakul
org $839174
		jsl newHudValueCalcGrakul2

org $838DB8
		GrakulBossState0f_death: 
org $839247		
	;GrakulBossRoutine02_keepBossInBound: 
		LDA.B RAM_X_event_slot_xPos,X        ;839247|B50A    |00000A;  
		CMP.W #$0200                         ;839249|C94002  |      ;  
		BCC CODE_839254                      ;83924C|9006    |839254;  
		CMP.W #$02f0                         ;83924E|C9B002  |      ;  
		BCS CODE_83925A                      ;839251|B007    |83925A;  
		RTL                                  ;839253|6B      |      ;  
   CODE_839254: 
		LDA.W #$0200                         ;839254|A94002  |      ;  
        STA.B RAM_X_event_slot_xPos,X        ;839257|950A    |00000A;  
        RTL                                  ;839259|6B      |      ;  
   CODE_83925A: 
		LDA.W #$02f0                         ;83925A|A9B002  |      ;  
        STA.B RAM_X_event_slot_xPos,X        ;83925D|950A    |00000A;  
        RTL                              		

org $839061
        LDA.W #$01e0                       ;839061|A91002  |      ;  		; axe travel distance 
        STA.B $00                            ;839064|8500    |000000;  
        LDA.W #$0310    ; 2f0 
 
org $838A94 
;		ADC.W #$0008                         ;838A94|690800  |      ;  
		lda #$00b8							; fix the starting possition to the ground so slam spawn works too  
org $838A37
        LDA.W #$0010                         ;838A37|A92000  |      ;  hitbox Axe

}

{	; --------------------- bossDancer -------------------------------------

org $85E121
	jsl hijackDancerDeath

org $85E143	
;	JSL.L CODE_85E14C                    ;85E143|224CE185|85E14C;  	
	jsl newDeathSplitMovement
	
org $85DEE8
	jsl newActionCounterDancer
	cmp #$0100
	bpl +
	jsl newDancerMovementRoutineXpos
	jsl newDancerMovementRoutineYpos
	JSL.L $85DF01 
	rtl 
+	JMP.W $85DE71
	
org $85E1B0
	jsl newDancerHealthRoutioneHud 

	
org $85DF01
	jsl newAnimationCounterDancer

}


{	; --------------------- bossKoranot -------------------------------------

org $85E7B0
		LDY.W #$0000                         ;85E7B0|A00000  |      ;  initiating Platforms 
		LDX.W #$05C0                         ;85E7B3|A2C005  |      ;  
		LDA.W #$0008                         ;85E7B6|A90800  |      ;  
		JSR.W $85E7E0                    ;85E7B9|20E0E7  |85E7E0;  
		LDY.W #$0002                         ;85E7BC|A00200  |      ;  
		LDX.W #$0600                         ;85E7BF|A20006  |      ;  
		LDA.W #$0009                         ;85E7C2|A90900  |      ;  
		JSR.W $85E7E0                    ;85E7C5|20E0E7  |85E7E0;  

org $85ED03
		jml newStoneThrowRoutine

org $85ED09
		jml newEventsKornatBoss 

org $85E86C
		LDA.W #$0001				; #$00C7                         ;85E86C|A9C700  |      ; hibox 		
org $85EC75
		LDA.W #$0000                ; white fade

org $85EB07
		LDA.W #$0004                         ;85EB07|A90500  |      ;  how many rocks should fall 

org $81F35B
		dw $0708,$0740,$0778,$07b0,$07d8,$0800  ; 81F35B| ; koranotFallingBlockBaseXpos: 

}


{	; --------------------- bossRowdin -------------------------------------
org $82D688
    RowdinBossMain: 
		REP #$20                             ;82D688|C220    |      ;  
        REP #$10                             ;82D68A|C210    |      ;  
        JSL.L RNGgetMix00                    ;82D68C|22898180|808189;  
        LDX.W #$0580                         ;82D690|A28005  |      ;  
        JSL.L rowdinBossJumpTableRoutine     ;82D693|22EBD682|82D6EB;  
        LDA.B $B8                            ;82D697|A5B8    |0000B8;  
        BEQ ++                      		;82D699|F02F    |82D6CA;  
        JSL.L $82B099		; bossRoutine00LastEventSlot     ;82D69B|2299B082|82B099;  
        JSL.L bossRoutine01                  ;82D69F|22A8D682|82D6A8;  
        JSL.L $82D6CB			; bossRoutine02                  ;82D6A3|22CBD682|82D6CB;  
        RTL                                  ;82D6A7|6B      |      ;  
	bossRoutine01: 
		LDX.W #$0580                         ;82D6A8|A28005  |      ; Rowdin 
        LDA.B RAM_X_event_slot_state,X       ;82D6AB|B512    |000012;  
        CMP.W #$0004                         ;82D6AD|C90400  |      ; checks HorseDeath state
        BEQ ++                      		;82D6B0|F018    |82D6CA;  
        CMP.W #$0005                         ;82D6B2|C90500  |      ;  
        BEQ ++                      			;82D6B5|F013    |82D6CA;  
        CMP.W #$0004                         ;82D6B7|C90400  |      ;  
        BCC +                     				 ;82D6BA|900A    |82D6C6;  
        JSL.L $82D99E	; bossRowsdinFightProgression    ;82D6BC|229ED982|82D99E;  
        LDX.W #$0580                         ;82D6C0|A28005  |      ;  
        JMP.W $82DE63                    ;82D6C3|4C63DE  |82DE63;  

	+	JSL.L bossRowdinHUDhealthCalculation ;82D6C6|224BD882|82D84B;  
	++ 	RTL                                  ;82D6CA|6B      |      ;  

org $82D6EB
	rowdinBossJumpTableRoutine: 
		LDA.B RAM_X_event_slot_state,X       ;82D6EB|B512    |000012;  
        PHX                                  ;82D6ED|DA      |      ;  
        ASL A                                ;82D6EE|0A      |      ;  
        TAX                                  ;82D6EF|AA      |      ;  
        LDA.L rowdinBossStateTable,X         ;82D6F0|BFFAD682|82D6FA;  
        PLX                                  ;82D6F4|FA      |      ;  
        STA.B $00                            ;82D6F5|8500    |000000;  
        JMP.W ($0000)                        ;82D6F7|6C0000  |000000;  
	rowdinBossStateTable: 
		dw rowdinState00                     ;82D6FA|        |82D718;  
        dw rowdinState01                     ;82D6FC|        |82D8B6;  
        dw rowdinState01                     ;82D6FE|        |82D8B6;  
        dw rowdinState03_walkingShooting     ;82D700|        |82D8E3;  
        dw rowdinState04_horseDeath          ;82D702|        |82D944;  
        dw rowdinState05_spawnSkelly         ;82D704|        |82D9E8;  
        dw rowdinState06_empty               ;82D706|        |82DA54;  
        dw rowdinState07_freez               ;82D708|        |82DA55;  
        dw rowdinState08_walkLeft            ;82D70A|        |82DB1D;  
        dw rowdinState09_jumpAttack          ;82D70C|        |82DBC3;  
        dw rowdinState0a_walkRight           ;82D70E|        |82DB89;  
        dw rowdinState09_jumpAttack          ;82D710|        |82DBC3;  
        dw rowdinState0c_orb                 ;82D712|        |82DC08;  
        dw rowdinState0d_lastHealthBar       ;82D714|        |82DF3D;  
        dw rowdinState0e                     ;82D716|        |82DF9E;  

    rowdinState00: 
		jml newInitRowdin
;		LDY.W #$C687                         ;82D718|A087C6  |      ; palettePointerID
;        LDX.W #$1240                         ;82D71B|A24012  |      ; UpdateSlot palette
;        JSL.L bossGetPaletteY2X              ;82D71E|22E99080|8090E9;  
;        LDX.W #$0580                         ;82D722|A28005  |      ; main event Slot
;        STZ.B RAM_X_event_slot_Movement2c,X  ;82D725|742C    |00002C;  
;        LDA.W #$0810                         ;82D727|A91008  |      ; xPos
;        STA.B RAM_X_event_slot_xPos,X        ;82D72A|950A    |00000A;  
;        STA.W $078A                          ;82D72C|8D8A07  |81078A;  
;        LDA.W #$00AD                         ;82D72F|A9AD00  |      ; yPos
;        STA.B RAM_X_event_slot_yPos,X        ;82D732|950E    |00000E;  
;        STA.W $078E                          ;82D734|8D8E07  |81078E;  
;        JSL.L bossRowdinInit                 ;82D737|2275D782|82D775;  
;        LDA.W #$0080                         ;82D73B|A98000  |      ;  
;        STA.B RAM_X_event_slot_24,X          ;82D73E|9524    |000024;  
;        STA.B RAM_X_event_slot_xSpd,X        ;82D740|951A    |00001A; SpeedXpos
;        LDA.W #$0080                         ;82D742|A98000  |      ; rowdinBoss ID
;        STA.B RAM_X_event_slot_ID,X          ;82D745|9510    |000010;  
;        LDA.W #$0047                         ;82D747|A94700  |      ; hitBox hitable and hurt
;        STA.W $05AE                          ;82D74A|8DAE05  |8105AE;  
;        LDA.W #$0001                         ;82D74D|A90100  |      ;  
;        STA.W $07AE                          ;82D750|8DAE07  |8107AE;  
;        LDA.W RAM_81_simonSlot_spritePriority;82D753|AD4205  |810542;  
;        STA.W $0582                          ;82D756|8D8205  |810582;  
;        STA.W $0782                          ;82D759|8D8207  |810782;  
;        LDA.W #$0200                         ;82D75C|A90002  |      ; bossHealth
;        STA.W RAM_81_X_event_slot_event_slot_health,X;82D75F|9D0600  |810006;  
;        LDA.W #$0010                         ;82D762|A91000  |      ; bossHealthHUD
;        STA.L $8013F6                        ;82D765|8FF61380|8013F6;  
;        LDA.W #$0003                         ;82D769|A90300  |      ;  
;        STA.W $07AC                          ;82D76C|8DAC07  |8107AC; horseHead??
;        LDA.W #$0001                         ;82D76F|A90100  |      ; go First State
;        STA.B RAM_X_event_slot_state,X       ;82D772|9512    |000012;  
;        RTL                                  ;82D774|6B      |      ;  

org $82D775
	bossRowdinInit:	


org $82D84B		
	bossRowdinHUDhealthCalculation: 
		LDA.L $8013F6                        ;82D84B|AFF61380|8013F6;  
        STA.B RAM_X_event_slot_mask,X        ;82D84F|9530    |000030;  
        LDA.B RAM_X_event_slot_event_slot_health,X;82D851|B506    |000006;  
		jsl bossHealthHUDRowdin
;        LSR A                                ;82D853|4A      |      ;  
;        LSR A                                ;82D854|4A      |      ;  
;        LSR A                                ;82D855|4A      |      ;  
;        LSR A                                ;82D856|4A      |      ;  
        LSR A                                ;82D857|4A      |      ;  
        CMP.W #$0011                         ;82D858|C91100  |      ;  
        BCS CODE_82D870                      ;82D85B|B013    |82D870;  
        STA.L $8013F6                        ;82D85D|8FF61380|8013F6;  
        DEC A                                ;82D861|3A      |      ;  
        CMP.W #$0003            ; #$0009             ;82D862|C90900  |      ;  
        BCC CODE_82D870                      ;82D865|9009    |82D870;  
        LDA.L $8013F6                        ;82D867|AFF61380|8013F6;  
        CMP.B RAM_X_event_slot_mask,X        ;82D86B|D530    |000030;  
        BNE CODE_82D8B3                      ;82D86D|D044    |82D8B3;  
        RTL                                  ;82D86F|6B      |      ;  		
    
	CODE_82D870: 
		LDA.W #$0093                         ;82D870|A99300  |      ;  
        JSL.L sfxLunch                    ;82D873|22E38580|8085E3;  
        STZ.B RAM_X_event_slot_22,X          ;82D877|7422    |000022;  
        LDA.W #$0000                         ;82D879|A90000  |      ;  
        STA.W $07A2                          ;82D87C|8DA207  |8107A2;  
        STA.W $07A4                          ;82D87F|8DA407  |8107A4;  
        STA.W $07AE                          ;82D882|8DAE07  |8107AE;  
        STA.W RAM_81_eventSlot_Base          ;82D885|8D8005  |810580;  
        LDA.W #$0004                         ;82D888|A90400  |      ;  
        STA.B RAM_X_event_slot_state,X       ;82D88B|9512    |000012;  
        LDA.W #$0009                         ;82D88D|A90900  |      ;  
        STA.L $8013F6                        ;82D890|8FF61380|8013F6;  
        LDA.W #$0010                         ;82D894|A91000  |      ;  
        STA.B RAM_X_event_slot_HitboxXpos,X  ;82D897|9528    |000028;  
        LDA.W #$0020                         ;82D899|A92000  |      ;  
        STA.B RAM_X_event_slot_HitboxYpos,X  ;82D89C|952A    |00002A;  
        LDA.W #$0000                         ;82D89E|A90000  |      ;  
        STA.W $07AE                          ;82D8A1|8DAE07  |8107AE;  
        STA.B RAM_X_event_slot_HitboxID,X    ;82D8A4|952E    |00002E;  
        LDA.W #$05C0                         ;82D8A6|A9C005  |      ;  
        STA.B RAM_X_event_slot_xPosSub       ;82D8A9|8508    |000008;  
        LDA.W #$077E                         ;82D8AB|A97E07  |      ;  
        STA.B RAM_X_event_slot_ID            ;82D8AE|8510    |000010;  
        JMP.W $82E031		; CODE_82E031                    ;82D8B0|4C31E0  |82E031;  
    CODE_82D8B3: 
		JMP.W $82DF0C		; getPalette81C690               ;82D8B3|4C0CDF  |82DF0C;  
org $82D8B6
		rowdinState01:	

org $82D8E3
	rowdinState03_walkingShooting:

org $82D918
		jsl headMovmentForBackAndForward
		nop
		nop

		
org $82D944
		rowdinState04_horseDeath:
		jsl makeHorseStopWhileDeath
org $82D9E8
		rowdinState05_spawnSkelly:
org $82DA2A		
		LDA.W #$0200                         ;82DA2A|A92001  |      ;  
		sta $06,x 
		LDA.W #$0010                         ;82DA2F|A90900  |      ;  
        STA.L $8013F6                        ;82DA32|8FF61380|8013F6;  
	  
org $82DA54
		rowdinState06_empty:
		rtl 
		rowdinState07_freez:
org $82DB1D
		rowdinState08_walkLeft:
org $82DB2D
	    LDA.W #$FFFE                         ;82DB2D|A9FFFF  |      ;  
        STA.B RAM_X_event_slot_xSpd,X        ;82DB30|951A    |00001A;  
        LDA.W #$e000                         ;82DB32|A90080  |      ;  	
org $82DBC3
		rowdinState09_jumpAttack:
org $82DB89
		rowdinState0a_walkRight:
org $82DB97	
		jsl newSpeedRowsinSkellyRight 
		nop 
		
org $82DC08
		rowdinState0c_orb:
org $82DF3D
		rowdinState0d_lastHealthBar:
org $82DF9E
		rowdinState0e:
		jsl rowdinWhipStonesSpeedup
org $82E0B8
		jsl newFirballLunchCheck
		nop
		

org $82E1D3
		JSL newRowdinWalkRoutine
org $82E0C7		
		JSL $82E217                          
		jsl newRowdinLunchFireball
		LDA #$AD82               
		STA $0580                
		RTL   

org $82E1AD
		nop		; speed reset disable 
		nop 
		nop
		nop 
		nop
		nop 		
		nop
		nop 
		nop 	; animation reset disable 
		nop 
org $82E15A
        JSL.L newFireBallRowHorse 			;CODE_82E16A                    ;82E15A|226AE182|82E16A;  
org $81c4d1
;	headPosRowdHorse:
	bossRowdinHeadPosLeft:
		db $C0,$00,$A0,$00,$E0,$00,$B0,$00,$E0,$00,$80,$00,$B0,$00,$D0,$00,$C0,$00,$F0,$00,$80,$00 ;orginal
	;	db $C0,$00,$A0,$00,$E0,$00,$B0,$00,$E0,$00,$80,$00,$20,$00,$30,$00,$40,$00,$50,$00,$80,$00
	;	db $C0,$00,$A0,$00,$E0,$00,$B0,$00,$E0,$00,$80,$00,$20,$00,$30,$00,$10,$00,$50,$00,$20,$00 
org $81ffea
	bossRowdinHeadPosRight:
		db $40,$00,$30,$00,$20,$00,$50,$00,$10,$00,$80,$00,$50,$00,$30,$00,$40,$00,$20,$00,$80,$00


org $84b02e
	db $01,$FC,$FC,$44,$2B				; fireball assembly 
	db $01,$FC,$FC,$42,$2B
		
}

{	; --------------------- bossMedusa -------------------------------------
org $82EC2F
	bossMedusaStateTable: 
		dw bossMedusaState00                 ; init
		dw bossMedusaState01                 ; spawn  start state
		dw bossMedusaState02                 ; main 1
		dw bossMedusaState03                 ; main 2
		dw bossMedusaState04                 ; death state
		dw bossMedusaState05				 ; new 1
;org $82EC39
	bossMedusaState00:
		jsl newBossMedusaState00
		rtl 
;org $82EC99
	bossMedusaState01:
		jsl newBossMedusaState01
		rtl 
;org $82ECCE
    bossMedusaState02: 
		jsl newBossMedusaState02
		rtl 
;org $82ED0D
    bossMedusaState03:
		jsl newBossMedusaState03 
		rtl 
    bossMedusaState05:
		jsl newBossMedusaState05 
		rtl 		
warnPC $82ED80

org $86c488
	lda #$0036							; music to play after medusa
;   LDA.W #$000A                         ;82EDB0|A90A00  |      ; outro bossfight	
org $82ED81
	bossMedusaState04:	

org $82EF20
	jsl newStoneBeemDirection
	nop
	nop 
org $82EF2C
	jml newStoneBeemExtras
org $82EEB6	
	jsl newStoneBeemDirection				; for snake but it is the same thing.. 
	nop
	nop 	
org $82B459
	jml newSnakeThrowSpeedCalc
	
	
org $81CA6A		
	bossMedusaSpeedTableLeft: 
		dw $FFFF                             ;81CA6A|        |      ;                                                              ;      |        |      ;  
    bossMedusaSpeedSubTableLeft: 
		dw $0000
		dw $FFFF,$0000,$FFFF,$0000,$FFFF,$0000           
	bossMedusaSpeedTableRight: 
		dw $0001                             ;81CA7A|        |      ;  
    bossMedusaSubSpeedTableRight: 
		dw $0000
		dw $0001,$0000,$0001,$0000,$0001,$0000              
    DATA16_81CA8A: 
		dw $0000,$FFED,$FFED,$FFFE           ;81CA8A|        |      ;  
        dw $000E,$000E                       ;81CA92|        |      ; 
org $82EE6F
		LDA.W #$00b8                         ; small snake hight ground
org $82EF9D
        CMP.W #$00b8                         ; small snake hight air breakup hight 
org $82EFAD
		LDA.W #$00b8                         ; small snake hight air
;org $82EC62		
;		LDA.W #$0081                         ;MedusaBoss Ypos

}

{	; --------------------- bossViper --------------------------------------
org $82E7BC
JSL.L NewViperShootingInterfall		; CODE_82E82D                    ;82E7BC|222DE882|82E82D;  

org $84B038
	sprAssID_510_bossViperHead00: 
		db $06                               ;84B038|        |0000FE;  
		dd $24AA07FE,$24A807EE               ;84B039|        |      ;  
		dd $24A6F70E,$24A4F7FE               ;84B041|        |      ;  
		dd $24A2F7EE,$24A0F7DE               ;84B049|        |      ;  
                                                            ;      |        |      ;  
	sprAssID_511_bossViperHead01: 
		db $07                               ;84B051|        |0000FE;  
        dd $24AA07FE,$24C207EE               ;84B052|        |      ;  
        dd $24C007DE,$24A6F70E               ;84B05A|        |      ;  
        dd $24A4F7FE,$24AEF7EE               ;84B062|        |      ;  
        dd $24ACF7DE                         ;84B06A|        |      ;  
                                                            ;      |        |      ;  
	sprAssID_512_bossViperHead02: 
		db $07                               ;84B06E|        |0000FE;  
        dd $24AA07FE,$24C807EE               ;84B06F|        |      ;  
        dd $24C607DE,$24A6F70E               ;84B077|        |      ;  
        dd $24A4F7FE,$24C4F7EE               ;84B07F|        |      ;  
        dd $24ACF7DE                         ;84B087|        |      ;  
                                                            ;      |        |      ;  
	sprAssID_513_bossViperHead03: db $08                               ;84B08B|        |      ;  
        dd $24AA07FE,$24CE17EE               ;84B08C|        |      ;  
        dd $24CC07EE,$24A6F70E               ;84B094|        |      ;  
        dd $24A4F7FE,$24CA07DE               ;84B09C|        |      ;  
        dd $24C4F7EE,$24ACF7DE               ;84B0A4|        |      ;  
                                                            ;      |        |      ;  
	sprAssID_514_bossViperNeck00: 
		db $01                               ;84B0AC|        |0000F9;  
        dd $24E0F9F9                         ;84B0AD|        |      ;  

org $84B14E
	sprAssID_524_bossViperNeck01: 
		db $01                               ;84B14E|        |0000F9;  
        dd $256CF9F9                         ;84B14F|        |      ;  
                                                            ;      |        |      ;  
	sprAssID_525_bossViperNeck02: 
		db $01                               ;84B153|        |0000F9;  
        dd $256EF9F9                         ;84B154|        |      ;  
                                                            ;      |        |      ;  
	sprAssID_526_bossViperNeck03: 
		db $01                               ;84B158|        |0000F9;  
        dd $2580F9F9                         ;84B159|        |      ;  
                                                            ;      |        |      ;  
	sprAssID_527_bossViperNeck04: 
		db $01                               ;84B15D|        |0000F9;  
        dd $2582F9F9                         ;84B15E|        |      ;  
                                                            ;      |        |      ;  
	sprAssID_528_bossViperNeck05: 
		db $01                               ;84B162|        |0000F9;  
        dd $2584F9F9                         ;84B163|        |      ;  
                                                            ;      |        |      ;  
	sprAssID_529: 
		db $01                               ;84B167|        |0000F9;  
        dd $2586F9F9                         ;84B168|        |      ;  
                                                            ;      |        |      ;  
    sprAssID_530: 
		db $01                               ;84B16C|        |0000F9;  
        dd $2588F9F9                         ;84B16D|        |      ;  
                                                            ;      |        |      ;  
sprAssID_531_bossViperHead04: 
		db $07                               ;84B171|        |0000FE;  
        dd $24AA07FE,$258C17EE               ;84B172|        |      ;  
        dd $258A07EE,$24A6F70E               ;84B17A|        |      ;  
        dd $24A4F7FE,$24C4F7EE               ;84B182|        |      ;  
        dd $24ACF7DE     


}

{	; --------------------- bossPuwexil  -----------------------------------


org $829497 
		LDX.W #$0580                         ;829497|A28005  |      ;  
        JSL.L clearSelectedEventSlotAll      ;82949A|22598C80|808C59;  
		LDA.W #$0084                         ;82949E|A98400  |      ;  
        STA.B $10,X                          ;8294A1|9510    |000010;  
        LDA.W #$0380                         ;8294A3|A98003  |      ;  
        STA.B $0A,X                          ;8294A6|950A    |00000A;  
        LDA.W #$0060                         ;8294A8|A96000  |      ;  
        STA.B $0E,X                          ;8294AB|950E    |00000E;  
        LDA.W #$000c ; #$000C                         ;8294AD|A90C00  |      ;  
        STA.B RAM_transoEffectSprite         ;8294B0|8544    |000044;  
        LDA.W #$0005                         ;8294B2|A90500  |      ;  
        STA.B $B8                            ;8294B5|85B8    |0000B8;  
        RTL                                  ;8294B7|6B      |      ;  


org $82F14D
    PwuixleBossMain: 
		REP #$20                             ;82F14D|C220    |      ;  
        REP #$10                             ;82F14F|C210    |      ;  
        JSL.L RNGgetMix00                    ;82F151|22898180|808189;  
        LDX.W #$0580                         ;82F155|A28005  |      ;  
        JSL.L PwuixleBossStateRoutine        ;82F158|2278F182|82F178;  
        LDX.W #$0580                         ;82F15C|A28005  |      ;  
        JSL.L bossArenaBounderiesMain           ;82F15F|22A1F182|82F1A1;  
        LDA.B $B8                            ;82F163|A5B8    |0000B8;  
        BEQ +                  
        JSL.L PwuixleBossRoutine01       ; single mentos and physics    ;82F167|2237F982|82F937;  
        JSL.L PwuixleBossRoutine03           ;82F16B|22C3F882|82F8C3;  
;        JSL.L PwuixleBossRoutine04       ; extra mentos
		nop
		nop
		nop
		nop
		
        JSL.L PwuixleBossHealthRoutine05     ;82F173|22E8F182|82F1E8;                                                            ;      |        |      ;  
      + RTL                                  ;82F177|6B      |      ;  
                                                            ;      |        |      ;  
	PwuixleBossStateRoutine: 
		LDA.B RAM_X_event_slot_state,X       ;82F178|B512    |000012;  
        PHX                                  ;82F17A|DA      |      ;  
        ASL A                                ;82F17B|0A      |      ;  
        TAX                                  ;82F17C|AA      |      ;  
        LDA.L bossPwuixleStateTable,X                 ;82F17D|BF87F182|82F187;  
        PLX                                  ;82F181|FA      |      ;  
        STA.B $00                            ;82F182|8500    |000000;  
        JMP.W ($0000)                        ;82F184|6C0000  |000000;  
                                                            ;      |        |      ;  
    bossPwuixleStateTable: 
		dw bossPwuixleState00                ;82F187|        |82F27B;  
        dw bossPwuixleState01                ;82F189|        |82F2CC;  
        dw bossPwuixleState02                ;82F18B|        |82F315;  
        dw bossPwuixleState03_faceSimon                ;82F18D|        |82F373;  
        dw bossPwuixleState04_moveRight                ;82F18F|        |82F3CD;  
        dw bossPwuixleState05_moveLeft                ;82F191|        |82F434 
        dw bossPwuixleState06_breath                ;82F193|        |82F461;  
        dw bossPwuixleState07_nothing                ;82F195|        |82F511;  
        dw bossPwuixleState08_thongueOut                ;82F197|        |82F512;  
        dw bossPwuixleState09_nothing                ;82F199|        |82F5BE;  
        dw bossPwuixleState0a_tongue_retract                ;82F19B|        |82F5BF  
        dw bossPwuixleState0b_death_anim                ;82F19D|        |82F660  
        dw bossPwuixleState0c_outro                ;82F19F|        |82F6B3;  
        dw bossPwuixleState0d_final 
		dw bossPwuixleState0e_finalFight
		dw bossPwuixleState0f_finalFight
		dw bossPwuixleState10_finalFight
    bossPwuixleState0d_final:				; free space
		DEC.B RAM_X_event_slot_24,X        
        LDA.B RAM_X_event_slot_24,X          
		cmp #$00b0
		bne +
		
		lda #$0032			; lunch boss music castle	
		jsl $8280DD
		jsl $80859E 
	+	cmp #$0080
		bne +

		jsl makeMentosDangerous		
		lda #$0008
		sta $40				; white conter effect 
		lda #$0010			; boss health 
		sta $13f6
		lda #$0003			; enable movement updates x and y 
		sta $2c,x 
		inc $12,x  
		
	+	rtl 
	
	bossPwuixleState0e_finalFight:
		jml finalFightPuwexilState0e
	bossPwuixleState0f_finalFight:
		jml finalFightPuwexilState0f	
	bossPwuixleState10_finalFight:
		jml finalFightPuwexilState10
warnPC $82F1E7

org $82F1E8                                                            ;      |        |      ;  
	PwuixleBossHealthRoutine05: 
		LDA.B RAM_X_event_slot_state,X       ;82F1E8|B512    |000012;  
        CMP.W #$000B                         ;82F1EA|C90B00  |      ;  
        BCS +                      ;82F1ED|B01F    |82F20E;  
        LDA.L $8013F6                        ;82F1EF|AFF61380|8013F6;  
;		nop 
;		nop 
;		LDA.B RAM_X_event_slot_event_slot_health,X
		STA.B RAM_X_event_slot_34,X          ;82F1F3|9534    |000034;  
        LDA.B RAM_X_event_slot_event_slot_health,X;82F1F5|B506    |000006;  
		jsl puwexilNewHealthHud
;        LSR A                                ;82F1F7|4A      |      ;  
;        LSR A                                ;82F1F8|4A      |      ;  
;        LSR A                                ;82F1F9|4A      |      ;  
;        LSR A                                ;82F1FA|4A      |      ;  
        LSR A                                ;82F1FB|4A      |      ;  
        STA.L $8013F6                        ;82F1FC|8FF61380|8013F6;  
        DEC A                                ;82F200|3A      |      ;  
        CMP.W #$0010                         ;82F201|C91000  |      ;  
        BCS CODE_82F20F                      ;82F204|B009    |82F20F;  
        LDA.L $8013F6                        ;82F206|AFF61380|8013F6;  
;		nop 
;		nop 
;		LDA.B RAM_X_event_slot_event_slot_health,X
        CMP.B RAM_X_event_slot_34,X          ;82F20A|D534    |000034;  
        BNE CODE_82F250                      ;82F20C|D042    |82F250;   
   + 	RTL                                  ;82F20E|6B      |      ;  
 
    CODE_82F20F: 
		LDA.W #$0001                         ;82F20F|A90100  |      ;  
        STA.B RAM_whiteFadeCounter           ;82F212|8540    |000040;  
        JSL.L $82F7AF                    ;82F214|22AFF782|82F7AF;  
        LDA.W #$0000                         ;82F218|A90000  |      ;  
        STA.L $8013F6                        ;82F21B|8FF61380|8013F6;  
        STA.W $0583                          ;82F21F|8D8305  |810583;  
        STA.W $05AE                          ;82F222|8DAE05  |8105AE;  
        STA.W RAM_81_eventSlot_Base          ;82F225|8D8005  |810580;  
        STA.W $05AC                          ;82F228|8DAC05  |8105AC;  
        JSL.L CODE_82FA9E                    ;82F22B|229EFA82|82FA9E;  
        LDA.W #$000B                         ;82F22F|A90B00  |      ;  
        STA.W $0592                          ;82F232|8D9205  |810592;  
        LDY.W #$CC0C                         ;82F235|A00CCC  |      ;  
        LDX.W #$1260                         ;82F238|A26012  |      ;  
        JSL.L bossGetPaletteY2X              ;82F23B|22E99080|8090E9;  
        STZ.B RAM_transoEffectSprite         ;82F23F|6444    |000044;  
        JSL.L $808584  	; CODE_808584                    ;82F241|22848580|808584;  
        JSL.L $80859E  	; CODE_80859E                    ;82F245|229E8580|80859E;  
        LDA.W #$009B                         ;82F249|A99B00  |      ;  
        JML.L $8085E3	; CODE_8085E3                    ;82F24C|5CE38580|8085E3;  
                                             ;      |        |      ;  
    CODE_82F250: 
		LDA.W #$0010                         ;82F250|A91000  |      ;  
        STA.W $0EF0                          ;82F253|8DF00E  |810EF0;  
    ;    LDA.W RAM_81_simonSlot_Xpos          ;82F256|AD4A05  |81054A;  
;		lda.w $58a							; boss pos as startingpoint 
;		AND.W #$00FF                         ;82F259|29FF00  |      ;  
;        STA.B RAM_RNG_2                      ;82F25C|85E8    |0000E8;  		
        JSL.L FindEmptyAndclearEventSlot       ; ckear slot             ;82F25E|2232F882|82F832;  
        JSL.L spawn_mentos00                    ;82F262|227FF882|82F87F;  
        LDY.W #$CBFF                         ;82F266|A0FFCB  |      ;  
        LDX.W #$1270                         ;82F269|A27012  |      ;  
        JSL.L bossGetPaletteY2X              ;82F26C|22E99080|8090E9;  
        LDA.W #$0033                         ;82F270|A93300  |      ;  
        JSL.L $8085E3 	; SFX Music ??		CODE_8085E3                    ;82F273|22E38580|8085E3;  
        LDX.W #$0580                         ;82F277|A28005  |      ;  
        RTL                                  ;82F27A|6B      |      ;  
org $82F27B                                                            ;      |        |      ;  
   bossPwuixleState00: 
		JSL.L $83D77B                    ;82F27B|227BD783|83D77B;  
        LDX.W #$0580                         ;82F27F|A28005  |      ;  
        LDY.W #$CBF7                         ;82F282|A0F7CB  |      ;  
        LDX.W #$1250                         ;82F285|A25012  |      ;  
        JSL.L bossGetPaletteY2X              ;82F288|22E99080|8090E9;  
        LDX.W #$0580                         ;82F28C|A28005  |      ;  
        LDA.W #$0003                         ;82F28F|A90300  |      ;  
        STA.B RAM_X_event_slot_Movement2c,X  ;82F292|952C    |00002C;  
        LDA.W #$038E                         ;82F294|A98E03  |      ;  
        STA.B RAM_X_event_slot_xPos,X        ;82F297|950A    |00000A;  
        LDA.W #$0100		;#$0010                         ;82F299|A91000  |      ;  
        STA.B RAM_X_event_slot_yPos,X        ;82F29C|950E    |00000E;  
        LDA.W #$0400		; #$0200                         ;82F29E|A90002  |      ;  
        STA.B RAM_X_event_slot_event_slot_health,X;82F2A1|9506    |000006;  
        LDA.W #$0010                         ;82F2A3|A91000  |      ;  
        STA.W $0EF2                          ;82F2A6|8DF20E  |810EF2;  
        STA.L $8013F6                        ;82F2A9|8FF61380|8013F6;  
        LDA.W #$B3C3                         ;82F2AD|A9C3B3  |      ;  
        STA.B $00,X                          ;82F2B0|9500    |000000;  
        LDA.W #$0000 ;#$0047                         ;82F2B2|A94700  |      ;  
        STA.B RAM_X_event_slot_HitboxID,X    ;82F2B5|952E    |00002E;  
        LDA.W #$0018                         ;82F2B7|A91800  |      ;  
        STA.B RAM_X_event_slot_HitboxXpos,X  ;82F2BA|9528    |000028;  
        LDA.W #$0015                         ;82F2BC|A91500  |      ;  
        STA.B RAM_X_event_slot_HitboxYpos,X  ;82F2BF|952A    |00002A;  
        LDA.W #$0001                         ;82F2C1|A90100  |      ;  
        STA.B RAM_X_event_slot_mask,X        ;82F2C4|9530    |000030;  
        LDA.W #$0001                         ;82F2C6|A90100  |      ;  
        STA.B RAM_X_event_slot_state,X       ;82F2C9|9512    |000012;  
        RTL                                  ;82F2CB|6B      |      ;  
                                                            ;      |        |      ;  
   bossPwuixleState01: 
;		JSL.L $82B407                    ;82F2CC|2207B482|82B407;  
		jml newPuwxilIntro
		LDA.W #$0010 	;#$0090                         ;82F2D0|A99000  |      ;  
        CMP.B RAM_X_event_slot_yPos,X        ;82F2D3|D50E    |00000E;  
        bcs + ; BCC +
        RTL                                  ;82F2D7|6B      |      ;  
                                                            ;      |        |      ;  
      + STZ.B RAM_X_event_slot_Movement2c,X  ;82F2D8|742C    |00002C;  
        INC.B RAM_X_event_slot_32,X          ;82F2DA|F632    |000032;  
        LDA.B RAM_X_event_slot_32,X          ;82F2DC|B532    |000032;  
        CMP.W #$0001                         ;82F2DE|C90100  |      ;  
        BEQ +++                     		 ;82F2E1|F026    |82F309;  
        CMP.W #$0020                         ;82F2E3|C92000  |      ;  
        BCS ++          					 ;82F2E6|B014    |82F2FC;  
        AND.W #$0003                         ;82F2E8|290300  |      ;  
        CMP.W #$0001                         ;82F2EB|C90100  |      ;  
        BNE +
        JMP.W CODE_82B0C3                    ;82F2F0|4CC3B0  |82B0C3;  
                                                            ;      |        |      ;  
      + CMP.W #$0003                         ;82F2F3|C90300  |      ;  
        BNE +                      			;82F2F6|D003    |82F2FB;  
        JMP.W $82B0D5                    	;82F2F8|4CD5B0  |82B0D5;  
                                            
      + RTL                                 
                                            
     ++ LDA.W #$0003                        
        STA.B RAM_X_event_slot_Movement2c,X 
        STZ.B RAM_X_event_slot_32,X         
        LDA.W #$0002                        
        STA.B RAM_X_event_slot_state,X      
        RTL                                 
                                            
    +++ STX.B RAM_XregSlotCurrent           
        LDA.W #$0079             ; first landing sfx effect
        JSL.L $8085E3                   
        LDX.B RAM_XregSlotCurrent       
        RTL                             
                                        
   bossPwuixleState02: 						; scripting boss here
		jml puwexilScript
	bossPwuixleState07_nothing:
		jml newPuwexilState07
	bossPwuixleState09_nothing:
		jml specialStartingState09Puwexil
;		LDA.B RAM_X_event_slot_32,X          
;        CMP.W #$0000                         
;        BEQ CODE_82F334                      
;        CMP.W #$0001                         
;        BEQ CODE_82F32E                      
;        CMP.W #$0002                         
;        BEQ CODE_82F33A                      
;        CMP.W #$0003                         
;        BEQ CODE_82F367                      
;        STZ.B RAM_X_event_slot_32,X          
;        RTL                                  

org $82F32E                                             
    CODE_82F32E: 
		LDA.W #$0008                         ;82F32E|A90800  |      ;  
        STA.B RAM_X_event_slot_state,X       ;82F331|9512    |000012;  
        RTL                                  ;82F333|6B      |      ;  
                                                            ;      |        |      ;  
    CODE_82F334: 
		LDA.W #$0003                         ;82F334|A90300  |      ;  
        STA.B RAM_X_event_slot_state,X       ;82F337|9512    |000012;  
        RTL                                  ;82F339|6B      |      ;  
                                                            ;      |        |      ;  
    CODE_82F33A: 
		LDA.B RAM_RNG_2                      ;82F33A|A5E8    |0000E8;  
        AND.W #$000f          ;$0001               ;82F33C|290100  |      ;  
        CMP.W #$0001                         ;82F33F|C90100  |      ;  
        BEQ CODE_82F35B                      ;82F342|F017    |82F35B;  
        LDA.B RAM_X_event_slot_xPos,X        ;82F344|B50A    |00000A;  
        CMP.W RAM_81_simonSlot_Xpos          ;82F346|CD4A05  |81054A;  
        BCS CODE_82F353                      ;82F349|B008    |82F353;  
        LDA.W #$0004                         ;82F34B|A90400  |      ;  
        STA.B RAM_X_event_slot_state,X       ;82F34E|9512    |000012;  
        JMP.W CODE_82F36D                    ;82F350|4C6DF3  |82F36D;  
                                                            ;      |        |      ;  
    CODE_82F353: 
		LDA.W #$0005                         ;82F353|A90500  |      ;  
        STA.B RAM_X_event_slot_state,X       ;82F356|9512    |000012;  
        JMP.W CODE_82F36D                    ;82F358|4C6DF3  |82F36D;  
                                                            ;      |        |      ;  
    CODE_82F35B: 
		STZ.B RAM_X_event_slot_36,X          ;82F35B|7436    |000036;  
        STZ.B RAM_X_event_slot_22,X          ;82F35D|7422    |000022;  
        STZ.B RAM_X_event_slot_24,X          ;82F35F|7424    |000024;  
        LDA.W #$0006                         ;82F361|A90600  |      ;  
        STA.B RAM_X_event_slot_state,X       ;82F364|9512    |000012;  
        RTL                                  ;82F366|6B      |      ;  
                                                            ;      |        |      ;  
    CODE_82F367: 
		LDA.W #$000A                         ;82F367|A90A00  |      ;  
        STA.B RAM_X_event_slot_state,X       ;82F36A|9512    |000012;  
        RTL                                  ;82F36C|6B      |      ;  
                                                            ;      |        |      ;  
    CODE_82F36D: 
		LDA.W #$FFFB                         ;82F36D|A9FBFF  |      ;  
 ;       STA.B RAM_X_event_slot_ySpd,X        ;82F370|951E    |00001E;   
		nop
		nop
		RTL                                  ;82F372|6B      |      ;  
                                                            ;      |        |      ;  
   bossPwuixleState03_faceSimon: 
;		jml newPuwexilState03
		JSL.L findSimonsXposFor00                    ;82F373|22ABF382|82F3AB;  
        LDA.B RAM_RNG_2                      ;82F377|A5E8    |0000E8;  
        AND.W #$001F                         ;82F379|291F00  |      ;  
        CMP.W #$0001                         ;82F37C|C90100  |      ;  
        BEQ returnScriptStateStopYposSpeed                      ;82F37F|F01C    |82F39D;  
;		bra returnScriptStateStopYposSpeed
		
        LDA.B RAM_X_event_slot_yPos,X        ;82F381|B50E    |00000E;  
        CMP.W RAM_81_simonSlot_Ypos          ;82F383|CD4E05  |81054E;  
        BEQ returnScriptStateStopYposSpeed                      ;82F386|F015    |82F39D;  
        BCS moveUpConstant6000                      ;82F388|B008    |82F392;  
        STZ.B RAM_X_event_slot_ySpd,X        ;82F38A|741E    |00001E;  
        LDA.W #$A000                         ;82F38C|A900A0  |      ;  
        STA.B RAM_X_event_slot_ySpdSub,X     ;82F38F|951C    |00001C;  
        RTL                                  ;82F391|6B      |      ;  
                                                            ;      |        |      ;  
    moveUpConstant6000: 
		LDA.W #$FFFF                         ;82F392|A9FFFF  |      ;  
        STA.B RAM_X_event_slot_ySpd,X        ;82F395|951E    |00001E;  
        LDA.W #$6000                         ;82F397|A90060  |      ;  
        STA.B RAM_X_event_slot_ySpdSub,X     ;82F39A|951C    |00001C;  
        RTL                                  ;82F39C|6B      |      ;  
                                                            ;      |        |      ;  
    returnScriptStateStopYposSpeed: 
		STZ.B RAM_X_event_slot_ySpdSub,X     ;82F39D|741C    |00001C;  
        STZ.B RAM_X_event_slot_ySpd,X        ;82F39F|741E    |00001E;  
        STZ.B RAM_X_event_slot_22,X          ;82F3A1|7422    |000022;  
        LDA.W #$0002                         ;82F3A3|A90200  |      ;  
        STA.B RAM_X_event_slot_state,X       ;82F3A6|9512    |000012;  
        INC.B RAM_X_event_slot_32,X          ;82F3A8|F632    |000032;  
        RTL                                  ;82F3AA|6B      |      ;  
                                                            ;      |        |      ;  
    findSimonsXposFor00: 
		LDA.W RAM_81_simonSlot_Xpos          ;82F3AB|AD4A05  |81054A;  
        CMP.W $058A                          ;82F3AE|CD8A05  |81058A;  
        BCS CODE_82F3C0                      ;82F3B1|B00D    |82F3C0;  
        LDA.W #$0000                         ;82F3B3|A90000  |      ;  
        STA.W $0584                          ;82F3B6|8D8405  |810584;  
        LDA.W #$0080                         ;82F3B9|A98000  |      ;  
        STA.W $05BA                          ;82F3BC|8DBA05  |8105BA;  
        RTL                                  ;82F3BF|6B      |      ;  
                                                            ;      |        |      ;  
    CODE_82F3C0: 
		LDA.W #$4000                         ;82F3C0|A90040  |      ;  
        STA.W $0584                          ;82F3C3|8D8405  |810584;  
        LDA.W #$0000                         ;82F3C6|A90000  |      ;  
        STA.W $05BA                          ;82F3C9|8DBA05  |8105BA;  
        RTL                                  ;82F3CC|6B      |      ;  
                                                            ;      |        |      ;  
   bossPwuixleState04_moveRight: 
		JSL.L $82B407                    ;82F3CD|2207B482|82B407;  
        JSL.L CheckHealthForSpriteID                    ;82F3D1|2206F482|82F406;  
        JSL.L $82F6C4                    ;82F3D5|22C4F682|82F6C4;  
        LDA.B RAM_X_event_slot_xSpdSub,X     ;82F3D9|B518    |000018;  
        CLC                                  ;82F3DB|18      |      ;  
        ADC.W #$0800 	;#$0C00                         ;82F3DC|69000C  |      ;  
        STA.B RAM_X_event_slot_xSpdSub,X     ;82F3DF|9518    |000018;  
        LDA.B RAM_X_event_slot_xSpd,X        ;82F3E1|B51A    |00001A;  
        ADC.W #$0000                         ;82F3E3|690000  |      ;  
        STA.B RAM_X_event_slot_xSpd,X        ;82F3E6|951A    |00001A;  
        LDA.B RAM_X_event_slot_xSpdSub,X     ;82F3E8|B518    |000018;  
        SEC                                  ;82F3EA|38      |      ;  
        SBC.W #$0000                         ;82F3EB|E90000  |      ;  
        LDA.B RAM_X_event_slot_xSpd,X        ;82F3EE|B51A    |00001A;  
		jsl newPuwxilRightMovmentCap
		nop
;        SBC.W #$0003                         ;82F3F0|E90300  |      ;  
;        BCS stopPuexilsXposMovment                      ;82F3F3|B001    |82F3F6;  
        RTL                                  ;82F3F5|6B      |      ;  
  
	stopPuexilsXposMovment:
		STZ.B RAM_X_event_slot_ySpd,X        ;82F3F6|741E    |00001E;  
        STZ.B RAM_X_event_slot_ySpdSub,X     ;82F3F8|741C    |00001C;  
        STZ.B RAM_X_event_slot_xSpd,X        ;82F3FA|741A    |00001A;  
        STZ.B RAM_X_event_slot_xSpdSub,X     ;82F3FC|7418    |000018;  
        LDA.W #$0002                         ;82F3FE|A90200  |      ;  
        STA.B RAM_X_event_slot_state,X       ;82F401|9512    |000012;  
        INC.B RAM_X_event_slot_32,X          ;82F403|F632    |000032;  
        RTL                                  ;82F405|6B      |      ;  
org $82F406                                                            ;      |        |      ;  
    CheckHealthForSpriteID: 

org $82F434
   bossPwuixleState05_moveLeft: 
		JSL.L $82B407                    ;82F434|2207B482|82B407;  
        JSL.L CheckHealthForSpriteID                    ;82F438|2206F482|82F406;  
        JSL.L $82F6C4                    ;82F43C|22C4F682|82F6C4;  
        LDA.W RAM_81_X_event_slot_xSpdSub,X  ;82F440|BD1800  |810018;  
        SEC                                  ;82F443|38      |      ;  
        SBC.W #$0800 		; #$0C00                         ;82F444|E9000C  |      ;  
        STA.W RAM_81_X_event_slot_xSpdSub,X  ;82F447|9D1800  |810018;  
        LDA.W RAM_81_X_event_slot_xSpd,X     ;82F44A|BD1A00  |81001A;  
        SBC.W #$0000                         ;82F44D|E90000  |      ;  
        STA.W RAM_81_X_event_slot_xSpd,X     ;82F450|9D1A00  |81001A;  
        LDA.B RAM_X_event_slot_xSpdSub,X     ;82F453|B518    |000018;  
        CLC                                  ;82F455|18      |      ;  
        ADC.W #$0000                         ;82F456|690000  |      ;  
        LDA.B RAM_X_event_slot_xSpd,X        ;82F459|B51A    |00001A;  
		jsl newPuwxilLeftMovmentCap
		nop
;        ADC.W #$0003                         ;82F45B|690300  |      ;  
;        BCC stopPuexilsXposMovment                      ;82F45E|9096    |82F3F6;     
        RTL                                  ;82F460|6B      |      ;  

org $82F461                                                            ;      |        |      ;  
   bossPwuixleState06_breath: 
 
org $82F4A2 
 ;       JSL.L $83D7DC                  ; tile Updater
		nop
		nop
		nop
		nop		

org $82F511                                                  
;   bossPwuixleState07_nothing: 
		rtl 
   bossPwuixleState08_thongueOut: 	
org $82F5BE  
;   bossPwuixleState09_nothing:
		rtl 
   bossPwuixleState0a_tongue_retract: 
org $82F660
	bossPwuixleState0b_death_anim:
org $82F672
;    JSL.L $82FA22                    ;82F672|2222FA82|82FA22;  get rig of skull
	jsl fixwiredBugPuwexil
    JSL.L $82F7BF                    ;82F676|22BFF782|82F7BF;  spawn mentos 
	
org $82F6B3
	bossPwuixleState0c_outro:

org $82F692
	lda #$000d
;	jsl initateFinalPuwexilForm
	
org $82F832                                                         
    FindEmptyAndclearEventSlot: 
org $82F84C                                                         
	PwuixleBossRoutine04: 
org $82F87F                                                        
    spawn_mentos00: 
		BCS +                      ;82F87F|B041    |82F8C2;  
		jsl newPuwexilMentosSpawn
	+	rtl 

org $82F8C3                                                          
	PwuixleBossRoutine03: 
		LDA.L $8013F6                        ;82F8C3|AFF61380|8013F6;  
        CMP.W $0EF2                          ;82F8C7|CDF20E  |810EF2;  
        BNE CODE_82F8CD                      ;82F8CA|D001    |82F8CD;  
        RTL                                  ;82F8CC|6B      |      ;  
 
    CODE_82F8CD: 
		LDA.L $8013F6                        ;82F8CD|AFF61380|8013F6;  
        STA.W $0EF2                          ;82F8D1|8DF20E  |810EF2;  
        JMP.W CODE_82F8D7                    ;82F8D4|4CD7F8  |82F8D7;  
 
    CODE_82F8D7: 
		LDA.W #$0009                         ;82F8D7|A90900  |      ;  
        STA.B RAM_X_event_slot_ID            ;82F8DA|8510    |000010;  
     
    CODE_82F8DC: 
		JSL.L FindEmptyAndclearEventSlot                    ;82F8DC|2232F882|82F832;  
;        JSL.L CODE_82F8EB                    ;82F8E0|22EBF882|82F8EB;  
		jsl finalPuwexilFormTewak
		DEC.B RAM_X_event_slot_ID            ;82F8E4|C610    |000010;  
        LDA.B RAM_X_event_slot_ID            ;82F8E6|A510    |000010;  
        BNE CODE_82F8DC                      ;82F8E8|D0F2    |82F8DC;  
        RTL                                  ;82F8EA|6B      |      ;  
    
    CODE_82F8EB: 
		BCS +                 ;82F8EB|B049    |82F936;  
        LDA.W #$0003                         ;82F8ED|A90300  |      ;  
        STA.W RAM_81_X_event_slot_Movement2c,Y;82F8F0|992C00  |81002C;  
        STX.B RAM_X_event_slot_xSpdSub       ;82F8F3|8618    |000018;  
        LDA.B RAM_X_event_slot_ID            ;82F8F5|A510    |000010;  
        ASL A                                ;82F8F7|0A      |      ;  
        TAX                                  ;82F8F8|AA      |      ;  
        LDA.W DATA16_81CC85,X                ;82F8F9|BD85CC  |81CC85;  
        STA.W RAM_81_X_event_slot_xSpd,Y     ;82F8FC|991A00  |81001A;  
        LDA.W DATA16_81CC97,X                ;82F8FF|BD97CC  |81CC97;  
        STA.W RAM_81_X_event_slot_ySpd,Y     ;82F902|991E00  |81001E;  
        LDA.W PTR16_81CCA9,X                 ;82F905|BDA9CC  |81CCA9;  
        STA.W RAM_81_X_event_slot_sprite_assembly,Y;82F908|990000  |810000;  
        LDX.B RAM_X_event_slot_xSpdSub       ;82F90B|A618    |000018;  
        LDA.W #$0001                         ;82F90D|A90100  |      ;  
        STA.W RAM_81_X_event_slot_ID,Y       ;82F910|991000  |810010;  
        LDA.W #$0000                         ;82F913|A90000  |      ;  
        STA.W RAM_81_X_event_slot_HitboxID,Y ;82F916|992E00  |81002E;  
        LDA.W #$0003                         ;82F919|A90300  |      ;  
        STA.W RAM_81_X_event_slot_HitboxXpos,Y;82F91C|992800  |810028;  
        STA.W RAM_81_X_event_slot_HitboxYpos,Y;82F91F|992A00  |81002A;  
        LDA.B RAM_X_event_slot_xPos,X        ;82F922|B50A    |00000A;  
        STA.W RAM_81_X_event_slot_xPos,Y     ;82F924|990A00  |81000A;  
        LDA.B RAM_X_event_slot_yPos,X        ;82F927|B50E    |00000E;  
        STA.W RAM_81_X_event_slot_yPos,Y     ;82F929|990E00  |81000E;  
        LDA.B RAM_X_event_slot_SpriteAdr,X   ;82F92C|B526    |000026;  
        STA.W RAM_81_X_event_slot_SpriteAdr,Y;82F92E|992600  |810026;  
        LDA.B $02,X                          ;82F931|B502    |000002;  
        STA.W RAM_81_X_event_slot_attribute,Y;82F933|990200  |810002;   
	  + RTL                                  ;82F936|6B      |      ;  
                                                            ;      |        |      ;  
	PwuixleBossRoutine01: 
		LDX.W #$0840                         ;82F937|A24008  |      ;  
                                                            ;      |        |      ;  
    CODE_82F93A: 
		JSL.L CODE_82B145                    ;82F93A|2245B182|82B145;  
        LDA.B RAM_X_event_slot_ID,X          ;82F93E|B510    |000010;  
        CMP.W #$0001                         ;82F940|C90100  |      ;  
        BNE CODE_82F948                      ;82F943|D003    |82F948;  
        JMP.W CODE_82F9F7                    ;82F945|4CF7F9  |82F9F7;  
                                                            ;      |        |      ;  
    CODE_82F948: 
		CMP.W #$0002                         ;82F948|C90200  |      ;  
        BNE CODE_82F950                      ;82F94B|D003    |82F950;  
        JMP.W mentosStateRoutine                    ;82F94D|4CFEF9  |82F9FE;  
                                                            ;      |        |      ;  
    CODE_82F950: 
		CMP.W #$0005                         ;82F950|C90500  |      ;  
        BEQ CODE_82F970                      ;82F953|F01B    |82F970;  
        CMP.W #$002D                         ;82F955|C92D00  |      ;  
        BEQ CODE_82F969                      ;82F958|F00F    |82F969;  
                                                            ;      |        |      ;  
    CODE_82F95A: 
		TXA                                  ;82F95A|8A      |      ;  
        CLC                                  ;82F95B|18      |      ;  
        ADC.W #$0040                         ;82F95C|694000  |      ;  
        TAX                                  ;82F95F|AA      |      ;  
        CMP.W #$0E40                         ;82F960|C9400E  |      ;  
        BCC CODE_82F93A                      ;82F963|90D5    |82F93A;  
        LDX.W #$0580                         ;82F965|A28005  |      ;  
        RTL                                  ;82F968|6B      |      ;  
                                                            ;      |        |      ;  
    CODE_82F969: 
		JSL.L $80E982 		; event_ID_2d_smalFlame          ;82F969|2282E980|80E982;  
        JMP.W CODE_82F95A                    ;82F96D|4C5AF9  |82F95A;  
                                                            ;      |        |      ;  
    CODE_82F970: 
		LDA.B RAM_X_event_slot_state,X       ;82F970|B512    |000012;  
        PHX                                  ;82F972|DA      |      ;  
        ASL A                                ;82F973|0A      |      ;  
        TAX                                  ;82F974|AA      |      ;  
        LDA.L PTR16_82F97F,X               ;82F975|BF7FF982|82F97F;  
        PLX                                  ;82F979|FA      |      ;  
        STA.B $00                            ;82F97A|8500    |000000;  
        JMP.W ($0000)                        ;82F97C|6C0000  |000000;  
                                              
	PTR16_82F97F: 
		dw CODE_82F983                       ;82F97F|        |82F983;  
        dw CODE_82F9DD                       ;82F981|        |82F9DD;

org $82B0C3	
	CODE_82B0C3:
org $82B145 
	CODE_82B145:	
org $82F983
	CODE_82F983:
org $82F9DD
	CODE_82F9DD:	
org $82FA9E
	CODE_82FA9E:
org $82FA22 
	CODE_82FA22:
org $82F9F7 
	CODE_82F9F7:
org $82F9FE 
	mentosStateRoutine:	
		JSL.L mentosStateHealth                    ;82F9FE|2212FA82|82FA12;  
        LDA.W #$CCBB                         ;82FA02|A9BBCC  |      ;  
        STA.B RAM_general                    ;82FA05|8500    |000000;  
        JSL.L spriteAnimationRoutine00       ;82FA07|2269B082|82B069;  
        JSL.L newMentosRoutine		; CODE_82B459  falling Routine                  ;82FA0B|2259B482|82B459;  
        JMP.W CODE_82F95A                    ;82FA0F|4C5AF9  |82F95A;  
    mentosStateHealth: 
		LDA.B $24,X                          ;82FA12|B524    |000024;  
        AND.W #$0008                         ;82FA14|290800  |      ;  
        BEQ +                      ;82FA17|F006    |82FA1F;  
        LDA.W #$8000                         ;82FA19|A90080  |      ;  
        STA.B $04,X                          ;82FA1C|9504    |000004;  
        RTL                                  ;82FA1E|6B      |      ;  
      + STZ.B $04,X                          ;82FA1F|7404    |000004;  
        RTL                                  ;82FA21|6B      |      ;  

org $83d7e9
;	nop		; disable bg update puwexil 
;	nop
;	nop
org $82F9BE
;	JSL.L $83D7DC                    ;82F9BE|22DCD783|83D7DC; 	
	nop 
	nop
	nop
	nop

;org $81CBDD
;	PTR16_81CBDD:
;org $81CBC9
;	PTR16_81CBC9:
;org $81CBC5
;	PTR16_81CBC5:
;org $81CBC1
;	PTR16_81CBC1:	
;org $81CBBD	
;	PTR16_81CBBD:
;org $81CBCD
;	DATA16_81CBCD:
;org $81CBD9	
;	PTR16_81CBD9:
;org $81CBD5 
;	PTR16_81CBD5:
;org $81CBD1	
;	PTR16_81CBD1:
;
;org $81CBE1				
;	DATA16_81CBE1:
;	
org $81CC85	
	DATA16_81CC85:
org $81CC97	
	DATA16_81CC97:	
org $81CCA9	
	PTR16_81CCA9:	

}
	
; ---------------------------- END boss   ----------------------------------	
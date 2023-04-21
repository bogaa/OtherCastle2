if !simonIdleAnimation == 1 
;----------------- make Idle Animation for Simon ------------------------------------

org $81909f		; -------- fix up some sprite assembly to get a bit more space 
	dw SwingLeftSpriteAssembly,SwingLeftDownSpriteAssembly,SwingDownSpriteAssembly
	dw SwingRightDownSpriteAssembly,SwingRightSpriteAssembly

org $8191a1
	dw SwingLeftSpriteAssemblyThrow1,SwingLeftSpriteAssemblyThrow2,SwingLeftSpriteAssemblyThrow3
	dw SwingLeftDownSpriteAssemblyThrow1,SwingLeftDownSpriteAssemblyThrow2,SwingLeftDownSpriteAssemblyThrow3
	dw SwingDownSpriteAssemblyThrow1,SwingDownSpriteAssemblyThrow2,SwingDownSpriteAssemblyThrow3
	dw SwingRightDownSpriteAssemblyThrow1,SwingRightDownSpriteAssemblyThrow2,SwingRightDownSpriteAssemblyThrow3	
	dw SwingRightSpriteAssemblyThrow1,SwingRightSpriteAssemblyThrow2,SwingRightSpriteAssemblyThrow3
	;dw SwingLeftSpriteAssembly,SwingLeftSpriteAssembly,SwingLeftSpriteAssembly
	;dw SwingLeftDownSpriteAssembly,SwingLeftDownSpriteAssembly,SwingLeftDownSpriteAssembly
	;dw SwingDownSpriteAssembly,SwingDownSpriteAssembly,SwingDownSpriteAssembly
	;dw SwingRightDownSpriteAssembly,SwingRightDownSpriteAssembly,SwingRightDownSpriteAssembly
	;dw SwingRightSpriteAssembly,SwingRightSpriteAssembly,SwingRightSpriteAssembly

org $849FD1
	SwingLeftSpriteAssembly:
org $849FEA
	SwingLeftDownSpriteAssembly:
org $84A003
	SwingDownSpriteAssembly:
org $84A018
	SwingRightDownSpriteAssembly:
org $84A031
	SwingRightSpriteAssembly:

org $84A052
	SwingLeftSpriteAssemblyThrow1:
org $84A06B
	SwingLeftSpriteAssemblyThrow2:
org $84A088
	SwingLeftSpriteAssemblyThrow3:
org $84A0A9
	SwingLeftDownSpriteAssemblyThrow1:
org $84A0C2
	SwingLeftDownSpriteAssemblyThrow2:
org $84A0DF
	SwingLeftDownSpriteAssemblyThrow3:
org $84A100
	SwingDownSpriteAssemblyThrow1:
org $84A115
	SwingDownSpriteAssemblyThrow2:
org $84A12E
	SwingDownSpriteAssemblyThrow3:
org $84A147
	SwingRightDownSpriteAssemblyThrow1:
org $84A160
	SwingRightDownSpriteAssemblyThrow2:
org $84A17D
	SwingRightDownSpriteAssemblyThrow3:
org $84A196
	SwingRightSpriteAssemblyThrow1:
	db $08
	db $12,$0a,$0E,$60
	db $02,$0a,$0C,$60
	db $12,$Fa,$0A,$60
	db $02,$Fa,$08,$60
	db $F2,$Fa,$06,$60
	db $F2,$Ea,$04,$60
	db $E2,$Ea,$02,$60
	db $F2,$Da,$00,$60

org $84A1B7
	SwingRightSpriteAssemblyThrow2:
	db $08
	db $12,$0a,$0E,$60
	db $02,$0a,$0C,$60
	db $12,$Fa,$0A,$60
	db $02,$Fa,$08,$60
	db $F2,$Fa,$06,$60
	db $02,$Ea,$04,$60
	db $F2,$Ea,$02,$60
	db $E2,$Ea,$00,$60

org $84A1D8
	SwingRightSpriteAssemblyThrow3:
	db $08
	db $12,$0a,$0E,$60
	db $02,$0a,$0C,$60
	db $12,$Fa,$0A,$60
	db $02,$Fa,$08,$60
	db $F2,$Fa,$06,$60
	db $F2,$Ea,$04,$60
	db $E2,$Ea,$02,$60
	db $F2,$Da,$00,$60



if !jpWhipSound == 1		; only large whip?
org $fd8079
	db $01, $E0, $0E, $E7, $67, $ED, $BE, $EA, $07, $01, $05, $8E, $91, $01, $07, $93, $97, $01
	db $09, $9F, $7F, $6D, $9C, $00, $00, $00, $F5, $34, $FA, $01, $E0, $0E, $E7, $67, $ED, $BE
endif 


if !moonwalk == 1 
org $80a792
		jsl MoonWalk
		rtl	

pullPC
	MoonWalk:
		LDA $22e			;Simon walk movment if equal. Used when whiping
		BNE simonFlip		;
		LDA $02bc
		BNE simonFlip		
		LDA $20
		BIT #$0080			;Check A button
		BNE	endSimonFlip
		
		BIT #$0100 		;Check left button
		BNE simonFlipLeft	
	+	
		BIT #$0200			;Check right button
		BNE simonFlipRight
	simonFlip:
		LDA $0578
		AND #$0002
		STA $0578
		TAY
		LDA $8fbf,Y		;Look up table for spriteflip
		STA $0544
	endSimonFlip:
		RTL
	
	simonFlipLeft:	
		STZ $0544
		STZ $0578
		RTL
	simonFlipRight:	
		LDA.W #$4000
		STA.W $0544
		LDA.W #$0002
		STA.W $0578
		RTL
pushPC 

endif 

org $80A758		; max fall speed 
		SBC.W #$0007                         	;80A758|E90800  |      ;  
		BCC +                      				;80A75B|900C    |80A769;  
		LDA.W #$0000                         	;80A75D|A90000  |      ;  
		STA.W RAM_81_simonSlot_SpeedSubYpos  	;80A760|8D5C05  |81055C;  
		LDA.W #$0007                         	;80A763|A90800  |      ;  
		STA.W RAM_81_simonSlot_SpeedYpos     	;80A766|8D5E05  |81055E;  
	+ 	RTL                              



if !invertRingGlitchControll == 1 
org $80A9E2
	jsl invertRingControllCheck
org	$81ffe4
	invertedValuesRingSpeed:
	dw $0000,$0004,$0002
pullPC
	invertRingControllCheck:
		tay				; hijackFix 		
		lda !logicRingControlls
		beq +
		cmp #$0002			; if simon is above the ring invert Y 2and4 
		bne +
		lda.w invertedValuesRingSpeed,y 		; invert when value is 2
		tay 					
	+	lda $0574	; hijackFix 
		rtl 
		
	invertControllAboveRingFix:				; if is in if bat.. we need better hijack system!! FIXME	
		lda !logicRingControlls
		beq ++
		
		lda RAM_simonSlot_State 			; skip not in ring state since we like to detect the first frame we got a hit on the current ring 
		cmp #$0008
		beq +

		lda #$0001								; set it to a value so we can detect hits in ring state
		sta RAM_X_event_slot_event_slot_health,x
			
	+	lda RAM_X_event_slot_event_slot_health,x	; once damage done we know we can to our check to invert controlls 
		bne ++
		
		lda RAM_simonSlot_Ypos
		sec
		sbc #$0008								; set offset for above ring
		clc 
		cmp RAM_X_event_slot_yPos,x 
		bcc +
		
		lda #$0001
		sta !logicRingControlls		
		bra ++
	+	lda #$0002
		sta !logicRingControlls		
		
	++	rtl 
pushPC 	
endif 	


if !hotFixWhipCancle == 1 
; -------- whipCancleOnRingFix
org $80DB1B
	jml whipCancleRingFix 
;    BEQ CODE_80DB22                      ;80DB1B|F005    |80DB22;  
;    BMI CODE_80DB22                      ;80DB1D|3003    |80DB22;  
;    JMP.W CODE_80DC78                    ;80DB1F|4C78DC  |80DC78;  
pullPC
	whipCancleRingFix:
		BEQ +                     
		BMI +                     
		lda RAM_X_event_slot_ID,x
		cmp #$0003					; add a exeption to always check rings 
		beq +					
		cmp #$000e					; exeptions for Candles 
		beq +
		jml $80DC78                   
+	jml $80DB22
pushPC 
endif


if !swordSkellyHitboxFix == 1 
org $80F909
		ADC.W #$0026                         ;80F909|691C00  |      ;  
org $80F91A
		SBC.W #$0026                         ;80F91A|E91C00  |      ;  

endif  


; -------- end fix sprites
org $80A61D
		JML.L idleAnimationRoutine 	                 

pullPC
	idleAnimationRoutine:
		sta $560 						; hijack fix 
		cmp #$0073
		beq +
		
		lda $22e
		bne +
		lda $20
		bne +
		jsl idleAnimationStart 
	+	rtl 

	idleAnimationStart:
		phx 
		
		lda $550					; !! should be empty
		inc a
		sta $550 
		cmp #$003f
		bcc +
		stz $550 
		
	+	lsr
		lsr
		lsr
		and #$003e
		tax 
		lda.l simonIdleFrameTable,x 
		sta $560
		
		plx 
		rtl 
	simonIdleFrameTable:
		dw $0001,$0074,$0075,$0076

pushPC 
endif 

if !extraSpritesOnScreen == 1
org $808DEE
;  endOAMsetEmptySlots: 
;	LDX.B RAM_X_event_slot_sprite_assembly;808DEE|A600    |000000;  
;    LDY.B RAM_X_event_slot_attribute     ;808DF0|A402    |000002;  
		jsl loadExtraSprites

pullPC
	loadExtraSprites:		; 
		ldx #$0008			; size needs to mach table or game crashes since we use stack 
	-	lda.l newSpriteOAM,x 
		pha
		dex
		dex  
		bpl -

		LDX.B $00		; hijack Fix 
		LDY.B $02     	; hijack Fix
		
		pla 
     -  STA.B $00,X
        INX                                 
        INX                                 
		pla 
		STA.B $00,X
		inx
		inx 
		clc 
		ROR.B $FE                
        sec
		ROR.B $FE    
		bcc +
		
		lda $FE			; attribute bits 
		sta.w $0000,y 
		iny
		iny
		lda #$8000
		sta $fe
		
	+	pla 
		cmp #$ffff
		bne -


;		LDX.B $00		; hijack Fix 
;		LDY.B $02     	; 808DF0|A402    |000002;  
		rtl

	newSpriteOAM:
		dw $14f1, $3264, $0080, $0080, $ffff

pushPC 
endif 




if !subWeaponDropOnPickup == 1
org $80DE9D
	jsl subWeaponDropPickupBeahvier
	nop
	nop
	

pullPC
	subWeaponDropPickupBeahvier:
		lda RAM_simon_subWeapon
		beq +++
		phx 
		
		jsl getEmptyEventSlot
		lda RAM_simon_subWeapon
		clc
		adc #$0019						; callculate item drop ID
		sta $10,x 
		lda $542						; priority and possition 
		sta $02,x
		lda $54a
		sta $0a,x 
		lda $54e
		sbc #$0018						; make it appear above Simon 
		sta $0e,x 
		
		lda #$0009
		sta RAM_X_event_slot_HitboxID,x 
		lda #$0003
		sta RAM_X_event_slot_Movement2c,x 
		sta RAM_X_event_slot_HitboxXpos,x
		sta RAM_X_event_slot_HitboxYpos,x
		
		lda #$fffe						; push it up  a bit 
		sta RAM_X_event_slot_ySpd,x 
		
		lda $544						; push it backwared
		beq +
		lda #$c000
		sta RAM_X_event_slot_xSpdSub,x
		lda #$0000
		sta RAM_X_event_slot_xSpd,x
		bra ++
	+	lda #$4000
		sta RAM_X_event_slot_xSpdSub,x 
		lda #$ffff
		sta RAM_X_event_slot_xSpd,x
		
	++	plx 
	+++	LDA.B RAM_X_event_slot_ID,X      ; hijackFix 
        SEC                                
        SBC.W #$0019                     
		rtl 
pushPC

endif


if !reUseBrkblBlock == 1
; ----------------- make breakable wall recolactable in different screens -----------
org $80E73A
			nop 
			nop
			nop
;           STA.W $19C0,Y                        ;80E73A|99C019  |8119C0;  

endif 

; ----------------- have verticle update in both directions -----------

if !freeScrolling == 1
	org $869D71
		jsl additionalScrollsetingsLevelType03
	
	org $869C41
		jsl additionalScrollsetingsLevelType12
pullPC		
	additionalScrollsetingsLevelType03:
		jsl $869F51		; hijackFix 
		LDA.W $12A6                          ;869C6F|ADA612  |0012A6;  
        BPL + 
		rtl 
	+	;jsl $869C08						; does break the level with wrong tile update but seem to work otherwise 
		rtl 
	additionalScrollsetingsLevelType12:
		jsl $869F51		; hijackFix 
		LDA.W $12A6                          ;869C6F|ADA612  |0012A6;  
        BPL + 
		rtl 
	+	jsl $869C08							; scroll down fix  
		rtl 
	
pushPC

endif 

; ----------------- Remove Fatal Hit Crusher -----------------------
if !NoFatalCrusherHit == 1
org $82BBA5		; spike hit 
			jsl newSpikeHitRoutine
			nop
			nop 
;		STZ.W RAM_81_simonStat_Health_HUD    ;82BBA5|9CF413  |8113F4; killSimon
;        LDA.W #$000C                         ;82BBA8|A90C00  |      ;  
;        STA.W RAM_81_simonSlot_State         ;82BBAB|8D5205  |810552;  
pullPC
		newSpikeHitRoutine:
				lda $13f4
				sec
				sbc #$0005			; spike damage
				bcs +
				lda #$0000			; fatal hit detection 
			+	sta $13f4 	
				lda #$000c
				rtl 
pushPC
endif

; ----------------- HeartDependendMultishot -----------------------
if !HeartDependendMultishot == 1
org $80B988
	jsl HeartDependendMultishotRoutine
org $80DEA5
    ;STZ.B RAM_simon_multiShot            ;80DEA5|6490  
	nop									; disable multishot reset 
	nop 

pullPC											; free Space
		HeartDependendMultishotRoutine:			; store 1 or 2 on $10 for multiShoots
			lda $13F2
			cmp #$0020
			bmi NotEnoughHeartFor3
			lda #$0002
			bra storeMultishootManip
		NotEnoughHeartFor3:
			cmp #$0015
			bmi NotEnoughHeartFor2
			lda #$0001
		
		storeMultishootManip:
			sta $10
		NotEnoughHeartFor2:
			rtl
pushPC
endif

; ----------------- lastSlotFixedRing -----------------------
if !lastSlotFixedRing == 1
org $80D7E4	
		jml lastSlotFixedRingRoutine
		;LDX.B $FC                            ;80D7E4|A6FC    |0000FC;  
		;STZ.B $26,X                          ;80D7E6|7426    |000026;  

pullPC									; free space
	lastSlotFixedRingRoutine:
		LDX.B $FC                           ;80D7E4|A6FC    |0000FC;  
		LDA #$01e0							;offset last slot !!needs to be disable for Drac,
		STA.B $26,X                         ;80D7E6|7426    |000026;  
		RTL
pushPC
endif


org $81A425							; mainRingHijack for different patches.. 
	dl NewRingRoutineHijack

pullPC
	NewRingRoutineHijack:
	
	if !invertRingGlitchControll = 1		
		jsl invertControllAboveRingFix
	endif 

		lda $86						; check for levels to not check simon for sprite priority 
		cmp #$0001
		beq +
		cmp #$0020
		beq +						; elevator use is wired otherwise... 
		
		jml $8CFF07					; RingMain HijackFix 
	+	jml $8CFF0C					; no priority fix for this stages	
pushPC 


{; ----------------- BatRing -------------------------------
if !BatRing == 1	
org $86C656
	jml NewRingEventInit 				; this is where the normal bat dies 

org $8CFF1A
	jml newRingSubID					; make new ring events 

org $80DBB3									 ; connecting to ring Sound
	LDA.W #$0025                        
	JSL.L ringConnectHijack 		; CODE_8085E3            	; 80DBB6|22E38580|8085E3;  

pullPC				; free space
	ringConnectHijack: 		
		jsl $8085E3									; hijack fix play sound 
		stz.w RAM_X_event_slot_event_slot_health,x 	; mark the current ring hit with 00 health as it triggers the sound 
		rtl

	NewRingEventInit:
		lda $14,x 		
		cmp #$0001
		bne ++

		lda #$0003		; get sprite slot offset 
		sta $10,x
		sta $1a 
		jsl $80d7cc		; SpriteOffset	

		stz $12,x
		lda #$a4fd		; show ring assembly firstframe 
		sta $00,x 				

		lda #$0010		; 16 frame delay till it is hitable 
		sta $22,x 		; 20

		lda #$0084
		sta $14,x 
				
		rtl 
	
	++	stz $2e,x		; normal routine bat gets killed hijack fix 
		stz $26,x 
		jml $86C65A	
		
		
	newRingSubID:		
		LDA.B RAM_X_event_slot_subId,X       ;8CFF1A|B514    |000014;  
        bit #$0080
		bne ++
		cmp #$0000
		BNE +
		rtl 								; normal ring without subID 
	+ 	jml $8CFF1F							; hijack fix normal ring event with subID
	
	++	LDA.B $14,X                  		                                                  
		and #$007f							; mask bit 80 out 
		PHX                                 
        ASL A                               
        TAX                                 
        LDA.L newRingEventSubID,X    
        PLX                                 
        STA.B $00                   
        JMP.W ($00) 
		
	newRingEventSubID:
		dw ringSubID80,ringSubID81,ringSubID82,ringSubID83,ringMedusaMovm84
	
	ringSubID80:						; rising and wrapping rings 				
		lda RAM_simonSlot_State 
		cmp #$0008
		beq +
		
		lda #$0001								; set it to a value so we can detect hits
		sta RAM_X_event_slot_event_slot_health,x
		
	+	lda #$0003
		sta RAM_X_event_slot_Movement2c,X 
	+	lda #$ffff 
		sta RAM_X_event_slot_ySpd,X 
		lda #$0000
		sta RAM_X_event_slot_ySpdSub,X 
		
		lda RAM_X_event_slot_yPos,x 
		bne +
		
		lda RAM_X_event_slot_event_slot_health,x
		bne +
;		lda RAM_simonSlot_State 
;		cmp #$0008
;		bne +
		jsl disslunchSimonFromRing
		lda #$fffc
		sta RAM_simonSlot_SpeedYpos
		
	+	lda RAM_X_event_slot_yPos,x 
		and #$00ff		
		sta RAM_X_event_slot_yPos,x 
		jsl $8CFF49						; make Simon FollowRing 
		rtl 
		
		
	ringSubID81:	
		lda RAM_simonSlot_State 
		cmp #$0008
		beq +
		
		lda #$0001								; set it to a value so we can detect hits
		sta RAM_X_event_slot_event_slot_health,x
		
	+	lda #$0003
		sta RAM_X_event_slot_Movement2c,X 
	+	lda #$0000
		sta RAM_X_event_slot_ySpd,X 
		lda #$c000
		sta RAM_X_event_slot_ySpdSub,X 
		
		lda RAM_X_event_slot_yPos,x 
		cmp #$00ff
		bne +
		
		lda RAM_X_event_slot_event_slot_health,x
		bne +
		jsl disslunchSimonFromRing
		lda #$fffc
		sta RAM_simonSlot_SpeedYpos
		
	+	lda RAM_X_event_slot_yPos,x 
		and #$00ff		
		sta RAM_X_event_slot_yPos,x 
		jsl $8CFF49						; make Simon FollowRing 
		rtl 
		 
		 
	ringSubID82:
		lda #$0003
		sta RAM_X_event_slot_Movement2c,X 
		jsl $8CFF49						; make Simon FollowRing 
		
		lda RAM_X_event_slot_yPos,x		; find turn points ypos top bottom to set flag $22,x 
		sec 
		cmp #$0030 
		bcs +
		lda #$0001
		sta $22,x 
		jsl zeroYSpeed
		bra +
	+	clc 
		lda #$0090
	    cmp RAM_X_event_slot_yPos,x
		bcs +
		stz.w $22,x
		jsl zeroYSpeed

	+	lda.w $22,x						; add speed depending on this flag 
		beq ++

		LDA.B RAM_X_event_slot_ySpdSub,X     ;82C242|B51C    |00001C;  
        CLC                                  ;82C244|18      |      ;  
        ADC.W #$1000                         ;82C245|690020  |      ;  
        STA.B RAM_X_event_slot_ySpdSub,X     ;82C248|951C    |00001C;  
        LDA.B RAM_X_event_slot_ySpd,X        ;82C24A|B51E    |00001E;  
        ADC.W #$0000                         ;82C24C|690000  |      ;  
        STA.B RAM_X_event_slot_ySpd,X        ;82C24F|951E    |00001E;  
        LDA.B RAM_X_event_slot_yPos,X        ;82C251|B50E    |00000E;  
		bra +++
		
	++	LDA.B RAM_X_event_slot_ySpdSub,X     ;82C21C|B51C    |00001C;  
        SEC                                  ;82C21E|38      |      ;  
        SBC.W #$1000                         ;82C21F|E90020  |      ;  
        STA.B RAM_X_event_slot_ySpdSub,X     ;82C222|951C    |00001C;  
        LDA.B RAM_X_event_slot_ySpd,X        ;82C224|B51E    |00001E;  
        SBC.W #$0000                         ;82C226|E90000  |      ;  
        STA.B RAM_X_event_slot_ySpd,X        ;82C229|951E    |00001E;  
        LDA.B RAM_X_event_slot_yPos,X        ;82C22B|B50E    |00000E;  
		
	+++	rtl 
	zeroYSpeed:
		stz.w RAM_X_event_slot_ySpdSub,x 
		stz.w RAM_X_event_slot_ySpd,x 
		rtl
		
	ringSubID83:
		jsr checkIfSimonDislunched2ResetHealth 	; stop reseting health while on ring. This check should detect current ring hit and reset when switching 
		LDA.B $22,X 							; new subID                  		                                                  
		PHX                                 
        ASL A                               
        TAX                                 
        LDA.L newRingDisappearState,X    
        PLX                                 
        STA.B $00                   
        JMP.W ($00) 
		
	newRingDisappearState:
		dw ringGetRendomTimer,ringDisApearTimerInit,ringDisApearTimer,ringOnScreen
		
	ringGetRendomTimer:	
		LDA.B RAM_RNG_2                 
        AND.W #$003F                    
        CLC                             
        ADC.W #$0040                    
        STA.B RAM_X_event_slot_24,X     
        INC.B $22,X       					
		rtl 
	
	ringDisApearTimerInit:		
		lda $3a
		bit #$0002
		bne +
		lda #$0000					; make sprite disappear on some frame flicker
		sta $00,x 
					
	+	DEC.B RAM_X_event_slot_24,X     
        BNE +                     		
		
		LDA.W #$0040              	; set timer gone       
        STA.B RAM_X_event_slot_24,X     
		INC.B $22,X 
	+	rtl 
	
	ringDisApearTimer: 
		lda #$0000					; make sprite disappear 
		sta $00,x 
		sta $2e,x 					; make it not hitable 
						
		lda RAM_simonSlot_State 	; check if simon currently on ring 
		cmp #$0008
		bne +
		
		lda RAM_X_event_slot_event_slot_health,x ; check if this ring got hit in this cycle  
		cmp #$0001
		beq +
		
		jsl disslunchSimonFromRing	; dislunch Simon when ring got hit since it spawned
		lda #$fffc
		sta RAM_simonSlot_SpeedYpos	
		
	+	DEC.B RAM_X_event_slot_24,X     
        BNE +                      		
        
		LDA.B RAM_RNG_2                 
        AND.W #$003F                    
        CLC              
		adc.W #$0060             	; timer to stay on screen        
        STA.B RAM_X_event_slot_24,X     
		INC.B $22,X 
		
	+	rtl 
	ringOnScreen:	
		lda #$0022
		sta $2e,X 					; make it hitable 
		
		DEC.B RAM_X_event_slot_24,X 
		bne +
		
		lda #$0000					; repeat cycles 
		STA $22,X 
	+	rtl 
	
	checkIfSimonDislunched2ResetHealth:
		lda RAM_simonSlot_State 	
		cmp #$0008
		beq +	

		lda #$0001				
		sta RAM_X_event_slot_event_slot_health,x
	+	rts 

	ringMedusaMovm84:	
		lda $22,x 		; 16 frame delay till it is hitable timer is set in initiation face when bat dies 
		beq +
		sec
		sbc #$0001
		sta $22,x 
		bne +
		
		lda #$0022		; get hurt use 47
		sta $2e,x
				
	+	jsl $82C218		; Medusa movement
		jsl $8CFF49		; simon follow Ring
						;jml $86C529 ??
		rtl		
				
}
		
		
		
		
pushPC
		
;org $8cff9e			; used to clean up old place for the patch in OG ROM 
;	padbyte $ff
;	pad $8cfffe
;	
;warnpc $8cffff	
endif

; ----------------- timer remove -------------------------------
org $828000	
	timerOutofBoundCheckScrolling:	
		LDA $78                  
		AND #$003F  	;check frame counter to run             
		BNE +              		
if !removeTimer == 1
		bra +
		nop
		nop
		nop
elseif !removeTimer == 0
		LDA $13F0      	; skip when timer is zero   
		BEQ +              
	endif		
		SED                      
		SEC                      
		SBC #$0001               
		STA $13F0                
		CLD                      
		CMP #$0031               
		BCS +              
		LDA #$004F    	; SoundID when time runs out.            
		JSL $8085E3              
		
		LDA $13F0  		; timer               
		BNE +              
		LDA #$000C 		; knockback state              
		STA $0552                
		STZ $13F4                
	-   RTL                      
	+ 	LDA $B6 		; $828030  	               
		BNE -              
		LDX $13D0      	; scroll values          
		LDA $054E                
		BMI -              
		SEC                      
		SBC $18,X                
		CMP #$00D8               
		BMI -              


if !removeTimer == 1	; $808241 dynamic update Hud
org $80c756
		stz $0000		; make it appear as 000
		nop
		nop
org $80da7d
		stz $13f0		; store 00 to timer will make countdown faster without modding other values. Removing timer data routine would be better.. 
		nop
		nop
org $82ba8a
		padbyte $ea		; remove check on stairs if timer is 000 to not trigger transition
		pad $82ba8f
org $80C74F
	rtl							; disable timer update
endif

; ----------------- deathCounter -------------------------------
if !deathCounter == 1
org $82809d
;		sed
;		lda $7c
;		clc
		jsl NewWhileDead
		adc #$0001
		sta $7c
		cld
		padbyte $ea
		pad $8280a7

org $8094da
		lda #$0001		;Make life counter start out with 00 lifes
org $8cfd9a
		lda #$0001

org $8095c7			;Continue?
endif

; ----------------- make use of empty GFX provided with SC4ed extension -------------------------------
if !removeGFXreuse == 1
org $868934			;Terminate second loads lvl 2
	db $ff,$ff
org $68967			;Terminate second loads lvl 9 Swamp
	db $ff,$ff
org $6897a			;Terminate second loads lvl a River	also removes 2bb gfx.. 
	db $ff,$ff	
org $689ae			;Terminate second loads lvl e Catacomb
	db $ff,$ff	
org $689bc			;Terminate second loads lvl 12 Puwexil 
	db $ff,$ff	
org $689ef			;Terminate second loads lvl 18 Amazone
	db $ff,$ff	
org $68a02			;Terminate second loads lvl 19 Amazone
	db $ff,$ff		
org $68a15			;Terminate second loads lvl 1a Castle
	db $ff,$ff
org $68a31			;Terminate second loads lvl 1c Castle Interior
	db $ff,$ff	
org $68a3f			;Terminate second loads lvl 1f Castle DanceRoom
	db $ff,$ff	
org $68a77			;Terminate second loads lvl 2c Stage 8 part 2
	db $ff,$ff		
endif

if !levelSelect == 1
org $809477
	dw $9a63			; change main game state table 00
;org $8014d3
;	db $80				; always branch	so level is not reset for lvl 0 
org $809a77
	dw $0064			; pointer?? unused table we now read from 
org $809af9	
	jmp $94c5
endif 


org $83DF55			; bloodTripTimerTo Do Damaga again
		LDA.W #$0006                         ;83DF55|A94000  |      ;  
org $83DF5E
		SBC.W #$0001                         ;83DF5E|E90200  |      ;  

; progression showing map 
org $81F683
 db $05,$0d,$07,$17,$19,$22,$29,$2D,$35,$3B                               ;81F68C| mapProgression lvl for next scene
org $80DFEE 
		jml newOrbPickupBehavior
pullPC
	newOrbPickupBehavior:
		jsl clearSelectedEventSlotAll		; jijack fix 
		lda $86				
		cmp #$002c
		bne +
		dec 				; harcoded sequentz after puwexorb 
		sta $86
		lda #$0006
		sta $70
		
		LDA.W #$0017                         ;80DFF2|A99000  |      ;  
        JSL.L lunchSFXfromAccum              ;80DFF5|22E38580|8085E3;  		
		
	+	rtl 
	
PushPC 


; ----------------- whip upgrade -------------------------------
org $80E014
WhipUpgradDropCheck: 
	JSL.L burnAndDropItem
	jml newSmallHeartWhipUpgradeCheck
org $80E070
		burnAndDropItem:

org $809545
	noHealtWhileLoadingBranch:  				; reset stats
;	LDA.W #$0005                  
;    STA.W $13f2				; RAM_81_simonStat_Hearts        ;809548|8DF213  |8113F2;  
 ;   STZ.B $8e				; RAM_simon_subWeapon            ;80954B|648E    |00008E;  
;    STZ.B $90				; RAM_simon_multiShot            ;80954D|6490    |000090;  
;    STZ.B $92				; RAM_simon_whipType             ;80954F|6492    |000092;  
	jsl halfHeartCount

	STZ.W $13c6				; RAM_81_BG3_subweaponHitCounter ;809551|9CC613  |8113C6;  
    LDA.W #$0010                       
    STA.W $13f4				; RAM_81_simonStat_Health_HUD    ;809557|8DF413  |8113F4;  
    STA.W $13f6				; RAM_81_boss_Health_HUD         ;80955A|8DF613  |8113F6; 
padbyte $ea
pad $80955D
warnPC $80955D

org $8094C5
	mainGameStartUp_04:						; firstLevelLoad setUp in levelJobLoad jobs.asm

org $809778
;    JSL.L NewWhileDead						; only death by pit

org $819255
	subweaponHeartCost:
	dw $0000,$0001,$0001,$0001,$0002,$0003 		
org $81A6FA	
	subWeaponDamageData:
	dw $0048,$0030,$0030,$0030,$0000                               

org $80BD36				; clock behavier
;		LDA.W #$0100                         ;80BD36|A90001  |      ;  
;		STA.W RAM_81_simonStat_stopWatchTimer;80BD39|8DFA13  |8113FA;  
;		LDA.W #$00F2                         ;80BD3C|A9F200  |      ;  
;		JML.L lunchSFXfromAccum              ;80BD3F|5CE38580|8085E3;  
		lda #$0094				;36 94 56
		jsl lunchSFXfromAccum
		jml newStopWatchbehavier


org $80badd					
		lda #$0010				; default 0008 axe hitbox 
org $80bae2					
		lda #$0010				; default 0008 axe hitbox
org $80bb8a                     
		lda #$0008				; default 0004 holywater hitbox 	
;org $80bc03                     
;		lda #$0010				; default 0008 holywater hitbox wide ypos
org $80BBFC
		lda #$0050				; holy water timer
		jsl newHolyWbehavier
org $80BC12
		jsl newHolyWbehavierFlame



pullPC
	restoreStopWatchCost:
		sed
		lda RAM_simonStat_Hearts
		clc
		adc #$0003
		sta RAM_simonStat_Hearts
		cld 
		rtl 
	
	newStopWatchbehavier:	
		lda $444
		bne restoreStopWatchCost
		
		jsl checkForMan2Heal
		
		phx 
		lda RAM_simonStat_Health_HUD		; give health
		cmp #$0010
		beq +
		inc.w RAM_simonStat_Health_HUD		; restor on health when not full 
				
	+	lda #$0028							; timer herb coldown
		sta $444
		
		lda $442							; slot not in use and values most likely be overwritten 
		clc
		adc #$0002
		cmp #$000a
		bne +
		lda #$0000
	+	sta $442
		tax 
		lda.l stopwatchEffects,x 
		sta $44 	

	++	plx 
		rtl 
	stopwatchEffects:
		dw $0008,$0d00,$000f,$0400,$0004 

	checkForMan2Heal:
		lda $86
		cmp #$0007		; check that we are in town 
		bne +
		lda $13d4		; check current death entrance
		bne +
		lda !ownedWhipTypes
		cmp #$0003
		bne +
		
		phx
		ldx #$0800		; spawn NPC HunterBoss
		lda #$000d
		sta $10,x 
		lda #$001f
		sta $14,x 
		lda #$0048
		sta $0e,x 
		lda #$0314
		sta $0a,x 
		lda #$0080
		sta RAM_X_event_slot_HitboxID,x  
		lda #$0160
		sta RAM_X_event_slot_SpriteAdr,x
		lda #$0010
		sta RAM_X_event_slot_HitboxYpos,x 
		sta RAM_X_event_slot_HitboxXpos,x
		
		plx 
	+	rtl

	newHolyWbehavier:
		STA.B RAM_X_event_slot_24,X          ;80BBFF|9524    |000024;  hijack fix
        STZ.B RAM_X_event_slot_22,X          ;80BC01|7422    |000022;  
		lda #$0001							; make it slide 
		sta $2c,x 
		
		lda RAM_X_event_slot_xSpd,x
		bmi +
		lda #$0000
		sta RAM_X_event_slot_xSpd,x
		lda #$c000
		sta RAM_X_event_slot_xSpdSub,x 
		bra ++
	+	
		lda #$ffff
		sta RAM_X_event_slot_xSpd,x
		lda #$4000
		sta RAM_X_event_slot_xSpdSub,x 
	++	rtl 

	newHolyWbehavierFlame:
		JSL.L $80BC1F                    ;80BC12|221FBC80|80BC1F;  	hijack fix
		lda #$0001
		sta RAM_X_event_slot_ySpd,x		 ; fall speed for flame 
		
		phx 
		LDA.B RAM_X_event_slot_xPos,X        
        STA.B $00							 
        LDA.B RAM_X_event_slot_yPos,X        
        CLC                                  
        ADC.W #$0001                         
        STA.B $02						     
        JSL.L $80CF86 		; readCollusionTable7e4000       ;80BBC9|2286CF80|80CF86;  
   
		BEQ +                   
        BMI +  
		plx 
		stz.b $2c,x 		; also makes it stuck inside a wall. dirty but kinda works lol
		bra ++ 
	+	plx 

	++	phx
		LDA.B RAM_X_event_slot_xPos,X        				; check if we can fall again
        STA.B $00							 
        LDA.B RAM_X_event_slot_yPos,X        
        CLC                                  
        ADC.W #$0008                         
        STA.B $02						     
        JSL.L $80CF86 		; readCollusionTable7e4000       ;80BBC9|2286CF80|80CF86;  
   
		BEQ +                   
        BMI +  
		plx 
		bra ++ 
	+	plx 
		lda #$0003
		sta $2c,x 
	++	rtl 
	
pushPC 	
	

org $828ac4
	lda #$000c				; #$0008 rotating platform timer till it rotates

	
	
	
;entrances 278000 ROM 138000

;0A03`	State0 DeathEntrance
;6E00   Xpos
;B600   ypos
;0200   cam0Xpos
;0800   cam0Ypos
;8000   cam1Xpos
;0400   cam1ypos
;0100   State1
;0000   EntranceNumber
;0500	BorderLeft
;0002	BorderRight
;0600	BorderTop
;0700	BorderBottom
;6666	ScrollSpeedXDirection
;0080	ScrollSpeedYDirection
;B2C3	ScrollBehavierPointer? 


;58C3	;lvl 0 	type 6 
;76C3    ;lvl 1	type 0
;94C3    ;lvl 2	(TwoScreensLong)
;94C3    ;lvl 3	(TwoScreensLongIntersected)
;94C3    ;lvl 4
;B2C3    ;lvl 5
;B2C3    ;lvl 6
;B2C3    ;lvl 7
;D0C3    ;lvl 8
;EEC3    ;lvl 9
;0CC4    ;lvl a
;0CC4    ;lvl b
;2AC4    ;lvl c
;48C4    ;lvl d
;66C4    ;lvl e
;66C4    ;lvl f
;66C4    ;lvl 10
;66C4    ;lvl 11
;84C4    ;lvl 12
;84C4    ;lvl 13
;84C4    ;lvl 14
;A2C4    ;lvl 15
;C0C4    ;lvl 16
;DEC4    ;lvl 17
;FCC4    ;lvl 18
;1AC5    ;lvl 19
;38C5    ;lvl 1a
;38C5    ;lvl 1b
;56C5    ;lvl 1c
;56C5    ;lvl 1d
;56C5    ;lvl 1e
;74C5    ;lvl 1f
;74C5    ;lvl 20
;74C5    ;lvl 21
;74C5    ;lvl 22
;92C5    ;lvl 23
;92C5    ;lvl 24
;92C5    ;lvl 25
;B0C5    ;lvl 26
;B0C5    ;lvl 27
;B0C5    ;lvl 28
;B0C5    ;lvl 29
;CEC5    ;lvl 2a
;CEC5    ;lvl 2b
;ECC5    ;lvl 2c
;ECC5    ;lvl 2d
;0AC6    ;lvl 2e
;0AC6    ;lvl 2f
;0AC6    ;lvl 30
;28C6    ;lvl 31
;28C6    ;lvl 32
;28C6    ;lvl 33
;28C6    ;lvl 34
;28C6    ;lvl 35
;28C6    ;lvl 36
;46C6    ;lvl 37
;46C6    ;lvl 38
;46C6    ;lvl 39
;46C6    ;lvl 3a
;64C6    ;lvl 3b
;82C6    ;lvl 3c
;82C6    ;lvl 3d
;A0C6    ;lvl 3e
;BEC6    ;lvl 3f
;DCC6    ;lvl 41
;FAC6    ;lvl 42
;18C7    ;lvl 43
;18C7    ;lvl 44

;org $a0f000									; freeSpacePrePatch

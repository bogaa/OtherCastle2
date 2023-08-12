

; ------------------------- hijack Simon State -----------
org $80A0D2
		jml stateFixForNewStates
		nop
		nop 


org $80A227
;     simonStateTable: 
		dw simonState00_respawn              ;80A227|        |80A249;  	
org $80A249
		dw simonState11_Gradius
		dw simonStateElevate
	simonState11_Gradius:
		jml simonState11_GradiusL
	simonStateElevate:
		rtl 
warnPC $80A279

org $80A279
		simonState00_respawn:
		jsl SimonState00_respawnL
		nop
		nop


org $80A287			; state 2 collusion with ground offset calc
		jml stateFixCoffineRocket02
;org $80A2E1			; state 5 collusion change ducking on ground 
;		jml stateFixCoffineRocket05

; ------------------ old job.asm 

org $80DFF2 
	oneUpPickupBehavier:
		LDA.W #$0086                         ;80DFF2|A99000  |      ;  
        JSL.L lunchSFXfromAccum              ;80DFF5|22E38580|8085E3;  
		JML.L clearSelectedEventSlotAll
warnPC $80E00F


org $80D732		
		jsl hijackPlaceEventType0

org $86B79E									;  hijack special level behavior
		jsl newSpecialLevelBehavier

org $80B964	
		jsl newHeartCostCalc
org $80B99E
		jsl newHeartCostCalc

org $8086E6
		jsl initGameSetup
org $85fe4f
		dw $fed5							; skip Heart Count Down
org $85FF28
		nop									; disable heart reset to 5
		nop
		nop

org $809c13									; disable heart default 5 hearts
		nop
		nop
		nop
org $80945D
		jsl pauseCheckHijack

org $80DFAF
;		jml newDoublPickupBehavier

org $80D40E
		nop									; disable debuff behavier second quest and castle
		nop 

org $80DF00
	whipUpgradePickupBehavier: 
		LDA.W #$0091          				; sound ID            
        JSL.L $8085E3                   
        STZ.W $13ec							; RAM_81_simonStat_whipUpgradDropFlag 
;        LDA.B !whipLeanth          				; RAM_mainGameState   
;        CMP.W #$0001                     
;        BCC +                     
		
;        STZ.B $72                          
;        LDA.W #$000A                     
;        STA.B $70            				; RAM_mainGameState  

	+	INC !whipLeanth         			; RAM_simon_whipType  
        LDA !whipLeanth        			; RAM_simon_whipType  
        CMP #$0007                       
        BCC +                  
        LDA #$0006                     
        STA !whipLeanth      			 	; RAM_simon_whipType  

	+	LDX.B $00fc            				; RAM_XregSlotCurrent   
        JML.L $808C59      					; clearSelectedEventSlotAll  
	
org $80C4BA				
        LDA.W #$0009                        
        JML.L $8085E3                    	
		LDA.W #$0008                        
		JML.L $8085E3
		LDA.W #$0007                        
		JML.L $8085E3  	

org $86B5A9
;		LDA.B $92							; make level load whip GFX based on multiplayer
org $81FA0F									; transition GFX relaod
		dw $B411,$B424,$FF27              ; leather,chain,CHAIN
                             

;org $80BD70 
;	whipStateTable:		
;	dw whipReset,whipIdle,whipWindup,whipDirections,whipLimpWhipReplacement 	; original
;	dw whipLimp,whipSwing1,whipSwing2

org $80BD80
	whipReset:
org $80BDCC
	whipIdle:
org $80BE67
	whipWindup:
org $80BE9A
	whipDirections:	
org $80C0CD
	whipLimpWhipReplacement:	;This is unused and could replace the whipDirections
org $80C0DC 
	whipLimp:
org $80C3A4 
	whipSwing1:
org $80C3B0
	whipSwing2:

org $80bd66						; new whip behavier
		jsl.l newWhipTypeBehavier
		plx 
		sta.b $00
		jmp.w ($00)
warnPC $80BD7E

org $80BE9F
		jsl NewWhipLeangthBehavier
		nop
		nop
org $80AB28
		jml NewWhipLeangthBehavierRing


org $819261
;	whipLeangthLinkCount: 
;		dw $0008,$0007,$0007                 ;819261
org $8190fb
	dw $009F,$009F,$00DF					; swing Leangth 

org $80DE03
	jsl newWhipColdwons
	nop 

org $80DE0E
	jsl newSubweaponCuldowns
	nop 


org $81a3da						; hud display "block" replace
table "code/text_table_sc4.txt"	;[,rtl/ltr]	
	db "CURSE"
cleartable 
org $81a3fb						; remove letters HUD
;	db $00						; = 
org $81a400						
;	db $00						; =
org $81a417
	db $00,$00,$00,$00			; time

org $81A6EC
   whipDamageData: 
	dw $0020,$0008
	dw $0030,$0010           
    dw $0000,$001c 


; ------- the other hijack I know what a mess haha embrase the chaos -------------------------------------------
; ------------------------- HIJACKS -------
org $82C0B8		; falling block stage 8 hardcode slot offset 
		jsl hardcodeSlotOffsetBrige8
  

org $80DC36		; we can detect here if you murder the hunter 
		jsl detectMurderOnHunter
	; JSL.L collectableItemDroper          ;80DC36|2214E080|80E014;  


org $808649
		jsl konamiCode
	;   JSL.L CODE_8098BE                    ;808649|22BE9880|8098BE;  

         
org $80EB11
		jml findSimonBelowInRangeMakeState01 ; snake 32 hijack first state 

org $829350									 ; mute music before boss
		jsl bossCountdown
;		JSL.L CODE_8085E3                    ; 829350|22E38580|8085E3;  

org $8293EC
		jsl bossLunch 

org $80A366
		JSL.L stairFixCounterRoutine         ; 80A366|2262A880|80A862;  
		
org $80B237 
		jml stairFix

org $80BD25
		jsl crossCatchRoutine				; get heart back when catching
		nop
		nop 

org $80DF72
		jml $80DF99 						; dont check for one up from points 

org $81f2d8
		dw $0418							; move breakable stairs collusion remove pointer Stage 8 

org $86b7ff		; hijacks
	JSL.L $86AC59
;	nop				; disable all 3th bg scene load?? .. done in levelBG0Mapping: 
;	nop
;	nop
;	nop
org $8297E2
	LDA.W #$0008	; #$0010   ; hunchback timer after landing                      ;8297E2|A91000  |   
org $8297ea			; hunchback event 57 hijack
	jml newHunchbackSript
org $81BB8B
hunchBackJumpLongSpeeXposSub: 
	dw $2000                                                                     
hunchBackJumpLongSpeeXpos: 
	dw $0002,$E000,$FFFD               

org $81A4DC
    dl event_ID_40_unusedTurningPlatform ;81A4DC|        |828A87;  
org $81A551 
    dl eventNewPlatform					; event_ID_67_emptyEvent            ;81A551|        |83D3EF;
org $81A461
    dl NewFloatingPlatform_ev17        ;81A461|        |82C2B0; 17
org $81A58D
	dl coffineRocket			; dl event_ID_7b_coffineCircle         ;81A58D|        |82ACA7;  


org $8094C5 
		LDA.W #$2000                      ; points neede to get a extra life after startup game
        STA.B $7e							; RAM_simon_PointsTillExtraLife  ;8094C8|857E    |00007E;  
        STZ.W $13C2                           
        STZ.W $13C4                           

    ;    LDA.W $1e02						; RAM_81_titleScreen_menuSelect  ;8094D0|AD021E  |811E02; start menu selection??
    ;    BNE +                     		  
	;	STZ.B RAM_currentLevel               ;8094D5|6486    |000086; setStarting Level
		nop
		nop
		nop		
		jsl newStarterLevel
		INC.W $13E8

org $80DF81						; extra life from points behavior
		STA.B $13f0 				; RAM_simon_Lifes                ;80DF81|857C    |00007C;  	  

org $81A4FD
	dl newEventID4b           ; dl event_ID_4b_unusedBat             ;81A4FD|        |82C757;  
org $82CD08
	jsl newChandelire
	nop 
org $828DF9
	jml newTable
org $828C4A				
    ironGateState03: 		; ironGateFix Changing sprite priority	
		PHX                                
		LDY.W #$8018                        
;		LDA.B $9C                           
;		EOR.W #$0001                        
;		STA.B $9C                           
;		BEQ +                 
		cpy $0542
		bne +
		LDY.W #$0000                        
	+	STY.W $0542			; RAM_81_simonSlot_spritePriority
        STY.W $0402                          
        STY.W $0202                          
        STY.W $0242                          
        STY.W $0282                          
        STY.W $02C2                          
        STY.W $0302                          
        STY.W $0342                          
        STY.W $0382                          
        STY.W $03C2                          
        PLX                                  
        STX.B $fc		; RAM_XregSlotCurrent            
        INC.B $12,X                          
        RTL                                 

org $85FF7B
	stairFixCounterRoutine:
		lda #$0008				; set counter on stairs so you can walk off in air without it beein wierd 
		sta !stairFixCounter
		
		jsl $80A862				; hijack Fix   
		rtl 
	
	stairFix:
		lda !stairFixCounter 	; use coldown to not go off when walking off the stairs in air 
		beq +
		sec
		sbc #$0001
		sta !stairFixCounter		
		bra ++
		
	+	lda $141c			; add a other check..
		inc
		bpl ++
		jml $80B2C1
		
	++	lda $142c
		inc
		bpl +
		jml $80b2c1
		
	+	jml $80B282			; clc no Stairs 

org $86A7B9
	setting82Routine0b: 
		JSL.L $869E73                    	 ;86A7B9|22739E86|869E73;  
        JSL.L $86A06B                    	 ;86A7BD|226BA086|86A06B;  
        LDX.W #$1280                         ;86A7C1|A28012  |      ;  
        LDY.W #$4000                         ;86A7C4|A00040  |      ;  
        LDA.W #$0000                         ;86A7C7|A90000  |      ;  
        JSR.W $A886                    		 ;86A7CA|2086A8  |86A886; ?? 
 
        LDX.W #$0001                         ;86A7DB|A20100  |      ;  
        LDY.W #$C000                         ;86A7DE|A000C0  |      ;  
		lda $54a 
		cmp #$04d0                         ;86A7D6|C90004  |      ;  
        bcs CODE_86A7F0                      ;86A7D9|9015    |86A7F0;  

		jml newBGScrolling
;        LDX.W #$0000                         ;86A7CD|A20000  |      ;   ySpeed BG blocks moving Up old 
;        LDY.W #$6000                         ;86A7D0|A00060  |      ;
;        LDA.W RAM_BG1_ScrollingSlot          ;86A7D3|AD8012  |001280;  
;        CMP.W #$0400                         ;86A7D6|C90004  |      ;  
;        BCC CODE_86A7F0                      ;86A7D9|9015    |86A7F0;  
;        LDX.W #$0001                         ;86A7DB|A20100  |      ;  
;        LDY.W #$C000                         ;86A7DE|A000C0  |      ;  
;        CMP.W #$0600                         ;86A7E1|C90006  |      ;  
;        BCC CODE_86A7F0                      ;86A7E4|900A    |86A7F0;  
;        LDA.W $1298                          ;86A7E6|AD9812  |001298;  
;        STA.W $12D8                          ;86A7E9|8DD812  |0012D8;  
;        LDX.W #$0000                         ;86A7EC|A20000  |      ;  
;        TXY                                  ;86A7EF|9B      |      ;  
org $86A7F0 
    CODE_86A7F0: 
		STX.B $02                            ;86A7F0|8602    |000002;  
        STY.B $00                            ;86A7F2|8400    |000000;  
	endBGscrollingLevelTypeB:
org $86A859
		jml newEndofTypeBStage
;	LDA.W #$0002                         ;86A859|A90200  |      ;  
;   STA.B $82                            ;86A85C|8582    |000082;  

; ---------------- hijack Picture Lady 
org $83D686
    dw pictureLadyState00
	dw pictureLadyState01
	dw pictureLadyState02 
	dw pictureLadyState03
  	pictureLadyState00: 
		LDA.W #$0040		; #$0046                         ;83D68C|A94600  |      ;  
org $83D6A2
  	pictureLadyState01: 
		jml newPictureLadyRoutine
	pictureLadyState02:
		jsl pictureLadyGrabHoldSimon		
		LDA.W RAM_81_simonSlot_State       
        CMP.W #$0002                         
        bne +  
		jsl pictureLadyCurseLunch
	+	rtl 
	pictureLadyState03:
		jsl pictureLadyState03Long
;		jsr $d6fd 		; speed up animation 
		lda RAM_X_event_slot_34,X 
		lsr
		sta RAM_X_event_slot_34,X 
		rtl 
warnPC $83D6F9 

; ---------------- hijack BolderThrowState stage 8 enemy
org $83D5C9
        CMP.W #$00f0                         ;83D5C9|C93000  |      ;  
        BPL +                      			;83D5CC|100F    |83D5DD;  
        LDA.W #$0036                        ;83D5CE|A98000  |      ; 10 
		jsl backupBolderStatuePos
;        JSL.L $8085E3                    ;83D5D1|22E38580|8085E3;  
        INC.B RAM_X_event_slot_state,X       ;83D5D5|F612    |000012;  
		LDA.B RAM_X_event_slot_22,X          ; bolderDropingStatueState01: 83D5D7|B522    |000022;  
        BEQ ++                      		;83D5D9|F003    |83D5DE;  
        DEC.B RAM_X_event_slot_22,X          ;83D5DB|D622    |000022;  
    + 	RTL                                  ;83D5DD|6B      |      ;  
	++	LDA.B RAM_X_event_slot_32,X 

org $83D62C		; skip bg update that can be scrolled on screen 
		jml $83D64E

org $83D5DE		; NewBolderStatue
		lda $20,x 
		clc 
		adc #$0001
		sta $20,x 
		cmp #$0040		; timer to throw bolders 
		bne +
		stz.w $20,x 
		LDA.W #$0080                         ;83D5CE|A98000  |      ;  
        JSL.L $8085E3                    ;83D5D1|22E38580|8085E3;  		
		jsl $83D620		
	+	rtl 
	
	backupBolderStatuePos:
		JSL.L $8085E3		; hijack fix play sound 
		lda $0a,x
		sta $3a,x
		lda $0e,x 
		sta $3e,x
		
		rtl 
warnPC $83D666 ; NOT FREE SPACE TILL HERE!!
org $83D66E                      
	jml resetBolderThrowStatue
	; JML.L clearSelectedEventSlotAll      ;83D66E|5C598C80|808C59;  

; ----------------- hijack BoneDragon 
org $82B5A3
	JML boneDragonSpawnTweak
	spawnBoneDragon:


; only render score in pause
org $80C729
		LDY.W #$5848			; move score where simons health is 
		jml renderScoreWhilePause
org $80C73E						; dont render health while pause to show score 
		jml newHealthUpdate				
		nop 
		nop
org $85FC92						; make secret reusable 
;   STY.W $1604                          ;85FC92|8C0416  |811604;  		
		nop
		nop
		nop
 
org $85FB37 
		jsl newTreasurOpenBehavier

org $86C56F						; diving Bat hijack 
		jml newDivingBat

; ----------------------- tripple Shot pickup behavier -------------------
org $80DF9B
	;doubleShotPickupBehavier: 
		jml newDoubleShotPickup			; dog 
		nop
		nop 
org $80DFA3		
	tripleShotPickupBehavier: 
		jml newTrippleShotPickup		; key 
		nop
		nop 

org $80D253			; small Heart snow fix 
		jml smallHeartSnowFix


org $83F096			; crumbling bridge 
	; bridgeColaps_stateTable: 
		dw bridgeColaps_state00              ;83F096|        |83F0A0;  
        dw bridgeColaps_state01              ;83F098|        |83F0A8;  
		dw $F173				;       dw bridgeColaps_state02              ;83F09A|        |83F173;  
		dw $F1D8				;       dw bridgeColaps_state03              ;83F09C|        |83F1D8;  
		dw $F246				;       dw bridgeColaps_state04              ;83F09E|        |83F246;  
        dw boneDragonBoss00                                                    ;      |        |      ;  
		dw boneDragonBoss01
		dw boneDragonBoss02
	bridgeColaps_state00: 
		jml bridgeColaps_state00L 
                                                            ;      |        |      ;  

	bridgeColaps_state01: 
		jml bridgeColaps_state01L
	
	boneDragonBoss00:
		jml boneDragonBossHead00L
	
	boneDragonBoss01:
		jml boneDragonBossSpawn
	boneDragonBoss02:			; dragonTail 
		jml boneDragonBossTail
	
	warnPC $83F0BF
org $83F0BF
	branchEndCrumblingBridgeHijack:	
;org $83F262
;	LDX.W #$0f00                         ; fix shortage of events for boss spawn !! FIXME?? 83F262|A20008  |      ;  
;
;org $83F25D
;	jml clearSelectedEventSlotAll

org $83F2BA	
	jsl newBatSpawnRoutineBridge
	
;org $81A506
;	dl divingBatFIXhijack	

org $82B990
		dw skellyHighFiveTable00		; movedRoutine 
org $82B99C							; highFiveSkelly NewStates 
		dw skellyHighFiveTable06		; fireball	
	skellyHighFiveTable06:
		jml skellyHighFiveFireBall
warnPC $82B9A6

org $82B9E9							; highFiveSkellyFireballRoutine 
;	skellyHighFiveTable03:
		jml newHighFiveSkellyFireBall

	skellyHighFiveTable00:	
		jml movedSkellyHighFiveTable00

; ------------------------- freeSpace ---------------------


pullPC	


{; ------------------------- boss crumbling Bridge Dragon  ------------
	; RAM $20,x followPosX, 30-32 direction delay 36-3e tailPointer in head Event 
	; RAM $22,x followPosY,  34??

;	divingBatFIXhijack:
;		lda !bridgDragonSpawn	; this is needed as when you boost you skip spawns.. not a perfect fix but should do the trick  FIXME!! bad fix  
;		beq +
;		lda #$fffe 
;		sta RAM_X_event_slot_xSpd,X 
;		lda #$4000
;		sta.b $04,x 
;		lda #$0013
;		jsl lunchSFXfromAccum
;	+	jml $86C540
	
	boneDragonBossTail:
		lda #dragonNeckLong
		sta $00,x 
		lda #$0081
		sta RAM_X_event_slot_HitboxID,x  
		lda #$0003
		sta RAM_X_event_slot_Movement2c,x
		
		LDA $3e,x 
		beq +
		tay 

		jsl boxRestrictedMovemnt
		jsl copyDeminishedSpeedvaluesXpos
		jsl copyDeminishedSpeedvaluesYpos
	+	rtl 

	boxRestrictedMovemnt:
;getPixleOffsetXposAwayFromSimon:     		; 82D647
		LDA.B RAM_X_event_slot_xPos,X      	; change it to get pixle away form event and update pos if outside range 
        SEC                                 
        SBC.W RAM_X_event_slot_xPos,Y       
        BPL +
        EOR.W #$FFFF
		cmp #$0020								; check distance
		bcc ++
		lda.w RAM_X_event_slot_xPos,Y        	; set max distance away from nighbour event   
		sec
		sbc #$0020								  
		sta RAM_X_event_slot_xPos,X  
		
		jmp ++
		
	+	cmp #$0020								; check distance
		bcc ++
		
		lda #$0020
		clc 
		adc.w RAM_X_event_slot_xPos,Y   		; set max distance away from nighbour event 
		sta RAM_X_event_slot_xPos,X  		
	
	++	LDA.B RAM_X_event_slot_yPos,X      	; change it to get pixle away form event and update pos if outside range 
        SEC                                 
        SBC.W RAM_X_event_slot_yPos,Y       
        BPL +
        EOR.W #$FFFF
		cmp #$000c								; check distance
		bcc ++
		lda.w RAM_X_event_slot_yPos,Y        	; set max distance away from nighbour event   
		sec
		sbc #$000c							  
		sta RAM_X_event_slot_yPos,X  
		
		jmp ++
		
	+	cmp #$000c								; check distance
		bcc ++
		
		lda #$000c
		clc 
		adc.w RAM_X_event_slot_yPos,Y   		; set max distance away from nighbour event 
		sta RAM_X_event_slot_yPos,X  		     
		
	++	RTL                                

	copyDeminishedSpeedvaluesXpos:
		lda.w RAM_X_event_slot_flip_mirror_attribute,y 	; flip sprite 
		sta.b RAM_X_event_slot_flip_mirror_attribute,x
		and #$f000
		beq +
		lda #$fffe
		jmp ++
	+	lda #$0001	
	++	sta.b RAM_X_event_slot_xSpd,x 
		lda #$8000
		sta.b RAM_X_event_slot_xSpdSub,x  	
		rtl 
		
	copyDeminishedSpeedvaluesYpos:
		lda $22,x 
		cmp #$0003
		bne +
		
		lda.w RAM_X_event_slot_ySpd,y 				; invert boss values so the tail moves oposite where he moves 
		eor #$ffff
		sta.b RAM_X_event_slot_ySpd,x 
		lda.w RAM_X_event_slot_ySpdSub,y
		eor #$ffff	
		sta.b RAM_X_event_slot_ySpdSub,x 
		rtl 

	+	lda.w RAM_X_event_slot_ySpd,y 
		sta.b RAM_X_event_slot_ySpd,x 
		lda.w RAM_X_event_slot_ySpdSub,y 
		sta.b RAM_X_event_slot_ySpdSub,x 
		rtl 

	boneDragonBossHead00L:		
		lda.b $16,x
		lsr 
		lsr 
		sta.b $16,x 							; reduse hitstun 
		lda #$B123
		sta $00,x 
		
		lda #$00c7
		sta RAM_X_event_slot_HitboxID,x  
		lda #$0010
		sta RAM_X_event_slot_HitboxXpos,x
		lda #$0008
		sta RAM_X_event_slot_HitboxYpos,x
		
		
		jsr bossDragonBridgeHealthHud
		
		jsr bossMovment 		
		
		lda $3e,x 								; once we collected them and updated them we can skip this 
		beq +
		jsr tailMovementPointerUpdate		
		
	+	lda $06,x 
		bit #$f000
		beq bossDragonDefeted
		and #$0f00
		bne +
		ldy.w $3c,x 
		beq +
		stz.b $3c,x 
		jsr loseDragonTail

	+	cmp #$0300
		bne +
		ldy.w $36,x 
		beq +
		stz.b $36,x 
		jsr loseDragonTail

	+	cmp #$0200
		bne +
		ldy.w $38,x 
		beq +
		stz.b $38,x 
		jsr loseDragonTail

	+	cmp #$0100
		bne +
		ldy.w $3a,x 
		beq +
		stz.b $3a,x 
		jsr loseDragonTail
	
	+	rtl 
	
	loseDragonTail:
		pha 
		lda #$003d
		sta.w $10,y 
		lda #$0000
		sta.w $14,y 	
		sta.w $12,y 
		pla 		
		rts 
	
	bossDragonDefeted:
		lda #$0020
		jsl lunchSFXfromAccum
		
		lda #$003d
		sta $10,x 
		stz.b $14,x 
		stz.b $12,x 
		lda #$5e0			; campera 1th boss 
		sta $a2 
		lda RAM_simonSlot_Xpos
		cmp #$0500
		bcc +
		lda #$0700			; campera 1th boss 
		sta $a2 
	+	rtl 
	
	bossMovment: 
		lda #$0003
		sta RAM_X_event_slot_Movement2c,x 
		
;		lda RAM_simonSlot_Ypos
;		sta RAM_X_event_slot_mask,X
;		jsl $86C5DD
		
		LDA.w RAM_simonSlot_Xpos
		sta $20,x 
		LDA.w RAM_simonSlot_Ypos
		sta $22,x 
		
		jsl bridgeDragonXposMovment
		jsl bridgeDragonyposMovment
		jsl bossArenaBounderiesYposDragon		
		rts
 
	bossArenaBounderiesYposDragon: 
		LDA.B RAM_X_event_slot_yPos,X   
        CMP.W #$00f0                    
        BCS +     
        CMP.W #$0010                    
        BCC ++        
        RTL                             
	+	lda #$00f0
		sta RAM_X_event_slot_yPos,X 
		rtl 	
	++	lda #$0010	
		sta RAM_X_event_slot_yPos,X 
		rtl 

	tailMovementPointerUpdate:	; give all the tails the pointer for there event they should follow 		
		lda #$0002			; set number of updates 
		sta.w $00
		phx 
		
		lda $36,x 			; this is our X slot so we do not need to phx 
		pha 
		lda $38,x 
		pha 
		lda $3a,x 
		pha 
		lda $3c,x 
		tay  
		lda $3e,x 
		tax  	

	-	txa 
		sta.w $3e,y 
		lda.w $00
		inc 
		sta.w $22,y 	
	
		tyx 
		ply 
		dec.w $00 
		bpl -	
		
		txa 				; last entery 
		sta.w $3e,y 		

		plx 			
		stz.b $3e,x 		; clear BossHead Ram slot after we destributed the pointers 
		rts
		 
	
	bridgeDragonXposMovment:
		LDA.w $20,x     
        CMP.B RAM_X_event_slot_xPos,X     
        BCC bridgeDragonMoveBackwardDelayX          
		                             
	bridgeDragonMoveForwardDelayX:		
		dec $30,x 			; moment change delay counter 
		lda $30,x 
		cmp #$ffd0
		bcs bridgeDragonMoveBackward  
	
	bridgeDragonMoveForward:	
		lda $04,x 
		ora #$4000
		sta $04,x 	
		
		CLC    
		LDA.B RAM_X_event_slot_xSpdSub,X     
        ADC.W #$0800                         
        STA.B RAM_X_event_slot_xSpdSub,X     
        LDA.B RAM_X_event_slot_xSpd,X        
        ADC.W #$0000                         
		cmp #$0003			; speed cap
		beq +
		STA.B RAM_X_event_slot_xSpd,X        
     +  RTL                                  
	
	bridgeDragonMoveBackwardDelayX:
		inc $30,x 			; moment change delay counter 
		lda $30,x 
		cmp #$0030
		bcc bridgeDragonMoveForward  

	bridgeDragonMoveBackward: 
		lda $04,x 
		and #$Bfff
		sta $04,x 	
		
		SEC                                  
        LDA.B RAM_X_event_slot_xSpdSub,X     
        SBC.W #$0800                         
        STA.B RAM_X_event_slot_xSpdSub,X     
        LDA.B RAM_X_event_slot_xSpd,X        
        SBC.W #$0000                         
        cmp #$fffd			; speed cap
		beq +
		STA.B RAM_X_event_slot_xSpd,X        
    +   RTL                                  

; ------------------------------------------------------------------------

	bridgeDragonyposMovment:
		lda.b $22,x 
        CMP.B RAM_X_event_slot_yPos,X
        BCC bridgeDragonMoveForwardDelayY                                    

		
	bridgeDragonMoveDownwardDelay:		
		dec $32,x 			; moment change delay counter 
		lda $32,x 
		cmp #$ffa0
		bcs bridgeDragonMoveDownwardFix

	bridgeDragonMoveUpwared:
		CLC
		LDA.B RAM_X_event_slot_ySpdSub,X    
        ADC.W #$0800                        
        STA.B RAM_X_event_slot_ySpdSub,X    
        LDA.B RAM_X_event_slot_ySpd,X       
        ADC.W #$0000                        
        cmp #$0003			; speed cap
		beq +
		STA.B RAM_X_event_slot_ySpd,X       
    +   RTL                                 
   	bridgeDragonMoveDownwardFix:	
		lda #$ffa0
		sta $32,x 
		jmp bridgeDragonMoveDownward
	
	
	bridgeDragonMoveForwardDelayY:		
		inc $32,x 			; moment change delay counter 
		lda $32,x 
		cmp #$0060
		bcc bridgeDragonMoveUpwaredFix  
		
	bridgeDragonMoveDownward: 
		SEC                                 
        LDA.B RAM_X_event_slot_ySpdSub,X    
        SBC.W #$0800                        
        STA.B RAM_X_event_slot_ySpdSub,X    
        LDA.B RAM_X_event_slot_ySpd,X       
        SBC.W #$0000                        
        cmp #$fffd			; speed cap
		beq +
		STA.B RAM_X_event_slot_ySpd,X       
     +  RTL                                 
	bridgeDragonMoveUpwaredFix:	
		lda #$0060
		sta $32,x 
		jmp bridgeDragonMoveUpwared  

;		jsl $80DEB9						; rossery effect 
	bossDragonBridgeHealthHud:
		lda !bridgDragonHealthHud		; this is done like this to have 2 dragons at once.. but this is stupid gameplay wise
		and #$0fff							; first part is used as falg so it is not treated as normal enemy death routine 
		clc 
		adc $06,x 
		sta !bridgDragonHealthHud		
		rts 
		
	boneDragonBossSpawn:							; spawn all at once and then fix y!! FIXME 
		stz.w !bridgDragonSpawn						; flag clear for next peace
		stz.b RAM_X_event_slot_SpriteAdr,x 
		
		phx 										; backup xSlot 
		lda !bridgDragonLeangth	
		asl		
		tax 
		pla 
		sta !bridgDragonRamPointer,x 
		tax 

		lda !bridgDragonLeangth	
		cmp #$0004								; tail segment langth tails are basicly just sprite and hitbox data.. 
		bne +
		
		dec.b $12,x 							; bossHead spawn 
		inc.w !bridgDragonProgress			; mark boss as Spawned 
		
		phx 									; copy pointer array from the tail to the head. So we can controll the boss from the head 
		phy 
		
		asl
		tay
	-	lda.w !bridgDragonRamPointer,y 
		sta $3e,x 
		
		dex
		dex 
		dey
		dey
		bpl -
		
		ply
		 
		ldx #$000e		
		lda #$0000								; clear pointer and flags for next spawn 
	-	sta.w !bridgDragonSpawn,x 	
		dex
		dex 
		bpl -
		
		plx 
		
		lda #$1400								; boss health and propertys 
		sta $06,x 		
		lda #$0080
		sta RAM_X_event_slot_HitboxID,x  
		lda #$4600
		sta $04,x 
		
		
		jmp ++

	+	inc.b $12,x 							; spawn a dragon tail and propertys 
		inc.w !bridgDragonLeangth		
		
		lda #$4600								; pallete and orientation 
		sta $04,x 
		lda #$0080
		sta RAM_X_event_slot_HitboxID,x  
		
	++	rtl 
	
	bridgeColaps_state00L:							; make space for new states 
		LDA.W #$0080                         
        STA.B RAM_X_event_slot_HitboxID,X    
        INC.B RAM_X_event_slot_state,X       
	-	RTL                                  

	bridgeColaps_state01L:						
		LDA.B RAM_X_event_slot_22,X           
        ASL A                                 
        ASL A                                 
        ASL A                                 
        ASL A                                 
        ASL A                                 
        CLC                                   
        ADC.W #$0130                          
        CMP.W RAM_81_simonSlot_Xpos           
        BCS -                       
        		
		LDY.B RAM_X_event_slot_22,X           
        cpy.w #$0009										; starting point where it can start spawning 
		bcc + 
		jmp spawnBossDragon01
	
	checkSecondDragonSpawn:	
		cpy.w #$001d										; starting point where it can start spawning 
		bcc +
		jmp spawnBossDragon02
		
	checkIfBridgeEnded:
		CPY.W #$0024               						; a 1f dragon            
        BCC +                       

		INC.B RAM_X_event_slot_state,X 					; go to boss state end of the bridge 
		
	+	jml branchEndCrumblingBridgeHijack 
	spawnBossDragon01:
;		cpy #$000e
;		bcs checkSecondDragonSpawn
		lda !bridgDragonProgress
		bne checkSecondDragonSpawn
		lda #$0001
		sta RAM_whiteFadeCounter
		sta !bridgDragonSpawn
		jmp checkSecondDragonSpawn
	spawnBossDragon02:
;		cpy #$0022											; starting point where it can start spawning 
;		bcs checkIfBridgeEnded		
		lda !bridgDragonProgress
		cmp #$0001
		bne checkIfBridgeEnded
		lda #$0001
		sta RAM_whiteFadeCounter		
		sta !bridgDragonSpawn
		jmp checkIfBridgeEnded

	newBatSpawnRoutineBridge:
		lda !bridgDragonSpawn
		beq +	
				
		lda #$007d
		jmp ++	
		
	+	lda #$004e
	++	JSL $80D37A 			; crumblingBridgeWriteEventFromA ;83F2BA|227AD380|80D37A;  	
		rtl
;	crumblingBridgeNewEnding:
;		CPY.W #$0028                         ;83F0BA|C02800  |      ;  
;		BCS	+
;		rtl 
;;	+   lda #$ffff
;;		sta $15fe							; end of event type 1 progression is probably never used anyway.. so nice to use it as a flag when the brige is cleared 
;	minusLongJumpRTL:	
;		sep #$20							
;		pla 
;		rep #$20
;		pla 
;		rtl 	
}


{; --------------------------- event ID 4e diving bat -----------------
	newDivingBat:
	;divingBat_state01:	
		lda $14,x 
		cmp #$0001
		bne ++
		JSL.L getPixleOffsetXposAwayFromSimon
		cmp #$0050
		bpl +
		
		lda #$0003
		sta RAM_X_event_slot_Movement2c,x 
		
		LDA.W #$6000                         
        STA.B RAM_X_event_slot_xSpdSub,X    
        LDA.W #$0001                        
		STA.B RAM_X_event_slot_xSpd,X      
        LDA.W #$4000                      
        STA.B RAM_X_event_slot_flip_mirror_attribute,X		
		
		jml $86C580
	+	rtl
		
	++	JSL.L getPixleOffsetXposAwayFromSimon		;86C56F|2247D682|82D647;  		
		jml $86C573									; normal dive bat check xpos to dive 

}
	
{; -------------------------- AllsmallEnemyTweaks ---------------------	
	
	smallHeartSnowFix:
		lda $20,x 
		cmp #$0001							; this is not perfect since some enemies type 1 or 2 can presist there mask.. but it probaly will not be a issue and worst thing is sprite messup 
		beq +
		LDA.B RAM_X_event_slot_ID,X          ;80D253|B510    |000010;  
        ASL A                                ;80D255|0A      |      ;  
        TAY                                  ;80D256|A8      |      ;  
		jml $80D257 
	+	jml $80D25E
	

		
		
	resetBolderThrowStatue:
		lda #$0000
		sta $00,x 
		sta $12,x			
		sta RAM_X_event_slot_ySpd,x 
		sta RAM_X_event_slot_ySpdSub,x
		sta $2e,x 
		
		lda $3a,x
		sta $0a,x
		lda $3e,x 
		sta $0e,x 
		
		rtl 
	
	newPictureLadyRoutine:		
		jsl $82D647                    ; hijack fix 83D6A2|2247D682|82D647;  
		bpl +
		dec.w RAM_simonSlot_Xpos
		bra ++		
	+	inc.w RAM_simonSlot_Xpos
	++	jsl $82D647                    ; hijack fix
		CMP.W #$0010                         ;83D6A6|C91800  |      ;  
        BPL +                      	;83D6A9|1010    |83D6BB;  
	pictureLadyGrabHoldSimon:
		stz.w RAM_buttonMapWhip
		lda #$0004
		sta.w RAM_simonSlot_SpeedYpos
		stz.w RAM_simonSlot_SpeedSubYpos		
        LDA.W #$A89A                         ;83D6B4|A99AA8  |      ;  
        STA.B $00,X                          ;83D6B7|9500    |000000;  
        lda #$0002 
		sta RAM_X_event_slot_state,X       ;83D6B9|F612    |000012;  
		lda #$0001
		sta RAM_81_simonStat_Stuck
 +		RTL                                  ;83D6BB|6B      |      ;  
	
	
	
	pictureLadyState03Long:
		stz.w RAM_simonSlot_direction
		lda #$0060
		sta $44
		
		lda RAM_X_event_slot_yPosSub,x
		sec
		sbc #$4000
		sta RAM_X_event_slot_yPosSub,x
		lda RAM_X_event_slot_yPos,x
		sbc #$0000
		sta RAM_X_event_slot_yPos,x
		sta RAM_simonSlot_Ypos
		cmp #$0060
		bpl +

		jsl giveSimonCurse
		
	+	lda RAM_X_event_slot_xPos,x
		sta RAM_simonSlot_Xpos
		
		lda.l RAM_simon_DamageDeBuff
		cmp #$0100
		bne +
		jsl endAnimationGetUnstuckPictureLady
	+	rtl 
	
	giveSimonCurse:						; once we reach max hight we give the curse
		lda #$000d
		sta RAM_81_simonSlot_State 
		
		lda #$8000
		sta $04,x 
		
		lda #$0060
		sta RAM_X_event_slot_yPos,x
		sta RAM_simonSlot_Ypos	
		
		sed 
		lda.l RAM_simon_DamageDeBuff
		clc
		adc #$0004
		sta.l RAM_simon_DamageDeBuff
		cld 
		jsl updateCurseHud
		rtl 

	endAnimationGetUnstuckPictureLady:
		lda #$0004
		sta $44 
		
		lda.w !backUpButtonMapWhip
		sta.w RAM_buttonMapWhip
		stz.w RAM_81_simonStat_Stuck
		lda RAM_simonSlot_Ypos	
		pha 
		lda RAM_simonSlot_Xpos
		pha 
		jsl clearSelectedEventSlotAll
		pla 
		sta RAM_X_event_slot_xPos,x
		pla 
		sta RAM_X_event_slot_yPos,x
		lda #$003d
		sta RAM_X_event_slot_ID,x  
		lda #$fffb
		sta RAM_simonSlot_SpeedXpos
		sta RAM_simonSlot_SpeedYpos
		phx
		jsl $80DEB9						; rossery effect 
		plx 
		rtl 
	
	pictureLadyCurseLunch:
		phx
		jsl $80DEB9						; rossery effect 
		plx 
		
		lda #$009a
		jsl $8085E3
		lda #$0003 
		sta RAM_X_event_slot_state,X       ;83D6B9|F612    |000012;  
		rtl 
}

{ ; ------------------------- konami Code Unlock Levels
	konamiCode:
		phx 
		ldx $570
		
		lda $28
		and.l konamiCodeInput,x 			; read table to get end value to unlock the map levels 
		beq +
		lda #$0018							; timer to not fail inputs 
		sta $572
		inx
		inx 
		stx $570 
		cpx #$0014
		bne +
	   
		stz.w $570	   	  
		lda #$0093
		jsl $8085E3
	   
		lda #$0043
		sta.l $700000
	   	   
	+ 	dec $572
		lda $572
		bpl +
		stz.w $572
		stz.w $570
	+	plx 
		JSL.L $8098BE                    ; hijackfix 808649|22BE9880|8098BE;  
		rtl 

	konamiCodeInput:
		dw $0800,$0800,$0400,$0400,$0200,$0100,$0200,$0100,$0080,$8000
}	
	

{	; ----------------------- Simon Gradius Controlls ------------------	
	stateFixCoffineRocket02:
		lda.w #simonInCoffine						; skip stand up from ground when coffine sprite is loaded. 
		cmp.w RAM_simonSlot
		beq +
		LDA.W RAM_81_simonSlot_Collusion_Donno01	;80A287|AD7605  |810576;  
        SEC                                  		;80A28A|38      |      ;  
		jml $80A28B
	+	jml	$80A2AD									; skip state change  

;	stateFixCoffineRocket05:
;		lda.w #simonInCoffine						; skip crouching.. 
;		cmp.w RAM_simonSlot
;		beq +
;		
;		LDA.W RAM_81_simonSlot_Collusion_Donno01	;80A2E1|AD7605  |810576;  
;        SEC                                 	 	;80A2E4|38      |      ;  
;		jml $80A2E5
;	+	jml $80A307

	stateFixForNewStates:
		cmp #$0012
		beq +
		cmp #$0011									; check if fly state 
		beq +
													; forward to state table routine
		LDA.W RAM_81_simonSlot_Collusion_Donno00	;80A0D2|AD6C05  |81056C;  hijack fix 
        BIT.W #$0001                         		;80A0D5|890100  |      ;
		jml $80A0D8
	+	jml $80A217	

	simonState11_GradiusL:							; unused here 
		rtl 


	coffineRocket:
;		lda #$0080							; will break the use on second entrance 
;		sta RAM_X_event_slot_HitboxID,x 
		
		LDA.B RAM_X_event_slot_state,X       ; $20,x subweapon slot offset
        PHX                                  ; $22,x subweapon ID to shoot
        ASL A                                ; $24,x backupSubweapon normal state 
        TAX                                  ; $30,x facing backup attr
        LDA.L coffineRocketStateTable,X      ; $32,x facing backup dir 
        PLX                                  ; $34,x autoScroll 
        STA.B $00                            ; $36,x timer 
        JMP.W ($0000)        
	coffineRocketStateTable:	
		dw coffineRocketState00,coffineRocketState01,coffineRocketState02
		
	coffineRocketState00:
		lda.w #GradiusSpriteAssembly00		; initiate sprite 
		sta $00,x 
		lda #$01c0
		sta $26,x 
		
		lda $14,x
		cmp #$0002
		beq endOfLvlBossSpawn

	coffineRocketStateMounting:
	+	jsl checkSimonCollusionEvent		; check collusion with Simon 
		bcc endCoffineRocket
		
		lda #GradiusSpriteAssembly01
		sta $00,x 

		lda $28							; press B to jump in 
		bit !backUpButtonMapJump
		beq endCoffineRocket
	
		lda #$0002
		sta $12,x 
		
		lda $8e							; backup subweapon 
		sta $24,x 		

		lda #$0001							; give default weapon
		sta $8e 
		
		stz.b RAM_buttonMapWhip			; disable whip 
				
		lda #$0010
		sta $36,x 	
	endCoffineRocket:	
		rtl 

	endOfLvlBossSpawn:
		lda RAM_X_event_slot_xPos,x
		cmp #$0300
		bcs coffineRocketStateMounting
		
		inc $36,x 						; lets make the coffine be wired till the boss event spawns 
		lda $36,x 
		cmp #$0050
		bcs +
		lda RAM_RNG_1
		and #$0E00
		sta $04,x 		
		rtl 
		
	+	lda #$002a						; set boss 
		sta $10,x
		lda #$000b
		sta $14,x 
		lda #$0010
		sta $a6						; set cam 
		lda #$0200
		sta $a0
		sta $a2
		rtl 	

	coffineRocketState02:					; small delay 	
		dec.b $36,x 
		lda $36,x 
		bne +
		lda #$0001
		sta $12,x 
		
		lda $0a,x 						; move simon to not move the coffine what looks wired 
		sta RAM_simonSlot_Xpos 
		lda $0e,x 
		sta RAM_simonSlot_Ypos	
		
		bra ++
	+	lda $3a
		bit #$0004
		beq +
	++	lda.w #GradiusSpriteAssembly01
		bra ++
	+	lda.w #GradiusSpriteAssembly00
	++	sta $00,x 
		rtl 	
	
	coffineRocketState01:		
		lda $14,x 
		
;		lda #$0001
		sta !autoScroll
		
		lda $20							; shoot trigger buttons 
		bit.w !backUpButtonMapWhip
		beq +
		
		lda #$0001						
		sta $22,x 			
		sta RAM_simon_subWeapon	
		
		
	+   lda $20
		bit.w RAM_buttonMapJump
		beq +
		 
		lda #$0003						
		sta $22,x 			
		sta RAM_simon_subWeapon	
		
	+	lda $20											; hold direction while holding button to shoot 
		bit #$c000
		beq +
		lda $30,x 
		sta RAM_simonSlot_spriteAttributeFlipMirror 
		lda $32,x
		sta RAM_simonSlot_direction
		bra ++
	+	lda RAM_simonSlot_spriteAttributeFlipMirror		; backup facing direction so we can keep it while holding button 
		sta $30,x 					
		lda RAM_simonSlot_direction
		sta $32,x 
	
	++	jsl shootingSequentscoffeine 
;		lda $14,x
;		bne +	
;		jsl cofineFlightRoutine							; needs to be at the end for dismount not colliding with our free shoots 
;		rtl	
	+	ldx.w RAM_XregSlotCurrent							; fix a bug wher x sometimes holds 480 
		jsl cofineFlightRoutine
		rtl 
	shootingSequentscoffeine:
		lda $22,x 						; does not shoot from accum but we use it to scheudle shoot.. 
		beq ++
;		lda $36,x 						; shot delay timer countdown 
;		beq +
;		dec.b $36,x
;		bra ++
;	+
		jsl shootSubweaponInAccu
	++	rtl 


	shootSubweaponInAccu:
		lda $20,x 					; offset subweapon slots 
		and #$00ff
		clc 
		adc #$0440
		cmp #$0500					; prevent overlowing slots for supeapon 
		bne +
		lda #$440
	+	phx							; slot occupied test 
		tax 
		lda $0000,x 
		bne +
		txa 
		plx 
;		sta $22,x					; subweapon shot scheudled ??? lda ??
		sta $2fa
		jsl $80B9AB
;		jsl curseInCoffineRoutine	; give curse for every shot 
		stz.b $22,x					; reset shoot for new subweapon 
;		lda #$0002
;		sta.b $36,x 				; delay for shots 
		rtl 

	+	txa							; rotate full slots to find may be empty on the next frame 
		plx 	
		sta $20,x	
		rtl 
		

	checkSimonCollusionEvent:
		lda $54a				; Simon xpos 
		clc  
		adc $28,x  
		cmp $0a,x 				; compare xpos
		bmi ++
		
		lda $0a,x 
		clc
		adc $28,x 
		cmp $54a 		
		bmi ++	
								; 5aa ypos 
		lda $54e				; Simon  ypos 
		clc  
		adc $2a,x  
		cmp $0e,x 				; compare ypos
		bmi ++
		
		lda $0e,x 
		clc
		adc $2a,x
		cmp $54e  
		bmi ++
		sec
		rtl 
		
	++	clc
		rtl 

	cofineFlightRoutine01:
		jsl flightControlls	
		bra +

	cofineFlightRoutine:
		lda $14,x
		cmp #$0002
		beq cofineFlightRoutine01
		
		jsl dismountEndOfLevelRoutine
		jsl flightControlls 
		jsl flightBounderies 
		
		
	+	lda RAM_simonSlot_Xpos ; follow Simon 
		sta $0a,x 
		lda RAM_simonSlot_Ypos
		sta $0e,x 				

		lda #$0004
		sta RAM_simonSlot_State		
		sta RAM_simonSlot_StateBackUp
		
;		lda #$0001				; air 
;		sta $80
;		lda #$9c25

		lda #simonInCoffine
		sta RAM_simonSlot
		stz.w RAM_simonSlot_SubAnimationCounter			; prevent walk frames kicking in 
		
		lda RAM_simonSlot_Collusion_Donno01
		cmp #$000f
		bne +
		jsl dismountCoffine

	+	lda #$001b			; keep jumping collusion game likes to put you in croutch when colliding wiht ground 	
		sta RAM_simonSlot_Collusion_Donno01
;		lda #$0003			; 2 crouch 3 air 
;		sta $57e 
		
;		lda $564
;		cmp $34,x 
;		bne +				; check if counter stops moving to make dismount possible 

		

;		bra ++
;	+	lda $564			; store to find when it stops moving 
;		sta $34,x 
;	++	

;		stz.w RAM_simonSlot
;		lda #$0007
;		sta RAM_simonSlot_AnimationCounter
;		sta RAM_simonSlot_forceCrouchFrameCounter
;		lda #$0006				; duck 
;		sta RAM_simonSlot_State		
		
		lda $13F4					; check if Simon is dead
		bne +		
	
	destroyGradiusShipOnDeath:	
		jsl clearSelectedEventSlotAll	; die and destroy event 
		lda #$003d						
		sta $10,x 
		lda RAM_simonSlot_Xpos
		sta $0a,x 
		lda RAM_simonSlot_Ypos
		sta $0e,x 	
		stz.w !autoScroll	
	+	rtl 

	dismountEndOfLevelRoutine:
		lda #$dff
		cmp $a0 
		bcc dismountEndOfLevel
	-	rtl 
	dismountCoffine:
		lda $20
		cmp #$8400
		bne -
;		lda $28
;		bit #$8000
;		beq -
	dismountEndOfLevel:
		lda $24,x					; give orginal subweapon back 
		sta $8e		
		stz.b $12,x 		
		
		lda !backUpButtonMapWhip	; enable whip again 
		sta RAM_buttonMapWhip
		stz.w !autoScroll
		
		lda $14,x					; set cam on dismount to go and discover stuff 
		cmp #$0002
		beq + 
		stz.b $a0 
		rtl
	+	lda #$0d00
		sta $a2 
		rtl 

	
	flightControlls:
		stz.w RAM_simonSlot_SpeedSubXpos		; stop movment when not pressing directions 
		stz.w RAM_simonSlot_SpeedXpos
		stz.w RAM_simonSlot_SpeedSubYpos
		stz.w RAM_simonSlot_SpeedYpos 
		
		lda $20
		bit #$0100
		bne goRight	
		
	checkLeft:
		lda $20
		bit #$0200
		bne goLeft
		
	checkUp:
		lda $20
		bit #$0400
		bne goUp
		
	checkDown:
		lda $20	
		bit #$0800
		bne	goDown
		rtl 	
		
	goRight:		
		lda #$0001		; incXSpeed
		sta RAM_simonSlot_SpeedXpos
		lda #$c000
		sta RAM_simonSlot_SpeedSubXpos
		bra checkLeft
		
	goLeft:		
		lda #$fffe 		; decXSpeed
		sta RAM_simonSlot_SpeedXpos
		lda #$8000
		sta RAM_simonSlot_SpeedSubXpos
		bra checkUp
		
	goUp:
		lda #$0001		; incYSpeed
		sta RAM_simonSlot_SpeedYpos
		lda #$8000
		sta RAM_simonSlot_SpeedSubYpos
		bra checkDown
		
	goDown:
		lda #$fffe		; decYSpeed
		sta RAM_simonSlot_SpeedYpos
		lda #$8000
		sta RAM_simonSlot_SpeedSubYpos
		rtl	
				

	flightBounderies:
		clc 
		LDA.W RAM_simonSlot_Ypos					; RAM_X_event_slot_yPos,X FIXME x has base $480 sometimes 					; gradiusYposBoundiungPlayer: 
        CMP.W #$00d1                    
        BCS setCoffineIntoBoundBottom     
        
		CMP.W #$000f                    
        BCC setCoffineIntoBoundTop        
        RTL                             

;   curseInCoffineRoutine:
;		lda $22,x 
;		beq +
;		sed 
;		lda.l RAM_simon_DamageDeBuff
;		clc
;		adc #$0001
;		sta.l RAM_simon_DamageDeBuff
;		cld 
;		jsl updateCurseHud
;		
;	+	rtl 
                                                                                                                     
   setCoffineIntoBoundBottom: 
		LDA.W #$00d0                    
 ;       sta RAM_81_X_event_slot_yPos,x 
		sta RAM_simonSlot_Ypos 
		RTL                             
                                        
   setCoffineIntoBoundTop: 
		LDA.W #$0010                    
 ;       sta RAM_81_X_event_slot_yPos,x 
		sta RAM_simonSlot_Ypos
        RTL  	

}

{	; ------------------------ boss fixes ------------------------------	
	
	bossCountdown:
		JSL.L $8085E3  			; hijack fix will mute music with Value $F4 in Accumulator 
		lda #$0001				; this can glitch out boss GFX loading if not disabled 
		sta !noWhipSwitch

		lda $86					; cam fix dancer 
		cmp #$0022
		bne disslunchSimonFromRing
		stz.w $a4	
		stz.w $a6		
	
	disslunchSimonFromRing:
		lda $552				; check simons to dislunch from rings 
		cmp #$0008
		bne +
		lda #$0010 				; cant go to 04 air 10 will dislunch properly??
		sta $552 
		lda #$0000
		sta $0212 				; whip Fix ?? 

		
	+	rtl 
		
	bossLunch:
		stz !noWhipSwitch 		; enable switching again 
		
		LDA.B $5A                            ;8293EC|A55A    |00005A;  hijack fix 
        ORA.B $6A                            ;8293EE|056A    |00006A;  
		rtl 

}

{ ; -------------------------- New Level Type B BG Scroll -------------	
	
	newBGScrolling:
		lda $12c2
		clc 
		adc #$0001
		and #$00ff 
		sta $12c2 
		cmp #$0080
		bmi +
		lda $1280
		ldx #$0001
		ldy #$0000
		bra ++
	+	lda $1280
		ldx #$fffe
		ldy #$ffff
		
	++	jml CODE_86A7F0

	newEndofTypeBStage:
		lda #$0002		; set level lype 
		sta $82
		sta $13d4		; set checkpoint to entrane 2 
		lda #$0600		; set canera
		sta $a0 
		rtl 
}

{ ; ---------------------------- allSmallPatches ----------------------
	newTrippleShotPickup:
		lda #$0002
		ora RAM_simon_multiShot
		sta RAM_simon_multiShot
		lda #$0084
		jsl lunchSFXfromAccum
		bra +
	newDoubleShotPickup:
		LDA.W #$0017 				;#$0084                         
                                                                     
        JSL.L lunchSFXfromAccum                      
		lda RAM_simon_multiShot            
        ora #$0001
		sta RAM_simon_multiShot
	+	JML.L clearSelectedEventSlotAll      
	
	
	hardcodeSlotOffsetBrige8:
		lda $14,x 
		cmp #$0003		; only stage 8 blocks.. 
		bne +
		lda #$0120
		sta $26,x 
	+	JSL.L $80CF86 ; hijack fix readCollusionTable7e4000       ;82C0B8|2286CF80|80CF86;
		rtl
	
	detectMurderOnHunter:
		lda $86
		cmp #$0007		; check that we are in town 
		bne +
		lda $13d4		; check current death entrance
		bne +
		lda.w $10,y 		; check enemy ID killed 
		cmp #$0070
		bne +
		
		sed
		lda !killedHusband	; count how many times you kill him 
		clc
		adc #$0001
		sta !killedHusband
		cld 	
		
	+	JSL.L $80E014	; collectableItemDroper     ; hijack fix      ;80DC36|2214E080|80E014;  
		rtl 
		
	newHealthUpdate:
		lda $66
		bne +
		ldy #$5848			; hijack fix 
		lda $13f4 
		jml $80C7C9

	+	lda #$0002			; skip health update 
		bra ++
		
	renderScoreWhilePause:
		lda $66 		; RAM_PauseFlag
		beq +
		JSL.L $808D52  ; hijack fix                     ; 80C72C|22528D80|808D52; 
		jml $80C730 	

	+	lda #$0001		; skip score update 
	++	jml $80C70E

	boneDragonSpawnTweak:		; make him only spawn on the right yPos to reduce lag 
		jsl $82B70B			; CODE_82B70B     hijack fix        ;82B5A3|220BB782|82B70B; 
		lda RAM_X_event_slot_yPos,x
		clc
		adc #$00c0														; we only check when coming from bellow..
		cmp RAM_simonSlot_Ypos
		bcs +
		rtl 
	+	jml spawnBoneDragon
;secretBreakabGrState00: LDA.W $1602                          ;83E351|AD0216  |811602;  

	halfHeartCount:
		lda RAM_simon_subWeapon								; carry clock through death 
		cmp #$0005
		beq +
		stz.w RAM_simon_subWeapon	
		
	+	phx 
		lda $13f2 
		and #$00f0
		beq +
		lsr
		lsr
		lsr
		lsr
		tax 
		lda.l heartCountAfterDeath,x 
		and #$00ff
		sta $13f2 
		
	+	plx 
		rtl	
	heartCountAfterDeath:
		db $00,$05,$08,$15,$20,$30,$40,$45,$58,$60
	
	
	crossCatchRoutine:
		sbc $54e			; give a heart back when u catch cross 
		cmp #$0020
		bcs hitBoxCheckYposCrossCatchEnd
		
		lda !aramusBelmontCross
		beq giveSimonHeart4CrossCatch
		
		lda RAM_81_simonSlot_Xpos			; hit simon when not facing toward the cross to catch 
		cmp RAM_X_event_slot_xPos,X   
		bcc +
		lda RAM_simonSlot_spriteAttributeFlipMirror
		beq ++
		bra giveSimonHeart4CrossCatch
	+	lda RAM_simonSlot_spriteAttributeFlipMirror		
		beq giveSimonHeart4CrossCatch
				
	++	beq +
		lda #$ffff				; manipulate the direction simon gets boosted 
		sta RAM_81_simonSlot_empty00
		
	+	lda #$000c				; aramus Patch dont trust the cross
		sta RAM_simonSlot_State
		LDA.W #$004e			; 3e   95                      
		jsl lunchSFXfromAccum             
		
		lda RAM_81_simonSlot_empty00	; we got oposit so we toggle 
		eor #$ffff
		sta RAM_81_simonSlot_empty00

	giveSimonHeart4CrossCatch:	
		sed
		lda $13f2
		clc 
		adc #$0001
		cmp #$0100
		beq +
		sta $13f2 
	+	cld
		clc 
	hitBoxCheckYposCrossCatchEnd:
		rtl 
	
	newStarterLevel:
		lda $1e02
		bne +
;	if !levelSelect == 0	
		lda #$0005
		sta $86
		lda #$0000			; reset on first level start 
		sta !armorType
		sta !ownedWhipTypes
		sta !allSubweapon
		sta !killedHusband
		sta !dogLeash
;	endif
	+	rtl
	newTable:
		lda #$0001
;		sta $12,x
		rtl

	checkType2Multiples:
		phy 
		ldy #$0540
		
	-	tya
		clc 
		adc #$0040
		cmp #$0f00
		beq ++
		tay 
		lda $30,x 				; check ID
		cmp $0030,y 
		bne -
		txa 					; check if not orginal event 
		sta $00
		cpy $00 
		beq -
		
		ply 
		jml clearSelectedEventSlotAll		; terminate multispawn 
	++	ply 
		rtl 

	newChandelire:
		phx 					; make it always appear and get wired extra spawns 
		lda $30,x   
		tax 
		stz $1500,x
		plx 
		
		jsl checkType2Multiples
		
		lda $542				; Sprite Priority same as Simon 
		sta $02,x 		
		
		LDA.W #$A7BC
		sta $00,x
		lda $06,x
		cmp #$0100
		beq +
		inc $12,x			; make a health check so it falls only when hit
	+	dec $12,x
		rtl
}


{ ; ---------------------------- new event 4b camera ------------------
	newEventID4b:				
		LDA.B $14,X                                                                    
		PHX                                 
        ASL A                               
        TAX                                 
        LDA.L newEventJumpTable,X    
        PLX                                 
        STA.B $00                   
        JMP.W ($00)                 
	newEventJumpTable: 
		dw cameraLockDown00,cameraLockDown01,cameraLockDown02,leverBGScroll3,leverBGScroll4,levelBGWrap5,realCurse6
		dw eventSpawnBossAtXpos,puwexOrb08,lvl9HurbSecret09,stage6Elevator0a,stage7Liberary0b,stage1Pipe0c,zapfBatCam_0d
		dw wirllWind_0e,screenMover_0f,wizzardBoss_10,simonNoTopBorderClip_11

	eventKeepUpWithSimon:
		lda $54e			; keep up with simon
		sta $0e,x
		lda $54a
		sta $0a,x
		rtl 
		
	cameraLockDown00:	
		jsl eventKeepUpWithSimon
		
		lda $54e			
		cmp #$02b0			;last Drop
		bpl +++
		cmp #$01a0			; check 3th drop
		bpl ++
		cmp #$00d5			; check 1th drop
		bmi endCamLockMoveDown
		lda $a4
		clc 
		adc #$0008		
		cmp #$00d0
		bpl +
		sta $a4
		sta $a6
	+	lda $54a			; check 2th drop 
		cmp #$e80
		bmi endCamLockMoveDown
		lda $a4
		clc 
		adc #$0008
		cmp #$0130
		bpl endCamLockMoveDown
		sta $a4
		sta $a6 
		lda #$0e80			; revile out-cove
		sta $a2
		rtl

	++  lda $a4
		clc 
		adc #$0008
		cmp #$01a0
		bpl +
		sta $a4
		sta $a6
		lda #$0e00			; revile out-cove
		sta $a2
	+	lda $54a			; check 4h drop 
		cmp #$0d70
		bpl endCamLockMoveDown
		lda $a4
		clc 
		adc #$0008
		cmp #$0220
		bpl endCamLockMoveDown
		sta $a4
		sta $a6 
		rtl				
	+++	; lda $a6						; the slow movement seem not to fix anything anyway.. 
		; clc 
		; adc #$0008
		; cmp #$0328
		; bpl endCamLockMoveDown
		lda #$0320						
		sta $a6 
		lda #$0BE0
		sta $a0
		jsl clearSelectedEventSlotAll	; clear on bothom so we have no issue climbing again 
		
		rtl
	endCamLockMoveDown:
		rtl
		
	cameraLockDown01:			; level $13
		jsl eventKeepUpWithSimon
		jsl elevatorBodleyMension
		
		lda $54e			
;		cmp #$00a0			;
;		bpl +
;		lda #$0000
;		sta $a4
;		rtl
		
	+	cmp #$250			;
		bpl ++
		lda $54a
		cmp #$00a0
		bpl +
		lda #$0000
		sta $a4
	+	rtl

	++	cmp #$330			;
		bpl ++
		lda $54a
		cmp #$0078
		bpl +
		lda #$200
		sta $a4
	+	rtl
		
;	+	cmp #$03f0			; 
;		bpl ++
;		lda #$2f0 
;		sta $a4
;	+	rtl
		
	++	lda $54e
		cmp #$550			;
		bpl +
		lda $54a
		cmp #$00a0
		bpl +
;		lda #$3a0
		lda #$2c0 
		sta $a4
	+	rtl 

	cameraLockDown02:
		jsl eventKeepUpWithSimon
		
		lda $54e
		cmp #$00a4	; 70 
		bpl +
		lda #$0100
		sta $a2
		bra ++ 		; reached the top  		
		
	+	lda $54e
		cmp #$2e0
		bpl +
		lda $54a
		cmp #$0a0
		bpl ++
		stz $a4 
		stz $a2 
;		inc $1298			; force redraw tilemap update 
		bra ++
		
	+	lda $54e
		cmp #$456			; second last 
		bpl +

		lda #$3b0
		sta $a6 
		lda #$28f
		sta $a4
		bra ++
		
		
	+	lda $54e
		cmp #$570			; last (bottom)
		bpl ++
		lda $54a
		cmp #$0080
		bpl ++
		lda #$0400 
		sta $a4
			
	++	rtl 


	elevatorBodleyMension:
		lda RAM_X_event_slot_state,x 
		beq +
		
		lda #$0012
		sta RAM_simonSlot_State
		stz.w RAM_simonSlot
		
		lda RAM_simonSlot_Ypos
		sec
		sbc #$0002
		sta RAM_simonSlot_Ypos
		cmp #$02a5
		bcs endElevatorBodly
		
		stz.b RAM_X_event_slot_state,x 	; terminate elevate 
		stz.w RAM_simonStat_stopWatchTimer		
		lda #$0004
		sta RAM_simonSlot_State
		lda.l !backUpButtonMapWhip
		sta RAM_buttonMapWhip
		
	+	lda RAM_simon_multiShot			; elevator card check 
		and #$0001
		beq endElevatorBodly
	
		lda RAM_buttonPressCurFram		; up button check 
		bit #$0800
		beq endElevatorBodly

		lda RAM_simonSlot_Ypos		; init elevator ride 
		cmp #$0565
		bne endElevatorBodly
		lda RAM_simonSlot_Xpos
		cmp #$0018
		bcs endElevatorBodly
		
		lda RAM_simon_multiShot		; elevator card remove 
		eor #$0001
		sta RAM_simon_multiShot
		
		lda #$0250
		sta RAM_simonStat_stopWatchTimer
		sta RAM_X_event_slot_state,x 
		stz.w RAM_buttonMapWhip
	endElevatorBodly:	
		rtl 

		
	leverBGScroll4:
		lda #$4000
		sta $04,x 
	leverBGScroll3:
		lda $00,x 
		bne +
		
		lda #$01e0
		sta $26,x				; assigne last slot for sprite 
		lda #newLeverSpriteAssembly01 ; #$96b5 sprite assembly #$96c7
		sta $00,x 
        lda #$0042     		; can be hit does not hurt                     
		sta $2e,x 
		lda #$0200				; health
		sta $06,x
		lda #$0010				; sometimes the hitbox is wired otherwise. VanillaBUG!? 
		sta $2a,x 
		lda #$0016
		sta $28,x 

	+	lda $06,x
		cmp #$0200				; check if hit 
		beq ++
		lda !layer2ScrollBehavier
		bne +	
		jml initiateBGScroll
	
	+	cmp #$3000			; check if scroll has finished
		bne ++
		lda #$0200			; reset 	
		sta $06,x 
		lda #newLeverSpriteAssembly01
		sta $00,x 	
	
	++	rtl 

	levelBGWrap5:
		lda $12,x 
		bne +
		lda #$0001 
		sta RAM_FlagAllowOutOfBounce 
		sta $12,x 
		
	+	jsl eventKeepUpWithSimon
		
;		jsl betterScreenWrap
		lda $54e
		and #$00ff
		sta $54e 
		rtl 

;	betterScreenWrap:
;		LDA.W $12D8                          ;86A805|ADD812  |0012D8;  
;		AND.W #$00FF                         ;86A808|29FF01  |      ;  
;		STA.W $12D8                          ;86A80B|8DD812  |0012D8;  
;		LDA.W $12E2                          ;86A80E|ADE212  |0012E2;  
;		AND.W #$00FF                         ;86A811|29FF01  |      ;  
;		STA.W $12E2                          ;86A814|8DE212  |0012E2;  
;
;	;	LDX.W #$12C0                         ;86A817|A2C012  |      ;  	bg verticle screen scroll
;	;	LDY.W #$A000                         ;86A81A|A000A0  |      ;  
;	;	LDA.W #$1000                         ;86A81D|A90010  |      ;  
;	;	JSL.L CODE_86A8BB                    ;86A820|22BBA886|86A8BB;  
;
;	;	LDA.W $1298                          ;86A824|AD9812  |001298;  bg verticle wrapping ??
;	;	AND.W #$03FF                         ;86A827|29FF03  |      ;  
;	;	STA.W $1298                          ;86A82A|8D9812  |001298;  
;	;	LDA.W $12A2                          ;86A82D|ADA212  |0012A2;  
;	;	AND.W #$03FF                         ;86A830|29FF03  |      ;  
;	;	STA.W $12A2                          ;86A833|8DA212  |0012A2;  
;		LDA.W $12D8                          ;86A836|ADD812  |0012D8;  
;		AND.W #$00FF                         ;86A839|29FF01  |      ;  
;		STA.W $12D8                          ;86A83C|8DD812  |0012D8;  
;		LDA.W $12E2                          ;86A83F|ADE212  |0012E2;  
;		AND.W #$00FF                         ;86A842|29FF01  |      ;  
;		STA.W $12E2                          ;86A845|8DE212  |0012E2;  
;		LDA.W RAM_simonSlot_Ypos             ;86A848|AD4E05  |00054E;  
;		AND.W #$00FF                         ;86A84B|29FF03  |      ;  
;		STA.W RAM_simonSlot_Ypos 
;		rtl 

	realCurse6:
		jsl eventKeepUpWithSimon
		lda RAM_simon_DamageDeBuff
		cmp #$0100
		bne +
		
		inc.w $20,x 
		lda $20,x 		
		cmp #$0050
		bne +
		
		lda RAM_simonStat_Health_HUD
		sta.w $20,x 				; also use as value to have shorter timer at the beginning
		sec
		sbc #$0001
		sta RAM_simonStat_Health_HUD
		bpl +
		stz.w RAM_simonStat_Health_HUD	
		lda #$000c
		sec 
		sbc RAM_simonSlot_State
		bmi +
		lda #$000d
		sta RAM_simonSlot_State
	+	rtl 


	initiateBGScroll:
		lda #$0020
		sta !bafferRam 
		
		lda #newLeverSpriteAssembly00  ; #$96be, #$96c7
		sta $00,x 
		lda #$1000					
		ora $20,x						; set timer to go up here (mask value from hijacking 4b)(first value Flag the last 3 are timer)  
		sta !layer2ScrollBehavier 
		lda #$002e						; sound effect
		jsl $8085E3
		rtl 


	runBGScreenScrollGlobal:		; this is always active
		lda !layer2ScrollBehavier
		and #$f000
		cmp #$3000
		bne +
		stz !layer2ScrollBehavier		; terminate scrolling 
		rtl 
	+	cmp #$2000
		beq resetScroll2StartingPossition	; retract branch to reseting the scroll
		jsl bgScrollwhileActive
		lda !layer2ScrollBehavier
		sec 
		sbc #$0001		
		sta !layer2ScrollBehavier
		cmp #$1000			; timer for the scroll 
		bne +
		lda #$2090			; set timer to go down here
		sta !layer2ScrollBehavier
	+	rtl 
		


	bgScrollwhileActive:		
		lda !bafferRam 
		beq +
		sec 
		sbc #$0001
		sta !bafferRam
		jsl bgScreenShake
		bra ++
		
	+	lda $12d8
		clc
		adc #$0001
		cmp #$0050			; yPos screen
		bcs ++
		sta $12d8 
	++	rtl 
	
	resetScroll2StartingPossition:
		lda $12d8		; skip when reset
		bne +
		lda #$3000		; one frame should be enough so the event does know to reset too
		sta !layer2ScrollBehavier
		bra ++
	+	sec								; scroll down 
		sbc #$0001
		sta $12d8
	++	rtl
	
	bgScreenShake:
		lda $3a
		and #$0004
		bne +
		dec $12d8
		rtl 

	+	inc $12d8
		rtl 
	
	eventSpawnBossAtXpos:
		jsl eventKeepUpWithSimon
		lda RAM_simonSlot_Xpos
		cmp #$0240
		bmi +
		lda #$002a
		sta $10,x 
		lda #$0009
		sta $14,x 

;		sta $9a		; use direction left right on top .. this does not work!! No idea how to FIX!! Would be great though..
						; also events load in a uniq direcion and will not be delete.. really the event loader needs rework! 
	+	lda $54e
;		cmp #$2c0
		cmp #$330
		bpl +
		lda $54a
		cmp #$0128
		bpl +
		lda #$0000
		sta $a4
	+	rtl 

	puwexOrb08:		
		LDA.B RAM_X_event_slot_state,X     ; new state   
		PHX                                  
        ASL A                                
        TAX                                  
        LDA.L puwexORBSateTAble,X        
        PLX                                  
        STA.B $00  
        JMP.W ($00) 


	puwexORBSateTAble:
		dw puwexOrb08State00,puwexOrb08State01,puwexOrb08State02,puwexOrb08State03,puwexOrb08State04,puwexOrb08State05


	puwexOrb08State00:	
		jsl eventKeepUpWithSimon
		lda $54e
		cmp #$0180
		bcc +
		inc.b RAM_X_event_slot_state,x 
		lda #$00f0
		sta RAM_X_event_slot_yPos,x 
		lda #$0080
		sta RAM_X_event_slot_xPos,x 
		lda #$8000
		sta RAM_X_event_slot_HitboxID,x 		; make it not despawn even when it goes off screen a lot 

	+	rtl 
	
	
	puwexOrb08State01:
		lda #$81a4
		sta $00,x 
		
		inc.b RAM_X_event_slot_yPos,x 
		
		lda RAM_X_event_slot_yPos,x 
		cmp #$0160
		bne +
		jsl removeSubweapon
		stz.b $22,x 
		inc.b RAM_X_event_slot_state,x 
	-
	+	rtl 
	removeSubweapon:
		lda RAM_simon_subWeapon
		beq -

	removeItem:
		phx 		
		jsl getEmptyEventSlot
		txy 
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
		
		lda #$0000
		sta RAM_X_event_slot_HitboxID,x 
		lda #$0003
		sta RAM_X_event_slot_Movement2c,x 
		sta RAM_X_event_slot_HitboxXpos,x
		sta RAM_X_event_slot_HitboxYpos,x
		
		lda #$fffc						; push it up  a bit 
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
		stz.b RAM_simon_subWeapon
		
		rtl 


	puwexOrb08State02:		
		jsl faceSimon
		lda $3a 
		bit #$0003
		beq puwexOrb08State03 
		lda #$81a4
		sta $00,x 
		rtl 
	puwexOrb08State03:
		lda #$0400		; 0006 red 
		ora $04,x 
		sta $04,x 
		LDA.W #$B3C3   
		sta $00,x 
		
		inc.b $22,x 		
		lda $22,x 
		cmp #$0020
		bne +
		inc.b RAM_X_event_slot_state,x
		stz.b $22,x 
		LDA.B RAM_X_event_slot_state,X
		
		cmp #$0003
		bne +		
		lda #$8047							;  init boss 
		sta RAM_X_event_slot_HitboxID,x 	; give hitbox	
		lda #$0003
		sta RAM_X_event_slot_Movement2c,x 	; make it movable x and y 
		lda #$000c
		sta RAM_X_event_slot_HitboxXpos,x 
		lda #$0014
		sta RAM_X_event_slot_HitboxYpos,x 
		lda #$0200							; health 
		sta $06,x 
		sta $20,x 							; compare value to detect hits 
	+	rtl 
	puwexOrb08State04:
        jsl bossGeneralHealthRoutine
		Jsl $80CA9D                    ;80CA52|229DCA80|80CA9D;  
		jsl $80CAAF
		
		jsl faceSimon
		
		lda #$0400		; 0006 black 
		ora $04,x 
		sta $04,x 
		
		lda $06,x 
		cmp $20,x 
		bcs +
		dec
		dec 
		sta $20,x 
		lda #$0600		; 0006 red 
		ora $04,x 
		sta $04,x 
	+	rtl 
	
	bossGeneralHealthRoutine:
		lda $06,x 
		cmp #$0031
		bcc +
		lsr
		lsr
		lsr
		lsr
		lsr 
		sta RAM_boss_Health_HUD
		rtl 
	+	stz.w RAM_boss_Health_HUD
		stz.b RAM_X_event_slot_HitboxID,x 	; give hitbox	
		stz.b $22,x 
		stz.b $24,x 
		inc.b RAM_X_event_slot_state,x 
;		stz.b RAM_X_event_slot_Movement2c,x ; make him stop moving 		
		rtl 
	puwexOrb08State05:		
;		LDA.B RAM_X_event_slot_xPos,X   
;        STA.W $00
;        LDA.B RAM_X_event_slot_yPos,X  
;        STA.W $02
;		stx.w RAM_XregSlotCurrent 
;		JSL.L $80CF86		; Check Floor To stop falling readCollusionTable7e4000       ;80D27C|2286CF80|80CF86;  
;        beq +                      
;		dec.b RAM_X_event_slot_yPos,x 
;		dec.b RAM_X_event_slot_yPos,x 
;	+	ldx.w RAM_XregSlotCurrent	
		lda RAM_X_event_slot_yPos,x 
		clc
		adc #$0001
		cmp #$01e0 
		bcs +
		sta RAM_X_event_slot_yPos,x  
	+	Jsl $80CA9D     	; X movment              ;80CA52|229DCA80|80CA9D;  
		
		lda #$0220							; set bottom screen lock 
		sta.w $a6 
		
		lda $3a					; sprite blink animation 
		bit #$0008
		bne +
		stz.w $04,x 
		lda #$81a4
		bra ++ 	
	+	lda #$0400	
		sta $04,x 
		lda #$B3C3
	++	sta.b $00,x 

		lda $24,x 
		cmp #$0006
		beq ++
		
		inc.w $22,x 
		lda $22,x 
		cmp #$0018
		bne +
		
		inc.b $24,x 
		stz.b $22,x 
		lda #$0088
		jsl lunchSFXfromAccum 
	+	rtl 
	++ 	phx 
		lda $0a,x 
		pha 
		lda $0e,x 
		pha 
		jsl getEmptyEventSlot
		
		lda #$0027
		sta $10,x 

		pla
		sta $0e,x 
		pla
		sta $0a,x 
		
		lda #$0089
		sta RAM_X_event_slot_HitboxID,x 
		lda #$0003
		sta RAM_X_event_slot_Movement2c,x 
		sta RAM_X_event_slot_HitboxXpos,x
		sta RAM_X_event_slot_HitboxYpos,x
		plx
		jml clearSelectedEventSlotAll

	lvl9HurbSecret09:
		LDA.B RAM_X_event_slot_state,X     ; new state   
		PHX                                  
        ASL A                                
        TAX                                  
        LDA.L dogHurbRoutineTable,X        
        PLX                                  
        STA.B $00  
        JMP.W ($00) 


	dogHurbRoutineTable:
		dw dogHurbRoutineTable00,dogHurbRoutineTable01,dogHurbTransformFace02
		
	dogHurbRoutineTable00:
		lda #$0080
		sta RAM_X_event_slot_HitboxID,x 
		lda RAM_simonSlot_Ypos
		cmp #$0008
		bcs +
		lda #$0008				; make simon not wrap to bottom since cameral lock event.. 
		sta RAM_simonSlot_Ypos
	+	jsl carrySetOnSimonEventCollusion
		bcc +
		
		jsl elevatorCardPassCheck
		bcs +
		
		lda #$0250
		sta RAM_simonStat_stopWatchTimer
		sta RAM_simon_invulnerable_counter
		stz.w RAM_buttonMapWhip				; enable whiping 	
		
		lda #$0001
		sta $12,x 
	+	rtl 

	elevatorCardPassCheck:
		lda RAM_buttonPressCurFram		; up button check 
		bit #$0800
		beq +		
	
	elevatorCardPassCheckNoInput:	
		lda RAM_simon_multiShot			; elevator card check 
		and #$0001
		beq +		

		lda RAM_simon_multiShot		; elevator card remove 
		and #$0002
		sta RAM_simon_multiShot
		clc
		bra ++
		
	+	sec 
	++	rtl

	dogHurbRoutineTable01:			
		lda $3a							; mystic glitching 
		sta RAM_mosaicEffect_Value_BG
		lda #$0008
		sta $44
;		and #$000f
;		sta RAM_blackFade
		
		lda #$0012						; simon elevator state 
		sta RAM_simonSlot_State
		stz.w RAM_simonSlot
		
		lda #$8af4						; skelly sprite
		sta $00,x 
		
		ldy #$0400						; blink skelly 
		lda $3a 
		bit #$0004
		beq +
			
		ldy #$0e00
	+	tya 
		sta $04,x 
		
		lda #$0180
		sta $26,x 
		
		lda #$0818
		sta $0a,x 
		lda #$0038
		sta $0e,x 		
		
		lda RAM_simonSlot_Xpos
		clc
		adc #$0002
		sta RAM_simonSlot_Xpos
		cmp #$0800
		bcc endElevatorHurb
		
		lda.l !backUpButtonMapWhip	
		sta RAM_buttonMapWhip				; enable whiping 	
		lda #$0002						; end elevator face NPC Init face 
		sta RAM_X_event_slot_state,x 	; terminate elevate 
		stz.w RAM_simonStat_stopWatchTimer
		stz.w RAM_simon_invulnerable_counter		
		stz.w RAM_mosaicEffect_Value_BG
;		stz.w RAM_blackFade
		lda #$0004
		sta RAM_simonSlot_State			; replace event with NPC 
		
		lda #$000d						
		sta $10,x 
		lda #$001e
		sta $14,x 		
		clc 
		adc #$0002
		sta $12,x 
	endElevatorHurb:			
		rtl 
		
	dogHurbTransformFace02:				; clock $1e sub id  	
		rtl 

	stage6Elevator0a:
		lda $12,x 
		bne engageStage6Elevator
		
		lda #$0080						; make it occopie a slot for this stage and not despawn 
		sta RAM_X_event_slot_HitboxID,x 
		jsl carrySetOnSimonEventCollusion
		bcc +
		jsl elevatorCardPassCheck
		bcs +
		
		lda #$0250
		sta RAM_simon_invulnerable_counter
		sta RAM_simonStat_stopWatchTimer
		lda #$8000
		sta RAM_simonSlot_spritePriority
		lda #$0001
		sta $12,x 
		
	+	rtl 
	engageStage6Elevator:
;		lda #$03b0
;		sta $a6 						; set border for less glitches of bg update missing a line 
		
		lda #$9fd1
		sta RAM_simonSlot
		lda #$0024
		sta RAM_simonSlot_AnimationCounter
		
		stz.w RAM_buttonMapWhip				; disable whiping 
		
		lda #$0012
		sta RAM_simonSlot_State
		
		lda RAM_simonSlot_Xpos		; move left first then up 
		sec
		sbc #$0002							
		sta RAM_simonSlot_Xpos	
		cmp #$0040
		bcs +
		
		lda #$0040
		sta RAM_simonSlot_Xpos
		
		lda RAM_simonSlot_Ypos
		sec
		sbc #$0003
		sta RAM_simonSlot_Ypos
		cmp #$0330	
		bcs +
		
		jsl leaveElevatorState
;		lda #$0000
;		sta $12,x					; end elevator ride  
;		sta RAM_simonSlot_spritePriority
;		sta RAM_simon_invulnerable_counter
;		sta RAM_simonStat_stopWatchTimer
;		lda #$0004
;		sta RAM_simonSlot_State 
;
;		lda.l !backUpButtonMapWhip	
;		sta RAM_buttonMapWhip				; enable whiping 	
		
	+	rtl 


	stage7Liberary0b:
		lda $12,x 
		bne engageLiberaryElevator
		
		lda #$0080						; make it occopie a slot for this stage and not despawn 
		sta RAM_X_event_slot_HitboxID,x 
		jsl carrySetOnSimonEventCollusion
		bcc +
		jsl elevatorCardPassCheck
		bcs +

		lda #$0250
		sta RAM_simon_invulnerable_counter
		sta RAM_simonStat_stopWatchTimer
		lda #$0001
		sta $12,x 
		
		stz.w RAM_buttonMapWhip
		lda #$0012
		sta RAM_simonSlot_State
		lda #$0037
		jsl lunchSFXfromAccum
		
	+	rtl 
	engageLiberaryElevator:
		lda #$9bb9
		sta RAM_simonSlot
		lda #$8000		
		sta RAM_simonSlot_spriteAttributeFlipMirror
		lda $3a
		and #$000f

		sta RAM_simonSlot_AnimationCounter
		adc #$0020
		sta RAM_simonSlot_Ypos
		
		lda RAM_simonSlot_Xpos		; move left first then up 
		clc
		adc #$0003							
		sta RAM_simonSlot_Xpos	
		cmp #$07d0
		bcc +
		
		jsl leaveElevatorState
		
	+	rtl 

	stage1Pipe0c:
		lda $12,x 
		bne pipeTransition
		
		lda #$818b
		sta $00,x 
		lda #$8018
		sta $02,x 
		
		lda RAM_simonSlot_Ypos
		cmp #$0060
		bcc +

		jsl carrySetOnSimonXposEventCollusion
		bcc +
		lda RAM_buttonPressCurFram
		bit #$0400
		beq +
		jsl elevatorCardPassCheckNoInput		
		bcs +

		
		lda #$0001
		sta $12,x					; inite pipe  ride  
		lda #$0300
		sta RAM_simon_invulnerable_counter
		sta RAM_simonStat_stopWatchTimer
		stz.w RAM_buttonMapWhip
		stz.b $00,x 
		lda #$0072
		jsl lunchSFXfromAccum
		
	+	rtl 
	pipeTransition:
		lda #$0080
		sta RAM_X_event_slot_HitboxID,x 		; make it not despawn 
		
		lda $12,x
		cmp #$0002
		beq pipeMario
		
		lda #$9bb9
		sta RAM_simonSlot
		stz.w RAM_simonSlot_spritePriority
		
		lda #$0012			; move down the pipe 
		sta RAM_simonSlot_State 
		inc.w RAM_simonSlot_Ypos
		lda RAM_simonSlot_Ypos
		cmp #$00c0
		bcc +
		
		lda #$0950			; make the the event look like luigi on to of pipe 
		sta RAM_X_event_slot_xPos,x 
		lda #$0078
		sta RAM_X_event_slot_yPos,x 
		lda #$00a0
		sta RAM_X_event_slot_SpriteAdr,x 
		lda #luigiSpriteAssembly
		sta $00,x 
		stz.b $02,x 
			
		lda #$00e0 
		sta RAM_simonSlot_Ypos
		
		lda #$0000			; move right
		sta RAM_simonSlot	
		lda RAM_simonSlot_Xpos
		clc
		adc #$0003
		sta RAM_simonSlot_Xpos		
		cmp #$0950
		bcc +
		
		lda #$0072
		jsl lunchSFXfromAccum
		
		lda #$0002
		sta $12,x 
	+	rtl 
	pipeMario:					; luigi appear ince palette.. 						
		inc.b RAM_X_event_slot_yPos,x 
		
		lda #$9bb9				; simon get out of the pipe 
		sta RAM_simonSlot		
		dec.w RAM_simonSlot_Ypos
		lda RAM_simonSlot_Ypos
		cmp #$0077
		bcs +
		
		lda #$0004				; exit pipe 
		sta RAM_simonSlot_State
		lda.l !backUpButtonMapWhip	
		sta RAM_buttonMapWhip	 
		lda #$8018
		sta RAM_simonSlot_spritePriority
		jml clearSelectedEventSlotAll		; clear event 
	+	rtl 
	
	leaveElevatorState:
		lda #$0000
		sta $12,x					; end elevator ride  
		sta RAM_simonSlot_spritePriority
		sta RAM_simon_invulnerable_counter
		sta RAM_simonStat_stopWatchTimer
		lda #$0004
		sta RAM_simonSlot_State 

		lda.l !backUpButtonMapWhip	
		sta RAM_buttonMapWhip				; enable whiping 	

		rtl 

	carrySetOnSimonEventCollusion:
        lda RAM_81_simonSlot_Ypos
		sec
		sbc #$0010
		cmp RAM_X_event_slot_yPos,x                        
        bcs +
		
		clc 
		adc #$0020
		cmp RAM_X_event_slot_yPos,x 
		bcc + 		
	
	carrySetOnSimonXposEventCollusion:		
		lda RAM_81_simonSlot_Xpos          
        sec
		sbc #$0008
		cmp RAM_X_event_slot_xPos,x                        
        bcs +                      
        
		clc
		adc #$0010
		cmp RAM_X_event_slot_xPos,x                        
        bcc +             
		
		
		

		sec
		rtl 
	+	clc 
		rtl 
		
	zapfBatCam_0d:
		jsl paletteAnimZapfBG
		jsl eventKeepUpWithSimon
		lda RAM_simonSlot_Xpos
		cmp #$0240
		bmi +
		cmp #$0328
		bpl +
		lda RAM_simonSlot_Ypos
		cmp #$00c0
		bpl +

		lda #$0200		; cam fix 
		sta $a0 
		sta $a2 
		stz.b $a6	
		
		inc $20,x 		; delay for the cam to catch up else events will respawn after boss clear routine 
		lda $20,x 
		cmp #$0040
		bmi +
		
		jsl clearSelectedEventSlotAll	; spawn zapf 
		lda #$002a
		sta $10,x 
		lda #$0005
		sta $14,x 
		lda RAM_simonSlot_Xpos
		sta $0a,x 		

	+	rtl 

	paletteAnimZapfBG:				; 22 timer 24 palette offset 26 switch to reverse anim 
		lda $22,x 
		beq +
		dec.b $22,x				
		bra +++
	+	lda #$0008					; timer for palette change 10 frames  
		sta $22,x 
		
		lda $26,x
		cmp #$0030
		bne accendAnimZapfBG
	
	decendAnimZapfBG:	
		lda $24,x					; decend anim 
		sec
		sbc #$0010
		bpl +
		lda #$0000					; reset palette anim 
		sta $26,x 
	+	sta $24,x 
		bra ++
	
	accendAnimZapfBG:
		lda $24,x 					; acend anim 
		clc
		adc #$0010
		cmp #$0040					; max set of palette
		bne +
		lda #$0030					; reset palette anim 
		sta $26,x 
	+	sta $24,x 
		
	++	phb
		phx
		phy 
		sep #$20
		lda #$86	
		pha
		plb
		rep #$20
		
		lda #$ff00			;	paletteGetDark ; 16 bytes 2 7e228c 86ff00 ; 4 sets 
		clc 
		adc $24,x 
		sta $00
	
		ldx #$0010
		txy
	-	lda ($00),y  
		sta.l $7e228c,x
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
		
	+++	rtl 

pushPC
	org $86ff00			; dark palette 
		db $00, $00, $00, $00, $B1, $76, $24, $00, $22, $00, $20, $00, $00, $00, $00, $00
		db $00, $00, $00, $00, $B2, $66, $23, $00, $22, $00, $20, $00, $00, $00, $00, $00
		db $00, $00, $00, $00, $ED, $49, $22, $00, $21, $00, $21, $00, $00, $00, $00, $00
		db $00, $00, $00, $00, $AC, $41, $21, $00, $20, $00, $20, $00, $00, $00, $00, $00	
pullPC 
		
	wirllWind_0e:
		lda $20,x 
		beq ++
		dec.b $20,x 
		lda $3a
		bit #$0004
		beq +
		stz.w RAM_simonSlot_spriteAttributeFlipMirror
		bra ++
	+	lda #$4000
		sta RAM_simonSlot_spriteAttributeFlipMirror
		
	++	jsl carrySetOnSimonEventCollusion
		bcc +
		lda RAM_buttonPress
		bit #$0400
		beq +
		lda #$fff5		; f3ff
		sta RAM_simonSlot_SpeedYpos
		lda #$0020
		sta $20,x 
		lda RAM_simonSlot_Ypos
		sec
		sbc #$0008
		sta RAM_simonSlot_Ypos
	+	rtl 
	
	screenMover_0f:

		lda #$0080
		sta RAM_X_event_slot_HitboxID,x 
		phb
		sep #$30
		lda #$a0
		pha
		plb
		rep #$30 
		jsl loadPalettePracticeRing
		plb
				; 7e8000 block map WRAM $80 bytes are one screen
		rtl 	; move screen 7 3
		
	wizzardBoss_10:		
		LDA.B RAM_X_event_slot_state,X     ; new state   
		PHX                                  
        ASL A                                
        TAX                                  
        LDA.L wizzarBossTable,X        
        PLX                                  
        STA.B $00  
        JMP.W ($00) 

	wizzarBossTable:
		dw wizzardTransform00,wizzardTransform01,wizzardTransform02,wizzardTransform03,wizzardTransform04,wizzardTransform05
	
	wizzardTransform00:	
		lda $3a
		and #$0004
		beq +
		lda #oldManFr2
	+	sta $00,x 
		jsl faceSimon
		
		inc $20,x 
		lda $20,x 
		cmp #$0030
		bne +
		inc.b $12,x 
		stz.b $20,x 	
		
	+	rtl 

	wizzardTransform01:		
		stz.b RAM_X_event_slot_SpriteAdr,x 
		dec.b RAM_X_event_slot_yPos,x 		
		lda #$004c
		cmp RAM_X_event_slot_yPos,x 
		bcc +
		sta RAM_X_event_slot_yPos,x 
		inc.b $12,x 
		jsr paletteLoadDragon
	+	dec.b RAM_X_event_slot_xPos,x
		lda #$0014
		cmp RAM_X_event_slot_xPos,x		
		bcc +
		sta RAM_X_event_slot_xPos,x
	+	jmp orbSpriteAnim

	wizzardTransform02:		; orb moves into hole hdma would be cool 
		stz.b $00,x 
		
		lda $20,x 
		bne ++

	++	lda RAM_simonSlot_Xpos
		cmp #$0120
		bcc +
		
		lda #$00c8
		sta RAM_X_event_slot_xPos,x 
		lda #$000c
		sta RAM_X_event_slot_yPos,x
		inc.b $12,x 
		
	+	rtl 
	wizzardTransform03:				; orb moves over bridge 		
		jsr bridgDragonHealthHudRoutine
		
		lda #$0003
		sta RAM_X_event_slot_Movement2c,x 
		
		inc.b RAM_X_event_slot_xPos,x 
		inc.b RAM_X_event_slot_xPos,x 
;		lda #$0580
		lda #$3d0
		cmp RAM_X_event_slot_xPos,x 
		bcs orbSpriteAnimWithMovment
	
		jsr orbSpawnRing
		bcs orbSpriteAnimWithMovment	
		
		stz.b $00,x 
		
		lda RAM_simonSlot_Xpos
		cmp #$0490
		bcc +
		
		inc.b $12,x 
;		stz.b $20,x 			; clear pointer for next ring spawn make it a permanent event 
		
	+	jml $86C5DD			; bat movment routine move ment at boss screen 
		
	orbSpriteAnimWithMovment:
		lda #$0040
		sta RAM_X_event_slot_mask,X
		jsl $86C5DD			; bat movment routine 
	
	orbSpriteAnim:
		lda $3a
		bit #$0004
		beq +
		lda #$819F
		jmp ++
	+	lda #$81a4 
	++	sta $00,x 		
		rtl 
	
	orbSpawnRing:
		sta RAM_X_event_slot_xPos,x 
		phx 
		lda $20,x 					; get a other slot and put a ring witout sprite. Then make it move with the orb 
		bne +
	
		jsl getEmptyEventSlot		
		bcs ++
		txa
		
		plx 						
		sta $20,x 
		tay 
		
		lda #$0003					; ring propertys 		
		sta.w $10,y
		lda #$0085
		sta.w $14,y 
		lda RAM_81_simonSlot_spritePriority
		sta.w $04,y 
		lda #$00e0		
		sta.w RAM_X_event_slot_SpriteAdr,y 
		lda #$0200			; palette fix 
		sta.w $04,y  
		
		phx  

	+	tay 
		lda.B RAM_X_event_slot_yPos,X 			; update ring pos with orb pos 
		sta.w RAM_X_event_slot_yPos,y
		lda.B RAM_X_event_slot_xPos,X 
		sta.w RAM_X_event_slot_xPos,y

		plx 
		clc 
		rts 
	
	++	plx 									; in case the whole table is occopied 
		sec
		rts 
	
	wizzardTransform04:
		jsr bridgDragonHealthHudRoutine
;		lda #$05e0
;		sta.b $a2 
		inc.b RAM_X_event_slot_xPos,x 
		inc.b RAM_X_event_slot_xPos,x 
		lda #$0600
		cmp RAM_X_event_slot_xPos,x 
		bcs orbSpriteAnimWithMovment
		
	+	jsr orbSpawnRing
		bcs orbSpriteAnimWithMovment
		stz.b $00,x 
		jml $86C5DD

	wizzardTransform05:
;		lda #$0700				; finall cam lock done with boss
;		sta $a2 
		
		inc.b RAM_X_event_slot_xPos,x 
		inc.b RAM_X_event_slot_xPos,x 
		jmp orbSpriteAnimWithMovment
	
	bridgDragonHealthHudRoutine:
		lda !bridgDragonHealthHud
		beq +
		and #$0fff
		lsr
		lsr
		lsr
		lsr
		lsr
		lsr 
		inc
		sta RAM_boss_Health_HUD					; make it always show one health at last 
		stz.w !bridgDragonHealthHud			; clear after update to calculate it new every frame 
	+	rts 

	paletteLoadDragon:
		phx 
		ldx #$001e
	-	lda.l $86ffc0,x 
		sta.l $7e23c0,x 
		dex
		dex
		bpl -
		plx 
		rts

	simonNoTopBorderClip_11:
		lda #$0080
		sta RAM_X_event_slot_HitboxID,x  
		lda RAM_simonSlot_Ypos
		cmp #$0020
		bcs +
		lda #$0020			; make simon not wrap to bottom since cameral lock event.. 
		sta RAM_simonSlot_Ypos
	+	rtl 	
}

	
{ ; ---------------------------- New Platform 40 ----------------------	

	event_ID_40_unusedTurningPlatform: 
		LDA.B RAM_X_event_slot_state,X       ;828A87|B512    |000012;  
        PHX                                  
        ASL A                                
        TAX                                  
        LDA.L unusedTurningPlatformStateTable,X 
        PLX                                   
        STA.B RAM_X_event_slot_sprite_assembly
        JMP.W (RAM_X_event_slot_sprite_assembly)
                                                    
                                                    
	unusedTurningPlatformStateTable: 
		dw turningPlaformState00      
		dw turningPlaformState01      
		dw turningPlaformState02      
		dw turningPlaformState03      

	turningPlaformState00:	
		lda #$001c
		sta $2a,x
		lda #$0010
		sta $28,x 
		
		lda #$003b
;		lda $10,x 
		sta $1a 
		phx 
		jsl calculateSpriteSlotOffset_ID_atRam1a 		; get sprite slot uses x and y 		
		plx 
		jml $828ABF
		
	turningPlaformState01:
		jsl checkSimonCollusionEvent
		bcc ++
		inc $22,x 
		lda $22,x 
		cmp #$0028
		bne +
		lda #$002b 
		jsl lunchSFXfromAccum
	+	cmp #$0040
		bne +++
		inc $12,x 
	++	stz.b $22,x 		
	+++	jml $828AEA
    turningPlaformState02:
		lda #$000c
		cmp $24,x 
		bne +
		jsl throwSimonUp
	+	jml $828B3B
    turningPlaformState03:
		lda $20,x 		; wirl animation 
		beq ++
		dec.b $20,x 
		lda $3a
		bit #$0004
		beq +
		stz.w RAM_simonSlot_spriteAttributeFlipMirror
		stz.w $578
		bra ++
	+	lda #$4000
		sta RAM_simonSlot_spriteAttributeFlipMirror
		lda #$0002
		sta $578 
		
	++	jml $828B64

	throwSimonUp:
		lda #$fff7		; f3ff
		sta RAM_simonSlot_SpeedYpos
		lda #$0010
		sta $20,x 
;		lda RAM_simonSlot_Ypos
;		sec
;		sbc #$0008
;		sta RAM_simonSlot_Ypos
		rtl 
; ---------------------------- New 67 ??----------------------------------------		
	eventNewPlatform:			
		rtl 

; ---------------------------- New Platform -----------------------------------------	
		
	-	lda $04,x 
		ora #$0800
		sta $04,x 
		bra ++
	NewFloatingPlatform_ev17:
		lda RAM_currentLevel		; gold platter for gold stage 
		cmp #$002e
		beq -
		cmp #$002f
		beq -
		cmp #$0030
		beq -
		cmp #$0035
		beq -
		cmp #$003d
		beq -
	++	lda $14,x
		bit #$0080					; bit check for new platform behavier
		bne newPlatformJumpTable
		jsl $82C2B0
		rtl

	newPlatformJumpTable:
		lda $14,x 
		and #$000f                                                                  
        PHX                                 
        ASL A                               
        TAX                                 
        LDA.L newServBordType,X    
        PLX                                 
        STA.B $00                   
        JMP.W ($00)
 
+		rtl 

	newServBordType: 
		dw standStill,raftBehavier,raftBehavierBounce,wrapingPlatform_03,risingWhenTouched_04,wrapingPlatform_05,risingWhenTouched_06,risingWhenTouched_07           		
		
; ---------------------------- RAFT 1 -----------------------------------------		
	standStill:
	    LDA.W #$A6EF               		; #$A701, #$A6F8
        STA.B $00,x                   		
		
		jsl $82C312 						; Platform So you can stand on it
		lda $20
		cmp #$8400
		bne +
		stz $0080
	+	rtl
; ---------------------------- RAFT 2 -----------------------------------------		
	raftBehavier:
		jsl initPlatform
	
	raftBehavierState1:
		jsl $82C312 	;Platform So you can stand on it
			
	raftGainSpeed:
		lda $0080
		beq endRaftGainSpeed
		lda #$0400
		clc
		adc $18,x
		sta $18,x 
		lda $1a,x
		adc #$0000
		sta $1a,x
		cmp #$0002
		bne endRaftGainSpeed
		lda #$8000		; max speed 
		sta $18,x
		lda #$0001
		sta $1a,x
	endRaftGainSpeed:		
		jsl stopRaft
		jsl myCollusinRaft		
		rtl 	
; ---------------------------- RAFT 3 -----------------------------------------		
	raftBehavierBounce:
		jsl initPlatform
		lda.w #sheepSpriteAssembly
		sta $00,x 
		
		jsl $82C312 	;Platform So you can stand on it
	raftBounceGainSpeed:
		lda $0080
		beq stopBouncyRaft
		
		jsl gainSpeedLeftAndRight

	endRaftBounceGainSpeed:				
		jsl myCollusinRaftBounce	
		jsl bounceOffWalls
		rtl 
	stopBouncyRaft:	
		jsl stopRaft
		jsl faceSimon
		bra endRaftBounceGainSpeed
	
	myCollusinRaft:
		lda #$1000		;fall speed acceleration
		clc 
		adc $1c,x 
		sta $1c,x 
		bcc +
		inc $1e,x 
	
	+	lda $28,x 		;hitbox Xpos
		sta $08
;		lda $2a,x 		;hitbox Ypos
		lda #$0001
		sta $0a
		jsl $80CE0C		;collusion Check with solid??
		cmp #$0000
		beq +

		lda #$ffff
		sta $1e,x 
		lda #$8000
		sta $1c,x
		
;		stz $1c,x 		
;		stz $1e,x 		
		
	+	jsl frontCollusionUpBounce

		rtl 

	wrapingPlatform_03:
		LDA.W #$A6EF               			; #$A701, #$A6F8
        STA.B $00,x                   
		jsl $82C312 						; Platform So you can stand on it
		
		dec.w RAM_X_event_slot_yPos,x 		
		lda RAM_X_event_slot_yPos,x 
		and #$00ff
		sta RAM_X_event_slot_yPos,x 
		rtl 
			
			
	wrapingPlatform_05:
		LDA.W #$A6EF               			; #$A701, #$A6F8
        STA.B $00,x                   
		jsl $82C312 						; Platform So you can stand on it
		
		inc.w RAM_X_event_slot_yPos,x 		
		lda RAM_X_event_slot_yPos,x 
		and #$00ff
		sta RAM_X_event_slot_yPos,x 
		rtl 			
	
	
	
	
	risingWhenTouched_06:
		lda #$0100
		sta RAM_X_event_slot_SpriteAdr,x 	
		lda #$a6d4
		bra +
	risingWhenTouched_04:					; does not work with multiple platforms since it does not know to to reset till it reached the bottom.. a really smart moving down state might be able to tell.. 
		lda RAM_simonSlot_State
		cmp #$000f							; skip shen simon is dead
		beq risngPlatormMoveDown			; go down when simon is dead it looks better 
		
		LDA.W #$A6EF               			; #$A701, #$A6F8
  +     STA.B $00,x                   		
		lda $80
		sta $22,x 							; check if behavier changed after platrom routine 
		
		jsl $82C312 						; Platform So you can stand on it
		lda $22,x 
		cmp $80
		beq +
		
		lda $80
		sta $12,x 							; use it as state 			

	+	lda $80
		beq risngPlatormMoveDown			; there are a view things that make this stop so we always go down when not set on platform 
		lda RAM_X_event_slot_state,x 
		bne risngPlatormMoveUp
   
   	risngPlatormMoveDown:	
		lda $20,x
		beq ++
		lda $3a
		and #$0001
		beq +
		dec.b $20,x 						; travel to starting pos
		inc.b RAM_X_event_slot_yPos,x 
	+	rtl 
	++	stz.b RAM_X_event_slot_state,x 		; trashold to go down
		rtl 
   
	risngPlatormMoveUp:
		dec.w RAM_X_event_slot_yPos,x 
		inc.w $20,x 						; keep track of distance traveled 
		lda $20,x 
		cmp #$00e0							; max 
		bcc + 
		dec.w $20,x 
		inc.w RAM_X_event_slot_yPos,x 		
	+	rtl 




	risingWhenTouched_07:					; ----------------------------------
		lda #$0100
		sta RAM_X_event_slot_SpriteAdr,x 
		lda RAM_simonSlot_State
		cmp #$000f
		beq LowerPlatformMoveDown			; go down when simon is dead it looks better 
		
		LDA.W #$A6d4               			; #$A701, #$A6F8
        STA.B $00,x                   		
		lda $80
		sta $22,x 							; check if behavier changed after platrom routine 
		
		jsl $82C312 						; Platform So you can stand on it
		lda $22,x 
		cmp $80
		beq +
		
		lda $80
		sta $12,x 							; use it as state 
			

	+	lda $80
		beq LowerPlatformMoveDown			; there are a view things that make this stop so we always go down when not set on platform 
		lda RAM_X_event_slot_state,x 
		bne LowerPlatformMoveBack
   
   	LowerPlatformMoveDown:	
		lda $20,x
		beq ++
		lda $3a
		and #$0001
		beq +
		dec.b $20,x 						; travel to starting pos
		dec.b RAM_X_event_slot_yPos,x 
	+	rtl 
	++	stz.b RAM_X_event_slot_state,x 		; trashold to go down
		rtl  

	LowerPlatformMoveBack:
		inc.w RAM_X_event_slot_yPos,x 
		inc.w $20,x 						; keep track of distance traveled 
		lda $20,x 
		cmp #$0038							; max 
		bcc + 
		dec.w $20,x 
		dec.w RAM_X_event_slot_yPos,x 		
		rtl 
	
	

	newTreasurOpenBehavier:				  ; treasue routine 
		JSL.L lunchSFXfromAccum          ; hijackfix    ;85FB37|22E38580|8085E3;  		
		
		ldy #$0017
		jsl searchForEventIDinY
		bcs +
		lda RAM_simon_ForceGroundBehavier	; skip not on platform 
		beq +		
		lda #$fffd
		sta.w RAM_X_event_slot_ySpd,y 
		lda #$8000
		sta.w RAM_simonSlot_SpeedSubYpos,y 
	+	rtl 

	searchForEventIDinY:	
		sty $00
		phx 
		LDX.W #$0580                   
		clc 
                                         
	-	LDA.B RAM_X_event_slot_ID,X    
		cmp $00 
		clc 
		BEQ +                     
        TXA                            
        CLC                            
        ADC.W #$0040                   
        TAX                            
        CPX.W #$0EC0                   
        BCC -                    
                                                        
    +	txy 
		plx 
		RTL                             
		


	myCollusinRaftBounce:
		lda #$2000		;fall speed acceleration
		clc 
		adc $1c,x 
		sta $1c,x 
		bcc ++
		lda $1e,x 
		clc
		adc #$0001
		cmp #$0002
		bne +
		stz $1c,x
	+	sta $1e,x
	++	
		lda $28,x 		;hitbox Xpos
		sta $08
		lda $2a,x 		;hitbox Ypos
		sta $0a
		jsl $80CE0C		;collusion Check with solid??
		cmp #$0000
		beq EndCollisionBounce
		
		lda #$fffd
		sta $1e,x
;		lda #$0800		; slow bounce
;		sec 
;		sbc $1c,x 
;		sta $1c,x 
;		bcs EndCollisionBounce
;		dec $1e,x 
;		
;		lda $1e,x
;		cmp #$fffe		; max up speed	
;		bpl EndCollisionBounce
;		lda #$fffe
;		sta $1e,x 
;		stz $1c,x
	EndCollisionBounce:		
		rtl 

;	myCollusinRaft01:
;		lda #$2000		;fall speed acceleration
;		clc 
;		adc $1c,x 
;		sta $1c,x 
;		bcc ++
;		lda $1e,x 
;		clc
;		adc #$0001
;		cmp #$0002
;		bne +
;		stz $1c,x
;	+	sta $1e,x
;	++	
;		
;		phx 
;		LDA.B RAM_X_event_slot_xPos,X        				; check if we can fall again
;        STA.B $00							 
;        LDA.B RAM_X_event_slot_yPos,X        
;        CLC                                  
;        ADC.W #$0008                         
;        STA.B $02						     
;        JSL.L $80CF86 		; readCollusionTable7e4000       ;80BBC9|2286CF80|80CF86;  
;		
;		BEQ +                   
;        BMI +  
;		plx 
;		bra ++ 
;	+	plx 
;		lda #$fffe
;		sta $1e,x 
;	++	stz.w $1e,x 
;		rtl 
		


	bounceOffWalls:
		lda $1a,x 		; forwared check
		bmi +			; backwards check
		lda $28,x 		; hitbox Xpos
		sta $08
		lda #$0001		; higher then hitbox 
		sta $0a
		jsl $80CE0C		;collusion Check with solid??
		cmp #$0000
		beq ++
		lda #$0000
		sta $04,x 
		lda #$ffff
		sta $1a,x 
		dec $0a,x
		dec $0a,x
		bra ++
		
	+	lda $28,x 		;hitbox Xpos
		sta $08
	;	lda $2a,x 		;hitbox Ypos
		lda #$0002
		sta $0a
		jsl $80CE0C		;collusion Check with solid??
		cmp #$0000
		beq ++
		lda #$4000
		sta $04,x 
		lda #$0001
		sta $1a,x 				
		inc $0a,x
		inc $0a,x
	++	rtl


	gainSpeedLeftAndRight:
		lda $04,x 
		beq +
		lda #$0400
		clc
		adc $18,x
		sta $18,x 
		lda $1a,x
		adc #$0000
		sta $1a,x
		cmp #$0001
		bne ++
		lda #$2000		; max speed  right 
		sta $18,x
		lda #$0001
		sta $1a,x
		bra ++
	+	lda $18,x 
		sec
		sbc #$0400
		sta $18,x 
		lda $1a,x
		sbc #$0000
		sta $1a,x 
		cmp #$fffe
		bne ++
		lda #$fffe		; max speed Left 
		sta $1a,x
		lda #$d000
		sta $18,x
				
	++ 	rtl 

	initPlatform:
		lda $542
		sta $02,x 
		
		LDA.W #$A6EF               		; #$A701, #$A6F8
        STA.B $00,x                   				
				
		lda $12,x 
		bne +							; jump over init
		lda.w #$A6EF
		sta $00,x 

		LDA.W #$0010   
        STA.B $28,X    
        LDA.W #$0008   
        STA.B $2A,X       
        lda #$0020		
		sta $2e,x 
		
		lda #$0003
		sta $2c,x 	
	+	rtl
		
	frontCollusionUpBounce:
		LDA $0A,X   	
		CLC                 
		ADC $08 
		STA $00  
		LDA $02  
		SEC                 
		SBC #$0008          
		STA $02  
		JSL $80CF86 
		ldx $fc
		cmp #$0000
		beq +
		dec $1e,x 
	+	rtl 
	
	frontCollusionUpBounce2:
		LDA $0A,X   	
		CLC                 
		ADC $08 
		STA $00  
		LDA $02  
		SEC                 
		SBC #$0008          
		STA $02  
		JSL $80CF86 
		ldx $fc
		cmp #$0000
		beq +
		lda #$fffd
		sta $1e,x 
;		lda #$8000
;		sta $1c,x
	+	rtl  

	stopRaft:
		lda $0080
		bne +
	
		lda $18,x
		sec		
		sbc #$0300	
		sta $18,x 
		
		lda $1a,x
		sbc #$0000
		sta $1a,x
		bpl +
		stz $18,x
		stz $1a,x

		
	+	rtl

	stopRaftBad:
		lda $0080
		bne +
	
		lda $18,x
		sec		
		sbc #$0100	
		sta $18,x 
		
		lda #$0000
		sbc $1a,x
		sta $1a,x
		bpl +
		stz $1a,x		
	+	rtl
}


{ ; --------------------------- New Snakes 32 -------------------------
	findSimonBelowInRangeMakeState01:
		jsl subIDFunctionForSnakes
		LDA.W RAM_81_simonSlot_Ypos          	;80EB11|AD4E05  |81054E;  
		CMP.B RAM_X_event_slot_yPos,X        	;80EB14|D50E    |00000E;  
		BCC +                      				;80EB16|9019    |80EB31;  
		LDA.W RAM_81_simonSlot_Xpos          	;80EB18|AD4A05  |81054A;  
		AND.W #$FFFC                         	;80EB1B|29FCFF  |      ;  
		STA.B $00                            	;80EB1E|8500    |000000;  
		LDA.B RAM_X_event_slot_xPos,X        	;80EB20|B50A    |00000A;  
		CMP.B $00                            	;80EB22|C500    |000000;  
		BNE +                      				;80EB24|D00B    |80EB31;  
		LDA.W #$0001                         	;80EB26|A90100  |      ;  
		STA.B RAM_X_event_slot_state,X       	;80EB29|9512    |000012;  
		LDA.W #$0001                         	;80EB2B|A90100  |      ;  
		STA.W RAM_81_X_event_slot_32,X       	;80EB2E|9D3200  |810032;  
      + RTL                                  	;80EB31|6B      |      ;  

	subIDFunctionForSnakes:
		LDA.W $14,X    
        PHX                                  
        ASL A                                
        TAX                                  
        LDA.L hangingSnakeSubIDTable,X       
        PLX                                  
        STA.B $00                            
        JMP.W ($0000)                        

	hangingSnakeSubIDTable:
		dw normalSnakes,shootingSnakes,dropingFrogSnake

	normalSnakes:
		rtl 
	shootingSnakes:
		lda #$0001			; just start with the sneak up face.. 
		sta $12,x 
		rtl 
	dropingFrogSnake:
		lda $36,x 
		clc
		adc #$0001
		sta $36,x 
		bit #$0080
		bne +
		lda #$8a4a
		sta $00,x 
		lda $36,x 
	+	cmp #$0088
		bne +

		phx 		
		stz $36,x 
		lda RAM_X_event_slot_xPos,X
		pha
		lda RAM_X_event_slot_yPos,X
		pha 
		
		jsl $80D7F1			; find empty event slot 		
		bcs ++
		lda #$0030			; make it a frog and put it where the plant is 
		sta $10,x 
		sta $1a 			; get sprite slot 
		pla 
		sta RAM_X_event_slot_yPos,X 
		pla 
		sta RAM_X_event_slot_xPos,X 

		lda RAM_simonSlot_spritePriority
		sta $02,x 
		lda #$0047 
		sta RAM_X_event_slot_HitboxID,x 
		lda #$0008
		sta RAM_X_event_slot_HitboxXpos,x
		sta RAM_X_event_slot_HitboxYpos,x 
		
		stx $fc 			; RAM_XregSlotCurrent
		jsl calculateSpriteSlotOffset_ID_atRam1a 		; get sprite slot uses x and y 		
		plx 
		stx $fc 
	+	rtl 

	++ 	pla 
		pla 
		plx
		rtl 
		
}


{ ; --------------------------- highFiveSkellyFireball 36 -------------
	newHighFiveSkellyFireBall:
        LDA.W #$C033 
		sta $00
		JSL.L spriteAnimationRoutine00       ;82B9EE|2269B082|82B069;  hijack Fix 
		
		lda $30,x 
		bne +
		
		phx 
		jsl getEmptyEventSlot 
		txa
		plx
		sta $30,x 
		
		tay 
		lda #$0036
		sta.w $10,y 
		lda #$0006
		sta.w $12,y 
		
		lda RAM_X_event_slot_xPos,x 
		sta.w RAM_X_event_slot_xPos,y		
		lda RAM_X_event_slot_yPos,x 
		sta.w RAM_X_event_slot_yPos,y
		
		
	+	rtl 
	
	skellyHighFiveFireBall:
		lda #$9AB0
		sta $00,x 
		dec.b RAM_X_event_slot_yPos,x 
		rtl 
	
	
	movedSkellyHighFiveTable00:
		INC.B RAM_X_event_slot_state,X      
        LDA.W #$0003                       
        STA.B RAM_X_event_slot_Movement2c,X 
        STZ.B RAM_X_event_slot_HitboxID,X   
        RTL                                  

}

{; ---------------------------- different teaks (old job.asm)

	hijackPlaceEventType0:
		STA.B RAM_X_event_slot_xSpd          ;80D732|851A    |00001A;  is this a Vanilla bug??
        cmp #$004b
		bne +
		
		pha 
		lda $0003,y 							; also store the mask to RAM $20,x (eventtableRAM)
		and #$00ff
		sta $20,x 
		pla 		

	+	ASL A                                ;80D734|0A      |      ;  
        TAY                                  ;80D735|A8      |      ;  
		rtl 
	
	newSpecialLevelBehavier:
		stz $ae								; reset special level behavior
		lda $86								; ..  
		cmp #$001c
		bne +
		lda #$0001
		sta $ae
		bra ++
	+	cmp #$001d	
		bne ++
		lda #$0001
		sta $ae 
	++	lda $86 
		rtl 
	
	newSubweaponCuldowns:    
		phx 
		lda $8e
		asl
		tax
		lda.l subweaponColddownList,x
;		LDA.W #$0010                         ;80DE0E|A91000  |      ;  
        STA.B $BA                            ;80DE11|85BA    |0000BA;  
		plx
		rtl
	subweaponColddownList:
		dw $0000,$0008,$0008,$0008,$0010,$0000
	newWhipColdwons:
		lda $92					; make the last whip a super short coldown to get masive hits
		cmp #$0002
		bne +
		lda #$0006				; 4
		bra ++
	+	LDA.W #$0010                         ;80DE03|A91000  |      ;  
    ++  STA.B $AC                            ;80DE06|85AC    |0000AC;  	
		rtl 
		
	newHeartCostCalc:
		lda !jobTable03
		and #$0f00
		cmp #$0200
		beq +		
		cmp #$0400
		beq +
		jsl $80BD43
		rtl
 
; freeAmoOnZeroHearts
	+	LDA.B $8e			; RAM_simon_subWeapon           
        ASL A                           
        TAY                                
        LDA.W $13f2 		; RAM_81_simonStat_Hearts    
        CMP.W subweaponHeartCost,Y           ;80BD4A|D95592  |819255;  
        BCC +                     
        SED                                 
        LDA.W $13f2			; RAM_81_simonStat_Hearts       
        SEC                                 
        SBC.W subweaponHeartCost,Y           ;80BD54|F95592  |819255;  
        STA.W $13f2 		; RAM_81_simonStat_Hearts       
        CLD                                  
        RTL            
	  + stz $13f2
	    sec
		rtl
		
		
	initGameSetup:
		lda $be					; backup buttonmaping jump,whip and subweapon 
		sta !backUpButtonMapJump
		lda $c0
		sta !backUpButtonMapWhip
		lda $c2
		sta !backUpButtonMapSubWe
		
		LDA.W #$008B			; hijackFix
		JSL.L $8085E3                    
		rtl
	
	newSmallHeartWhipUpgradeCheck:
;        pha 
;		lda $ac 
;		cmp #$ffff
;		bne +
;		stz $ac					; remove candle cancle whip 
;	+	lda $ae
;		cmp #$ffff
;		bne +
;		stz $ae					; remove candle cancle subw
;		
;	+	pla 

		CMP.W #$0018           ; smallHeartID it is stored at $10,x and we check for possebility
        BNE notSmallHeart 
;		lda $92					; only collect when whip type is selected 2
;		cmp #$0001
		lda !ownedWhipTypes		; only get when whip is owned 
		and #$fff6
		beq ++
		lda !whipDropCounter
		clc
		adc #$0001
		sta !whipDropCounter
		and #$000f				; overflow protect  
		cmp #$0003
		bcc ++
		stz !whipDropCounter
		lda #$0005
		cmp !whipLeanth
 
		bcc ++
		
;        LDY.W $13f2				; RAM_81_simonStat_Hearts     
;        CPY.W #$0004                    
;        BCC ++
;		LDA $92					; RAM_simon_whipType   
;        BEQ dropWhipUpgrade                     
;        CPY.W #$0008            ; check hearts for second whip upgrade
;        BCC ++                   
;        DEC A                               
;        BEQ dropWhipUpgrade                  
;     ; doubleTribleSpawn    
;		LDA.B $8e				; RAM_simon_subWeapon  
;        BEQ ++                    
;        CMP.W #$0005            
;        BEQ ++                     
;        LDA.W $13c6 			; RAM_81_BG3_subweaponHitCounter
;        CMP.W #$000A           	; amount of things hit till it drops upgrade
;        BCC ++                    
;        STZ.W $13c6				; RAM_81_BG3_subweaponHitCounter
;        LDA.B $90				; RAM_simon_multiShot            
;        CMP.W #$0002                      
;        BCS ++                     
;        ADC.W #$0023                      
;        BRA +                     
     dropWhipUpgrade: 
		LDA.W #$0018                       
 ;       LDY.W $13ec				; RAM_81_simonStat_whipUpgradDropFlag 
 ;       BNE +                    	; this is disable to prevent the bug when the upgrad falls into a pit. We also have a system that prevents multiples..
        LDA.W #$0021                      
 ;       INC.W $13ec				; RAM_81_simonStat_whipUpgradDropFlag;80E05C|EEEC13  |8113EC;     
 ;	 +	
		STA.B $10,X                        
     ++ RTL                                
	notSmallHeart: 
		SEC                             
		SBC.W #$0019             	; check if same subweapon        
		CMP.B $8e					; subweapon
		BNE +                  
		LDA.W #$0019            	; big heart            
		STA.B $10,X                      
;      + cmp #$0023					; drop small meat instead of double
;		bne +
;		lda #$0025
;		sta $10,x
	  +	RTL 
;		lda !whipDropCounter
;		clc 
;		adc #$0001
;		cmp #$0003
;		bne +
;		
;		lda #$0000
;		sta !whipDropCounter
;		lda #$0021
;		bra ++
;	+	sta !whipDropCounter
;		lda #$0018
;	++	rtl 		

	
	
	NewWhipLeangthBehavier:					; !whipLeanth
		cpy #$0000
		bne + 
		lda #$0006							; leather whip leangth
		bra ++
	+	LDA !whipLeanth
		clc 
		adc #$0002
	++	STA.W $027C                         
		rtl 
	
	NewWhipLeangthBehavierRing:
		phx
		pha
		lda $92
		cmp #$0001
		beq +
		pla
		cmp.l whipLeangthSwingData
		bcc ++
		lda.l whipLeangthSwingData
		bra ++

	+	lda !whipLeanth
		inc									; so we have the first entry for the other whips 
		asl
		tax
		pla
		cmp.l whipLeangthSwingData,x 
		bcc ++
		lda.l whipLeangthSwingData,x              
	++	plx
		jml $80AB43							; Hijack Fix
			
	whipLeangthSwingData:
		dw $00bf,$005f,$007f,$009f,$00bf,$00df,$00ff,$00ff		; first value in table is for leather whip 
		
	newWhipTypeBehavier:
		lda $92
		bne +
		LDA.L whipStateTable01,X 
		bra ++
	+	cmp #$0001
		beq +
		LDA.L whipStateTable00,X
		bra ++
	+ 	LDA.L whipStateTable,X 
	++	rtl 

	stopWatchTimerHurb:
		lda RAM_simon_subWeapon
		cmp #$0005
		bne +
		lda $444
		beq +
		dec.w $444 
	+	rtl 		
	
	autoScroolRoutine:
		lda !autoScroll
		beq +
		cmp #$0002
		beq ++
		
		lda $3a 
		bit #$0001				; run uneven frames 
		beq +

		inc $1c 
		
		lda $1c
		sta $a0 
				
	+	rtl 
	++	lda $3a 
		bit #$0001				; run uneven frames 
		beq +

		dec $1c 
		
		lda $1c
		sta $a2 	
		rtl
	
	annoyingDogRoutine:
		lda RAM_simon_multiShot			; elevator card check 
		and #$0001
		beq endDogMischief

		lda RAM_frameCounter			; make it rare so when frame counter is equal to RNG
		bit.w RAM_RNG_1	
		beq endDogMischief
		bit.w RAM_RNG_2
		bne endDogMischief	
		bit.w RAM_RNG_3
		bne endDogMischief			
		
		lda #$002c					; 14	17 
		jsl lunchSFXfromAccum
		
		lda RAM_simon_subWeapon			; exchange items 
		sta $00
		
		jsl removeItem
		lda #$0009
		sta.w $2e,y 
		lda #$ffff						; push it up  a bit 
		sta.w RAM_X_event_slot_ySpd,y 
		
		lda $3a 
		bit #$0001
		beq +
		
		lda RAM_simon_multiShot			; also throw keys away 
		and #$0002
		beq +
		lda #$0001
		sta RAM_simon_multiShot
		lda $00
		sta RAM_simon_subWeapon			; give subweapon but throw key 	
		
		lda #$0024
		sta.w $10,y 
		bra endDogMischief

	+   lda $00
		bne endDogMischief
		sta RAM_simon_subWeapon			; give no subweapon back and throw away hearts in anger 
		lda #$0019
		sta.w $10,y 
		sed
		lda RAM_simonStat_Hearts
		sec
		sbc #$0005
		bmi +
		sta RAM_simonStat_Hearts		; simple no minus hearts 
	+   cld 
;		ldx #$0000
;		txy 
	endDogMischief:	
		rtl 
	
	
	pauseCheckHijack:
		lda $70
		cmp #$0005 						; only run main game 
		bne +
		jsl dogLeashRoutine
		
		jsl stopWatchTimerHurb
		jsl selectSubweaponsWhenUpgraded
		jsl doBlueSkinL
if !radio == 1
		jsl musicSelector		
endif 		
		lda $66							; dont run while pause
		bne +
		
		jsl autoScroolRoutine
		jsl annoyingDogRoutine 
		
		lda !layer2ScrollBehavier
		beq +
		jsl runBGScreenScrollGlobal			; this is located along the event that triggers it in the tutorialHackTweak.asm 



	+	JSL.L $80978F                    ;hijackFix this will check for pause
		rtl

	dogLeashRoutine:
		lda !dogLeash
		beq ++
		
		lda RAM_buttonPressCurFram
		bit #$0020
		beq ++
		
		lda !dogLeash
		cmp #$0002
		beq +							
		lda RAM_simon_multiShot			; take away 
		and #$0002
		sta RAM_simon_multiShot	
		lda #$0002
		sta !dogLeash
		bra ++	
								
	+	
		lda RAM_simon_multiShot			; give 	
		ora #$0001
		sta RAM_simon_multiShot	
		lda #$0001
		sta !dogLeash
	++	rtl 

if !radio == 1
	musicSelector:
		lda $20				; Select Hold check
		bit #$2000
		beq endMusicSelector	 

		lda $28				; rotate music with select X
		cmp #$0040
		bne playMusicSelecteded
		lda !costumMusicNumber
		inc 
		inc
		cmp #$0046
		bne +
		lda #$0000
	+	sta !costumMusicNumber	 
		
	playMusicSelecteded: 
		lda $28				
		cmp #$0080				; A button Press
		bne endMusicSelector		
		
		lda !costumMusicNumber				; selected music
		jsl $8280DD			; music change
		JSL.L $80859E  		; donno seems to tune the music a bit quicker..
;		lda #$000f0			; reset Music
;		JSL.L $8085E3
		
;		pla				; get rid of stuck pointer to check again if Simon died
;		sep #$20
;		pla
;		rep #$30
;		sec
;		JML.L $8097A5
		
	endMusicSelector:	
		rtl
endif 

	selectSubweaponsWhenUpgraded:
		ldx $8e							; get current subweapon 
		lda !allSubweapon
		cmp #$0001
		bne endsubWeaponSelect
	
		lda $20							; press L and use arrows to choose
		bit #$0020
		beq ++
		bit #$0100
		beq +
		ldx #$0001
	+	bit #$0200
		beq +
		ldx #$0002		
	+	bit #$0400
		beq +
		ldx #$0003		
	+	bit #$0800
		beq +
		ldx #$0004		
	+	bit #$0080
		beq ++
		ldx #$0005						; herb  
	
	++	stx $8e
	endsubWeaponSelect:	
		lda !noWhipSwitch				; disable switching toggle 
		bne +++
		lda $28							; press select to rotate whip type	always				
		and #$f000
		cmp #$2000
		bne +++
		
		lda $92							; based on whip type 
		inc
		cmp !ownedWhipTypes
		bcc ++		
		LDX.W #$B3EB            			; leather whip     		
        JSL.L $8280e8
		lda #$0000		
	+	sta $92		
		rtl
	++	sta $92
		cmp #$0002
		beq +
		LDX.W #$B3FE						                     
        JSL.L $8280e8 						; miscGFXloadRoutineXPlus81Bank	
	+++	rtl 
	  + LDX.W #$FF27						; FireWhip #$FF27	                   
        JSL.L $8280e8 	
		rtl		
	
	doBlueSkinL:
;		lda !armorType			; switcher 1e1a
;		beq endDoBlueSkinL
		
		phb
		phk
		plb
		
		phx
		lda !armorType
		
		asl 
		tax
		lda.l armorColorPointer,x 
		sta $00
		
		ldy #$0000
		ldx #$0000
	-	lda ($00),y 
		sta $7e2310,x 
		inx
		inx 
		iny
		iny
		cpx #$0008
		bne -
		
	+	plx 
		plb		
	endDoBlueSkinL:	
		rtl

	armorColorPointer:
	dw armorVanilla,armorColorsBlue,armorColorsRed,armorColorsGreen,armorColorsGold

	
	armorVanilla: 
		dw $77B8  
		dw $4E70  
		dw $2528  
		dw $0462 
	armorColorsBlue:
		dw $7b74, $5dab, $3883, $0800
	armorColorsRed:
		dw $319F  
		dw $0013  
		dw $000C  
		dw $0006 
	armorColorsGreen:
		dw $33E0  
		dw $1A60  
		dw $1980  
		dw $18C0 	
	armorColorsGold:
		dw $67E6  
		dw $4E60  
		dw $3180  
		dw $18C0 


	whipStateTable:		
		dw whipReset,whipIdle,whipWindup,whipDirections,whipLimpWhipReplacement 	; original
		dw whipLimp,whipSwing1,whipSwing2
	
	whipStateTable00:		
		dw whipReset,whipIdle,whipWindup,whipLimpWhipReplacement,whipReset 	; 
		dw whipLimp,whipSwing1,whipSwing2
	whipStateTable01:		
		dw whipReset,whipIdle,whipWindup,whipDirections,whipLimpWhipReplacement 	; original
		dw whipLimp,whipSwing1,whipSwing2
	
	NewWhileDead:
;		stz !whipLeanth
		lda !whipLeanth
		lsr
		sta !whipLeanth
		
		sed									; hijackFix
		lda $7c
		clc	
		rtl 
}


{; ------------------------------ new Hunchback 57 routijne
	newHunchbackSript:
		DEC.B RAM_X_event_slot_3e,X          
        BNE +++                 
		
		ldy #$0007											; high jump as default option 
		stz.b $04,x											; facing left as default 			
		lda RAM_81_simonSlot_Xpos
		cmp RAM_X_event_slot_xPos,X 
		bcc ++
				
		lda RAM_simonSlot_spriteAttributeFlipMirror			; simon is right we check if he is facing away to do short jump 
		beq +
		
		lda #$4000
		sta $04,x 
		bra endHunchBackScrip
	+	lda #$4000
		sta $04,x 	
		ldy #$0005		; jump wide
		
		bra endHunchBackScrip
								
	++	lda #$0004											; does decide to jump left 
		sta $3e,x 
		lda RAM_simonSlot_spriteAttributeFlipMirror 		; simon is Left
		beq endHunchBackScrip
 
		ldy #$0005		; jump wide
		bra endHunchBackScrip	


;		LDY.W #$0007                         
;        LDA.W #$4000                         
;        STA.B $04,x 					; RAM_X_event_slot_flip_mirror_attribute,X
;        LDA.W RAM_81_simonSlot_Xpos          
;        SEC                                  
;        SBC.B RAM_X_event_slot_xPos,X        
;        BPL ++                      
;        PHA                                  
;        LDA.B RAM_RNG_2                      
;        AND.W #$0003                         
;        BEQ +                      
;        STZ.B $04,x 					; RAM_X_event_slot_flip_mirror_attribute,X
;        LDA.W #$0004                         
;        STA.B RAM_X_event_slot_3e,X          
;                                             
;	+	PLA                                  
;        EOR.W #$FFFF                         
;        INC A                                
;                                             
;	++	CMP.W #$0050                         
;        BCC endHunchBackScrip                      
;        LDA.B $E9                            
;        AND.W #$0003                         
;        BEQ endHunchBackScrip                      
;        LDY.W #$0005                                                                     
	endHunchBackScrip:		
		STY.B RAM_X_event_slot_state,X       
        LDA.W #$9387                         
        STA.B $00,x 					; RAM_X_event_slot_sprite_assembly,X
                                                           
	+++	RTL                                 


}

pushPC		

org $81a253
	db $48,$34							; make clock Hud green (hurb)
org $84816c
	db $24 								; sprite assembly 

org $81FF27								; data bank 81 use of free space 
	FireWhipLoadScrDest:
		dw $0100,$6200                      
        dl whipFireStrightGFXdata       
        dw $6300                           
        dl whipFireLimpGFXdata           
        dw $69C0                           
        dl whipFireNoWhipGFXdata         
        dw $FFFF
	newHUDupgradIcons:
		dw $0000
		dw $7264 
		dw $3666 
		dw $7665 
org $80C6F1
    LDA.W newHUDupgradIcons,Y 			; multiShotUpgradHudSpritePPU,Y  ;80C6F1|B953A2  |81A253;  

org $FE8F1D
	whipFireStrightGFXdata: 
		db $83,$00,$80
org $FE8FFD		
	whipFireLimpGFXdata:
		db $83,$00,$80
org $FE90DD		
	whipFireNoWhipGFXdata: 
		db $23,$00,$80 


{ ; ---------------------------- SPRITEASSEMBLY    ROM TWEAKS  ------------------------------	

org $8481B8
	;sprAssFirstPageID_48:
		db $02                               ;8481B8|        |0000F7;  money Points
        dd $028BFCF7,$028AFCFC               ;8481B9|        |      ;  
        dd $028AFC01                         ;8481C1|        |      ;  
                                                            ;      |        |      ;  
	;sprAssFirstPageID_49: 
		db $03                               ;8481C5|        |0000F7;  
		dd $028CFCF7,$028AFCFC               ;8481C6|        |      ;  
		dd $028AFC01                         ;8481CE|        |      ;  
                                                            ;      |        |      ;  
	;sprAssFirstPageID_4a: 
		db $02                               ;8481D2|        |0000F7;  
        dd $028DFCF7,$028AFCFC               ;8481D3|        |      ;  
        dd $028AFC01                         ;8481DB|        |      ; 

	;sprAssFirstPageID_4b: 
		db $03                               ;8481DF|        |0000F7;  
		dd $028EFCF7,$028AFCFC               ;8481E0|        |      ;  
		dd $028AFC01                         ;8481E8|        |      ;  

	;sprAssFirstPageID_4c: 
		db $02                               ;8481EC|        |0000F7;  
		dd $028FFCF7,$028AFCFC               ;8481ED|        |      ;  
		dd $028AFC01                         ;8481F5|        |      ;  
                                                            ;      |        |      ;  
	;sprAssFirstPageID_4d: 
		db $03                               ;8481F9|        |0000F7;  
        dd $029AFCF7,$028AFCFC               ;8481FA|        |      ;  
        dd $028AFC01                         ;848202|        |      ;  
                                                            ;      |        |      ;  
	;sprAssFirstPageID_4e: 
		db $02                               ;848206|        |0000F7;  
        dd $029BFCF7,$028AFCFC               ;848207|        |      ;  
        dd $028AFC01                         ;84820F|        |      ;  
                                                            ;      |        |      ;  
	;sprAssFirstPageID_4f: 
		db $03                               ;848213|        |0000F7;  
        dd $029CFCF7,$028AFCFC               ;848214|        |      ;  
        dd $028AFC01                         ;84821C|        |      ;  
                                                            ;      |        |      ;  
	; sprAssFirstPageID_50: 
		db $03                               ;848220|        |0000F7;  
        dd $029DFCF7,$028AFCFC               ;848221|        |      ;  
        dd $028AFC01                         ;848229|        |      ;  



org $80e87a							; breakable block assembly sub00 
	db $00,$B0,$00,$B0,$00,$30,$00,$30,$00,$30,$00,$30,$00,$30,$00,$30,$00,$30,$00,$30,$00,$30,$00,$30

org $83ea8b 						; fence Blocks fix and tile arrangment
	db $21,$21						; replace Blocks 
	db $01,$08,$02,$08,$01,$08,$02,$08,$01,$08,$02,$08,$01,$08,$02,$08,$03,$08,$04,$08,$03,$08,$04,$08,$03,$08,$04,$08,$03,$08,$04,$08

org $81e24b							; Viper Boss Water Blocks on startup 
	db 03,$00,$00,$00,$05,$03,$00,$00,$05,$05,$00,$00,$05,$05,$00,$00,$05,$05,$05,$00,$05,$05,$05,$00,$05,$05,$06,$00,$00
org $83e034 
	cmp #$0003						; no rising water faster Transition 


org $848F15
	;sprAssID_99_oldManWalking00: 
;	wizzardSprite00:
	oldManFr1:
		db $06                               ;848F15|        |0000FD;  
        dd $220A08FD
		dd $220808ED               ;848F16|        |      ;  
        dd $2206F8FD
		dd $2204F8ED               ;848F1E|        |      ;  
        dd $2202E8FD
		dd $2200E8ED               ;848F26|        |      ;  
                                                            ;      |        |      ;  
	;sprAssID_100_oldManWalking01: 
;	wizzardSprite01:	
	oldManFr2:
		db $06                               ;848F2E|        |0000FD;  
        dd $222208FD
		dd $222008ED               ;848F2F|        |      ;  
        dd $220EF8FD
		dd $220CF8ED               ;848F37|        |      ;  
        dd $2202E8FD
		dd $2200E8ED               ;848F3F|        |      ;  


org $8489D1  ; ghost 
    ;sprAssID_03: 
		db $03                               ;8489D1|        |0000F8;  
        dd $2800F8F8
		dd $2604F908               ;8489D2|        |      ;  
        dd $2602F9F8                         ;8489DA|        |      ;  
    ;sprAssID_04: 
		db $03                               ;8489DE|        |0000F8;  
        dd $2800F8F8
		dd $2608F908               ;8489DF|        |      ;  
        dd $2606F9F8                         ;8489E7|        |      ;  
   ;sprAssID_05: 
		db $01                               ;8489EB|        |0000F8;  
        dd $260AF8F8         

org $849193     ; ghost 
	;sprAssID_137: 
		db $01                               ;849193|        |0000F8;  
        dd $260CF8F8                         ;849194|        |      ;  
   ; sprAssID_138: 
		db $01                               ;849198|        |0000F8;  
        dd $260EF8F8                         ;849199|        |      ;  

org $8490D7
    ;sprAssID_129:     				; table sprite assembly 
		db $07                               ;8490D7|        |      ;  
        dd $3646fc11
		dd $3642ec11               ;8490D8|        |      ;  
		dd $3644fc01
		dd $420401F1               ;8490E0|        |      ;  
        dd $220401E1
;		dd $2202F101               ;8490E8|        |      ;  
        dd $4200F1F1
		dd $2200F1E1               ;8490F0|        |      ;  


org $84FE7F						; $84FFB5 free Space Orginal
    oldMan2Fr1: 
		db $06                     
        dd $260A08FD
		dd $260808ED               
        dd $2206F8FD
		dd $2240F8ED               
        dd $2202E8FD
		dd $2200E8ED               
    oldMan2Fr2: 
		db $06                     
        dd $262208FD
		dd $262008ED               
        dd $220EF8FD
		dd $2242F8ED               
        dd $2202E8FD
		dd $2200E8ED               
	oldMan3Fr1: 
		db $06                     
        dd $262e08FD
		dd $262c08ED               
        dd $264aF8FD
		dd $2648F8ED               
        dd $262aE8FD
		dd $2628E8ED               
    oldMan3Fr2: 
		db $06                     
        dd $264208FD
		dd $264008ED               
        dd $264eF8FD
		dd $264cF8ED               
        dd $262aE8FD
		dd $2628E8ED              
	jungLadyFr1: 
		db $03                    
		dd $264608F8              
		dd $2626F8F8              
		dd $2624E8F8              

	doorSpriteAssembly:
		db $04
		db $FD,$08,$44,$22
		db $FD,$F8,$44,$A2
		db $FD,$E8,$44,$22
		db $FD,$D8,$44,$A2
		
		
	
	sheepSpriteAssembly:
		db $08
		db $E0,$E8,$00,$28
		db $F0,$E8,$02,$28
		db $00,$E8,$04,$28
		db $10,$E8,$06,$28
		db $E0,$F8,$08,$28
		db $F0,$F8,$0A,$28
		db $00,$F8,$0C,$28
		db $10,$F8,$0E,$28

	newLeverSpriteAssembly00:
		db $02
		db $08,$F8,$06,$24
		db $F8,$F8,$04,$24

	newLeverSpriteAssembly01:
		db $02
		db $08,$F8,$02,$24
		db $F8,$F8,$00,$24
		
	GradiusSpriteAssembly00:	;
		db $08
		db $10,$f0,$00,$6E
		db $00,$f0,$02,$6E
		db $f0,$f0,$04,$6E
		db $e0,$f0,$06,$6E
		db $10,$00,$20,$6E
		db $00,$00,$22,$6E
		db $f0,$00,$24,$6E
		db $e0,$00,$26,$6E
	
	GradiusSpriteAssembly01:	;
		db $08
		db $10,$f0,$08,$6E
		db $00,$f0,$0a,$6E
		db $f0,$f0,$0c,$6E
		db $e0,$f0,$0e,$6E
		db $10,$00,$28,$6E
		db $00,$00,$2a,$6E
		db $f0,$00,$2c,$6E
		db $e0,$00,$2e,$6E

	simonInCoffine:
		db $02
		db $F0,$EC,$00,$20
		db $00,$EC,$02,$20
	
org $848246					; more free space for sprite assembly 
	luigiSpriteAssembly:
		db $02                              
		db $f8,$08,$02,$24
		db $f8,$f8,$00,$24
	AssPaul:
		db $08
		db $10,$e8,$82,$22
		db $00,$e8,$80,$22
		db $10,$d8,$62,$22
		db $00,$d8,$60,$22
		
		db $00,$08,$a6,$22
		db $f0,$08,$a4,$22
		db $00,$f8,$a2,$22
		db $f0,$f8,$a0,$22


	AssAramus00:
		db $04
		db $f8,$f8,$24,$24
		db $08,$f8,$26,$24
		db $f8,$08,$44,$24
		db $08,$08,$46,$24
						 
	AssAramus01:         
		db $04           
		db $f8,$f8,$28,$24
		db $08,$f8,$2a,$24
		db $f8,$08,$48,$24
		db $08,$08,$4a,$24

	AssGuy:         
		db $03           
		db $F8,$e8,$2e,$26
		db $F8,$f8,$4e,$26
		db $F8,$08,$40,$26

	oldManBrawnPents00:				; 
		db $06                               ;old man sprite assembly 
        dd $260A08FD
		dd $260808ED               ;848F16|        |      ;  
        dd $2206F8FD
		dd $2204F8ED               ;848F1E|        |      ;  
        dd $2202E8FD
		dd $2200E8ED               ;848F26|        |      ;  
    oldManBrawnPents01: 
		db $06                               ;848F2E|        |0000FD;  
        dd $262208FD
		dd $262008ED               ;848F2F|        |      ;  
        dd $220EF8FD
		dd $220CF8ED               ;848F37|        |      ;  
        dd $2202E8FD
		dd $2200E8ED               ;848F3F|        |      ;  

	headlessKnightNPC: 
		db $07                              
		dd $2C62E4E0     
        dd $2C64E4F0         
		dd $2C66f4E0     
        dd $2C68f4F0   
		dd $2C6a04E0     
        dd $2C6c04F0 
		dd $2C600880 

	chillSkellyAss:
		db $0d
		db $00,$b0,$4e,$6e
		db $00,$c0,$4e,$ee		
		db $f8,$d0,$4e,$6e
		db $08,$c8,$4e,$2e
		db $f8,$e0,$60,$6e
		db $08,$d8,$60,$2e						 
		db $f8,$e8,$62,$ae
		db $08,$e8,$64,$ae
		db $f8,$d0,$27,$6e
		db $08,$d0,$25,$6e		
		db $00,$e0,$02,$6e
		db $fc,$f0,$06,$6e
		db $0c,$f0,$04,$6e		
	ddSprite00:
		db $04
		db $f0,$00,$0c,$28
		db $00,$00,$0e,$28
		db $f0,$08,$1c,$28
		db $00,$08,$1e,$28
	ddSprite01:	
		db $04
		db $f0,$00,$3c,$28
		db $00,$00,$3e,$28
		db $f0,$08,$4c,$28
		db $00,$08,$4e,$28
	fishSprite:
		db $02
		db $00,$fc,$4a,$24
		db $f0,$fc,$48,$24
	smallFish:
		db $02
		db $fc,$fc,$4a,$24
		db $f4,$fc,$48,$24
	
	
	snowFlake:
		db $01
		db $FC,$01,$04,$02
	
	dragonNeckLong:
		db #$02
		dd $2B68F900
		dd $2B68F9f0
;		dd $2B68F9E9	
warnPC $84896E	

}
		


{ ; -------------------------- MAKEing SPACE IN THE ROM to expand tables.. ------------------ 
org $86C3A4							; after death fight 
		JSL.L CODE_84FEE9                    ;86C3A4|22E9FE84|84FEE9;  

org $81A54B						; make space for sprite assembly 
		dl event_ID_65_fallingBlocks         ;81A54B|        |84FE7F; 

; --------------- move simons DMA pointers 
org $808251		
        JSL.L simonSpriteDMAPointerToo1b00   ;808251|22BFC580|80C5BF;  		
		
org $ff8000					; new free space 		
;pullPC

	event_ID_65_fallingBlocks: 
		LDA.B RAM_X_event_slot_state,X       ;84FE7F|B512    |000012;  
        PHX                                  ;84FE81|DA      |      ;  
        ASL A                                ;84FE82|0A      |      ;  
        TAX                                  ;84FE83|AA      |      ;  
        LDA.L fallingBlocksStateTable,X      ;84FE84|BF8EFE84|84FE8E;  
        PLX                                  ;84FE88|FA      |      ;  
        STA.B $00                            ;84FE89|8500    |000000;  
        JMP.W ($0000)                        ;84FE8B|6C0000  |000000;  
                                                            ;      |        |      ;  
	fallingBlocksStateTable: 
		dw fallingBlocksState00              ;84FE8E|        |84FE94;  
        dw fallingBlocksState01              ;84FE90|        |84FE99;  
        dw fallingBlocksState02              ;84FE92|        |84FEC3;  
                                                            ;      |        |      ;  
	fallingBlocksState00: 
		STZ.B RAM_X_event_slot_HitboxID,X    ;84FE94|742E    |00002E;  
        INC.B RAM_X_event_slot_state,X       ;84FE96|F612    |000012;  
        RTL                                  ;84FE98|6B      |      ;  
                                                            ;      |        |      ;  
	fallingBlocksState01: 
		LDA.B RAM_X_event_slot_24,X          ;84FE99|B524    |000024;  
        BEQ CODE_84FEA0                      ;84FE9B|F003    |84FEA0;  
        DEC.B RAM_X_event_slot_24,X          ;84FE9D|D624    |000024;  
        RTL                                  ;84FE9F|6B      |      ;  
                                                            ;      |        |      ;  
	CODE_84FEA0: 
		LDA.B RAM_X_event_slot_22,X          ;84FEA0|B522    |000022;  
        INC.B RAM_X_event_slot_22,X          ;84FEA2|F622    |000022;  
        ASL A                                ;84FEA4|0A      |      ;  
        TAY                                  ;84FEA5|A8      |      ;  
        LDA.W $81EFCB,Y                ;84FEA6|B9CBEF  |81EFCB;  
        CMP.W #$FFFF                         ;84FEA9|C9FFFF  |      ;  
        BEQ CODE_84FEBF                      ;84FEAC|F011    |84FEBF;  
        AND.W #$00FF                         ;84FEAE|29FF00  |      ;  
        STA.B $00                            ;84FEB1|8500    |000000;  
        LDA.W $81EFCC,Y                ;84FEB3|B9CCEF  |81EFCC;  
        AND.W #$00FF                         ;84FEB6|29FF00  |      ;  
        STA.B RAM_X_event_slot_24,X          ;84FEB9|9524    |000024;  
        JSR.W fallingBlocksRoutine00         ;84FEBB|20FBFE  |84FEFB;  
        RTL                                  ;84FEBE|6B      |      ;  
                                                            ;      |        |      ;  
    CODE_84FEBF: 
		JML.L clearSelectedEventSlotAll      ;84FEBF|5C598C80|808C59;  
                                                            ;      |        |      ;  
	fallingBlocksState02: 
		JSL.L CODE_84FEE9                    ;84FEC3|22E9FE84|84FEE9;  
        BEQ CODE_84FED0                      ;84FEC7|F007    |84FED0;  
        BMI CODE_84FED0                      ;84FEC9|3005    |84FED0;  
        CMP.W #$0006                         ;84FECB|C90600  |      ;  
        BNE CODE_84FED6                      ;84FECE|D006    |84FED6;  
                                                            ;      |        |      ;  
    CODE_84FED0: 
		LDX.B RAM_XregSlotCurrent            ;84FED0|A6FC    |0000FC;  
        JML.L $82D62B ; bridgeState02_longJump         ;84FED2|5C2BD682|82D62B;  
                                                            ;      |        |      ;  
    CODE_84FED6: 
		LDA.W #$0047                         ;84FED6|A94700  |      ;  
        JSL.L $8085E3                    ;84FED9|22E38580|8085E3;  
        LDX.B RAM_XregSlotCurrent            ;84FEDD|A6FC    |0000FC;  
        JSL.L CODE_84FF25                    ;84FEDF|2225FF84|84FF25;  
        LDX.B RAM_XregSlotCurrent            ;84FEE3|A6FC    |0000FC;  
        JML.L clearSelectedEventSlotAll      ;84FEE5|5C598C80|808C59;  
                                                            ;      |        |      ;  
    CODE_84FEE9: 
		LDA.B RAM_X_event_slot_xPos,X        ;84FEE9|B50A    |00000A;  
        STA.B $00                            ;84FEEB|8500    |000000;  
        LDA.B RAM_X_event_slot_yPos,X        ;84FEED|B50E    |00000E;  
        CLC                                  ;84FEEF|18      |      ;  
        ADC.W #$0008                         ;84FEF0|690800  |      ;  
        ADC.B RAM_X_event_slot_xSpd,X        ;84FEF3|751A    |00001A;  
        STA.B $02                            ;84FEF5|8502    |000002;  
        JML.L $80CF86		; readCollusionTable7e4000       ;84FEF7|5C86CF80|80CF86; 
	
	
	fallingBlocksRoutine00: 
		JSL.L $80D7F1			; getEmptyEventSlot              ;84FEFB|22F1D780|80D7F1;  
        BCS CODE_84FF24                      ;84FEFF|B023    |84FF24;  
        JSL.L $808C59			; clearSelectedEventSlotAll      ;84FF01|22598C80|808C59;  
        LDA.W #$0065                         ;84FF05|A96500  |      ;  
        JSL.L $80D37A                    ;84FF08|227AD380|80D37A;  
        LDA.W #$A5A0                         ;84FF0C|A9A0A5  |      ;  
        STA.B $00,X                          ;84FF0F|9500    |000000;  
        LDA.W #$0002                         ;84FF11|A90200  |      ;  
        STA.B RAM_X_event_slot_state,X       ;84FF14|9512    |000012;  
        LDA.B $00                            ;84FF16|A500    |000000;  
        STA.B RAM_X_event_slot_xPos,X        ;84FF18|950A    |00000A;  
        LDA.W #$0002                         ;84FF1A|A90200  |      ;  
        STA.B RAM_X_event_slot_Movement2c,X  ;84FF1D|952C    |00002C;  
        LDA.W #$0047                         ;84FF1F|A94700  |      ;  
        STA.B RAM_X_event_slot_HitboxID,X    ;84FF22|952E    |00002E;  
                                                            ;      |        |      ;  
    CODE_84FF24: 
		RTS                                  ;84FF24|60      |      ;  
	
 ;      |        |      ;  
    CODE_84FF25: 
		LDA.B RAM_X_event_slot_xPos,X        ;84FF25|B50A    |00000A;  
        STA.B $00                            ;84FF27|8500    |000000;  
        LSR A                                ;84FF29|4A      |      ;  
        LSR A                                ;84FF2A|4A      |      ;  
        LSR A                                ;84FF2B|4A      |      ;  
        LSR A                                ;84FF2C|4A      |      ;  
        AND.W #$000E                         ;84FF2D|290E00  |      ;  
        STA.B $04                            ;84FF30|8504    |000004;  
        LDA.B RAM_X_event_slot_yPos,X        ;84FF32|B50E    |00000E;  
        STA.B $02                            ;84FF34|8502    |000002;  
        LSR A                                ;84FF36|4A      |      ;  
        AND.W #$0070                         ;84FF37|297000  |      ;  
        ORA.B $04                            ;84FF3A|0504    |000004;  
        STA.B $04                            ;84FF3C|8504    |000004;  
        TAX                                  ;84FF3E|AA      |      ;  
        LDA.L $7E8000,X                      ;84FF3F|BF00807E|7E8000;  
        STA.B $08 	     ;84FF43|8508    |000008;  
        LDY.W #$0000                         ;84FF45|A00000  |      ;  
                                                            ;      |        |      ;  
    CODE_84FF48: 
		LDA.W $81EFBD,Y                ;84FF48|B9BDEF  |81EFBD;  
        AND.W #$00FF                         ;84FF4B|29FF00  |      ;  
        CMP.B $08       ;84FF4E|C508    |000008;  
        BEQ CODE_84FF59                      ;84FF50|F007    |84FF59;  
        INY                                  ;84FF52|C8      |      ;  
        CPY.W #$000E                         ;84FF53|C00E00  |      ;  
        BCC CODE_84FF48                      ;84FF56|90F0    |84FF48;  
        rtl
                                                            ;      |        |      ;  
    CODE_84FF59: 
		TYA                                  ;84FF59|98      |      ;  
        ASL A                                ;84FF5A|0A      |      ;  
        TAY                                  ;84FF5B|A8      |      ;  
        LDA.B $00                            ;84FF5C|A500    |000000;  
        BIT.W #$0010                         ;84FF5E|891000  |      ;  
        BEQ CODE_84FF64                      ;84FF61|F001    |84FF64;  
        INY                                  ;84FF63|C8      |      ;  
                                                            ;      |        |      ;  
	CODE_84FF64: 
		LDX.B $04                            ;84FF64|A604    |000004;  
		LDA.W $81EFA1,Y			; DATA16_81EFA1,Y                ;84FF66|B9A1EF  |81EFA1;  
		AND.W #$00FF                         ;84FF69|29FF00  |      ;  
		STA.L $7E8000,X                      ;84FF6C|9F00807E|7E8000;  
		STA.B $0a				; RAM_X_event_slot_xPos          ;84FF70|850A    |00000A;  
		LDA.B $00                            ;84FF72|A500    |000000;  
		LSR A                                ;84FF74|4A      |      ;  
		LSR A                                ;84FF75|4A      |      ;  
		LSR A                                ;84FF76|4A      |      ;  
		AND.W #$001C                         ;84FF77|291C00  |      ;  
		STA.B $06				; RAM_X_event_slot_event_slot_health;84FF7A|8506    |000006;  
		LDA.B $02                            ;84FF7C|A502    |000002;  
		ASL A                                ;84FF7E|0A      |      ;  
		ASL A                                ;84FF7F|0A      |      ;  
		AND.W #$0380                         ;84FF80|298003  |      ;  
		ORA.B $06				; RAM_X_event_slot_event_slot_health;84FF83|0506    |000006;  
		TAY                                  ;84FF85|A8      |      ;  
		LDA.B $0a				; RAM_X_event_slot_xPos          ;84FF86|A50A    |00000A;  
		JSL.L $83D1E7 			; CODE_83D1E7                    ;84FF88|22E7D183|83D1E7;  
		LDA.B $00                            ;84FF8C|A500    |000000;  
		LSR A                                ;84FF8E|4A      |      ;  
		LSR A                                ;84FF8F|4A      |      ;  
		LSR A                                ;84FF90|4A      |      ;  
		AND.W #$001E                         ;84FF91|291E00  |      ;  
		STA.B $06				; RAM_X_event_slot_event_slot_health;84FF94|8506    |000006;  
		LDA.B $02                            ;84FF96|A502    |000002;  
		ASL A                                ;84FF98|0A      |      ;  
		ASL A                                ;84FF99|0A      |      ;  
		AND.W #$03C0                         ;84FF9A|29C003  |      ;  
		ORA.B $06				; RAM_X_event_slot_event_slot_health;84FF9D|0506    |000006;  
		ASL A                                ;84FF9F|0A      |      ;  
		TAX                                  ;84FFA0|AA      |      ;  
		LDA.W #$0001                         ;84FFA1|A90100  |      ;  
		STA.L $7E4000,X                      ;84FFA4|9F00407E|7E4000;  
		STA.L $7E4002,X                      ;84FFA8|9F02407E|7E4002;  
		STA.L $7E4040,X                      ;84FFAC|9F40407E|7E4040;  
		STA.L $7E4042,X                      ;84FFB0|9F42407E|7E4042;  
		RTL                                  ;84FFB4|6B      |      ;  

	SimonState00_respawnL:						; moved to make space 					
		STZ.W RAM_81_simonSlot_StateBackUp   ;80A249|9C5605  |810556;  
        STZ.W $1FA4                          ;80A24C|9CA41F  |811FA4;  
        STZ.W RAM_81_simonSlot_SpeedSubXpos  ;80A24F|9C5805  |810558;  
        STZ.W RAM_81_simonSlot_SpeedXpos     ;80A252|9C5A05  |81055A;  
        STZ.W RAM_81_simonSlot_SpeedSubYpos  ;80A255|9C5C05  |81055C;  
        STZ.W RAM_81_simonSlot_SpeedYpos     ;80A258|9C5E05  |81055E;  
        STZ.W RAM_81_simonSlot_SubAnimationCounter;80A25B|9C6205  |810562;  
        STZ.W $0564                          ;80A25E|9C6405  |810564;  
        STZ.W $1F86                          ;80A261|9C861F  |811F86;  
        STZ.W $057E                          ;80A264|9C7E05  |81057E;  
        STZ.W $1FA0                          ;80A267|9CA01F  |811FA0;  
        LDA.W #$0003                         ;80A26A|A90300  |      ;  
        STA.W $1FA0                          ;80A26D|8DA01F  |811FA0;  
        LDA.W #$001B                         ;80A270|A91B00  |      ;  
        STA.W RAM_81_simonSlot_Collusion_Donno01;80A273|8D7605  |810576;  
        STZ.W $1F88                          ;80A276|9C881F  |811F88;  
        LDA.W #$0001                         ;80A279|A90100  |      ;  
        STA.W RAM_81_simonSlot_State         ;80A27C|8D5205  |810552;  
		rtl 

; -------------------------------------------
	-	rtl 
simonSpriteDMAPointerToo1b00: 
		REP #$30                             ;80C5BF|C230    |      ;  
		LDA.W RAM_81_simonSlot_AnimationCounter;80C5C1|AD6005  |810560;  
		BEQ -                      ;80C5C4|F0F8    |80C5BE;  
		ASL A                                ;80C5C6|0A      |      ;  
		ASL A                                ;80C5C7|0A      |      ;  
		ASL A                                ;80C5C8|0A      |      ;  
		ASL A                                ;80C5C9|0A      |      ;  
		CLC                                  ;80C5CA|18      |      ;  
		ADC.W #dmaBaseSimon                       ;80C5CB|693682  |      ; add basepointer at bank 84
		TAY                                  ;80C5CE|A8      |      ;  
		SEP #$20                             ;80C5CF|E220    |      ;  
		LDA.B #$ff       ; fixed bank at ff  rewrite to store long..              ;80C5D1|A984    |      ;  
		PHA                                  ;80C5D3|48      |      ;  
		PLB                                  ;80C5D4|AB      |      ;  
		REP #$20                             ;80C5D5|C220    |      ;  
		LDA.W $0000,Y                        ;80C5D7|B90000  |840000;  
		STA.L $7E1B00                          ;80C5DA|8D001B  |841B00;  
		CLC                                  ;80C5DD|18      |      ;  
		ADC.W #$0200                         ;80C5DE|690002  |      ;  
		STA.L $7E1B10                          ;80C5E1|8D101B  |841B10;  
		LDA.W $0002,Y                        ;80C5E4|B90200  |840002;  
		STA.L $7E1B02                          ;80C5E7|8D021B  |841B02;  
		CLC                                  ;80C5EA|18      |      ;  
		ADC.W #$0200                         ;80C5EB|690002  |      ;  
		STA.L $7E1B12                          ;80C5EE|8D121B  |841B12;  
		LDA.W $0004,Y                        ;80C5F1|B90400  |840004;  
		STA.L $7E1B04                          ;80C5F4|8D041B  |841B04;  
		CLC                                  ;80C5F7|18      |      ;  
		ADC.W #$0200                         ;80C5F8|690002  |      ;  
		STA.L $7E1B14                          ;80C5FB|8D141B  |841B14;  
		LDA.W $0006,Y                        ;80C5FE|B90600  |840006;  
		STA.L $7E1B06                          ;80C601|8D061B  |841B06;  
		CLC                                  ;80C604|18      |      ;  
		ADC.W #$0200                         ;80C605|690002  |      ;  
		STA.L $7E1B16                          ;80C608|8D161B  |841B16;  
		LDA.W $0008,Y                        ;80C60B|B90800  |840008;  
		STA.L $7E1B08                          ;80C60E|8D081B  |841B08;  
		CLC                                  ;80C611|18      |      ;  
		ADC.W #$0200                         ;80C612|690002  |      ;  
		STA.L $7E1B18                          ;80C615|8D181B  |841B18;  
		LDA.W $000A,Y                        ;80C618|B90A00  |84000A;  
		STA.L $7E1B0A                          ;80C61B|8D0A1B  |841B0A;  
		CLC                                  ;80C61E|18      |      ;  
		ADC.W #$0200                         ;80C61F|690002  |      ;  
		STA.L $7E1B1A                          ;80C622|8D1A1B  |841B1A;  
		LDA.W $000C,Y                        ;80C625|B90C00  |84000C;  
		STA.L $7E1B0C                          ;80C628|8D0C1B  |841B0C;  
		CLC                                  ;80C62B|18      |      ;  
		ADC.W #$0200                         ;80C62C|690002  |      ;  
		STA.L $7E1B1C                          ;80C62F|8D1C1B  |841B1C;  
		LDA.W $000E,Y                        ;80C632|B90E00  |84000E;  
		STA.L $7E1B0E                          ;80C635|8D0E1B  |841B0E;  
		CLC                                  ;80C638|18      |      ;  
		ADC.W #$0200                         ;80C639|690002  |      ;  
		STA.L $7E1B1E                          ;80C63C|8D1E1B  |841B1E;  
		SEP #$20                             ;80C63F|E220    |      ;  
		LDA.B #$81                           ;80C641|A981    |      ;  
		PHA                                  ;80C643|48      |      ;  
		PLB                                  ;80C644|AB      |      ;  
		REP #$20                             ;80C645|C220    |      ;  
		RTL   
	dmaBaseSimon:
		dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	SimonWalk1:
		dw $0000,$0040,$0080,$00C0,$0100,$0140,$0000,$0000	;$1 
	SimonWalk2:                                             ;
		dw $0180,$01C0,$0400,$0440,$0480,$04C0,$0000,$0000  ;$2 
	SimonWalk3:                                             ;
		dw $0500,$0540,$0580,$05C0,$0800,$0840,$0000,$0000  ;$3 
	SimonWalk4:                                             ;
		dw $0880,$08C0,$0900,$0940,$0980,$09C0,$0000,$0000  ;$4 
	SimonWalk5:                                             ;
		dw $0500,$0540,$0C00,$0C40,$0C80,$0CC0,$0000,$0000  ;$5 
	SimonWalk6:                                             ;
		dw $0180,$01C0,$0D00,$0D40,$0D80,$0DC0,$0000,$0000  ;$6 
															
	Crouch1:                                                ;
		dw $0000,$0040,$3400,$3440,$3480,$34C0,$0000,$0000  ;$7 
	Crouch2:                                                ;
		dw $0180,$01C0,$3500,$3540,$3580,$35C0,$0000,$0000  ;$8 
	Crouch3:                                                ;
		dw $0500,$0540,$3800,$3840,$3880,$38C0,$0000,$0000  ;$9 
	Crouch4:                                                ;
		dw $0880,$08C0,$3900,$3940,$3980,$39C0,$0000,$0000  ;$a 
	Crouch5:                                                ;
		dw $0500,$0540,$3C00,$3C40,$3C80,$3CC0,$0000,$0000  ;$b 
	Crouch6:                                                ;
		dw $0180,$01C0,$3D00,$3D40,$3D80,$3DC0,$0000,$0000  ;$c 
															
	WhipWindup1:                                            ;
		dw $4000,$4040,$4080,$40C0,$4100,$4140,$0000,$0000  ;$d 
	WhipWindup2:                                            ;
		dw $4180,$41C0,$4400,$4440,$4480,$44C0,$4500,$4540  ;$e 
	Whip:                                                   ;
		dw $4580,$45C0,$4800,$4840,$4880,$48C0,$0000,$0000  ;$f 
															;
	WhipDiUpWindup:                                         ;
		dw $4900,$4940,$4980,$49C0,$4C00,$4C40,$0000,$0000  ;$10
	WhipDiUp:                                               ;
		dw $4D00,$4C80,$4CC0,$4800,$4840,$4880,$48C0,$0000  ;$11
															
	WhipUp:                                                 ;
		dw $4D40,$4D80,$4DC0,$5000,$5040,$5080,$50C0,$0000  ;$12
	AirWhipDownWindup1:                                     ;
		dw $5100,$5140,$5180,$51C0,$5400,$5440,$0000,$0000  ;$13
	AirWhipDownWindup2:                                     ;
		dw $5480,$54C0,$5500,$5540,$5580,$55C0,$5800,$0000  ;$14
	AirWhipDown:                                            ;
		dw $5840,$5880,$58C0,$5900,$5940,$5980,$0000,$0000  ;$15
	AirWhipDiDown:                                          ;
		dw $5840,$5880,$5C80,$5CC0,$5D00,$5D40,$0000,$0000  ;$16
															
	LimpDown:                                               ;
		dw $5D80,$5DC0,$6000,$6040,$0100,$0140,$0000,$0000  ;$17
	LimpDiDown:                                             ;
		dw $6080,$60C0,$0080,$6100,$0100,$0140,$0000,$0000  ;$18
	LimpRight:                                              ;
		dw $6080,$6140,$6180,$0080,$61C0,$6400,$0100,$0140  ;$19
	LimpDiUp:                                               ;
		dw $6080,$6440,$0080,$6480,$0100,$0140,$0000,$0000  ;$1a
	LimpUp:
		dw $64C0,$6080,$6500,$0080,$6480,$0100,$0140,$0000  ;$1b
															
	WhipCrouchWindup1:                                      ;
		dw $4000,$4040,$B400,$B440,$B480,$B4C0,$0000,$0000  ;$1c
	WhipCrouchWindup2:                                      ;
		dw $4180,$41C0,$B500,$B540,$B580,$B5C0,$0000,$0000  ;$1d
	WhipCrouch:                                             ;
		dw $B900,$B940,$B980,$B800,$B840,$B880,$B8C0,$0000  ;$1e
															
	LimpCrouchDown:                                         ;
		dw $5D80,$5DC0,$6540,$6580,$3480,$34C0,$0000,$0000  ;$1f
	LimpCrouchDiDown:                                       ;
		dw $6080,$60C0,$3400,$65C0,$3480,$34C0,$0000,$0000  ;$20
	LimpCrouchRight:                                        ;
		dw $6080,$6140,$6180,$3400,$6800,$6400,$3480,$34C0  ;$21
	LimpCrouchDiUp:                                         ;
		dw $6080,$6440,$3400,$6840,$3480,$34C0,$0000,$0000  ;$22
	LimpCrouchUp:                                           ;
		dw $64C0,$6080,$6500,$3400,$6840,$3480,$34C0,$0000  ;$23
															
	SwingRight:                                             ;
		dw $9900,$99C0,$9980,$9940,$9C40,$9C00,$0000,$0000  ;$24
	SwingRightDown:	                                        ;
		dw $9580,$9800,$95C0,$9880,$9840,$98C0,$0000,$0000  ;$25
	SwingDown:	                                            ;
		dw $9440,$9480,$94C0,$9500,$9540,$0000,$0000,$0000  ;$26
	SwingLeftDown:                                          ;
		dw $90C0,$9140,$9100,$91C0,$9180,$9400,$0000,$0000  ;$27
	SwingLeft:	                                            ;
		dw $8D40,$8D00,$8CC0,$9000,$8DC0,$8D80,$9080,$9040  ;$28
	
	StairUp1:
		dw $1000,$1040,$1080,$10C0,$1100,$0000,$0000,$0000  ;$29
	StairUp2:                                               ;
		dw $1140,$1180,$11C0,$1400,$1440,$1480,$14C0,$1500  ;$2a
	StairUp3:                                               ;
		dw $1540,$1580,$15C0,$1800,$1840,$1880,$18C0,$0000  ;$2b
	StairUp4:                                               ;
		dw $1900,$1940,$1980,$19C0,$1C00,$1C40,$0000,$0000  ;$2c
	StairUp5:                                               ;
		dw $1C80,$1CC0,$1D00,$1D40,$1D80,$1DC0,$2000,$0000  ;$2d
	StairUp6:                                               ;
		dw $2040,$2080,$20C0,$0000,$0000,$0000,$0000,$0000  ;$2e
															
	StairDown1:	                                            ;
		dw $2100,$2140,$2180,$21C0,$2400,$2440,$0000,$0000  ;$2f
	StairDown2:	                                            ;
		dw $2480,$24C0,$2500,$2540,$2580,$25C0,$0000,$0000  ;$30
	StairDown3:	                                            ;
		dw $2800,$2840,$2880,$28C0,$2900,$2940,$0000,$0000  ;$31
	StairDown4:	                                            ;
		dw $2980,$29C0,$2C00,$2C40,$2C80,$2CC0,$0000,$0000  ;$32
	StairDown5:	                                            ;
		dw $2D00,$2D40,$2D80,$2DC0,$3000,$3040,$0000,$0000  ;$33
	StairDown6:	                                            ;
		dw $3080,$30C0,$3100,$3140,$3180,$31C0,$0000,$0000  ;$34
															
	StairsUpWhipWindup1:                                    ;
		dw $4000,$4040,$7180,$71C0,$7400,$7440,$0000,$0000  ;$35
	StairsUpWhipWindup2:                                    ;
		dw $4180,$41C0,$4400,$7480,$74C0,$7500,$7540,$0000  ;$36
	StairsUpWhip:                                           ;
		dw $4580,$C440,$7580,$75C0,$7800,$0000,$0000,$0000  ;$37
															
	StairsDownWhipWindup1:	                                ;
		dw $4000,$4040,$7980,$79C0,$7C00,$7C40,$0000,$0000  ;$38
	StairsDownWhipWindup2:	                                ;
		dw $7C80,$7CC0,$7D00,$7D40,$7D80,$7DC0,$8000,$0000  ;$39
	StairsDownWhip:	                                        ;
		dw $8040,$8080,$80C0,$7D40,$7D80,$7DC0,$8000,$0000  ;$3a
															
	StarisUpDiWindup1:                                      ;
		dw $4900,$4940,$7840,$71C0,$7400,$7440,$0000,$0000  ;$3b
	StarisUpDiUp:                                      
		dw $C480,$4C80,$4CC0,$7580,$75C0,$7800,$0000,$0000  ;$3c
	StairsUpWhipUp:                                         ;
		dw $C4C0,$4D80,$4DC0,$7880,$78C0,$7900,$7940,$0000  ;$3d
															
	StairsDownWhipDiWindupUp1:                              ;Same as 38
		dw $4000,$4040,$7980,$79C0,$7C00,$7C40,$0000,$0000  ;$3e
	StairsDownWhipDiWindupUp2:                                  ;
		dw $8100,$8140,$8180,$7D80,$7DC0,$8000,$0000,$0000  ;$3f
	StairsDownWhipDi:                                       ;
		dw $81C0,$8400,$8440,$8480,$84C0,$8500,$0000,$0000  ;$40
															
	StairsUpLimpDown:                                       ;
		dw $5D80,$5DC0,$6000,$8540,$8580,$85C0,$0000,$0000  ;$41
	StairsUpLimpDiDown:                                     ;
		dw $6080,$60C0,$0080,$8800,$8580,$85C0,$0000,$0000  ;$42
	StairsUpLimpRight:                                      ;
		dw $6080,$6140,$6180,$0080,$8840,$6400,$8580,$85C0  ;$43
	StairsUpLimpDiUp:                                       ;
		dw $6080,$6440,$0080,$8880,$8580,$85C0,$0000,$0000  ;$44
	StairsUpLimpUp:                                         ;
		dw $64C0,$6080,$6500,$0080,$8880,$8580,$85C0,$0000  ;$45
															
	StairsDownLimpUp:                                       ;
		dw $64C0,$6080,$6500,$88C0,$8900,$8940,$8980,$0000  ;$46
	StairsDownLimpDiUp:                                     ;
		dw $6080,$6440,$88C0,$8900,$8940,$8980,$0000,$0000  ;$47
	StairsDownLimpRight:                                    ;
		dw $6080,$6140,$6180,$88C0,$89C0,$6400,$8940,$8980  ;$48
	StairsDownLimpDiDown:                                   ;
		dw $6080,$60C0,$88C0,$8C00,$8940,$8980,$0000,$0000  ;$49
	StairsDownLimpDown:                                     ;
		dw $5D80,$5DC0,$8C40,$8C80,$8940,$8980,$0000,$0000  ;$4a
															
	AirWhipWindup1:                                         ;
		dw $B9C0,$BC00,$BC40,$BC80,$BCC0,$BD00,$0000,$0000  ;$4b
	AirWhipWindup2:                                         ;
		dw $BD40,$BD80,$BDC0,$C000,$C040,$BC80,$BCC0,$BD00  ;$4c
	AirWhipUp:                                              ;
		dw $C080,$C0C0,$C100,$C140,$C180,$C1C0,$C400,$0000  ;$4d
															
	Hurt:                                                   ;
		dw $6880,$68C0,$6900,$6940,$6980,$69C0,$0000,$0000  ;$4e
	Death1:                                                 ;
		dw $6C00,$6C40,$6C80,$6CC0,$0000,$0000,$0000,$0000  ;$4f
	Death2:                                                 ;
		dw $6D00,$6D40,$6D80,$6DC0,$7000,$0000,$0000,$0000  ;$50
	Death3:                                                 ;
		dw $7040,$7080,$70C0,$7100,$7140,$0000,$0000,$0000  ;$51
															
	SwingRightThrow1:                                       ;
		dw $B080,$99C0,$9980,$9940,$9C40,$9C00,$0000,$0000  ;$52
	SwingRightThrow2:                                       ;
		dw $9900,$99C0,$9980,$B100,$B0C0,$9C40,$9C00,$0000  ;$53
	SwingRightThrow3:                                       ;
		dw $9900,$B140,$99C0,$9980,$B1C0,$B180,$9C40,$9C00  ;$54
	SwingRightDownThrow1:                                   ;
		dw $ACC0,$9800,$95C0,$9880,$9840,$98C0,$0000,$0000  ;$55
	SwingRightDownThrow2:                                   ;
		dw $9580,$9800,$AD40,$AD00,$9880,$9840,$98C0,$0000  ;$56
	SwingRightDownThrow3:                                   ;
		dw $ADC0,$AD80,$9800,$B040,$B000,$9880,$9840,$98C0  ;$57
	SwingDownThrow1:                                        ;
		dw $9440,$A900,$A940,$9500,$9540,$0000,$0000,$0000  ;$58
	SwingDownThrow2:                                        ;
		dw $9440,$9480,$A9C0,$A980,$9500,$9540,$0000,$0000  ;$59
	SwingDownThrow3:                                        ;
		dw $9440,$AC40,$AC00,$AC80,$9500,$9540,$0000,$0000  ;$5a
	SwingLeftDownThrow1:	                                ;
		dw $A1C0,$A180,$A440,$A400,$A480,$A4C0,$0000,$0000  ;$5b
	SwingLeftDownThrow2:	                                ;
		dw $A540,$A500,$A800,$A5C0,$A580,$A480,$A4C0,$0000  ;$5c
	SwingLeftDownThrow3:	                                ;
		dw $A880,$A840,$A800,$A8C0,$A480,$A4C0,$0000,$0000  ;$5d
	SwingLeftThrow1:                                        ;
		dw $9C80,$9D00,$9CC0,$9000,$8DC0,$8D80,$9080,$9040   ;$5e
	SwingLeftThrow2:                                        ;
		dw $9D00,$A0C0,$A080,$9000,$8DC0,$8D80,$9080,$9040   ;$5f
	SwingLeftThrow3:                                        ;
		dw $A100,$9D00,$A140,$9000,$8DC0,$8D80,$9080,$9040   ;$60
	;	dw $8D40,$8D00,$8CC0,$9000,$8DC0,$8D80,$9080,$9040  ;$28													
	LimpIdle:                                               ;
		dw $6080,$C500,$C540,$0080,$00c0,$0100,$0140,$0000  ;$61
	LimpCrouchIdle:                                         ;
		dw $0000,$C500,$C540,$3400,$3440,$3480,$34C0,$0000  ;$62
	StairsUpLimpIdle:                                       ;
		dw $C5C0,$C800,$D5C0,$C840,$1100,$0000,$0000,$0000  ;$63
	StairsDownLimpIdle:                                     ;
		dw $C880,$C8C0,$2180,$C900,$2400,$2440,$0000,$0000  ;$64
															
	Air:                                                    ;
		dw $0000,$0040,$C940,$C980,$C9C0,$CC00,$0000,$0000  ;$65
	AirWindup:                                          ;
		dw $4000,$4040,$C940,$C980,$C9C0,$CC00,$0000,$0000  ;$66
	AirWhip:                                                ;
		dw $B900,$B940,$B980,$C940,$C980,$C9C0,$CC00,$0000  ;$67
	AirLimpDown:                                            ;
		dw $5D80,$5DC0,$CD40,$CD80,$C9C0,$CC00,$0000,$0000  ;$68
	AirLimpDiDown:                                          ;
		dw $6080,$60C0,$C940,$CDC0,$C9C0,$CC00,$0000,$0000  ;$69
	AirLimpForward:                                         ;
		dw $6080,$6140,$6180,$C940,$D000,$6400,$C9C0,$CC00  ;$6a
	AirLimpDiUp: 	                                        ;
		dw $6080,$6440,$C940,$C980,$C9C0,$CC00,$0000,$0000  ;$6b
	AirLimpUp:                                              ;
		dw $64C0,$6080,$6500,$C940,$C980,$C9C0,$CC00,$0000  ;$6c
															
	AirWhipDiUp:                                            ;
		dw $BD40,$BD80,$BDC0,$C000,$C940,$C980,$C9C0,$CC00  ;$6d
	AirWhipUp2:                                             ;
		dw $C080,$C0C0,$C100,$D080,$C980,$C9C0,$CC00,$0000  ;$6e
	AirWhipUpWindup1:                                        ;
		dw $4180,$41C0,$CC40,$CC80,$CCC0,$CD00,$D040,$0000  ;$6f
	AirWhipDiUpWindup2:                                     ;
		dw $B9C0,$BC00,$BC40,$BC80,$BCC0,$BD00,$0000,$0000  ;$70
	AirLimpIdle:                                            ;
		dw $6080,$C500,$C940,$C980,$C9C0,$CC00,$0000,$0000  ;$71
	Idle:                                                   ;
		dw $0000,$0040,$0080,$00C0,$0100,$0140,$0000,$0000
	;	dw $D800,$D400,$D440,$D480,$D4C0,$D500,$0000,$0000  ;$72 same as $01
	IdleNearHole:                                           ;
		dw $0000,$0040,$D180,$D1C0,$D540,$D580,$0000,$0000  ;$73   
	
	Idle00:                                           ;
		dw $d400,$d440,$d800,$d840,$dc00,$dc40,$0000,$0000  ;$74 	
	Idle01:                                           ;
		dw $d4c0,$d500,$d8c0,$d900,$dcc0,$dd00,$0000,$0000  ;$75 	
	Idle02:                                           ;
		dw $d0c0,$d100,$d140,$d880,$dc80,$c580,$0000,$0000  ;$76 			
		
}

; ------------------------- hijack simonStates  ---------------------
;org $80A95D
;; simonJumpStateTable: 
;		dw simonJumpState00                  ;80A95D|        |80A96B;  
;		dw simonJumpState01                  ;80A95F|        |80A983;  
;		dw simonJumpState02                  ;80A961|        |80A989;  
;		dw simonJumpState03                  ;80A963|        |80A99F;  
;		dw simonJumpState04                  ;80A965|        |80A9AE;  
;		dw simonJumpState05                  ;80A967|        |80A9C0;  
;		dw simonJumpState06                  ;80A969|        |80A9C9;  	
;		dw simonAirRoutine
;	simonJumpState00:	
;		jsl simonJumpState00Long		
;		rtl 
;	simonAirRoutine:
;		jsl simonGradiousState
;		rtl 
;warnPC $80A982		
;
;org $80A983
;		simonJumpState01:
;org $80A989
;		simonJumpState02:
;org $80A99F
;		simonJumpState03:
;org $80A9AE		
;		simonJumpState04:
;org $80A9C0
;		simonJumpState05:
;org $80A9C9 
;		simonJumpState06:
;	


;;	 simonGradiousState:
;;			
;;			rtl 
;;
;;	 simonJumpState00Long: 					; movet to make space 
;;			LDA.B RAM_X_event_slot_20            ;80A96B|A520    |000020;  
;;            BIT.B RAM_buttonMapJump              ;80A96D|24BE    |0000BE;  
;;            BEQ +                    ;80A96F|F00B    |80A97C;  
;;            INC.W $0564                          ;80A971|EE6405  |810564;  
;;            LDA.W $0564                          ;80A974|AD6405  |810564;  
;;            CMP.W #$0004                         ;80A977|C90400  |      ;  
;;            BCC ++                     ;80A97A|9022    |80A99E;  
;;         +  LDA.W #$0001                         ;80A97C|A90100  |      ;  
;;            STA.W $1F86                          ;80A97F|8D861F  |811F86;  
;;         ++ RTL  
;;	
	


; trash 
;		LDA.B $12,X                          ;82C2B0|B512    |000012;  
;        BNE stateHandler                      ;82C2B2|D051    |82C305;  
;        LDY.W #$A701                         ;82C2B4|A001A7  |      ;  
;        LDA.B $86                            ;82C2B7|A586    |000086;  
;        CMP.W #$0017                         ;82C2B9|C91700  |      ;  
;        BEQ +                      ;82C2BC|F00B    |82C2C9;  
;        LDY.W #$A6EF                         ;82C2BE|A0EFA6  |      ;  
;        CMP.W #$0023                         ;82C2C1|C92300  |      ;  
;        BCC +                      ;82C2C4|9003    |82C2C9;  
;        LDY.W #$A6F8                         ;82C2C6|A0F8A6  |      ;  
;      
;	  + STY.B $00,X                          ;82C2C9|9400    |000000;  
;        LDA.W #$0003                         ;82C2CB|A90300  |      ;  
;        STA.B $2C,X                          ;82C2CE|952C    |00002C;  
;        INC.B $12,X                          ;82C2D0|F612    |000012;  
;        LDA.W #$C1BF                         ;82C2D2|A9BFC1  |      ;  
;        STA.B $00                            ;82C2D5|8500    |000000;  
;
;      - LDA.B $14,X                          ;82C2D7|B514    |000014; used 62 moving Spike,
;		bit #$000f							; fix hijack and expansion 
;		ASL A                                ;82C2D9|0A      |      ;  
;        TAY                                  ;82C2DA|A8      |      ;  
;        LDA.B ($00),Y                        ;82C2DB|B100    |000000;  
;        STA.B $3E,X                          ;82C2DD|953E    |00003E;  
;		
;	floPlaSpeedHandler: 
;		LDY.B $3E,X                          ;82C2DF|B43E    |00003E;  
;        LDA.W $0000,Y                        ;82C2E1|B90000  |810000;  
;        STA.B $3C,X                          ;82C2E4|953C    |00003C;  
;        INC A                                ;82C2E6|1A      |      ;  
;        BEQ -                      ;82C2E7|F0EE    |82C2D7;  
;        LDA.W $0002,Y                        ;82C2E9|B90200  |810002;  
;        STA.B $18,X                          ;82C2EC|9518    |000018;  
;        LDA.W $0004,Y                        ;82C2EE|B90400  |810004;  
;        STA.B $1A,X                          ;82C2F1|951A    |00001A;  
;        LDA.W $0006,Y                        ;82C2F3|B90600  |810006;  
;        STA.B $1C,X                          ;82C2F6|951C    |00001C;  
;        LDA.W $0008,Y                        ;82C2F8|B90800  |810008;  
;        STA.B $1E,X                          ;82C2FB|951E    |00001E;  
;        TYA                                  ;82C2FD|98      |      ;  
;        CLC                                  ;82C2FE|18      |      ;  
;        ADC.W #$000A                         ;82C2FF|690A00  |      ;  
;        STA.B $3E,X                          ;82C302|953E    |00003E;  
;        rtl                        			 ;82C304|6B      |      ;  
;	stateHandler:		
;		jsl surfBord 
;		DEC.B $3C,X                          ;82C305|D63C    |00003C;  
;        BNE +                      ;82C307|D009    |82C312;  
;        LDA.W #$C1BF                         ;82C309|A9BFC1  |      ;  
;        STA.B $00                            ;82C30C|8500    |000000;  
;        JSL.L floPlaSpeedHandler                    ;82C30E|22DFC282|82C2DF;  
;+
;	    LDA.W #$001B                         ;82C312|A91B00  |      ;  
;        LDY.W $0552                          ;82C315|AC5205  |810552;  
;        CPY.W #$0008                         ;82C318|C00800  |      ;  
;        BEQ CODE_82C38D                      ;82C31B|F070    |82C38D;  
;        CPY.W #$000F                         ;82C31D|C00F00  |      ;  
;        BEQ CODE_82C38D                      ;82C320|F06B    |82C38D;  
;        CPY.W #$0006                         ;82C322|C00600  |      ;  
;        BNE CODE_82C32A                      ;82C325|D003    |82C32A;  
;        LDA.W #$000F                         ;82C327|A90F00  |      ;  
;    
;	CODE_82C32A: 
;		STA.B $02                            ;82C32A|8502    |000002;  
;        CPX.W $13C8                          ;82C32C|ECC813  |8113C8;  
;        BNE CODE_82C38E                      ;82C32F|D05D    |82C38E;  
;        LDY.W $13D0                          ;82C331|ACD013  |8113D0;  
;        LDA.B $0E,X                          ;82C334|B50E    |00000E;  
;        SEC                                  ;82C336|38      |      ;  
;        SBC.W $0018,Y                        ;82C337|F91800  |810018;  
;        CMP.W #$00E0                         ;82C33A|C9E000  |      ;  
;        BCS CODE_82C385                      ;82C33D|B046    |82C385;  
;        LDA.W $0558                          ;82C33F|AD5805  |810558;  
;        ORA.W $055A                          ;82C342|0D5A05  |81055A;  
;        BNE CODE_82C34C                      ;82C345|D005    |82C34C;  
;        LDA.B $08,X                          ;82C347|B508    |000008;  
;        STA.W $0548                          ;82C349|8D4805  |810548;  
;    CODE_82C34C: 
;		LDA.W $0558                          ;82C34C|AD5805  |810558;  
;        CLC                                  ;82C34F|18      |      ;  
;        ADC.B $18,X                          ;82C350|7518    |000018;  
;        STA.W $0558                          ;82C352|8D5805  |810558;  
;        LDA.W $055A                          ;82C355|AD5A05  |81055A;  
;        ADC.B $1A,X                          ;82C358|751A    |00001A;  
;        STA.W $055A                          ;82C35A|8D5A05  |81055A;  
;        LDA.B $0E,X                          ;82C35D|B50E    |00000E;  
;        SEC                                  ;82C35F|38      |      ;  
;        SBC.B $2A,X                          ;82C360|F52A    |00002A;  
;        SEC                                  ;82C362|38      |      ;  
;        SBC.B $02                            ;82C363|E502    |000002;  
;        STA.W $054E                          ;82C365|8D4E05  |81054E;  
;        LDA.B $0C,X                          ;82C368|B50C    |00000C;  
;        STA.W $054C                          ;82C36A|8D4C05  |81054C;  
;        LDA.B $28,X                          ;82C36D|B528    |000028;  
;        CLC                                  ;82C36F|18      |      ;  
;        ADC.W #$000A                         ;82C370|690A00  |      ;  
;        STA.B $00                            ;82C373|8500    |000000;  
;        LDA.B $0A,X                          ;82C375|B50A    |00000A;  
;        SEC                                  ;82C377|38      |      ;  
;        SBC.W $054A                          ;82C378|ED4A05  |81054A;  
;        BPL CODE_82C381                      ;82C37B|1004    |82C381;  
;        EOR.W #$FFFF                         ;82C37D|49FFFF  |      ;  
;        INC A                                ;82C380|1A      |      ;  
;    CODE_82C381: 
;		CMP.B $00                            ;82C381|C500    |000000;  
;        BCC CODE_82C38D                      ;82C383|9008    |82C38D;  
;    CODE_82C385: 
;		LDA.W #$0009                         ;82C385|A90900  |      ;  
;        STZ.W $13C8                          ;82C388|9CC813  |8113C8;  
;        STZ.B $80                            ;82C38B|6480    |000080;  
;    
;	CODE_82C38D: RTL                                  ;82C38D|6B      |      ;  
;          
;	CODE_82C38E: 
;		LDA.W $055E                          ;82C38E|AD5E05  |81055E;  
;        BMI CODE_82C38D                      ;82C391|30FA    |82C38D;  
;        LDA.W $0542                          ;82C393|AD4205  |810542;  
;        CMP.B $02,X                          ;82C396|D502    |000002;  
;        BNE CODE_82C38D                      ;82C398|D0F3    |82C38D;  
;        LDY.W $13D0                          ;82C39A|ACD013  |8113D0;  
;        LDA.B $0E,X                          ;82C39D|B50E    |00000E;  
;        SEC                                  ;82C39F|38      |      ;  
;        SBC.W $0018,Y                        ;82C3A0|F91800  |810018;  
;        CMP.W #$00E0                         ;82C3A3|C9E000  |      ;  
;        BCS CODE_82C38D                      ;82C3A6|B0E5    |82C38D;  
;        LDA.B $28,X                          ;82C3A8|B528    |000028;  
;        CLC                                  ;82C3AA|18      |      ;  
;        ADC.W #$000A                         ;82C3AB|690A00  |      ;  
;        STA.B $00                            ;82C3AE|8500    |000000;  
;        LDA.B $0A,X                          ;82C3B0|B50A    |00000A;  
;        SEC                                  ;82C3B2|38      |      ;  
;        SBC.W $054A                          ;82C3B3|ED4A05  |81054A;  
;        BPL CODE_82C3BC                      ;82C3B6|1004    |82C3BC;  
;        EOR.W #$FFFF                         ;82C3B8|49FFFF  |      ;  
;        INC A                                ;82C3BB|1A      |      ;  
;    
;	CODE_82C3BC: 
;		CMP.B $00                            ;82C3BC|C500    |000000;  
;        BCS CODE_82C38D                      ;82C3BE|B0CD    |82C38D;  
;        LDA.B $02                            ;82C3C0|A502    |000002;  
;        CLC                                  ;82C3C2|18      |      ;  
;        ADC.B $2A,X                          ;82C3C3|752A    |00002A;  
;        STA.B $00                            ;82C3C5|8500    |000000;  
;        LDA.B $0E,X                          ;82C3C7|B50E    |00000E;  
;        SEC                                  ;82C3C9|38      |      ;  
;        SBC.W $054E                          ;82C3CA|ED4E05  |81054E;  
;        BMI CODE_82C38D                      ;82C3CD|30BE    |82C38D;  
;        CMP.B $00                            ;82C3CF|C500    |000000;  
;        BCS CODE_82C38D                      ;82C3D1|B0BA    |82C38D;  
;        ADC.W #$000A                         ;82C3D3|690A00  |      ;  
;        CMP.B $00                            ;82C3D6|C500    |000000;  
;        BCC CODE_82C38D                      ;82C3D8|90B3    |82C38D;  
;        INC.B $80                            ;82C3DA|E680    |000080;  
;        STX.W $13C8                          ;82C3DC|8EC813  |8113C8;  
;        LDA.B $0E,X                          ;82C3DF|B50E    |00000E;  
;        SEC                                  ;82C3E1|38      |      ;  
;        SBC.B $2A,X                          ;82C3E2|F52A    |00002A;  
;        SEC                                  ;82C3E4|38      |      ;  
;        SBC.B $02                            ;82C3E5|E502    |000002;  
;        STA.W $054E                          ;82C3E7|8D4E05  |81054E;  
;        LDA.W #$0005                         ;82C3EA|A90500  |      ;  
;        STA.W $0552                          ;82C3ED|8D5205  |810552;  
;        RTL                                  ;82C3F0|6B      |      ;  


; ------ old job.asm





;org $80C09f
;		jsl newWhipMechanic					; I started to dislike the idea to make whip directions to a upgrade. It would also be some work and probalby lame!
;		rts

		
;org $81930B	
;	whipDirection01TableIndex:				; ground 
;		dw $0B00,$0B00,$0300,$0F00 
;org $81931F
;	whipDirection02TableIndex:
;		dw $0002,$000D
;org $819323
;	whipDirection03TableIndex:
;		dw $FFFF,$0002,$FFFF,$FFFF
;org $819343
;	whipDirection04TableIndex:
;		dw $FFFF,$FFFF,$000D,$FFFF
;		
;pullPC 		
;	newWhipMechanic:
;		LDA.W $057E                          ;80C09F|AD7E05  |81057E;  
;		ASL A                                ;80C0A2|0A      |      ;  
;		TAY                                  ;80C0A3|A8      |      ;  
;		LDA.B $0020                			 ;80C0A4|A520    |000020;  RAM_buttonPress 
;		AND.W whipDirection01TableIndex,Y    ;80C0A6|390B93  |81930B;  				
;		XBA                                  ;80C0A9|EB      |      ;  
;		ASL A                                ;80C0AA|0A      |      ;  
;		TAY                                  ;80C0AB|A8      |      ;  
;		LDA.W $0578						     ;80C0AC|AD7805  |810578;  RAM_81_simonSlot_direction
;		BNE CODE_80C0C4                      ;80C0AF|D013    |80C0C4;  
;		LDA.W whipDirection03TableIndex,Y    ;80C0B1|B92393  |819323;  
;		BMI CODE_80C0BA                      ;80C0B4|3004    |80C0BA;  
;		STA.W $03BA                          ;80C0B6|8DBA03  |8103BA;  
;		rtl                                  ;80C0B9|60      |      ;  
;     CODE_80C0BA: 
;		LDA.W $0578						     ;80C0AC|AD7805  |810578;  RAM_81_simonSlot_direction 
;        LDA.W whipDirection02TableIndex,Y    ;80C0BD|B91F93  |81931F;  
;        STA.W $03BA                          ;80C0C0|8DBA03  |8103BA;  
;        rtl                                  ;80C0C3|60      |      ;  
;     CODE_80C0C4: 
;		LDA.W whipDirection04TableIndex,Y    ;80C0C4|B94393  |819343;  
;        BMI CODE_80C0BA                      ;80C0C7|30F1    |80C0BA;  
;        STA.W $03BA                          ;80C0C9|8DBA03  |8103BA;  
;        rtl             

; 		whip upgrade gives power behavier
;		double tripple give leangth
;pushPC

;	newDoublPickupBehavier:	
;		phx
;		lda $90
;		beq ++
;		cmp #$0002
;		beq +
;	
;		LDX.W #$B3FE                      
;        JSL.L $8280e8 						; miscGFXloadRoutineXPlus81Bank
;		bra ++
;		
;	+ 	LDX.W #$FF27						; FireWhip #$FF27	                   
;        JSL.L $8280e8 
;		
;	++	plx
;		stz $92								; reset whip
;		JML.L $808C59     ; hijackFix clearSelectedEventSlotAll

; whip GFX select 
;		dec
;		sta $92 							; set current new whip as selected
;		asl 
;		phx
;		tax
;		lda.l whipGFXPointers,x
;		tax 
;		JSL.L $8280e8
;		plx 
;		bra +
;	whipGFXPointers:	
;		dw $B3FE,$B3EB,$FF27



;	extraSpriteAddon:
;		jsl $80C69F 		; hijack fix                  ;808241|229FC680|80C69F;   free up 4c0 instead
;		rtl 

;		ldx #$0020			; find empty oam slot 
;	-	lda $0f00,x 
;		and #$00ff
;		cmp #$0080
;		beq +
;		inx
;		inx
;		inx
;		inx
;		cpx #$10fc
;		bne -
;		bra ++
;	+	txa 
;		clc
;		adc #$0f00 
;		sta $00
;		
;		ldx #$0002	
;		txy
;	-	lda.l hatOAMdata,x
;		sta ($00),y  
;		dex
;		dex 
;		dey
;		dey
;		bpl -
;	++	rtl 


; old wizzard routine.. 
;		ldy #$0009			; wired effect with different window mode.. 
;		lda $3a
;		bit #$000f
;		beq +
;		dec.w $1e80
;		ldy #$0006
;	+	sty.w $1e84
;				
;	++	inc.b $22,x 		; counter for next state 
;		lda $22,x 
;		cmp #$0080
;		bne +
;		inc.b $12,x
;		lda #$0009
;		sta $1e84
;		lda #$000f
;		sta $1e80
;		stz.b $22,x 
;	+	rtl

;;		stz.b $00,x 
;;		
;;		lda $20,x 
;;		bne ++
;		
;		lda $3a
;		bit #$000f
;		beq +
;		dec.w $1e80
;		lda $1e80
;		bne +
;		inc.b $20,x 
;		
;	+	rtl 
;	++	cmp #$0002
;		beq ++
;		lda $3a
;		bit #$000f
;		beq +
;		inc.w $1e80
;		lda $1e80
;		cmp #$000f
;		bne +
;		inc.b $20,x 	
;	+	rtl
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


; ----------------- BatRing -------------------------------
if !BatRing == 1
org $81A425
	dl NewRingRoutine
	
org $86C656
	jml NewRingEventInit 

pullPC				; free space
	NewRingEventInit:
		lda $14,x 		
		beq ++
		lda #$0003
		sta $10,x
		sta $1a			; will be used to find sprite OAM offset
		stz $12,x
		lda #$0022		; get hurt use 47
		sta $2e,x
	
		lda #$0010		; AddEvent newBat trigger identifyer
		sta $22,x
		
		stz $14,x 		; remove subID to prevent making it a drop. Sicne drop routien gets rid of stats.. 
		
		jsl $80d7cc		; SpriteOffset
		rtl 
	
	++	stz $2e,x		; normal routine bat gets killed
		stz $26,x 
		jml $86C65A
	
	NewRingRoutine:
		lda $22,x
		cmp #$0010 		; Check Bat event
		bne +
		
		jsl $82C20B		; Medusa movement
		
		lda $552		; Check RingState
		cmp #$0008
		bne +
		
		lda $0022,x		; Check New Event
		cmp #$0010
		bne +
		jsl $8CFF49	
	+	lda $86
		cmp #$0001
		bne +
		jml $8CFF0C		; no priority fix for this stage
	+	jml $8CFF07		; RingMain
		;jml $86C529
pushPC
		
org $8cff9e
	padbyte $ff
	pad $8cfffe
	
warnpc $8cffff	
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

org $81F683
 db $05,$0d,$07,$17,$19,$22,$29,$2D,$35,$3B                               ;81F68C| mapProgression lvl for next scene

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
    STZ.B $8e				; RAM_simon_subWeapon            ;80954B|648E    |00008E;  
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
	dw $0000,$0001,$0001,$0001,$0002,$0004 		
org $81A6FA	
	subWeaponDamageData:
	dw $0048,$0030,$0030,$0030,$0000                               

org $80badd					
	lda #$0010				; default 0008 axe hitbox 
org $80bae2					
	lda #$0010				; default 0008 axe hitbox
org $80bb8a                     
	lda #$0008				; default 0004 holywater hitbox 	
org $80bc03                     
	lda #$0010				; default 0008 holywater hitbox wide ypos


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

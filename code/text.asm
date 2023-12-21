;$FE = linebreak
;$FF = end

;cleartable
table "code/text_table_sc4.txt"	;[,rtl/ltr]

org $5f61b
	introText:
		db "ROTTEN GARLIC, EVIL",$FE
		db "WITH A NASTY SMELL.",$FE 
		db "_",$FE,"_",$FE				;every linebreak needs also a character
		db "THEY SELL THIS",$FE      
		db "IN TRANSELVANIA.",$FE
		db "THEY CALL IT,",$FE
		db "VAMPIRES DESIRE.",$FE
		db "_",$FE,"_",$FE				;every linebreak needs also a character
		db "THIS SHOULD BE",$FE
		db "A SCAME TO CURSE",$FE
		db "SOMEONE, TO BE",$FE
		db "EATEN BY A VAMPIRE.",$FE
		db "_",$FE,"_",$FE				;every linebreak needs also a character
		db "THE BAD THING IS",$FE
		db "THAT IT WORKS.",$FE
		db "A WOMAN USED IT ON",$FE
		db "HERE SINCE SHE",$FE
		db "HOPED A TOWNS IDIOT,",$FE
		db "WOULD LOSE INTERESST.",$FE
		db "_",$FE,"_",$FE				;every linebreak needs also a character
		db "WELL THAT WORKED TOO.",$FE
		db "BUT A OLD WELL KNOWN",$FE						;end
		db "VAMPIRE JUST BUSTED",$FE
		db "FROM THE GRAVE,",$FE
		db "AWAKON BY THE",$FE
		db "DEODERAN OF HELL.",$FE
		db "_",$FE,"_",$FE				;every linebreak needs also a character
		db "WE BETTER START",$FE
		db "INVESTEGAING AT THE",$FE
		db "TOWNS TAVERN.",$FF
 
 
 warnpc $05f934


org $81D10B      
	; optionPosY_data: 
		db $4A,$62,$7A,$92,$AA,$C2           ;81D10B|        |      ;  

{ ; ---------------------- text options, title ----------------------------------------------------- 
org $8385DF
		LDX.W #optionMenuText			; static TextSection     ;8385DF|A24186 
org $838629
		LDX.W #text_donno_00			
org $83863C
		LDX.W #text_donno_01            
org $83864F
		LDX.W #text_donno_02            
org $838662
		LDX.W #text_donno_03            
org $81D0FB
	; buttonMapTextPointer: 
		dw text_A_button                     ;81D0FB|        |81868B;  
        dw text_B_button                     ;81D0FD|        |818695;  
        dw text_X_button                     ;81D0FF|        |81869F;  
        dw text_Y_button                     ;81D101|        |8186A9;  
        dw text_L_button                     ;81D103|        |8186B3;  
        dw text_R_button                     ;81D105|        |8186BD;  
    ; stereoTextPointer: 
		dw text_Stereo                       ;81D107|        |8186C7;  
    ; monoTextPointer: 
		dw text_Monarual                     ;81D109|        |8186D1;  


{ ; needs ponter refferances !! 
;org $8184E4
;    text_GameOver: 
;		dw $5A2C                             ;8184E4|        |      ;  
;		db "GAME OVER",$FE 
;
;    text_Continue: 
;		dw $5AAC                             ;8184F0|        |      ;  
;		db "CONTINUE",$FE 
;
;    text_Password: 
;		dw $5AEC                             ;8184FB|        |      ;  
;		db "PASSWORD",$FF 
;
;	text_xxxx:
;        dw $5AAA                             ;818506|        |      ;  
;		db "+",$FE 					
;        dw $5AEA                             ;81850A|        |      ;  
;		db " ",$FF
;        dw $5AAA                             ;81850E|        |      ;  
;		db " ",$FE
;        dw $5AEA                             ;818512|        |      ;  
;		db "+",$FF
;  
;    text_notComplete: 
;		dw $5A4A                             ;818516|        |      ;  
;		db "NOT COMPLETE",$FE
;
;		dw $5A8C                             ;818525|        |      ;  
;		db "TRY AGAIN",$FF
;
;	textTitle_playerSelect: 
;		dw $5A2A                             ;818531|        |      ;  
;		db "PLAY SELECT",$FE
;        dw $5B21                             ;81853F|        |      ;  
;		db "TM AND @ 1991 KONAMI CO., LTD.",$FE 
;        dw $5B46                             ;818560|        |      ;  
;		db "LICENSED BY NINTENDO",$FF
;
;	textTitle_Start: 
;		dw $5A6C                             ;818577|        |      ;  
;		db "START",$FF
;
;	textTitle_Continue: 
;		dw $5AAC                             ;81857F|        |      ;  
;		db "CONTINUE",$FF
;
;    textTitle_Option: 
;		dw $5AEC                             ;81858A|        |      ;  
;		db "OPTION",$FF 
; 
;    DATA16_818593: 
;		dw $5A6A                             ;818593|        |      ;  
;		db "+",$FE 	
;        dw $5AAA                             ;818597|        |      ;  
;		db " ",$FE 		
;        dw $5AEA                             ;81859B|        |      ;  
;		db " ",$FF 	
;
;    DATA16_81859F: 
;		dw $5A6A                             ;81859F|        |      ;  
;		db " ",$FE 
;        dw $5AAA                             ;8185A3|        |      ;  
;		db "+",$FE	
;        dw $5AEA                             ;8185A7|        |      ;  
;		db " ",$FF
;
;    DATA16_8185AB: 
;		dw $5A6A                             ;8185AB|        |      ;    
;		db " ",$FE
;        dw $5AAA                             ;8185AF|        |      ;  
;		db " ",$FE
;        dw $5AEA                             ;8185B3|        |      ;  
;		db "+",$FF
;
;    textABC: 
;		dw $59C8                             ;8185B7|        |      ;  
;		db "A B C D E F G H I",$FE
;    textJKL: 
;		dw $5A08                             ;8185CB|        |      ;  
;		db "J K L M N O P Q R",$FE 	  
;    textSTU: 
;		dw $5A48                             ;8185DF|        |      ;  
;		db "S T U V W X Y Z",$FE   
;    text123: 
;		dw $5A88                             ;8185F1|        |      ;  
;		db "1 2 3 4 5 6 7 8 9",$FF 
;
;		dw $59AC                             ;818605|        |      ;  
;		db "        ",$FF 
; 
;	textInputYourPassword: 
;		dw $58A6                             ;818610|        |      ;  
;		db "INPUT YOUR PASSWORD",$FF 	
; 
;    textYourPassword: 
;		dw $58A9 
;		db "YOUR PASSWORD",$FF
;
;		dw $58AC                       		 ;818635|        |      ;  
;		db "MAP DISP",$FF 
}

org $818531
        dw $5A2A                            
		db " ",$FF 

org $818641
    optionMenuText: 
		dw $582A                             ;818641|        |      ; posOptionMenu
		db "OPTION MODE",$FE 
		dw $5862
		db "TO DELETE SAVE HOLD SELECT",$FE
		dw $58c8
		db "SPECIAL A",$FE 
		dw $5928                             ;81864F|        |      ;  
		db "JUMP",$FE 
		dw $5988                             ;818656|        |      ;  
		db "WHIP",$FE 
		dw $59E8                             ;81865D|        |      ;  
		db "ITEM",$FE 
		dw $5A48                   	 		 ;818664|        |      ;  
		db "SOUND",$FE 
		dw $5AA8                     	 ;81866C|        |      ;  
		db "BGM",$FE 
		dw $5B08                             ;818672|        |      ;  
		db "EFFECT",$FF 
        
	text_donno_00:
		dw $5930                             ;81867B|        |      ;  
        db $FF,$00                            
    text_donno_01:   
		dw $5990                             ;81867f|        |      ;  
        db $FF,$00                         
    text_donno_02:   
		dw $59F0                              ;818683|        |      ;  
        db $FF,$00                    	 
    text_donno_03:   
		dw $5A50                              ;818687|        |      ;  
        db $FF,$00                       
		
    text_A_button: 
		db "A",$FF,$00 
    text_B_button: 
		db "B",$FF,$00  
    text_X_button: 
        db "X",$FF,$00 
    text_Y_button: 
		db "Y",$FF,$00 
    text_L_button: 
        db "L",$FF,$00                       
    text_R_button: 
		db "R",$FF,$00 
          
	text_Stereo: 
		db "STEREO  ",$FF,$00 
    text_Monarual: 
		 db "MONAURAL",$FF 
warnPC $8186DA 
;    text_donnoThatOne: 						 
;		dw $5B29		
;		db $74,$75,$76,$77
;        db $31,$3C,$3D,$38,$39,$FE
;		
;		dw $5B49   							 ;8186E2|        |      ;  
;        db $84,$85,$86,$87,$40,$41,$4C,$4D   ;8186EA|        |      ;  
;        db $48,$49,$FF                       ;8186F2|        |      ;    

 }
 
org $81EB4B
{	;    endingSceneProperties
	endingSceneStages: 
		db $00				; endingText00           
		db $05              ; endingText01           
		db $0e              ; endingText02           
		db $11              ; endingText03           
		db $12              ; endingText04           
		db $40              ; endingText05           
		db $3b              ; endingText06           
		db $19              ; endingText07           
        db $06              ; endingText08           
		db $25              ; endingText09           
		db $29              ; endingText0a           
		db $15              ; endingText0b 30           
		db $35              ; endingText0c           
		db $39              ; endingText0d           
		db $3D              ; endingText0e           
		db $3e              ; endingText0f           
        db $41              ; endingText10           
		db $2a              ; endingText11                    

	endingSceenWindowShrinkPos: 
		dw $5020                             ; endingText00
        dw $4020                             ; endingText01
        dw $4020                             ; endingText02
        dw $2020                             ; endingText03
        dw $6030	; $1820                             ; endingText04
        dw $2020		; $4820                             ; endingText05
        dw $0020  	; $2020                           ; endingText06
        dw $2020	; $4820                             ; endingText07
        dw $1010                             ; endingText08
        dw $2020                             ; endingText09
        dw $5020                             ; endingText0a
        dw $6020                             ; endingText0b
        dw $2020                             ; endingText0c
        dw $5020                             ; endingText0d
        dw $5020                             ; endingText0e
        dw $5820                             ; endingText0f
        dw $1020                             ; endingText10
        dw $1820                             ; endingText11
   
	endingEntrance_SimonXpos: 
		dw $000C                           	; endingText00
	endingEntrance_SimonYpos:               
		dw $00A5                             
        dw $000C                            ; endingText01 
        dw $00B5                             
        dw $06a0	; $06B3                            ; endingText02 
        dw $0020	; $00A5                             
        dw $0000	; $0AF9                            ; endingText03 
        dw $0000                             
        dw $00BF                            ; endingText04 
        dw $00B5                             
        dw $02f9	; $02F9                            ; endingText05 
        dw $0055                             
        dw $0d00                            ; endingText06 
        dw $0020                             
        dw $0000			; $0686                            ; endingText07 
        dw $00A5                             
        dw $0480	; $00E9                            ; endingText08 
        dw $0020	; $00A5                             
        dw $000C                            ; endingText09 
        dw $0025                             
        dw $0280                            ; endingText0a 
        dw $0000                             
        dw $0eef	; $00A7                            ; endingText0b 
        dw $0185	; $0085                             
        dw $01F1                            ; endingText0c 
        dw $0085                             
        dw $0224                            ; endingText0d 
        dw $00A5                             
        dw $0112                            ; endingText0e 
        dw $0075                             
        dw $00C4                            ; endingText0f 
        dw $00A5                             
        dw $020C                            ; endingText10 
        dw $0065                             
        dw $01C0                            ; endingText11 
        dw $00A5                             
 
	endingEntrance_BG_12a8: 
		dw $0000                             ; endingText00
	endingEntrance_BG_12a2:                  
		dw $0000                             
        dw $0000                             ; endingText01
        dw $0000                             
        dw $0633                             ; endingText02
        dw $0000                             
        dw $0A79                             ; endingText03
        dw $0000                             
        dw $0000                             ; endingText04
        dw $0000 	; $0045                             
        dw $0279	; $0279                             ; endingText05
        dw $0000                             
        dw $0d00                             ; endingText06
        dw $0000                             
        dw $0000 	; $0606                             ; endingText07
        dw $0000                             
        dw $0480	; $0069                             ; endingText08
        dw $0000                             
        dw $0000                             ; endingText09
        dw $0000                             
        dw $0280                             ; endingText0a
        dw $0000                             
        dw $0e00		;$0027                             ; endingText0b
        dw $0100		;$0000                             
        dw $0171                             ; endingText0c
        dw $0000                             
        dw $01A4                             ; endingText0d
        dw $0000                             
        dw $0092                             ; endingText0e
        dw $0000                             
        dw $0044                             ; endingText0f
        dw $0000                             
        dw $018C                             ; endingText10
        dw $0000                             
        dw $0140                             ; endingText11
        dw $0000                             

	endingEntrance_BG_12ca: 
		dw $0000                            ; endingText00
    endingEntrance_FE: 						
		dw $0000                            
        dw $0000                            ; endingText01
        dw $0000                            
        dw $05F9                            ; endingText02
        dw $0000                            
        dw $0000                            ; endingText03
        dw $0000                            
        dw $0000                            ; endingText04
        dw $0045                            
        dw $00FB                            ; endingText05
        dw $0000                            
        dw $0000                            ; endingText06
        dw $0000                            
        dw $0606                            ; endingText07
        dw $0000                            
        dw $0000	; $0054                            ; endingText08
        dw $0000                            
        dw $0000                            ; endingText09
        dw $0000                            
        dw $00B0                            ; endingText0a
        dw $0000                            
        dw $0e00	; $001F                            ; endingText0b
        dw $0000	; $0000                            
        dw $0127                            ; endingText0c
        dw $0000                            
        dw $0150                            ; endingText0d
        dw $0000                            
        dw $000F                            ; endingText0e
        dw $0000                            
        dw $0003                            ; endingText0f
        dw $0000                            
        dw $01FA                            ; endingText10
        dw $0000                            
        dw $0100                            ; endingText11
        dw $0000                            
      
	endingEntrance_Direction: 
		dw $0000                             ; endingText00
        dw $0000                             ; endingText01 
        dw $0000                             ; endingText02		
        dw $0000                             ; endingText03		
        dw $0002                             ; endingText04		
        dw $0000                             ; endingText05		
        dw $0000                             ; endingText06	
        dw $0000                             ; endingText07		
        dw $0000                             ; endingText08		
        dw $0000                             ; endingText09		
        dw $0000                             ; endingText0a		
        dw $0001                             ; endingText0b		
        dw $0000                             ; endingText0c		
        dw $0000                             ; endingText0d		
        dw $0000                             ; endingText0e		
        dw $0000                             ; endingText0f		
        dw $0002                             ; endingText10		
        dw $0000                             ; endingText11
warnPC $81EC7D
}
org $83FC2E
	jsl loadTextDifferentBank
	nop #$02 

org $83FC43                      
	stz.w $1c38 			; make fd do small letters instead of long name.. 			
;	LDA.W #$0040                        
;    STA.B RAM_X_event_slot_xPosSub     
	bra +		
;setEndingTextBigLetters: 
	INC.W $1C38                         
 +
org $83FC23
	LDA.W #$0040             ; big text starting default 
 
org $81E8E2 
;   endingTextStartPos: 
;		dw $5844,$5844,$5844
;		dw $5844,$5844	
;        dw $5844,$8544			
;        dw $5844,$5844,$5844,$5844 ; $5AC4       
;        dw $5844,$5844,$5844,$5844        
;        dw $5844,$5844,$5944              
;   endingTextStartPos: 

		dw $5842		   ; endingText00    
		dw $5844           ; endingText01    
		dw $5844           ; endingText02    
		dw $5844           ; endingText03  
        dw $5844           ; endingText04  
		dw $5844           ; endingText05  
		dw $5844           ; endingText06  
		dw $5844           ; endingText07  
        dw $5844           ; endingText08  
		dw $5844           ; endingText09  
		dw $5844           ; endingText0a  
		dw $5844           ; endingText0b  
        dw $5844           ; endingText0c  
		dw $5844           ; endingText0d  
		dw $5844           ; endingText0e  
		dw $5844           ; endingText0f  
        dw $5844           ; endingText10  
		dw $5844			;$5AC4           ; endingText11    
		dw $5944             
 
 
 
		dw endingText00                      ;81E908|        |81E92E;  
        dw endingText01                      ;81E90A|        |81E949;  
        dw endingText02                      ;81E90C|        |81E962;  
        dw endingText03                      ;81E90E|        |81E981;  
        dw endingText04                      ;81E910|        |81E9A0;  
        dw endingText05                      ;81E912|        |81E9BC;  
        dw endingText06                      ;81E914|        |81E9D4;  
        dw endingText07                      ;81E916|        |81E9EF;  
        dw endingText08                      ;81E918|        |81EA0A;  
        dw endingText09                      ;81E91A|        |81EA25;  
        dw endingText0a                      ;81E91C|        |81EA3B;  
        dw endingText0b                      ;81E91E|        |81EA58;  
        dw endingText0c                      ;81E920|        |81EA75;  
        dw endingText0d                      ;81E922|        |81EA95;  
        dw endingText0e                      ;81E924|        |81EAAF;  
        dw endingText0f                      ;81E926|        |81EAC1;  
        dw endingText10                      ;81E928|        |81EADB;  
        dw endingText11                      ;81E92A|        |81EAEE;  
        dw endingText12_lineBreak            ;81E92C|        |81EB0E;  

	batBaGFX_dmaPointer: 
		dw $0100,$7800                       ;81B3EB|        |      ;  
        dl $FEC9ED	; gfxBatBa      
		dw $ffff
	paletteBatba:
		db $01
		dw $0000
		dw paletteBatba_data
		dw $23a0
		dw $0000
warnPC $81EB27	


pullPC
	loadTextDifferentBank:
		sep #$20 
		phb 
		lda #$a4	; data bank swap 
		pha 
		plb 
		rep #$20
		
		LDA $0000,Y ;83FC2E|B90000  |810000;  
        AND.W #$00FF                        
		
		plb 
		rtl 

	endingText00: 
; 		mitch ueno 	; masahiro ueno, mitch jun ferano 		
; 		db "nyankun/hara",$FE,$FE wife
		
		db "LEAD PROGRAMMER AND DESSIGNER",$FE 
;		db "MASAHIRO UENO"	;		db "jun/furano",$FF
		db "mr/masahiro/ueno",$FE 
;		db "NYANKUN HARA",$FD
		db "mrs/nyankun/hara",$FE,$FE,$FE,$FE,$FE,$FE,$FD 
		db $27," ",$27,"  MAY THERE HEARTS",$fd
		db "  BE BLESSED FOREVER  ",$27," ",$27,$ff 
		
	endingText01: 	
		db "OG PROGRAMMER",$FE 
		db "ete/pow/konoz",$FE,$FE,$FD
		db "    CREATOR OF THE WHIP",$FE 	
		db "/yaipon",$FF  ; creator of the whip  	
		
	endingText02:	
		db "OG PROGRAMMER",$FE 
		db "/k/nitta/",$FE,$FE
		db "/kushibuchi",$FE,$FE 		
		db "/pechi",$FF 
		
	endingText03:
		db "OG SOUND DESIGNER",$FE
		db "/oodachi",$FE,$FE
		db "/souji/taro",$FE,$FE
		db "/akkun",$FF
    
	endingText04: 
		db "KONAMI",$FE 
		db "/mr/kitaue",$FE,$FE
		db "/kurokotai",$FF

    endingText05: 
		db "HACKER_LEGAND",$FE	
		db "/redguy",$fe,$fd
		db "CREATOR OF SC4ED",$fd
		db "AMONG OTHER THINGS",$fd,$fd,$fd 
		db "I CAN NOT EXPRESS HOW MUCH",$fd
		db "YOUR WORK MEANS TO ME",$fd
		db "THANK YOU SO MUCH",$fe,$fe 
		db "/you/are/awsome",$ff 
	endingText06: 
		db "SNES_LAB_TOOLS",$FE,$fe 	
		db "/asar",$FE,$FE
		db "/diztinguish",$FE,$FE
		db "/tile/molester",$FE,$FE
		db "/hxd",$ff 

	endingText07: 
		db $ff
		
	endingText08: 		
		db "MY FAMILY",$fe
		db "/chese/my/wife",$FE
		db "/mame",$FE
		db "/dad",$FD,$fd  	
		db " MANY OTHERS",$fd
		db " THANK TO YOU ALL",$FF 	
		  
    endingText09: 
		db "SNES_COMMUNITY",$FE,$fe
		db "/you/are/awsome",$fe,$fe 
		db "would/be/nowhere",$fe,$fe
		db "without/you",$ff 
	   
	endingText0b: 

		
	endingText0d: 
		db $ff
	endingText0e: 
		db "GFX WIZZARD",$fe
		db "garindann",$fd,$fd
		db "BLOB",$fe 
		db "batbarian",$ff 
	
	endingText0f: 	
		db "BRING LOVE TO THE HEROS",$fd
		db "  IN YOUR LIFE",$FE,$fe  	
		db "//fight/the",$fe,$fe  	
		db "//blood/suckers",$ff 
	endingText0a: 
		db $fe 
		db "play/testers",$fe,$fe,$FD
		db " DRUNKEN DRACONIAN",$FD
		db " THE LAST BELMONT",$FD
		db " CURIEN",$fd 
		db " HACK GAMES LONGPLAY",$ff
	   
	endingText10: 
		db $FE
		db "special/thanks",$fe,$fe,$FD 
		db "SPIDER DAVE",$FD 		
		db "RAYOFJAY",$FD  
		db "RAINBOW SPRINKLEZ",$FD
		db "KANDOWONTU",$FF


    endingText0c: 		
		db $fe 
		db "resource/sharing",$fd 
		db "VITOR VILELA FASTROM",$fd 
		db "SHADOW333",$fd 
		db "MINUCCE",$fd
		db "BILLY TIME GAMES",$FF 
		
	endingText11: 
		db $fe 
		db "you/are",$fe
		db "the/hero",$fe 
		db "of/this",$fe
		db "story",$fd,$fd 
		db "THANK YOU FOR PLAYING",$FF 
	endingText12_lineBreak:	
		db $FE 
    endingText13: 
		db "//hacked/by",$FE,$FE
		db "////////bogaa",$FF		
	pushPC 

;warnPC $81EB27		


org $81B7BC		; probably free space FIXME!!	
warnPC $81B903



org $81ff44
warnPC $81ffb4 	



{ ; orginal ---------------------------------------------------------------- FIXME!! byte missing in text and other mistakes.. 
;org $81E8E2 
;;   endingTextStartPos: 
;		dw $5844,$5844,$5844,$5AC4           ;81E8E2|        |      ; not sure
;        dw $5AC4,$5844,$5AC4,$5844           ;81E8EA|        |      ;  
;        dw $5844,$5AC4,$5844,$5AC4           ;81E8F2|        |      ;  
;        dw $5AC4,$5AC4,$5AC4,$5844           ;81E8FA|        |      ;  
;        dw $5AC4,$5AC4,$5944                 ;81E902|        |      ;  
;                                                            ;      |        |      ;  
;;    PTR16_81E908: 
;		dw endingText00                      ;81E908|        |81E92E;  
;        dw endingText01                      ;81E90A|        |81E949;  
;        dw endingText02                      ;81E90C|        |81E962;  
;        dw endingText03                      ;81E90E|        |81E981;  
;        dw endingText04                      ;81E910|        |81E9A0;  
;        dw endingText05                      ;81E912|        |81E9BC;  
;        dw endingText06                      ;81E914|        |81E9D4;  
;        dw endingText07                      ;81E916|        |81E9EF;  
;        dw endingText08                      ;81E918|        |81EA0A;  
;        dw endingText09                      ;81E91A|        |81EA25;  
;        dw endingText0a                      ;81E91C|        |81EA3B;  
;        dw endingText0b                      ;81E91E|        |81EA58;  
;        dw endingText0c                      ;81E920|        |81EA75;  
;        dw endingText0d                      ;81E922|        |81EA95;  
;        dw endingText0e                      ;81E924|        |81EAAF;  
;        dw endingText0f                      ;81E926|        |81EAC1;  
;        dw endingText10                      ;81E928|        |81EADB;  
;        dw endingText11                      ;81E92A|        |81EAEE;  
;        dw endingText12_lineBreak            ;81E92C|        |81EB0E;  
;
;
; 
;    endingText00: 
;		db "MAIN_PROGRAMMER",$FE 
;		db "jun/furano",$FF
;   
;    endingText01: 
;		db "PLAYER_PROGRAMMER",$FE 
;		db "yaipon",$FF 
;
;    endingText02: 
;		db "ENEMY_PROGRAMMER",$FE
;		db "great/k/nitta",$ff
;
;   endingText03: 
;		db "ENEMY_PROGRAMMER",$FE
;		db "ete/pow/konoz",$ff
;   
;    endingText04: 
;		db "ENEMY_PROGRAMMER",$FE
;		db "jun/furano",$ff
;                                                      
;    endingText05: 
;		db "ENEMY_PROGRAMMER",$FE
;		db "yaipon",$FF                                                        
;   
;   endingText06: 
;		db "MAIN_DESIGNER",$FE
;		db "nyankun/hara",$FF 
;                                                       
;    endingText07: 
;		db "VRAM_DESIGNER",$FE 
;		db "nyankun/hara",$FF 
;                                                     
;    endingText08: 
;		db "VRAM_DESIGNER",$FE 
;		db "s/kushibuchi",$FF 
;                                                       
;    endingText09: 
;		db "OBJECT_DESIGNER",$FE  
;		db "pechi",$FF 
;                                                      
;    endingText0a: 
;		db "OBJECT_DESIGNER",$FE 
;		db "s/kushibuchi",$FF 
;                                                      
;    endingText0b: 
;		db "OBJECT_DESIGNER",$FE 
;		db "nyankun/hara",$FF 
;                                                      
;    endingText0c: 
;		db "SOUND_DESIGNER",$FE 
;		db "masanori/oodachi",$FF
;                                                      
;    endingText0d: 
;		db "SOUND_DESIGNER",$FE 
;		db "souji/taro",$FF
;                                                      
;    endingText0e: 
;		db "SUPER VOICE",$FE 
;		db "akkun",$FF
;                                                    
;    endingText0f: 
;		db "TOTAL DIRECTOR",$FE 
;		db "jun/furano",$ff
;                                                      
;    endingText10: 
;		db "PRODUCER",$FE 
;		db "mr/kitaue",$ff
;                                                      
;    endingText11: 
;		db "SPECIAL THANKS",$FE 
;		db "konami/kurokotai"
;                                                      
;	endingText12_lineBreak: 
;		db $fe 
;                                                     
;    endingText13: 
;		db "presented/by",$FE,$FE
;		db "///konami",$FF
; 
;warnPC $81EB27

}

{ ; ---------------------- text options, title ----------------------------------------------------- 
;org $8385DF
;		LDX.W #optionMenuText			; static TextSection     ;8385DF|A24186 
;org $838629
;		LDX.W #text_donno_00			
;org $83863C
;		LDX.W #text_donno_01            
;org $83864F
;		LDX.W #text_donno_02            
;org $838662
;		LDX.W #text_donno_03            
;org $81D0FB
;	; buttonMapTextPointer: 
;		dw text_A_button                     ;81D0FB|        |81868B;  
;        dw text_B_button                     ;81D0FD|        |818695;  
;        dw text_X_button                     ;81D0FF|        |81869F;  
;        dw text_Y_button                     ;81D101|        |8186A9;  
;        dw text_L_button                     ;81D103|        |8186B3;  
;        dw text_R_button                     ;81D105|        |8186BD;  
;    stereoTextPointer: 
;		dw text_Stereo                       ;81D107|        |8186C7;  
;    monoTextPointer: 
;		dw text_Monarual                     ;81D109|        |8186D1;  
;
;
;org $8184E4
;    text_GameOver: 
;		dw $5A2C                             ;8184E4|        |      ;  
;		db "GAME OVER",$FE 
;
;    text_Continue: 
;		dw $5AAC                             ;8184F0|        |      ;  
;		db "CONTINUE",$FE 
;
;    text_Password: 
;		dw $5AEC                             ;8184FB|        |      ;  
;		db "PASSWORD",$FF 
;
;	text_xxxx:
;        dw $5AAA                             ;818506|        |      ;  
;		db "+",$FE 					
;        dw $5AEA                             ;81850A|        |      ;  
;		db " ",$FF
;        dw $5AAA                             ;81850E|        |      ;  
;		db " ",$FE
;        dw $5AEA                             ;818512|        |      ;  
;		db "+",$FF
;  
;    text_notComplete: 
;		dw $5A4A                             ;818516|        |      ;  
;		db "NOT COMPLETE",$FE
;
;		dw $5A8C                             ;818525|        |      ;  
;		db "TRY AGAIN",$FF
;
;	textTitle_playerSelect: 
;		dw $5A2A                             ;818531|        |      ;  
;		db "PLAY SELECT",$FE
;        dw $5B21                             ;81853F|        |      ;  
;		db "TM AND @ 1991 KONAMI CO., LTD.",$FE 
;        dw $5B46                             ;818560|        |      ;  
;		db "LICENSED BY NINTENDO",$FF
;
;	textTitle_Start: 
;		dw $5A6C                             ;818577|        |      ;  
;		db "START",$FF
;
;	textTitle_Continue: 
;		dw $5AAC                             ;81857F|        |      ;  
;		db "CONTINUE",$FF
;
;    textTitle_Option: 
;		dw $5AEC                             ;81858A|        |      ;  
;		db "OPTION",$FF 
; 
;    DATA16_818593: 
;		dw $5A6A                             ;818593|        |      ;  
;		db "+",$FE 	
;        dw $5AAA                             ;818597|        |      ;  
;		db " ",$FE 		
;        dw $5AEA                             ;81859B|        |      ;  
;		db " ",$FF 	
;
;    DATA16_81859F: 
;		dw $5A6A                             ;81859F|        |      ;  
;		db " ",$FE 
;        dw $5AAA                             ;8185A3|        |      ;  
;		db "+",$FE	
;        dw $5AEA                             ;8185A7|        |      ;  
;		db " ",$FF
;
;    DATA16_8185AB: 
;		dw $5A6A                             ;8185AB|        |      ;    
;		db " ",$FE
;        dw $5AAA                             ;8185AF|        |      ;  
;		db " ",$FE
;        dw $5AEA                             ;8185B3|        |      ;  
;		db "+",$FF
;
;    textABC: 
;		dw $59C8                             ;8185B7|        |      ;  
;		db "A B C D E F G H I",$FE
;    textJKL: 
;		dw $5A08                             ;8185CB|        |      ;  
;		db "J K L M N O P Q R",$FE 	  
;    textSTU: 
;		dw $5A48                             ;8185DF|        |      ;  
;		db "S T U V W X Y Z",$FE   
;    text123: 
;		dw $5A88                             ;8185F1|        |      ;  
;		db "1 2 3 4 5 6 7 8 9",$FF 
;
;		dw $59AC                             ;818605|        |      ;  
;		db "        ",$FF 
; 
;	textInputYourPassword: 
;		dw $58A6                             ;818610|        |      ;  
;		db "INPUT YOUR PASSWORD",$FF 	
; 
;    textYourPassword: 
;		dw $58A9 
;		db "YOUR PASSWORD",$FF
;
;		dw $58AC                       		 ;818635|        |      ; this upwared needs pointer refferences!! 
;		db "MAP DISP",$FF 
;
;org $818641
;    optionMenuText: 
;		dw $588A                             ;818641|        |      ; posOptionMenu
;		db "OPTION MODE",$FE 
;
;    text_jump: 
;		dw $5928                             ;81864F|        |      ;  
;		db "JUMP",$FE 
;
;    text_whip: 
;		dw $5988                             ;818656|        |      ;  
;		db "WHIP",$FE 
;
;    text_item: 
;		dw $59E8                             ;81865D|        |      ;  
;		db "ITEM",$FE 
; 
;    text_sound: dw $5A48                   	 ;818664|        |      ;  
;		db "SOUND",$FE 
;
;    text_bgm: dw $5AA8                     	 ;81866C|        |      ;  
;		db "BGM",$FE 
; 
;    text_effect: 
;		dw $5B08                             ;818672|        |      ;  
;		db "EFFECT",$FF 
;        
;	text_donno_00:
;		dw $5930                             ;81867B|        |      ;  
;        db $FF,$00                            
;    text_donno_01:   
;		dw $5990                             ;81867f|        |      ;  
;        db $FF,$00                         
;    text_donno_02:   
;		dw $59F0                              ;818683|        |      ;  
;        db $FF,$00                    	 
;    text_donno_03:   
;		dw $5A50                              ;818687|        |      ;  
;        db $FF,$00                       
;		
;    text_A_button: 
;		db "A BUTTON",$FF,$00 
;    text_B_button: 
;		db "B BUTTON",$FF,$00  
;    text_X_button: 
;        db "X BUTTON",$FF,$00 
;    text_Y_button: 
;		db "Y BUTTON",$FF,$00 
;    text_L_button: 
;        db "L BUTTON",$FF,$00                       
;    text_R_button: 
;		db "R BUTTON",$FF,$00 
;          
;	text_Stereo: 
;		db "STEREO  ",$FF,$00 
;    text_Monarual: 
;		 db "MONAURAL",$FF 
;warnPC $8186DA 
;;    text_donnoThatOne: 						 
;;		dw $5B29		
;;		db $74,$75,$76,$77
;;        db $31,$3C,$3D,$38,$39,$FE
;;		
;;		dw $5B49   							 ;8186E2|        |      ;  
;;        db $84,$85,$86,$87,$40,$41,$4C,$4D   ;8186EA|        |      ;  
;;        db $48,$49,$FF                       ;8186F2|        |      ;    
;
; }
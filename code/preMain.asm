;lorom

!deathCounter = 1
!removeGFXreuse = 0

!BatRing = 1						; code in baseRomTweaks
!removeTimer = 1
!removeGFXreuse = 0
!HeartDependendMultishot = 1
!lastSlotFixedRing = 0
!practice = 0
!levelSelect = 0

;NEW RAM ALLOCATION IN FREERAM -----------------------------------------------
!textEngineState = $1E18	; write 2 to write text and 1 to terminate. 4 lines with 16 Character 
!armorType = $1e1a
!whipLeanth = $1e1c
!whipDropCounter = $1e1e
!ownedWhipTypes = $1e20
!allSubweapon = $1e22
!backUpButtonMapJump = $1e24
!backUpButtonMapWhip = $1e26
!backUpButtonMapSubWe = $1e28
!currentHeartCountBackup = $1e2a


!jobTable00	= $1e40			; 
!jobTable01	= $1e42
!jobTable02	= $1e44
!jobTable03	= $1e46

!jobTextDisplay = $7fff88		; job text display 2c size

org $80810D
;LDA.W #$0040                         ;subw default 2X
lda #$0010
;2f unused 0,2,

org $a08000							; free Space startpoint 
pushPC

;incsrc code/baseRomTweaks.asm		
;incsrc code/textEngine.asm 
;incsrc code/tutorialHackTweak.asm

pullPC

incsrc code/enemiePointer.asm		
;incsrc code/text.asm

if !practice == 1
;incsrc code/practice.asm 
endif

;incsrc code/NewEnemies/oldManEvID0d.asm 
;DATA16_819477 limp whip waights.. fun to randomize 

;Direction =1(Right or Down),2(Left or Up)                         "Trigger when Simon moves in this direction"
;DirAddr=55a(X direction),55e(Y direction)                          "Direction off the trigger"
;CmpAddr=54a(X position), 54e (Y direction)                       "Set Compering to X or Y"
;CmpValue=x or y value to check current values against         "Triggers when Simon moves over coordinate X Y "
;StValue=new value to change lock to                                     "Set new Value to where you want the camera lock to go"
;StAddr=A0 (left), A2 (right), A4 (top), A6 (bottom)             "Set witch Camera lock you want to move"

; 138000 exits rom address

; --------small fixes ------------------------------------------
org $83E3D0
; draw secret stairst collusion in other direction  
		LDA.W #$0000                         ;83E3E3|A90100  |      ; make lower floor
        STA.L $7E4E66                        ;83E3E6|8F664E7E|7E4E66;  
        STA.L $7E4EA4                        ;83E3EA|8FA44E7E|7E4EA4;  
        STA.L $7E4EA6                        ;83E3EE|8FA64E7E|7E4EA6;  
        STA.L $7E4EE2                        ;83E3F2|8FE24E7E|7E4EE2;  
        STA.L $7E4EE4                        ;83E3F6|8FE44E7E|7E4EE4;  
        STA.L $7E4EE6                        ;83E3FA|8FE64E7E|7E4EE6;  
		LDA.W #$8001                         ;83E3D0|A90080  |      ; drawStairs $40 offset 
        STA.L $7E4E20                        ;83E3D3|8F264E7E|7E4E26;  
        STA.L $7E4E62                        ;83E3D7|8F644E7E|7E4E64;  
        STA.L $7E4EA4                        ;83E3DB|8FA24E7E|7E4EA2;  
        STA.L $7E4EE6                   	 ;83E3DF|8FE04E7E|7E4EE0;  
org $83E41D
        LDA.W #$0000                         ;83E41D|A90100  |      ;  make it reappear  
        STA.W $1602                          ;83E420|8D0216  |811602;  		
		
; -------------------------------------------------------------


org $808fe1 
	ldy #$07ff		; orginal $03ff	;clear whole bg3 tilemap in transit. 

org $a78c1a			; entrance Speed change Cave x y 
	dw $8000,$8000	; orginal $3333 
org $81F6E8			; paletteTilesStagel03_cave:
	db $01                               ;81F6E8|        |      ;  
    dw $0000                             ;81F6E9|        |      ;  
    dw $E470		; paletteDataTilesStagel03_cave     ;81F6EB|        |86E5D4;  	$E470
    dw $2220                             ;81F6ED|        |      ;  
    dw $E5D4		; paletteDataTileStagel03_cave00    ;81F6EF|        |86E636;  	E5D4
    dw $2220                             ;81F6F1|        |      ;  					$2220
    dw $E658		; paletteDataSpriteStagel03_cave00  ;81F6F3|        |86E658;  
    dw $23E0,$0000 

;org $86898D			; disable 2bb gfx load
;    dw $5180   	; $ffff        ; dw $5180                             ;86898D|        |      ;  
;org $8684C8			; sceneMabSrcDestPointer0b
;	dw $0001                             ;8684C8|        |      ;  
;    dl $7E8000                           ;8684CA|        |      ;  
;    dl $B6F05D		; sceneMabDataStage3_Cave_00_BG1    ;8684CD|        |B6F05D;  
;    dl $7E9000                           ;8684D0|        |      ;  
;    dl $A0FFD0		; DATAlevel00                       ;8684D3|        |A0FFD0;  
;    dl $7EE000                           ;8684D6|        |      ;  
;    dl $B790BD		; sceneMabDataStage3_Cave_00_BG0    ;8684D9|        |B790BD;  
;    dl $7EF000                           ;8684DC|        |      ;  
;    dl $A0FFD0		; DATAlevel00                       ;8684DF|        |A0FFD0;  
;    dw $FFFF                             ;8684E2|        |      ;  


org $85C248			;  levelBG0Mapping:
   dw $0000,$0000,$0000,$0000           ;85C248|        |      ; ;bg0 mapping AABB AA=Speed?? BB=BGIndex
   dw $0000,$0000,$0000,$0000           ;85C250|        |      ;  
   dw $0000,$0000,$8002,$8002           ;85C258|        |      ;  
   dw $0000		; $8003 disable cave bg
   dw $0000  		; $8004		
   dw $0000,$0000           ;85C260|        |      ;  
   dw $0000,$0000,$0000,$0000           ;85C268|        |      ;  
   dw $0000,$0000,$0000,$0001           ;85C270|        |      ;  
   dw $0000,$0000,$8005,$0000           ;85C278|        |      ;  
   dw $0000,$0000,$0000,$0000           ;85C280|        |      ;  
   dw $0000,$0000,$0000,$0000           ;85C288|        |      ;  
   dw $0000,$0000,$0000,$0000           ;85C290|        |      ;  
   dw $0000,$0000,$0000,$0000           ;85C298|        |      ;  
   dw $0000,$0000,$C006,$C006           ;85C2A0|        |      ;  
   dw $C007,$0000,$0000,$0000           ;85C2A8|        |      ;  
   dw $0000,$0000,$0000,$0000           ;85C2B0|        |      ;  
   dw $0000,$0000,$0000,$0000           ;85C2B8|        |      ;  
   dw $0000,$0000,$0000,$0000           ;85C2C0|        |      ;  
   dw $0000,$0000,$0000,$0000           ;85C2C8|        |      ;  


org $85C736
specialScrollingAndTiles:
 
org $85C7BE 
BGTranperantSetting:		; stored to $44
	dw $0001		;lvl 0
	dw $0000        ;lvl 1
	dw $0000        ;lvl 2
	dw $0000        ;lvl 3
	dw $0000        ;lvl 4
	dw $0000        ;lvl 5
	dw $0000        ;lvl 6
	dw $0000        ;lvl 7
	dw $0000        ;lvl 8
	dw $0001        ;lvl 9
	dw $0001        ;lvl a
	dw $0001        ;lvl b
	dw $0001        ;lvl c $0000
	dw $0001        ;lvl d
	dw $0001        ;lvl e
	dw $0001        ;lvl f
	dw $0001        ;lvl 10
	dw $0001        ;lvl 11
	dw $0000        ;lvl 12
	dw $0000        ;lvl 13
	dw $0000        ;lvl 14
	dw $0000        ;lvl 15
	dw $0002        ;lvl 16
	dw $0000        ;lvl 17
	dw $0000        ;lvl 18
	dw $0000        ;lvl 19
	dw $0000        ;lvl 1a
	dw $0000        ;lvl 1b
	dw $0000        ;lvl 1c
	dw $0000        ;lvl 1d
	dw $0000        ;lvl 1e
	dw $0000        ;lvl 1f
	dw $0000        ;lvl 20
	dw $0000				; $0004        ;lvl 21
	dw $0000        ;lvl 22
	dw $0000        ;lvl 23
	dw $0000        ;lvl 24
	dw $0000        ;lvl 25
	dw $0004        ;lvl 26 0000
	dw $000a        ;lvl 27 0000 
	dw $0060        ;lvl 28 0000
	dw $0000        ;lvl 29
	dw $0000        ;lvl 2a 0001
	dw $0001        ;lvl 2b
	dw $0000        ;lvl 2c
	dw $0001        ;lvl 2d
	dw $000A        ;lvl 2e
	dw $000A        ;lvl 2f
	dw $000A        ;lvl 30
	dw $0000        ;lvl 31
	dw $0000        ;lvl 32
	dw $0000        ;lvl 33
	dw $0000        ;lvl 34
	dw $0000        ;lvl 35
	dw $0060        ;lvl 36
	dw $0000        ;lvl 37
	dw $0000        ;lvl 38
	dw $0000        ;lvl 39
	dw $0000        ;lvl 3a
	dw $0000        ;lvl 3b
	dw $0000        ;lvl 3c
	dw $0000        ;lvl 3d
	dw $0001        ;lvl 3e
	dw $0000        ;lvl 3f
	dw $0000        ;lvl 41
	dw $0000        ;lvl 42
	dw $0000        ;lvl 43
    dw $0000        ;lvl 44

org $85C846
ScrollSettingsBG:
	dw $0005     ;lvl 0
	dw $0000     ;lvl 1
	dw $8001     ;lvl 2
	dw $8003     ;lvl 3
	dw $8001     ;lvl 4
	dw $8004     ;lvl 5
	dw $800A     ;lvl 6
	dw $8004     ;lvl 7
	dw $0002     ;lvl 8
	dw $0010     ;lvl 9
	dw $000B     ;lvl a
	dw $0006     ;lvl b
	dw $000C     ;lvl c
	dw $0013     ;lvl d
	dw $0014     ;lvl e
	dw $0000     ;lvl f
	dw $0000     ;lvl 10
	dw $0009     ;lvl 11
	dw $0000     ;lvl 12
	dw $0000     ;lvl 13
	dw $0000     ;lvl 14
	dw $8008     ;lvl 15
	dw $0007     ;lvl 16
	dw $0006     ;lvl 17
	dw $0013		;dw $0015     ;lvl 18
	dw $0000     ;lvl 19
	dw $0016     ;lvl 1a
	dw $8008     ;lvl 1b
	dw $0000     ;lvl 1c
	dw $0000     ;lvl 1d
	dw $0000     ;lvl 1e
	dw $0000     ;lvl 1f
	dw $0017     ;lvl 20
	dw $0000     ;lvl 21
	dw $0021     ;lvl 22
	dw $0000     ;lvl 23
	dw $0000     ;lvl 24
	dw $0000     ;lvl 25
	dw $0000     ;lvl 26
	dw $0000     ;lvl 27
	dw $0000     ;lvl 28
	dw $0000     ;lvl 29
	dw $001A     ;lvl 2a
	dw $001A     ;lvl 2b
	dw $0000     ;lvl 2c
	dw $001A     ;lvl 2d
	dw $001B     ;lvl 2e
	dw $001B     ;lvl 2f
	dw $001B     ;lvl 30
	dw $0000     ;lvl 31
	dw $0000     ;lvl 32
	dw $0000     ;lvl 33
	dw $0000     ;lvl 34
	dw $0000     ;lvl 35
	dw $0000     ;lvl 36
	dw $0000     ;lvl 37
	dw $0000     ;lvl 38
	dw $0000     ;lvl 39
	dw $0000     ;lvl 3a
	dw $001F     ;lvl 3b
	dw $001D     ;lvl 3c
	dw $001E     ;lvl 3d
	dw $0000     ;lvl 3e
	dw $0023     ;lvl 3f
	dw $0023     ;lvl 41
	dw $0022     ;lvl 42
	dw $0025     ;lvl 43
	dw $0025     ;lvl 44	

org $85ca82		;tileAnimation 1
	dw $87C3    ;lvl 0
	dw $87C7    ;lvl 1
	dw $87FF		;dw $87BF    ;lvl 2
	dw $87BF    ;lvl 3
	dw $87BF    ;lvl 4
	dw $87BF    ;lvl 5
	dw $87CB    ;lvl 6
	dw $87BF    ;lvl 7
	dw $87BF    ;lvl 8
	dw $87CF    ;lvl 9
	dw $87D3    ;lvl a
	dw $87D3    ;lvl b
	dw $87D3		; $87BF    ;lvl c
	dw $87DB    ;lvl d
	dw $87DF    ;lvl e
	dw $87DF    ;lvl f
	dw $87DF    ;lvl 10
	dw $87DF    ;lvl 11
	dw $87BF    ;lvl 12
	dw $87BF    ;lvl 13
	dw $87BF    ;lvl 14
	dw $87BF    ;lvl 15
	dw $87BF    ;lvl 16
	dw $87BF    ;lvl 17
	dw $87E7    ;lvl 18
	dw $87EB    ;lvl 19
	dw $87BF    ;lvl 1a
	dw $87BF    ;lvl 1b
	dw $87BF    ;lvl 1c
	dw $87BF    ;lvl 1d
	dw $87BF    ;lvl 1e
	dw $87BF    ;lvl 1f
	dw $87BF    ;lvl 20
	dw $87BF    ;lvl 21
	dw $87BF    ;lvl 22 $87FF
	dw $87BF    ;lvl 23
	dw $87BF    ;lvl 24
	dw $87BF    ;lvl 25
	dw $87BF    ;lvl 26
	dw $87BF    ;lvl 27
	dw $87BF    ;lvl 28
	dw $87BF    ;lvl 29
	dw $87EF    ;lvl 2a
	dw $87EF    ;lvl 2b
	dw $87BF    ;lvl 2c
	dw $87F7    ;lvl 2d
	dw $87BF    ;lvl 2e
	dw $87BF    ;lvl 2f
	dw $87BF    ;lvl 30
	dw $87BF    ;lvl 31
	dw $87BF    ;lvl 32
	dw $87BF    ;lvl 33
	dw $87BF    ;lvl 34
	dw $87BF    ;lvl 35
	dw $87BF    ;lvl 36
	dw $87FB    ;lvl 37
	dw $87FB    ;lvl 38
	dw $87FB    ;lvl 39
	dw $87FB    ;lvl 3a
	dw $87BF    ;lvl 3b
	dw $87BF    ;lvl 3c
	dw $87BF    ;lvl 3d
	dw $87BF    ;lvl 3e
	dw $87BF    ;lvl 3f
	dw $87BF    ;lvl 41
	dw $87BF    ;lvl 42
	dw $87BF    ;lvl 43
	dw $87BF	;lvl 44
	

org $85cb0a		;tileAnimation 2
	dw $87BF	;lvl 0
	dw $87BF    ;lvl 1
	dw $87BF    ;lvl 2
	dw $87BF    ;lvl 3
	dw $87BF    ;lvl 4
	dw $87BF    ;lvl 5
	dw $87BF    ;lvl 6
	dw $87BF    ;lvl 7
	dw $87BF    ;lvl 8
	dw $87BF    ;lvl 9
	dw $87BF    ;lvl a
	dw $87BF    ;lvl b
	dw $87C3 	; $87E3	; $87DF			; $87BF    ;lvl c
	dw $87BF    ;lvl d
	dw $87E3    ;lvl e
	dw $87E3    ;lvl f
	dw $87E3    ;lvl 10
	dw $87E3    ;lvl 11
	dw $87BF    ;lvl 12
	dw $87BF    ;lvl 13
	dw $87BF    ;lvl 14
	dw $87BF    ;lvl 15
	dw $87BF    ;lvl 16
	dw $87BF    ;lvl 17
	dw $87BF    ;lvl 18
	dw $87C3    ;lvl 19
	dw $87BF    ;lvl 1a
	dw $87BF    ;lvl 1b
	dw $87BF    ;lvl 1c
	dw $87BF    ;lvl 1d
	dw $87BF    ;lvl 1e
	dw $87BF    ;lvl 1f
	dw $87BF    ;lvl 20
	dw $87BF    ;lvl 21
	dw $87BF    ;lvl 22
	dw $87BF    ;lvl 23
	dw $87BF    ;lvl 24
	dw $87BF    ;lvl 25
	dw $87BF    ;lvl 26
	dw $87BF    ;lvl 27
	dw $87BF    ;lvl 28
	dw $87BF    ;lvl 29
	dw $87F3    ;lvl 2a
	dw $87F3    ;lvl 2b
	dw $87BF    ;lvl 2c
	dw $87BF    ;lvl 2d
	dw $87BF    ;lvl 2e
	dw $87BF    ;lvl 2f
	dw $87BF    ;lvl 30
	dw $87BF    ;lvl 31
	dw $87BF    ;lvl 32
	dw $87BF    ;lvl 33
	dw $87BF    ;lvl 34
	dw $87BF    ;lvl 35
	dw $87BF    ;lvl 36
	dw $87FF    ;lvl 37
	dw $87FF    ;lvl 38
	dw $87FF    ;lvl 39
	dw $87FF    ;lvl 3a
	dw $87BF    ;lvl 3b
	dw $87BF    ;lvl 3c
	dw $87BF    ;lvl 3d
	dw $87BF    ;lvl 3e
	dw $87BF    ;lvl 3f
	dw $87BF    ;lvl 41
	dw $87BF    ;lvl 42
	dw $87BF    ;lvl 43
	dw $87BF    ;lvl 44
	
org $86946f 	;palette Animation 	(..1f869 palette data pointer)
	dw $86F5	;lvl 0
	dw $F84B    ;lvl 1
	dw $86F5    ;lvl 2
	dw $F858    ;lvl 3
	dw $86F5    ;lvl 4
	dw $86F5    ;lvl 5
	dw $86F5    ;lvl 6
	dw $86F5    ;lvl 7
	dw $86F5    ;lvl 8
	dw $F869    ;lvl 9
	dw $F886    ;lvl a
	dw $F886    ;lvl b
	dw $F886	; $86F5    ;lvl c
	dw $F8F0    ;lvl d
	dw $F8FD    ;lvl e
	dw $F8FD    ;lvl f
	dw $F8FD    ;lvl 10
	dw $F8FD    ;lvl 11
	dw $F916    ;lvl 12
	dw $F916    ;lvl 13
	dw $F91E    ;lvl 14
	dw $86F5    ;lvl 15
	dw $86F5    ;lvl 16
	dw $86F5    ;lvl 17
	dw $F926    ;lvl 18
	dw $F92E    ;lvl 19
	dw $86F5    ;lvl 1a
	dw $F936    ;lvl 1b
	dw $F93E    ;lvl 1c
	dw $86F5    ;lvl 1d
	dw $86F5    ;lvl 1e
	dw $86F5    ;lvl 1f
	dw $F946    ;lvl 20
	dw $86F5    ;lvl 21
	dw $86F5    ;lvl 22
	dw $F95F    ;lvl 23
	dw $F936	; $F95F    ;lvl 24
	dw $F95F    ;lvl 25
	dw $F967    ;lvl 26
	dw $F967    ;lvl 27
	dw $F967    ;lvl 28
	dw $F967    ;lvl 29
	dw $F96F    ;lvl 2a
	dw $F96F    ;lvl 2b
	dw $86F5    ;lvl 2c
	dw $86F5    ;lvl 2d
	dw $F980    ;lvl 2e
	dw $F980    ;lvl 2f
	dw $F980    ;lvl 30
	dw $F9A5    ;lvl 31
	dw $F9A5    ;lvl 32
	dw $F9A5    ;lvl 33
	dw $F9A5    ;lvl 34
	dw $F9A5    ;lvl 35
	dw $F9A5    ;lvl 36
	dw $F9BA    ;lvl 37
	dw $F9BA    ;lvl 38
	dw $F9BA    ;lvl 39
	dw $F9BA    ;lvl 3a
	dw $F9CB    ;lvl 3b
	dw $86F5    ;lvl 3c
	dw $86F5    ;lvl 3d
	dw $86F5    ;lvl 3e
	dw $86F5    ;lvl 3f
	dw $86F5    ;lvl 41
	dw $86F5    ;lvl 42
	dw $86F5    ;lvl 43
	dw $86F5    ;lvl 44

;org $81A6EC
;   whipDamageData: 
;	dw $0020,$0008
;	dw $0030,$0010           
;    dw $0000,$0018                      

org $81A81A
   breakableWallItems: 
	db $26		; lvl 3
	db $25		; lvl 5 23
	db $19		; lvl 6
	db $26		; swamp
	db $26		; puw 19
	db $25		; chan 23
	db $26		; danc
	db $26		; danc
    db $26		; lib
	db $25		; lib 23
	db $26		; dungon                

org $81ab00		; HitBoxTable y x from Center
	dw $0808    ;
	dw $0808    ; ID 01 Projectile ??
	dw $0808    ; ID 02 Projectile Bone ??
	dw $0404    ; ID 03 Ring
	dw $0000    ; ID 04 PullBridge Mode7
	dw $0000    ; ID 05 simon go to other BG
	dw $0000    ; ID 06 fallingPlatform
	dw $0808    ; ID 07 Medusa
	dw $0808    ; ID $8 Ghost
	dw $0808    ; ID $9 SpinnyRoller 
	dw $080C    ; ID $a Dog
	dw $1408    ; ID $b BonePillar
	dw $0808    ; ID $c Bat
	dw $1008    ; ID $d OldMan with Dog 0808
	dw $1008    ; ID $e UnusedCandle
	dw $0808    ; ID $f Book Bird
	dw $0808    ; ID $10 Bird
	dw $1808    ; ID $11 Skelly Walk
	dw $1808    ; ID $12 Skelly Bone
	dw $0000    ; ID $13 ??
	dw $0000    ; ID $14 Pillar Exit
	dw $0000    ; ID $15 Exit lvl
	dw $0810    ; ID $16 Crusher
	dw $0810    ; ID $17 Platform that Moves
	dw $0808    ; ID $18 Small Heart Candle
	dw $0808    ; ID $19 Heart
	dw $0808    ; ID $1a Dagger
	dw $0808    ; ID $1b Axe
	dw $0808    ; ID $1c HolyWater
	dw $0808    ; ID $1d Cross
	dw $0808    ; ID $1e StopWatch
	dw $0808    ; ID $1f Rosary
	dw $0808    ; ID $20 Potion
	dw $0808    ; ID $21 WhipUpgrade
	dw $0808    ; ID $22 Money (A2,E2)
	dw $0808    ; ID $23 Doble
	dw $0808    ; ID $24 Trible
	dw $0808    ; ID $25 Small Meat
	dw $0808    ; ID $26 Meat
	dw $0808    ; ID $27 Orb
	dw $0808    ; ID $28 One UP
	dw $0808    ; ID $29 ?? Type two disapearing Candle 
	dw $0000    ; ID $2a Bosses (Needs a other Document..)
	dw $0000    ; ID $2b IronGate 
	dw $0808    ; ID $2c Wall Women/corps
	dw $0808    ; ID $2d Small FLAME (EnemyKill)
	dw $0000    ; ID $2e Moon (sub1)RedBat (sub2)RedBat
	dw $0808    ; ID $2f Brackable Block Iteam!  NEEDS DOCUMENTATION (
	dw $0808    ; ID $30 Frog
	dw $1410    ; ID $31 Sword Knight
	dw $0C14    ; ID $32 Snake falling Vegies
	dw $0C08    ; ID $33 Coffine Snapping
	dw $0C08    ; ID $34 MudMan ID 78 sub2 ID 79 sub sub0
	dw $0C08    ; ID $35 Snake plant Salat
	dw $0C08    ; ID $36 (HighFiveSkelly) 
	dw $0808    ; ID $37 Crumbling block
	dw $0000    ; ID $38 EventAutoSpawner !Swarms!Dusa:s1+2+6(hard) Zo
	dw $1018    ; ID $39 Wiggeling on bridge handle sub0-4 TileAnimati
	dw $0000    ; ID $3a Falling wooden Bridge
	dw $0000    ; ID $3b Trap Turning Platform
	dw $180C    ; ID $3c leave man
	dw $0808    ; ID $3d BIG FLAME
	dw $1C0C    ; ID $3e gargyle
	dw $0404    ; ID $3f water drip sub0 sub1+ does damage
	dw $0000    ; ID $40 UNUSED TURNING PLATFORM
	dw $0000    ; ID $41 Camera look event (s editable in Propertie me
	dw $1020    ; ID $42 Table
	dw $0808    ; ID $43 Spider
	dw $1808    ; ID $44 Falling stalactit
	dw $0808    ; ID $45 ?? CANDLE INVISIBLE ITEM THAT CRASH GAME
	dw $0404    ; ID $46 Brackable Stair SUB 0-3!-3f Animated bg Skele
	dw $0000    ; ID $47 ?? MEDUSA OUT OF CANDLE THAT CRASHES THE GAME
	dw $0000    ; ID $48 Sub0 HydraBoss! Sub0, Sub1 water current!  Cu
	dw $0000    ; ID $49 Vines TileAnimation
	dw $0000    ; ID $4a Trap TurningSpikePlatform
	dw $1016    ; ID $4b LITTLE BATS UNUSED ENEMY 0 2 1 BONEPILLER
	dw $1808    ; ID $4c 0 2 FISHMAN SWIMMING 1FLYING SOMETHING
	dw $1020    ; ID $4d Chandalire Falling
	dw $0808    ; ID $4e Bat single diving after Simon
	dw $0404    ; ID $4f Sprite moving very fast to the felt
	dw $0404    ; ID $50 SPLASH?
	dw $1808    ; ID $51 FISHMAN JUMPING 
	dw $1808    ; ID $52 AxeKnight
	dw $0808    ; ID $53 AXE 0 2
	dw $1B0C    ; ID $54 Zombi Ghost Castle
	dw $0000    ; ID $55 NOTHING 1 CRASH SOUND? / Platform ..x100 y5d
	dw $1808    ; ID $56 Skelletone Whiping
	dw $0808    ; ID $57 HUNCHBACK 0 2
	dw $140C    ; ID $58 HARPIES 0 2
	dw $180C    ; ID $59 SpearKnight
	dw $1008    ; ID $5a Women Ghost
	dw $1008    ; ID $5b Man Ghost
	dw $0808    ; ID $5c Hands with skeleton knight
	dw $1008    ; ID $5d Bone Dragon SUB 0=nothing 18=small heart e2=G
	dw $1008    ; ID $5e Bone Dragon Left Side SUB19=Big heart 0=Nothi
	dw $0C0C    ; ID $5f Extoplasm Sub 1+2  
	dw $2004    ; ID $60 Falling Dagers
	dw $0810    ; ID $61 Swinging Spike Platform
	dw $0A10    ; ID $62 Rising Spike array Sub 0 1 2
	dw $0404    ; ID $63 Gold Platform Disapearing Sub 0-13, Tresure C
	dw $1010    ; ID $64 Destroyable block array with falling routine 
	dw $0808    ; ID $65 Falling Blocks that stack
	dw $0808    ; ID $66 SINGLE HAND 0 2
	dw $080E    ; ID $67 ??NOTHING
	dw $0000    ; ID $68 Skull Watching Sub 0-9 (80-89) y80 x1b8 208 2
	dw $1808    ; ID $69 Skeleton Red
	dw $0808    ; ID $6a ??FALLING SOMETHING 0 2
	dw $080C    ; ID $6b CandleDog
	dw $0000    ; ID $6c Skelly out of celling Sub 1 4 8 c 10 y30 x100
	dw $0202    ; ID $6d Fuzzyball
	dw $0404    ; ID $6e Grabing hand
	dw $0404    ; ID $6f Horse head normal
	dw $1008    ; ID $70 Grave Digingman 
	dw $0404    ; ID $71 Horse head upside down
	dw $0404    ; ID $72 eye eye
	dw $0808    ; ID $73 club guy
	dw $0404    ; ID $74 Caterpiller Lag Monster
	dw $0404    ; ID $75 Gargyle with shild
	dw $0404    ; ID $76 Dancing Couple
	dw $0404    ; ID $77 ?? INVISABLE SOMETHING STANDING STILL 0 2
	dw $0404    ; ID $78 Bridge Falling Mask 21-37? (Bracking when mov
	dw $0404    ; ID $79 ?? SMALL MUD MAN MASK? CRACK SOUND WHEN DUCKI
	dw $0000    ; ID $7a CarpetMonster Block event (used in every stag
	dw $0e18    ; ID $7b Coffin Circle 08 08
	dw $0808    ; ID $7c Gear Big SUB 0, Gear Little SUB 2, Gear Force
	dw $0808    ; ID $7d Gear Spike SUB 20, Sub 0 Bridge final stage, 
	dw $0810    ; ID $7e Headless Knight
	dw $0810    ; ID $7f Rockman
	

org $81ac00		; enemyHealth Table
	dw $0000	;
	dw $0000	; ID 01 Projectile ??
	dw $0010	; ID 02 Projectile Bone ??
	dw $0001	; ID 03 Ring
	dw $0000	; ID 04 PullBridge Mode7
	dw $0000	; ID 05 simon go to other BG
	dw $0000	; ID 06 fallingPlatform
	dw $0010	; ID 07 Medusa
	dw $0060	; ID $8 Ghost
	dw $0060	; ID $9 SpinnyRoller 
	dw $0008	; ID $a Dog
	dw $0090	; ID $b BonePillar
	dw $0010	; ID $c Bat
	dw $0100	; ID $d OldMan with Dog 0010 
	dw $0000	; ID $e UnusedCandle
	dw $0010	; ID $f Book Bird
	dw $0008	; ID $10 Bird
	dw $0030	; ID $11 Skelly Walk
	dw $0030	; ID $12 Skelly Bone
	dw $0000	; ID $13 ??
	dw $0000	; ID $14 Pillar Exit
	dw $0000	; ID $15 Exit lvl
	dw $0000	; ID $16 Crusher
	dw $0000	; ID $17 Platform that Moves
	dw $0000	; ID $18 Small Heart Candle
	dw $0000	; ID $19 Heart
	dw $0000	; ID $1a Dagger
	dw $0000	; ID $1b Axe
	dw $0000	; ID $1c HolyWater
	dw $0000	; ID $1d Cross
	dw $0000	; ID $1e StopWatch
	dw $0000	; ID $1f Rosary
	dw $0000	; ID $20 Potion
	dw $0000	; ID $21 WhipUpgrade
	dw $0000	; ID $22 Money (A2,E2)
	dw $0000	; ID $23 Doble
	dw $0000	; ID $24 Trible
	dw $0000	; ID $25 Small Meat
	dw $0000	; ID $26 Meat
	dw $0000	; ID $27 Orb
	dw $0000	; ID $28 One UP
	dw $0000	; ID $29 ?? Type two disapearing Candle 
	dw $0000	; ID $2a Bosses (Needs a other Document..)
	dw $0000	; ID $2b IronGate 
	dw $0000	; ID $2c Wall Women/corps
	dw $0000	; ID $2d Small FLAME (EnemyKill)
	dw $0000	; ID $2e Moon (sub1)RedBat (sub2)RedBat
	dw $7FFF	; ID $2f Brackable Block Iteam!  NEEDS DOCUMENTATION (
	dw $0008	; ID $30 Frog
	dw $0060	; ID $31 Sword Knight
	dw $0030	; ID $32 Snake falling Vegies
	dw $0030	; ID $33 Coffine Snapping
	dw $0030	; ID $34 MudMan ID 78 sub2 ID 79 sub sub0
	dw $0030	; ID $35 Snake plant Salat
	dw $0030	; ID $36 (HighFiveSkelly) 
	dw $0000	; ID $37 Crumbling block
	dw $0000	; ID $38 EventAutoSpawner !Swarms!Dusa:s1+2+6(hard) Zo
	dw $0000	; ID $39 Wiggeling on bridge handle sub0-4 TileAnimati
	dw $0000	; ID $3a Falling wooden Bridge
	dw $0000	; ID $3b Trap Turning Platform
	dw $0040	; ID $3c leave man
	dw $0000	; ID $3d BIG FLAME
	dw $000A	; ID $3e gargyle
	dw $0000	; ID $3f water drip sub0 sub1+ does damage
	dw $0000	; ID $40 UNUSED TURNING PLATFORM
	dw $0000	; ID $41 Camera look event (s editable in Propertie me
	dw $0050	; ID $42 Table
	dw $0010	; ID $43 Spider
	dw $0000	; ID $44 Falling stalactit
	dw $0000	; ID $45 ?? CANDLE INVISIBLE ITEM THAT CRASH GAME
	dw $7FFF	; ID $46 Brackable Stair SUB 0-3!-3f Animated bg Skele
	dw $0000	; ID $47 ?? MEDUSA OUT OF CANDLE THAT CRASHES THE GAME
	dw $0000	; ID $48 Sub0 HydraBoss! Sub0, Sub1 water current!  Cu
	dw $0000	; ID $49 Vines TileAnimation
	dw $0000	; ID $4a Trap TurningSpikePlatform
	dw $0000	; $0030	; ID $4b LITTLE BATS UNUSED ENEMY 0 2 1 BONEPILLER
	dw $0030	; ID $4c 0 2 FISHMAN SWIMMING 1FLYING SOMETHING
	dw $0100	; ID $4d Chandalire Falling
	dw $0010	; ID $4e Bat single diving after Simon
	dw $0010	; ID $4f Sprite moving very fast to the felt
	dw $0000	; ID $50 SPLASH?
	dw $0020	; ID $51 FISHMAN JUMPING 
	dw $0090	; ID $52 AxeKnight
	dw $0010	; ID $53 AXE 0 2
	dw $0010	; ID $54 Zombi Ghost Castle
	dw $0000	; ID $55 NOTHING 1 CRASH SOUND? / Platform ..x100 y5d
	dw $0040	; ID $56 Skelletone Whiping
	dw $0020	; ID $57 HUNCHBACK 0 2
	dw $0030	; ID $58 HARPIES 0 2
	dw $00B0	; ID $59 SpearKnight
	dw $0010	; ID $5a Women Ghost
	dw $0010	; ID $5b Man Ghost
	dw $0030	; ID $5c Hands with skeleton knight
	dw $0100	; ID $5d Bone Dragon SUB 0=nothing 18=small heart e2=G
	dw $0100	; ID $5e Bone Dragon Left Side SUB19=Big heart 0=Nothi
	dw $0060	; ID $5f Extoplasm Sub 1+2  
	dw $7FFF	; ID $60 Falling Dagers
	dw $7FFF	; ID $61 Swinging Spike Platform
	dw $7FFF	; ID $62 Rising Spike array Sub 0 1 2
	dw $0000	; ID $63 Gold Platform Disapearing Sub 0-13, Tresure C
	dw $7FFF	; ID $64 Destroyable block array with falling routine 
	dw $0004	; ID $65 Falling Blocks that stack
	dw $0020	; ID $66 SINGLE HAND 0 2
	dw $7FFF	; ID $67 ??NOTHING
	dw $7FFF	; ID $68 Skull Watching Sub 0-9 (80-89) y80 x1b8 208 2
	dw $0030	; ID $69 Skeleton Red
	dw $7FFF	; ID $6a ??FALLING SOMETHING 0 2
	dw $0030	; ID $6b CandleDog
	dw $0000	; ID $6c Skelly out of celling Sub 1 4 8 c 10 y30 x100
	dw $1400	; ID $6d Fuzzyball
	dw $0030	; ID $6e Grabing hand
	dw $0030	; ID $6f Horse head normal
	dw $0030	; ID $70 Grave Digingman 
	dw $0030	; ID $71 Horse head upside down
	dw $0030	; ID $72 eye eye
	dw $0030	; ID $73 club guy
	dw $0100	; ID $74 Caterpiller Lag Monster
	dw $0030	; ID $75 Gargyle with shild
	dw $0030	; ID $76 Dancing Couple
	dw $0030	; ID $77 ?? INVISABLE SOMETHING STANDING STILL 0 2
	dw $0030	; ID $78 Bridge Falling Mask 21-37? (Bracking when mov
	dw $0030	; ID $79 ?? SMALL MUD MAN MASK? CRACK SOUND WHEN DUCKI
	dw $0000	; ID $7a CarpetMonster Block event (used in every stag
	dw $0200	; ID $7b Coffin Circle
	dw $0000	; ID $7c Gear Big SUB 0, Gear Little SUB 2, Gear Force
	dw $0000	; ID $7d Gear Spike SUB 20, Sub 0 Bridge final stage, 
	dw $0030	; ID $7e Headless Knight
	dw $0070	; ID $7f Rockman
	
;org $81ad00	; HitAttributes ;22 normal 01,damage,02 whip destruct, 04 sub destruct,08empty?
	dw $0000	;
	dw $0047    ; ID 01 Projectile ??
	dw $0047    ; ID 02 Projectile Bone ??
	dw $0022    ; ID 03 Ring
	dw $0020    ; ID 04 PullBridge Mode7
	dw $0020    ; ID 05 simon go to other BG
	dw $0120    ; ID 06 fallingPlatform
	dw $0047    ; ID 07 Medusa
	dw $0047    ; ID $8 Ghost
	dw $0047    ; ID $9 SpinnyRoller 
	dw $0047    ; ID $a Dog
	dw $0047    ; ID $b BonePillar
	dw $0047    ; ID $c Bat
	dw $0000    ; ID $d OldMan with Dog
	dw $0026    ; ID $e UnusedCandle
	dw $0047    ; ID $f Book Bird
	dw $0047    ; ID $10 Bird
	dw $0047    ; ID $11 Skelly Walk
	dw $0047    ; ID $12 Skelly Bone
	dw $0020    ; ID $13 ??
	dw $0020    ; ID $14 Pillar Exit
	dw $0020    ; ID $15 Exit lvl
	dw $0020    ; ID $16 Crusher
	dw $0020    ; ID $17 Platform that Moves
	dw $0009    ; ID $18 Small Heart Candle
	dw $0009    ; ID $19 Heart
	dw $0009    ; ID $1a Dagger
	dw $0009    ; ID $1b Axe
	dw $0009    ; ID $1c HolyWater
	dw $0009    ; ID $1d Cross
	dw $0009    ; ID $1e StopWatch
	dw $0009    ; ID $1f Rosary
	dw $0009    ; ID $20 Potion
	dw $0009    ; ID $21 WhipUpgrade
	dw $0009    ; ID $22 Money (A2,E2)
	dw $0009    ; ID $23 Doble
	dw $0009    ; ID $24 Trible
	dw $0009    ; ID $25 Small Meat
	dw $0009    ; ID $26 Meat
	dw $0009    ; ID $27 Orb
	dw $0009    ; ID $28 One UP
	dw $0000    ; ID $29 ?? Type two disapearing Candle 
	dw $0020    ; ID $2a Bosses (Needs a other Document..)
	dw $0020    ; ID $2b IronGate 
	dw $0047    ; ID $2c Wall Women/corps
	dw $0000    ; ID $2d Small FLAME (EnemyKill)
	dw $0020    ; ID $2e Moon (sub1)RedBat (sub2)RedBat
	dw $0022    ; ID $2f Brackable Block Iteam!  NEEDS DOCUMENTATION (
	dw $0047    ; ID $30 Frog
	dw $0047    ; ID $31 Sword Knight
	dw $0047    ; ID $32 Snake falling Vegies
	dw $0047    ; ID $33 Coffine Snapping
	dw $0047    ; ID $34 MudMan ID 78 sub2 ID 79 sub sub0
	dw $0047    ; ID $35 Snake plant Salat
	dw $0047    ; ID $36 (HighFiveSkelly) 
	dw $0120    ; ID $37 Crumbling block
	dw $0020    ; ID $38 EventAutoSpawner !Swarms!Dusa:s1+2+6(hard) Zo
	dw $0001    ; ID $39 Wiggeling on bridge handle sub0-4 TileAnimati
	dw $0120    ; ID $3a Falling wooden Bridge
	dw $0120    ; ID $3b Trap Turning Platform
	dw $0000    ; ID $3c leave man
	dw $0000    ; ID $3d BIG FLAME
	dw $0047    ; ID $3e gargyle
	dw $0020    ; ID $3f water drip sub0 sub1+ does damage
	dw $0120    ; ID $40 UNUSED TURNING PLATFORM
	dw $0020    ; ID $41 Camera look event (s editable in Propertie me
	dw $0000	; $0047    ; ID $42 Table
	dw $0047    ; ID $43 Spider
	dw $0021    ; ID $44 Falling stalactit
	dw $0001    ; ID $45 ?? CANDLE INVISIBLE ITEM THAT CRASH GAME
	dw $0020    ; ID $46 Brackable Stair SUB 0-3!-3f Animated bg Skele
	dw $0020    ; ID $47 ?? MEDUSA OUT OF CANDLE THAT CRASHES THE GAME
	dw $0020    ; ID $48 Sub0 HydraBoss! Sub0, Sub1 water current!  Cu
	dw $0020	; ID $49 Vines TileAnimation
    dw $0120    ; ID $4a Trap TurningSpikePlatform
    dw $0000	; $0047    ; ID $4b LITTLE BATS UNUSED ENEMY 0 2 1 BONEPILLER
    dw $0047    ; ID $4c 0 2 FISHMAN SWIMMING 1FLYING SOMETHING
    dw $0047	; $0021    ; ID $4d Chandalire Falling
    dw $0047    ; ID $4e Bat single diving after Simon
    dw $0047    ; ID $4f Sprite moving very fast to the felt
    dw $0000    ; ID $50 SPLASH?
    dw $0047    ; ID $51 FISHMAN JUMPING 
    dw $0047    ; ID $52 AxeKnight
    dw $0047    ; ID $53 AXE 0 2
    dw $0047    ; ID $54 Zombi Ghost Castle
    dw $0020    ; ID $55 NOTHING 1 CRASH SOUND? / Platform ..x100 y5d
    dw $0047    ; ID $56 Skelletone Whiping
    dw $0047    ; ID $57 HUNCHBACK 0 2
    dw $0047    ; ID $58 HARPIES 0 2
    dw $0047    ; ID $59 SpearKnight
    dw $0047    ; ID $5a Women Ghost
    dw $0047    ; ID $5b Man Ghost
    dw $0060    ; ID $5c Hands with skeleton knight
    dw $0020    ; ID $5d Bone Dragon SUB 0=nothing 18=small heart e2=G
    dw $0020    ; ID $5e Bone Dragon Left Side SUB19=Big heart 0=Nothi
    dw $00E7    ; ID $5f Extoplasm Sub 1+2  
    dw $0001    ; ID $60 Falling Dagers
    dw $0020    ; ID $61 Swinging Spike Platform
    dw $0021    ; ID $62 Rising Spike array Sub 0 1 2
    dw $0020    ; ID $63 Gold Platform Disapearing Sub 0-13, Tresure C
    dw $0022    ; ID $64 Destroyable block array with falling routine 
    dw $0020    ; ID $65 Falling Blocks that stack
    dw $0046    ; ID $66 SINGLE HAND 0 2
    dw $0000    ; ID $67 ??NOTHING
    dw $0020    ; ID $68 Skull Watching Sub 0-9 (80-89) y80 x1b8 208 2
    dw $0047    ; ID $69 Skeleton Red
    dw $0000    ; ID $6a ??FALLING SOMETHING 0 2
    dw $0047    ; ID $6b CandleDog
    dw $0020    ; ID $6c Skelly out of celling Sub 1 4 8 c 10 y30 x100
    dw $0047    ; ID $6d Fuzzyball
    dw $0047    ; ID $6e Grabing hand
    dw $0047    ; ID $6f Horse head normal
    dw $0047    ; ID $70 Grave Digingman 
    dw $0047    ; ID $71 Horse head upside down
    dw $0047    ; ID $72 eye eye
    dw $0047    ; ID $73 club guy
    dw $0047    ; ID $74 Caterpiller Lag Monster
    dw $0047    ; ID $75 Gargyle with shild
    dw $0047    ; ID $76 Dancing Couple
    dw $0047    ; ID $77 ?? INVISABLE SOMETHING STANDING STILL 0 2
    dw $0047    ; ID $78 Bridge Falling Mask 21-37? (Bracking when mov
    dw $0047    ; ID $79 ?? SMALL MUD MAN MASK? CRACK SOUND WHEN DUCKI
    dw $0020    ; ID $7a CarpetMonster Block event (used in every stag
    dw $0000    ; ID $7b Coffin Circle 67
    dw $0020    ; ID $7c Gear Big SUB 0, Gear Little SUB 2, Gear Force
    dw $0020    ; ID $7d Gear Spike SUB 20, Sub 0 Bridge final stage, 
    dw $0047    ; ID $7e Headless Knight
    dw $0047    ; ID $7f Rockman

;org $81ae00 	; Death Animation or respawn?
	db $2D,$2D,$2D,$2D,$2D,$2D,$2D,$07
	db $08,$2D,$0A,$0B,$0C,$3d	; $0d
	db $2D,$2D
	db $10,$11,$12,$2D,$2D,$2D,$2D,$2D
	db $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
	db $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
	db $2D,$2D,$2D,$2D,$3D,$2D,$2D,$2D
	db $2D,$31,$32,$33,$34,$2D,$36,$2D
	db $2D,$2D,$2D,$2D,$3C,$2D,$3E,$2D
	db $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
	db $2D,$2D,$2D,$2D,$4C,$2D,$2D,$2D
	db $2D,$51,$52,$2D,$54,$2D,$56,$3D
	db $3D,$59,$5A,$5A,$5C,$2D,$2D,$5F
	db $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
	db $2D,$69,$2D,$2D,$2D,$2D,$6E,$2D
	db $70,$2D,$3D,$3D,$2D,$75,$3D,$3D
	db $78,$79,$2D,$3D,$2D,$2D,$7E,$2D
;org $81ae80		;??
	db $00,$00,$00,$00,$00,$00,$00,$02
	db $03,$00,$03,$07,$02,$0D,$00,$00
	db $07,$06,$06,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$0B,$04,$05,$04,$00,$04,$00
	db $00,$00,$00,$00,$04,$00,$04,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$08,$00,$00,$00
	db $00,$0B,$06,$00,$03,$00,$06,$00
	db $00,$04,$0A,$0A,$06,$00,$00,$02
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$06,$00,$00,$00,$00,$04,$00
	db $04,$00,$00,$00,$00,$03,$00,$00
	db $04,$04,$00,$00,$00,$00,$04,$00
	
;org $81af00		; DamageTable
	db $00   	;
	db $02   	; ID 01 Projectile ??
	db $02   	; ID 02 Projectile Bone ??
	db $02   	; ID 03 Ring
	db $01   	; ID 04 PullBridge Mode7
	db $01   	; ID 05 simon go to other BG
	db $01   	; ID 06 fallingPlatform
	db $02   	; ID 07 Medusa
	db $03   	; ID $8 Ghost
	db $03   	; ID $9 SpinnyRoller 
	db $03   	; ID $a Dog
	db $03   	; ID $b BonePillar
	db $03   	; ID $c Bat
	db $03   	; ID $d OldMan with Dog
	db $03   	; ID $e UnusedCandle
	db $03   	; ID $f Book Bird
	db $02   	; ID $10 Bird
	db $03   	; ID $11 Skelly Walk
	db $03   	; ID $12 Skelly Bone
	db $01   	; ID $13 ??
	db $01   	; ID $14 Pillar Exit
	db $01   	; ID $15 Exit lvl
	db $01   	; ID $16 Crusher
	db $01   	; ID $17 Platform that Moves
	db $00   	; ID $18 Small Heart Candle
	db $00   	; ID $19 Heart
	db $00   	; ID $1a Dagger
	db $00   	; ID $1b Axe
	db $00   	; ID $1c HolyWater
	db $00   	; ID $1d Cross
	db $00   	; ID $1e StopWatch
	db $00   	; ID $1f Rosary
	db $00   	; ID $20 Potion
	db $00   	; ID $21 WhipUpgrade
	db $00   	; ID $22 Money (A2,E2)
	db $00   	; ID $23 Doble
	db $00   	; ID $24 Trible
	db $00   	; ID $25 Small Meat
	db $00   	; ID $26 Meat
	db $00   	; ID $27 Orb
	db $00   	; ID $28 One UP
	db $00   	; ID $29 ?? Type two disapearing Candle 
	db $00   	; ID $2a Bosses (Needs a other Document..)
	db $00   	; ID $2b IronGate 
	db $02   	; ID $2c Wall Women/corps
	db $00   	; ID $2d Small FLAME (EnemyKill)
	db $00   	; ID $2e Moon (sub1)RedBat (sub2)RedBat
	db $00   	; ID $2f Brackable Block Iteam!  NEEDS DOCUMENTATION (
	db $02   	; ID $30 Frog
	db $03   	; ID $31 Sword Knight
	db $03   	; ID $32 Snake falling Vegies
	db $02   	; ID $33 Coffine Snapping
	db $04   	; ID $34 MudMan ID 78 sub2 ID 79 sub sub0
	db $03   	; ID $35 Snake plant Salat
	db $03   	; ID $36 (HighFiveSkelly) 
	db $00   	; ID $37 Crumbling block
	db $00   	; ID $38 EventAutoSpawner !Swarms!Dusa:s1+2+6(hard) Zo
	db $01   	; ID $39 Wiggeling on bridge handle sub0-4 TileAnimati
	db $00   	; ID $3a Falling wooden Bridge
	db $00   	; ID $3b Trap Turning Platform
	db $03   	; ID $3c leave man
	db $00   	; ID $3d BIG FLAME
	db $02   	; ID $3e gargyle
	db $02   	; ID $3f water drip sub0 sub1+ does damage
	db $00   	; ID $40 UNUSED TURNING PLATFORM
	db $00   	; ID $41 Camera look event (s editable in Propertie me
	db $02   	; ID $42 Table
	db $02   	; ID $43 Spider
	db $03   	; ID $44 Falling stalactit
	db $03   	; ID $45 ?? CANDLE INVISIBLE ITEM THAT CRASH GAME
	db $02   	; ID $46 Brackable Stair SUB 0-3!-3f Animated bg Skele
	db $00   	; ID $47 ?? MEDUSA OUT OF CANDLE THAT CRASHES THE GAME
	db $00   	; ID $48 Sub0 HydraBoss! Sub0, Sub1 water current!  Cu
	db $00   	; ID $49 Vines TileAnimation
	db $00   	; ID $4a Trap TurningSpikePlatform
	db $02   	; ID $4b LITTLE BATS UNUSED ENEMY 0 2 1 BONEPILLER
	db $03   	; ID $4c 0 2 FISHMAN SWIMMING 1FLYING SOMETHING
	db $03   	; ID $4d Chandalire Falling
	db $03   	; ID $4e Bat single diving after Simon
	db $03   	; ID $4f Sprite moving very fast to the felt
	db $00   	; ID $50 SPLASH?
	db $03   	; ID $51 FISHMAN JUMPING 
	db $03   	; ID $52 AxeKnight
	db $02   	; ID $53 AXE 0 2
	db $03   	; ID $54 Zombi Ghost Castle
	db $00   	; ID $55 NOTHING 1 CRASH SOUND? / Platform ..x100 y5d
	db $03   	; ID $56 Skelletone Whiping
	db $03   	; ID $57 HUNCHBACK 0 2
	db $03   	; ID $58 HARPIES 0 2
	db $03   	; ID $59 SpearKnight
	db $03   	; ID $5a Women Ghost
	db $03   	; ID $5b Man Ghost
	db $03   	; ID $5c Hands with skeleton knight
	db $03   	; ID $5d Bone Dragon SUB 0=nothing 18=small heart e2=G
	db $03   	; ID $5e Bone Dragon Left Side SUB19=Big heart 0=Nothi
	db $02   	; ID $5f Extoplasm Sub 1+2  
	db $02   	; ID $60 Falling Dagers
	db $06   	; ID $61 Swinging Spike Platform
	db $06   	; ID $62 Rising Spike array Sub 0 1 2
	db $00   	; ID $63 Gold Platform Disapearing Sub 0-13, Tresure C
	db $01   	; ID $64 Destroyable block array with falling routine 
	db $01   	; ID $65 Falling Blocks that stack
	db $00   	; ID $66 SINGLE HAND 0 2
	db $00   	; ID $67 ??NOTHING
	db $02   	; ID $68 Skull Watching Sub 0-9 (80-89) y80 x1b8 208 2
	db $03   	; ID $69 Skeleton Red
	db $00   	; ID $6a ??FALLING SOMETHING 0 2
	db $04   	; ID $6b CandleDog
	db $01   	; ID $6c Skelly out of celling Sub 1 4 8 c 10 y30 x100
	db $03   	; ID $6d Fuzzyball
	db $03   	; ID $6e Grabing hand
	db $03   	; ID $6f Horse head normal
	db $02   	; ID $70 Grave Digingman 
	db $03   	; ID $71 Horse head upside down
	db $03   	; ID $72 eye eye
	db $03   	; ID $73 club guy
	db $03   	; ID $74 Caterpiller Lag Monster
	db $03   	; ID $75 Gargyle with shild
	db $03   	; ID $76 Dancing Couple
	db $03   	; ID $77 ?? INVISABLE SOMETHING STANDING STILL 0 2
	db $03   	; ID $78 Bridge Falling Mask 21-37? (Bracking when mov
	db $03   	; ID $79 ?? SMALL MUD MAN MASK? CRACK SOUND WHEN DUCKI
	db $00   	; ID $7a CarpetMonster Block event (used in every stag
	db $03   	; ID $7b Coffin Circle
	db $03   	; ID $7c Gear Big SUB 0, Gear Little SUB 2, Gear Force
	db $06   	; ID $7d Gear Spike SUB 20, Sub 0 Bridge final stage, 
	db $03   	; ID $7e Headless Knight
	db $03   	; ID $7f Rockman
	
	
org $81B100		; byte table default death sound 
    dw $1521,$FF15,$FFFF,$15FF           ;81B100|        |      ;  
    dw $1F15,$1217,$5513			; $8B13
	dw $21FF           ;81B108|        |      ;  
    dw $FF13,$FFFF,$FFFF,$FFFF           ;81B110|        |      ;  
    dw $FFFF,$FFFF,$FFFF,$FFFF           ;81B118|        |      ;  
    dw $FFFF,$FFFF,$FFFF,$FFFF           ;81B120|        |      ;  
    dw $FFFF,$FFFF,$FF21,$FFFF           ;81B128|        |      ;  
    dw $1214,$5415,$161D,$FF46           ;81B130|        |      ;  
    dw $FFFF,$FFFF,$FF16,$FF40           ;81B138|        |      ;  
    dw $FFFF,$2154,$FFFF,$FFFF           ;81B140|        |      ;  
    dw $FFFF,$13FF,$FF21,$FF13           ;81B148|        |      ;  
    dw $21FF,$1512,$FF1C,$15FF           ;81B150|        |      ;  
    dw $1220,$1C53,$2121,$5221           ;81B158|        |      ;  
    dw $FFFF,$FFFF,$FFFF,$FF15           ;81B160|        |      ;  
    dw $1E15,$17FF,$21FF,$2121           ;81B168|        |      ;  
    dw $211C,$2120,$2121,$2121           ;81B170|        |      ;  
    dw $1D1D,$54FF,$FFFF,$2121           ;81B178|        |   	
	
	
	
	
;musicExperiment			; got patched.. 
;org $81B656
;  music_SrcDes_stage0: dw $A001,$3C00                       ;81B656|        |      ;  
; ;                      dl music_stage0                      ;81B65A|        |F0DD7D;  ;
;						dl newMusic 
;		
;org $FFF000		
;newMusic:
;db $79,$10,$80,$AA,$3C,$20,$3C,$30,$3C,$40,$3C,$60,$3C,$63,$00,$02
;db $3C,$00,$00,$70,$3C,$08,$3D,$45,$3D,$07,$3E,$D7,$3E,$2D,$3F,$00
;db $00,$00,$00,$DE,$3F,$50,$40,$E5,$40,$43,$41,$A9,$41,$5F,$42,$00
;db $00,$00,$00,$0E,$43,$9A,$43,$20,$44,$7B,$44,$DE,$44,$7B,$45,$00
;db $00,$00,$00,$12,$46,$A7,$46,$34,$47,$9D,$47,$12,$48,$99,$48,$00
;db $00,$00,$00,$21,$49,$DA,$49,$4F,$4A,$B4,$4A,$1C,$4B,$AF,$4B,$00
;db $00,$00,$00,$43,$4C,$DD,$4C,$1A,$4D,$70,$4D,$1D,$4E,$73,$4E,$00
;db $00,$00,$00,$E7,$1B,$ED,$BE,$E1,$0A,$E5,$E0,$0B,$12,$69,$A8,$E0
;db $0A,$06,$A4,$E0,$0D,$0C,$6F,$AF,$E0,$0B,$18,$67,$A8,$A8,$E0,$0D
;db $0C,$6F,$AF,$E6,$03,$00,$00,$E0,$0B,$12,$69,$A8,$E0,$0A,$06,$A4
;db $E0,$0D,$0C,$6F,$AF,$E0,$0B,$18,$67,$A8,$E0,$0D,$18,$6F,$AF,$0C
;db $AF,$E5,$E0,$0B,$12,$69,$A8,$E0,$0A,$06,$A4,$E0,$0D,$0C,$6F,$AF
;db $E0,$0B,$18,$67,$A8,$A8,$E0,$0D,$0C,$7F,$AF,$E6,$04,$00,$00,$E1
;db $07,$06,$C9,$12,$69,$AF,$E1,$0E,$12,$63,$AF,$E1,$04,$12,$61,$AF
;db $E1,$0A,$03,$62,$AF,$03,$63,$AF,$03,$65,$AF,$03,$66,$AF,$03,$77
;db $AF,$15,$6F,$AF,$E0,$0B,$60,$A8,$3C,$C9,$E0,$0D,$03,$67,$AF,$03
;db $6F,$AF,$06,$AF,$AF,$0C,$6F,$AF,$06,$AF,$00,$E0,$01,$E7,$1B,$ED
;db $F0,$F4,$00,$E1,$0A,$E5,$18,$1F,$A1,$0C,$5F,$A1,$30,$6F,$9F,$0C
;db $7F,$A4,$24,$1F,$C8,$30,$6F,$9D,$06,$3F,$9F,$9F,$18,$1F,$A1,$0C
;db $5F,$A1,$30,$6F,$9F,$0C,$7F,$A4,$24,$1F,$C8,$3C,$6F,$9D,$E6,$02
;db $00,$00,$60,$C9,$60,$1F,$A1,$C9,$E0,$06,$E7,$1B,$ED,$41,$F4,$0A
;db $E1,$03,$0C,$C9,$0C,$6F,$B4,$B2,$B0,$E1,$06,$B2,$B0,$AF,$E1,$03
;db $B4,$B2,$B0,$E1,$06,$B2,$B0,$AF,$E1,$0A,$B0,$AF,$AD,$E1,$0D,$AF
;db $AD,$AB,$E1,$10,$B4,$B2,$B0,$E1,$12,$B2,$B0,$AF,$E1,$14,$B0,$AF
;db $AD,$AF,$AD,$AB,$0C,$65,$A9,$C9,$E1,$03,$0C,$6F,$B4,$B2,$B0,$E1
;db $06,$B2,$B0,$AF,$E1,$03,$B4,$B2,$B0,$E1,$06,$B2,$B0,$AF,$E1,$0A
;db $B0,$AF,$AD,$E1,$0D,$AF,$AD,$AB,$E1,$10,$B4,$B2,$B0,$E1,$12,$B2
;db $B0,$AF,$E1,$14,$B0,$AF,$AD,$AF,$AD,$AB,$0C,$65,$A9,$06,$C9,$E0
;db $04,$ED,$78,$E1,$0D,$F4,$07,$FB,$9B,$32,$00,$C9,$06,$6F,$B9,$B8
;db $B5,$B7,$B3,$B5,$B1,$0C,$B3,$06,$B0,$0C,$B5,$06,$B3,$B7,$B3,$0C
;db $BE,$0C,$6B,$BE,$0C,$6F,$BE,$0C,$6B,$BE,$BE,$BE,$0C,$6F,$BE,$0C
;db $6B,$BE,$0C,$6F,$BE,$0C,$6B,$BE,$0C,$6F,$BE,$0C,$6B,$BE,$0C,$6F
;db $BE,$0C,$6B,$BE,$0C,$6F,$BE,$06,$6B,$BE,$E0,$06,$E7,$1B,$ED,$46
;db $E1,$03,$F4,$00,$F4,$07,$E3,$00,$01,$00,$06,$C9,$0C,$65,$B4,$B2
;db $B0,$E1,$06,$B2,$B0,$06,$AF,$E1,$0A,$0C,$6F,$B0,$AF,$AD,$E1,$0D
;db $AF,$AD,$AB,$E1,$10,$B4,$B2,$B0,$E1,$12,$B2,$B0,$AF,$E1,$14,$B0
;db $AF,$AD,$AF,$AD,$AB,$0C,$67,$A9,$E1,$10,$0C,$63,$B4,$B2,$B0,$E1
;db $12,$B2,$B0,$AF,$C9,$E1,$03,$0C,$6F,$B4,$B2,$B0,$E1,$06,$B2,$B0
;db $AF,$E1,$0A,$B0,$AF,$AD,$E1,$0D,$AF,$AD,$AB,$E1,$10,$B4,$B2,$B0
;db $E1,$12,$B2,$B0,$AF,$E1,$14,$B0,$AF,$AD,$AF,$AD,$AB,$0C,$67,$A9
;db $E1,$10,$0C,$63,$B4,$B2,$B0,$E1,$12,$B2,$B0,$AF,$C9,$E0,$04,$ED
;db $78,$E1,$07,$FB,$9B,$32,$00,$C9,$06,$3F,$AD,$AC,$A9,$AB,$A7,$A9
;db $A5,$0C,$A7,$06,$A4,$0C,$A9,$06,$A7,$AB,$A7,$0C,$B9,$0C,$3B,$B9
;db $0C,$3F,$B9,$0C,$3B,$B9,$0C,$3F,$B9,$0C,$3B,$B9,$0C,$3F,$B9,$0C
;db $3B,$B9,$0C,$3F,$B9,$0C,$3B,$B9,$0C,$3F,$B9,$0C,$3B,$B9,$0C,$3F
;db $B9,$0C,$3B,$B9,$0C,$3F,$B9,$06,$3B,$B9,$E0,$04,$E7,$1B,$ED,$DC
;db $E1,$0A,$F4,$00,$FB,$9B,$32,$00,$18,$6F,$B9,$B9,$B9,$12,$B9,$06
;db $B9,$E5,$C9,$12,$B9,$18,$B9,$B9,$12,$B9,$06,$B9,$E6,$07,$00,$00
;db $ED,$C8,$C9,$B9,$B8,$B5,$B7,$B3,$B5,$B1,$0C,$B3,$06,$B0,$0C,$B5
;db $06,$B3,$B7,$B3,$E5,$0C,$BE,$0C,$6B,$BE,$0C,$6F,$BE,$0C,$6B,$BE
;db $0C,$6F,$BE,$0C,$6B,$BE,$0C,$6F,$BE,$0C,$6B,$BE,$E6,$02,$00,$00
;db $E0,$06,$E7,$1B,$ED,$5F,$F4,$00,$E1,$03,$0C,$6F,$B4,$B2,$B0,$E1
;db $06,$B2,$B0,$AF,$E1,$03,$B4,$B2,$B0,$E1,$06,$B2,$B0,$AF,$E1,$0A
;db $B0,$AF,$AD,$E1,$0D,$AF,$AD,$AB,$E1,$10,$B4,$B2,$B0,$E1,$12,$B2
;db $B0,$AF,$E1,$14,$B0,$AF,$AD,$AF,$AD,$AB,$0C,$65,$A9,$C9,$E1,$03
;db $0C,$6F,$B4,$B2,$B0,$E1,$06,$B2,$B0,$AF,$E1,$03,$B4,$B2,$B0,$E1
;db $06,$B2,$B0,$AF,$E1,$0A,$B0,$AF,$AD,$E1,$0D,$AF,$AD,$AB,$E1,$10
;db $B4,$B2,$B0,$E1,$12,$B2,$B0,$AF,$E1,$14,$B0,$AF,$AD,$AF,$AD,$AB
;db $0C,$65,$A9,$C9,$E0,$04,$ED,$C8,$E1,$0A,$F4,$00,$FB,$9B,$32,$00
;db $06,$C9,$06,$3F,$AD,$AC,$A9,$AB,$A7,$A9,$A5,$0C,$A7,$06,$A4,$0C
;db $A9,$06,$A7,$AB,$A7,$E5,$0C,$B9,$0C,$3B,$B9,$0C,$3F,$B9,$0C,$3B
;db $B9,$0C,$3F,$B9,$0C,$3B,$B9,$0C,$3F,$B9,$0C,$3B,$B9,$E6,$02,$00
;db $00,$E7,$1C,$ED,$BE,$E1,$0A,$E0,$0B,$18,$69,$A8,$E0,$0D,$0C,$6F
;db $AF,$E0,$0B,$24,$67,$A8,$E0,$0D,$0C,$6F,$AF,$E0,$0B,$0C,$67,$A9
;db $E5,$E0,$0B,$18,$69,$A8,$E0,$0D,$0C,$6F,$AF,$E0,$0B,$18,$67,$A8
;db $0C,$A8,$E0,$0D,$18,$6F,$AF,$E6,$03,$00,$00,$E0,$0B,$0C,$69,$A8
;db $0C,$67,$A8,$E0,$0D,$0C,$6F,$AF,$E0,$0B,$24,$67,$A8,$E0,$0D,$0C
;db $6F,$AF,$E0,$0B,$0C,$67,$A8,$E5,$E0,$0B,$18,$69,$A8,$E0,$0D,$0C
;db $6F,$AF,$E0,$0B,$18,$67,$A8,$0C,$A8,$E0,$0D,$18,$6F,$AF,$E6,$03
;db $00,$00,$00,$E0,$01,$E7,$1C,$ED,$E6,$E1,$0A,$F4,$00,$24,$1F,$A1
;db $18,$1F,$A1,$0C,$5F,$A6,$18,$1F,$A8,$24,$1F,$A1,$18,$1F,$A1,$0C
;db $5F,$A6,$06,$3F,$A8,$AB,$0C,$5F,$A8,$24,$1F,$A1,$18,$1F,$A1,$0C
;db $5F,$A6,$12,$2F,$AB,$06,$3F,$A9,$0C,$5F,$A8,$06,$3F,$9E,$12,$2F
;db $A0,$18,$1F,$B4,$0C,$5F,$A6,$12,$2F,$A8,$06,$3F,$AA,$0C,$5F,$AB
;db $06,$3F,$A9,$12,$2F,$AB,$18,$1F,$AB,$0C,$5F,$A4,$12,$2F,$A6,$06
;db $3F,$A6,$0C,$5F,$AB,$06,$3F,$A9,$12,$2F,$AB,$18,$1F,$AB,$0C,$5F
;db $A4,$A6,$AB,$24,$1F,$A1,$18,$1F,$A1,$0C,$5F,$A6,$12,$2F,$A8,$06
;db $3F,$A8,$0C,$5F,$AC,$06,$3F,$9C,$12,$2F,$A0,$18,$1F,$AC,$0C,$5F
;db $A6,$06,$3F,$A8,$AC,$0C,$5F,$A8,$E0,$08,$E7,$1C,$ED,$69,$E1,$0A
;db $F4,$00,$24,$3F,$B9,$24,$3B,$B8,$18,$39,$B4,$12,$39,$B7,$B6,$0C
;db $B2,$12,$B6,$12,$3B,$B4,$0C,$3D,$AF,$54,$3F,$B0,$06,$6D,$B4,$B2
;db $5A,$3D,$B4,$06,$C9,$0C,$1F,$B9,$06,$6D,$B7,$0C,$1E,$B9,$12,$3D
;db $BC,$30,$3F,$B9,$0C,$1F,$B7,$06,$6F,$B5,$0C,$1F,$B7,$12,$3F,$B9
;db $24,$B5,$0C,$B7,$06,$6F,$B9,$0C,$1F,$BB,$B7,$0C,$3E,$B2,$36,$7F
;db $B4,$54,$3F,$C8,$0C,$B8,$E0,$08,$E7,$1C,$ED,$4B,$F4,$00,$F4,$0A
;db $E1,$0D,$E3,$17,$23,$41,$06,$C9,$24,$3F,$B9,$24,$3B,$B8,$18,$39
;db $B4,$12,$39,$B7,$B6,$0C,$B2,$12,$B6,$12,$3B,$B4,$0C,$3D,$AF,$54
;db $3F,$B0,$06,$6D,$B4,$B2,$5A,$3D,$B4,$06,$C9,$0C,$1D,$B9,$06,$1B
;db $B7,$0C,$1C,$B9,$12,$3B,$BC,$30,$3D,$B9,$0C,$1D,$B7,$06,$6D,$B5
;db $0C,$1D,$B7,$12,$3D,$B9,$24,$B5,$0C,$B7,$06,$6D,$B9,$0C,$1D,$BB
;db $B7,$0C,$3D,$B2,$36,$7D,$B4,$4E,$3F,$C8,$0C,$B8,$E0,$04,$E7,$1C
;db $ED,$B4,$E1,$08,$F4,$00,$FB,$9B,$32,$00,$0C,$6F,$C0,$0C,$6B,$C0
;db $0C,$6F,$C0,$0C,$6B,$C0,$0C,$6F,$C0,$0C,$6B,$C0,$0C,$6F,$C0,$0C
;db $6B,$C0,$0C,$6F,$BB,$0C,$6B,$BB,$0C,$6F,$BB,$0C,$6B,$BB,$0C,$6F
;db $BB,$0C,$6B,$BB,$0C,$6F,$BB,$0C,$6B,$BB,$0C,$6F,$BC,$0C,$6B,$BC
;db $E1,$0A,$ED,$BE,$0C,$6F,$BC,$0C,$6B,$BC,$0C,$6F,$BC,$0C,$6B,$BC
;db $0C,$6F,$BC,$0C,$6B,$BC,$0C,$6F,$BE,$0C,$6B,$BE,$0C,$6F,$BE,$0C
;db $6B,$BE,$0C,$6F,$BE,$0C,$6B,$BE,$0C,$6F,$BE,$0C,$6B,$BE,$18,$C9
;db $0C,$B4,$B4,$B5,$B5,$B5,$B5,$18,$C9,$0C,$B7,$B7,$BC,$BC,$BC,$BC
;db $ED,$B4,$0C,$6F,$C0,$0C,$6B,$C0,$0C,$6F,$C0,$0C,$6B,$C0,$0C,$6F
;db $C0,$0C,$6B,$C0,$0C,$6F,$C0,$0C,$6B,$C0,$0C,$6F,$BB,$0C,$6B,$BB
;db $0C,$6F,$BB,$0C,$6B,$BB,$0C,$6F,$BC,$0C,$6B,$BC,$0C,$6F,$BC,$0C
;db $6B,$BC,$E0,$04,$E7,$1C,$ED,$B4,$E1,$0C,$F4,$00,$F4,$0A,$FB,$9B
;db $32,$00,$0C,$6F,$B9,$0C,$6B,$B9,$0C,$6F,$B9,$0C,$6B,$B9,$0C,$6F
;db $B9,$0C,$6B,$B9,$0C,$6F,$B9,$0C,$6B,$B9,$0C,$6F,$B7,$0C,$6B,$B7
;db $0C,$6F,$B7,$0C,$6B,$B7,$0C,$6F,$B7,$0C,$6B,$B7,$0C,$6F,$B7,$0C
;db $6B,$B7,$0C,$6F,$B9,$0C,$6B,$B9,$E0,$05,$ED,$73,$E1,$07,$06,$3B
;db $AD,$AF,$B0,$B4,$B9,$B8,$B4,$B0,$B7,$B6,$B0,$06,$6B,$AF,$18,$79
;db $AC,$0C,$67,$A1,$0C,$69,$A0,$0C,$6A,$A4,$0C,$6B,$A3,$0C,$6D,$A8
;db $0C,$6F,$A6,$48,$6D,$AB,$0C,$AB,$A8,$60,$6F,$A9,$E0,$04,$E1,$0D
;db $ED,$B4,$FB,$9B,$32,$00,$0C,$B9,$0C,$6B,$B9,$0C,$6F,$B9,$0C,$6B
;db $B9,$0C,$6F,$B9,$0C,$6B,$B9,$0C,$6F,$B9,$0C,$6B,$B9,$0C,$6F,$B8
;db $0C,$6B,$B8,$0C,$6F,$B8,$0C,$6B,$B8,$B5,$B5,$0C,$6F,$B5,$0C,$6B
;db $B5,$E7,$1C,$ED,$BE,$E1,$0A,$E0,$0B,$18,$69,$A8,$E0,$0D,$0C,$6F
;db $AF,$E0,$0B,$24,$67,$A8,$E0,$0D,$0C,$6F,$AF,$E0,$0B,$0C,$67,$A9
;db $E5,$E0,$0B,$18,$69,$A8,$E0,$0D,$0C,$6F,$AF,$E0,$0B,$18,$67,$A8
;db $0C,$A8,$E0,$0D,$18,$6F,$AF,$E6,$03,$00,$00,$E0,$0B,$0C,$69,$A8
;db $0C,$67,$A8,$E0,$0D,$0C,$6F,$AF,$E0,$0B,$24,$67,$A8,$E0,$0D,$0C
;db $6F,$AF,$E0,$0B,$0C,$67,$A8,$E5,$E0,$0B,$18,$69,$A8,$E0,$0D,$0C
;db $6F,$AF,$E0,$0B,$18,$67,$A8,$0C,$A8,$E0,$0D,$18,$6F,$AF,$E6,$02
;db $00,$00,$E0,$0B,$18,$69,$A8,$E0,$0D,$06,$6F,$AF,$AF,$0C,$AF,$E0
;db $0B,$18,$67,$A8,$E0,$0D,$06,$6F,$AF,$AF,$AF,$AF,$00,$E0,$01,$E7
;db $1C,$ED,$E6,$E1,$0A,$F4,$00,$24,$1F,$A1,$18,$A1,$0C,$5F,$A6,$18
;db $1F,$A8,$24,$A1,$18,$A1,$0C,$5F,$A6,$06,$3F,$A8,$AB,$0C,$5F,$A8
;db $24,$1F,$A1,$18,$A1,$0C,$5F,$A6,$12,$2F,$AB,$06,$3F,$A9,$0C,$5F
;db $A8,$06,$3F,$9C,$12,$2F,$A0,$18,$1F,$B4,$0C,$5F,$A6,$12,$2F,$A8
;db $06,$3F,$AA,$0C,$5F,$AB,$06,$3F,$A9,$12,$2F,$AB,$18,$1F,$AB,$0C
;db $5F,$A4,$A6,$AB,$AB,$06,$3F,$A9,$12,$2F,$AB,$18,$1F,$AB,$0C,$5F
;db $A4,$A6,$A4,$24,$1F,$A1,$18,$A1,$0C,$5F,$A6,$12,$2F,$A8,$06,$3F
;db $A8,$0C,$5F,$AC,$06,$3F,$9C,$1E,$5F,$A0,$0C,$AC,$A6,$0C,$6F,$B8
;db $06,$B7,$B8,$E0,$08,$E7,$1C,$ED,$69,$E1,$0A,$F4,$00,$24,$3F,$B9
;db $30,$3B,$B8,$0C,$39,$B4,$12,$39,$B7,$12,$3B,$B6,$0C,$3D,$B2,$12
;db $3B,$B6,$12,$3D,$B4,$0C,$3E,$AF,$54,$3F,$B0,$06,$B4,$06,$3D,$B2
;db $60,$B4,$0C,$3F,$B4,$06,$3D,$B2,$0C,$3E,$B4,$12,$3D,$B5,$30,$3F
;db $B2,$0C,$B2,$06,$B0,$0C,$B2,$12,$B4,$24,$B0,$0C,$AF,$06,$B0,$0C
;db $B2,$AF,$0C,$3E,$AB,$FB,$9B,$DD,$00,$36,$3F,$AD,$60,$C8,$E0,$08
;db $E7,$1C,$ED,$4B,$E1,$0D,$F4,$00,$F4,$0A,$E3,$17,$23,$41,$2A,$3F
;db $B9,$30,$3B,$B8,$06,$39,$B4,$ED,$64,$12,$39,$B4,$12,$3B,$B2,$0C
;db $3D,$AF,$12,$3B,$B2,$12,$3D,$B0,$0C,$3E,$AB,$ED,$46,$5A,$3D,$B0
;db $06,$B4,$06,$3B,$B2,$60,$B4,$0C,$3D,$B4,$06,$3B,$B2,$0C,$3C,$B4
;db $12,$3B,$B5,$30,$3D,$B2,$0C,$3D,$B2,$06,$B0,$0C,$B2,$12,$B4,$24
;db $B0,$0C,$AF,$06,$B0,$0C,$B2,$AF,$AB,$FB,$9B,$DD,$00,$36,$AD,$5A
;db $C8,$E0,$04,$E7,$1C,$ED,$B4,$E1,$08,$F4,$00,$FB,$9B,$32,$00,$0C
;db $6F,$C0,$0C,$6B,$C0,$0C,$6F,$C0,$0C,$6B,$C0,$0C,$6F,$C0,$0C,$6B
;db $C0,$0C,$6F,$C0,$0C,$6B,$C0,$0C,$6F,$BB,$0C,$6B,$BB,$0C,$6F,$BB
;db $0C,$6B,$BB,$0C,$6F,$BB,$0C,$6B,$BB,$0C,$6F,$BB,$0C,$6B,$BB,$0C
;db $6F,$BC,$0C,$6B,$BC,$0C,$6F,$BC,$0C,$6B,$BC,$0C,$6F,$BC,$0C,$6B
;db $BC,$0C,$6F,$BC,$0C,$6B,$BC,$0C,$6F,$BE,$0C,$6B,$BE,$0C,$6F,$BE
;db $0C,$6B,$BE,$0C,$6F,$BE,$0C,$6B,$BE,$0C,$6F,$BE,$0C,$6B,$BE,$B4
;db $B4,$B4,$B4,$B5,$B5,$B5,$B5,$B7,$B7,$B7,$B7,$BC,$BC,$BC,$BC,$B9
;db $B9,$B9,$B9,$B9,$B9,$B9,$B9,$ED,$C8,$06,$6F,$BE,$BE,$0C,$BE,$06
;db $B8,$B8,$0C,$B8,$06,$BB,$0C,$BB,$06,$BB,$B2,$B2,$0C,$B2,$E0,$04
;db $E7,$1C,$ED,$B4,$E1,$0C,$F4,$0A,$FB,$9B,$32,$00,$0C,$6F,$B9,$0C
;db $6B,$B9,$0C,$6F,$B9,$0C,$6B,$B9,$0C,$6F,$B9,$0C,$6B,$B9,$0C,$6F
;db $B9,$0C,$6B,$B9,$0C,$6F,$B7,$0C,$6B,$B7,$0C,$6F,$B7,$0C,$6B,$B7
;db $0C,$6F,$B7,$0C,$6B,$B7,$0C,$6F,$B7,$0C,$6B,$B7,$B9,$B9,$E0,$05
;db $ED,$73,$E1,$07,$06,$3B,$AD,$AF,$B0,$B4,$06,$2B,$B9,$B8,$06,$3B
;db $B4,$B0,$B7,$B6,$B0,$AF,$30,$69,$AC,$E0,$04,$ED,$A0,$FB,$9B,$64
;db $00,$0C,$67,$AF,$0C,$69,$AC,$0C,$6B,$B4,$0C,$6C,$AF,$60,$6B,$B7
;db $B5,$60,$69,$B9,$E0,$04,$ED,$C8,$E1,$0C,$F4,$0A,$FB,$9B,$32,$00
;db $06,$6D,$C1,$C1,$0C,$C1,$06,$BB,$BB,$0C,$BB,$06,$BE,$0C,$BE,$06
;db $BE,$B5,$B5,$0C,$B5,$E7,$1C,$ED,$BE,$E1,$0A,$E0,$0D,$06,$6F,$AF
;db $AF,$E0,$0B,$0C,$69,$AB,$E0,$0D,$0C,$6F,$AF,$E0,$0B,$06,$67,$AB
;db $E0,$0D,$12,$69,$AF,$0C,$65,$AF,$06,$62,$AF,$E0,$0B,$12,$67,$A9
;db $E5,$E0,$0B,$18,$69,$AB,$E0,$0D,$0C,$6F,$AF,$E0,$0B,$18,$67,$AB
;db $0C,$AB,$E0,$0D,$18,$6F,$AF,$E6,$03,$00,$00,$E0,$0B,$18,$69,$AF
;db $E0,$0D,$0C,$6F,$AF,$E0,$0B,$24,$67,$A4,$E0,$0D,$0C,$6F,$AF,$E0
;db $0B,$0C,$67,$A4,$E5,$E0,$0B,$18,$69,$AB,$E0,$0D,$0C,$6F,$AF,$E0
;db $0B,$18,$67,$AB,$0C,$AB,$E0,$0D,$18,$6F,$AF,$E6,$02,$00,$00,$E0
;db $0B,$18,$69,$AB,$E0,$0D,$06,$6F,$AF,$AF,$0C,$AF,$E0,$0B,$18,$67
;db $AB,$E0,$0D,$06,$6F,$AF,$AF,$AF,$AF,$00,$E0,$01,$E7,$1C,$ED,$E6
;db $F4,$00,$E1,$0A,$18,$C9,$12,$2F,$A8,$06,$3F,$A3,$A8,$A7,$0C,$5F
;db $A8,$9F,$A2,$18,$1F,$A3,$06,$3F,$A7,$A3,$A7,$12,$2F,$A3,$0C,$5F
;db $A8,$06,$3F,$AB,$AB,$AA,$AB,$AB,$12,$2F,$A6,$24,$1F,$A6,$0C,$4F
;db $A1,$0C,$5F,$A6,$A1,$18,$1F,$A6,$0C,$5F,$A6,$18,$1F,$A1,$0C,$5F
;db $A6,$A1,$A4,$18,$1F,$AD,$12,$2F,$AD,$06,$3F,$AD,$0C,$5F,$AD,$24
;db $1F,$A8,$18,$1F,$A8,$12,$2F,$A8,$06,$3E,$A8,$0C,$5F,$A8,$24,$1F
;db $A3,$18,$1F,$AF,$12,$2F,$AF,$06,$3F,$AF,$0C,$5F,$AF,$18,$1F,$AA
;db $06,$3F,$AD,$AA,$18,$1F,$AF,$12,$2F,$AF,$06,$3F,$AF,$0C,$5F,$AF
;db $AA,$06,$3F,$AA,$AC,$AD,$AD,$E0,$08,$E7,$1C,$ED,$6E,$F4,$00,$E1
;db $0A,$FB,$96,$D2,$00,$18,$C9,$0C,$3F,$B7,$B6,$B7,$B6,$0C,$3E,$B4
;db $0C,$3F,$B0,$B6,$0C,$3E,$B4,$3C,$39,$AF,$0C,$38,$AF,$54,$3D,$B4
;db $E0,$05,$ED,$64,$E1,$08,$06,$6A,$A6,$06,$6D,$A8,$12,$1E,$BB,$12
;db $0E,$B9,$0C,$1E,$B4,$12,$0A,$B9,$12,$1B,$B6,$0C,$1B,$B2,$3C,$1A
;db $B0,$0C,$1F,$A8,$0C,$1C,$AB,$0C,$1D,$B2,$3C,$1B,$AF,$0C,$19,$AB
;db $0C,$18,$AF,$0C,$1B,$B6,$54,$1D,$B2,$06,$4D,$B2,$B4,$60,$1D,$B6
;db $E0,$05,$E7,$1C,$ED,$78,$F4,$00,$F4,$0A,$E1,$07,$E3,$00,$01,$00
;db $FB,$96,$D2,$00,$18,$C9,$0C,$1F,$AF,$AD,$0C,$1F,$AF,$AE,$0C,$1E
;db $AB,$0C,$1F,$A8,$AD,$0C,$1E,$AB,$3C,$1F,$A7,$0C,$1E,$A8,$54,$3B
;db $AB,$E0,$05,$ED,$46,$F4,$14,$E1,$07,$06,$C9,$06,$6A,$A6,$06,$6D
;db $A8,$12,$1E,$BB,$12,$0E,$B9,$0C,$1E,$B4,$12,$0A,$B9,$12,$1B,$B6
;db $0C,$6B,$B2,$3C,$6A,$B0,$0C,$1F,$A8,$0C,$1C,$AB,$0C,$1D,$B2,$3C
;db $1B,$AF,$0C,$19,$AB,$0C,$18,$AF,$0C,$1B,$B6,$54,$1D,$B2,$06,$4D
;db $B2,$B4,$5A,$1D,$B6,$E0,$07,$E7,$1C,$ED,$5A,$F4,$00,$E1,$08,$FB
;db $96,$D2,$00,$18,$C9,$06,$3B,$B6,$BB,$C0,$BB,$B4,$AF,$B4,$B7,$C0
;db $BB,$B7,$B6,$B4,$B6,$B7,$BB,$C0,$BB,$B7,$BB,$B7,$B4,$B7,$B4,$AF
;db $AB,$AF,$B4,$E5,$B2,$B4,$B5,$B2,$B4,$B9,$BE,$B9,$B2,$B4,$B5,$B9
;db $BE,$B9,$B5,$B4,$E6,$02,$00,$00,$AD,$AF,$B0,$B4,$B9,$B4,$B0,$AF
;db $AD,$AF,$B0,$B4,$B9,$B4,$B0,$AF,$B4,$B6,$B7,$BB,$C0,$BB,$B7,$B6
;db $B4,$B6,$B7,$BB,$C0,$BB,$B7,$B6,$BB,$B1,$B2,$B6,$BB,$B6,$B2,$B1
;db $BB,$B1,$B2,$B6,$BB,$B6,$B2,$B1,$AF,$B1,$B2,$B6,$BB,$B6,$B2,$B1
;db $BB,$B1,$B2,$06,$3F,$B6,$ED,$82,$BB,$B8,$B5,$B2,$E0,$07,$E7,$1C
;db $ED,$37,$F4,$00,$F4,$07,$E1,$0C,$FB,$96,$D2,$00,$1E,$C9,$06,$3B
;db $B6,$BB,$C0,$BB,$B4,$AF,$B4,$B7,$C0,$BB,$B7,$B6,$B4,$B6,$B7,$BB
;db $C0,$BB,$B7,$BB,$B7,$B4,$B7,$B4,$AF,$AB,$AF,$B4,$E5,$B2,$B4,$B5
;db $B2,$B4,$B9,$BE,$B9,$B2,$B4,$B5,$B9,$BE,$B9,$B5,$B4,$E6,$02,$00
;db $00,$AD,$AF,$B0,$B4,$B9,$B4,$B0,$AF,$AD,$AF,$B0,$B4,$B9,$B4,$B0
;db $AF,$B4,$B6,$B7,$BB,$C0,$BB,$B7,$B6,$B4,$B6,$B7,$BB,$C0,$BB,$B7
;db $B6,$BB,$B1,$B2,$B6,$BB,$B6,$B2,$B1,$BB,$B1,$B2,$B6,$BB,$B6,$B2
;db $B1,$AF,$B1,$B2,$B6,$BB,$B6,$B2,$B1,$BB,$B1,$B2,$ED,$5A,$06,$3F
;db $B6,$BB,$B8,$B5,$E7,$1C,$ED,$BE,$E1,$0A,$E0,$0D,$06,$6F,$AF,$0C
;db $AF,$06,$AF,$0C,$AF,$E0,$0B,$06,$67,$AB,$E0,$0D,$12,$69,$AF,$0C
;db $65,$AF,$06,$62,$AF,$E0,$0B,$12,$67,$A9,$E5,$E0,$0B,$18,$69,$AB
;db $E0,$0D,$0C,$6F,$AF,$E0,$0B,$18,$67,$AB,$0C,$AB,$E0,$0D,$18,$6F
;db $AF,$E6,$02 
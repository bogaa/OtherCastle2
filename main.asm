;NOTES!!
; - cofine turning and shooting crosses. Fight death. Appear as skelleton
; - grakul jumps over you
; - monster warp fast and throw stuff
; $b8 disables event collecting items?? 
; $13c0 simon cant move timer 
; elevator in stage 13 for curienTK
; fix save file to store progress and ora since points and stuff.. 

;lorom

!deathCounter = 1
!removeGFXreuse = 0

!hotFixWhipCancle = 1				; always check ring with whip 
!NoFatalCrusherHit = 1
!BatRing = 1						; code in baseRomTweaks
!removeTimer = 1
!removeGFXreuse = 0
!HeartDependendMultishot = 1
!lastSlotFixedRing = 0
!practice = 0
!levelSelect = 0
!freeScrolling = 0					; broken 
!reUseBrkblBlock = 1
!simonIdleAnimation = 1
!subWeaponDropOnPickup = 1
!extraSpritesOnScreen = 0
!invertRingGlitchControll = 1
!swordSkellyHitboxFix = 1
!jpWhipSound = 1
!radio = 0
!moonwalk = 1
!newSecondQuestStartLevel = 1 

;NEW RAM ALLOCATION IN FREERAM ------- till $1e7f----------------------------------------
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
!flagSkipBoss = $1e2c			; needs to be cleard when implementing game save 
!stairFixCounter = $1e2e
!layer2ScrollBehavier = $1e30 
!bafferRam = $1e32				; just make sure not to use it twice in a level
!noWhipSwitch = $1e34			; probably use a other way TODO
!logicRingControlls = $1e36		; above rings controlls are inverted try to fix this here
!killedHusband = $1e38
!aramusBelmontCross = $1e3a
!costumMusicNumber = $1e3c 	
!dogLeash = $1e3e

!jobTable00	= $1e40			; 
!jobTable01	= $1e42
!jobTable02	= $1e44
!jobTable03	= $1e46

!autoScroll = $1e48				; 1 scroll right ..only auto scroll added. Cool would be to add all direction and have part of it beeing the scroll speed 


!fishCatchedFlag = $19c0		; breakable wall table start till 19ff
!bridgDragonProgress = $19c2
!bridgDragonSpawn = $19c4		; breakable wall table start till 19ff
!bridgDragonLeangth = $19c6		; breakable wall table start till 19ff
!bridgDragonHealthHud = $19c8		; breakable wall table start till 19ff
!bridgDragonRamPointer = $19ca		; array.. breakable wall table start till 19ff


!jobTextDisplay = $7fff88		; job text display 2c size
incsrc code/labels.asm

org $80810D
;LDA.W #$0040                         ;subw default 2X

; freeSpace at  $81B7BC-81b902 
; freeSpace at	$A49000-A4FFFF ??
; freeSpace at 	$ff8a00		
;				$80C5BF-80C647

;110000 collusion tables ROM offset
;org $20c000 LvlTransitionTable


;entrances a78000 ROM 138000

;SPRITEASSEMBLY l2590 tutorialHackTweak
;GFX some are in pointer and need to be plit for some reason??

org $a08000							; free Space startpoint !!org $a0f000 freeSpace PrePatch
pushPC

incsrc code/baseRomTweaks.asm		
;incsrc code/jobs.asm 				; will be applied to the ROM beforehand  
incsrc code/textEngine.asm 
;incsrc code/tutorialHackTweak.asm	; moved for space 

pullPC
warnPC $a0c000
org $A49000
pushPC 

incsrc code/tutorialHackTweak.asm
incsrc code/tutorialBosses.asm
incsrc code/mapSRAM.asm
incsrc code/bloodDripTitle.asm

pullPC
warnPC $a4ffff

;incsrc code/enemiePointer.asm		; will be applied to the ROM beforehand  
incsrc code/text.asm

if !practice == 1
incsrc code/practice.asm 
endif

;incsrc code/NewEnemies/oldManEvID0d.asm 

check bankcross off
org $F6A57D
	simonSpriteData00:
		dw $2004
		db $80
			incbin ".GFX/simonSheet.bin":($0000)-($1fff) 

org $F6C5FD
	simonSpriteData01:
		dw $2003
		db $80
			incbin ".GFX/simonSheet.bin":($2000)-($3fff) 
			
org $F6E65D
	simonSpriteData02:
		dw $2003
		db $80
			incbin ".GFX/simonSheet.bin":($4000)-($5fff) 		

org $F786BD
	simonSpriteData03:
		dw $2003
		db $80
			incbin ".GFX/simonSheet.bin":($6000)-($7fff) 				
			
org $F7A71D
	simonSpriteData04:
		dw $2003
		db $80
			incbin ".GFX/simonSheet.bin":($8000)-($9fff) 		

org $F7C77D
	simonSpriteData05:
		dw $2003
		db $80
			incbin ".GFX/simonSheet.bin":($a000)-($bfff) 	
			
org $F7E7DD
	simonSpriteData06:
		dw $2003
		db $80
			incbin ".GFX/simonSheet.bin":($c000)-($dfff) 		
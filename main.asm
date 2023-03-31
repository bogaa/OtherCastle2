;NOTES!!
; - cofine turning and shooting crosses. Fight death. Appear as skelleton
; - grakul jumps over you
; - monster warp fast and throw stuff
; $b8 disables event collecting items?? 
; $13c0 simon cant move timer 

;lorom

!deathCounter = 1
!removeGFXreuse = 0

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
!flagSkipBoss = $1e2c			; needs to be cleard when implementing game save 
!stairFixCounter = $1e2e
!layer2ScrollBehavier = $1e30 
!bafferRam = $1e32				; just make sure not to use it twice in a level
!noWhipSwitch = $1e34			; probably use a other way TODO


!jobTable00	= $1e40			; 
!jobTable01	= $1e42
!jobTable02	= $1e44
!jobTable03	= $1e46

!jobTextDisplay = $7fff88		; job text display 2c size
incsrc code/labels.asm

org $80810D
;LDA.W #$0040                         ;subw default 2X

; freeSpace at  $81B7BC-81b902 
; freeSpace at	$A49000-A4FFFF ??
; freeSpace at 	$ff8a00		
;				$80C5BF-80C647

org $a08000							; free Space startpoint !!org $a0f000 freeSpace PrePatch
pushPC

incsrc code/baseRomTweaks.asm		
;incsrc code/jobs.asm 				; will be applied to the ROM beforehand  
incsrc code/textEngine.asm 
incsrc code/tutorialHackTweak.asm

pullPC
warnPC $a0c000
org $A49000
pushPC 

incsrc code/tutorialBosses.asm
incsrc code/mapSRAM.asm

pullPC
warnPC $a4ffff

;incsrc code/enemiePointer.asm		; will be applied to the ROM beforehand  
incsrc code/text.asm

if !practice == 1
incsrc code/practice.asm 
endif

;incsrc code/NewEnemies/oldManEvID0d.asm 



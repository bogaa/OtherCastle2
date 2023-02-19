; frank teleport and throw pottle
; mummy fast teleport and walk
; dancer as second form of dracula
; gaibon reapearing in castle
; koranot new jump
; get cursed and fight him as a dead belmont
; blue armore health regan



$001C = !RAM_bg1CamXpos,
$001E = !RAM_bg1CamYpos,
$0020 = !RAM_buttonPress,
$0022 = !RAM_buttonPressPlayer2,
$0028 = !RAM_buttonPressCurFram,
$002A = !RAM_buttonPressCurFramPlayer2,
$0032 = !RAM_gameState,					; 04 runs main game 06 PW Screen 	
$0034 = !RAM_subGameState,
$003A = !RAM_frameCounter,
$003E = !RAM_blackFadeCounter,
$0040 = !RAM_whiteFadeCounter,
$0042 = !RAM_transpEffectBG,
$0044 = !RAM_transoEffectSprite,
$0046 = !RAM_scrollAndMode7_setting,
$0048 = !RAM_pointerCG_WRAM,
;4c index title or intro screen??
;50 Hud Update offset?? size ??
$0054 = !RAM_SFXReadLPtr_Set,
$0056 = !RAM_SFXReadLPtr_Active,
$0066 = !RAM_pauseFlag,
$0070 = !RAM_mainGameState,
$0078 = !RAM_frameCounter_effectiv,		;00,NameScreen Init, 01 02 03 04 loading, 05 mainGame, 06 Loading with Fade, 07 gameover, 08 SimonFreez, 09 WinScreenScores..
$007A = !RAM_SFX_Ptr_Repeat,
$007C = !RAM_simon_Lifes,
$007E = !RAM_simon_PointsTillExtraLife,
$0080 = !RAM_simon_ForceGroundBehavier,
$0082 = !RAM_level_type,
$0084 = !RAM_simon_DamageDeBuff,
$0086 = !RAM_currentLevel,
$0088 = !RAM_setSecondQuest,
$008C = !RAM_disableHUDupdate,
$008E = !RAM_simon_subWeapon,			; #$1a.. dagger, axe, holy, cross, clock
$0090 = !RAM_simon_multiShot,
$0092 = !RAM_simon_whipType,
$0094 = !RAM_pointerEventTracker01,
$0096 = !RAM_pointerEventTracker02,
$009D = !RAM_spritePrioManip,
$00A0 = !RAM_camLockLeft,
$00A2 = !RAM_camLockRight,
$00A4 = !RAM_camLockTop,
$00A6 = !RAM_camLockBottom,
$00A8 = !RAM_BG1_XposScrollSpeed,
$00AA = !RAM_BG1_YposScrollSpeed,
$00AC = !RAM_whip_Hit_Disable_CounterFlag,
$00AE = !RAM_IndexSpecialLevelBehavier,		; HardcodedLevelStuffIndex 01 bg rising plaform, 03 garden BG tiles 
$00BA = !RAM_subweapon_Hit_Disable_CounterFlag,
$00B6 = !RAM_FlagAllowOutOfBounce,
;$00b8 = !RAM_BossFlag					; needs to be set while bossfight 
$00BC = !RAM_simon_invulnerable_counter,
$00BE = !RAM_buttonMapJump,
$00C0 = !RAM_buttonMapWhip,
$00C2 = !RAM_buttonMapSubWep,
$00C8 = !RAM_collusionDataPointer,			; 24 bit
$00E6 = !RAM_RNG_1,
$00E8 = !RAM_RNG_2,		
$00EA = !RAM_RNG_3,
$00F2 = !RAM_HUD_RenderFlag,
$00F4 = !RAM_free00cleared,
$00F6 = !RAM_gameOverStuffs,
$00F8 = !RAM_free01cleared,
$00FA = !RAM_free02cleared,
$00FC = !RAM_XregSlotCurrent,
$0100 = !RAM_SFX_Buffer100ByteLong,

$0240 = !RAM_whipSlot01,
$0280 = !RAM_whipSlot02,
$02C0 = !RAM_whipSlot03,
$0300 = !RAM_whipSlot04,
$0340 = !RAM_whipSlot05,
$0380 = !RAM_whipSlot06,
$03C0 = !RAM_whipSlot07,
$0400 = !RAM_whipSlot08,

$0440 = !RAM_subWepSlot00,
$0480 = !RAM_subWepSlot01,
$04C0 = !RAM_subWepSlot02,

$0500 = !RAM_sparkSlot,

$0540 = !RAM_simonSlot,
$0542 = !RAM_simonSlot_spritePriority,
$0544 = !RAM_simonSlot_spriteAttributeFlipMirror,
$0546 = !RAM_simonSlot_empty00,
$0548 = !RAM_simonSlot_subXpos,
$054A = !RAM_simonSlot_Xpos,
$054C = !RAM_simonSlot_subYpos,
$054E = !RAM_simonSlot_Ypos,
$0550 = !RAM_simonSlot_empty01,
$0552 = !RAM_simonSlot_State,
$0554 = !RAM_simonSlot_empty02,
$0556 = !RAM_simonSlot_StateBackUp,
$0558 = !RAM_simonSlot_SpeedSubXpos,
$055A = !RAM_simonSlot_SpeedXpos,
$055C = !RAM_simonSlot_SpeedSubYpos,
$055E = !RAM_simonSlot_SpeedYpos,
$0560 = !RAM_simonSlot_AnimationCounter,
$0562 = !RAM_simonSlot_SubAnimationCounter,
$0566 = !RAM_simonSlot_SpriteAttributeSub_Pallete,
$056C = !RAM_simonSlot_Collusion_Donno00,
$056E = !RAM_simonSlot_forceCrouchFrameCounter,
$0576 = !RAM_simonSlot_Collusion_Donno01,
$0578 = !RAM_simonSlot_direction,

$0580 = !RAM_eventSlot_Base,
			!event_slot_assembly = $00  ;X default Table offset
			;02 attribute
			;04 flip mirror attribute
			!event_slot_health = $06 
			!event_slot_xPosSub = $08  
			!event_slot_xPos = $0A  
			!event_slot_yPosSub = $0C  
			!event_slot_yPos = $0E  
			!event_slot_id = $10  
			!event_slot_state = $12  
			!event_slot_subId = $14
			;16  
			!event_slot_xSpdSub = $18  
			!event_slot_xSpd = $1A  
			!event_slot_ySpdSub = $1C  
			!event_slot_ySpd = $1E  
			;20
			;22
			;24
			!event_slot_SpriteAdr = $26  
			!event_slot_HitboxXpos = $28  
			!event_slot_HitboxYpos = $2a 
			;2c movment? 3 ghost,
			!event_slot_Hitbox = $2e         ;47 hitable? a=? b=? c=? d=?   e=9? f=GetHurtSubW g=GetHurtWhip h=GetHit  9 collect? 
			;	h = 01 hurt 
			;	g = 02 subWea hitable 
			;	f = 04 whip hitable 
			;	e = 08 collect able also needs bit 01 set 
			;	d = 10 ??
			;	c = 20 
			;	b = 40 used often .. rossery??
			;	a = 80 
			!event_slot_mask = $30
			;32 movement logic??


$0F00 = !RAM_OAM_Page,
$1120 = !RAM_FreeRamPage_E0_byte_not_cleard,

$1200 = !RAM_channel_W_0_paletteAnimation,
$1210 = !RAM_channel_W_1_paletteAnimation,
$1220 = !RAM_channel_W_2_paletteAnimation,
$1230 = !RAM_channel_W_3_paletteAnimation,
$1240 = !RAM_channel_W_4_paletteAnimation,
$1250 = !RAM_channel_W_5_paletteAnimation,
$1260 = !RAM_channel_W_6_paletteAnimation,
$1270 = !RAM_channel_W_7_paletteAnimation,

$1280 = !RAM_BG1_ScrollingSlot,
$12C0 = !RAM_BG2_ScrollingSlot,
$1300 = !RAM_BG3_ScrollingSlot,

	;$1280 cam0
	;00 Xpos
	;14
	;16
	;18 ypos 
	;1a
	;
	;22 buffer yPos Scroll
	
	;$12c0 cam1
	;12d8 ypos Cam1
	
	;1380 mode7 slot
	;1384 mod7 stretch ypos 
	;1386 mod7 stretch xpos 
	;1388 mod7 rotation 


$13A0 = !RAM_enemieIDSlotAssignPPUTable,
; $13c0 = !RAM_counterStopPlayerMovement,
$13D0 = !RAM_ScrollBG1SyncSpeed,
$13D2 = !RAM_ScrollBG3SyncSpeed,
$13D4 = !RAM_deathEntrance,
$13E2 = !RAM_currentMusicTrack,
$13EC = !RAM_simonStat_whipUpgradDropFlag,
$13F0 = !RAM_simonStat_Timer,
$13F2 = !RAM_simonStat_Hearts,
$13F4 = !RAM_simonStat_Health_HUD,
$13F6 = !RAM_boss_Health_HUD,
$13FA = !RAM_simonStat_stopWatchTimer,

$1480 = !RAM_channel_DMA_0,
$1490 = !RAM_channel_DMA_1,
$14A0 = !RAM_channel_DMA_2,
$14B0 = !RAM_channel_DMA_3,
$14C0 = !RAM_channel_DMA_4,
$14D0 = !RAM_channel_DMA_5,
$14E0 = !RAM_channel_DMA_6,
$14F0 = !RAM_channel_DMA_7,

$1500 = !RAM_masktTable_respawnEvents,

$1602 = !RAM_secretStage6_Floor_Flag,		; floor stage 6		; 00 can enter, 01 will use second exit, 02 cant use secret
$1604 = !RAM_secret_Flag,					; suckhole stage 9	; 00 can enter, 01 will use second exit, 02 cant use secret
;$19c0 = !RAM_breakableWallsCollectedFlags, till $19ff (cleard on death) 
;$1a00 = ,,
$1C00 = !RAM_state_Map_Scene,
$1E02 = !RAM_titleScreen_menuSelect,
$1E0A = !RAM_characterString_Castlevania4,	
$1E16 = !RAM_monoSound_flag,

$1E18 = !RAM_freeSpaceTill_1e7f_exeptOptionsMenu,
$1E2E = !RAM_freeSpaceTill_1e7f,

$1E80 = !RAM_blackFade,
$1E84 = !RAM_PPU_Mode,
$1E86 = !RAM_sprite_size_mode,
$1E8A = !RAM_mosaicEffect_Value_BG,
$1F40 = !RAM_scoreLow,
$1F42 = !RAM_scoreHigh,
$1F86 = !RAM_simon_Jump_State,
$1F88 = !RAM_simon_Mud_State,
$1F8A = !RAM_simonStat_direction,
$1FA2 = !RAM_simonStat_Stuck,


; --------------- lables2ADD -----------------
; all documented labels.. !!


; --------------- WRAM Section $7e0000 bank -----------------
;2c00 DMA Table? 
;7e3c00 - 7e5fff collusion 
;7e6000 - 7e7fff block and collusion map 
;7f0000 - 7fffff GFX SimonsSpriteSheet and animated tiles..

; freeSpace
; $a08000-$a0c000 
; $A49000-$a4ffff
; $a7c400-$a7ffff 
; $fe8000-$ffffff

; --------------- WRAM Section $7e0000 bank -----------------
;2c00 DMA Table? 
;7e3c00 - 7e4fff collusion 734000??
;7E6000 
;7EC000 
;7f0000 - 7fffff GFX SimonsSpriteSheet and animated tiles..

; --------------- HackFlags ------------------------------
; !textEngineState = $1E18	; write 2 to write text and 1 to terminate

; ----------------- Notes -----------------------------

;110000 collusion tables ROM offset
;org $20c000 LvlTransitionTable

;entrances a78000 ROM 138000
;freeSpace bank: 8c,9e,9f.. 

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


; ================= trash 
; -------------- more Notes --------------------------

; 8ec91b 		;bg0 cave tilemap 81f9eb,y 
; $13D2 ;table for bg0 mapping UNREACH_85C248

; 85c8ce    	;paralexeffects?? 85c846 index for effects

; usefull routines:
; jsl $80d7f1 	; search for empty event slot. Returns with right slot offset in X.
; CODE_82FFC0 ; put A onto 70 and loads level based on expandet Table
; jsl $82C218		;Medusa movement ??

; 8181B0 table entery scrolling?
; 81adc8 hitbox table blocks 80db77 hitroutine

; 7e3c00 - 7e4fff collusion
; 81df57 visual update when block is destroyed y x cordinat 


; LDX #$B3FE ;chainWhip GFX org $80df12
; JSL $8280E8		D7B5 E6B4 1AB5 03B5 A7B5 CEB5 67E2 7DB4 9AB4 49F3 45B5 67B5 ;81 is the bank for the ponter
; tracing   0004 VRam low 0006 source 0009 size  ;org 008d06 ;;7e2800
;OC1 softlock stage4, easyModeWrongContinueA, RingHightWaterfall, Stage2 rework/boss ,remove timer, gate , birds climnb 3, visual save crusher 4, hear reset stage5Gaibon
;0C1 checkpoint secret??,  grakul door  , zapfbat slog exit ending stage 2 

; next project
; run with limp and pick up some items like switches.
; cape simon and p meter. Also short kong only up haha with barrwls!!
; get cursed and fight as a dead belmont

; gold stage banana hoard. 
; gold stage inomenal room when going back. gold to skelettons and blood 

; dancing secion with arrow like step mania. Give Simon black dress with gold strips.. may be disco black color glim 

; pitctures RBMchok, TLB dance club, eatitup, 
; add tip backentrance to town.. why is it open? trader?

; EXTRA tip hook on medua rings when they are high to go under things 
; remove getting 0 hearts when dieng


; done
; BBQ souce with pizza souce sweet spicy though PC Smokin' Stampede Beer & Chipotle BBQ
; tip duck in grass to find wirrling things 
; dancer bumping

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
$004C = !RAM_introScreenIndex,
$0050 = !RAM_VRAM_updateSize,
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
$0098 = !RAM_camBuffer_80_eventSpawn,
$009A = !RAM_eventSpawnDirection,
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
$00B4 = !$RAM_Cam_yPosTob
$00B6 = !RAM_FlagAllowOutOfBounce,
$00b8 = !RAM_BossFlag					; needs to be set while bossfight also used as index for damage 81b180 
$00BC = !RAM_simon_invulnerable_counter,
$00BE = !RAM_buttonMapJump,
$00C0 = !RAM_buttonMapWhip,
$00C2 = !RAM_buttonMapSubWep,
$00C8 = !RAM_collusionDataPointer,			; 24 bit
$00E6 = !RAM_RNG_1,
$00E8 = !RAM_RNG_2,		
$00EA = !RAM_RNG_3,
$00F0 = !RAM_HUD_RenderFlag,
$00F4 = !RAM_free00cleared,
$00F6 = !RAM_gameOverStuffs,
$00F8 = !RAM_free01cleared,
$00FA = !RAM_free02cleared,
$00FC = !RAM_XregSlotCurrent,
$00FE = !RAM_currentEventROM,
$0100 = !RAM_SFX_Buffer100ByteLong,

$0212 = !RAM_whipState 				; 06 ringDetermainSwingPos, 07 RingSwing
$0240 = !RAM_whipSlot01,
$0280 = !RAM_whipSlot02,
$022E = !RAM_whipDisableMovement 	; movement
$02BC = !RAM_SubWep_useTimer 		; movement
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
$0574 = !RAM_simonSlot_RingSpeed,
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
			;	c = 20 type 2 event type flag (to use clear/respawn table 1500)
			;	b = 40 used often .. rossery??
			;	a = 80 noDespawn			; messes with other stuff?? Bosses not hitable??
			!event_slot_mask = $30
			;32 movement logic??


$0F00 = !RAM_OAM_Page,
;						RAM_OAM_PROPERTY_BITS = $1100-$111f					   ;      | 

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

	;$1280 	;cam0
	;$1280	;00 Xpos Current
	;$1288	;18 XposSub 
	;$128a	;1a Xpos 
	;$1292	;12 pixleAdvanced?? 

	;$1298	;18 YposCurrent 
	;$12a0	;20 YposSub 
	;$12a2	;22 Ypos 
	
	;$12ba 	; flag stop cam movment all 
	
	;$12c0 cam1
	;12d8 ypos Cam1
	
	;1380 mode7 slot
	;1384 mod7 stretch ypos 
	;1386 mod7 stretch xpos 
	;1388 mod7 rotation 


$13A0 = !RAM_enemieIDSlotAssignPPUTable,
$13c0 = !RAM_counterStopPlayerMovement,
$13D0 = !RAM_ScrollBG1SyncSpeed,
$13D2 = !RAM_ScrollBG3SyncSpeed,
$13D4 = !RAM_deathEntrance,
	  
$13DC = !RAM_ring_platformTracking,
$13DE = !RAM_OAM_BaseYpos,
$13E2 = !RAM_currentMusicTrack,
$13EC = !RAM_simonStat_whipUpgradDropFlag,
$13F0 = !RAM_simonStat_Timer,
$13F2 = !RAM_simonStat_Hearts,
$13F4 = !RAM_simonStat_Health_HUD,
$13F6 = !RAM_boss_Health_HUD,
$13FA = !RAM_simonStat_stopWatchTimer,

$1400 = !Ram_collusionTableSimon, ; - 1434 

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
$19c0 = !RAM_breakableWall_Flags, 			; till $19ff (cleard on death) 
$1A00 = !RAM_loadingStuff,

$1C00 = !RAM_state_Map_Scene,
$1E02 = !RAM_titleScreen_menuSelect,
$1E0A = !RAM_characterString_Castlevania4,	
$1E16 = !RAM_monoSound_flag,

$1E18 = !RAM_freeSpaceTill_1e7f_exeptOptionsMenu,
$1E2E = !RAM_freeSpaceTill_1e7f,

$1E80 = !RAM_blackFade,
$1e82 = !RAM_autoMoveNMIreg
$1E84 = !RAM_PPU_Mode,
$1E86 = !RAM_sprite_size_mode,

$1E8A = !RAM_mosaicEffect_Value_BG,

$1E9e = !RAM_MOD7_X_stretch_A		; horiz Stratch
$1Ea0 = !RAM_MOD7_shear_B			; share
$1Ea2 = !RAM_MOD7_shear_C			; share 
$1Ea4 = !RAM_MOD7_Y_Stretch_D 		; vertic Stratch 
$1Ea6 = !RAM_MOD7_scrollXpos
$1Ea8 = !RAM_MOD7_scrollYpos
$1Eaa = !RAM_MOD7_x	
$1Eac = !RAM_MOD7_x

$1F40 = !RAM_scoreLow,
$1F42 = !RAM_scoreHigh,
$1F86 = !RAM_simon_Jump_State,
$1F88 = !RAM_simon_Mud_State,
$1F8A = !RAM_simonStat_direction,
$1FA2 = !RAM_simonStat_Stuck,


; --------------- lables2ADD -----------------


; --------------- WRAM Section $7e0000 bank -----------------
;2c00 DMA Table? 
;7e3c00 - 7e5fff collusion 
;7e6000 - 7e7fff block and collusion map 
;7E8000 blockMap_array 
;7f0000 - 7fffff GFX SimonsSpriteSheet and animated tiles..


; freeSpace at  $81B7BC-81b902 ??
; freeSpace at	$A49000-A4FFFF ??	
; freeSpace at	$80C5BF-80C647 ?? once you use idle 

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

;0A03	State0 DeathEntrance
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

; 81adc8 hitbox table blocks 80db77 hitroutine

; 7e3c00 - 7e4fff collusion
; 81df57 visual update when block is destroyed y x cordinat 


; LDX #$B3FE ;chainWhip GFX org $80df12
; JSL $8280E8		D7B5 E6B4 1AB5 03B5 A7B5 CEB5 67E2 7DB4 9AB4 49F3 45B5 67B5 ;81 is the bank for the ponter
; tracing   0004 VRam low 0006 source 0009 size  ;org 008d06 ;;7e2800


;0
;1	
;2	
;3	
;4
;5
;6
;7
;8
;9
;a
;b
;c
;d
;e
;f
;10
;11
;12
;13
;14
;15
;16
;17
;18
;19
;1a
;1b
;1c
;1d
;1e
;1f
;20
;21
;22
;23
;24
;25
;26
;27
;28
;29
;2a
;2b
;2c
;2d
;2e
;2f
;30
;31
;32
;33
;34
;35
;36
;37
;38
;39
;3a
;3b
;3c
;3d
;3e
;3f
;40
;41
;42
;43
;44
;45
;46
;47
;48
;49
;4a
;4b
;4c
;4d
;4e
;4f
;50
;51
;52
;53
;54
;55
;56
;57
;58
;59
;5a
;5b
;5c
;5d
;5e
;5f
;60
;61
;62
;63
;64
;65
;66
;67
;68
;69
;6a
;6b
;6c
;6d
;6e
;6f
;70
;71
;72
;73
;74
;75
;76
;77
;78
;79
;7a
;7b
;7c
;7d
;7e
;7f
;
;80
;81	
;82	
;83	
;84
;85
;86
;87
;88
;89
;8a
;8b
;8c
;8d
;8e
;8f
;90
;91
;92
;93
;94
;95
;96
;97
;98
;99
;9a
;9b
;9c
;9d
;9e
;9f
;a0
;a1
;a2
;a3
;a4
;a5
;a6
;a7
;a8
;a9
;aa
;ab
;ac
;ad
;ae
;af
;b0
;b1
;b2
;b3
;b4
;b5
;b6
;b7
;b8
;b9
;ba
;bb
;bc
;bd
;be
;bf
;c0
;c1
;c2
;c3
;c4
;c5
;c6
;c7
;c8
;c9
;ca
;cb
;cc
;cd
;ce
;cf
;d0
;d1
;d2
;d3
;d4
;d5
;d6
;d7
;d8
;d9
;da
;db
;dc
;dd
;de
;df
;e0
;e1
;e2
;e3
;e4
;e5
;e6
;e7
;e8
;e9
;ea
;eb
;ec
;ed
;ee
;ef
;f0
;f1
;f2
;f3
;f4
;f5
;f6
;f7
;f8
;f9
;fa
;fb
;fc
;fd
;fe
;ff
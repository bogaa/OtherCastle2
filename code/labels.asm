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
	gravetyFallCalculation2000:     
org $82B459
	gravetyFallCalculation4000:      
org $82D647
	getPixleOffsetXposAwayFromSimon:			
org $80CF86
	readCollusionTable7e4000:       
org $80D7CC
	calculateSpriteSlotOffset_ID_atRam1a:
org $80859E
	musicFixFlagCheck:
org $808584
	muteMusic:                 		   
org $82B0EE
	resetRAM22And24:              
org $82B0E0
	clearSpeedValuesAll:           			   
org $82B0E9
	clearSpeedValuesX:
org $82B0E4
	clearSpeedValuesY:             
org $82AFEE
	deathDivingYspeed:              
org $82FFC0
	SC4ed_LvL_transitHandler:
org $80CDEE
    skellyGravity: 
org $82939F
	clearEventTableBeforBoss:
org $8280E8
	miscGFXloadRoutineXPlus81Bank:  
org $80E096 	
	collideWithSimonCheck:					   
					   RAM_X_event_slot_sprite_assembly = $000000
					   RAM_X_event_slot_attribute = $000002
					   RAM_X_event_slot_flip_mirror_attribute = $000004
					   RAM_X_event_slot_event_slot_health = $000006;      |        |      ;  
                       RAM_X_event_slot_xPosSub = $000008   ;      |        |      ;  
                       RAM_X_event_slot_xPos = $00000A      ;      |        |      ;  
                       RAM_X_event_slot_yPosSub = $00000C   ;      |        |      ;  
                       RAM_X_event_slot_yPos = $00000E      ;      |        |      ;  
                       RAM_X_event_slot_ID = $000010        ;      |        |      ;  
                       RAM_X_event_slot_state = $000012     ;      |        |      ;  
                       RAM_X_event_slot_subId = $000014     ;      |        |      ;  
                       RAM_X_event_slot_16 = $000016        ;      |        |      ;  
                       RAM_X_event_slot_xSpdSub = $000018   ;      |        |      ;  
                       RAM_X_event_slot_xSpd = $00001A      ;      |        |      ;  
                       RAM_X_event_slot_ySpdSub = $00001C   ;      |        |      ;  
                       RAM_X_event_slot_ySpd = $00001E      ;      |        |      ;  
                       RAM_X_event_slot_20 = $000020        ;      |        |      ;  
                       RAM_X_event_slot_22 = $000022        ;      |        |      ;  
                       RAM_X_event_slot_24 = $000024        ;      |        |      ;  
                       RAM_X_event_slot_SpriteAdr = $000026 ;      |        |      ;  
                       RAM_X_event_slot_HitboxXpos = $000028;      |        |      ;  
                       RAM_X_event_slot_HitboxYpos = $00002A;      |        |      ;  
                       RAM_X_event_slot_Movement2c = $00002C;      |        |      ;  
                       RAM_X_event_slot_HitboxID = $00002E  ;      |        |      ;  
                       RAM_X_event_slot_mask = $000030      ;      |        |      ;  
                       RAM_X_event_slot_32 = $000032        ;      |        |      ;  
                       RAM_X_event_slot_34 = $000034        ;      |        |      ;  
                       RAM_X_event_slot_36 = $000036        ;      |        |      ;  
                       RAM_X_event_slot_38 = $000038        ;      |        |      ;  
                       RAM_X_event_slot_3a = $00003A        ;      |        |      ;  
                       RAM_X_event_slot_3c = $00003C        ;      |        |      ;  
                       RAM_X_event_slot_3e = $00003E        ;      |        |      ;   
					   RAM_general = $000000                ;      |        |      ;  
                       RAM_bg1CamXpos = $00001C             ;      |        |      ;  
                       RAM_bg1CamYpos = $00001E             ;      |        |      ;  
                       RAM_buttonPress = $000020            ;      |        |      ;  
                       RAM_buttonPressCurFram = $000028     ;      |        |      ;  
                       RAM_gameState = $000032              ;      |        |      ;  
                       RAM_subGameState = $000034           ;      |        |      ;  
                       RAM_frameCounter = $00003A           ;      |        |      ;  
                       RAM_blackFadeCounter = $00003E       ;      |        |      ;  
                       RAM_whiteFadeCounter = $000040       ;      |        |      ;  
                       RAM_transpEffectBG = $000042         ;      |        |      ;  
                       RAM_transoEffectSprite = $000044     ;      |        |      ;  
                       RAM_mode7Mode = $000046              ;      |        |      ;  
                       RAM_pointerCG_WRAM = $000048         ;      |        |      ;  
                       RAM_SFXReadLPtr_Set = $000054        ;      |        |      ;  
                       RAM_SFXReadLPtr_Active = $000056     ;      |        |      ;  
                       RAM_pauseFlag = $000066              ;      |        |      ;  
                       RAM_mainGameState = $000070          ;      |        |      ;  
                       RAM_frameCounter_effectiv = $000078  ;      |        |      ;  
                       RAM_SFX_Ptr_Repeat = $00007A         ;      |        |      ;  
                       RAM_simon_Lifes = $00007C            ;      |        |      ;  
                       RAM_simon_PointsTillExtraLife = $00007E;      |        |      ;  
                       RAM_simon_ForceGroundBehavier = $000080;      |        |      ;  
                       RAM_simon_DamageDeBuff = $000084     ;      |        |      ;  
                       RAM_currentLevel = $000086           ;      |        |      ;  
                       RAM_setSecondQuest = $000088         ;      |        |      ;  
                       RAM_disableHUDupdate = $00008C       ;      |        |      ;  
                       RAM_simon_subWeapon = $00008E        ;      |        |      ;  
                       RAM_simon_multiShot = $000090        ;      |        |      ;  
                       RAM_simon_whipType = $000092         ;      |        |      ;  
                       RAM_pointerEventTracker01 = $000094  ;      |        |      ;  
                       RAM_pointerEventTracker02 = $000096  ;      |        |      ;  
                       RAM_spritePrioManip = $00009C        ;      |        |      ;  
                       RAM_camLockLeft = $0000A0            ;      |        |      ;  
                       RAM_camLockRight = $0000A2           ;      |        |      ;  
                       RAM_camLockTop = $0000A4             ;      |        |      ;  
                       RAM_camLockBottom = $0000A6          ;      |        |      ;  
                       RAM_BG1_XposScrollSpeed = $0000A8    ;      |        |      ;  
                       RAM_BG1_YposScrollSpeed = $0000AA    ;      |        |      ;  
                       RAM_IndexSpecialLevelBehavier = $0000AE;      |        |      ;  
						RAM_WhipCancleTimer = $0000ac                      
						RAM_SubweaponCancleTimer = $0000ba       
					   RAM_FlagAllowOutOfBounce = $0000B6   ;      |        |      ;  
                        RAM_FlagBossFight = $0000B8 
					   RAM_simon_invulnerable_counter = $0000BC;      |        |      ;  
                       RAM_buttonMapJump = $0000BE          ;      |        |      ;  
                       RAM_buttonMapWhip = $0000C0          ;      |        |      ;  
                       RAM_buttonMapSubWep = $0000C2        ;      |        |      ;  
                       RAM_RNG_1 = $0000E6                  ;      |        |      ;  
                       RAM_RNG_2 = $0000E8                  ;      |        |      ;  
                       RAM_RNG_3 = $0000EA                  ;      |        |      ;  
                       RAM_HUD_RenderFlag = $0000F2         ;      |        |      ;  
                       RAM_free00cleared = $0000F4          ;      |        |      ;  
                       RAM_gameOverStuffs = $0000F6         ;      |        |      ;  
                       RAM_free01cleared = $0000F8          ;      |        |      ;  
                       RAM_free02cleared = $0000FA          ;      |        |      ;  
                       RAM_XregSlotCurrent = $0000FC        ;      |        |      ;  
                       RAM_SFX_Buffer100ByteLong = $000100  ;      |        |      ;  
                       RAM_whipSlot00 = $000200             ;      |        |      ;  
                       RAM_whipSlot01 = $000240             ;      |        |      ;  
                       RAM_whipSlot02 = $000280             ;      |        |      ;  
                        RAM_SubWep_useTimer = $0002bc 
					   RAM_whipSlot03 = $0002C0             ;      |        |      ;  
                       RAM_whipSlot04 = $000300             ;      |        |      ;  
						RAM_whipLangthOnRing = $00033c

                       RAM_whipSlot05 = $000340             ;      |        |      ;  
                       RAM_whipSlot06 = $000380             ;      |        |      ;  
                       RAM_whipSlot07 = $0003C0             ;      |        |      ;  
                       RAM_whipSlot08 = $000400             ;      |        |      ;  
                       RAM_subWepSlot00 = $000440           ;      |        |      ;  
                       RAM_subWepSlot01 = $000480           ;      |        |      ;  
                       RAM_subWepSlot02 = $0004C0           ;      |        |      ;  
                       RAM_sparkSlot = $000500              ;      |        |      ;  
                       RAM_simonSlot = $000540              ;      |        |      ;  
                       RAM_simonSlot_spritePriority = $000542;      |        |      ;  
                       RAM_simonSlot_spriteAttributeFlipMirror = $000544;      |        |      ;  
                       RAM_simonSlot_empty00 = $000546      ;      |        |      ;  
                       RAM_simonSlot_subXpos = $000548      ;      |        |      ;  
                       RAM_simonSlot_Xpos = $00054A         ;      |        |      ;  
                       RAM_simonSlot_subYpos = $00054C      ;      |        |      ;  
                       RAM_simonSlot_Ypos = $00054E         ;      |        |      ;  
                       RAM_simonSlot_empty01 = $000550      ;      |        |      ;  
                       RAM_simonSlot_State = $000552        ;      |        |      ;  
                       RAM_simonSlot_empty02 = $000554      ;      |        |      ;  
                       RAM_simonSlot_StateBackUp = $000556  ;      |        |      ;  
                       RAM_simonSlot_SpeedSubXpos = $000558 ;      |        |      ;  
                       RAM_simonSlot_SpeedXpos = $00055A    ;      |        |      ;  
                       RAM_simonSlot_SpeedSubYpos = $00055C ;      |        |      ;  
                       RAM_simonSlot_SpeedYpos = $00055E    ;      |        |      ;  
                       RAM_simonSlot_AnimationCounter = $000560;      |        |      ;  
                       RAM_simonSlot_SubAnimationCounter = $000562;      |        |      ;  
                       RAM_simonSlot_SpriteAttributeSub_Pallete = $000566;      |        |      ;  
                       RAM_simonSlot_Collusion_Donno00 = $00056C;      |        |      ;  
                       RAM_simonSlot_forceCrouchFrameCounter = $00056E;      |        |      ;  
                       RAM_simonSlot_Collusion_Donno01 = $000576;      |        |      ;  
 
					   RAM_simonSlot_direction = $000578    ;      |        |      ;  
                       RAM_eventSlot_Base = $000580         ;      |        |      ;  
                       RAM_OAM_Page = $000F00    
 
                       RAM_FreeRamPage_E0_byte_not_cleard = $001120;      |        |      ;  
                       RAM_channel_W_0_paletteAnimation = $001200;      |        |      ;  
                       RAM_channel_W_1_paletteAnimation = $001210;      |        |      ;  
                       RAM_channel_W_2_paletteAnimation = $001220;      |        |      ;  
                       RAM_channel_W_3_paletteAnimation = $001230;      |        |      ;  
                       RAM_channel_W_4_paletteAnimation = $001240;      |        |      ;  
                       RAM_channel_W_5_paletteAnimation = $001250;      |        |      ;  
                       RAM_channel_W_6_paletteAnimation = $001260;      |        |      ;  
                       RAM_channel_W_7_paletteAnimation = $001270;      |        |      ;  
                       RAM_BG1_ScrollingSlot = $001280      ;      |        |      ;  
                       RAM_BG2_ScrollingSlot = $0012C0      ;      |        |      ;  
                       RAM_BG3_ScrollingSlot = $001300      ;      |        |      ;  
                       RAM_enemieIDSlotAssignPPUTable = $0013A0;      |        |      ;  
                       RAM_ScrollBG1SyncSpeed = $0013D0     ;      |        |      ;  
                       RAM_ScrollBG3SyncSpeed = $0013D2     ;      |        |      ;  
                       RAM_deathEntrance = $0013D4          ;      |        |      ;  

					   RAM_currentMusicTrack = $0013E2      ;      |        |      ;  
                       RAM_simonStat_whipUpgradDropFlag = $0013EC;      |        |      ;  
                       RAM_simonStat_Timer = $0013F0        ;      |        |      ;  
                       RAM_simonStat_Hearts = $0013F2       ;      |        |      ;  
                       RAM_simonStat_Health_HUD = $0013F4   ;      |        |      ;  
                       RAM_boss_Health_HUD = $0013F6        ;      |        |      ;  
                       RAM_simonStat_stopWatchTimer = $0013FA;      |        |      ;  
                       RAM_channel_DMA_0 = $001480          ;      |        |      ;  
                       RAM_channel_DMA_1 = $001490          ;      |        |      ;  
                       RAM_channel_DMA_2 = $0014A0          ;      |        |      ;  
                       RAM_channel_DMA_3 = $0014B0          ;      |        |      ;  
                       RAM_channel_DMA_4 = $0014C0          ;      |        |      ;  
                       RAM_channel_DMA_5 = $0014D0          ;      |        |      ;  
                       RAM_channel_DMA_6 = $0014E0          ;      |        |      ;  
                       RAM_channel_DMA_7 = $0014F0          ;      |        |      ;  
                       RAM_masktTable_respawnEvents = $001500;      |        |      ;  

					   RAM_titleScreen_menuSelect = $001E02 ;      |        |      ;  
                       RAM_characterString_Castlevania4 = $001E0A;      |        |      ;  
                       RAM_monoSound_flag = $001E16         ;      |        |      ;  
                       RAM_freeSpaceTill_1e7f_exeptOptionsMenu = $001E18;      |        |      ;  
                       RAM_freeSpaceTill_1e7f = $001E2E     ;      |        |      ;  
                       RAM_blackFade = $001E80              ;      |        |      ;  
						RAM_autoMove = $001e82 ;82 auto move right 81 standart ?? 
					   RAM_PPU_Mode = $001E84               ;      |        |      ;  
                       RAM_sprite_size_mode = $001E86       ;      |        |      ;  
                       RAM_mosaicEffect_Value_BG = $001E8A  ;      |        |      ;  
                       RAM_scoreLow = $001F40               ;      |        |      ;  
                       RAM_scoreHigh = $001F42  
						RAM_81_simon_Mud_State = $001f88					   ;      |        |      ;  
                       RAM_simonStat_direction = $001F8A    ;      |        |      ;  
                       RAM_simonStat_Stuck = $001FA2        ;      |        |      ;  
                       SNES_INIDISP = $002100               ;      |        |      ;  
                       SNES_OBJSEL = $002101                ;      |        |      ;  
                       SNES_OAMADDL = $002102               ;      |        |      ;  
                       SNES_OAMADDH = $002103               ;      |        |      ;  
                       SNES_OAMDATA = $002104               ;      |        |      ;  
                       SNES_BGMODE = $002105                ;      |        |      ;  
                       SNES_MOSAIC = $002106                ;      |        |      ;  
                       SNES_BG1SC = $002107                 ;      |        |      ;  
                       SNES_BG2SC = $002108                 ;      |        |      ;  
                       SNES_BG3SC = $002109                 ;      |        |      ;  
                       SNES_BG4SC = $00210A                 ;      |        |      ;  
                       SNES_BG12NBA = $00210B               ;      |        |      ;  
                       SNES_BG34NBA = $00210C               ;      |        |      ;  
                       SNES_BG1HOFS = $00210D               ;      |        |      ;  
                       SNES_BG1VOFS = $00210E               ;      |        |      ;  
                       SNES_BG2HOFS = $00210F               ;      |        |      ;  
                       SNES_BG2VOFS = $002110               ;      |        |      ;  
                       SNES_BG3HOFS = $002111               ;      |        |      ;  
                       SNES_BG3VOFS = $002112               ;      |        |      ;  
                       SNES_BG4HOFS = $002113               ;      |        |      ;  
                       SNES_BG4VOFS = $002114               ;      |        |      ;  
                       SNES_VMAINC = $002115                ;      |        |      ;  
                       SNES_VMADDL = $002116                ;      |        |      ;  
                       SNES_VMADDH = $002117                ;      |        |      ;  
                       SNES_VMDATAL = $002118               ;      |        |      ;  
                       SNES_VMDATAH = $002119               ;      |        |      ;  
                       SNES_M7SEL = $00211A                 ;      |        |      ;  
                       SNES_M7A = $00211B                   ;      |        |      ;  
                       SNES_M7B = $00211C                   ;      |        |      ;  
                       SNES_M7C = $00211D                   ;      |        |      ;  
                       SNES_M7D = $00211E                   ;      |        |      ;  
                       SNES_M7X = $00211F                   ;      |        |      ;  
                       SNES_M7Y = $002120                   ;      |        |      ;  
                       SNES_CGADD = $002121                 ;      |        |      ;  
                       SNES_CGDATA = $002122                ;      |        |      ;  
                       SNES_W12SEL = $002123                ;      |        |      ;  
                       SNES_W34SEL = $002124                ;      |        |      ;  
                       SNES_WOBJSEL = $002125               ;      |        |      ;  
                       SNES_WH0 = $002126                   ;      |        |      ;  
                       SNES_WH1 = $002127                   ;      |        |      ;  
                       SNES_WH2 = $002128                   ;      |        |      ;  
                       SNES_WH3 = $002129                   ;      |        |      ;  
                       SNES_WBGLOG = $00212A                ;      |        |      ;  
                       SNES_WOBJLOG = $00212B               ;      |        |      ;  
                       SNES_TM = $00212C                    ;      |        |      ;  
                       SNES_TS = $00212D                    ;      |        |      ;  
                       SNES_TMW = $00212E                   ;      |        |      ;  
                       SNES_TSW = $00212F                   ;      |        |      ;  
                       SNES_CGSWSEL = $002130               ;      |        |      ;  
                       SNES_CGADSUB = $002131               ;      |        |      ;  
                       SNES_COLDATA = $002132               ;      |        |      ;  
                       SNES_SETINI = $002133                ;      |        |      ;  
                       SNES_MPYL = $002134                  ;      |        |      ;  
                       SNES_MPYM = $002135                  ;      |        |      ;  
                       SNES_MPYH = $002136                  ;      |        |      ;  
                       SNES_SLHV = $002137                  ;      |        |      ;  
                       SNES_ROAMDATA = $002138              ;      |        |      ;  
                       SNES_RVMDATAL = $002139              ;      |        |      ;  
                       SNES_RVMDATAH = $00213A              ;      |        |      ;  
                       SNES_RCGDATA = $00213B               ;      |        |      ;  
                       SNES_OPHCT = $00213C                 ;      |        |      ;  
                       SNES_OPVCT = $00213D                 ;      |        |      ;  
                       SNES_STAT77 = $00213E                ;      |        |      ;  
                       SNES_STAT78 = $00213F                ;      |        |      ;  
                       SNES_APUIO0 = $002140                ;      |        |      ;  
                       SNES_APUIO1 = $002141                ;      |        |      ;  
                       SNES_APUIO2 = $002142                ;      |        |      ;  
                       SNES_APUIO3 = $002143                ;      |        |      ;  
                       SNES_WMDATA = $002180                ;      |        |      ;  
                       SNES_WMADDL = $002181                ;      |        |      ;  
                       SNES_WMADDM = $002182                ;      |        |      ;  
                       SNES_WMADDH = $002183                ;      |        |      ;  
                       SNES_JOY1 = $004016                  ;      |        |      ;  
                       SNES_JOY2 = $004017                  ;      |        |      ;  
                       SNES_NMITIMEN = $004200              ;      |        |      ;  
                       SNES_WRIO = $004201                  ;      |        |      ;  
                       SNES_WRMPYA = $004202                ;      |        |      ;  
                       SNES_WRMPYB = $004203                ;      |        |      ;  
                       SNES_WRDIVL = $004204                ;      |        |      ;  
                       SNES_WRDIVH = $004205                ;      |        |      ;  
                       SNES_WRDIVB = $004206                ;      |        |      ;  
                       SNES_HTIMEL = $004207                ;      |        |      ;  
                       SNES_HTIMEH = $004208                ;      |        |      ;  
                       SNES_VTIMEL = $004209                ;      |        |      ;  
                       SNES_VTIMEH = $00420A                ;      |        |      ;  
                       SNES_MDMAEN = $00420B                ;      |        |      ;  
                       SNES_HDMAEN = $00420C                ;      |        |      ;  
                       SNES_MEMSEL = $00420D                ;      |        |      ;  
                       SNES_RDNMI = $004210                 ;      |        |      ;  
                       SNES_TIMEUP = $004211                ;      |        |      ;  
                       SNES_HVBJOY = $004212                ;      |        |      ;  
                       SNES_RDIO = $004213                  ;      |        |      ;  
                       SNES_RDDIVL = $004214                ;      |        |      ;  
                       SNES_RDDIVH = $004215                ;      |        |      ;  
                       SNES_RDMPYL = $004216                ;      |        |      ;  
                       SNES_RDMPYH = $004217                ;      |        |      ;  
                       SNES_CNTRL1L = $004218               ;      |        |      ;  
                       SNES_CNTRL1H = $004219               ;      |        |      ;  
                       SNES_CNTRL2L = $00421A               ;      |        |      ;  
                       SNES_CNTRL2H = $00421B               ;      |        |      ;  
                       SNES_CNTRL3L = $00421C               ;      |        |      ;  
                       SNES_CNTRL3H = $00421D               ;      |        |      ;  
                       SNES_CNTRL4L = $00421E               ;      |        |      ;  
                       SNES_CNTRL4H = $00421F               ;      |        |      ;  
                       SNES_DMA0PARAM = $004300             ;      |        |      ;  
                       SNES_DMA0REG = $004301               ;      |        |      ;  
                       SNES_DMA0ADDRL = $004302             ;      |        |      ;  
                       SNES_DMA0ADDRM = $004303             ;      |        |      ;  
                       SNES_DMA0ADDRH = $004304             ;      |        |      ;  
                       SNES_DMA0CNTL = $004305              ;      |        |      ;  
                       SNES_DMA0CNTH = $004306              ;      |        |      ;  
                       SNES_HDMA0BANK = $004307             ;      |        |      ;  
                       SNES_DMA0IDXL = $004308              ;      |        |      ;  
                       SNES_DMA0IDXH = $004309              ;      |        |      ;  
                       SNES_HDMA0LINES = $00430A            ;      |        |      ;  
                       SNES_DMA1PARAM = $004310             ;      |        |      ;  
                       SNES_DMA1REG = $004311               ;      |        |      ;  
                       SNES_DMA1ADDRL = $004312             ;      |        |      ;  
                       SNES_DMA1ADDRM = $004313             ;      |        |      ;  
                       SNES_DMA1ADDRH = $004314             ;      |        |      ;  
                       SNES_DMA1CNTL = $004315              ;      |        |      ;  
                       SNES_DMA1CNTH = $004316              ;      |        |      ;  
                       SNES_HDMA1BANK = $004317             ;      |        |      ;  
                       SNES_DMA1IDXL = $004318              ;      |        |      ;  
                       SNES_DMA1IDXH = $004319              ;      |        |      ;  
                       SNES_HDMA1LINES = $00431A            ;      |        |      ;  
                       SNES_DMA2PARAM = $004320             ;      |        |      ;  
                       SNES_DMA2REG = $004321               ;      |        |      ;  
                       SNES_DMA2ADDRL = $004322             ;      |        |      ;  
                       SNES_DMA2ADDRM = $004323             ;      |        |      ;  
                       SNES_DMA2ADDRH = $004324             ;      |        |      ;  
                       SNES_DMA2CNTL = $004325              ;      |        |      ;  
                       SNES_DMA2CNTH = $004326              ;      |        |      ;  
                       SNES_HDMA2BANK = $004327             ;      |        |      ;  
                       SNES_DMA2IDXL = $004328              ;      |        |      ;  
                       SNES_DMA2IDXH = $004329              ;      |        |      ;  
                       SNES_HDMA2LINES = $00432A            ;      |        |      ;  
                       SNES_DMA3PARAM = $004330             ;      |        |      ;  
                       SNES_DMA3REG = $004331               ;      |        |      ;  
                       SNES_DMA3ADDRL = $004332             ;      |        |      ;  
                       SNES_DMA3ADDRM = $004333             ;      |        |      ;  
                       SNES_DMA3ADDRH = $004334             ;      |        |      ;  
                       SNES_DMA3CNTL = $004335              ;      |        |      ;  
                       SNES_DMA3CNTH = $004336              ;      |        |      ;  
                       SNES_HDMA3BANK = $004337             ;      |        |      ;  
                       SNES_DMA3IDXL = $004338              ;      |        |      ;  
                       SNES_DMA3IDXH = $004339              ;      |        |      ;  
                       SNES_HDMA3LINES = $00433A            ;      |        |      ;  
                       SNES_DMA4PARAM = $004340             ;      |        |      ;  
                       SNES_DMA4REG = $004341               ;      |        |      ;  
                       SNES_DMA4ADDRL = $004342             ;      |        |      ;  
                       SNES_DMA4ADDRM = $004343             ;      |        |      ;  
                       SNES_DMA4ADDRH = $004344             ;      |        |      ;  
                       SNES_DMA4CNTL = $004345              ;      |        |      ;  
                       SNES_DMA4CNTH = $004346              ;      |        |      ;  
                       SNES_HDMA4BANK = $004347             ;      |        |      ;  
                       SNES_DMA4IDXL = $004348              ;      |        |      ;  
                       SNES_DMA4IDXH = $004349              ;      |        |      ;  
                       SNES_HDMA4LINES = $00434A            ;      |        |      ;  
                       SNES_DMA5PARAM = $004350             ;      |        |      ;  
                       SNES_DMA5REG = $004351               ;      |        |      ;  
                       SNES_DMA5ADDRL = $004352             ;      |        |      ;  
                       SNES_DMA5ADDRM = $004353             ;      |        |      ;  
                       SNES_DMA5ADDRH = $004354             ;      |        |      ;  
                       SNES_DMA5CNTL = $004355              ;      |        |      ;  
                       SNES_DMA5CNTH = $004356              ;      |        |      ;  
                       SNES_HDMA5BANK = $004357             ;      |        |      ;  
                       SNES_DMA5IDXL = $004358              ;      |        |      ;  
                       SNES_DMA5IDXH = $004359              ;      |        |      ;  
                       SNES_HDMA5LINES = $00435A            ;      |        |      ;  
                       SNES_DMA6PARAM = $004360             ;      |        |      ;  
                       SNES_DMA6REG = $004361               ;      |        |      ;  
                       SNES_DMA6ADDRL = $004362             ;      |        |      ;  
                       SNES_DMA6ADDRM = $004363             ;      |        |      ;  
                       SNES_DMA6ADDRH = $004364             ;      |        |      ;  
                       SNES_DMA6CNTL = $004365              ;      |        |      ;  
                       SNES_DMA6CNTH = $004366              ;      |        |      ;  
                       SNES_HDMA6BANK = $004367             ;      |        |      ;  
                       SNES_DMA6IDXL = $004368              ;      |        |      ;  
                       SNES_DMA6IDXH = $004369              ;      |        |      ;  
                       SNES_HDMA6LINES = $00436A            ;      |        |      ;  
                       SNES_DMA7PARAM = $004370             ;      |        |      ;  
                       SNES_DMA7REG = $004371               ;      |        |      ;  
                       SNES_DMA7ADDRL = $004372             ;      |        |      ;  
                       SNES_DMA7ADDRM = $004373             ;      |        |      ;  
                       SNES_DMA7ADDRH = $004374             ;      |        |      ;  
                       SNES_DMA7CNTL = $004375              ;      |        |      ;  
                       SNES_DMA7CNTH = $004376              ;      |        |      ;  
                       SNES_HDMA7BANK = $004377             ;      |        |      ;  
                       SNES_DMA7IDXL = $004378              ;      |        |      ;  
                       SNES_DMA7IDXH = $004379              ;      |        |      ;  
                       SNES_HDMA7LINES = $00437A            ;      |        |      ;  
                       RAM_81_X_event_slot_sprite_assembly = $810000;      |        |      ;  
                       RAM_81_X_event_slot_attribute = $810002;      |        |      ;  
                       RAM_81_X_event_slot_flip_mirror_attribute = $810004;      |        |      ;  
                       RAM_81_X_event_slot_event_slot_health = $810006;      |        |      ;  
                       RAM_81_X_event_slot_xPosSub = $810008;      |        |      ;  
                       RAM_81_X_event_slot_xPos = $81000A   ;      |        |      ;  
                       RAM_81_X_event_slot_yPosSub = $81000C;      |        |      ;  
                       RAM_81_X_event_slot_yPos = $81000E   ;      |        |      ;  
                       RAM_81_X_event_slot_ID = $810010     ;      |        |      ;  
                       RAM_81_X_event_slot_state = $810012  ;      |        |      ;  
                       RAM_81_X_event_slot_subId = $810014  ;      |        |      ;  
                       RAM_81_X_event_slot_16 = $810016     ;      |        |      ;  
                       RAM_81_X_event_slot_xSpdSub = $810018;      |        |      ;  
                       RAM_81_X_event_slot_xSpd = $81001A   ;      |        |      ;  
                       RAM_81_X_event_slot_ySpdSub = $81001C;      |        |      ;  
                       RAM_81_X_event_slot_ySpd = $81001E   ;      |        |      ;  
                       RAM_81_X_event_slot_20 = $810020     ;      |        |      ;  
                       RAM_81_X_event_slot_22 = $810022     ;      |        |      ;  
                       RAM_81_X_event_slot_24 = $810024     ;      |        |      ;  
                       RAM_81_X_event_slot_SpriteAdr = $810026;      |        |      ;  
                       RAM_81_X_event_slot_HitboxXpos = $810028;      |        |      ;  
                       RAM_81_X_event_slot_HitboxYpos = $81002A;      |        |      ;  
                       RAM_81_X_event_slot_Movement2c = $81002C;      |        |      ;  
                       RAM_81_X_event_slot_HitboxID = $81002E;      |        |      ;  
                       RAM_81_X_event_slot_mask = $810030   ;      |        |      ;  
                       RAM_81_X_event_slot_32 = $810032     ;      |        |      ;  
                       RAM_81_X_event_slot_34 = $810034     ;      |        |      ;  
                       RAM_81_X_event_slot_36 = $810036     ;      |        |      ;  
                       RAM_81_X_event_slot_38 = $810038     ;      |        |      ;  
                       RAM_81_X_event_slot_3a = $81003A     ;      |        |      ;  
                       RAM_81_X_event_slot_3c = $81003C     ;      |        |      ;  
                       RAM_81_X_event_slot_3e = $81003E     ;      |        |      ;  
                       RAM_81_whiteFadeCounter = $810040    ;      |        |      ;  
                       RAM_81_transpEffectBG = $810042      ;      |        |      ;  
                       RAM_81_transoEffectSprite = $810044  ;      |        |      ;  
                       RAM_81_mode7Mode = $810046           ;      |        |      ;  
                       RAM_81_pointerCG_WRAM = $810048      ;      |        |      ;  
                       RAM_81_SFXReadLPtr_Set = $810054     ;      |        |      ;  
                       RAM_81_SFXReadLPtr_Active = $810056  ;      |        |      ;  
                       RAM_81_pauseFlag = $810066           ;      |        |      ;  
                       RAM_81_mainGameState = $810070       ;      |        |      ;  
                       RAM_81_frameCounter_effectiv = $810078;      |        |      ;  
                       RAM_81_SFX_Ptr_Repeat = $81007A      ;      |        |      ;  
                       RAM_81_simon_Lifes = $81007C         ;      |        |      ;  
                       RAM_81_simon_PointsTillExtraLife = $81007E;      |        |      ;  
                       RAM_81_simon_ForceGroundBehavier = $810080;      |        |      ;  
                       RAM_81_simon_DamageDeBuff = $810084  ;      |        |      ;  
                       RAM_81_currentLevel = $810086        ;      |        |      ;  
                       RAM_81_setSecondQuest = $810088      ;      |        |      ;  
                       RAM_81_disableHUDupdate = $81008C    ;      |        |      ;  
                       RAM_81_simon_subWeapon = $81008E     ;      |        |      ;  
                       RAM_81_simon_multiShot = $810090     ;      |        |      ;  
                       RAM_81_simon_whipType = $810092      ;      |        |      ;  
                       RAM_81_pointerEventTracker01 = $810094;      |        |      ;  
                       RAM_81_pointerEventTracker02 = $810096;      |        |      ;  
                       RAM_81_eventTrackerDirection = $81009A;      |        |      ;  
                       RAM_81_spritePrioManip = $81009D     ;      |        |      ;  
                       RAM_81_camLockLeft = $8100A0         ;      |        |      ;  
                       RAM_81_camLockRight = $8100A2        ;      |        |      ;  
                       RAM_81_camLockTop = $8100A4          ;      |        |      ;  
                       RAM_81_camLockBottom = $8100A6       ;      |        |      ;  
                       RAM_81_BG1_XposScrollSpeed = $8100A8 ;      |        |      ;  
                       RAM_81_BG1_YposScrollSpeed = $8100AA ;      |        |      ;  
                       RAM_81_IndexSpecialLevelBehavier = $8100AE;      |        |      ;  
                       RAM_81_FlagAllowOutOfBounce = $8100B6;      |        |      ;  
                       RAM_81_simon_invulnerable_counter = $8100BC;      |        |      ;  
                       RAM_81_buttonMapJump = $8100BE       ;      |        |      ;  
                       RAM_81_buttonMapWhip = $8100C0       ;      |        |      ;  
                       RAM_81_buttonMapSubWep = $8100C2     ;      |        |      ;  
                       RAM_81_RNG_1 = $8100E6               ;      |        |      ;  
                       RAM_81_RNG_2 = $8100E8               ;      |        |      ;  
                       RAM_81_RNG_3 = $8100EA               ;      |        |      ;  
                       RAM_81_HUD_RenderFlag = $8100F2      ;      |        |      ;  
                       RAM_81_free00cleared = $8100F4       ;      |        |      ;  
                       RAM_81_gameOverStuffs = $8100F6      ;      |        |      ;  
                       RAM_81_free01cleared = $8100F8       ;      |        |      ;  
                       RAM_81_free02cleared = $8100FA       ;      |        |      ;  
                       RAM_81_XregSlotCurrent = $8100FC     ;      |        |      ;  
                       RAM_81_SFX_Buffer100ByteLong = $810100;      |        |      ;  
                       RAM_81_whipSlot00 = $810200          ;      |        |      ;  
                       RAM_81_whipSlot01 = $810240          ;      |        |      ;  
                       RAM_81_whipSlot02 = $810280          ;      |        |      ;  
                       RAM_81_whipSlot03 = $8102C0          ;      |        |      ;  
                       RAM_81_whipSlot04 = $810300          ;      |        |      ;  
                       RAM_81_whipSlot05 = $810340          ;      |        |      ;  
                       RAM_81_whipSlot06 = $810380          ;      |        |      ;  
                       RAM_81_whipSlot07 = $8103C0          ;      |        |      ;  
                       RAM_81_whipSlot08 = $810400          ;      |        |      ;  
                       RAM_81_subWepSlot00 = $810440        ;      |        |      ;  
                       RAM_81_subWepSlot01 = $810480        ;      |        |      ;  
                       RAM_81_subWepSlot02 = $8104C0        ;      |        |      ;  
                       RAM_81_sparkSlot = $810500           ;      |        |      ;  
                       RAM_81_simonSlot = $810540           ;      |        |      ;  
                       RAM_81_simonSlot_spritePriority = $810542;      |        |      ;  
                       RAM_81_simonSlot_spriteAttributeFlipMirror = $810544;      |        |      ;  
                       RAM_81_simonSlot_empty00 = $810546   ;      |        |      ;  
                       RAM_81_simonSlot_subXpos = $810548   ;      |        |      ;  
                       RAM_81_simonSlot_Xpos = $81054A      ;      |        |      ;  
                       RAM_81_simonSlot_subYpos = $81054C   ;      |        |      ;  
                       RAM_81_simonSlot_Ypos = $81054E      ;      |        |      ;  
                       RAM_81_simonSlot_empty01 = $810550   ;      |        |      ;  
                       RAM_81_simonSlot_State = $810552     ;      |        |      ;  
                       RAM_81_simonSlot_empty02 = $810554   ;      |        |      ;  
                       RAM_81_simonSlot_StateBackUp = $810556;      |        |      ;  
                       RAM_81_simonSlot_SpeedSubXpos = $810558;      |        |      ;  
                       RAM_81_simonSlot_SpeedXpos = $81055A ;      |        |      ;  
                       RAM_81_simonSlot_SpeedSubYpos = $81055C;      |        |      ;  
                       RAM_81_simonSlot_SpeedYpos = $81055E ;      |        |      ;  
                       RAM_81_simonSlot_AnimationCounter = $810560;      |        |      ;  
                       RAM_81_simonSlot_SubAnimationCounter = $810562;      |        |      ;  
                       RAM_81_simonSlot_SpriteAttributeSub_Pallete = $810566;      |        |      ;  
                       RAM_81_simonSlot_Collusion_Donno00 = $81056C;      |        |      ;  
                       RAM_81_simonSlot_forceCrouchFrameCounter = $81056E;      |        |      ;  
                       RAM_81_simonSlot_Collusion_Donno01 = $810576;      |        |      ;  
                       RAM_81_simonSlot_direction = $810578 ;      |        |      ;  
                       RAM_81_eventSlot_Base = $810580      ;      |        |      ;  
                       RAM_81_OAM_Page = $810F00            ;      |        |      ;  
                       RAM_81_FreeRamPage_E0_byte_not_cleard = $811120;      |        |      ;  
                       RAM_81_channel_W_0_paletteAnimation = $811200;      |        |      ;  
                       RAM_81_channel_W_1_paletteAnimation = $811210;      |        |      ;  
                       RAM_81_channel_W_2_paletteAnimation = $811220;      |        |      ;  
                       RAM_81_channel_W_3_paletteAnimation = $811230;      |        |      ;  
                       RAM_81_channel_W_4_paletteAnimation = $811240;      |        |      ;  
                       RAM_81_channel_W_5_paletteAnimation = $811250;      |        |      ;  
                       RAM_81_channel_W_6_paletteAnimation = $811260;      |        |      ;  
                       RAM_81_channel_W_7_paletteAnimation = $811270;      |        |      ;  
                       RAM_81_BG1_ScrollingSlot = $811280   ;      |        |      ;  
                       RAM_81_BG2_ScrollingSlot = $8112C0   ;      |        |      ;  
                       RAM_81_BG3_ScrollingSlot = $811300   ;      |        |      ;  
                       RAM_81_enemieIDSlotAssignPPUTable = $8113A0;      |        |      ;  
                       RAM_81_BG3_subweaponHitCounter = $8113C6;      |        |      ;  
                       RAM_81_ScrollBG1SyncSpeed = $8113D0  ;      |        |      ;  
                       RAM_81_ScrollBG3SyncSpeed = $8113D2  ;      |        |      ;  
                       RAM_81_deathEntrance = $8113D4       ;      |        |      ;  
                       RAM_81_currentMusicTrack = $8113E2   ;      |        |      ;  
                       RAM_81_simonStat_whipUpgradDropFlag = $8113EC;      |        |      ;  
                       RAM_81_simonStat_Timer = $8113F0     ;      |        |      ;  
                       RAM_81_simonStat_Hearts = $8113F2    ;      |        |      ;  
                       RAM_81_simonStat_Health_HUD = $8113F4;      |        |      ;  
                       RAM_81_boss_Health_HUD = $8113F6     ;      |        |      ;  
                       RAM_81_simonStat_stopWatchTimer = $8113FA;      |        |      ;  
                       RAM_81_channel_DMA_0 = $811480       ;      |        |      ;  
                       RAM_81_channel_DMA_1 = $811490       ;      |        |      ;  
                       RAM_81_channel_DMA_2 = $8114A0       ;      |        |      ;  
                       RAM_81_channel_DMA_3 = $8114B0       ;      |        |      ;  
                       RAM_81_channel_DMA_4 = $8114C0       ;      |        |      ;  
                       RAM_81_channel_DMA_5 = $8114D0       ;      |        |      ;  
                       RAM_81_channel_DMA_6 = $8114E0       ;      |        |      ;  
                       RAM_81_channel_DMA_7 = $8114F0       ;      |        |      ;  
                       RAM_81_masktTable_respawnEvents = $811500;      |        |      ;  
                       RAM_81_titleScreen_menuSelect = $811E02;      |        |      ;  
                       RAM_81_characterString_Castlevania4 = $811E0A;      |        |      ;  
                       RAM_81_monoSound_flag = $811E16      ;      |        |      ;  
                       RAM_81_freeSpaceTill_1e7f_exeptOptionsMenu = $811E18;      |        |      ;  
                       RAM_81_freeSpaceTill_1e7f = $811E2E  ;      |        |      ;  
                       RAM_81_blackFade = $811E80           ;      |        |      ;  
                       RAM_81_PPU_Mode = $811E84            ;      |        |      ;  
                       RAM_81_sprite_size_mode = $811E86    ;      |        |      ;  
                       RAM_81_mosaicEffect_Value_BG = $811E8A;      |        |      ;  
                       RAM_81_scoreLow = $811F40            ;      |        |      ;  
                       RAM_81_scoreHigh = $811F42           ;      |        |      ;  
                       RAM_81_simonStat_direction = $811F8A ;      |        |      ;  
                       RAM_81_simonStat_Stuck = $811FA2     ;      |        |      ;  

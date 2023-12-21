
{ ; ------------------------------- tile collusion stuff ----------------------------------------
org $86A379
    CODE_86A379: 
		LDY.W #$0002                         ;86A379|A00200  |      ;  
        LDA.W RAM_X_event_slot_sprite_assembly,X;86A37C|BD0000  |000000;  
        AND.W #$0001                         ;86A37F|290100  |      ;  
        BEQ CODE_86A387                      ;86A382|F003    |86A387;  
        LDY.W #$0040                         ;86A384|A04000  |      ;  
                                             ;      |        |      ;  
	CODE_86A387: 
		STY.B RAM_X_event_slot_event_slot_health;86A387|8406    |000006;  
        LDA.W RAM_X_event_slot_flip_mirror_attribute,X;86A389|BD0400  |000004;  
        AND.W #$0FFF                         ;86A38C|29FF0F  |      ;  
        ASL A                                ;86A38F|0A      |      ;  
        CLC                                  ;86A390|18      |      ;  
        ADC.B $FE                            ;86A391|65FE    |0000FE;  
        STA.B RAM_X_event_slot_sprite_assembly;86A393|8500    |000000;  
        LDA.W RAM_X_event_slot_event_slot_health,X;86A395|BD0600  |000006;  
        STA.B RAM_X_event_slot_flip_mirror_attribute;86A398|8504    |000004;  
        LDA.W $0009,X                        ;86A39A|BD0900  |000009;  
        STA.B RAM_X_event_slot_attribute     ;86A39D|8502    |000002;  
        LDY.W #$0000                         ;86A39F|A00000  |      ;  
                                                            ;      |        |      ;  
    CODE_86A3A2: 
		LDA.B (RAM_X_event_slot_flip_mirror_attribute),Y;86A3A2|B104    |000004;  
        STA.B RAM_X_event_slot_xPosSub       ;86A3A4|8508    |000008;  
        ROL A                                ;86A3A6|2A      |      ;  
        ROL A                                ;86A3A7|2A      |      ;  
        ROL A                                ;86A3A8|2A      |      ;  
        AND.W #$0001                         ;86A3A9|290100  |      ;  
        STA.B RAM_X_event_slot_xPos          ;86A3AC|850A    |00000A;  
        LDA.B RAM_X_event_slot_xPosSub       ;86A3AE|A508    |000008;  
        AND.W #$03FF                         ;86A3B0|29FF03  |      ;  


	SC4edNewTableBasedCollusionFirstLevelFIX: 
		PHY                                  ;86A3B3|5A      |      ;  
        TAY                                  ;86A3B4|A8      |      ;  
        LDA.B [$c8],Y   ;86A3B5|B7C8    |0000C8; writes collusion byte to WRAM table
        PLY                                  ;86A3B7|7A      |      ;  
        AND.W #$00FF                         ;86A3B8|29FF00  |      ;  
		CMP.W #$0002                         ;86A3BB|C90200  |      ;  
        BCC writeByte2Tabke                      ;86A3BE|9073    |86A433; FIXME!

;        CMP.B $E4                            ;86A3C0|C5E4    |0000E4;  
		bit #$00f0								; add new tile collision types 
		beq +
		xba 									; 
		bra writeByte2Tabke

	+	cmp #$000e
        BEQ writeAsBackground                      ;86A3C2|F068    |86A42C;  
 
		CMP.W #$0004                         ;86A3C4|C90400  |      ;  
        BCC CODE_86A431                      ;86A3C7|9068    |86A431;  
        CMP.W #$0006                         ;86A3C9|C90600  |      ;  
        BCC writeByte2Tabke                      ;86A3CC|9065    |86A433; FIXME!
        BNE CODE_86A3D5                      ;86A3CE|D005    |86A3D5; FIXME!
		lda #$ffff		                     ;86A3D0|A9FFFF  |      ;  
        BRA CODE_86A431                      ;86A3D3|805C    |86A431; FIXME!
                                                            ;      |        |      ;  
    CODE_86A3D5: 
		CMP.W #$000C                         ;86A3D5|C90C00  |      ;  
        BCC CODE_86A431                      ;86A3D8|9057    |86A431;  
        BNE CODE_86A427                      ;86A3DA|D04B    |86A427; FIXME!
        LDA.W #$8000                         ;86A3DC|A90080  |      ;  
        BRA CODE_86A431                      ;86A3DF|8050    |86A431; FIXME!
		

padbyte $ff 
pad $86A427
;        BCS CODE_86A3E8                      ;86A3E1|B005    |86A3E8; unsed Setup by Redguy or orginal Setup..
;        LDA.W #$0005                         ;86A3E3|A90500  |      ;  
;        BRA writeByte2Tabke                      ;86A3E6|804B    |86A433;  
;                                                            ;      |        |      ;  
;    CODE_86A3E8: 
;		CMP.B $D4                            ;86A3E8|C5D4    |0000D4;  
;        BCS CODE_86A3F1                      ;86A3EA|B005    |86A3F1;  
;        LDA.W #$FFFF                         ;86A3EC|A9FFFF  |      ;  
;        BRA CODE_86A431                      ;86A3EF|8040    |86A431;  
;                                                            ;      |        |      ;  
;                                                            ;      |        |      ;  
;    CODE_86A3F1: 
;		CMP.B $D6                            ;86A3F1|C5D6    |0000D6;  
;        BCS CODE_86A3FA                      ;86A3F3|B005    |86A3FA;  
;        LDA.W #$0007                         ;86A3F5|A90700  |      ;  
;        BRA CODE_86A431                      ;86A3F8|8037    |86A431;  
;                                                            ;      |        |      ;    
;    CODE_86A3FA: 
;		CMP.B $D8                            ;86A3FA|C5D8    |0000D8;  
;        BCS CODE_86A403                      ;86A3FC|B005    |86A403;  
;        LDA.W #$0008                         ;86A3FE|A90800  |      ;  
;        BRA CODE_86A431                      ;86A401|802E    |86A431;  
;                                                            ;      |        |      ;  
;                                                            ;      |        |      ;  
;    CODE_86A403: 
;		CMP.B $DA                            ;86A403|C5DA    |0000DA;  
;        BCS CODE_86A40C                      ;86A405|B005    |86A40C;  
;        LDA.W #$0009                         ;86A407|A90900  |      ;  
;        BRA CODE_86A431                      ;86A40A|8025    |86A431;  
;                                                            ;      |        |      ;  
;    CODE_86A40C: 
;		CMP.B $DC                            ;86A40C|C5DC    |0000DC;  
;        BCS CODE_86A415                      ;86A40E|B005    |86A415;  
;        LDA.W #$000A                         ;86A410|A90A00  |      ;  
;        BRA CODE_86A431                      ;86A413|801C    |86A431;  
;                                                            ;      |        |      ;   
;    CODE_86A415: 
;		CMP.B $DE                            ;86A415|C5DE    |0000DE;  
;        BCS CODE_86A41E                      ;86A417|B005    |86A41E;  
;        LDA.W #$000B                         ;86A419|A90B00  |      ;  
;        BRA CODE_86A431                      ;86A41C|8013    |86A431;  
;                                                            ;      |        |      ;  
;    CODE_86A41E: 
;		CMP.B $E0                            ;86A41E|C5E0    |0000E0;  
;        BCS CODE_86A427                      ;86A420|B005    |86A427;  
;        LDA.W #$8000                         ;86A422|A90080  |      ;  
;        BRA CODE_86A431                      ;86A425|800A    |86A431;  

warnPC $86A427
org $86A427                                                            ;      |        |      ;  
    CODE_86A427: 
		LDA.W #$0006                         ;86A427|A90600  |      ;  
        BRA writeByte2Tabke                      ;86A42A|8007    |86A433;  
                                                            ;      |        |      ;  
    writeAsBackground: 
		LDA.W #$0000                         ;86A42C|A90000  |      ;  
        BRA writeByte2Tabke                      ;86A42F|8002    |86A433;  
                                                            ;      |        |      ;  
    CODE_86A431: 
		EOR.B RAM_X_event_slot_xPos          ; stairTiles flip orientation 
                                                            ;      |        |      ;  
    writeByte2Tabke: 
		STA.B (RAM_X_event_slot_sprite_assembly);86A433|9200    |000000;  
        LDA.B RAM_X_event_slot_sprite_assembly;86A435|A500    |000000;  
        CLC                                  ;86A437|18      |      ;  
        ADC.B RAM_X_event_slot_event_slot_health;86A438|6506    |000006;  
        STA.B RAM_X_event_slot_sprite_assembly;86A43A|8500    |000000;  
        INY                                  ;86A43C|C8      |      ;  
        INY                                  ;86A43D|C8      |      ;  
        CPY.B RAM_X_event_slot_attribute     ;86A43E|C402    |000002;  
        BCS CODE_86A445                      ;86A440|B003    |86A445;  
        JMP.W CODE_86A3A2                    ;86A442|4CA2A3  |86A3A2;  
                                                            ;      |        |      ;  
    CODE_86A445: 
		TXA                                  ;86A445|8A      |      ;  
        CLC                                  ;86A446|18      |      ;  
        ADC.W #$000B                         ;86A447|690B00  |      ;  
        TAX                                  ;86A44A|AA      |      ;  
        CPX.B $4E                            ;86A44B|E44E    |00004E;  
        BCS CODE_86A452                      ;86A44D|B003    |86A452;  
        JMP.W CODE_86A379                    ;86A44F|4C79A3  |86A379;  
    CODE_86A452: 
		RTL                                  ;86A452|6B      |      ;  
                                                            ;      |        |      ;  
    CODE_86A453: 
		LDX.B RAM_X_event_slot_ySpdSub       ;86A453|A61C    |00001C;  
        LDY.W #$0002                         ;86A455|A00200  |      ;  
        LDA.W RAM_X_event_slot_sprite_assembly,X;86A458|BD0000  |000000;  
        AND.W #$0001                         ;86A45B|290100  |      ;  
        BEQ CODE_86A463                      ;86A45E|F003    |86A463;  
        LDY.W #$0040                         ;86A460|A04000  |      ;  
                                                            ;      |        |      ;  
    CODE_86A463: 
		STY.B RAM_X_event_slot_event_slot_health;86A463|8406    |000006;  
        LDA.W RAM_X_event_slot_flip_mirror_attribute,X;86A465|BD0400  |000004;  
        AND.W #$0FFF                         ;86A468|29FF0F  |      ;  
        ASL A                                ;86A46B|0A      |      ;  
        CLC                                  ;86A46C|18      |      ;  
        ADC.W #$A000                         ;86A46D|6900A0  |      ;  
        STA.B RAM_X_event_slot_sprite_assembly;86A470|8500    |000000;  
        LDA.W RAM_X_event_slot_event_slot_health,X;86A472|BD0600  |000006;  
        STA.B RAM_X_event_slot_flip_mirror_attribute;86A475|8504    |000004;  
        LDA.W $0009,X                        ;86A477|BD0900  |000009;  
        STA.B RAM_X_event_slot_attribute     ;86A47A|8502    |000002;  
        LDY.W #$0000                         ;86A47C|A00000  |      ;  
                                                            ;      |        |      ;  
    CODE_86A47F: 
		LDA.B (RAM_X_event_slot_flip_mirror_attribute),Y;86A47F|B104    |000004;  
		AND.W #$2000                         ;86A481|290020  |      ;  
		STA.B (RAM_X_event_slot_sprite_assembly);86A484|9200    |000000;  
		LDA.B RAM_X_event_slot_sprite_assembly;86A486|A500    |000000;  
		CLC                                  ;86A488|18      |      ;  
		ADC.B RAM_X_event_slot_event_slot_health;86A489|6506    |000006;  
		STA.B RAM_X_event_slot_sprite_assembly;86A48B|8500    |000000;  
		INY                                  ;86A48D|C8      |      ;  
		INY                                  ;86A48E|C8      |      ;  
		CPY.B RAM_X_event_slot_attribute     ;86A48F|C402    |000002;  
		BCS CODE_86A496                      ;86A491|B003    |86A496;  
		JMP.W CODE_86A47F                    ;86A493|4C7FA4  |86A47F;  
                                                            ;      |        |      ;  
    CODE_86A496: 
		TXA                                  ;86A496|8A      |      ;  
        CLC                                  ;86A497|18      |      ;  
        ADC.W #$000B                         ;86A498|690B00  |      ;  
        TAX                                  ;86A49B|AA      |      ;  
        CPX.B $4E                            ;86A49C|E44E    |00004E;  
        BCS CODE_86A4A3                      ;86A49E|B003    |86A4A3;  
        db $4C,$55,$A4                       ;86A4A0|        |86A455;  
    CODE_86A4A3: 
		RTL                                  ;86A4A3|6B      |      ;  
                                                            ;      |        |      ;  
    CODE_86A4A4: 
		LDA.B $FE                            ;86A4A4|A5FE    |0000FE;  
        CMP.W #$4000                         ;86A4A6|C90040  |      ;  
        BEQ CODE_86A4AC                      ;86A4A9|F001    |86A4AC;  
        RTL                                  ;86A4AB|6B      |      ;  
                                                            ;      |        |      ;  
    CODE_86A4AC: 
		LDX.B RAM_X_event_slot_ySpdSub       ;86A4AC|A61C    |00001C;  
        LDA.W RAM_X_event_slot_flip_mirror_attribute,X;86A4AE|BD0400  |000004;  
        AND.W #$0FFF                         ;86A4B1|29FF0F  |      ;  
        ASL A                                ;86A4B4|0A      |      ;  
        CLC                                  ;86A4B5|18      |      ;  
        ADC.W #$4000                         ;86A4B6|690040  |      ;  
        STA.B RAM_X_event_slot_ID            ;86A4B9|8510    |000010;  
        CLC                                  ;86A4BB|18      |      ;  
        ADC.W #$6000                         ;86A4BC|690060  |      ;  
        STA.B RAM_X_event_slot_state         ;86A4BF|8512    |000012;  
        LDA.W RAM_X_event_slot_event_slot_health,X;86A4C1|BD0600  |000006;  
        STA.B RAM_X_event_slot_flip_mirror_attribute;86A4C4|8504    |000004;  
        LDA.W $0009,X                        ;86A4C6|BD0900  |000009;  
        STA.B RAM_X_event_slot_attribute     ;86A4C9|8502    |000002;  
        LDY.W #$0000                         ;86A4CB|A00000  |      ;  
                                                            ;      |        |      ;  
    CODE_86A4CE: 
		LDA.B (RAM_X_event_slot_flip_mirror_attribute),Y;86A4CE|B104    |000004;  
        STA.B RAM_X_event_slot_xPosSub       ;86A4D0|8508    |000008;  
        ROL A                                ;86A4D2|2A      |      ;  
        ROL A                                ;86A4D3|2A      |      ;  
        ROL A                                ;86A4D4|2A      |      ;  
        AND.W #$0001                         ;86A4D5|290100  |      ;  
        STA.B RAM_X_event_slot_xPos          ;86A4D8|850A    |00000A;  
        LDA.B RAM_X_event_slot_xPosSub       ;86A4DA|A508    |000008;  
        AND.W #$03FF                         ;86A4DC|29FF03  |      ;  
                                                            ;      |        |      ;  
	SC4edSeconLevelColluisonTableFIX00: 
		PHY                                  ;86A4DF|5A      |      ;  
        TAY                                  ;86A4E0|A8      |      ;  
        LDA.B [$c8],Y   ;86A4E1|B7C8    |0000C8;  RAM_collusionDataPointer
        AND.W #$00FF                         ;86A4E3|29FF00  |      ;  
        PLY                                  ;86A4E6|7A      |      ;  
        PHA                                  ;86A4E7|48      |      ;  
        CMP.W #$0002                         ;86A4E8|C90200  |      ;  
        BCC CODE_86A4FC                      ;86A4EB|900F    |86A4FC; FIXME
        CMP.B $CC                            ;86A4ED|C5CC    |0000CC;  
        BEQ CODE_86A4F6                      ;86A4EF|F005    |86A4F6; FIXME // BEQ - branch if 2 (#8000)
        LDA.W #$0000                         ;86A4F1|A90000  |      ;  
                                                            ;      |        |      ;  
    CODE_86A4F4: 
		BRA CODE_86A4FC                      ;86A4F4|8006    |86A4FC; // FIXME
                                                            ;      |        |      ;  
    CODE_86A4F6: 
		LDA.W #$8000                         ;86A4F6|A90080  |      ;  
        NOP                                  ;86A4F9|EA      |      ; end reguy edits
        EOR.B RAM_X_event_slot_xPos          ;86A4FA|450A    |00000A;  
                                                            ;      |        |      ;  
    CODE_86A4FC: 
		STA.B (RAM_X_event_slot_ID)          ;86A4FC|9210    |000010;  
        LDA.B RAM_X_event_slot_ID            ;86A4FE|A510    |000010;  
        CLC                                  ;86A500|18      |      ;  
        ADC.W #$0040                         ;86A501|694000  |      ;  
        STA.B RAM_X_event_slot_ID            ;86A504|8510    |000010;  
        LDA.B RAM_X_event_slot_xPosSub       ;86A506|A508    |000008;  
        AND.W #$03FF                         ;86A508|29FF03  |      ;  
                                                            ;      |        |      ;  
	SC4edSeconLevelColluisonTableFIX01: 
		PLA                                  ;86A50B|68      |      ;  
        CMP.W #$000E                         ;86A50C|C90E00  |      ;  
        BCS CODE_86A517                      ;86A50F|B006    |86A517;  
        CMP.B $CE                            ;86A511|C5CE    |0000CE;  
        BEQ CODE_86A51C                      ;86A513|F007    |86A51C;  
        BCS CODE_86A521                      ;86A515|B00A    |86A521;  
                                                            ;      |        |      ;  
    CODE_86A517: 
		LDA.W #$0000                         ;86A517|A90000  |      ; // FIXME
        BRA CODE_86A528                      ;86A51A|800C    |86A528;  
                                                            ;      |        |      ;  
    CODE_86A51C: 
		LDA.W #$0001                         ;86A51C|A90100  |      ; // FIXME
        BRA CODE_86A528                      ;86A51F|8007    |86A528;  
                                                            ;      |        |      ;  
    CODE_86A521: 
		LDA.W #$8000                         ;86A521|A90080  |      ; // FIXME
        NOP                                  ;86A524|EA      |      ;  
        NOP                                  ;86A525|EA      |      ; end redguy collusion table setup edits
        EOR.B RAM_X_event_slot_xPos          ;86A526|450A    |00000A;  
                                                            ;      |        |      ;  
    CODE_86A528: 
		STA.B (RAM_X_event_slot_state)       ;86A528|9212    |000012;  
        LDA.B RAM_X_event_slot_state         ;86A52A|A512    |000012;  
        CLC                                  ;86A52C|18      |      ;  
        ADC.W #$0040                         ;86A52D|694000  |      ;  
        STA.B RAM_X_event_slot_state         ;86A530|8512    |000012;  
        INY                                  ;86A532|C8      |      ;  
        INY                                  ;86A533|C8      |      ;  
        CPY.B RAM_X_event_slot_attribute     ;86A534|C402    |000002;  
        BCS CODE_86A53B                      ;86A536|B003    |86A53B;  
        JMP.W CODE_86A4CE                    ;86A538|4CCEA4  |86A4CE;  
                                                            ;      |        |      ;  
    CODE_86A53B: 
		TXA                                  ;86A53B|8A      |      ;  
        CLC                                  ;86A53C|18      |      ;  
        ADC.W #$000B                         ;86A53D|690B00  |      ;  
        TAX                                  ;86A540|AA      |      ;  
        CPX.B $4E                            ;86A541|E44E    |00004E;  
        BCS CODE_86A548                      ;86A543|B003    |86A548;  
        db $4C,$AE,$A4                       ;86A545|        |86A4AE;  
    CODE_86A548: 
		RTL                                  ;86A548|6B      |      ;  

; block assembly data 
    UNREACH_86A549: db $00,$00                           ;86A549|        |      ;  
    UNREACH_86A54B: db $08,$00                           ;86A54B|        |      ;  
    UNREACH_86A54D: db $10,$00                           ;86A54D|        |86A54F;  
    UNREACH_86A54F: db $18,$00,$02,$00,$0A,$00,$12,$00   ;86A54F|        |      ;  
                    db $1A,$00,$04,$00,$0C,$00,$14,$00   ;86A557|        |      ;  
                    db $1C,$00,$06,$00,$0E,$00,$16,$00   ;86A55F|        |000600;  
                    db $1E,$00,$06,$00,$0E,$00,$16,$00   ;86A567|        |000600;  
                    db $1E,$00,$04,$00,$0C,$00,$14,$00   ;86A56F|        |000400;  
                    db $1C,$00,$02,$00,$0A,$00,$12,$00   ;86A577|        |000200;  
                    db $1A,$00,$00,$00,$08,$00,$10,$00   ;86A57F|        |      ;  
                    db $18,$00,$18,$00,$10,$00,$08,$00   ;86A587|        |      ;  
                    db $00,$00,$1A,$00,$12,$00,$0A,$00   ;86A58F|        |      ;  
                    db $02,$00,$1C,$00,$14,$00,$0C,$00   ;86A597|        |      ;  
                    db $04,$00,$1E,$00,$16,$00,$0E,$00   ;86A59F|        |000000;  
                    db $06,$00,$1E,$00,$16,$00,$0E,$00   ;86A5A7|        |000000;  
                    db $06,$00,$1C,$00,$14,$00,$0C,$00   ;86A5AF|        |000000;  
                    db $04,$00,$1A,$00,$12,$00,$0A,$00   ;86A5B7|        |000000;  
                    db $02,$00,$18,$00,$10,$00,$08,$00   ;86A5BF|        |      ;  
                    db $00,$00                           ;86A5C7|        |      ;  

    UNREACH_86A5C9: db $00,$00                           ;86A5C9|        |      ;  
    UNREACH_86A5CB: db $02,$00                           ;86A5CB|        |      ;  
    UNREACH_86A5CD: db $04,$00                           ;86A5CD|        |000000;  
    UNREACH_86A5CF: db $06,$00,$08,$00,$0A,$00,$0C,$00   ;86A5CF|        |000000;  
                    db $0E,$00,$10,$00,$12,$00,$14,$00   ;86A5D7|        |001000;  
                    db $16,$00,$18,$00,$1A,$00,$1C,$00   ;86A5DF|        |000000;  
                    db $1E,$00,$06,$00,$04,$00,$02,$00   ;86A5E7|        |000600;  
                    db $00,$00,$0E,$00,$0C,$00,$0A,$00   ;86A5EF|        |      ;  
                    db $08,$00,$16,$00,$14,$00,$12,$00   ;86A5F7|        |      ;  
                    db $10,$00,$1E,$00,$1C,$00,$1A,$00   ;86A5FF|        |86A601;  
                    db $18,$00,$18,$00,$1A,$00,$1C,$00   ;86A607|        |      ;  
                    db $1E,$00,$10,$00,$12,$00,$14,$00   ;86A60F|        |001000;  
                    db $16,$00,$08,$00,$0A,$00,$0C,$00   ;86A617|        |000000;  
                    db $0E,$00,$00,$00,$02,$00,$04,$00   ;86A61F|        |000000;  
                    db $06,$00,$1E,$00,$1C,$00,$1A,$00   ;86A627|        |000000;  
                    db $18,$00,$16,$00,$14,$00,$12,$00   ;86A62F|        |      ;  
                    db $10,$00,$0E,$00,$0C,$00,$0A,$00   ;86A637|        |86A639;  
                    db $08,$00,$06,$00,$04,$00,$02,$00   ;86A63F|        |      ;  
                    db $00,$00,$6B                       ;86A647|        |      ;  

;org $86A3BE
;	jmp.w $86A433		; simplyfied collusion seems close 

org $86B859
	NewTableBasedCollusionSettup: 
		LDA.W #$0002                         ;86B859|A90200  |      ;  replace collision setup with table base setup in $C8
        STA.B $CC                            ;86B85C|85CC    |0000CC; SC4ed Edit by Redguy
        INC A                                ;86B85E|1A      |      ;  
        STA.B $CE                            ;86B85F|85CE    |0000CE;  ; used for bg collusion lvl 1 
 ;       INC A                                ;86B861|1A      |      ;  
 ;       STA.B $D0                            ;86B862|85D0    |0000D0;  
 ;       INC A                                ;86B864|1A      |      ;  
 ;       STA.B $D2                            ;86B865|85D2    |0000D2;  
 ;       INC A                                ;86B867|1A      |      ;  
 ;       STA.B $D4                            ;86B868|85D4    |0000D4;  
 ;       INC A                                ;86B86A|1A      |      ;  
 ;       STA.B $D6                            ;86B86B|85D6    |0000D6;  
 ;       INC A                                ;86B86D|1A      |      ;  
 ;       STA.B $D8                            ;86B86E|85D8    |0000D8;  
 ;       INC A                                ;86B870|1A      |      ;  
 ;       STA.B $DA                            ;86B871|85DA    |0000DA;  
 ;       INC A                                ;86B873|1A      |      ;  
 ;       STA.B $DC                            ;86B874|85DC    |0000DC;  
 ;       INC A                                ;86B876|1A      |      ;  
 ;       STA.B $DE                            ;86B877|85DE    |0000DE;  
 ;       INC A                                ;86B879|1A      |      ;  
 ;       STA.B $E0                            ;86B87A|85E0    |0000E0;  
 ;       INC A                                ;86B87C|1A      |      ;  
 ;       STA.B $E2                            ;86B87D|85E2    |0000E2;  
 ;       INC A                                ;86B87F|1A      |      ;  
 ;       STA.B $E4                            ;86B880|85E4    |0000E4;  

        LDA.B RAM_currentLevel               ;86B882|A586    |000086;  
        AND.W #$001F                         ;86B884|291F00  |      ;  
        XBA                                  ;86B887|EB      |      ; callculation collusion data pointer
        ASL A                                ;86B888|0A      |      ;  
        ASL A                                ;86B889|0A      |      ;  
        CLC                                  ;86B88A|18      |      ;  
        ADC.W #$8000                         ;86B88B|690080  |      ;  
        STA.B $C8	; RAM_collusionDataPointer       ;86B88E|85C8    |0000C8;  
        LDA.B RAM_currentLevel               ;86B890|A586    |000086;  
        LSR A                                ;86B892|4A      |      ;  
        LSR A                                ;86B893|4A      |      ;  
        LSR A                                ;86B894|4A      |      ;  
        LSR A                                ;86B895|4A      |      ;  
        LSR A                                ;86B896|4A      |      ;  
        CLC                                  ;86B897|18      |      ;  
        ADC.W #$00A2                         ;86B898|69A200  |      ;  
        STA.B $CA                            ;86B89B|85CA    |0000CA;  
        RTL  
warnPC $86B8AE


org $80B2C1
		jml stairTileSkip

pullPC
	stairTileSkip:
		dec 
		bit #$0f00						; filter out costum tiles 
		bne +
		sta $1f80
		jml $80B2C5
		;rtl
	+	jml $80B282 
		;pla
		;pla
		;pla 
		;rtl 
pushPC 		

; -------------------------------- add collusion tile to table ----------------------------------------
;org $a2e0e0
;	dw $fefc
;
;org $a2e0f0
;	dw $fefc
	
;org $80B89A
;		jml extraTilesTable
;	vanillTileProcessing:
;		PLX                              
;        STA.B RAM_X_event_slot_event_slot_health
;		JMP.W (RAM_X_event_slot_event_slot_health)
;	tileCollusionActionTable:       
;
;pullPC
;	extraTilesTable:
;		cmp #$004f
;		beq +
;
;		LDA.L tileCollusionActionTable,X 	
;		jml vanillTileProcessing
;	+	lda #$0000
;		rtl 
;pushPC 		

; ---------------------------------- end tile collusion stuff -------------------------------------

}

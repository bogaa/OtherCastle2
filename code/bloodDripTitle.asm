;blood drip experiment  ; hijacks 
org $83db46
	jsl .patch1
	nop #2

org $83dba8
	jsl .patch2
	nop #2

org $83dbb2
	jsl .patch3
	rtl

org $83dbbe
	jml .patch4

org $83dbd8
	jsl .patch5
	nop #2

org $83dbf5
	jml .patch6
	nop #1

org $83dc42
	jsl .patch7
	nop #2

org $83dc7c
	jml .patch8
	nop #1

;org $9ffe40						; freeSpace
pullPC


.patch1:
	lda.w #$0003					; old code		; z_03db46
	sta $13ce


	ldx #$0780

	lda.w #$00b0
	sta $0a,x

	lda.w #$0088
	sta $0e,x

	lda.w #$6000
	sta $1c,x

	lda.w #$0000
	sta $1e,x

	lda.w #$0005
	sta $24,x
	rtl


.patch2:						; .z_03dbc4
	jsr .animate_blood_frame

	lda.w #$0080				; old code
	sta $1c02

	rtl

.patch3:						; .z_03dbd1
	jsr .animate_blood_frame

	dec $1c02					; old code
	bne ..exit
	inc $1c00
..exit:
	rtl


.patch4:
	jsl $86a1f0						; old code		; .z_03dbdd - 03dbf9
	jsl $83dbc2
	jsr .animate_blood_frame
	rtl


.patch5:
	jsr .animate_blood_frame		; .z_03dbfd

	lda.w #$0001					; old code
	sta $1c04
	rtl


.patch6:			; .z_03dc1d
	jsr .animate_blood_frame

	lda $1c06						; old code
	beq ..exit2

..exit1:
	jml $83dbfa

..exit2:
	jml $83dc0b

.patch7:							; .z_03dc6d
	jsr .animate_blood_frame

	ldx.w #$0580					; old code
	ldy.w #$0000
	rtl

.patch8:							; .z_03dcaa
	jsr .animate_blood_frame

	dec $1c02						; old code
	beq ..exit2

..exit1:
	jml $83dc81

..exit2:
	jml $83dcc1

.animate_blood_frame:		; .z_03dd01:
	ldx #$0780
	jsr .z_03dd20

	ldx #$07c0

..loop:
	stx $fc

	lda $10,x
	beq ..z_03dd13

	jsr .z_03dd6c


..z_03dd13:
	lda $fc
	clc
	adc.w #$0040

	tax
	cpx #$0880
	bcc ..loop
	rts

.z_03dd20:
	lda.w #$006e				; start Xpos blood drip
	sta $0a,x

	lda #$8018				
	sta $02,x


	lda.w #$0068			; start Ypos blood drip
	sec
	sbc $1298

	clc
	adc $12d8
	sta $0e,x


	lda.w #.drip_sprite_table
	sta $00

	jsl $82d65f


	lda $00
	bne ..exit


	stz $24,x
	stz $22,x


	ldx #$07c0
	lda #$0880
	jsr .z_03dd59
	bcs ..exit


	lda.w #$0001
	sta $10,x
..exit:
	rts
	

.z_03dd59:
	sta $00

..loop:
	lda $10,x
	beq ..exit


	txa
	clc
	adc.w #$0040
	tax


	cpx $00
	bcc ..loop

	rts


..exit:
	clc
	rts


.z_03dd6c:
	lda $12,x
	phx

	asl a
	tax

	lda.l ..jmp_table,x
	plx

	sta $00
	jmp ($0000)


..jmp_table:
	dw #.z_03dd81, #.z_03dda2, #.z_03ddd8


.z_03dd81:
	lda #.fall_1
	sta $00,x


	ldy #$0780
	lda.w $000a,y
	clc
	adc.w #$0002
	sta $0a,x


	lda.w $000e,y
	clc
	adc.w #$000f
	sta.w $0e,x


	stz $1c,x
	stz $1e,x
	inc $12,x
	rts


.z_03dda2:
	lda $1c,x
	clc
	adc #$1200
	sta $1c,x


	lda $1e,x
	adc.w #$0000
	sta $1e,x


	cmp.w #$0006
	bcc ..z_03ddbd


	lda.w #$0006
	sta $1e,x
	stz $1c,x


..z_03ddbd:
	jsr .z_03ddf8

	cmp.w #$0190
	bcc ..exit


	lda.w #$0030
	jsl $8085e3


	lda #$0190					; ypos drip rings ground 
	sta $0e,x
	stz $24,x
	stz $22,x
	inc $12,x

..exit:
	rts

.z_03ddd8:
	lda.w #.splash_sprite_table
	sta $00

	jsl $82d65f

	lda $00
	bne ..exit

	jsl $808c59


..exit:
	rts


.z_03ddea:
	lda $08,x
	clc
	adc $18,x
	sta $08,x


	lda $0a,x
	adc $1a,x
	sta $0a,x
	rts


.z_03ddf8:
	lda $0c,x
	clc
	adc $1c,x
	sta $0c,x

	lda $0e,x
	adc $1e,x
	sta $0e,x

	rts


.z_04fe7f:
	lda $12,x
	phx
	asl a
	tax

	lda.l ..asm_04_table,x
	plx
	sta $00

	rtl

..asm_04_table:
	dw $fe94, $fe99, $fec3
pushPC 




;org $81ff26
org $81ffb4					; new dataBank enteries 
.drip_sprite_table:			; .z_01e18f:
	dw .drip_1, $0020
	dw .drip_2, $0010
	dw .drip_3, $0010
	dw .drip_4, $0010
	dw .drip_5, $0010
	dw .drip_6, $0010
	dw .drip_7, $0010
	dw $0000

.splash_sprite_table:			; .z_01e1ad:
	dw .splash_1, $0008
	dw .splash_2, $0008
	dw .splash_3, $0008
	dw $0000

org $84fe7f
	jsl .z_04fe7f
	jmp ($0000)


.fall_1:			; .z_04e06e:
	db $01
	db $f6, $fa, $46, $24


;org $84ffb5			; newSpriteAssemblyTable enteries
org $849A0B				; overwrite Ghost Hand along Sprite 						
.drip_1:			; .z_04e033
	db $01
	db $f8, $f8, $40, $24

.drip_2:
	db $02
	db $f8, $f8, $42, $24
	db $f8, $01, $46, $24

.drip_3:
	db $02
	db $f8, $f8, $42, $24
	db $f8, $03, $44, $24

.drip_4:
	db $02
	db $f8, $f8, $42, $24
	db $f8, $04, $44, $24

.drip_5:
	db $02
	db $f8, $f8, $42, $24
	db $f8, $05, $44, $24

.drip_6:
	db $02
	db $f8, $f8, $42, $24
	db $f8, $07, $44, $24

.drip_7:
	db $02
	db $f8, $f8, $42, $24
	db $f8, $09, $46, $24


.splash_1:		; .z_04e073
	db $01
	db $f8, $f7, $48, $24

.splash_2:
	db $01
	db $f8, $f7, $4a, $24

.splash_3:
	db $01
	db $f8, $f7, $4c, $24

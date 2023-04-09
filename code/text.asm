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
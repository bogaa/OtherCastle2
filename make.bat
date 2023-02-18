::@ECHO OFF 
IF NOT EXIST rom\sc4.sfc (
	asar\asar.exe rom\source\main.asm
	move rom\source\main.sfc rom\main.sfc 
	ren rom\main.sfc sc4.sfc )

asar\asar.exe code/preMain.asm rom\sc4.sfc
copy rom\sc4.sfc sc4.sfc

asar\asar.exe main.asm sc4.sfc
::timeout 3
pause 
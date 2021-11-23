ALL: ..\lib\bms.lib ..\dll\bmscalls.dll ..\lib\bmscalls.lib

OBJS=bmsmain.obj bmsgetnumbuttons.obj bmsgetnummickeys.obj bmsgetdevstatus.obj bmsgetnumqueel.obj bmsreadeventque.obj bmsgetscalefact.obj &
bmsgeteventmask.obj bmssetscalefact.obj bmsseteventmask.obj bmsgethotkey.obj bmssethotkey.obj bmsopen.obj bmsclose.obj bmsgetptrshape.obj &
bmssetptrshape.obj bmsdrawptr.obj bmsremoveptr.obj bmsgetptrpos.obj bmssetptrpos.obj bmsinitreal.obj bmsflushque.obj bmssetdevstatus.obj

..\dll\bmscalls.dll: ..\lib\bms.lib makefile
	@echo LINK $@
	@wlink.exe @<<
     system   os2_dll
     option   map
     export BMSMAIN.1 RESIDENT
     name     ..\dll\bmscalls
     file     ..\lib\bms.lib 
     file	..\helpers.obj
<<

..\lib\bmscalls.lib: ..\dll\bmscalls.dll makefile
	@echo LIB $@
	@wlib -q -fo $@ ..\dll\bmscalls.dll

..\lib\bms.lib: $(OBJS)
	@echo LIB $@
	@wlib -q -fo $@ $(OBJS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -I..\include $*.asm


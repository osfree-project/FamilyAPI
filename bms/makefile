PROJ=bms

ALL: ..\lib\$(PROJ).lib ..\dll\$(PROJ)calls.dll ..\lib\$(PROJ)calls.lib

OBJS=bmsmain.obj bmsgetnumbuttons.obj bmsgetnummickeys.obj bmsgetdevstatus.obj bmsgetnumqueel.obj bmsreadeventque.obj bmsgetscalefact.obj &
bmsgeteventmask.obj bmssetscalefact.obj bmsseteventmask.obj bmsgethotkey.obj bmssethotkey.obj bmsopen.obj bmsclose.obj bmsgetptrshape.obj &
bmssetptrshape.obj bmsdrawptr.obj bmsremoveptr.obj bmsgetptrpos.obj bmssetptrpos.obj bmsinitreal.obj bmsflushque.obj bmssetdevstatus.obj

..\dll\$(PROJ)calls.dll: ..\lib\$(PROJ).lib makefile
	@echo LINK $@
	@wlink.exe @<<
     system   os2_dll
     option   map
     export BMSMAIN.1 RESIDENT
     name     ..\dll\$(PROJ)calls
     file     ..\lib\$(PROJ).lib 
     file	..\helpers.obj
<<

..\lib\$(PROJ)calls.lib: ..\dll\$(PROJ)calls.dll makefile
	@echo LIB $@
	@wlib -q -fo $@ ..\dll\$(PROJ)calls.dll

..\lib\$(PROJ).lib: $(OBJS)
	@echo LIB $@
	@wlib -q -fo $@ $(OBJS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -I..\include $*.asm


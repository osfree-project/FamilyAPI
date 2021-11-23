PROJ=mou

ALL: ..\lib\$(PROJ).lib ..\dll\$(PROJ)calls.dll

OBJS=mouroute.obj mougetnumbuttons.obj mougetnummickeys.obj mougetdevstatus.obj mougetnumqueel.obj moureadeventque.obj mougetscalefact.obj mougeteventmask.obj &
mousetscalefact.obj mouseteventmask.obj mougethotkey.obj mousethotkey.obj mouopen.obj mouclose.obj mougetptrshape.obj mousetptrshape.obj &
moudrawptr.obj mouremoveptr.obj mougetptrpos.obj mousetptrpos.obj mouinitreal.obj mouflushque.obj mousetdevstatus.obj

..\dll\$(PROJ)calls.dll: ..\lib\$(PROJ).lib makefile
	@echo LINK $@
	@wlink.exe @<<
     system   os2_dll
     option   map
     name     ..\dll\$(PROJ)calls
     file     ..\lib\$(PROJ).lib 
     file     ..\lib\bmscalls.lib 
     file	..\helpers.obj
<<

..\lib\$(PROJ).lib: $(OBJS) makefile
	@echo LIB $@
	@wlib -q -fo $@ $(OBJS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -I..\include $*.asm


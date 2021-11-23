ALL: ..\lib\mou.lib ..\dll\moucalls.dll

OBJS=mouroute.obj mougetnumbuttons.obj mougetnummickeys.obj mougetdevstatus.obj mougetnumqueel.obj moureadeventque.obj mougetscalefact.obj mougeteventmask.obj &
mousetscalefact.obj mouseteventmask.obj mougethotkey.obj mousethotkey.obj mouopen.obj mouclose.obj mougetptrshape.obj mousetptrshape.obj &
moudrawptr.obj mouremoveptr.obj mougetptrpos.obj mousetptrpos.obj mouinitreal.obj mouflushque.obj mousetdevstatus.obj

..\dll\moucalls.dll: ..\lib\mou.lib makefile
	@echo LINK $@
	@wlink.exe @<<
     system   os2_dll
     option   map
     name     ..\dll\moucalls
     file     ..\lib\mou.lib 
     file     ..\lib\bmscalls.lib 
     file	..\helpers.obj
<<

..\lib\mou.lib: $(OBJS) makefile
	@echo LIB $@
	@wlib -q -fo $@ $(OBJS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -I..\include $*.asm


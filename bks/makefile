PROJ=bks

ALL: ..\lib\$(PROJ).lib ..\dll\$(PROJ)calls.dll ..\lib\$(PROJ)calls.lib

OBJS=bksmain.obj bkscharin.obj bkspeek.obj bksflushbuffer.obj bksgetstatus.obj bkssetstatus.obj bksstringin.obj bksopen.obj bksclose.obj bksgetfocus.obj &
bksfreefocus.obj bksgetcp.obj bkssetcp.obj bksxlate.obj bkssetcustxt.obj bksgethwid.obj

..\dll\$(PROJ)calls.dll: ..\lib\$(PROJ).lib makefile
	@echo LINK $@
	@wlink.exe @<<
     system   os2_dll
     option   map,nod
     name     ..\dll\$(PROJ)calls
     export BKSMAIN.1 RESIDENT
     file     ..\lib\$(PROJ).lib 
     file	..\helpers.obj
<<

..\lib\$(PROJ)calls.lib: ..\dll\$(PROJ)calls.dll makefile
	@echo LIB $@
	@wlib -q -fo $@ ..\dll\$(PROJ)calls.dll

..\lib\$(PROJ).lib: $(OBJS) makefile
	@echo LIB $@
	@wlib -q -fo $@ $(OBJS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -I..\include $*.asm


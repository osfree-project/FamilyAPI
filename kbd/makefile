PROJ=kbd

ALL: ..\lib\$(PROJ).lib ..\dll\$(PROJ)calls.dll

OBJS=kbdroute.obj kbdcharin.obj kbdpeek.obj kbdflushbuffer.obj kbdgetstatus.obj kbdsetstatus.obj
kbdstringin.obj kbdopen.obj kbdclose.obj kbdgetfocus.obj kbdfreefocus.obj kbdgetcp.obj &
kbdsetcp.obj kbdxlate.obj kbdsetcustxt.obj kbdgethwid.obj

..\dll\$(PROJ)calls.dll: ..\lib\$(PROJ).lib makefile
	@echo LINL $@
	@wlink.exe @<<
     system   os2_dll
     option   map
     name     ..\dll\$(PROJ)calls
     file     ..\lib\$(PROJ).lib 
     file     ..\lib\bkscalls.lib 
     file	..\helpers.obj
<<

..\lib\$(PROJ).lib: $(OBJS)
	@echo LIB $@
	@wlib -q -fo $@ $(OBJS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -I..\include $*.asm


ALL: ..\lib\kbd.lib ..\dll\kbdcalls.dll

OBJS=kbdroute.obj kbdcharin.obj kbdpeek.obj kbdflushbuffer.obj kbdgetstatus.obj kbdsetstatus.obj
kbdstringin.obj kbdopen.obj kbdclose.obj kbdgetfocus.obj kbdfreefocus.obj kbdgetcp.obj &
kbdsetcp.obj kbdxlate.obj kbdsetcustxt.obj kbdgethwid.obj

..\dll\kbdcalls.dll: ..\lib\kbd.lib makefile
	@echo LINL $@
	@wlink.exe @<<
     system   os2_dll
     option   map
     name     ..\dll\kbdcalls
     file     ..\lib\kbd.lib 
     file     ..\lib\bkscalls.lib 
     file	..\helpers.obj
<<

..\lib\kbd.lib: $(OBJS)
	@echo LIB $@
	@wlib -q -fo $@ $(OBJS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -I..\include $*.asm


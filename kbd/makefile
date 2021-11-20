ALL: ..\lib\kbd.lib

OBJS=kbdroute.obj kbdcharin.obj kbdpeek.obj kbdflushbuffer.obj kbdgetstatus.obj kbdsetstatus.obj
kbdstringin.obj kbdopen.obj kbdclose.obj kbdgetfocus.obj kbdfreefocus.obj kbdgetcp.obj &
kbdsetcp.obj kbdxlate.obj kbdsetcustxt.obj kbdgethwid.obj

..\lib\kbd.lib: $(OBJS)
	@echo LIB $@
	@wlib -q -fo $@ $(OBJS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -I..\include $*.asm


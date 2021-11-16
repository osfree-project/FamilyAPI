ALL: ..\lib\kbd.lib

OBJS=kbdroute.obj kbdcharin.obj kbdpeek.obj kbdflushbuffer.obj kbdgetstatus.obj kbdsetstatus.obj
kbdstringin.obj kbdopen.obj kbdclose.obj kbdgetfocus.obj kbdfreefocus.obj kbdgetcp.obj &
kbdsetcp.obj kbdxlate.obj kbdsetcustxt.obj kbdgethwid.obj

..\lib\kbd.lib: $(OBJS)
  wlib -q -fo ..\lib\kbd.lib $(OBJS)

.asm.obj: .AUTODEPEND
	@jwasm.exe -q -I..\include $*.asm


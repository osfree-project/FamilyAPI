ALL: ..\lib\bks.lib

OBJS=bksmain.obj bkscharin.obj bkspeek.obj bksflushbuffer.obj bksgetstatus.obj bkssetstatus.obj bksstringin.obj bksopen.obj bksclose.obj bksgetfocus.obj &
bksfreefocus.obj bksgetcp.obj bkssetcp.obj bksxlate.obj bkssetcustxt.obj bksgethwid.obj

..\lib\bks.lib: $(OBJS)
  wlib -q -fo ..\lib\bks.lib $(OBJS)

.asm.obj: .AUTODEPEND
	@jwasm.exe -q -I..\include $*.asm


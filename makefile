ALL: fapi.lib

OBJS=globalshared.obj helpers.obj baddynlink.obj ginfoseg.obj linfoseg.obj globalvars.obj

fapi.lib: lib/dos.lib lib/mem.lib lib/fm.lib lib/ioctl.lib lib/vio.lib lib/bvs.lib lib/kbd.lib lib/bks.lib lib/mou.lib lib/bms.lib $(OBJS)
  wlib -q -fo fapi.lib +lib/dos.lib +lib/mem.lib +lib/fm.lib +lib/ioctl.lib +lib/vio.lib +lib/bvs.lib +lib/kbd.lib +lib/bks.lib +lib/mou.lib +lib/bms.lib $(OBJS)

.asm.obj: .AUTODEPEND
	@jwasm.exe -q -Iinclude $*.asm


ALL: fapi.lib

OBJS=globalshared.obj helpers.obj baddynlink.obj ginfoseg.obj linfoseg.obj globalvars.obj

fapi.lib: lib/dos.lib lib/mem.lib lib/fm.lib lib/ioctl.lib vio/vio.lib bvs/bvs.lib kbd/kbd.lib lib/bks.lib mou/mou.lib bms/bms.lib $(OBJS)
  wlib -q -fo fapi.lib +lib/dos.lib +lib/mem.lib +lib/fm.lib +lib/ioctl.lib +vio/vio.lib +bvs/bvs.lib +kbd/kbd.lib +lib/bks.lib +mou/mou.lib +bms/bms.lib $(OBJS)

.asm.obj:
	@jwasm.exe -q -Iinclude $*.asm


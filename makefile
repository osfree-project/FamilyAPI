ALL: fapi.lib

OBJS=globalshared.obj helpers.obj baddynlink.obj ginfoseg.obj linfoseg.obj globalvars.obj
LIBS=lib/dos.lib lib/mem.lib lib/fm.lib lib/ioctl.lib lib/vio.lib lib/bvs.lib lib/kbd.lib lib/bks.lib lib/mou.lib lib/bms.lib

fapi.lib: $(LIBS) $(OBJS)
	@echo LIB $@
	@wlib -q -fo $@ $(LIBS) $(OBJS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -Iinclude $*.asm


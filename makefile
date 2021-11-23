ALL: fapi.lib

LIBS=lib/core.lib lib/dos.lib lib/mem.lib lib/fm.lib lib/ioctl.lib lib/vio.lib lib/bvs.lib lib/kbd.lib lib/bks.lib lib/mou.lib lib/bms.lib

fapi.lib: $(LIBS) 
	@echo LIB $@
	@wlib -q -fo $@ $(LIBS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -Iinclude $*.asm


ALL: ../lib/core.lib

OBJS=globalshared.obj baddynlink.obj ginfoseg.obj linfoseg.obj globalvars.obj helpers.obj

../lib/core.lib: $(OBJS)
	@echo LIB $@
	@wlib -q -fo $@ $(LIBS) $(OBJS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -I../include $*.asm


#echo Building Core Subsystem
#echo Core Subsystem build finished
ALL: ../lib/core.lib

OBJS=globalshared.obj baddynlink.obj ginfoseg.obj linfoseg.obj globalvars.obj helpers.obj

../lib/core.lib: $(OBJS)
	@echo LIB $@
	@wlib -q -fo $@ $(LIBS) $(OBJS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -I../include $*.asm

clean: .SYMBOLIC
	if exist *.obj del *.obj
	if exist *.err del *.err
	if exist *.lst del *.lst
	if exist *.map del *.map

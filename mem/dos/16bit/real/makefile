#echo Building 16-bit real mode memory subsystem
#echo 16-bit real mode memory subsystem build finished

ALL: ..\..\..\..\lib\mem16r.lib

OBJS=Dos16RAllocHuge.obj Dos16RAllocSeg.obj Dos16RAllocShrSeg.obj Dos16RCreateCSAlias.obj &
Dos16RFreeSeg.obj Dos16RGetHugeShift.obj Dos16RGetShrSeg.obj Dos16RMemAvail.obj Dos16RReallocSeg.obj &
Dos16RSizeSeg.obj Dos16RReallocHuge.obj

..\..\..\..\lib\mem16r.lib: $(OBJS)
	@echo LIB $@
	@wlib -q -fo $@ $(OBJS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -I..\..\..\..\include $*.asm

clean: .SYMBOLIC
	if exist *.obj del *.obj
	if exist *.err del *.err
	if exist *.lst del *.lst
	if exist *.map del *.map

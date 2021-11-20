ALL: ..\..\..\..\lib\mem16r.lib

OBJS=Dos16RAllocHuge.obj Dos16RAllocSeg.obj Dos16RAllocShrSeg.obj Dos16RCreateCSAlias.obj &
Dos16RFreeSeg.obj Dos16RGetHugeShift.obj Dos16RGetShrSeg.obj Dos16RMemAvail.obj Dos16RReallocSeg.obj

..\..\..\..\lib\mem16r.lib: $(OBJS)
	@echo LIB $@
	@wlib -q -fo $@ $(OBJS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -I..\..\..\..\include $*.asm


ALL: ..\..\..\lib\mem16.lib

OBJS=DosAllocHuge.obj DosAllocSeg.obj DosAllocShrSeg.obj DosCreateCSAlias.obj DosFreeSeg.obj DosGetHugeShift.obj &
DosGetShrSeg.obj DosMemAvail.obj DosReallocSeg.obj DosSubAlloc.obj DosSubFree.obj DosSubSet.obj

..\..\..\lib\mem16.lib: ..\..\..\lib\mem16r.lib ..\..\..\lib\mem16p.lib $(OBJS)
	@echo LIB $@
	@wlib -q -fo $@ ..\..\..\lib\mem16r.lib ..\..\..\lib\mem16p.lib $(OBJS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -I..\..\..\include $*.asm


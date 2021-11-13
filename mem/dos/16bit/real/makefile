ALL: ..\..\..\..\lib\mem.lib

OBJS=DosAllocHuge.obj DosAllocSeg.obj DosAllocShrSeg.obj DosCreateCSAlias.obj DosFreeSeg.obj DosGetHugeShift.obj DosGetShrSeg.obj DosMemAvail.obj DosReallocSeg.obj

..\..\..\..\lib\mem.lib: $(OBJS)
  wlib -q -fo ..\..\..\..\lib\mem.lib $(OBJS)

.asm.obj:
	@jwasm.exe -q -I..\..\..\..\include $*.asm


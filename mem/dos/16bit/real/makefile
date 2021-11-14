ALL: ..\..\..\..\lib\mem16r.lib

OBJS=DosAllocHuge.obj DosAllocSeg.obj DosAllocShrSeg.obj DosCreateCSAlias.obj DosFreeSeg.obj DosGetHugeShift.obj DosGetShrSeg.obj DosMemAvail.obj DosReallocSeg.obj

..\..\..\..\lib\mem16r.lib: $(OBJS)
  wlib -q -fo ..\..\..\..\lib\mem16r.lib $(OBJS)

.asm.obj:
	@jwasm.exe -q -I..\..\..\..\include $*.asm


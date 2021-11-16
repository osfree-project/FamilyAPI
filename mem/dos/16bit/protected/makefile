ALL: ..\..\..\..\lib\mem16p.lib

OBJS=DosAllocHuge.obj DosAllocSeg.obj DosAllocShrSeg.obj DosCreateCSAlias.obj DosFreeSeg.obj DosGetHugeShift.obj DosGetShrSeg.obj DosMemAvail.obj DosReallocSeg.obj

..\..\..\..\lib\mem16p.lib: $(OBJS)
  wlib -q -fo ..\..\..\..\lib\mem16p.lib $(OBJS)

.asm.obj:
	@jwasm.exe -q -I..\..\..\..\include $*.asm


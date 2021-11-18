ALL: ..\..\..\..\lib\mem16p.lib

OBJS=Dos16PAllocHuge.obj Dos16PAllocSeg.obj Dos16PAllocShrSeg.obj Dos16PCreateCSAlias.obj Dos16PFreeSeg.obj &
Dos16PGetHugeShift.obj Dos16PGetShrSeg.obj Dos16PMemAvail.obj Dos16PReallocSeg.obj

..\..\..\..\lib\mem16p.lib: $(OBJS)
  wlib -q -fo ..\..\..\..\lib\mem16p.lib $(OBJS)

.asm.obj: .AUTODEPEND
	@jwasm.exe -q -I..\..\..\..\include $*.asm


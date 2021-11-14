ALL: ..\..\..\lib\mem16.lib

OBJS=DosSubAlloc.obj DosSubFree.obj DosSubSet.obj

..\..\..\lib\mem16.lib: $(OBJS)
  wlib -q -fo ..\..\..\lib\mem16.lib ..\..\..\lib\mem16r.lib $(OBJS)

.asm.obj:
	@jwasm.exe -q -I..\..\..\include $*.asm


#echo Building 16-bit protected mode memory subsystem
#echo 16-bit protected mode memory subsystem build finished

ALL: ..\..\..\..\lib\mem16p.lib

OBJS=Dos16PAllocHuge.obj Dos16PAllocSeg.obj Dos16PAllocShrSeg.obj Dos16PCreateCSAlias.obj Dos16PFreeSeg.obj &
Dos16PGetHugeShift.obj Dos16PGetShrSeg.obj Dos16PMemAvail.obj Dos16PReallocSeg.obj

..\..\..\..\lib\mem16p.lib: $(OBJS)
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

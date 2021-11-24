#echo Building 16-bit memory subsystem
#echo 16-bit memory subsystem build finished

ALL: build ..\..\..\lib\mem16.lib

build: .SYMBOLIC
	cd dpmi
	@$(MAKE) -h
	cd ..
	cd real
	@$(MAKE) -h
	cd ..

OBJS=DosAllocHuge.obj DosAllocSeg.obj DosAllocShrSeg.obj DosCreateCSAlias.obj DosFreeSeg.obj DosGetHugeShift.obj &
DosGetShrSeg.obj DosMemAvail.obj DosReallocSeg.obj DosSubAlloc.obj DosSubFree.obj DosSubSet.obj

..\..\..\lib\mem16.lib: ..\..\..\lib\mem16r.lib ..\..\..\lib\mem16p.lib $(OBJS)
	@echo LIB $@
	@wlib -q -fo $@ ..\..\..\lib\mem16r.lib ..\..\..\lib\mem16p.lib $(OBJS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -I..\..\..\include $*.asm

clean: .SYMBOLIC
	if exist *.obj del *.obj
	if exist *.err del *.err
	if exist *.lst del *.lst
	if exist *.map del *.map
	cd dpmi
	@$(MAKE) -h clean
	cd ..
#	cd vcpi
#	@$(MAKE) -h clean
#	cd ..
#	cd xms
#	@$(MAKE) -h clean
#	cd ..
#	cd int15
#	@$(MAKE) -h clean
#	cd ..
	cd real
	@$(MAKE) -h clean
	cd ..

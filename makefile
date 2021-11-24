ALL: fapi.lib

LIBS=lib/core.lib lib/dos.lib lib/mem.lib lib/fm.lib lib/ioctl.lib lib/vio.lib lib/bvs.lib lib/kbd.lib lib/bks.lib lib/mou.lib lib/bms.lib

fapi.lib: $(LIBS) 
 	@echo LIB $@
	@wlib -q -fo $@ $(LIBS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -Iinclude $*.asm

clean: .SYMBOLIC
	cd dll
	if exist *.dll del *.dll
	cd ..
	cd lib
	if exist *.bak del *.bak
	if exist *.lib del *.lib
	cd ..
	cd core
	@$(MAKE) -h clean
	cd ..
	cd mem
	@$(MAKE) -h clean
	cd ..
	cd bvs
	@$(MAKE) -h clean
	cd ..
	cd bms
	@$(MAKE) -h clean
	cd ..
	cd bks
	@$(MAKE) -h clean
	cd ..
	cd vio
	@$(MAKE) -h clean
	cd ..
	cd mou
	@$(MAKE) -h clean
	cd ..
	cd kbd
	@$(MAKE) -h clean
	cd ..
        cd fm
	@$(MAKE) -h clean
	cd ..
	cd ioctl
	@$(MAKE) -h clean
	cd ..
	cd dos
	@$(MAKE) -h clean
	cd ..

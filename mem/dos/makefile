#echo Building memory subsystem
#echo Memory subsystem build finished
ALL: build ..\..\lib\mem.lib

build: .SYMBOLIC
	cd 16bit
	@$(MAKE) -h
	cd ..

..\..\lib\mem.lib: ..\..\lib\mem16.lib
	@echo LIB $@
	@wlib -q -fo $@ ..\..\lib\mem16.lib

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -I..\..\..\include $*.asm

clean: .SYMBOLIC
	cd 16bit
	@$(MAKE) -h clean
	cd ..

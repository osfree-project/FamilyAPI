ALL: ..\..\lib\mem.lib

..\..\lib\mem.lib: ..\..\lib\mem16.lib
	@echo LIB $@
	@wlib -q -fo $@ ..\..\lib\mem16.lib

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -I..\..\..\include $*.asm


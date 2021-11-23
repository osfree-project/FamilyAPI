ALL: ..\lib\bks.lib ..\dll\bkscalls.dll ..\lib\bkscalls.lib

OBJS=bksmain.obj bkscharin.obj bkspeek.obj bksflushbuffer.obj bksgetstatus.obj bkssetstatus.obj bksstringin.obj bksopen.obj bksclose.obj bksgetfocus.obj &
bksfreefocus.obj bksgetcp.obj bkssetcp.obj bksxlate.obj bkssetcustxt.obj bksgethwid.obj

..\dll\bkscalls.dll: ..\lib\bks.lib makefile
	@echo LINK $@
	@wlink.exe @<<
     system   os2_dll
     option   map,nod
     name     ..\dll\bkscalls
     export BKSMAIN.1 RESIDENT
     file     ..\lib\bks.lib 
     file	..\helpers.obj
<<

..\lib\bkscalls.lib: ..\dll\bkscalls.dll makefile
	@echo LIB $@
	@wlib -q -fo $@ ..\dll\bkscalls.dll

..\lib\bks.lib: $(OBJS) makefile
	@echo LIB $@
	@wlib -q -fo $@ $(OBJS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -I..\include $*.asm


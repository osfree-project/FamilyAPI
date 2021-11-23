ALL: ..\lib\$(PROJ).lib ..\dll\$(PROJ)calls.dll ..\lib\$(PROJ)calls.lib

..\dll\$(PROJ)calls.dll: ..\lib\$(PROJ).lib makefile
	@echo LINK $@
	@wlink.exe op q libpath ..\lib @<<
     system   os2_dll
     option   map,nod
     name     ..\dll\$(PROJ)calls
     export $(EXPORT)
     file     $(PROJ).lib 
     file	core.lib
!ifdef IMPORT
     lib $(IMPORT) 
!endif
<<

..\lib\$(PROJ)calls.lib: ..\dll\$(PROJ)calls.dll makefile
	@echo LIB $@
	@wlib -q -fo $@ ..\dll\$(PROJ)calls.dll

..\lib\$(PROJ).lib: $(OBJS) makefile
	@echo LIB $@
	@wlib -q -fo $@ $(OBJS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -I..\include $*.asm


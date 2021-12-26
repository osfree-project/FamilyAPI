#echo Building DOS subsystem
#echo DOS subsystem build finished

PROJ=dos

ALL: ../lib/$(PROJ).lib ..\dll\$(PROJ)calls.dll

OBJS=dosbeep.obj dosqsysinfo.obj dosdevconfig.obj dosgetdatetime.obj doserror.obj &
dosexecpgm.obj dosexit.obj dosexitlist.obj dosgetenv.obj dosgetpid.obj dosportaccess.obj &
doscliaccess.obj dosgetmachinemode.obj dosgetversion.obj dossleep.obj dossetdatetime.obj dossetvec.obj dosgetinfoseg.obj &
dosholdsignal.obj dossystrace.obj dosgetstda.obj

#dossetsighandler.obj dosfreemodule.obj dosgetmodule.obj dosgetprocaddr.obj

..\dll\$(PROJ)calls.dll: ..\lib\$(PROJ).lib
	@echo LINK $@
	@wlink.exe op q @<<
    option osname='OS/2 16-bit'
    format os2 dll ^
     option   map, nod
     name     ..\dll\$(PROJ)calls
     file     ..\lib\$(PROJ).lib
     file     ..\lib\core.lib
	file  ..\lib\mem.lib
	file ..\lib\fm.lib 
	file ..\lib\nls.lib 
	file ..\lib\ioctl.lib
<<

../lib/$(PROJ).lib:  $(OBJS) 
	@echo LIB $@
	@wlib -q -fo $@ $(OBJS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -Fl -q -I../include $*.asm

clean: .SYMBOLIC
	if exist *.obj del *.obj
	if exist *.err del *.err
	if exist *.lst del *.lst
	if exist *.map del *.map

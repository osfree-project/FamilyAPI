PROJ=dos

ALL: ../lib/$(PROJ).lib ..\dll\$(PROJ)calls.dll

OBJS=dosbeep.obj dosgetmessage.obj dosqsysinfo.obj doscasemap.obj dossetctrycode.obj dosgetdbcsev.obj dosdevconfig.obj dosgetdatetime.obj doserror.obj &
dosexecpgm.obj dosexit.obj dosexitlist.obj dosgetcp.obj dossetcp.obj dosgetenv.obj dosgetpid.obj dosportaccess.obj &
doscliaccess.obj dosgetmachinemode.obj dosgetversion.obj dossleep.obj dossetdatetime.obj dossetvec.obj dosgetinfoseg.obj &
dosputmessage.obj dosputmessage.obj dosinsmessage.obj dosgetctryinfo.obj dosholdsignal.obj

#dossetsighandler.obj dosfreemodule.obj dosgetmodule.obj dosgetprocaddr.obj

..\dll\$(PROJ)calls.dll: ..\lib\$(PROJ).lib
	@echo LINK $@
	@wlink.exe @<<
     system   os2_dll
     option   map, nod
     name     ..\dll\$(PROJ)calls
     file     ..\lib\$(PROJ).lib
     file     ..\helpers.obj
     file     ..\globalshared.obj
     file     ..\globalvars.obj
     file     ..\ginfoseg.obj
     file     ..\linfoseg.obj
<<

../lib/$(PROJ).lib:  $(OBJS) makefile
	@echo LIB $@
	@wlib -q -fo $@ $(OBJS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -I../include $*.asm


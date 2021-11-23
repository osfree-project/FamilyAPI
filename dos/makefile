ALL: ../lib/dos.lib ..\dll\doscalls.dll

OBJS=dosbeep.obj dosgetmessage.obj dosqsysinfo.obj doscasemap.obj dossetctrycode.obj dosgetdbcsev.obj dosdevconfig.obj dosgetdatetime.obj doserror.obj &
dosexecpgm.obj dosexit.obj dosexitlist.obj dosgetcp.obj dossetcp.obj dosgetenv.obj dosgetpid.obj dosportaccess.obj &
doscliaccess.obj dosgetmachinemode.obj dosgetversion.obj dossleep.obj dossetdatetime.obj dossetvec.obj dosgetinfoseg.obj &
dosputmessage.obj dosputmessage.obj dosinsmessage.obj dosgetctryinfo.obj dosholdsignal.obj

#dossetsighandler.obj dosfreemodule.obj dosgetmodule.obj dosgetprocaddr.obj

..\dll\doscalls.dll: ..\lib\dos.lib
	@echo LINK $@
	@wlink.exe @<<
     system   os2_dll
     option   map, nod
     name     ..\dll\doscalls
     file     ..\lib\dos.lib
     file     ..\helpers.obj
     file     ..\globalshared.obj
     file     ..\globalvars.obj
     file     ..\ginfoseg.obj
     file     ..\linfoseg.obj
<<

../lib/dos.lib:  $(OBJS) makefile
	@echo LIB $@
	@wlib -q -fo $@ $(OBJS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -I../include $*.asm


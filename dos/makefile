PROJ=dos

ALL: ../lib/$(PROJ).lib ..\dll\$(PROJ)calls.dll

OBJS=dosbeep.obj dosgetmessage.obj dosqsysinfo.obj doscasemap.obj dossetctrycode.obj dosgetdbcsev.obj dosdevconfig.obj dosgetdatetime.obj doserror.obj &
dosexecpgm.obj dosexit.obj dosexitlist.obj dosgetcp.obj dossetcp.obj dosgetenv.obj dosgetpid.obj dosportaccess.obj &
doscliaccess.obj dosgetmachinemode.obj dosgetversion.obj dossleep.obj dossetdatetime.obj dossetvec.obj dosgetinfoseg.obj &
dosputmessage.obj dosputmessage.obj dosinsmessage.obj dosgetctryinfo.obj dosholdsignal.obj

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
	file ..\lib\ioctl.lib
<<

../lib/$(PROJ).lib:  $(OBJS) 
	@echo LIB $@
	@wlib -q -fo $@ $(OBJS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -I../include $*.asm

clean: .SYMBOLIC
	if exist *.obj del *.obj
	if exist *.err del *.err
	if exist *.lst del *.lst
	if exist *.map del *.map

ALL: ../lib/dos.lib

OBJS=dosbeep.obj dosgetmessage.obj dosqsysinfo.obj doscasemap.obj dossetctrycode.obj dosgetdbcsev.obj dosdevconfig.obj dosgetdatetime.obj doserror.obj &
dosexecpgm.obj dosexit.obj dosexitlist.obj dosgetcp.obj dossetcp.obj dosgetenv.obj dosgetmodule.obj dosgetprocaddr.obj dosgetpid.obj dosportaccess.obj &
doscliaccess.obj dosgetmachinemode.obj dosgetversion.obj dossleep.obj dossetdatetime.obj dossetsighandler.obj dossetvec.obj dosgetinfoseg.obj &
dosputmessage.obj dosputmessage.obj dosinsmessage.obj dosfreemodule.obj dosgetctryinfo.obj dosholdsignal.obj

../lib/dos.lib:  $(OBJS)
	@echo LIB $@
	@wlib -q -fo $@ $(OBJS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -I../include $*.asm


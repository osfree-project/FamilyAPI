#echo Building DOS subsystem
#echo DOS subsystem build finished

PROJ=dos

ALL: ../lib/$(PROJ).lib ..\dll\$(PROJ)calls.dll

OBJS=dosbeep.obj dosqsysinfo.obj dosdevconfig.obj dosgetdatetime.obj doserror.obj &
dosexecpgm.obj dosexit.obj dosexitlist.obj dosgetenv.obj dosgetpid.obj dosportaccess.obj &
doscliaccess.obj dosgetmachinemode.obj dosgetversion.obj dossleep.obj dossetdatetime.obj dossetvec.obj dosgetinfoseg.obj &
dosholdsignal.obj dossystrace.obj dosgetstda.obj dosclosequeue.obj dosclosesem.obj &
doscreatesem.obj doscreatequeue.obj doscreatethread.obj doscwait.obj dosentercritsec.obj &
dosexitcritsec.obj dosflagprocess.obj dosgetprty.obj doskillprocess.obj &
dosmakepipe.obj dosmonclose.obj dosmonopen.obj dosmonread.obj dosmonreg.obj dosmonwrite.obj &
dosmuxsemwait.obj dosopenqueue.obj dosopensem.obj dospeekqueue.obj dospfsactivate.obj &
dospfscloseuser.obj dospfsinit.obj dospfsqueryact.obj dospfsverifyfont.obj dosphysicaldisk.obj &
dosptrace.obj dospurgequeue.obj dosqueryqueue.obj dosreadqueue.obj dosresumethread.obj &
dosscanenv.obj dossearchpath.obj dosselectsession.obj dossemclear.obj dossemrequest.obj &
dossemset.obj dossemsetwait.obj dossemwait.obj dossendsignal.obj dossetprty.obj dossetsession.obj &
dosstartsession.obj dosstopsession.obj dossuspendthread.obj dostimerasync.obj &
dostimerstart.obj dostimerstop.obj doswritequeue.obj doserrclass.obj debug.obj

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
	import VioWrtTTY VIOCALLS.19
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

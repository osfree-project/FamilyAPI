ALL: fapi.lib

OBJS=globalshared.obj helpers.obj baddynlink.obj dosbeep.obj &
dosbufreset.obj dosgetmessage.obj dosqsysinfo.obj  &
doscasemap.obj &
dossetctrycode.obj &
doschdir.obj &
dosdevioctl.obj &
dosmkdir.obj &
dosclose.obj &
dosgetdbcsev.obj &
dosdelete.obj &
dosdevconfig.obj &
dosgetdatetime.obj &
dosduphandle.obj &
doserror.obj &
dosexecpgm.obj &
dosexit.obj &
dosexitlist.obj &
dosfirst.obj &
dosgetcp.obj &
dossetcp.obj &
dosgetenv.obj &
dosgetmo.obj &
dosgetpr.obj &
dosgtpid.obj &
dosportaccess.obj &
doscliaccess.obj &
doslock.obj &
dossetmaxfh.obj &
dosgetmachinemode.obj &
dosmove.obj &
dosnewsize.obj &
dosopen.obj &
dosqcurdir.obj &
dosqcurdisk.obj &
dosqfileinfo.obj &
dosqfsinfo.obj &
dosrmdir.obj &
dosqverify.obj &
dosqfilemode.obj &
dosqhand.obj &
dosgetversion.obj &
dosread.obj &
doschgfileptr.obj &
dossetfileinfo.obj &
dossetfilemode.obj &
dosselectdisk.obj &
dossleep.obj &
dossetdatetime.obj &
dossetverify.obj &
dosssig.obj &
dosstvec.obj &
doswrite.obj &
dosgetinfoseg.obj &
ginfoseg.obj &
linfoseg.obj &
globalvars.obj

fapi.lib: lib/mem.lib vio/vio.lib bvs/bvs.lib kbd/kbd.lib bks/bks.lib mou/mou.lib bms/bms.lib $(OBJS)
  wlib -q -fo fapi.lib +lib/mem.lib +vio/vio.lib +bvs/bvs.lib +kbd/kbd.lib +bks/bks.lib +mou/mou.lib +bms/bms.lib &
+globalshared.obj +helpers.obj +baddynlink.obj +dosbeep.obj &
+dosbufreset.obj +dosgetmessage.obj +dosqsysinfo.obj &
+doscasemap.obj &
+dossetctrycode.obj &
+doschdir.obj &
+dosdevioctl.obj &
+dosmkdir.obj &
+dosclose.obj &
+dosgetdbcsev.obj &
+dosdelete.obj &
+dosdevconfig.obj &
+dosgetdatetime.obj &
+dosduphandle.obj &
+doserror.obj &
+dosexecpgm.obj &
+dosexit.obj &
+dosexitlist.obj &
+dosfirst.obj &
+dosgetcp.obj &
+dossetcp.obj &
+dosgetenv.obj &
+dosgetmo.obj &
+dosgetpr.obj &
+dosgtpid.obj &
+doscliaccess.obj +dosportaccess.obj &
+doslock.obj &
+dossetmaxfh.obj &
+dosgetmachinemode.obj &
+dosmove.obj &
+dosnewsize.obj &
+dosopen.obj &
+dosqcurdir.obj &
+dosqcurdisk.obj &
+dosqfileinfo.obj &
+dosqfsinfo.obj &
+dosrmdir.obj &
+dosqverify.obj &
+dosqfilemode.obj &
+dosqhand.obj &
+dosgetversion.obj &
+dosread.obj &
+doschgfileptr.obj &
+dossetfileinfo.obj &
+dossetfilemode.obj &
+dosselectdisk.obj &
+dossleep.obj &
+dossetdatetime.obj &
+dossetverify.obj &
+dosssig.obj &
+dosstvec.obj &
+doswrite.obj &
+dosgetinfoseg.obj &
+ginfoseg.obj &
+linfoseg.obj &
+globalvars.obj

.asm.obj:
	@jwasm.exe -q -Iinclude $*.asm


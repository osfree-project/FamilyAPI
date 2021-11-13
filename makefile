ALL: fapi.lib

OBJS=globalshared.obj helpers.obj baddynlink.obj dosbeep.obj &
dosgetmessage.obj dosqsysinfo.obj  &
doscasemap.obj &
dossetctrycode.obj &
dosgetdbcsev.obj &
dosdevconfig.obj &
dosgetdatetime.obj &
doserror.obj &
dosexecpgm.obj &
dosexit.obj &
dosexitlist.obj &
dosgetcp.obj &
dossetcp.obj &
dosgetenv.obj &
dosgetmo.obj &
dosgetpr.obj &
dosgtpid.obj &
dosportaccess.obj &
doscliaccess.obj &
dosgetmachinemode.obj &
dosgetversion.obj &
dossleep.obj &
dossetdatetime.obj &
dosssig.obj &
dosstvec.obj &
dosgetinfoseg.obj &
ginfoseg.obj &
linfoseg.obj &
globalvars.obj

fapi.lib: lib/mem.lib lib/fm.lib lib/ioctl.lib vio/vio.lib bvs/bvs.lib kbd/kbd.lib bks/bks.lib mou/mou.lib bms/bms.lib $(OBJS)
  wlib -q -fo fapi.lib +lib/mem.lib +lib/fm.lib +lib/ioctl.lib +vio/vio.lib +bvs/bvs.lib +kbd/kbd.lib +bks/bks.lib +mou/mou.lib +bms/bms.lib $(OBJS)

.asm.obj:
	@jwasm.exe -q -Iinclude $*.asm


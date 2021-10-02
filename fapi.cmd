@echo off
cd vio
call make
cd ..
cd bvs
call make
cd ..
cd mou
call make
cd ..
cd bms
call make
cd ..
cd kbd
call make
cd ..
cd bks
call make
cd ..

rem dosloadmodule
:jwasm -q checkpathname.asm
:jwasm -q unloadmod16.asm
:jwasm -q setnpbase.asm
:jwasm -q loadnetables.asm
:jwasm -q load_segm.asm
:jwasm -q loadrefmods16.asm
:jwasm -q loadsegmtable.asm
:jwasm -q loadmodule16.asm
:jwasm -q dopreloads.asm
:jwasm -q segment2module.asm
:jwasm -q searchmodule16.asm
:jwasm -q loadlibintern2.asm
:jwasm -q segno2sel.asm
:jwasm -q freememory.asm
:jwasm -q freesegmmem.asm
:jwasm -q cleanupne.asm
:jwasm -q deletemodule16.asm
:jwasm -q strlen.asm
:jwasm -q searchneexport.asm
:jwasm -q freelibrary.asm
:jwasm -q freelib16.asm
:jwasm -q checkne.asm
:jwasm -q getprocaddress.asm
:jwasm -q getprocaddress16.asm
:jwasm -q getprocaddr16.asm
:jwasm -q dosloadmodule.ASM
:jwasm -q dosfrmod.ASM

jwasm -q globalvars.asm
jwasm -q globalshared.asm
jwasm -q helpers.asm
jwasm -q baddynlink.asm
jwasm -q dosmemavail.asm
jwasm -q dosgetmessage.asm
jwasm -q doscreatecsalias.asm
jwasm -q dossetctrycode.asm
jwasm -q dosallocseg.ASM
jwasm -q dosallocshrseg.ASM
jwasm -q dosgetshrseg.ASM
jwasm -q dosqsysinfo.ASM
jwasm -q doscliaccess.ASM
jwasm -q dosportaccess.ASM
jwasm -q dosbeep.ASM 
jwasm -q dosdevioctl.ASM 
jwasm -q doscasemap.ASM 
jwasm -q dosbufreset.ASM 
jwasm -q doschdir.ASM
jwasm -q dosclose.ASM
jwasm -q dosdbcs.ASM 
jwasm -q dosdelete.ASM  
jwasm -q dosdevconfig.ASM  
jwasm -q dosgetdatetime.ASM
jwasm -q dosduphandle.ASM 
jwasm -q doserror.ASM
jwasm -q dosexecpgm.ASM 
jwasm -q dosexit.ASM 
jwasm -q dosexitl.ASM
jwasm -q dosfirst.ASM
jwasm -q dosfreeseg.ASM
jwasm -q dosgetcp.ASM
jwasm -q dossetcp.ASM
jwasm -q dosgetenv.ASM
jwasm -q dosgetmo.ASM
jwasm -q dosgethugeshift.ASM
jwasm -q dosgetpr.ASM
jwasm -q dosgtpid.ASM
jwasm -q dosallochuge.ASM 
jwasm -q doslock.ASM 
jwasm -q dosmaxfh.ASM
jwasm -q dosgetmachinemode.ASM 
jwasm -q dosmove.ASM 
jwasm -q dosnewsize.ASM
jwasm -q dosopen.ASM 
jwasm -q dosqcurdir.ASM 
jwasm -q dosqfsinfo.ASM 
jwasm -q dosqcurdisk.ASM 
jwasm -q dosqfileinfo.ASM
jwasm -q dosrmdir.ASM
jwasm -q dossetdatetime.ASM
jwasm -q dosqfilemode.ASM
jwasm -q dosqhand.ASM
jwasm -q dosmkdir.ASM
jwasm -q dosgetversion.ASM 
jwasm -q dosrallc.ASM
jwasm -q dosread.ASM 
jwasm -q doschgfileptr.ASM 
jwasm -q dossetfileinfo.ASM
jwasm -q dossetfilemode.ASM
jwasm -q dossetverify.ASM
jwasm -q dosselectdisk.ASM
jwasm -q dossleep.ASM
jwasm -q dosssig.ASM 
jwasm -q dosstvec.ASM
jwasm -q doswrite.ASM
jwasm -q dosqverify.asm

:jwasm -q csalias.ASM
:jwasm -q gblreal.ASM

del fapi.lib
rem dos*module
:wlib -q -fo fapi.lib +dosloadmodule.obj +searchmodule16.obj
:wlib -q -fo fapi.lib +segment2module.obj
:wlib -q -fo fapi.lib +loadrefmods16.obj
:wlib -q -fo fapi.lib +insertmodule16.obj
:wlib -q -fo fapi.lib +dopreloads.obj
:wlib -q -fo fapi.lib +load_segm.obj
:wlib -q -fo fapi.lib +loadsegmtable.obj
:wlib -q -fo fapi.lib +loadnetables.obj
:wlib -q -fo fapi.lib +loadlibintern2.obj
:wlib -q -fo fapi.lib +freememory.obj
:wlib -q -fo fapi.lib +freelibrary.obj
:wlib -q -fo fapi.lib +freelib16.obj
:wlib -q -fo fapi.lib +segno2sel.obj
:wlib -q -fo fapi.lib +unloadmod16.obj
:wlib -q -fo fapi.lib +setnpbase.obj
:wlib -q -fo fapi.lib +checkne.obj
:wlib -q -fo fapi.lib +checkpathname.obj
:wlib -q -fo fapi.lib +strlen.obj
:wlib -q -fo fapi.lib +cleanupne.obj
:wlib -q -fo fapi.lib +deletemodule16.obj
:wlib -q -fo fapi.lib +freesegmmem.obj
:wlib -q -fo fapi.lib +searchneexport.obj
:wlib -q -fo fapi.lib +getprocaddress.obj
:wlib -q -fo fapi.lib +getprocaddress16.obj
:wlib -q -fo fapi.lib +getprocaddr16.obj
:wlib -q -fo fapi.lib +dosfrmod.obj

:+csalias.obj

wlib -q -fo fapi.lib +globalshared.obj +helpers.obj +baddynlink.obj  +dosallocseg.obj +dosallocshrseg.obj +dosbeep.obj
wlib -q -fo fapi.lib +dosbufreset.obj +doscreatecsalias.obj +dosgetmessage.obj +dosqsysinfo.obj +dosgetshrseg.obj
wlib -q -fo fapi.lib +doscasemap.obj +dosmemavail.obj
wlib -q -fo fapi.lib +dossetctrycode.obj
wlib -q -fo fapi.lib +doschdir.obj
wlib -q -fo fapi.lib +dosdevioctl.obj
wlib -q -fo fapi.lib +dosmkdir.obj
wlib -q -fo fapi.lib +dosclose.obj
wlib -q -fo fapi.lib +dosdbcs.obj
wlib -q -fo fapi.lib +dosdelete.obj
wlib -q -fo fapi.lib +dosdevconfig.obj
wlib -q -fo fapi.lib +dosgetdatetime.obj
wlib -q -fo fapi.lib +dosduphandle.obj
wlib -q -fo fapi.lib +doserror.obj
wlib -q -fo fapi.lib +dosexecpgm.obj
wlib -q -fo fapi.lib +dosexit.obj
wlib -q -fo fapi.lib +dosexitl.obj
wlib -q -fo fapi.lib +dosfirst.obj
wlib -q -fo fapi.lib +dosfreeseg.obj
wlib -q -fo fapi.lib +dosgetcp.obj
wlib -q -fo fapi.lib +dossetcp.obj
wlib -q -fo fapi.lib +dosgetenv.obj
wlib -q -fo fapi.lib +dosgethugeshift.obj
wlib -q -fo fapi.lib +dosgetmo.obj
wlib -q -fo fapi.lib +dosgetpr.obj
wlib -q -fo fapi.lib +dosgtpid.obj
wlib -q -fo fapi.lib +dosallochuge.obj
wlib -q -fo fapi.lib +doscliaccess.obj +dosportaccess.obj
wlib -q -fo fapi.lib +doslock.obj
wlib -q -fo fapi.lib +dosmaxfh.obj
wlib -q -fo fapi.lib +dosgetmachinemode.obj
wlib -q -fo fapi.lib +dosmove.obj
wlib -q -fo fapi.lib +dosnewsize.obj
wlib -q -fo fapi.lib +dosopen.obj
wlib -q -fo fapi.lib +dosqcurdir.obj
wlib -q -fo fapi.lib +dosqcurdisk.obj
wlib -q -fo fapi.lib +dosqfileinfo.obj
wlib -q -fo fapi.lib +dosqfsinfo.obj
wlib -q -fo fapi.lib +dosrmdir.obj
wlib -q -fo fapi.lib +dosqverify.obj
wlib -q -fo fapi.lib +dosqfilemode.obj
wlib -q -fo fapi.lib +dosqhand.obj
wlib -q -fo fapi.lib +dosgetversion.obj
wlib -q -fo fapi.lib +dosrallc.obj
wlib -q -fo fapi.lib +dosread.obj
wlib -q -fo fapi.lib +doschgfileptr.obj
wlib -q -fo fapi.lib +dossetfileinfo.obj
wlib -q -fo fapi.lib +dossetfilemode.obj
wlib -q -fo fapi.lib +dosselectdisk.obj
wlib -q -fo fapi.lib +dossleep.obj
wlib -q -fo fapi.lib +dossetdatetime.obj
wlib -q -fo fapi.lib +dossetverify.obj
wlib -q -fo fapi.lib +dosssig.obj
wlib -q -fo fapi.lib +dosstvec.obj
wlib -q -fo fapi.lib +doswrite.obj
:wlib -q -fo fapi.lib +gblreal.obj

wlib -q -fo fapi.lib +globalvars.obj

rem Fapi Subsystem
wlib -q -fo fapi.lib +vio/vio.lib +bvs/bvs.lib +kbd/kbd.lib +bks/bks.lib +mou/mou.lib +bms/bms.lib

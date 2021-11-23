@echo off
cd mem
call make
cd ..
cd bvs
call make
cd ..
cd bms
call make
cd ..
cd bks
call make
cd ..

cd vio
call make
cd ..
cd mou
call make
cd ..
cd kbd
call make
cd ..

cd fm
call make
cd ..
cd ioctl
call make
cd ..
cd dos
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


:jwasm -q csalias.ASM
:jwasm -q gblreal.ASM

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

echo Building Family API Subsystem
wmake -h
echo Family API Subsystem builded

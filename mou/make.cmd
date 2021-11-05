@echo off

echo Building Mouse subsystem
if exist mou.lib del mou.lib
if exist *.obj del *.obj
if exist *.lst del *.lst
if exist *.err del *.err
if exist *.bak del *.bak

rem Mouse subsystem
jwasm -q mouroute.asm
jwasm -q mougetnumbuttons.asm
jwasm -q mougetnummickeys.asm
jwasm -q mougetdevstatus.asm
jwasm -q mougetnumqueel.asm
jwasm -q moureadeventque.asm
jwasm -q mougetscalefact.asm
jwasm -q mougeteventmask.asm
jwasm -q mousetscalefact.asm
jwasm -q mouseteventmask.asm
jwasm -q mougethotkey.asm
jwasm -q mousethotkey.asm
jwasm -q mouopen.asm
jwasm -q mouclose.asm
jwasm -q mougetptrshape.asm
jwasm -q mousetptrshape.asm
jwasm -q moudrawptr.asm
jwasm -q mouremoveptr.asm
jwasm -q mougetptrpos.asm
jwasm -q mousetptrpos.asm
jwasm -q mouinitreal.asm
jwasm -q mouflushque.asm
jwasm -q mousetdevstatus.asm

rem Mou Subsystem
wlib -q -fo mou.lib +mouroute.obj +mougetnumbuttons.obj +mougetnummickeys.obj +mougetdevstatus.obj
wlib -q -fo mou.lib +mougetnumqueel.obj +moureadeventque.obj +mougetscalefact.obj +mougeteventmask.obj
wlib -q -fo mou.lib +mousetscalefact.obj +mouseteventmask.obj +mougethotkey.obj +mousethotkey.obj
wlib -q -fo mou.lib +mouopen.obj +mouclose.obj +mougetptrshape.obj +mousetptrshape.obj
wlib -q -fo mou.lib +moudrawptr.obj +mouremoveptr.obj +mougetptrpos.obj +mousetptrpos.obj
wlib -q -fo mou.lib +mouinitreal.obj +mouflushque.obj +mousetdevstatus.obj

echo Mouse subsystem build finished

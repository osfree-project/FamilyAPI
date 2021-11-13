@echo off

echo Building Base Mouse Subsystem
if exist bms.lib del bms.lib
if exist *.obj del *.obj
if exist *.lst del *.lst
if exist *.err del *.err
if exist *.bak del *.bak

rem Base Mouse Subsystem
jwasm -q bmsmain.asm
jwasm -q bmsgetnumbuttons.asm
jwasm -q bmsgetnummickeys.asm
jwasm -q bmsgetdevstatus.asm
jwasm -q bmsgetnumqueel.asm
jwasm -q bmsreadeventque.asm
jwasm -q bmsgetscalefact.asm
jwasm -q bmsgeteventmask.asm
jwasm -q bmssetscalefact.asm
jwasm -q bmsseteventmask.asm
jwasm -q bmsgethotkey.asm
jwasm -q bmssethotkey.asm
jwasm -q -I..\include bmsopen.asm
jwasm -q bmsclose.asm
jwasm -q bmsgetptrshape.asm
jwasm -q bmssetptrshape.asm
jwasm -q bmsdrawptr.asm
jwasm -q bmsremoveptr.asm
jwasm -q bmsgetptrpos.asm
jwasm -q bmssetptrpos.asm
jwasm -q bmsinitreal.asm
jwasm -q bmsflushque.asm
jwasm -q bmssetdevstatus.asm

rem Base Mouse Subsystem
wlib -q -fo bms.lib +bmsmain.obj 

echo Base Mouse Subsystem build finished

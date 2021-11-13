@echo off

echo Building Base Keyboard Subsystem
if exist bks.lib del bks.lib
if exist *.obj del *.obj
if exist *.lst del *.lst
if exist *.err del *.err
if exist *.bak del *.bak

rem Base Keyboard Subsystem
jwasm -q -I..\include bksmain.asm
jwasm -q -I..\include bkscharin.asm
jwasm -q -I..\include bkspeek.asm
jwasm -q -I..\include bksflushbuffer.asm
jwasm -q -I..\include bksgetstatus.asm
jwasm -q -I..\include bkssetstatus.asm
jwasm -q -I..\include bksstringin.asm
jwasm -q -I..\include bksopen.asm
jwasm -q -I..\include bksclose.asm
jwasm -q -I..\include bksgetfocus.asm
jwasm -q -I..\include bksfreefocus.asm
jwasm -q -I..\include bksgetcp.asm
jwasm -q -I..\include bkssetcp.asm
jwasm -q -I..\include bksxlate.asm
jwasm -q -I..\include bkssetcustxt.asm
jwasm -q -I..\include bksgethwid.asm

rem Base Keyboard Subsystem
wlib -q -fo bks.lib +bksmain.obj 
wlib -q -fo bks.lib +bkscharin.obj
wlib -q -fo bks.lib +bkspeek.obj
wlib -q -fo bks.lib +bksflushbuffer.obj
wlib -q -fo bks.lib +bksgetstatus.obj
wlib -q -fo bks.lib +bkssetstatus.obj
wlib -q -fo bks.lib +bksstringin.obj
wlib -q -fo bks.lib +bksopen.obj
wlib -q -fo bks.lib +bksclose.obj
wlib -q -fo bks.lib +bksgetfocus.obj
wlib -q -fo bks.lib +bksfreefocus.obj
wlib -q -fo bks.lib +bksgetcp.obj
wlib -q -fo bks.lib +bkssetcp.obj
wlib -q -fo bks.lib +bksxlate.obj
wlib -q -fo bks.lib +bkssetcustxt.obj
wlib -q -fo bks.lib +bksgethwid.obj

echo Base Keyboard Subsystem build finished

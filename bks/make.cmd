@echo off
del bks.lib
del *.obj
del *.lst
del *.err
del *.bak
rem Base Keyboard Subsystem
jwasm -q bksmain.asm
jwasm -q bkscharin.asm
jwasm -q bkspeek.asm
jwasm -q bksflushbuffer.asm
jwasm -q bksgetstatus.asm
jwasm -q bkssetstatus.asm
jwasm -q bksstringin.asm
jwasm -q bksopen.asm
jwasm -q bksclose.asm
jwasm -q bksgetfocus.asm
jwasm -q bksfreefocus.asm
jwasm -q bksgetcp.asm
jwasm -q bkssetcp.asm
jwasm -q bksxlate.asm
jwasm -q bkssetcustxt.asm
jwasm -q bksgethwid.asm

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


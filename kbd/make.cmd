@echo off
del kbd.lib
del *.obj
del *.lst
del *.err
del *.bak
rem Keyboard subsystem
jwasm -q kbdroute.asm
jwasm -q kbdcharin.asm
jwasm -q kbdpeek.asm
jwasm -q kbdflushbuffer.asm
jwasm -q kbdgetstatus.asm
jwasm -q kbdsetstatus.asm
jwasm -q kbdstringin.asm
jwasm -q kbdopen.asm
jwasm -q kbdclose.asm
jwasm -q kbdgetfocus.asm
jwasm -q kbdfreefocus.asm
jwasm -q kbdgetcp.asm
jwasm -q kbdsetcp.asm
jwasm -q kbdxlate.asm
jwasm -q kbdsetcustxt.asm
jwasm -q kbdgethwid.asm

rem Kbd Subsystem
wlib -q -fo kbd.lib +kbdroute.obj +kbdcharin.obj +kbdpeek.obj +kbdflushbuffer.obj +kbdgetstatus.obj +kbdsetstatus.obj
wlib -q -fo kbd.lib +kbdstringin.obj +kbdopen.obj +kbdclose.obj +kbdgetfocus.obj +kbdfreefocus.obj +kbdgetcp.obj
wlib -q -fo kbd.lib +kbdsetcp.obj +kbdxlate.obj +kbdsetcustxt.obj +kbdgethwid.obj

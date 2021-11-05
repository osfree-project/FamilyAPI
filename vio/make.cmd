@echo off
echo Building Video subsystem
if exist vio.lib del vio.lib
if exist *.obj del *.obj
if exist *.lst del *.lst
if exist *.err del *.err
if exist *.bak del *.bak
rem Video subsystem
jwasm -q vioroute.asm
jwasm -q vioscrlock.asm
jwasm -q viosetfont.asm
jwasm -q vioscrunlock.asm
jwasm -q vioreadcellstr.ASM 
jwasm -q vioreadcharstr.ASM 
jwasm -q vioscrolldn.ASM 
jwasm -q vioscrollup.ASM 
jwasm -q vioscrolllf.ASM 
jwasm -q vioscrollrt.ASM 
jwasm -q viosetansi.ASM 
jwasm -Fl -q viogetansi.ASM 
jwasm -q viosetmode.ASM 
jwasm -q viogetmode.ASM 
jwasm -q viogetconfig.ASM 
jwasm -q viogetcurpos.ASM  
jwasm -q viogetcurtype.ASM   
jwasm -q viosetcurpos.ASM  
jwasm -q viosetcurtype.ASM   
jwasm -q viowrtcellstr.ASM  
jwasm -q viowrtcharstr.ASM  
jwasm -q viowrtcharstratt.ASM 
jwasm -q viowrtnattr.ASM
jwasm -q viowrtnchar.asm
jwasm -q viowrtncell.ASM
jwasm -q viowrttty.ASM 
jwasm -q vioderegister.ASM 
jwasm -q vioregister.ASM 
jwasm -q viosetcp.ASM 
jwasm -q viogetcp.ASM 
jwasm -q viogetfont.ASM 
jwasm -q viomodewait.ASM 
jwasm -q viomodeundo.ASM 
jwasm -q viopopup.ASM 
jwasm -q vioendpopup.ASM 
jwasm -q viosavredrawwait.ASM 
jwasm -q viosavredrawundo.ASM 
jwasm -q vioprtsc.ASM 
jwasm -q vioprtsctoggle.ASM 
jwasm -q viosetstate.ASM 
jwasm -q viogetstate.ASM 
jwasm -q viogetbuf.ASM 
jwasm -q viogetphysbuf.ASM 
jwasm -q vioshowbuf.ASM 

rem Vio Subsystem
wlib -q -fo vio.lib +vioroute.obj +vioshowbuf.obj +vioreadcharstr.obj +viosetfont.obj +viosetcurtype.obj +viogetcurtype.obj
wlib -q -fo vio.lib +viosetstate.obj +viogetstate.obj +vioscrolllf.obj +vioscrollrt.obj +viogetbuf.obj +viogetphysbuf.obj
wlib -q -fo vio.lib +viopopup.obj +vioendpopup.obj +viosavredrawwait.obj +viosavredrawundo.obj +vioprtsc.obj +vioprtsctoggle.obj
wlib -q -fo vio.lib +viowrtnattr.obj +viogetcp.obj +viosetcp.obj +viogetfont.obj +viomodewait.obj +viomodeundo.obj +viomodewait.obj
wlib -q -fo vio.lib +viogetcurpos.obj +vioderegister.obj +vioregister.obj +vioscrollup.obj +vioscrolldn.obj +viowrttty.obj
wlib -q -fo vio.lib +viosetansi.obj +viogetansi.obj +viogetmode.obj +vioscrlock.obj +vioscrunlock.obj +viogetconfig.obj 
wlib -q -fo vio.lib +viowrtcharstratt.obj +viowrtcellstr.obj +viowrtcharstr.obj +viosetmode.obj +viosetcurpos.obj +viowrtnchar.obj +viowrtncell.obj

echo Video subsystem build finished

@echo off
del bvs.lib
del *.obj
del *.lst
del *.err
rem Base video subsystem
jwasm -q bvsshared.asm
jwasm -q bvsvars.asm
jwasm -q bvsmain.asm
jwasm -q bvsgetphysbuf.asm
jwasm -q bvsgetbuf.asm
jwasm -q bvsshowbuf.asm
jwasm -q bvsgetcurpos.asm
jwasm -q bvsgetcurtype.asm
jwasm -q bvsgetmode.asm
jwasm -q bvssetcurpos.asm
jwasm -q bvssetcurtype.asm
jwasm -q bvssetmode.asm
jwasm -q bvsreadcharstr.asm
jwasm -q bvsreadcellstr.asm
jwasm -q bvswrtnchar.asm
jwasm -q bvswrtnattr.asm
jwasm -q bvswrtncell.asm
jwasm -q bvswrtcharstr.asm
jwasm -q bvswrtcharstratt.asm
jwasm -q bvswrtcellstr.asm
jwasm -q bvswrttty.asm
jwasm -q bvsscrollup.asm
jwasm -q bvsscrolldn.asm
jwasm -q bvsscrolllf.asm
jwasm -q bvsscrollrt.asm
jwasm -q bvssetansi.asm
jwasm -q bvsgetansi.asm
jwasm -q bvsprtsc.asm
jwasm -q bvsscrlock.asm
jwasm -q bvsscrunlock.asm
jwasm -q bvssavredrawwait.asm
jwasm -q bvssavredrawundo.asm
jwasm -q bvspopup.asm
jwasm -q bvsendpopup.asm
jwasm -q bvsprtsctoggle.asm
jwasm -q bvsmodewait.asm
jwasm -q bvsmodeundo.asm
jwasm -q bvsgetfont.asm
jwasm -q bvsgetconfig.asm
jwasm -q bvssetcp.asm
jwasm -q bvsgetcp.asm
jwasm -q bvssetfont.asm
jwasm -q bvsgetstate.asm
jwasm -q bvssetstate.asm

rem Base Video Subsystem
wlib -q -fo bvs.lib +bvsmain.obj +bvsgetphysbuf.obj +bvsgetbuf.obj +bvsshowbuf.obj +bvsgetcurpos.obj +bvsgetcurtype.obj
wlib -q -fo bvs.lib +bvsgetmode.obj +bvssetcurpos.obj +bvssetcurtype.obj +bvssetmode.obj +bvsreadcharstr.obj +bvsreadcellstr.obj
wlib -q -fo bvs.lib +bvswrtnchar.obj +bvswrtnattr.obj +bvswrtncell.obj +bvswrtcharstr.obj +bvswrtcharstratt.obj +bvswrtcellstr.obj
wlib -q -fo bvs.lib +bvswrttty.obj +bvsscrollup.obj +bvsscrolldn.obj +bvsscrolllf.obj +bvsscrollrt.obj +bvssetansi.obj
wlib -q -fo bvs.lib +bvsgetansi.obj +bvsprtsc.obj +bvsscrlock.obj +bvsscrunlock.obj +bvssavredrawwait.obj +bvssavredrawundo.obj
wlib -q -fo bvs.lib +bvspopup.obj +bvsendpopup.obj +bvsprtsctoggle.obj +bvsmodewait.obj +bvsmodeundo.obj +bvsgetfont.obj
wlib -q -fo bvs.lib +bvsgetconfig.obj +bvssetcp.obj +bvsgetcp.obj +bvssetfont.obj +bvsgetstate.obj +bvssetstate.obj
wlib -q -fo bvs.lib +bvsshared.obj +bvsvars.obj


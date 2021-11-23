ALL: ..\lib\bvs.lib ..\dll\bvscalls.dll ..\lib\bvscalls.lib

OBJS=bvsmain.obj bvsgetphysbuf.obj bvsgetbuf.obj bvsshowbuf.obj bvsgetcurpos.obj bvsgetcurtype.obj &
bvsgetmode.obj bvssetcurpos.obj bvssetcurtype.obj bvssetmode.obj bvsreadcharstr.obj bvsreadcellstr.obj &
bvswrtnchar.obj bvswrtnattr.obj bvswrtncell.obj bvswrtcharstr.obj bvswrtcharstratt.obj bvswrtcellstr.obj &
bvswrttty.obj bvsscrollup.obj bvsscrolldn.obj bvsscrolllf.obj bvsscrollrt.obj bvssetansi.obj &
bvsgetansi.obj bvsprtsc.obj bvsscrlock.obj bvsscrunlock.obj bvssavredrawwait.obj bvssavredrawundo.obj &
bvspopup.obj bvsendpopup.obj bvsprtsctoggle.obj bvsmodewait.obj bvsmodeundo.obj bvsgetfont.obj &
bvsgetconfig.obj bvssetcp.obj bvsgetcp.obj bvssetfont.obj bvsgetstate.obj bvssetstate.obj &
bvsshared.obj bvsvars.obj

..\dll\bvscalls.dll: ..\lib\bvs.lib makefile
	@echo LINK $@
	@wlink.exe @<<
     export BVSMAIN.3 RESIDENT
     system   os2_dll
     option   map
     name     ..\dll\bvscalls
     file     ..\lib\bvs.lib 
     file	..\helpers.obj
<<


..\lib\bvscalls.lib: ..\dll\bvscalls.dll makefile
	@echo LIB $@
	@wlib -q -fo $@ ..\dll\bvscalls.dll

..\lib\bvs.lib: $(OBJS)
	@echo LIB $@
	@wlib -q -fo $@ $(OBJS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -I..\include $*.asm


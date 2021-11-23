ALL: ..\lib\vio.lib ..\dll\viocalls.dll

OBJS=vioroute.obj vioshowbuf.obj vioreadcharstr.obj viosetfont.obj viosetcurtype.obj viogetcurtype.obj &
viosetstate.obj viogetstate.obj vioscrolllf.obj vioscrollrt.obj viogetbuf.obj viogetphysbuf.obj &
viopopup.obj vioendpopup.obj viosavredrawwait.obj viosavredrawundo.obj vioprtsc.obj vioprtsctoggle.obj &
viowrtnattr.obj viogetcp.obj viosetcp.obj viogetfont.obj viomodewait.obj viomodeundo.obj viomodewait.obj &
viogetcurpos.obj vioderegister.obj vioregister.obj vioscrollup.obj vioscrolldn.obj viowrttty.obj &
viosetansi.obj viogetansi.obj viogetmode.obj vioscrlock.obj vioscrunlock.obj viogetconfig.obj &
viowrtcharstratt.obj viowrtcellstr.obj viowrtcharstr.obj viosetmode.obj viosetcurpos.obj viowrtnchar.obj viowrtncell.obj

..\dll\viocalls.dll: ..\lib\vio.lib makefile
	@echo LINK $@
	@wlink.exe @<<
     system   os2_dll
     option   map
     name     ..\dll\viocalls
     file     ..\lib\vio.lib
     file     ..\lib\bvscalls.lib 
     file     ..\helpers.obj
<<


..\lib\vio.lib: $(OBJS) makefile
	@echo LIB $@
	@wlib -q -fo $@ $(OBJS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -I..\include $*.asm


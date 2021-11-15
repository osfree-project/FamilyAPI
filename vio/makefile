ALL: ..\lib\vio.lib

OBJS=vioroute.obj vioshowbuf.obj vioreadcharstr.obj viosetfont.obj viosetcurtype.obj viogetcurtype.obj &
viosetstate.obj viogetstate.obj vioscrolllf.obj vioscrollrt.obj viogetbuf.obj viogetphysbuf.obj &
viopopup.obj vioendpopup.obj viosavredrawwait.obj viosavredrawundo.obj vioprtsc.obj vioprtsctoggle.obj &
viowrtnattr.obj viogetcp.obj viosetcp.obj viogetfont.obj viomodewait.obj viomodeundo.obj viomodewait.obj &
viogetcurpos.obj vioderegister.obj vioregister.obj vioscrollup.obj vioscrolldn.obj viowrttty.obj &
viosetansi.obj viogetansi.obj viogetmode.obj vioscrlock.obj vioscrunlock.obj viogetconfig.obj &
viowrtcharstratt.obj viowrtcellstr.obj viowrtcharstr.obj viosetmode.obj viosetcurpos.obj viowrtnchar.obj viowrtncell.obj

..\lib\vio.lib: $(OBJS)
  wlib -q -fo ..\lib\vio.lib $(OBJS)

.asm.obj:
	@jwasm.exe -q -I..\include $*.asm


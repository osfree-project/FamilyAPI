ALL: ..\lib\bvs.lib

OBJS=bvsmain.obj bvsgetphysbuf.obj bvsgetbuf.obj bvsshowbuf.obj bvsgetcurpos.obj bvsgetcurtype.obj &
bvsgetmode.obj bvssetcurpos.obj bvssetcurtype.obj bvssetmode.obj bvsreadcharstr.obj bvsreadcellstr.obj &
bvswrtnchar.obj bvswrtnattr.obj bvswrtncell.obj bvswrtcharstr.obj bvswrtcharstratt.obj bvswrtcellstr.obj &
bvswrttty.obj bvsscrollup.obj bvsscrolldn.obj bvsscrolllf.obj bvsscrollrt.obj bvssetansi.obj &
bvsgetansi.obj bvsprtsc.obj bvsscrlock.obj bvsscrunlock.obj bvssavredrawwait.obj bvssavredrawundo.obj &
bvspopup.obj bvsendpopup.obj bvsprtsctoggle.obj bvsmodewait.obj bvsmodeundo.obj bvsgetfont.obj &
bvsgetconfig.obj bvssetcp.obj bvsgetcp.obj bvssetfont.obj bvsgetstate.obj bvssetstate.obj &
bvsshared.obj bvsvars.obj


..\lib\bvs.lib: $(OBJS)
  wlib -q -fo ..\lib\bvs.lib $(OBJS)

.asm.obj:
	@jwasm.exe -q -I..\include $*.asm


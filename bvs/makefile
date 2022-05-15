# $Id: makefile,v 1.3 2004/08/21 14:49:03 prokushev Exp $
#
# Makefile for Watcom/LIBC interface layer

PROJ      = bvs
TRGT      = $(PROJ).lib
#32_BITS = 0
ADD_ASMOPT  = -I=$(MYDIR)..$(SEP)include -I=$(MYDIR)..$(SEP)macrolib
srcfiles  = $(p)bvsmain$(e) $(p)bvsgetphysbuf$(e) $(p)bvsgetbuf$(e) $(p)bvsshowbuf$(e) $(p)bvsgetcurpos$(e) $(p)bvsgetcurtype$(e) &
$(p)bvsgetmode$(e) $(p)bvssetcurpos$(e) $(p)bvssetcurtype$(e) $(p)bvssetmode$(e) $(p)bvsreadcharstr$(e) $(p)bvsreadcellstr$(e) &
$(p)bvswrtnchar$(e) $(p)bvswrtnattr$(e) $(p)bvswrtncell$(e) $(p)bvswrtcharstr$(e) $(p)bvswrtcharstratt$(e) $(p)bvswrtcellstr$(e) &
$(p)bvswrttty$(e) $(p)bvsscrollup$(e) $(p)bvsscrolldn$(e) $(p)bvsscrolllf$(e) $(p)bvsscrollrt$(e) $(p)bvssetansi$(e) &
$(p)bvsgetansi$(e) $(p)bvsprtsc$(e) $(p)bvsscrlock$(e) $(p)bvsscrunlock$(e) $(p)bvssavredrawwait$(e) $(p)bvssavredrawundo$(e) &
$(p)bvspopup$(e) $(p)bvsendpopup$(e) $(p)bvsprtsctoggle$(e) $(p)bvsmodewait$(e) $(p)bvsmodeundo$(e) $(p)bvsgetfont$(e) &
$(p)bvsgetconfig$(e) $(p)bvssetcp$(e) $(p)bvsgetcp$(e) $(p)bvssetfont$(e) $(p)bvsgetstate$(e) $(p)bvssetstate$(e) &
$(p)bvsshared$(e) $(p)bvsvars$(e)

JWASM     = 1

TARGETS  = $(PATH)$(TRGT)

!include $(%ROOT)/mk/libsdos.mk

$(TARGETS): $(OBJS)
 @$(MAKE) $(MAKEOPT) library=$(TARGETS) library

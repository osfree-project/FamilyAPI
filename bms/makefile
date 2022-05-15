#
# Makefile for Watcom/LIBC interface layer

PROJ      = bms
TRGT      = $(PROJ).lib
#32_BITS = 0
ADD_ASMOPT  = -I=$(MYDIR)..$(SEP)include;$(MYDIR)..$(SEP)macrolib
srcfiles  = $(p)bmsmain$(e) $(p)bmsgetnumbuttons$(e) $(p)bmsgetnummickeys$(e) $(p)bmsgetdevstatus$(e) $(p)bmsgetnumqueel$(e) &
$(p)bmsreadeventque$(e) $(p)bmsgetscalefact$(e) $(p)bmsgeteventmask$(e) $(p)bmssetscalefact$(e) $(p)bmsseteventmask$(e) &
$(p)bmsgethotkey$(e) $(p)bmssethotkey$(e) $(p)bmsopen$(e) $(p)bmsclose$(e) $(p)bmsgetptrshape$(e) $(p)bmssetptrshape$(e) &
$(p)bmsdrawptr$(e) $(p)bmsremoveptr$(e) $(p)bmsgetptrpos$(e) $(p)bmssetptrpos$(e) $(p)bmsinitreal$(e) $(p)bmsflushque$(e) &
$(p)bmssetdevstatus$(e)

JWASM     = 1

TARGETS  = $(PATH)$(TRGT)

!include $(%ROOT)/mk/libsdos.mk

$(TARGETS): $(OBJS)
 @$(MAKE) $(MAKEOPT) library=$(TARGETS) library

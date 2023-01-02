#
# Makefile for Watcom/LIBC interface layer

PROJ      = vio
TRGT      = $(PROJ).lib
#32_BITS = 0
ADD_ASMOPT  = -I=$(MYDIR)..$(SEP)include -I=$(MYDIR)..$(SEP)macrolib
srcfiles  = $(p)VioRoute$(e) $(p)debug$(e)

JWASM     = 1

TARGETS  = $(PATH)$(TRGT)

!include $(%ROOT)tools/mk/libsdos.mk

$(TARGETS): $(OBJS)
 @$(MAKE) $(MAKEOPT) library=$(TARGETS) library

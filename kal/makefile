#
# Makefile for Watcom/LIBC interface layer
#

PROJ      = kal
TRGT      = $(PROJ).lib
#32_BITS = 0
ADD_ASMOPT  = -I=$(MYDIR)..$(SEP)include -I=$(MYDIR)..$(SEP)macrolib
srcfiles  = $(p)globalshared$(e) $(p)BadDynLink$(e) $(p)GInfoSeg$(e) $(p)LInfoSeg$(e) $(p)GlobalVars$(e) $(p)helpers$(e) $(p)SAS$(e)
JWASM     = 1

TARGETS  = $(PATH)$(TRGT)

!include $(%ROOT)/mk/libsdos.mk

$(TARGETS): $(OBJS)
 @$(MAKE) $(MAKEOPT) library=$(TARGETS) library

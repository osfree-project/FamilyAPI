#
# Makefile for Kernel Abstraction Layer for DOS
#

PROJ      = kal
TRGT      = $(PROJ).lib
ADD_ASMOPT  = -I=$(%OS2TK)$(SEP)inc -I=$(MYDIR)..$(SEP)include -I=$(MYDIR)..$(SEP)macrolib
srcfiles  = $(p)globalshared$(e) $(p)BadDynLink$(e) $(p)GInfoSeg$(e) $(p)LInfoSeg$(e) $(p)GlobalVars$(e) $(p)helpers$(e) $(p)SAS$(e)
JWASM     = 1


TARGETS  = $(PATH)$(TRGT)

!include $(%ROOT)tools/mk/libsdos.mk

$(TARGETS): $(OBJS)
 @$(MAKE) $(MAKEOPT) library=$(TARGETS) library

#
# Makefile for Base Mouse Subsystem

PROJ      = bms
TRGT      = $(PROJ).lib
#32_BITS = 0
ADD_ASMOPT  = -I=$(MYDIR)..$(SEP)include -I=$(MYDIR)..$(SEP)macrolib
srcfiles  = &
	$(p)BmsMain$(e)

JWASM     = 1

TARGETS  = $(PATH)$(TRGT)

!include $(%ROOT)/mk/libsdos.mk

$(TARGETS): $(OBJS)
 @$(MAKE) $(MAKEOPT) library=$(TARGETS) library

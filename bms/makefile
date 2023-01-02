#
# Makefile for Base Mouse Subsystem

PROJ      = bms
TRGT      = $(PROJ).lib
ADD_ASMOPT  = -I=$(%OS2TK)$(SEP)inc -I=$(MYDIR)..$(SEP)..$(SEP)macrolib
srcfiles  = $(p)BmsMain$(e)

JWASM     = 1

TARGETS  = $(PATH)$(TRGT)

!include $(%ROOT)tools/mk/libsdos.mk

.asm: $(ROOT)shared$(SEP)bms

$(TARGETS): $(OBJS)
 @$(MAKE) $(MAKEOPT) library=$(TARGETS) library

#
# Makefile for Base Keyboard Subsystem

PROJ      = bks
TRGT      = $(PROJ).lib
#32_BITS = 0
ADD_ASMOPT  = -I=$(%OS2TK)$(SEP)inc -I=$(MYDIR)..$(SEP)..$(SEP)macrolib
srcfiles  = $(p)BksMain$(e)

JWASM     = 1

TARGETS  = $(PATH)$(TRGT)

!include $(%ROOT)/mk/libsdos.mk

.asm: $(ROOT)shared$(SEP)bks

$(TARGETS): $(OBJS)
 @$(MAKE) $(MAKEOPT) library=$(TARGETS) library

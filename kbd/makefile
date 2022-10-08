#
# Makefile for Keyboard router

PROJ      = kbd
TRGT      = $(PROJ).lib
#32_BITS = 0
ADD_ASMOPT  = -I=$(%OS2TK)$(SEP)inc -I=$(MYDIR)..$(SEP)include -I=$(MYDIR)..$(SEP)..$(SEP)macrolib
srcfiles  = $(p)KbdRoute$(e) $(p)kbddebug$(e)

JWASM     = 1

TARGETS  = $(PATH)$(TRGT)

!include $(%ROOT)/mk/libsdos.mk

.asm: $(ROOT)shared$(SEP)kbd

$(TARGETS): $(OBJS)
 @$(MAKE) $(MAKEOPT) library=$(TARGETS) library

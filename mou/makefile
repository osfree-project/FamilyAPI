#
# Makefile for Mouse Router

PROJ      = mou
TRGT      = $(PROJ).lib
#32_BITS = 0
ADD_ASMOPT  = -I=$(%OS2TK)$(SEP)inc -I=$(MYDIR)..$(SEP)..$(SEP)include -I=$(MYDIR)..$(SEP)macrolib
srcfiles  = $(p)MouRoute$(e) $(p)moudebug$(e)

JWASM     = 1

TARGETS  = $(PATH)$(TRGT)

!include $(%ROOT)/mk/libsdos.mk

.asm: $(ROOT)shared$(SEP)mou

$(TARGETS): $(OBJS)
 @$(MAKE) $(MAKEOPT) library=$(TARGETS) library

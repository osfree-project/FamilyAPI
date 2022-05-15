#
# Makefile for Watcom/LIBC interface layer

PROJ      = nls
TRGT      = $(PROJ).lib
#32_BITS = 0
ADD_ASMOPT  = -I=$(MYDIR)..$(SEP)include -I=$(MYDIR)..$(SEP)macrolib
srcfiles  = $(p)dosgetmessage$(e) $(p)doscasemap$(e) $(p)dossetctrycode$(e) $(p)dosgetcp$(e) $(p)dossetcp$(e) $(p)dosputmessage$(e) &
$(p)dosputmessage$(e) $(p)dosinsmessage$(e) $(p)dosgetctryinfo$(e) $(p)dosgetdbcsev$(e) $(p)dossetproccp$(e) $(p)dosgetcollate$(e)

JWASM     = 1

TARGETS  = $(PATH)$(TRGT)

!include $(%ROOT)/mk/libsdos.mk

$(TARGETS): $(OBJS)
 @$(MAKE) $(MAKEOPT) library=$(TARGETS) library

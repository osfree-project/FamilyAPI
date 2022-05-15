#
# Makefile for Watcom/LIBC interface layer

PROJ      = bks
TRGT      = $(PROJ).lib
#32_BITS = 0
ADD_ASMOPT  = -I=$(MYDIR)..$(SEP)include -I=$(MYDIR)..$(SEP)macrolib
srcfiles  = $(p)BksMain$(e) $(p)BksCharIn$(e) $(p)BksPeek$(e) $(p)BksFlushBuffer$(e) $(p)BksGetStatus$(e) $(p)BksSetStatus$(e) &
$(p)BksStringIn$(e) $(p)BksOpen$(e) $(p)BksClose$(e) $(p)BksGetFocus$(e) $(p)BksFreeFocus$(e) $(p)BksGetCp$(e) &
$(p)BksSetCp$(e) $(p)BksXlate$(e) $(p)BksSetCustXt$(e) $(p)BksGetHWId$(e)

JWASM     = 1

TARGETS  = $(PATH)$(TRGT)

!include $(%ROOT)/mk/libsdos.mk

$(TARGETS): $(OBJS)
 @$(MAKE) $(MAKEOPT) library=$(TARGETS) library

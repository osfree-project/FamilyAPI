#
# Makefile for Watcom/LIBC interface layer

PROJ      = bms
TRGT      = $(PROJ).lib
#32_BITS = 0
ADD_ASMOPT  = -I=$(MYDIR)..$(SEP)include -I=$(MYDIR)..$(SEP)macrolib
srcfiles  = &
	$(p)BmsMain$(e) &
	$(p)BmsGetNumButtons$(e) &
	$(p)BmsGetNumMickeys$(e) &
	$(p)BmsGetDevStatus$(e) &
	$(p)BmsGetNumQueEl$(e) &
	$(p)BmsReadEventQue$(e) &
	$(p)BmsGetScaleFact$(e) &
	$(p)BmsGetEventMask$(e) &
	$(p)BmsSetScaleFact$(e) &
	$(p)BmsSetEventMask$(e) &
	$(p)BmsGetHotKey$(e) &
	$(p)BmsSetHotKey$(e) &
	$(p)BmsOpen$(e) &
	$(p)BmsClose$(e) &
	$(p)BmsGetPtrShape$(e) &
	$(p)BmsSetPtrShape$(e) &
	$(p)BmsDrawPtr$(e) &
	$(p)BmsRemovePtr$(e) &
	$(p)BmsGetPtrPos$(e) &
	$(p)BmsSetPtrPos$(e) &
	$(p)BmsInitReal$(e) &
	$(p)BmsFlushQue$(e) &
	$(p)BmsSetDevStatus$(e)

JWASM     = 1

TARGETS  = $(PATH)$(TRGT)

!include $(%ROOT)/mk/libsdos.mk

$(TARGETS): $(OBJS)
 @$(MAKE) $(MAKEOPT) library=$(TARGETS) library

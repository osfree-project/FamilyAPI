# $Id: makefile,v 1.3 2004/08/21 14:49:03 prokushev Exp $
#
# Makefile for Watcom/LIBC interface layer

PROJ      = bvs
TRGT      = $(PROJ).lib
#32_BITS = 0
ADD_ASMOPT  = -I=$(%OS2TK)$(SEP)inc -I=$(MYDIR)..$(SEP)include -I=$(MYDIR)..$(SEP)..$(SEP)macrolib
srcfiles  = $(p)BvsMain$(e) $(p)BvsGetPhysBuf$(e) $(p)BvsGetBuf$(e) $(p)BvsShowBuf$(e) $(p)BvsGetCurPos$(e) $(p)BvsGetCurType$(e) &
$(p)BvsGetMode$(e) $(p)BvsSetCurPos$(e) $(p)BvsSetCurType$(e) $(p)BvsSetMode$(e) $(p)BvsReadCharStr$(e) $(p)BvsReadCellStr$(e) &
$(p)BvsWrtNChar$(e) $(p)BvsWrtNAttr$(e) $(p)BvsWrtNCell$(e) $(p)BvsWrtCharStr$(e) $(p)BvsWrtCharStrAtt$(e) $(p)BvsWrtCellStr$(e) &
$(p)BvsWrtTTY$(e) $(p)BvsScrollUp$(e) $(p)BvsScrollDn$(e) $(p)BvsScrollLf$(e) $(p)BvsScrollRt$(e) $(p)BvsSetAnsi$(e) &
$(p)BvsGetAnsi$(e) $(p)BvsPrtSc$(e) $(p)BvsScrLock$(e) $(p)BvsScrUnLock$(e) $(p)BvsSavRedrawWait$(e) $(p)BvsSavRedrawUndo$(e) &
$(p)BvsPopUp$(e) $(p)BvsEndPopUp$(e) $(p)BvsPrtScToggle$(e) $(p)BvsModeWait$(e) $(p)BvsModeUndo$(e) $(p)BvsGetFont$(e) &
$(p)BvsGetConfig$(e) $(p)BvsSetCP$(e) $(p)BvsGetCP$(e) $(p)BvsSetFont$(e) $(p)BvsGetState$(e) $(p)BvsSetState$(e) &
$(p)BvsShared$(e) $(p)BvsVars$(e)

JWASM     = 1

TARGETS  = $(PATH)$(TRGT)

!include $(%ROOT)/mk/libsdos.mk

$(TARGETS): $(OBJS)
 @$(MAKE) $(MAKEOPT) library=$(TARGETS) library

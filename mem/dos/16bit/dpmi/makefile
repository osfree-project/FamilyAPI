# $Id: makefile,v 1.3 2004/08/21 14:49:03 prokushev Exp $
#
# Makefile for Watcom/LIBC interface layer

PROJ      = mem16p
TRGT      = $(PROJ).lib
#32_BITS = 0
ADD_ASMOPT  = -I=$(MYDIR)..$(SEP)..$(SEP)..$(SEP)..$(SEP)macrolib -I=$(MYDIR)..$(SEP)..$(SEP)..$(SEP)..$(SEP)include
srcfiles  = $(p)Dos16PAllocHuge$(e) $(p)Dos16PAllocSeg$(e) $(p)Dos16PAllocShrSeg$(e) $(p)Dos16PCreateCSAlias$(e) $(p)Dos16PFreeSeg$(e) &
$(p)Dos16PGetHugeShift$(e) $(p)Dos16PGetShrSeg$(e) $(p)Dos16PMemAvail$(e) $(p)Dos16PReallocSeg$(e) $(p)Dos16PSizeSeg$(e) &
$(p)Dos16PReallocHuge$(e)

JWASM     = 1

TARGETS  = $(PATH)$(TRGT)

!include $(%ROOT)/mk/libsdos.mk

$(TARGETS): $(OBJS)
 @$(MAKE) $(MAKEOPT) library=$(TARGETS) library

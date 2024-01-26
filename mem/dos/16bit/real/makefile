# $Id: makefile,v 1.3 2004/08/21 14:49:03 prokushev Exp $
#
# Makefile for Watcom/LIBC interface layer

PROJ      = mem16r
TRGT      = $(PROJ).lib
#32_BITS = 0
ADD_ASMOPT  = -I=$(%OS2TK)$(SEP)inc -I=$(MYDIR)..$(SEP)..$(SEP)..$(SEP)..$(SEP)macrolib -I=$(MYDIR)..$(SEP)..$(SEP)..$(SEP)..$(SEP)include
srcfiles  = $(p)Dos16RAllocHuge$(e) $(p)Dos16RAllocSeg$(e) $(p)Dos16RAllocShrSeg$(e) $(p)Dos16RCreateCSAlias$(e) $(p)Dos16RFreeSeg$(e) &
$(p)Dos16RGetHugeShift$(e) $(p)Dos16RGetShrSeg$(e) $(p)Dos16RMemAvail$(e) $(p)Dos16RReallocSeg$(e) $(p)Dos16RSizeSeg$(e) &
$(p)Dos16RReallocHuge$(e)

JWASM     = 1

TARGETS  = $(PATH)$(TRGT)

!include $(%ROOT)tools/mk/libsdos.mk

$(TARGETS): $(OBJS)
 @$(MAKE) $(MAKEOPT) library=$(TARGETS) library

#
# A main Makefile for OS/3 boot sequence project
# (c) osFree project,
# valerius, 2006/10/30
#

# First directory must be SHARED which provides shared libs

DIRS = dpmi real

#!include $(%ROOT)/mk/all.mk

PROJ      = mem16
TRGT      = $(PROJ).lib
#32_BITS = 0
ADD_ASMOPT  = -I=$(MYDIR)..$(SEP)..$(SEP)..$(SEP)macrolib;$(MYDIR)..$(SEP)..$(SEP)..$(SEP)include
srcfiles  = $(p)DosAllocHuge$(e) $(p)DosAllocSeg$(e) $(p)DosAllocShrSeg$(e) $(p)DosCreateCSAlias$(e) $(p)DosFreeSeg$(e) &
$(p)DosGetHugeShift$(e) $(p)DosGetShrSeg$(e) $(p)DosMemAvail$(e) $(p)DosReallocSeg$(e) $(p)DosSubAlloc$(e) $(p)DosSubFree$(e) &
$(p)DosSubSet$(e) $(p)DosReallocHuge$(e) $(p)DosSizeSeg$(e)

JWASM     = 1

TARGETS  = $(PATH)$(TRGT)

!include $(%ROOT)/mk/libsdos.mk

$(TARGETS): $(OBJS)
 @$(MAKE) $(MAKEOPT) library=$(TARGETS) library

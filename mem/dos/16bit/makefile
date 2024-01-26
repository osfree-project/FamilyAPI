#
# A main Makefile for OS/3 boot sequence project
# (c) osFree project,
# valerius, 2006/10/30
#

# First directory must be SHARED which provides shared libs

DIRS = dpmi real

PROJ      = mem16
TRGT      = $(PROJ).lib
ADD_ASMOPT  = -I=$(%OS2TK)$(SEP)inc -I=$(MYDIR)..$(SEP)..$(SEP)..$(SEP)macrolib -I=$(MYDIR)..$(SEP)..$(SEP)..$(SEP)include
srcfiles  = $(p)DosAllocHuge$(e) $(p)DosAllocSeg$(e) $(p)DosAllocShrSeg$(e) $(p)DosCreateCSAlias$(e) $(p)DosFreeSeg$(e) &
$(p)DosGetHugeShift$(e) $(p)DosGetShrSeg$(e) $(p)DosMemAvail$(e) $(p)DosReallocSeg$(e) $(p)DosSubAlloc$(e) $(p)DosSubFree$(e) &
$(p)DosSubSet$(e) $(p)DosReallocHuge$(e) $(p)DosSizeSeg$(e)
LIBS = $(%ROOT)build$(SEP)lib$(SEP)mem16p.lib $(%ROOT)build$(SEP)lib$(SEP)mem16r.lib
JWASM     = 1

TARGETS  = $(PATH)$(TRGT)

!include $(%ROOT)tools/mk/libsdos.mk

$(TARGETS): $(OBJS) $(LIBS)
 @$(MAKE) $(MAKEOPT) library=$(TARGETS) library




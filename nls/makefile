#
# Makefile for Watcom/LIBC interface layer

PROJ      = nls
TRGT      = $(PROJ).lib
#32_BITS = 0
ADD_ASMOPT  = -I=$(%OS2TK)$(SEP)inc -I=$(MYDIR)..$(SEP)include -I=$(MYDIR)..$(SEP)..$(SEP)macrolib
srcfiles  = $(p)DosGetMessage$(e) $(p)DosCaseMap$(e) $(p)DosSetCtryCode$(e) $(p)DosGetCp$(e) $(p)DosSetCp$(e) $(p)DosPutMessage$(e) &
$(p)DosInsMessage$(e) $(p)DosGetCtryInfo$(e) $(p)DosGetDBCSEv$(e) $(p)DosSetProcCp$(e) $(p)DosGetCollate$(e)

JWASM     = 1

TARGETS  = $(PATH)$(TRGT)

!include $(%ROOT)tools/mk/libsdos.mk

$(TARGETS): $(OBJS)
 @$(MAKE) $(MAKEOPT) library=$(TARGETS) library

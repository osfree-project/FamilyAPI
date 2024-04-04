#
# A main Makefile for 
# (c) osFree project,
#

DIRS = dos

PROJ      = mem
TRGT      = $(PROJ).lib
ADD_ASMOPT  = -I=$(MYDIR)..$(SEP)..$(SEP)..$(SEP)..$(SEP)macrolib -I=$(MYDIR)..$(SEP)..$(SEP)..$(SEP)include
LIBS = $(%ROOT)build$(SEP)lib$(SEP)mem16.lib 
JWASM     = 1

TARGETS  = $(PATH)$(TRGT)

!include $(%ROOT)tools/mk/libsdos.mk

$(TARGETS): $(OBJS) $(LIBS)
 @$(MAKE) $(MAKEOPT) library=$(TARGETS) library




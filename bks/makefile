#
# Makefile for Watcom/LIBC interface layer

PROJ      = bks
TRGT      = $(PROJ).lib
#32_BITS = 0
ADD_ASMOPT  = -I=$(MYDIR)..$(SEP)include;$(MYDIR)..$(SEP)macrolib
srcfiles  = $(p)bksmain$(e) $(p)bkscharin$(e) $(p)bkspeek$(e) $(p)bksflushbuffer$(e) $(p)bksgetstatus$(e) $(p)bkssetstatus$(e) &
$(p)bksstringin$(e) $(p)bksopen$(e) $(p)bksclose$(e) $(p)bksgetfocus$(e) $(p)bksfreefocus$(e) $(p)bksgetcp$(e) &
$(p)bkssetcp$(e) $(p)bksxlate$(e) $(p)bkssetcustxt$(e) $(p)bksgethwid$(e)

JWASM     = 1

TARGETS  = $(PATH)$(TRGT)

!include $(%ROOT)/mk/libsdos.mk

$(TARGETS): $(OBJS)
 @$(MAKE) $(MAKEOPT) library=$(TARGETS) library

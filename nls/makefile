#
# Makefile for Watcom/LIBC interface layer

PROJ      = nls
TRGT      = $(PROJ).lib
ADD_ASMOPT  = -I=$(PATH) -I=$(%OS2TK)$(SEP)inc -I=$(MYDIR)..$(SEP)include -I=$(MYDIR)..$(SEP)macrolib
srcfiles  = $(p)DosGetMessage$(e) $(p)DosCaseMap$(e) $(p)DosSetCtryCode$(e) $(p)DosGetCp$(e) $(p)DosSetCp$(e) $(p)DosPutMessage$(e) &
			$(p)DosInsMessage$(e) $(p)DosGetCtryInfo$(e) $(p)DosGetDBCSEv$(e) $(p)DosSetProcCp$(e) $(p)DosGetCollate$(e) &
			$(p)$(PROJ)msg$(e)

JWASM     = 1

TARGETS  = $(PATH)$(TRGT)

!include $(%ROOT)tools/mk/libsdos.mk

$(TARGETS): $(OBJS)
 @$(MAKE) $(MAKEOPT) library=$(TARGETS) library

$(PATH)$(PROJ)msg.obj: $(PROJ)msg.asm $(PATH)msg.inc

$(PATH)msg.inc: $(PATH)$(PROJ).txt
  $(verbose)$(SAY) MKMSGF   $^.
  $(verbose)$(MC) -Q -A -I$(MYDIR)$(PS)$(%OS2TK)$(SEP)inc $[@ $^@

$(PATH)$(PROJ).txt: $(PATH)$(PROJ).ext
  $(verbose)$(SAY) MSGEXTRT $^.
  $(verbose)$(ME) $< $^@

#$(PATH)$(PROJ).ext: $(PROJ)msg.asm
#  msgprof $(PROJ).asm > $(PROJ).ext

$(PATH)$(PROJ).ext: .symbolic
 @%create $^@
 @%append $^@ >$(PROJ).asm
 @%append $^@ <$(%ROOT)build$(SEP)bin$(SEP)os2$(SEP)system$(SEP)oso001.msg
 @%append $^@ DOS0317
 @%append $^@ DOS0318
 @%append $^@ DOS0319
 @%append $^@ DOS0320
 @%append $^@ DOS0321

#
# Makefile for Watcom/LIBC interface layer

PROJ      = fm
TRGT      = $(PROJ).lib
#32_BITS = 0
ADD_ASMOPT  = -I=$(%OS2TK)$(SEP)inc -I=$(MYDIR)..$(SEP)include -I=$(MYDIR)..$(SEP)macrolib
srcfiles  = $(p)DosBufReset$(e) $(p)DosChDir$(e) $(p)DosMkDir$(e) $(p)DosClose$(e) $(p)DosDupHandle$(e) $(p)dosfirst$(e) &
$(p)DosFileLocks$(e) $(p)DosMove$(e) $(p)DosNewSize$(e) $(p)DosOpen$(e) $(p)DosQCurDir$(e) $(p)DosQCurDisk$(e) &
$(p)DosQFileInfo$(e) $(p)DosQFsInfo$(e) $(p)DosRmDir$(e) $(p)DosQVerify$(e) $(p)DosQFileMode$(e) $(p)DosQHandType$(e) &
$(p)DosRead$(e) $(p)DosChgFilePtr$(e) $(p)DosSetFileInfo$(e) $(p)DosSetFileMode$(e) $(p)DosSelectDisk$(e) &
$(p)DosSetVerify$(e) $(p)DosWrite$(e) $(p)DosDelete$(e) $(p)DosSetMaxFH$(e) $(p)DosSetFHandState$(e) &
$(p)DosSetFsInfo$(e) $(p)DosWriteAsync$(e) $(p)DosQFHandState$(e) $(p)DosReadAsync$(e) $(p)DosEnumAttribute$(e) &
$(p)DosEditName$(e) $(p)DosMkDir2$(e) $(p)DosOpen2$(e) $(p)DosSetPathInfo$(e) $(p)DosQPathInfo$(e)
JWASM     = 1

TARGETS  = $(PATH)$(TRGT)

!include $(%ROOT)tools/mk/libsdos.mk

$(TARGETS): $(OBJS)
 @$(MAKE) $(MAKEOPT) library=$(TARGETS) library

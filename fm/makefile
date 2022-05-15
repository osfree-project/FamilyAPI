#
# Makefile for Watcom/LIBC interface layer

PROJ      = fm
TRGT      = $(PROJ).lib
#32_BITS = 0
ADD_ASMOPT  = -I=$(MYDIR)..$(SEP)include;$(MYDIR)..$(SEP)macrolib
srcfiles  = $(p)dosbufreset$(e) $(p)doschdir$(e) $(p)dosmkdir$(e) $(p)dosclose$(e) $(p)dosduphandle$(e) $(p)dosfirst$(e) &
$(p)dosfilelocks$(e) $(p)dosmove$(e) $(p)dosnewsize$(e) $(p)dosopen$(e) $(p)dosqcurdir$(e) $(p)dosqcurdisk$(e) &
$(p)dosqfileinfo$(e) $(p)dosqfsinfo$(e) $(p)dosrmdir$(e) $(p)dosqverify$(e) $(p)dosqfilemode$(e) $(p)dosqhandtype$(e) &
$(p)dosread$(e) $(p)doschgfileptr$(e) $(p)dossetfileinfo$(e) $(p)dossetfilemode$(e) $(p)dosselectdisk$(e) &
$(p)dossetverify$(e) $(p)doswrite$(e) $(p)dosdelete$(e) $(p)dossetmaxfh$(e) $(p)dossetfhandstate$(e) &
$(p)dossetfsinfo$(e) $(p)doswriteasync$(e) $(p)dosqfhandstate$(e) $(p)dosreadasync$(e) $(p)dosenumattribute$(e) &
$(p)doseditname$(e) $(p)dosmkdir2$(e) $(p)dosopen2$(e) $(p)dossetpathinfo$(e) $(p)dosqpathinfo$(e)
JWASM     = 1

TARGETS  = $(PATH)$(TRGT)

!include $(%ROOT)/mk/libsdos.mk

$(TARGETS): $(OBJS)
 @$(MAKE) $(MAKEOPT) library=$(TARGETS) library

#
# (c) osFree project,
#


TRGT = $(PROJ).lib
LIBS = $(LIBSDIR)kal.lib $(LIBSDIR)bvs.lib $(LIBSDIR)bms.lib &
       $(LIBSDIR)bks.lib $(LIBSDIR)vio.lib $(LIBSDIR)mou.lib &
       $(LIBSDIR)kbd.lib $(LIBSDIR)fm.lib  $(LIBSDIR)nls.lib &
       $(LIBSDIR)ioctl.lib $(LIBSDIR)dos.lib $(LIBSDIR)mem.lib &
	   $(LIBSDIR)mm.lib $(EXTRALIB)
DEST = os2tk45$(SEP)lib$(SEP)
# additions to install target
INSTALL_ADD = 1

!ifeq %OS WIN64
hostos=win32
!else
hostos=$(%HOST)
!endif

!include $(%ROOT)tools/mk/libsdos.mk

HOSTDIR = $(ROOT)build$(SEP)bin$(SEP)host$(SEP)$(hostos)$(SEP)os2tk45$(SEP)lib$(SEP)

$(PATH)$(PROJ).lib: $(LIBS)
 @$(MAKE) $(MAKEOPT) library=$(PATH)$(PROJ).lib library

install_add: $(ROOT)build$(SEP)bin$(SEP)host$(SEP)$(hostos)$(SEP)os2tk45$(SEP)lib$(SEP)$(PROJ).lib

$(HOSTDIR)$(PROJ).lib: $(PATH)$(PROJ).lib
 $(verbose)$(MDHIER) $(HOSTDIR)
 @$(SAY) INST     $^. $(LOG)
 $(verbose)$(CP) $< $^@ $(BLACKHOLE)
	
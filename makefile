#
# (c) osFree project,
#


PROJ = fapi
TRGT = $(PROJ).lib
DIRS = kal mem bvs bms bks vio mou kbd fm nls ioctl dos
LIBS = $(%ROOT)build$(SEP)lib$(SEP)kal.lib $(%ROOT)build$(SEP)lib$(SEP)bvs.lib $(%ROOT)build$(SEP)lib$(SEP)bms.lib &
       $(%ROOT)build$(SEP)lib$(SEP)bks.lib $(%ROOT)build$(SEP)lib$(SEP)vio.lib $(%ROOT)build$(SEP)lib$(SEP)mou.lib &
       $(%ROOT)build$(SEP)lib$(SEP)kbd.lib $(%ROOT)build$(SEP)lib$(SEP)fm.lib $(%ROOT)build$(SEP)lib$(SEP)nls.lib &
       $(%ROOT)build$(SEP)lib$(SEP)ioctl.lib $(%ROOT)build$(SEP)lib$(SEP)dos.lib $(%ROOT)build$(SEP)lib$(SEP)mem.lib
DEST = os2tk45$(SEP)lib$(SEP)
# additions to install target
INSTALL_ADD = 1

!ifeq %OS WIN64
hostos=win32
!else
hostos=$(%OS)
!endif

!include $(%ROOT)tools/mk/libsdos.mk

$(PATH)$(PROJ).lib: $(LIBS)
 @$(MAKE) $(MAKEOPT) library=$(PATH)$(PROJ).lib library

install_add: $(ROOT)build$(SEP)bin$(SEP)host$(SEP)$(hostos)$(SEP)os2tk45$(SEP)lib$(SEP)$(PROJ).lib

$(ROOT)build$(SEP)bin$(SEP)host$(SEP)$(hostos)$(SEP)os2tk45$(SEP)lib$(SEP)$(PROJ).lib: $(PATH)$(PROJ).lib
 @$(SAY) INST     $^. $(LOG)
 $(verbose)$(CP) $< $^@ $(BLACKHOLE)

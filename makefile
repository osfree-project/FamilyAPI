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

!include $(%ROOT)tools/mk/libsdos.mk

$(PATH)$(PROJ).lib: $(LIBS)
 @$(MAKE) $(MAKEOPT) library=$(PATH)$(PROJ).lib library

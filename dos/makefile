#
# Makefile for Watcom/LIBC interface layer

PROJ      = dos
TRGT      = $(PROJ).lib
#32_BITS = 0
ADD_ASMOPT  = -I=$(MYDIR)..$(SEP)include;$(MYDIR)..$(SEP)macrolib
srcfiles  = $(p)dosbeep$(e) $(p)dosqsysinfo$(e) $(p)dosdevconfig$(e) $(p)dosgetdatetime$(e) $(p)doserror$(e) &
$(p)dosexecpgm$(e) $(p)dosexit$(e) $(p)dosexitlist$(e) $(p)dosgetenv$(e) $(p)dosgetpid$(e) $(p)dosportaccess$(e) &
$(p)doscliaccess$(e) $(p)dosgetmachinemode$(e) $(p)dosgetversion$(e) $(p)dossleep$(e) $(p)dossetdatetime$(e) &
$(p)dossetvec$(e) $(p)dosgetinfoseg$(e) $(p)dosholdsignal$(e) $(p)dossystrace$(e) $(p)dosgetstda$(e) &
$(p)dosclosequeue$(e) $(p)dosclosesem$(e) $(p)doscreatesem$(e) $(p)doscreatequeue$(e) $(p)doscreatethread$(e) &
$(p)doscwait$(e) $(p)dosentercritsec$(e) $(p)dosexitcritsec$(e) $(p)dosflagprocess$(e) $(p)dosgetprty$(e) &
$(p)doskillprocess$(e) $(p)dosmakepipe$(e) $(p)dosmonclose$(e) $(p)dosmonopen$(e) $(p)dosmonread$(e) &
$(p)dosmonreg$(e) $(p)dosmonwrite$(e) $(p)dosmuxsemwait$(e) $(p)dosopenqueue$(e) $(p)dosopensem$(e) &
$(p)dospeekqueue$(e) $(p)dospfsactivate$(e) $(p)dospfscloseuser$(e) $(p)dospfsinit$(e) $(p)dospfsqueryact$(e) &
$(p)dospfsverifyfont$(e) $(p)dosphysicaldisk$(e) $(p)dosptrace$(e) $(p)dospurgequeue$(e) $(p)dosqueryqueue$(e) &
$(p)dosreadqueue$(e) $(p)dosresumethread$(e) $(p)dosscanenv$(e) $(p)dossearchpath$(e) $(p)dosselectsession$(e) &
$(p)dossemclear$(e) $(p)dossemrequest$(e) $(p)dossemset$(e) $(p)dossemsetwait$(e) $(p)dossemwait$(e) &
$(p)dossendsignal$(e) $(p)dossetprty$(e) $(p)dossetsession$(e) $(p)dosstartsession$(e) $(p)dosstopsession$(e) &
$(p)dossuspendthread$(e) $(p)dostimerasync$(e) $(p)dostimerstart$(e) $(p)dostimerstop$(e) $(p)doswritequeue$(e) &
$(p)doserrclass$(e) $(p)debug$(e)

JWASM     = 1

TARGETS  = $(PATH)$(TRGT)

!include $(%ROOT)/mk/libsdos.mk

$(TARGETS): $(OBJS)
 @$(MAKE) $(MAKEOPT) library=$(TARGETS) library

#
# Makefile for Watcom/LIBC interface layer

PROJ      = dos
TRGT      = $(PROJ).lib

32_BITS = 0

ADD_ASMOPT  = -I=$(%OS2TK)$(SEP)inc -I=$(MYDIR)..$(SEP)include -I=$(MYDIR)..$(SEP)macrolib
ADD_COPT  = -0 -ms -i=$(%WATCOM)$(SEP)h -i=$(%WATCOM)$(SEP)h$(SEP)os21x

srcfiles  = $(p)DosBeep$(e) $(p)DosQSysInfo$(e) $(p)DosDevConfig$(e) $(p)DosGetDateTime$(e) $(p)DosError$(e) &
$(p)DosExecPgm$(e) $(p)DosExit$(e) $(p)DosExitList$(e) $(p)DosGetEnv$(e) $(p)DosGetPID$(e) $(p)DosPortAccess$(e) &
$(p)DosCLIAccess$(e) $(p)DosGetMachineMode$(e) $(p)DosGetVersion$(e) $(p)DosSleep$(e) $(p)DosSetDateTime$(e) &
$(p)DosSetVec$(e) $(p)DosGetInfoSeg$(e) $(p)DosHoldSignal$(e) $(p)DosSysTrace$(e) $(p)DosGetSTDA$(e) &
$(p)DosCloseQueue$(e) $(p)DosCloseSem$(e) $(p)DosCreateSem$(e) $(p)DosCreateQueue$(e) $(p)DosCreateThread$(e) &
$(p)DosCWait$(e) $(p)DosEnterCritSec$(e) $(p)DosExitCritSec$(e) $(p)DosFlagProcess$(e) $(p)DosGetPrty$(e) &
$(p)DosKillProcess$(e) $(p)DosMakePipe$(e) $(p)DosMonClose$(e) $(p)DosMonOpen$(e) $(p)DosMonRead$(e) &
$(p)DosMonReg$(e) $(p)DosMonWrite$(e) $(p)DosMuxSemWait$(e) $(p)DosOpenQueue$(e) $(p)DosOpenSem$(e) &
$(p)DosPeekQueue$(e) $(p)DosPFSActivate$(e) $(p)DosPFSCloseUser$(e) $(p)DosPFSInit$(e) $(p)DosPFSQueryAct$(e) &
$(p)DosPFSVerifyFont$(e) $(p)DosPhysicalDisk$(e) $(p)DosPTrace$(e) $(p)DosPurgeQueue$(e) $(p)DosQueryQueue$(e) &
$(p)DosReadQueue$(e) $(p)DosResumeThread$(e) $(p)DosScanEnv$(e) $(p)DosSearchPath$(e) $(p)DosSelectSession$(e) &
$(p)DosSemClear$(e) $(p)DosSemRequest$(e) $(p)DosSemSet$(e) $(p)DosSemSetWait$(e) $(p)DosSemWait$(e) &
$(p)DosSendSignal$(e) $(p)DosSetPrty$(e) $(p)DosSetSession$(e) $(p)DosStartSession$(e) $(p)DosStopSession$(e) &
$(p)DosSuspendThread$(e) $(p)DosTimerAsync$(e) $(p)DosTimerStart$(e) $(p)DosTimerStop$(e) $(p)DosWriteQueue$(e) &
$(p)DosErrClass$(e) $(p)debug$(e) # $(p)DosCopy$(e)

JWASM     = 1

TARGETS  = $(PATH)$(TRGT)

!include $(%ROOT)/mk/libsdos.mk

$(TARGETS): $(OBJS)
 @$(MAKE) $(MAKEOPT) library=$(TARGETS) library

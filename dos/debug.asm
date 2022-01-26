.8086

		include helpers.inc

EXTERN	VioWrtTTY: Far

_DATA		SEGMENT BYTE PUBLIC 'DATA' USE16

@tracemsg	macro	event
@CATSTR(event, Msg)			DB	@CATSTR( <!'>, event, <!'>), 0dh, 0ah
eventmsg=$-@CATSTR(event, Msg)
@CATSTR(event, MsgSize)		EQU	eventmsg
			endm

@tracemsg2	macro	event
@tracemsg	@CATSTR(Pre, event)
@tracemsg	@CATSTR(Post, event)
			endm

@tracemsg2	DosBeep
@tracemsg2	DosCLIAccess
@tracemsg2	DosCloseQueue
@tracemsg2	DosCloseSem
@tracemsg2	DosCreateQueue
@tracemsg2	DosCreateSem
@tracemsg2	DosCreateThread
@tracemsg2	DosCWait
@tracemsg2	DosDevConfig
@tracemsg2	DosEnterCritSec
@tracemsg2	DosErrClass
@tracemsg2	DosError
@tracemsg2	DosExecPgm
@tracemsg2	DosExit
@tracemsg2	DosExitCritSec
@tracemsg2	DosExitList
@tracemsg2	DosFlagProcess
@tracemsg2	DosFreeModule
@tracemsg2	DosGetDateTime
@tracemsg2	DosGetEnv
@tracemsg2	DosGetInfoSeg
@tracemsg2	DosGetMachineMode
@tracemsg2	DosGetModule
@tracemsg2	DosGetPID
@tracemsg2	DosGetProcAddr
@tracemsg2	DosGetPrty
@tracemsg2	DosGetSTDA
@tracemsg2	DosGetVersion
@tracemsg2	DosHoldSignal
@tracemsg2	DosIOAccess
@tracemsg2	DosKillProcess
@tracemsg2	DosMakePipe
@tracemsg2	DosMonClose
@tracemsg2	DosMonOpen
@tracemsg2	DosMonRead
@tracemsg2	DosMonReg
@tracemsg2	DosMonWrite
@tracemsg2	DosMuxSemWait
@tracemsg2	DosOpenQueue
@tracemsg2	DosOpenSem
@tracemsg2	DosPeekQueue
@tracemsg2	DosPFSActivate
@tracemsg2	DosPFSCloseUser
@tracemsg2	DosPFSInit
@tracemsg2	DosPFSQueryAct
@tracemsg2	DosPFSVerifyFont
@tracemsg2	DosPhysicalDisk
@tracemsg2	DosPortAccess
@tracemsg2	DosPTrace
@tracemsg2	DosPurgeQueue
@tracemsg2	DosQSysInfo
@tracemsg2	DosQueryQueue
@tracemsg2	DosReadQueue
@tracemsg2	DosResumeThread
@tracemsg2	DosScanEnv
@tracemsg2	DosSearchPath
@tracemsg2	DosSelectSession
@tracemsg2	DosSemClear
@tracemsg2	DosSemRequest
@tracemsg2	DosSemSet
@tracemsg2	DosSemSetWait
@tracemsg2	DosSemWait
@tracemsg2	DosSendSignal
@tracemsg2	DosSetDateTime
@tracemsg2	DosSetPrty
@tracemsg2	DosSetSession
@tracemsg2	DosSetSigHandler
@tracemsg2	DosSetVec
@tracemsg2	DosSleep
@tracemsg2	DosStartSession
@tracemsg2	DosStopSession
@tracemsg2	DosSuspendThread
@tracemsg2	DosSysTrace
@tracemsg2	DosTimerAsync
@tracemsg2	DosTimerStart
@tracemsg2	DosTimerStop
@tracemsg2	DosWriteQueue

_DATA		ENDS

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

@tracecall	macro	event
event		proc
			@TRACE	event
			ret
event		endp
		endm

@tracecall2	macro	event
@tracecall	@CATSTR(Pre, event)
@tracecall	@CATSTR(Post, event)
			endm

@tracecall2	DosBeep
@tracecall2	DosCLIAccess
@tracecall2	DosCloseQueue
@tracecall2	DosCloseSem
@tracecall2	DosCreateQueue
@tracecall2	DosCreateSem
@tracecall2	DosCreateThread
@tracecall2	DosCWait
@tracecall2	DosDevConfig
@tracecall2	DosEnterCritSec
@tracecall2	DosErrClass
@tracecall2	DosError
@tracecall2	DosExecPgm
@tracecall2	DosExit
@tracecall2	DosExitCritSec
@tracecall2	DosExitList
@tracecall2	DosFlagProcess
@tracecall2	DosFreeModule
@tracecall2	DosGetDateTime
@tracecall2	DosGetEnv
@tracecall2	DosGetInfoSeg
@tracecall2	DosGetMachineMode
@tracecall2	DosGetModule
@tracecall2	DosGetPID
@tracecall2	DosGetProcAddr
@tracecall2	DosGetPrty
@tracecall2	DosGetSTDA
@tracecall2	DosGetVersion
@tracecall2	DosHoldSignal
@tracecall2	DosIOAccess
@tracecall2	DosKillProcess
@tracecall2	DosMakePipe
@tracecall2	DosMonClose
@tracecall2	DosMonOpen
@tracecall2	DosMonRead
@tracecall2	DosMonReg
@tracecall2	DosMonWrite
@tracecall2	DosMuxSemWait
@tracecall2	DosOpenQueue
@tracecall2	DosOpenSem
@tracecall2	DosPeekQueue
@tracecall2	DosPFSActivate
@tracecall2	DosPFSCloseUser
@tracecall2	DosPFSInit
@tracecall2	DosPFSQueryAct
@tracecall2	DosPFSVerifyFont
@tracecall2	DosPhysicalDisk
@tracecall2	DosPortAccess
@tracecall2	DosPTrace
@tracecall2	DosPurgeQueue
@tracecall2	DosQSysInfo
@tracecall2	DosQueryQueue
@tracecall2	DosReadQueue
@tracecall2	DosResumeThread
@tracecall2	DosScanEnv
@tracecall2	DosSearchPath
@tracecall2	DosSelectSession
@tracecall2	DosSemClear
@tracecall2	DosSemRequest
@tracecall2	DosSemSet
@tracecall2	DosSemSetWait
@tracecall2	DosSemWait
@tracecall2	DosSendSignal
@tracecall2	DosSetDateTime
@tracecall2	DosSetPrty
@tracecall2	DosSetSession
@tracecall2	DosSetSigHandler
@tracecall2	DosSetVec
@tracecall2	DosSleep
@tracecall2	DosStartSession
@tracecall2	DosStopSession
@tracecall2	DosSuspendThread
@tracecall2	DosSysTrace
@tracecall2	DosTimerAsync
@tracecall2	DosTimerStart
@tracecall2	DosTimerStop
@tracecall2	DosWriteQueue

_TEXT		ends
			end
			

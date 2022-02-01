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

@tracemsg2	MouClose
@tracemsg2	MouDrawPtr
@tracemsg2	MouFlushQue
@tracemsg2	MouFree
@tracemsg2	MouGetDevStatus
@tracemsg2	MouGetEventMask
@tracemsg2	MouGetHotKey
@tracemsg2	MouGetNumButtons
@tracemsg2	MouGetNumMickeys
@tracemsg2	MouGetNumQueEl
@tracemsg2	MouGetPtrPos
@tracemsg2	MouGetPtrShape
@tracemsg2	MouGetScaleFact
@tracemsg2	MouInitReal
@tracemsg2	MouOpen
@tracemsg2	MouReadEventQue
@tracemsg2	MouRemovePtr
@tracemsg2	MouRoute
@tracemsg2	MouSetDevStatus
@tracemsg2	MouSetEventMask
@tracemsg2	MouSetHotKey
@tracemsg2	MouSetPtrPos
@tracemsg2	MouSetPtrShape
@tracemsg2	MouSetScaleFact
@tracemsg2	MouShellInit
@tracemsg2	MouSynch

_DATA		ENDS

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

@tracecall	macro	event
	event	proc
			@TRACE	event
			ret
	event	endp
		endm

if 0
@LOCALW		GLOBALSEG
@LOCALW		LOCALSEG
		@START	DOSGETPID
		PUSH	SS
		LEA	AX, GLOBALSEG
		PUSH	AX
		PUSH	SS
		LEA	AX, LOCALSEG
		PUSH	AX
		CALL	DOSGETINFOSEG
		MOV	AX, LOCALSEG
endif

@tracecall	PreMOUCLOSE
@tracecall	PreMOUDRAWPTR
@tracecall	PreMOUFLUSHQUE
@tracecall	PreMOUFREE
@tracecall	PreMOUGETDEVSTATUS
@tracecall	PreMOUGETEVENTMASK
@tracecall	PreMOUGETHOTKEY
@tracecall	PreMOUGETNUMBUTTONS
@tracecall	PreMOUGETNUMMICKEYS
@tracecall	PreMOUGETNUMQUEEL
@tracecall	PreMOUGETPTRPOS
@tracecall	PreMOUGETPTRSHAPE
@tracecall	PreMOUGETSCALEFACT
@tracecall	PreMOUINITREAL
@tracecall	PreMOUOPEN
@tracecall	PreMOUREADEVENTQUE
@tracecall	PreMOUREMOVEPTR
@tracecall	PreMOUROUTE
@tracecall	PreMOUSETDEVSTATUS
@tracecall	PreMOUSETEVENTMASK
@tracecall	PreMOUSETHOTKEY
@tracecall	PreMOUSETPTRPOS
@tracecall	PreMOUSETPTRSHAPE
@tracecall	PreMOUSETSCALEFACT
@tracecall	PreMOUSHELLINIT
@tracecall	PreMOUSYNCH
@tracecall	PostMOUCLOSE
@tracecall	PostMOUDRAWPTR
@tracecall	PostMOUFLUSHQUE
@tracecall	PostMOUFREE
@tracecall	PostMOUGETDEVSTATUS
@tracecall	PostMOUGETEVENTMASK
@tracecall	PostMOUGETHOTKEY
@tracecall	PostMOUGETNUMBUTTONS
@tracecall	PostMOUGETNUMMICKEYS
@tracecall	PostMOUGETNUMQUEEL
@tracecall	PostMOUGETPTRPOS
@tracecall	PostMOUGETPTRSHAPE
@tracecall	PostMOUGETSCALEFACT
@tracecall	PostMOUINITREAL
@tracecall	PostMOUOPEN
@tracecall	PostMOUREADEVENTQUE
@tracecall	PostMOUREMOVEPTR
@tracecall	PostMOUROUTE
@tracecall	PostMOUSETDEVSTATUS
@tracecall	PostMOUSETEVENTMASK
@tracecall	PostMOUSETHOTKEY
@tracecall	PostMOUSETPTRPOS
@tracecall	PostMOUSETPTRSHAPE
@tracecall	PostMOUSETSCALEFACT
@tracecall	PostMOUSHELLINIT
@tracecall	PostMOUSYNCH

_TEXT		ENDS

			END
.8086

		include helpers.inc

EXTERN	VioWrtTTY: Far

_DATA		SEGMENT BYTE PUBLIC 'DATA' USE16

PreMouCloseMsg				DB	'PreMouClose', 0dh, 0ah
PreMouCloseMsgSize			EQU	($-PreMouCloseMsg)
PreMouDrawPtrMsg            DB	'PreMouDrawPtr', 0dh, 0ah
PreMouDrawPtrMsgSize		EQU	($-PreMouDrawPtrMsg)
PreMouFlushQueMsg           DB	'PreMouFlushQue', 0dh, 0ah
PreMouFlushQueMsgSize		EQU	($-PreMouFlushQueMsg)
PreMouFreeMsg               DB	'PreMouFree', 0dh, 0ah
PreMouFreeMsgSize           EQU	($-PreMouFreeMsg)
PreMouGetDevStatusMsg       DB	'PreMouGetDevStatus', 0dh, 0ah
PreMouGetDevStatusMsgSize	EQU	($-PreMouGetDevStatusMsg)
PreMouGetEventMaskMsg       DB	'PreMouGetEventMask', 0dh, 0ah
PreMouGetEventMaskMsgSize	EQU	($-PreMouGetEventMaskMsg)
PreMouGetHotKeyMsg          DB	'PreMouGetHotKey', 0dh, 0ah
PreMouGetHotKeyMsgSize		EQU	($-PreMouGetHotKeyMsg)
PreMouGetNumButtonsMsg      DB	'PreMouGetNumButtons', 0dh, 0ah
PreMouGetNumButtonsMsgSize	EQU	($-PreMouGetNumButtonsMsg)
PreMouGetNumMickeysMsg      DB	'PreMouGetNumMickeys', 0dh, 0ah
PreMouGetNumMickeysMsgSize	EQU	($-PreMouGetNumMickeysMsg)
PreMouGetNumQueElMsg        DB	'PreMouGetNumQueEl', 0dh, 0ah
PreMouGetNumQueElMsgSize	EQU	($-PreMouGetNumQueElMsg)
PreMouGetPtrPosMsg          DB	'PreMouGetPtrPos', 0dh, 0ah
PreMouGetPtrPosMsgSize		EQU	($-PreMouGetPtrPosMsg)
PreMouGetPtrShapeMsg        DB	'PreMouGetPtrShape', 0dh, 0ah
PreMouGetPtrShapeMsgSize	EQU	($-PreMouGetPtrShapeMsg)
PreMouGetScaleFactMsg       DB	'PreMouGetScaleFact', 0dh, 0ah
PreMouGetScaleFactMsgSize	EQU	($-PreMouGetScaleFactMsg)
PreMouInitRealMsg           DB	'PreMouInitReal', 0dh, 0ah
PreMouInitRealMsgSize		EQU	($-PreMouInitRealMsg)
PreMouOpenMsg               DB	'PreMouOpen', 0dh, 0ah
PreMouOpenMsgSize			EQU	($-PreMouOpenMsg)
PreMouReadEventQueMsg       DB	'PreMouReadEventQue', 0dh, 0ah
PreMouReadEventQueMsgSize	EQU	($-PreMouReadEventQueMsg)
PreMouRemovePtrMsg          DB	'PreMouRemovePtr', 0dh, 0ah
PreMouRemovePtrMsgSize		EQU	($-PreMouRemovePtrMsg)
PreMouRouteMsg              DB	'PreMouRoute', 0dh, 0ah
PreMouRouteMsgSize			EQU	($-PreMouRouteMsg)
PreMouSetDevStatusMsg       DB	'PreMouSetDevStatus', 0dh, 0ah
PreMouSetDevStatusMsgSize	EQU	($-PreMouSetDevStatusMsg)
PreMouSetEventMaskMsg       DB	'PreMouSetEventMask', 0dh, 0ah
PreMouSetEventMaskMsgSize	EQU	($-PreMouSetEventMaskMsg)
PreMouSetHotKeyMsg          DB	'PreMouSetHotKey', 0dh, 0ah
PreMouSetHotKeyMsgSize		EQU	($-PreMouSetHotKeyMsg)
PreMouSetPtrPosMsg          DB	'PreMouSetPtrPos', 0dh, 0ah
PreMouSetPtrPosMsgSize		EQU	($-PreMouSetPtrPosMsg)
PreMouSetPtrShapeMsg        DB	'PreMouSetPtrShape', 0dh, 0ah
PreMouSetPtrShapeMsgSize	EQU	($-PreMouSetPtrShapeMsg)
PreMouSetScaleFactMsg       DB	'PreMouSetScaleFact', 0dh, 0ah
PreMouSetScaleFactMsgSize	EQU	($-PreMouSetScaleFactMsg)
PreMouShellInitMsg          DB	'PreMouShellInit', 0dh, 0ah
PreMouShellInitMsgSize		EQU	($-PreMouShellInitMsg)
PreMouSynchMsg              DB	'PreMouSynch', 0dh, 0ah
PreMouSynchMsgSize			EQU	($-PreMouSynchMsg)
PostMouCloseMsg             DB	'PostMouClose', 0dh, 0ah
PostMouCloseMsgSize			EQU	($-PostMouCloseMsg)
PostMouDrawPtrMsg           DB	'PostMouDrawPtr', 0dh, 0ah
PostMouDrawPtrMsgSize		EQU	($-PostMouDrawPtrMsg)
PostMouFlushQueMsg          DB	'PostMouFlushQue', 0dh, 0ah
PostMouFlushQueMsgSize		EQU	($-PostMouFlushQueMsg)
PostMouFreeMsg              DB	'PostMouFree', 0dh, 0ah
PostMouFreeMsgSize			EQU	($-PostMouFreeMsg)
PostMouGetDevStatusMsg      DB	'PostMouGetDevStatus', 0dh, 0ah
PostMouGetDevStatusMsgSize	EQU	($-PostMouGetDevStatusMsg)
PostMouGetEventMaskMsg      DB	'PostMouGetEventMask', 0dh, 0ah
PostMouGetEventMaskMsgSize	EQU	($-PostMouGetEventMaskMsg)
PostMouGetHotKeyMsg         DB	'PostMouGetHotKey', 0dh, 0ah
PostMouGetHotKeyMsgSize		EQU	($-PostMouGetHotKeyMsg)
PostMouGetNumButtonsMsg     DB	'PostMouGetNumButtons', 0dh, 0ah
PostMouGetNumButtonsMsgSize	EQU	($-PostMouGetNumButtonsMsg)
PostMouGetNumMickeysMsg     DB	'PostMouGetNumMickeys', 0dh, 0ah
PostMouGetNumMickeysMsgSize	EQU	($-PostMouGetNumMickeysMsg)
PostMouGetNumQueElMsg       DB	'PostMouGetNumQueEl', 0dh, 0ah
PostMouGetNumQueElMsgSize	EQU	($-PostMouGetNumQueElMsg)
PostMouGetPtrPosMsg         DB	'PostMouGetPtrPos', 0dh, 0ah
PostMouGetPtrPosMsgSize		EQU	($-PostMouGetPtrPosMsg)
PostMouGetPtrShapeMsg       DB	'PostMouGetPtrShape', 0dh, 0ah
PostMouGetPtrShapeMsgSize	EQU	($-PostMouGetPtrShapeMsg)
PostMouGetScaleFactMsg      DB	'PostMouGetScaleFact', 0dh, 0ah
PostMouGetScaleFactMsgSize	EQU	($-PostMouGetScaleFactMsg)
PostMouInitRealMsg          DB	'PostMouInitReal', 0dh, 0ah
PostMouInitRealMsgSize		EQU	($-PostMouInitRealMsg)
PostMouOpenMsg              DB	'PostMouOpen', 0dh, 0ah
PostMouOpenMsgSize			EQU	($-PostMouOpenMsg)
PostMouReadEventQueMsg      DB	'PostMouReadEventQue', 0dh, 0ah
PostMouReadEventQueMsgSize	EQU	($-PostMouReadEventQueMsg)
PostMouRemovePtrMsg         DB	'PostMouRemovePtr', 0dh, 0ah
PostMouRemovePtrMsgSize		EQU	($-PostMouRemovePtrMsg)
PostMouRouteMsg             DB	'PostMouRoute', 0dh, 0ah
PostMouRouteMsgSize			EQU	($-PostMouRouteMsg)
PostMouSetDevStatusMsg      DB	'PostMouSetDevStatus', 0dh, 0ah
PostMouSetDevStatusMsgSize	EQU	($-PostMouSetDevStatusMsg)
PostMouSetEventMaskMsg      DB	'PostMouSetEventMask', 0dh, 0ah
PostMouSetEventMaskMsgSize	EQU	($-PostMouSetEventMaskMsg)
PostMouSetHotKeyMsg         DB	'PostMouSetHotKey', 0dh, 0ah
PostMouSetHotKeyMsgSize		EQU	($-PostMouSetHotKeyMsg)
PostMouSetPtrPosMsg         DB	'PostMouSetPtrPos', 0dh, 0ah
PostMouSetPtrPosMsgSize		EQU	($-PostMouSetPtrPosMsg)
PostMouSetPtrShapeMsg       DB	'PostMouSetPtrShape', 0dh, 0ah
PostMouSetPtrShapeMsgSize	EQU	($-PostMouSetPtrShapeMsg)
PostMouSetScaleFactMsg      DB	'PostMouSetScaleFact', 0dh, 0ah
PostMouSetScaleFactMsgSize	EQU	($-PostMouSetScaleFactMsg)
PostMouShellInitMsg         DB	'PostMouShellInit', 0dh, 0ah
PostMouShellInitMsgSize		EQU	($-PostMouShellInitMsg)
PostMouSynchMsg             DB	'PostMouSynch', 0dh, 0ah
PostMouSynchMsgSize			EQU	($-PostMouSynchMsg)

_DATA		ENDS

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

@tracecall	macro	event
	event	proc
			@TRACE	event
			ret
	event	endp
		endm

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
.8086

		include helpers.inc

EXTERN	VioWrtTTY: Far

_DATA		SEGMENT BYTE PUBLIC 'DATA' USE16

PreMouCloseMsg				DB	'PreMouClose'
PreMouCloseMsgSize			EQU	($-PreMouCloseMsg)
PreMouDrawPtrMsg            DB	'PreMouDrawPtr'
PreMouDrawPtrMsgSize		EQU	($-PreMouDrawPtrMsg)
PreMouFlushQueMsg           DB	'PreMouFlushQue'
PreMouFlushQueMsgSize		EQU	($-PreMouFlushQueMsg)
PreMouFreeMsg               DB	'PreMouFree'
PreMouFreeMsgSize           EQU	($-PreMouFreeMsg)
PreMouGetDevStatusMsg       DB	'PreMouGetDevStatus'
PreMouGetDevStatusMsgSize	EQU	($-PreMouGetDevStatusMsg)
PreMouGetEventMaskMsg       DB	'PreMouGetEventMask'
PreMouGetEventMaskMsgSize	EQU	($-PreMouGetEventMaskMsg)
PreMouGetHotKeyMsg          DB	'PreMouGetHotKey'
PreMouGetHotKeyMsgSize		EQU	($-PreMouGetHotKeyMsg)
PreMouGetNumButtonsMsg      DB	'PreMouGetNumButtons'
PreMouGetNumButtonsMsgSize	EQU	($-PreMouGetNumButtonsMsg)
PreMouGetNumMickeysMsg      DB	'PreMouGetNumMickeys'
PreMouGetNumMickeysMsgSize	EQU	($-PreMouGetNumMickeysMsg)
PreMouGetNumQueElMsg        DB	'PreMouGetNumQueEl'
PreMouGetNumQueElMsgSize	EQU	($-PreMouGetNumQueElMsg)
PreMouGetPtrPosMsg          DB	'PreMouGetPtrPos'
PreMouGetPtrPosMsgSize		EQU	($-PreMouGetPtrPosMsg)
PreMouGetPtrShapeMsg        DB	'PreMouGetPtrShape'
PreMouGetPtrShapeMsgSize	EQU	($-PreMouGetPtrShapeMsg)
PreMouGetScaleFactMsg       DB	'PreMouGetScaleFact'
PreMouGetScaleFactMsgSize	EQU	($-PreMouGetScaleFactMsg)
PreMouInitRealMsg           DB	'PreMouInitReal'
PreMouInitRealMsgSize		EQU	($-PreMouInitRealMsg)
PreMouOpenMsg               DB	'PreMouOpen'
PreMouOpenMsgSize			EQU	($-PreMouOpenMsg)
PreMouReadEventQueMsg       DB	'PreMouReadEventQue'
PreMouReadEventQueMsgSize	EQU	($-PreMouReadEventQueMsg)
PreMouRemovePtrMsg          DB	'PreMouRemovePtr'
PreMouRemovePtrMsgSize		EQU	($-PreMouRemovePtrMsg)
PreMouRouteMsg              DB	'PreMouRoute'
PreMouRouteMsgSize			EQU	($-PreMouRouteMsg)
PreMouSetDevStatusMsg       DB	'PreMouSetDevStatus'
PreMouSetDevStatusMsgSize	EQU	($-PreMouSetDevStatusMsg)
PreMouSetEventMaskMsg       DB	'PreMouSetEventMask'
PreMouSetEventMaskMsgSize	EQU	($-PreMouSetEventMaskMsg)
PreMouSetHotKeyMsg          DB	'PreMouSetHotKey'
PreMouSetHotKeyMsgSize		EQU	($-PreMouSetHotKeyMsg)
PreMouSetPtrPosMsg          DB	'PreMouSetPtrPos'
PreMouSetPtrPosMsgSize		EQU	($-PreMouSetPtrPosMsg)
PreMouSetPtrShapeMsg        DB	'PreMouSetPtrShape'
PreMouSetPtrShapeMsgSize	EQU	($-PreMouSetPtrShapeMsg)
PreMouSetScaleFactMsg       DB	'PreMouSetScaleFact'
PreMouSetScaleFactMsgSize	EQU	($-PreMouSetScaleFactMsg)
PreMouShellInitMsg          DB	'PreMouShellInit'
PreMouShellInitMsgSize		EQU	($-PreMouShellInitMsg)
PreMouSynchMsg              DB	'PreMouSynch'
PreMouSynchMsgSize			EQU	($-PreMouSynchMsg)
PostMouCloseMsg             DB	'PostMouClose'
PostMouCloseMsgSize			EQU	($-PostMouCloseMsg)
PostMouDrawPtrMsg           DB	'PostMouDrawPtr'
PostMouDrawPtrMsgSize		EQU	($-PostMouDrawPtrMsg)
PostMouFlushQueMsg          DB	'PostMouFlushQue'
PostMouFlushQueMsgSize		EQU	($-PostMouFlushQueMsg)
PostMouFreeMsg              DB	'PostMouFree'
PostMouFreeMsgSize			EQU	($-PostMouFreeMsg)
PostMouGetDevStatusMsg      DB	'PostMouGetDevStatus'
PostMouGetDevStatusMsgSize	EQU	($-PostMouGetDevStatusMsg)
PostMouGetEventMaskMsg      DB	'PostMouGetEventMask'
PostMouGetEventMaskMsgSize	EQU	($-PostMouGetEventMaskMsg)
PostMouGetHotKeyMsg         DB	'PostMouGetHotKey'
PostMouGetHotKeyMsgSize		EQU	($-PostMouGetHotKeyMsg)
PostMouGetNumButtonsMsg     DB	'PostMouGetNumButtons'
PostMouGetNumButtonsMsgSize	EQU	($-PostMouGetNumButtonsMsg)
PostMouGetNumMickeysMsg     DB	'PostMouGetNumMickeys'
PostMouGetNumMickeysMsgSize	EQU	($-PostMouGetNumMickeysMsg)
PostMouGetNumQueElMsg       DB	'PostMouGetNumQueEl'
PostMouGetNumQueElMsgSize	EQU	($-PostMouGetNumQueElMsg)
PostMouGetPtrPosMsg         DB	'PostMouGetPtrPos'
PostMouGetPtrPosMsgSize		EQU	($-PostMouGetPtrPosMsg)
PostMouGetPtrShapeMsg       DB	'PostMouGetPtrShape'
PostMouGetPtrShapeMsgSize	EQU	($-PostMouGetPtrShapeMsg)
PostMouGetScaleFactMsg      DB	'PostMouGetScaleFact'
PostMouGetScaleFactMsgSize	EQU	($-PostMouGetScaleFactMsg)
PostMouInitRealMsg          DB	'PostMouInitReal'
PostMouInitRealMsgSize		EQU	($-PostMouInitRealMsg)
PostMouOpenMsg              DB	'PostMouOpen'
PostMouOpenMsgSize			EQU	($-PostMouOpenMsg)
PostMouReadEventQueMsg      DB	'PostMouReadEventQue'
PostMouReadEventQueMsgSize	EQU	($-PostMouReadEventQueMsg)
PostMouRemovePtrMsg         DB	'PostMouRemovePtr'
PostMouRemovePtrMsgSize		EQU	($-PostMouRemovePtrMsg)
PostMouRouteMsg             DB	'PostMouRoute'
PostMouRouteMsgSize			EQU	($-PostMouRouteMsg)
PostMouSetDevStatusMsg      DB	'PostMouSetDevStatus'
PostMouSetDevStatusMsgSize	EQU	($-PostMouSetDevStatusMsg)
PostMouSetEventMaskMsg      DB	'PostMouSetEventMask'
PostMouSetEventMaskMsgSize	EQU	($-PostMouSetEventMaskMsg)
PostMouSetHotKeyMsg         DB	'PostMouSetHotKey'
PostMouSetHotKeyMsgSize		EQU	($-PostMouSetHotKeyMsg)
PostMouSetPtrPosMsg         DB	'PostMouSetPtrPos'
PostMouSetPtrPosMsgSize		EQU	($-PostMouSetPtrPosMsg)
PostMouSetPtrShapeMsg       DB	'PostMouSetPtrShape'
PostMouSetPtrShapeMsgSize	EQU	($-PostMouSetPtrShapeMsg)
PostMouSetScaleFactMsg      DB	'PostMouSetScaleFact'
PostMouSetScaleFactMsgSize	EQU	($-PostMouSetScaleFactMsg)
PostMouShellInitMsg         DB	'PostMouShellInit'
PostMouShellInitMsgSize		EQU	($-PostMouShellInitMsg)
PostMouSynchMsg             DB	'PostMouSynch'
PostMouSynchMsgSize			EQU	($-PostMouSynchMsg)

_DATA		ENDS

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

PreMouClose	proc
			@TRACE	PreMouClose
PreMouClose	endp

PreMouDrawPtr	proc
			@TRACE	PreMouDrawPtr
PreMouDrawPtr	endp

PreMouFlushQue	proc
			@TRACE	PreMouFlushQue
PreMouFlushQue	endp

PreMouFree	proc
			@TRACE	PreMouFree
PreMouFree	endp

PreMouGetDevStatus	proc
			@TRACE	PreMouGetDevStatus
PreMouGetDevStatus	endp

PreMouGetEventMask	proc
			@TRACE	PreMouGetEventMask
PreMouGetEventMask	endp

PreMouGetHotKey	proc
			@TRACE	PreMouGetHotKey
PreMouGetHotKey	endp

PreMouGetNumButtons	proc
			@TRACE	PreMouGetNumButtons
PreMouGetNumButtons	endp

PreMouGetNumMickeys	proc
			@TRACE	PreMouGetNumMickeys
PreMouGetNumMickeys	endp

PreMouGetNumQueEl	proc
			@TRACE	PreMouGetNumQueEl
PreMouGetNumQueEl	endp

PreMouGetPtrPos	proc
			@TRACE	PreMouGetPtrPos
PreMouGetPtrPos	endp

PreMouGetPtrShape	proc
			@TRACE	PreMouGetPtrShape
PreMouGetPtrShape	endp

PreMouGetScaleFact	proc
			@TRACE	PreMouGetScaleFact
PreMouGetScaleFact	endp

PreMouInitReal	proc
			@TRACE	PreMouInitReal
PreMouInitReal	endp

PreMouOpen	proc
			@TRACE	PreMouOpen
PreMouOpen	endp

PreMouReadEventQue	proc
			@TRACE	PreMouReadEventQue
PreMouReadEventQue	endp

PreMouRemovePtr	proc
			@TRACE	PreMouRemovePtr
PreMouRemovePtr	endp

PreMouRoute	proc
			@TRACE	PreMouRoute
PreMouRoute	endp

PreMouSetDevStatus	proc
			@TRACE	PreMouSetDevStatus
PreMouSetDevStatus	endp

PreMouSetEventMask	proc
			@TRACE	PreMouSetEventMask
PreMouSetEventMask	endp

PreMouSetHotKey	proc
			@TRACE	PreMouSetHotKey
PreMouSetHotKey	endp

PreMouSetPtrPos	proc
			@TRACE	PreMouSetPtrPos
PreMouSetPtrPos	endp

PreMouSetPtrShape	proc
			@TRACE	PreMouSetPtrShape
PreMouSetPtrShape	endp

PreMouSetScaleFact	proc
			@TRACE	PreMouSetScaleFact
PreMouSetScaleFact	endp

PreMouShellInit	proc
			@TRACE	PreMouShellInit
PreMouShellInit	endp

PreMouSynch	proc
			@TRACE	PreMouSynch
PreMouSynch	endp

PostMouClose	proc
			@TRACE	PostMouClose
PostMouClose	endp

PostMouDrawPtr	proc
			@TRACE	PostMouDrawPtr
PostMouDrawPtr	endp

PostMouFlushQue	proc
			@TRACE	PostMouFlushQue
PostMouFlushQue	endp

PostMouFree	proc
			@TRACE	PostMouFree
PostMouFree	endp

PostMouGetDevStatus	proc
			@TRACE	PostMouGetDevStatus
PostMouGetDevStatus	endp

PostMouGetEventMask	proc
			@TRACE	PostMouGetEventMask
PostMouGetEventMask	endp

PostMouGetHotKey	proc
			@TRACE	PostMouGetHotKey
PostMouGetHotKey	endp

PostMouGetNumButtons	proc
			@TRACE	PostMouGetNumButtons
PostMouGetNumButtons	endp

PostMouGetNumMickeys	proc
			@TRACE	PostMouGetNumMickeys
PostMouGetNumMickeys	endp

PostMouGetNumQueEl	proc
			@TRACE	PostMouGetNumQueEl
PostMouGetNumQueEl	endp

PostMouGetPtrPos	proc
			@TRACE	PostMouGetPtrPos
PostMouGetPtrPos	endp

PostMouGetPtrShape	proc
			@TRACE	PostMouGetPtrShape
PostMouGetPtrShape	endp

PostMouGetScaleFact	proc
			@TRACE	PostMouGetScaleFact
PostMouGetScaleFact	endp

PostMouInitReal	proc
			@TRACE	PostMouInitReal
PostMouInitReal	endp

PostMouOpen	proc
			@TRACE	PostMouOpen
PostMouOpen	endp

PostMouReadEventQue	proc
			@TRACE	PostMouReadEventQue
PostMouReadEventQue	endp

PostMouRemovePtr	proc
			@TRACE	PostMouRemovePtr
PostMouRemovePtr	endp

PostMouRoute	proc
			@TRACE	PostMouRoute
PostMouRoute	endp

PostMouSetDevStatus	proc
			@TRACE	PostMouSetDevStatus
PostMouSetDevStatus	endp

PostMouSetEventMask	proc
			@TRACE	PostMouSetEventMask
PostMouSetEventMask	endp

PostMouSetHotKey	proc
			@TRACE	PostMouSetHotKey
PostMouSetHotKey	endp

PostMouSetPtrPos	proc
			@TRACE	PostMouSetPtrPos
PostMouSetPtrPos	endp

PostMouSetPtrShape	proc
			@TRACE	PostMouSetPtrShape
PostMouSetPtrShape	endp

PostMouSetScaleFact	proc
			@TRACE	PostMouSetScaleFact
PostMouSetScaleFact	endp

PostMouShellInit	proc
			@TRACE	PostMouShellInit
PostMouShellInit	endp

PostMouSynch	proc
			@TRACE	PostMouSynch
PostMouSynch	endp

_TEXT		ENDS

			END
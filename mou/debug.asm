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

PreMouClose	proc
			@TRACE	PreMouClose
			ret
PreMouClose	endp

PreMouDrawPtr	proc
			@TRACE	PreMouDrawPtr
			ret
PreMouDrawPtr	endp

PreMouFlushQue	proc
			@TRACE	PreMouFlushQue
			ret
PreMouFlushQue	endp

PreMouFree	proc
			@TRACE	PreMouFree
			ret
PreMouFree	endp

PreMouGetDevStatus	proc
			@TRACE	PreMouGetDevStatus
			ret
PreMouGetDevStatus	endp

PreMouGetEventMask	proc
			@TRACE	PreMouGetEventMask
			ret
PreMouGetEventMask	endp

PreMouGetHotKey	proc
			@TRACE	PreMouGetHotKey
			ret
PreMouGetHotKey	endp

PreMouGetNumButtons	proc
			@TRACE	PreMouGetNumButtons
			ret
PreMouGetNumButtons	endp

PreMouGetNumMickeys	proc
			@TRACE	PreMouGetNumMickeys
			ret
PreMouGetNumMickeys	endp

PreMouGetNumQueEl	proc
			@TRACE	PreMouGetNumQueEl
			ret
PreMouGetNumQueEl	endp

PreMouGetPtrPos	proc
			@TRACE	PreMouGetPtrPos
			ret
PreMouGetPtrPos	endp

PreMouGetPtrShape	proc
			@TRACE	PreMouGetPtrShape
			ret
PreMouGetPtrShape	endp

PreMouGetScaleFact	proc
			@TRACE	PreMouGetScaleFact
			ret
PreMouGetScaleFact	endp

PreMouInitReal	proc
			@TRACE	PreMouInitReal
			ret
PreMouInitReal	endp

PreMouOpen	proc
			@TRACE	PreMouOpen
			ret
PreMouOpen	endp

PreMouReadEventQue	proc
			@TRACE	PreMouReadEventQue
			ret
PreMouReadEventQue	endp

PreMouRemovePtr	proc
			@TRACE	PreMouRemovePtr
			ret
PreMouRemovePtr	endp

PreMouRoute	proc
			@TRACE	PreMouRoute
			ret
PreMouRoute	endp

PreMouSetDevStatus	proc
			@TRACE	PreMouSetDevStatus
			ret
PreMouSetDevStatus	endp

PreMouSetEventMask	proc
			@TRACE	PreMouSetEventMask
			ret
PreMouSetEventMask	endp

PreMouSetHotKey	proc
			@TRACE	PreMouSetHotKey
			ret
PreMouSetHotKey	endp

PreMouSetPtrPos	proc
			@TRACE	PreMouSetPtrPos
			ret
PreMouSetPtrPos	endp

PreMouSetPtrShape	proc
			@TRACE	PreMouSetPtrShape
			ret
PreMouSetPtrShape	endp

PreMouSetScaleFact	proc
			@TRACE	PreMouSetScaleFact
			ret
PreMouSetScaleFact	endp

PreMouShellInit	proc
			@TRACE	PreMouShellInit
			ret
PreMouShellInit	endp

PreMouSynch	proc
			@TRACE	PreMouSynch
			ret
PreMouSynch	endp

PostMouClose	proc
			@TRACE	PostMouClose
			ret
PostMouClose	endp

PostMouDrawPtr	proc
			@TRACE	PostMouDrawPtr
			ret
PostMouDrawPtr	endp

PostMouFlushQue	proc
			@TRACE	PostMouFlushQue
			ret
PostMouFlushQue	endp

PostMouFree	proc
			@TRACE	PostMouFree
			ret
PostMouFree	endp

PostMouGetDevStatus	proc
			@TRACE	PostMouGetDevStatus
			ret
PostMouGetDevStatus	endp

PostMouGetEventMask	proc
			@TRACE	PostMouGetEventMask
			ret
PostMouGetEventMask	endp

PostMouGetHotKey	proc
			@TRACE	PostMouGetHotKey
			ret
PostMouGetHotKey	endp

PostMouGetNumButtons	proc
			@TRACE	PostMouGetNumButtons
			ret
PostMouGetNumButtons	endp

PostMouGetNumMickeys	proc
			@TRACE	PostMouGetNumMickeys
			ret
PostMouGetNumMickeys	endp

PostMouGetNumQueEl	proc
			@TRACE	PostMouGetNumQueEl
			ret
PostMouGetNumQueEl	endp

PostMouGetPtrPos	proc
			@TRACE	PostMouGetPtrPos
			ret
PostMouGetPtrPos	endp

PostMouGetPtrShape	proc
			@TRACE	PostMouGetPtrShape
			ret
PostMouGetPtrShape	endp

PostMouGetScaleFact	proc
			@TRACE	PostMouGetScaleFact
			ret
PostMouGetScaleFact	endp

PostMouInitReal	proc
			@TRACE	PostMouInitReal
			ret
PostMouInitReal	endp

PostMouOpen	proc
			@TRACE	PostMouOpen
			ret
PostMouOpen	endp

PostMouReadEventQue	proc
			@TRACE	PostMouReadEventQue
			ret
PostMouReadEventQue	endp

PostMouRemovePtr	proc
			@TRACE	PostMouRemovePtr
			ret
PostMouRemovePtr	endp

PostMouRoute	proc
			@TRACE	PostMouRoute
			ret
PostMouRoute	endp

PostMouSetDevStatus	proc
			@TRACE	PostMouSetDevStatus
			ret
PostMouSetDevStatus	endp

PostMouSetEventMask	proc
			@TRACE	PostMouSetEventMask
			ret
PostMouSetEventMask	endp

PostMouSetHotKey	proc
			@TRACE	PostMouSetHotKey
			ret
PostMouSetHotKey	endp

PostMouSetPtrPos	proc
			@TRACE	PostMouSetPtrPos
			ret
PostMouSetPtrPos	endp

PostMouSetPtrShape	proc
			@TRACE	PostMouSetPtrShape
			ret
PostMouSetPtrShape	endp

PostMouSetScaleFact	proc
			@TRACE	PostMouSetScaleFact
			ret
PostMouSetScaleFact	endp

PostMouShellInit	proc
			@TRACE	PostMouShellInit
			ret
PostMouShellInit	endp

PostMouSynch	proc
			@TRACE	PostMouSynch
			ret
PostMouSynch	endp

_TEXT		ENDS

			END
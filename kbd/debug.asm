.8086

		include helpers.inc

EXTERN	VioWrtTTY: Far

_DATA		SEGMENT BYTE PUBLIC 'DATA' USE16

PreKbdCharInMsg				DB	'PreKbdCharIn', 0dh, 0ah
PreKbdCharInMsgSize			EQU	($-PreKbdCharIn)
PreKbdCloseMsg				DB	'PreKbdClose', 0dh, 0ah
PreKbdCloseMsgSize			EQU	($-PreKbdClose)
PreKbdFlushBufferMsg		DB	'PreKbdFlushBuffer', 0dh, 0ah
PreKbdFlushBufferMsgSize	EQU	($-PreKbdFlushBuffer)
PreKbdFreeFocusMsg			DB	'PreKbdFreeFocus', 0dh, 0ah
PreKbdFreeFocusMsgSize		EQU	($-PreKbdFreeFocus)
PreKbdGetCpMsg				DB	'PreKbdGetCp', 0dh, 0ah
PreKbdGetCpMsgSize			EQU	($-PreKbdGetCp)
PreKbdGetFocusMsg			DB	'PreKbdGetFocus', 0dh, 0ah
PreKbdGetFocusMsgSize		EQU	($-PreKbdGetFocus)
PreKbdGetHWIdMsg			DB	'PreKbdGetHWId', 0dh, 0ah
PreKbdGetHWIdMsgSize		EQU	($-PreKbdGetHWId)
PreKbdGetStatusMsg			DB	'PreKbdGetStatus', 0dh, 0ah
PreKbdGetStatusMsgSize		EQU	($-PreKbdGetStatus)
PreKbdOpenMsg				DB	'PreKbdOpen', 0dh, 0ah
PreKbdOpenMsgSize			EQU	($-PreKbdOpen)
PreKbdPeekMsg				DB	'PreKbdPeek', 0dh, 0ah
PreKbdPeekMsgSize			EQU	($-PreKbdPeek)
PreKbdRouteMsg				DB	'PreKbdRoute', 0dh, 0ah
PreKbdRouteMsgSize			EQU	($-PreKbdRoute)
PreKbdSetCpMsg				DB	'PreKbdSetCp', 0dh, 0ah
PreKbdSetCpMsgSize			EQU	($-PreKbdSetCp)
PreKbdSetCustXtMsg			DB	'PreKbdSetCustXt', 0dh, 0ah
PreKbdSetCustXtMsgSize		EQU	($-PreKbdSetCustXt)
PreKbdSetStatusMsg			DB	'PreKbdSetStatus', 0dh, 0ah
PreKbdSetStatusMsgSize		EQU	($-PreKbdSetStatus)
PreKbdStringInMsg			DB	'PreKbdStringIn', 0dh, 0ah
PreKbdStringInMsgSize		EQU	($-PreKbdStringIn)
PreKbdXlateMsg				DB	'PreKbdXlate', 0dh, 0ah
PreKbdXlateMsgSize			EQU	($-PreKbdXlate)

PostKbdCharInMsg			DB	'PostKbdCharIn', 0dh, 0ah
PostKbdCharInMsgSize		EQU	($-PostKbdCharIn)
PostKbdCloseMsg				DB	'PostKbdClose', 0dh, 0ah
PostKbdCloseMsgSize			EQU	($-PostKbdClose)
PostKbdFlushBufferMsg		DB	'PostKbdFlushBuffer', 0dh, 0ah
PostKbdFlushBufferMsgSize	EQU	($-PostKbdFlushBuffer)
PostKbdFreeFocusMsg			DB	'PostKbdFreeFocus', 0dh, 0ah
PostKbdFreeFocusMsgSize		EQU	($-PostKbdFreeFocus)
PostKbdGetCpMsg				DB	'PostKbdGetCp', 0dh, 0ah
PostKbdGetCpMsgSize			EQU	($-PostKbdGetCp)
PostKbdGetFocusMsg			DB	'PostKbdGetFocus', 0dh, 0ah
PostKbdGetFocusMsgSize		EQU	($-PostKbdGetFocus)
PostKbdGetHWIdMsg			DB	'PostKbdGetHWId', 0dh, 0ah
PostKbdGetHWIdMsgSize		EQU	($-PostKbdGetHWId)
PostKbdGetStatusMsg			DB	'PostKbdGetStatus', 0dh, 0ah
PostKbdGetStatusMsgSize		EQU	($-PostKbdGetStatus)
PostKbdOpenMsg				DB	'PostKbdOpen', 0dh, 0ah
PostKbdOpenMsgSize			EQU	($-PostKbdOpen)
PostKbdPeekMsg				DB	'PostKbdPeek', 0dh, 0ah
PostKbdPeekMsgSize			EQU	($-PostKbdPeek)
PostKbdRouteMsg				DB	'PostKbdRoute', 0dh, 0ah
PostKbdRouteMsgSize			EQU	($-PostKbdRoute)
PostKbdSetCpMsg				DB	'PostKbdSetCp', 0dh, 0ah
PostKbdSetCpMsgSize			EQU	($-PostKbdSetCp)
PostKbdSetCustXtMsg			DB	'PostKbdSetCustXt', 0dh, 0ah
PostKbdSetCustXtMsgSize		EQU	($-PostKbdSetCustXt)
PostKbdSetStatusMsg			DB	'PostKbdSetStatus', 0dh, 0ah
PostKbdSetStatusMsgSize		EQU	($-PostKbdSetStatus)
PostKbdStringInMsg			DB	'PostKbdStringIn', 0dh, 0ah
PostKbdStringInMsgSize		EQU	($-PostKbdStringIn)
PostKbdXlateMsg				DB	'PostKbdXlate', 0dh, 0ah
PostKbdXlateMsgSize			EQU	($-PostKbdXlate)

_DATA		ENDS

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

@tracecall	macro	event
	event	proc
			@TRACE	event
			ret
	event	endp
		endm

@tracecall	PreKbdCharIn
@tracecall	PreKbdClose
@tracecall	PreKbdFlushBuffer
@tracecall	PreKbdFreeFocus
@tracecall	PreKbdGetCp
@tracecall	PreKbdGetFocus
@tracecall	PreKbdGetHWId
@tracecall	PreKbdGetStatus
@tracecall	PreKbdOpen
@tracecall	PreKbdPeek
@tracecall	PreKbdRoute
@tracecall	PreKbdSetCp
@tracecall	PreKbdSetCustXt
@tracecall	PreKbdSetStatus
@tracecall	PreKbdStringIn
@tracecall	PreKbdXlate
@tracecall	PostKbdCharIn
@tracecall	PostKbdClose
@tracecall	PostKbdFlushBuffer
@tracecall	PostKbdFreeFocus
@tracecall	PostKbdGetCp
@tracecall	PostKbdGetFocus
@tracecall	PostKbdGetHWId
@tracecall	PostKbdGetStatus
@tracecall	PostKbdOpen
@tracecall	PostKbdPeek
@tracecall	PostKbdRoute
@tracecall	PostKbdSetCp
@tracecall	PostKbdSetCustXt
@tracecall	PostKbdSetStatus
@tracecall	PostKbdStringIn
@tracecall	PostKbdXlate

_TEXT		ends
			end
			
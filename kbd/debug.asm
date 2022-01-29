.8086

		include helpers.inc

EXTERN	VioWrtTTY: Far

_DATA		SEGMENT BYTE PUBLIC 'DATA' USE16

PreKbdCharInMsg				DB	'PreKbdCharIn', 0dh, 0ah
PreKbdCharInMsgSize			EQU	($-PreKbdCharInMsg)
PreKbdCloseMsg				DB	'PreKbdClose', 0dh, 0ah
PreKbdCloseMsgSize			EQU	($-PreKbdCloseMsg)
PreKbdFlushBufferMsg		DB	'PreKbdFlushBuffer', 0dh, 0ah
PreKbdFlushBufferMsgSize	EQU	($-PreKbdFlushBufferMsg)
PreKbdFreeFocusMsg			DB	'PreKbdFreeFocus', 0dh, 0ah
PreKbdFreeFocusMsgSize		EQU	($-PreKbdFreeFocusMsg)
PreKbdGetCpMsg				DB	'PreKbdGetCp', 0dh, 0ah
PreKbdGetCpMsgSize			EQU	($-PreKbdGetCpMsg)
PreKbdGetFocusMsg			DB	'PreKbdGetFocus', 0dh, 0ah
PreKbdGetFocusMsgSize		EQU	($-PreKbdGetFocusMsg)
PreKbdGetHWIdMsg			DB	'PreKbdGetHWId', 0dh, 0ah
PreKbdGetHWIdMsgSize		EQU	($-PreKbdGetHWIdMsg)
PreKbdGetStatusMsg			DB	'PreKbdGetStatus', 0dh, 0ah
PreKbdGetStatusMsgSize		EQU	($-PreKbdGetStatusMsg)
PreKbdOpenMsg				DB	'PreKbdOpen', 0dh, 0ah
PreKbdOpenMsgSize			EQU	($-PreKbdOpenMsg)
PreKbdPeekMsg				DB	'PreKbdPeek', 0dh, 0ah
PreKbdPeekMsgSize			EQU	($-PreKbdPeekMsg)
PreKbdRouteMsg				DB	'PreKbdRoute', 0dh, 0ah
PreKbdRouteMsgSize			EQU	($-PreKbdRouteMsg)
PreKbdSetCpMsg				DB	'PreKbdSetCp', 0dh, 0ah
PreKbdSetCpMsgSize			EQU	($-PreKbdSetCpMsg)
PreKbdSetCustXtMsg			DB	'PreKbdSetCustXt', 0dh, 0ah
PreKbdSetCustXtMsgSize		EQU	($-PreKbdSetCustXtMsg)
PreKbdSetStatusMsg			DB	'PreKbdSetStatus', 0dh, 0ah
PreKbdSetStatusMsgSize		EQU	($-PreKbdSetStatusMsg)
PreKbdStringInMsg			DB	'PreKbdStringIn', 0dh, 0ah
PreKbdStringInMsgSize		EQU	($-PreKbdStringInMsg)
PreKbdXlateMsg				DB	'PreKbdXlate', 0dh, 0ah
PreKbdXlateMsgSize			EQU	($-PreKbdXlateMsg)

PostKbdCharInMsg			DB	'PostKbdCharIn', 0dh, 0ah
PostKbdCharInMsgSize		EQU	($-PostKbdCharInMsg)
PostKbdCloseMsg				DB	'PostKbdClose', 0dh, 0ah
PostKbdCloseMsgSize			EQU	($-PostKbdCloseMsg)
PostKbdFlushBufferMsg		DB	'PostKbdFlushBuffer', 0dh, 0ah
PostKbdFlushBufferMsgSize	EQU	($-PostKbdFlushBufferMsg)
PostKbdFreeFocusMsg			DB	'PostKbdFreeFocus', 0dh, 0ah
PostKbdFreeFocusMsgSize		EQU	($-PostKbdFreeFocusMsg)
PostKbdGetCpMsg				DB	'PostKbdGetCp', 0dh, 0ah
PostKbdGetCpMsgSize			EQU	($-PostKbdGetCpMsg)
PostKbdGetFocusMsg			DB	'PostKbdGetFocus', 0dh, 0ah
PostKbdGetFocusMsgSize		EQU	($-PostKbdGetFocusMsg)
PostKbdGetHWIdMsg			DB	'PostKbdGetHWId', 0dh, 0ah
PostKbdGetHWIdMsgSize		EQU	($-PostKbdGetHWIdMsg)
PostKbdGetStatusMsg			DB	'PostKbdGetStatus', 0dh, 0ah
PostKbdGetStatusMsgSize		EQU	($-PostKbdGetStatusMsg)
PostKbdOpenMsg				DB	'PostKbdOpen', 0dh, 0ah
PostKbdOpenMsgSize			EQU	($-PostKbdOpenMsg)
PostKbdPeekMsg				DB	'PostKbdPeek', 0dh, 0ah
PostKbdPeekMsgSize			EQU	($-PostKbdPeekMsg)
PostKbdRouteMsg				DB	'PostKbdRoute', 0dh, 0ah
PostKbdRouteMsgSize			EQU	($-PostKbdRouteMsg)
PostKbdSetCpMsg				DB	'PostKbdSetCp', 0dh, 0ah
PostKbdSetCpMsgSize			EQU	($-PostKbdSetCpMsg)
PostKbdSetCustXtMsg			DB	'PostKbdSetCustXt', 0dh, 0ah
PostKbdSetCustXtMsgSize		EQU	($-PostKbdSetCustXtMsg)
PostKbdSetStatusMsg			DB	'PostKbdSetStatus', 0dh, 0ah
PostKbdSetStatusMsgSize		EQU	($-PostKbdSetStatusMsg)
PostKbdStringInMsg			DB	'PostKbdStringIn', 0dh, 0ah
PostKbdStringInMsgSize		EQU	($-PostKbdStringInMsg)
PostKbdXlateMsg				DB	'PostKbdXlate', 0dh, 0ah
PostKbdXlateMsgSize			EQU	($-PostKbdXlateMsg)

_DATA		ENDS

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

@tracecall	macro	event
	event	proc
			@TRACE	event
			ret
	event	endp
		endm

@tracecall	PreKBDCHARIN
@tracecall	PreKBDCLOSE
@tracecall	PreKBDFLUSHBUFFER
@tracecall	PreKBDFREEFOCUS
@tracecall	PreKBDGETCP
@tracecall	PreKBDGETFOCUS
@tracecall	PreKBDGETHWID
@tracecall	PreKBDGETSTATUS
@tracecall	PreKBDOPEN
@tracecall	PreKBDPEEK
@tracecall	PreKBDROUTE
@tracecall	PreKBDSETCP
@tracecall	PreKBDSETCUSTXT
@tracecall	PreKBDSETSTATUS
@tracecall	PreKBDSTRINGIN
@tracecall	PreKBDXLATE
@tracecall	PostKBDCHARIN
@tracecall	PostKBDCLOSE
@tracecall	PostKBDFLUSHBUFFER
@tracecall	PostKBDFREEFOCUS
@tracecall	PostKBDGETCP
@tracecall	PostKBDGETFOCUS
@tracecall	PostKBDGETHWID
@tracecall	PostKBDGETSTATUS
@tracecall	PostKBDOPEN
@tracecall	PostKBDPEEK
@tracecall	PostKBDROUTE
@tracecall	PostKBDSETCP
@tracecall	PostKBDSETCUSTXT
@tracecall	PostKBDSETSTATUS
@tracecall	PostKBDSTRINGIN
@tracecall	PostKBDXLATE

_TEXT		ends
			end
			
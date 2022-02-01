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

@tracemsg2	KbdCharIn
@tracemsg2	KbdClose
@tracemsg2	KbdFlushBuffer
@tracemsg2	KbdFreeFocus
@tracemsg2	KbdGetCp
@tracemsg2	KbdGetFocus
@tracemsg2	KbdGetHWId
@tracemsg2	KbdGetStatus
@tracemsg2	KbdOpen
@tracemsg2	KbdPeek
@tracemsg2	KbdRoute
@tracemsg2	KbdSetCp
@tracemsg2	KbdSetCustXt
@tracemsg2	KbdSetStatus
@tracemsg2	KbdStringIn
@tracemsg2	KbdXlate

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
			
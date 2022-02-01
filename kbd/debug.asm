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

@tracecall2	macro	event
@tracecall	@CATSTR(Pre, event)
@tracecall	@CATSTR(Post, event)
			endm

@tracecall2	KBDCHARIN
@tracecall2	KBDCLOSE
@tracecall2	KBDFLUSHBUFFER
@tracecall2	KBDFREEFOCUS
@tracecall2	KBDGETCP
@tracecall2	KBDGETFOCUS
@tracecall2	KBDGETHWID
@tracecall2	KBDGETSTATUS
@tracecall2	KBDOPEN
@tracecall2	KBDPEEK
@tracecall2	KBDROUTE
@tracecall2	KBDSETCP
@tracecall2	KBDSETCUSTXT
@tracecall2	KBDSETSTATUS
@tracecall2	KBDSTRINGIN
@tracecall2	KBDXLATE

_TEXT		ends
			end
			
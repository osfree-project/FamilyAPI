.8086

		include helpers.inc

EXTERN	VIOWRTTTY: Far

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

@tracemsg2	VioDeRegister
@tracemsg2	VioEndPopUp
@tracemsg2	VioGetAnsi
@tracemsg2	VioGetBuf
@tracemsg2	VioGetConfig
@tracemsg2	VioGetCP
@tracemsg2	VioGetCurPos
@tracemsg2	VioGetCurType
@tracemsg2	VioGetFont
@tracemsg2	VioGetMode
@tracemsg2	VioGetPhysBuf
@tracemsg2	VioGetState
@tracemsg2	VioModeUndo
@tracemsg2	VioModeWait
@tracemsg2	VioPopUp
@tracemsg2	VioPrtSc
@tracemsg2	VioPrtScToggle
@tracemsg2	VioReadCellStr
@tracemsg2	VioReadCharStr
@tracemsg2	VioRegister
@tracemsg2	VioRoute
@tracemsg2	VioSavRedrawUndo
@tracemsg2	VioSavRedrawWait
@tracemsg2	VioScrLock
@tracemsg2	VioScrollDn
@tracemsg2	VioScrollLf
@tracemsg2	VioScrollRt
@tracemsg2	VioScrollUp
@tracemsg2	VioScrUnLock
@tracemsg2	VioSetAnsi
@tracemsg2	VioSetCP
@tracemsg2	VioSetCurPos
@tracemsg2	VioSetCurType
@tracemsg2	VioSetFont
@tracemsg2	VioSetMode
@tracemsg2	VioSetState
@tracemsg2	VioShowBuf
@tracemsg2	VioWrtCellStr
@tracemsg2	VioWrtCharStr
@tracemsg2	VioWrtCharStrAtt
@tracemsg2	VioWrtNAttr
@tracemsg2	VioWrtNCell
@tracemsg2	VioWrtNChar
@tracemsg2	VioWrtTTY

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

@tracecall2	VioDeRegister
@tracecall2	VioEndPopUp
@tracecall2	VioGetAnsi
@tracecall2	VioGetBuf
@tracecall2	VioGetConfig
@tracecall2	VioGetCP
@tracecall2	VioGetCurPos
@tracecall2	VioGetCurType
@tracecall2	VioGetFont
@tracecall2	VioGetMode
@tracecall2	VioGetPhysBuf
@tracecall2	VioGetState
@tracecall2	VioModeUndo
@tracecall2	VioModeWait
@tracecall2	VioPopUp
@tracecall2	VioPrtSc
@tracecall2	VioPrtScToggle
@tracecall2	VioReadCellStr
@tracecall2	VioReadCharStr
@tracecall2	VioRegister
@tracecall2	VioRoute
@tracecall2	VioSavRedrawUndo
@tracecall2	VioSavRedrawWait
@tracecall2	VioScrLock
@tracecall2	VioScrollDn
@tracecall2	VioScrollLf
@tracecall2	VioScrollRt
@tracecall2	VioScrollUp
@tracecall2	VioScrUnLock
@tracecall2	VioSetAnsi
@tracecall2	VioSetCP
@tracecall2	VioSetCurPos
@tracecall2	VioSetCurType
@tracecall2	VioSetFont
@tracecall2	VioSetMode
@tracecall2	VioSetState
@tracecall2	VioShowBuf
@tracecall2	VioWrtCellStr
@tracecall2	VioWrtCharStr
@tracecall2	VioWrtCharStrAtt
@tracecall2	VioWrtNAttr
@tracecall2	VioWrtNCell
@tracecall2	VioWrtNChar
@tracecall2	VioWrtTTY

_TEXT		ends
			end
			
;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouShellInit
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS and OS/2
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

_DATA		SEGMENT BYTE PUBLIC 'DATA' USE16
CharStr		DB 'MouShellInit'
CharStr_size equ ($-charstr)
_DATA		ENDS

EXTERN	VioWrtTTY: FAR

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUSHELLINIT
		@MOUSTART	MOUSHELLINIT

		XOR		AX, AX				; RC=NO_ERROR
		@PUSHA
		MOV		AX, SEG CHARSTR
		PUSH	AX
		MOV		AX, OFFSET CHARSTR
		PUSH	AX
		MOV		AX,charstr_size
		PUSH	AX
		MOV		AX,0
		PUSH	AX
		CALL	VioWrtTTY
		@POPA
		@MOUEPILOG	MOUSHELLINIT

_TEXT		ENDS
		END

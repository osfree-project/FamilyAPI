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
		INCLUDE	BSEDOS.INC
		INCLUDE	BSEERR.INC

; Global Data
_DATA		SEGMENT BYTE PUBLIC 'DATA' USE16

CharStr		DB 'MouShellInit'
CharStr_size equ ($-charstr)

MOUSEFLAG	DW	0					; Is mouse device driver presented
MOUSEDD		DB	'MOUSE$', 0			; Mouse device driver name

;-- move to stack --
MOUSEH		DW	?					; Mouse device driver handle
MOUSEA		DW	?					; ActionTaken on mouse device driver open
GBL			DD	?
LCL			DD	?
;-- move to stack --

SHELL_PID	DW	?					; PID of session manager/shell

_DATA		ENDS

EXTERN	VioWrtTTY: FAR

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		PUBLIC	MOUSHELLINIT
MOUSHELLINIT	PROC FAR
		XOR		AX, AX				; RC=NO_ERROR
		@DosOpen	MOUSEDD, MOUSEH, MOUSEA, 0, 0, 1, 42h, 0
		CMP		AX, 0
		MOV		AX, ERROR_MOUSE_NO_DEVICE	;ERR
		JNE		BAD
		MOV		AX, SEG _DATA
		MOV		ES, AX
		@DosClose	ES:MOUSEH
		MOV		ES:MOUSEFLAG, 1
		@DosGetInfoSeg	GBL, LCL
		XOR		AX, AX
BAD:

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

		RETF
MOUSHELLINIT		ENDP

_TEXT		ENDS
		END

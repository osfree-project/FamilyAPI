;/*!
;   @file
;
;   @brief MouRoute
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

	include helpers.inc
		PUBLIC	MOUROUTE
		PUBLIC	MOUFUNCTIONMASK
		PUBLIC	AMSMAIN
		PUBLIC	AMSHANDLE

_DATA		SEGMENT BYTE PUBLIC 'DATA' USE16

AMSMAIN			DD	?	; AMSMAIN far address
AMSHANDLE		DW	?	; AMSHANDLE module handle
MOUFUNCTIONMASK		DD	0	; MOU FUNCTIONS REDIRECTION MASK

CharStr		DB 'MouRoute',0dh,0ah
CharStr_SIZE     equ     ($ - CharStr)

_DATA		ENDS

EXTERN		BMSMAIN: FAR		; SUBJECT TO MOVE TO DLL
EXTERN	VioWrtTTY: FAR

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

MOUROUTE	PROC	NEAR

		PUSHF
		@PUSHA
		MOV		AX, SEG CHARSTR
		PUSH	AX
		MOV		AX, OFFSET CHARSTR
		PUSH	AX
		MOV		AX,CharStr_SIZE
		PUSH	AX
		MOV		AX,0
		PUSH	AX
		CALL	VioWrtTTY
		@POPA
		POPF

		JNZ	BMS		; Skip if AMS not registered
;Call alternate mouse subsystem if function routed
		PUSH	DS		; caller data segment
		XOR	AX,AX
		MOV	AX, SEG _DATA
		MOV	ES, AX
		CALL	FAR PTR [ES:AMSMAIN]
		POP	DS
; Return code = 0 
;           No error.  Do not invoke the corresponding Base Mouse Subsystem 
;           routine.  Return to caller with Return code = 0. 
; Return code = -1 
;           No error.  Invoke the corresponding Base Mouse Subsystem 
;           routine. Return to caller with Return code = return code from 
;           Base Mouse Subsystem. 
; Return code = error (not 0 or -1) 
;           Do not invoke the corresponding Base Mouse Subsystem routine. 
;           Return to caller with Return code = error. 
		CMP	AX, 0
		JZ	EXIT
		CMP	AX, -1
		JNZ	EXIT
BMS:
		PUSH	DS		; caller data segment
		XOR	AX,AX
		CALL	FAR PTR BMSMAIN
		POP	DS

EXIT:
		PUSHF
		@PUSHA
		MOV		AX, SEG CHARSTR
		PUSH	AX
		MOV		AX, OFFSET CHARSTR
		PUSH	AX
		MOV		AX,CharStr_SIZE
		PUSH	AX
		MOV		AX,0
		PUSH	AX
		CALL	VioWrtTTY
		@POPA
		POPF

		RET	2			; POP function code
MOUROUTE	ENDP

_TEXT		ENDS
		END

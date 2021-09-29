;/*!
;   @file
;
;   @brief MouRoute
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;*/

.8086

		PUBLIC	MOUROUTE
		PUBLIC	MOUFUNCTIONMASK
		PUBLIC	AMSMAIN
		PUBLIC	AMSHANDLE

_DATA		SEGMENT BYTE PUBLIC 'DATA' USE16

AMSMAIN			DD	?	; AMSMAIN far address
AMSHANDLE		DW	?	; AMSHANDLE module handle
MOUFUNCTIONMASK		DD	0	; MOU FUNCTIONS REDIRECTION MASK

_DATA		ENDS

EXTERN		BMSMAIN: PROC		; SUBJECT TO MOVE TO DLL

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

MOUROUTE	PROC	NEAR
		JNZ	BMS		; Skip if AMS not registered
;Call alternate mouse subsystem if function routed
		PUSH	DS		; caller data segment
		XOR	AX,AX
		MOV	AX, SEG _DATA
		MOV	ES, AX
		CALL	[ES:AMSMAIN]
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
		JZ	@F
		CMP	AX, -1
		JNZ	@F
BMS:
		PUSH	DS		; caller data segment
		XOR	AX,AX
		CALL	FAR PTR BMSMAIN
		POP	DS
@@:
		RET	2
MOUROUTE	ENDP

_TEXT		ENDS
		END

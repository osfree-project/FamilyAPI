;/*!
;   @file
;
;   @brief KbdRoute
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;*/

.8086

		PUBLIC	KBDROUTE
		PUBLIC	KBDFUNCTIONMASK
		PUBLIC	AKSMAIN
		PUBLIC	AKSHANDLE

_DATA		SEGMENT BYTE PUBLIC 'DATA' USE16

AKSMAIN			DD	?	; AKSMAIN far address
AKSHANDLE		DW	?	; AKSHANDLE module handle
KBDFUNCTIONMASK		DD	0	; KBD FUNCTIONS REDIRECTION MASK

_DATA		ENDS

EXTERN	PreKbdRoute: PROC
EXTERN	PostKbdRoute: PROC
EXTERN		BKSMAIN: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

KBDROUTE	PROC	NEAR
		CALL	PreKbdRoute
		JNZ	BKS		; Skip if AKS not registered
;Call alternate keyboard subsystem if function routed
		PUSH	DS		; caller data segment
		XOR	AX,AX
		MOV	AX, SEG _DATA
		MOV	ES, AX
		CALL	[ES:AKSMAIN]
		POP	DS
; Return code = 0 
;           No error.  Do not invoke the corresponding Base Keyboard Subsystem 
;           routine.  Return to caller with Return code = 0. 
; Return code = -1 
;           No error.  Invoke the corresponding Base Keyboard Subsystem 
;           routine. Return to caller with Return code = return code from 
;           Base Keyboard Subsystem. 
; Return code = error (not 0 or -1) 
;           Do not invoke the corresponding Base Keyboard Subsystem routine. 
;           Return to caller with Return code = error. 
		CMP	AX, 0
		JZ	@F
		CMP	AX, -1
		JNZ	@F
BKS:
		PUSH	DS		; caller data segment
		XOR	AX,AX
		CALL	FAR PTR BKSMAIN
		POP	DS
@@:
		CALL	PostKbdRoute
		RET	2
KBDROUTE	ENDP

_TEXT		ENDS
		END

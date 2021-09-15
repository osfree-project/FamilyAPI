;/*!
;   @file
;
;   @brief VioRoute
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;*/

.8086

		PUBLIC	VIOROUTE
		PUBLIC	VIOFUNCTIONMASK1
		PUBLIC	VIOFUNCTIONMASK2
		PUBLIC	AVSMAIN
		PUBLIC	AVSHANDLE

_DATA		SEGMENT BYTE PUBLIC 'DATA' USE16

AVSMAIN			DD	?	; AVSMAIN far address
AVSHANDLE		DW	?	; AVSHANDLE module handle
VIOFUNCTIONMASK1	DD	0	; VIO FUNCTIONS REDIRECTION MASK 1
VIOFUNCTIONMASK2	DD	0 	; VIO FUNCTIONS REDIRECTION MASK 2

_DATA		ENDS

EXTERN		BVSMAIN: PROC		; SUBJECT TO MOVE TO DLL

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

VIOROUTE	PROC	NEAR
		JNZ	BVS		; Skip if AVS not registered
;Call alternate video subsystem if function routed
		PUSH	DS		; caller data segment
		XOR	AX,AX
		MOV	AX, SEG _DATA
		MOV	ES, AX
		CALL	[ES:AVSMAIN]
		POP	DS
; Return code = 0 
;           No error.  Do not invoke the corresponding Base Video Subsystem 
;           routine.  Return to caller with Return code = 0. 
; Return code = -1 
;           No error.  Invoke the corresponding Base Video Subsystem 
;           routine. Return to caller with Return code = return code from 
;           Base Video Subsystem. 
; Return code = error (not 0 or -1) 
;           Do not invoke the corresponding Base Video Subsystem routine. 
;           Return to caller with Return code = error. 
		CMP	AX, 0
		JZ	@F
		CMP	AX, -1
		JNZ	@F
BVS:
		PUSH	DS		; caller data segment
		XOR	AX,AX
		CALL	FAR PTR BVSMAIN
		POP	DS
@@:
		RET	2
VIOROUTE	ENDP

_TEXT		ENDS
		END

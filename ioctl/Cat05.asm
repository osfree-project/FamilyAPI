;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosDevIOCtl Category 5 Functions
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:dosdevioctl
;
;*/

_DATA		SEGMENT BYTE PUBLIC 'DATA' USE16

PRNTABLE1:
	DW	IOPSETFRAME		; Function 41H Set Frame control
	DW	RESERVED		; Function 42H Reserved
	DW	RESERVED		; Function 43H Reserved
	DW	IOPSETRETRY		; Function 44H Set Infinite Retry
	DW	RESERVED		; Function 45H Reserved
	DW	IOPINIT			; Function 46H Initialize printer

PRNTABLE2:
	DW	IOPGETFRAME		; Function 62H Get Frame Control
	DW	RESERVED		; Function 63H Reserved
	DW	IOPGETRETRY		; Function 64H Get Infinite Retry
	DW	RESERVED		; Function 65H Reserved
	DW	IOPGETSTATUS		; Function 66H Get Printer Status

_DATA	ENDS



_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

;--------------------------------------------------------
; Category 5 Handler
;--------------------------------------------------------

IOPRINTER	PROC NEAR
		MOV	SI, [DS:BP].ARGS.FUNCTION
		SUB	SI, 41H		; 41H
		JB	EXIT
		CMP	SI, 05H		; 46H
		JBE	OK1
		SUB	SI, 20H		; 61H
		JB	EXIT
		CMP	SI, 05H		; 66H
		JA	EXIT
		JMP	OK2
OK1:
		SHL	SI, 1
;		SHL	SI, 1
		CALL	WORD PTR ES:PRNTABLE1[SI]
		JMP	EXIT
OK2:
		SHL	SI, 1
;		SHL	SI, 1
		CALL	WORD PTR ES:PRNTABLE2[SI]
EXIT:
		RET
IOPRINTER	ENDP

		INCLUDE	IopSetFrame.asm
		INCLUDE	IopSetRetry.asm
		INCLUDE	IopInit.asm
		INCLUDE	IopGetFrame.asm
		INCLUDE	IopGetRetry.asm
		INCLUDE	IopGetStatus.asm

_TEXT		ENDS

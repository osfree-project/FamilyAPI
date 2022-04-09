;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosDevIOCtl Category 1 Functions
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

SERTABLE1:
	DW	IOSSETBAUD		; Function 41H Set Baud Rate
	DW	IOSSETLINE		; Function 42H Set Line Control

_DATA	ENDS



_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

;--------------------------------------------------------
; Category 1 Handler Serial Device Control
;--------------------------------------------------------

IOSERIAL	PROC NEAR
		MOV	SI, [DS:BP].ARGS.FUNCTION
		SUB	SI, 41H		; 41H
		JB	EXIT
		CMP	SI, 1H		; 42H
		JA	EXIT
		SHL	SI, 1
;		SHL	SI, 1
		CALL	WORD PTR ES:SERTABLE1[SI]
EXIT:
		RET
IOSERIAL	ENDP


		INCLUDE	IosSetBaud.asm
		INCLUDE	IosSetLine.asm


_TEXT		ENDS


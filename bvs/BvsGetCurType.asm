;/*!
;   @file
;
;   @brief BvsGetCurType DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;* 0         NO_ERROR 
;*355        ERROR_VIO_MODE 
;*436        ERROR_VIO_INVALID_HANDLE 
;*465        ERROR_VIO_DETACHED
;
; @todo add params checks
;
;*/

.8086
		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	bios.inc
INCL_SUB	EQU	1
		INCLUDE	bseerr.inc
		INCLUDE	bsesub.inc


_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BVSPROLOG	BVSGETCURTYPE
VIOHANDLE	DW	?		;VIDEO HANDLE
CURINFO		DD	?		;
		@BVSSTART	BVSGETCURTYPE

		EXTERN	VIOCHECKHANDLE: PROC
		MOV     BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

		LDS	SI,[DS:BP].ARGS.CURINFO
		@GetCur
		XOR	AH,AH
		MOV	AL,CH
		AND	AL,01FH
		MOV	[DS:SI].VIOCURSORINFO.VIOCI_YSTART,AX
		MOV	AL,CL
		AND	AL,01FH
		MOV	[DS:SI].VIOCURSORINFO.VIOCI_CEND,AX
		XOR	AX,AX
		MOV	[DS:SI].VIOCURSORINFO.VIOCI_CX,AX
		MOV	[DS:SI].VIOCURSORINFO.VIOCI_ATTR,AX

		XOR	AX, AX
EXIT:
		@BVSEPILOG	BVSGETCURTYPE
_TEXT		ENDS
		END

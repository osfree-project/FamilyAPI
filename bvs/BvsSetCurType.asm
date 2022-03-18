;/*!
;   @file
;
;   @brief BvsSetCurType DOS wrapper
;
;   (c) osFree Project 2008-2022, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   * 0          NO_ERROR 
;   * 355        ERROR_VIO_MODE 
;   * 356        ERROR_VIO_WIDTH 
;   * 421        ERROR_VIO_INVALID_PARMS 
;   * 436        ERROR_VIO_INVALID_HANDLE 
;   * 465        ERROR_VIO_DETACHED
;
;   @todo add params checks
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE BIOS.INC
INCL_SUB	EQU	1
		INCLUDE BSEERR.INC
		INCLUDE	BSESUB.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BVSPROLOG	BVSSETCURTYPE
VIOHANDLE	DW	?		;VIDEO HANDLE
CURINFO		DD	?		;
		@BVSSTART	BVSSETCURTYPE

		EXTERN	VIOCHECKHANDLE: PROC
		MOV	BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT  

		LDS	SI,[DS:BP].ARGS.CURINFO
		MOV	AX,[DS:SI].VIOCURSORINFO.VIOCI_YSTART
		AND	AL,01FH
		MOV	CH,AL
		MOV	AX,[DS:SI].VIOCURSORINFO.VIOCI_CEND
		AND	AL,01FH
		@SetCurSz CH, AL
		XOR	AX,AX
EXIT:
		@BVSEPILOG	BVSSETCURTYPE
_TEXT		ENDS
		END

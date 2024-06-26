;/*!
;   @file
;
;   @brief BvsSetMode DOS wrapper
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
;   * 358        ERROR_VIO_ROW 
;   * 359        ERROR_VIO_COL 
;   * 436        ERROR_VIO_INVALID_HANDLE 
;   * 465        ERROR_VIO_DETACHED
;
;*/

.8086
		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
INCL_SUB	EQU	1
		INCLUDE	bseerr.inc
		INCLUDE	bsesub.inc


_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BVSPROLOG	BVSSETMODE
VIOHANDLE	DW	?		;Video handle
MODEDATA	DD	?		;Video mode info
		@BVSSTART	BVSSETMODE

		EXTERN	VIOCHECKHANDLE: PROC
		MOV     BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

		MOV	AX, ERROR_VIO_MODE
EXIT:
		@BVSEPILOG BVSSETMODE
_TEXT		ENDS
		END


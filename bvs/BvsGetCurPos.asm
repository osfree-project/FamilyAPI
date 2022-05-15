;/*!
;   @file
;
;   @brief BvsGetCurPos DOS wrapper
;
;   (c) osFree Project 2008-2022, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viogetcurpos
;
;* 0          NO_ERROR 
;* 355        ERROR_VIO_MODE 
;* 436        ERROR_VIO_INVALID_HANDLE 
;* 465        ERROR_VIO_DETACHED
;
;*/

.8086
		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	bseerr.inc
		INCLUDE	bios.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BVSPROLOG	BVSGETCURPOS
VIOHANDLE	DW	?		;Video handle
COLUMN		DD	?		;Starting column position for output
ROW		DD	?		;Starting row position for output
		@BVSSTART BVSGETCURPOS

		EXTERN	VIOCHECKHANDLE: PROC
		MOV     BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

		@GetCur
		MOV	AH,0
		MOV	AL, DL
		LDS	SI,[DS:BP].ARGS.COLUMN
		MOV	[DS:SI],AX

		MOV	AL,DH
		LDS	SI,[DS:BP].ARGS.ROW
		MOV	[DS:SI],AX
		XOR	AX,AX
EXIT:
		@BVSEPILOG BVSGETCURPOS

_TEXT		ENDS
		END

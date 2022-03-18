;/*!
;   @file
;
;   @brief BvsWrtNCell DOS wrapper
;
;   (c) osFree Project 2008-2022, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;  * 0          NO_ERROR
;  * 355        ERROR_VIO_MODE
;  * 358        ERROR_VIO_ROW
;  * 359        ERROR_VIO_COL
;  * 436        ERROR_VIO_INVALID_HANDLE
;  * 465        ERROR_VIO_DETACHED
;
; @todo: Add CX check to prevent out of screen printing
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE BIOS.INC
		INCLUDE BSEERR.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BVSPROLOG	BVSWRTNCELL
VIOHANDLE	DW	?		;Video handle
COLUMN		DW	?		;Starting column position for output
ROW		DW	?		;Starting row position for output
CTIMES		DW	?		;Repeat count
CELL		DD	?		;Character to be written
		@BVSSTART	BVSWRTNCELL

EXTERN		VIOGOTOXYH: PROC
		MOV	BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		MOV	CX,[DS:BP].ARGS.ROW		; GET ROW
		MOV	DX,[DS:BP].ARGS.COLUMN		; GET COLUMN
		CALL	VIOGOTOXYH
		JNZ	EXIT

		LDS	SI,[DS:BP].ARGS.CELL		; GET THE POINTER IN DS:SI
		LODSW					; GET THE CHARACTER CELL IN AX
		@PutChAtr AL, AH, , [DS:BP].ARGS.CTIMES

		XOR	AX,AX				; SUCCESSFUL RETURN

EXIT:
		@BVSEPILOG BVSWRTNCELL
_TEXT	ends
	end

;/*!
;   @file
;
;   @brief BvsWrtCellStr DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
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
; @todo does not work on ibm 5150
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BVSPROLOG	BVSWRTCELLSTR
VIOHANDLE	DW	?		;Video handle
COLUMN		DW	?		;Starting column position for output
ROW		DW	?		;Starting row position for output
SLENGTH		DW	?		;String length
CELLSTR		DD	?		;String to be written
		@BVSSTART	BVSWRTCELLSTR

EXTERN		VIOGOTOXYH: PROC
		MOV	BX, [DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		MOV	CX, [DS:BP].ARGS.ROW		; GET ROW
		MOV	DX, [DS:BP].ARGS.COLUMN		; GET COLUMN
		CALL	VIOGOTOXYH
		JNZ	EXIT

		MOV	CX, [DS:BP].ARGS.SLENGTH	; GET LENGTH
		PUSH	BP
		LES	BP, [DS:BP].ARGS.CELLSTR	; GET THE POINTER IN DS:SI
		MOV	BH, 0				; DISPLAY PAGE
		MOV	AL, 3				; WRITE MODE
		MOV	AH, 13H				; CALL TO WRITE STR
		INT	10H				; DO THE INTERRUPT
		POP	BP

		XOR	AX, AX				; SUCCESSFUL RETURN

EXIT:
		@BVSEPILOG	BVSWRTCELLSTR
_TEXT		ENDS

		END

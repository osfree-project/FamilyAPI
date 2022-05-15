;/*!
;   @file
;
;   @brief BvsScrollRt DOS wrapper
;
;   (c) osFree Project 2008-2022, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;-----------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	bseerr.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BVSPROLOG	BVSSCROLLRT
VIOHANDLE	DW	?
CELL		DD	?
LINES		DW	?
RIGHTCOL	DW	?
BOTROW		DW	?
LEFTCOL		DW	?
TOPROW		DW	?
		@BVSSTART	BVSSCROLLRT

		EXTERN	VIOCHECKHANDLE: PROC
		MOV	BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

		MOV	AX,[DS:BP].ARGS.TOPROW	; GET TOP ROW
		MOV	CH,AL			; PUT IN PLACE
		MOV	AX,[DS:BP].ARGS.LEFTCOL	; GET LEFT COLUMN
		MOV	CL,AL			; PUT IN PLACE
		MOV	AX,[DS:BP].ARGS.BOTROW	; GET BOTTOM ROW
		MOV	DH,AL			; PUT IN PLACE
		MOV	AX,[DS:BP].ARGS.RIGHTCOL	; GET RIGHT COLUMN
		MOV	DL,AL			; PUT IN PLACE
		LDS	SI,[DS:BP].ARGS.CELL	; GET POINTER TO CELL
		LODSW				; GET THE CELL TO USE
		MOV	BH,AH			; PUT ATTRIBUTE IN PLACE
		MOV	AX,[DS:BP].ARGS.LINES	; GET LINES TO SCROLL
		OR	AX,AX			; IS IT 0?
		JNE	F10_20			; NO, SO GO ON
		XOR	AX,AX			; NOTHING TO DO, SO RETURN GOOD
		JMP	EXIT			; GO AWAY

F10_20:
		CMP	AX,-1			; IF IT IS -1, MAKE IT 0
		JNE	F10_21			; ITS NOT, SO GO ON
		XOR	AX,AX			; MAKE IT 0

F10_21:
;		MOV     AH,?			; SCROLL RIGHT
;		INT     10H			;

		XOR	AX,AX

EXIT:
		@BVSEPILOG	BVSSCROLLRT

_TEXT		ENDS

		END

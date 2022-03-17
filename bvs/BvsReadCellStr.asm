;/*!
;   @file
;
;   @brief BvsReadCellStr DOS wrapper
;
;   (c) osFree Project 2008-2022, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE	BIOS.INC
		INCLUDE	BSEERR.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BVSPROLOG	BVSREADCELLSTR
VIOHANDLE	DW	?		;Video handle
COLUMN		DW	?		;Starting column
ROW		DW	?		;Starting row
SLENGTH		DD	?
CELLSTR		DD	?
		@BVSSTART	BVSREADCELLSTR

EXTERN		VIOGOTOXYH: PROC
		MOV	BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		MOV	CX,[DS:BP].ARGS.ROW		; GET ROW
		MOV	DX,[DS:BP].ARGS.COLUMN		; GET COLUMN
		CALL	VIOGOTOXYH
		JNZ	EXIT

		MOV	AX,0B800H	; OFFSET FOR COLOR CARD
		MOV	SI,DI		; GET THE ADDRESS AS SOURCE INDEX?
		MOV	DS,AX		; DS:SI IS NOW SET UP

		LES	DI,[DS:BP].ARGS.SLENGTH	; GET THE POINTER TO COUNT
		MOV	CX,ES:[DI]		; PUT COUNT IN CX
		LES	DI,[DS:BP].ARGS.CELLSTR	; GET THE POINTER IN ES:DI

		CLD
	REP	MOVSB				; MOVE THE BYTES

		XOR	AX,AX			; SUCCESSFUL RETURN
EXIT:
		@BVSEPILOG	BVSREADCELLSTR

_TEXT		ENDS
		END


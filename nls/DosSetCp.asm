;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosSetCP DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	bseerr.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSSETCP
CODEPAGE	DW	?
RESERVED	DW	?
		@START	DOSSETCP
		MOV	AX,ERROR_INVALID_PARAMETER
		XOR	BX, BX
		CMP	BX, WORD PTR [DS:BP].ARGS.RESERVED
		JNZ	EXIT

		MOV	BX, [DS:BP].ARGS.CODEPAGE
		MOV     AX,6602H
		INT     21H
		XOR	AX, AX
EXIT:
		@EPILOG	DOSSETCP

_TEXT		ENDS

		END

;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief BmsDrawPtr DOS wrapper
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
		; OS/2
		INCLUDE bseerr.inc
		INCLUDE bsedos.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BMSPROLOG	BMSDRAWPTR
MOUHANDLE	DW	?		;MOUSE HANDLE
		@BMSSTART	BMSDRAWPTR
		MOV	AX, ERROR_MOUSE_INVALID_HANDLE
		CMP	WORD PTR [DS:BP].ARGS.MOUHANDLE, 0
		JNZ	EXIT

EXIT:
		@BMSEPILOG	BMSDRAWPTR

_TEXT		ENDS
		END

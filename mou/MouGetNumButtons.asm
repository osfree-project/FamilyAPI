;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouGetNumButtons DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:mougetnumbuttons
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUGETNUMBUTTONS
MOUHANDLE	DW	?		;MOUSE HANDLE
NUMBEROFBUTTONS	DD	?		;NUMBER OF MOUSE BUTTONS
		@MOUSTART	MOUGETNUMBUTTONS
	        MOV	AX, MI_MOUGETNUMBUTTONS
		PUSH	AX
		MOV	AX, WORD PTR MOUFUNCTIONMASK
		AND	AX, LOWWORD MR_MOUGETNUMBUTTONS
		CMP	AX, LOWWORD MR_MOUGETNUMBUTTONS
	        CALL    MOUROUTE
		@MOUEPILOG	MOUGETNUMBUTTONS

_TEXT		ENDS
		END

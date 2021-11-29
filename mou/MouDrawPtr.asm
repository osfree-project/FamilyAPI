;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouDrawPtr router
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS and OS/2
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:moudrawptr
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUDRAWPTR
MOUHANDLE	DW	?		;MOUSE HANDLE
		@MOUSTART	MOUDRAWPTR
	        MOV	AX, MI_MOUDRAWPTR
		PUSH	AX
		MOV	AX, WORD PTR MOUFUNCTIONMASK
		AND	AX, LOWWORD MR_MOUDRAWPTR
		CMP	AX, LOWWORD MR_MOUDRAWPTR
	        CALL    MOUROUTE
		@MOUEPILOG	MOUDRAWPTR

_TEXT		ENDS
		END

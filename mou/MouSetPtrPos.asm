;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouSetPtrPos router
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS and OS/2
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:mousetptrpos
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUSETPTRPOS
MOUHANDLE	DW	?		;MOUSE HANDLE
PTRPOS		DD	?		;
		@MOUSTART	MOUSETPTRPOS
	        MOV	AX, MI_MOUSETPTRPOS
		PUSH	AX
		MOV	AX, WORD PTR MOUFUNCTIONMASK+2
		AND	AX, HIGHWORD MR_MOUSETPTRPOS
		CMP	AX, HIGHWORD MR_MOUSETPTRPOS
	        CALL    MOUROUTE
		@MOUEPILOG	MOUSETPTRPOS

_TEXT		ENDS
		END

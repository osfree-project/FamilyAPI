;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouGetPtrPos router
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS and OS/2
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:mougetptrpos
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUGETPTRPOS
MOUHANDLE	DW	?		;MOUSE HANDLE
PTRPOS		DD	?		;
		@MOUSTART	MOUGETPTRPOS
	        MOV	AX, MI_MOUGETPTRPOS
		PUSH	AX
		MOV	AX, WORD PTR MOUFUNCTIONMASK+2
		AND	AX, HIGHWORD MR_MOUGETPTRPOS
		CMP	AX, HIGHWORD MR_MOUGETPTRPOS
	        CALL    MOUROUTE
		@MOUEPILOG	MOUGETPTRPOS

_TEXT		ENDS
		END

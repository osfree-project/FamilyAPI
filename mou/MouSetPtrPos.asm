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

EXTERN	PreMouSetPtrPos: PROC
EXTERN	PostMouSetPtrPos: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUSETPTRPOS
MOUHANDLE	DW	?		;MOUSE HANDLE
PTRPOS		DD	?		;
		@MOUSTART	MOUSETPTRPOS
		CALL	PreMouSetPtrPos
		MOV	AX, MI_MOUSETPTRPOS
		PUSH	AX
		MOV	AX, WORD PTR MOUFUNCTIONMASK+2
		AND	AX, HIGHWORD MR_MOUSETPTRPOS
		CMP	AX, HIGHWORD MR_MOUSETPTRPOS
		CALL    MOUROUTE
		CALL	PostMouSetPtrPos
		@MOUEPILOG	MOUSETPTRPOS

_TEXT		ENDS
		END

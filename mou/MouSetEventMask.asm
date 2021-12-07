;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouSetEventMask router
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS and OS/2
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:mouseteventmask
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

EXTERN	PreMouSetEventMask: PROC
EXTERN	PostMouSetEventMask: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUSETEVENTMASK
MOUHANDLE	DW	?		;MOUSE HANDLE
EVENTMASK	DD	?		;
		@MOUSTART	MOUSETEVENTMASK
		CALL	PreMouSetEventMask
		MOV	AX, MI_MOUSETEVENTMASK
		PUSH	AX
		MOV	AX, WORD PTR MOUFUNCTIONMASK
		AND	AX, LOWWORD MR_MOUSETEVENTMASK
		CMP	AX, LOWWORD MR_MOUSETEVENTMASK
		CALL    MOUROUTE
		CALL	PostMouSetEventMask
		@MOUEPILOG	MOUSETEVENTMASK

_TEXT		ENDS
		END

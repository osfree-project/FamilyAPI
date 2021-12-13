;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouFlushQue router
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS and OS/2
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:mouflushque
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

EXTERN	PreMouFlushQue: PROC
EXTERN	PostMouFlushQue: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUFLUSHQUE
HANDLE		DW	?		;
		@MOUSTART	MOUFLUSHQUE
		CALL	PreMouFlushQue
		MOV		AX, MI_MOUFLUSHQUE
		PUSH	AX
		MOV	AX, WORD PTR MOUFUNCTIONMASK+2
		AND	AX, HIGHWORD MR_MOUFLUSHQUE
		CMP	AX, HIGHWORD MR_MOUFLUSHQUE
		CALL    MOUROUTE
		CALL	PostMouFlushQue
		@MOUEPILOG	MOUFLUSHQUE

_TEXT		ENDS
		END

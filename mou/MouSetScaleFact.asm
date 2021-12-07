;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouSetScaleFact router
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS and OS/2
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:mousetscalefact
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

EXTERN	PreMouSetScaleFact: FAR
EXTERN	PostMouSetScaleFact: FAR

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUSETSCALEFACT
MOUHANDLE	DW	?		;MOUSE HANDLE
SCALESTRUCT	DD	?		;
		@MOUSTART	MOUSETSCALEFACT
		CALL	PreMouSetScaleFact
		MOV	AX, MI_MOUSETSCALEFACT
		PUSH	AX
		MOV	AX, WORD PTR MOUFUNCTIONMASK
		AND	AX, LOWWORD MR_MOUSETSCALEFACT
		CMP	AX, LOWWORD MR_MOUSETSCALEFACT
		CALL    MOUROUTE
		CALL	PostMouSetScaleFact
		@MOUEPILOG	MOUSETSCALEFACT

_TEXT		ENDS
		END

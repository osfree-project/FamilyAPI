;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouGetScaleFact router
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS and OS/2
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:mougetscalefact
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

EXTERN	PreMouGetScaleFact: PROC
EXTERN	PostMouGetScaleFact: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUGETSCALEFACT
MOUHANDLE	DW	?		;MOUSE HANDLE
SCALESTRUCT	DD	?		;
		@MOUSTART	MOUGETSCALEFACT
		CALL	PreMouGetScaleFact
		MOV	AX, MI_MOUGETSCALEFACT
		PUSH	AX
		MOV	AX, WORD PTR MOUFUNCTIONMASK
		AND	AX, LOWWORD MR_MOUGETSCALEFACT
		CMP	AX, LOWWORD MR_MOUGETSCALEFACT
		CALL    MOUROUTE
		CALL	PostMouGetScaleFact
		@MOUEPILOG	MOUGETSCALEFACT

_TEXT		ENDS
		END

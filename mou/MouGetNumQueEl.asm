;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouGetNumQueEl router
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS and OS/2
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:mougetnumqueel
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

EXTERN	PreMouGetNumQueEl: PROC
EXTERN	PostMouGetNumQueEl: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUGETNUMQUEEL
MOUHANDLE	DW	?		;MOUSE HANDLE
QUEDATARECORD	DD	?		;
		@MOUSTART	MOUGETNUMQUEEL
		CALL	PreMouGetNumQueEl
		MOV	AX, MI_MOUGETNUMQUEEL
		PUSH	AX
		MOV	AX, WORD PTR MOUFUNCTIONMASK
		AND	AX, LOWWORD MR_MOUGETNUMQUEEL
		CMP	AX, LOWWORD MR_MOUGETNUMQUEEL
		CALL    MOUROUTE
		CALL	PostMouGetNumQueEl
		@MOUEPILOG	MOUGETNUMQUEEL

_TEXT		ENDS
		END

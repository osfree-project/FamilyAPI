;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouOpen router
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS and OS/2
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:mouopen
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

EXTERN	PreMouOpen: PROC
EXTERN	PostMouOpen: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUOPEN
MOUHANDLE	DW	?		;MOUSE HANDLE
DRIVERNAME	DD	?		;
		@MOUSTART	MOUOPEN
		CALL		PreMouOpen
		MOV	AX,		MI_MOUOPEN
		PUSH	AX
		MOV	AX, WORD PTR MOUFUNCTIONMASK
		AND	AX, LOWWORD MR_MOUOPEN
		CMP	AX, LOWWORD MR_MOUOPEN
		CALL    MOUROUTE
		CALL		PostMouOpen
		@MOUEPILOG	MOUOPEN

_TEXT		ENDS
		END

;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief KbdGetStatus DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:kbdgetstatus
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE KBD.INC
		INCLUDE ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

EXTERN	PreKbdGetStatus: PROC
EXTERN	PostKbdGetStatus: PROC

		@KBDPROLOG	KBDGETSTATUS
KBDHANDLE	DW	?		;KEYBOARD HANDLE
STATDATA	DD	?		;
		@KBDSTART	KBDGETSTATUS
		CALL	PreKbdGetStatus
		MOV	AX, KI_KBDGETSTATUS
		PUSH	AX
		MOV	AX, WORD PTR KBDFUNCTIONMASK
		AND	AX, LOWWORD KR_KBDGETSTATUS
		CMP	AX, LOWWORD KR_KBDGETSTATUS
		CALL    KBDROUTE
		CALL	PostKbdGetStatus
		@KBDEPILOG	KBDGETSTATUS

_TEXT		ENDS
		END

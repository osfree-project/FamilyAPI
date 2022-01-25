;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief KbdGetFocus DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:kbdgetfocus
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE KBD.INC
		INCLUDE ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

EXTERN	PreKbdGetFocus: PROC
EXTERN	PostKbdGetFocus: PROC

		@KBDPROLOG	KBDGETFOCUS
KBDHANDLE	DW	?		;KEYBOARD HANDLE
IOWAIT		DW	?		;
		@KBDSTART	KBDGETFOCUS
		CALL	PreKbdGetFocus
		MOV	AX, KI_KBDGETFOCUS
		PUSH	AX
		MOV	AX, WORD PTR KBDFUNCTIONMASK
		AND	AX, LOWWORD KR_KBDGETFOCUS
		CMP	AX, LOWWORD KR_KBDGETFOCUS
		CALL    KBDROUTE
		CALL	PostKbdGetFocus
		@KBDEPILOG	KBDGETFOCUS

_TEXT		ENDS
		END

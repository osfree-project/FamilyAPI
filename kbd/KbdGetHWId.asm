;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief KbdGetHWId DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:kbdgethwid
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE KBD.INC
		INCLUDE ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

EXTERN	PreKbdGetHWId: PROC
EXTERN	PostKbdGetHWId: PROC

		@KBDPROLOG	KBDGETHWID
KBDHANDLE	DW	?		;KEYBOARD HANDLE
KEYBOARDID	DD	?		;
RESERVED	DD	?		;
		@KBDSTART	KBDGETHWID
		CALL	PreKbdGetHWId
		MOV	AX, KI_KBDGETHWID
		PUSH	AX
		MOV	AX, WORD PTR KBDFUNCTIONMASK
		AND	AX, LOWWORD KR_KBDGETHWID
		CMP	AX, LOWWORD KR_KBDGETHWID
		CALL    KBDROUTE
		CALL	PreKbdGetHWId
		@KBDEPILOG	KBDGETHWID

_TEXT		ENDS
		END

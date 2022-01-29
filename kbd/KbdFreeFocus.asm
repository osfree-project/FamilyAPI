;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief KbdFreeFocus DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:kbdfreefocus
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE KBD.INC
		INCLUDE ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

EXTERN	PreKbdFreeFocus: PROC
EXTERN	PostKbdFreeFocus: PROC

		@KBDPROLOG	KBDFREEFOCUS
KBDHANDLE	DW	?		;KEYBOARD HANDLE
		@KBDSTART	KBDFREEFOCUS
		CALL	PreKbdFreeFocus
		@KBDROUTE	KBDFREEFOCUS
		CALL	PostKbdFreeFocus
		@KBDEPILOG	KBDFREEFOCUS

_TEXT		ENDS
		END

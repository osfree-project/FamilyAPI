;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief KbdPeek DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:kbdpeek
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE KBD.INC
		INCLUDE ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

EXTERN	PreKbdPeek: PROC
EXTERN	PostKbdPeek: PROC

		@KBDPROLOG	KBDPEEK
KBDHANDLE	DW	?		;KEYBOARD HANDLE
CHARDATA	DD	?		;
		@KBDSTART	KBDPEEK
		CALL	PreKbdPeek
		@KBDROUTE	KBDPEEK
		CALL	PostKbdPeek
		@KBDEPILOG	KBDPEEK

_TEXT		ENDS
		END

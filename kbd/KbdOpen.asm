;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief KbdOpen DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:kbdopen
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE KBD.INC
		INCLUDE ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

EXTERN	PreKbdOpen: PROC
EXTERN	PostKbdOpen: PROC

		@KBDPROLOG	KBDOPEN
KBDHANDLE	DW	?		;KEYBOARD HANDLE
		@KBDSTART	KBDOPEN
		CALL	PreKbdOpen
		@KBDROUTE	KBDOPEN
		CALL	PostKbdOpen
		@KBDEPILOG	KBDOPEN

_TEXT		ENDS
		END

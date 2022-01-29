;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief KbdStringIn DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:kbdstringin
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE KBD.INC
		INCLUDE ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

EXTERN	PreKbdStringIn: PROC
EXTERN	PostKbdStringIn: PROC

		@KBDPROLOG	KBDSTRINGIN
KBDHANDLE	DW	?		;KEYBOARD HANDLE
IOWAIT		DW	?		;
STRINGLENGTH	DD	?		;
CHARBUFFER	DD	?		;
		@KBDSTART	KBDSTRINGIN
		CALL	PreKbdStringIn
		@KBDROUTE	KBDSTRINGIN
		CALL	PostKbdStringIn
		@KBDEPILOG	KBDSTRINGIN

_TEXT		ENDS
		END

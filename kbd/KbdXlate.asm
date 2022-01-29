;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief KbdXlate DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:kbdxlate
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE KBD.INC
		INCLUDE ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

EXTERN	PreKbdXlate: PROC
EXTERN	PostKbdXlate: PROC

		@KBDPROLOG	KBDXLATE
KBDHANDLE	DW	?		;KEYBOARD HANDLE
XLATERECORD	DD	?		;
		@KBDSTART	KBDXLATE
		CALL	PreKbdXlate
		@KBDROUTE	KBDXLATE
		CALL	PostKbdXlate
		@KBDEPILOG	KBDXLATE

_TEXT		ENDS
		END

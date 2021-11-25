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

		@KBDPROLOG	KBDXLATE
KBDHANDLE	DW	?		;KEYBOARD HANDLE
XLATERECORD	DD	?		;
		@KBDSTART	KBDXLATE
	        MOV	AX, KI_KBDXLATE
		PUSH	AX
		MOV	AX, WORD PTR KBDFUNCTIONMASK
		AND	AX, LOWWORD KR_KBDXLATE
		CMP	AX, LOWWORD KR_KBDXLATE
	        CALL    KBDROUTE
		@KBDEPILOG	KBDXLATE

_TEXT		ENDS
		END

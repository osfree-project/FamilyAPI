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

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@KBDPROLOG	KBDFREEFOCUS
KBDHANDLE	DW	?		;KEYBOARD HANDLE
		@KBDSTART	KBDFREEFOCUS
	        MOV	AX, KI_KBDFREEFOCUS
		PUSH	AX
		MOV	AX, WORD PTR KBDFUNCTIONMASK
		AND	AX, LOWWORD KR_KBDFREEFOCUS
		CMP	AX, LOWWORD KR_KBDFREEFOCUS
	        CALL    KBDROUTE
		@KBDEPILOG	KBDFREEFOCUS

_TEXT		ENDS
		END

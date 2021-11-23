;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief KbdClose DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:kbdclose
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE KBD.INC
		INCLUDE ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@KBDPROLOG	KBDCLOSE
KBDHANDLE	DW	?		;KEYBOARD HANDLE
		@KBDSTART	KBDCLOSE
	        MOV	AX, KI_KBDCLOSE
		PUSH	AX
		MOV	AX, WORD PTR KBDFUNCTIONMASK
		AND	AX, LOWWORD KR_KBDCLOSE
		CMP	AX, LOWWORD KR_KBDCLOSE
	        CALL    KBDROUTE
		@KBDEPILOG	KBDCLOSE

_TEXT		ENDS
		END

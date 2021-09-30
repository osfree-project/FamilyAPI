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

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@KBDPROLOG	KBDPEEK
KBDHANDLE	DW	?		;KEYBOARD HANDLE
CHARDATA	DD	?		;
		@KBDSTART	KBDPEEK
	        MOV	AX, KI_KBDPEEK
		PUSH	AX
		MOV	AX, WORD PTR KBDFUNCTIONMASK
		AND	AX, LOWWORD KR_KBDPEEK
		CMP	AX, LOWWORD KR_KBDPEEK
	        CALL    KBDROUTE
		@KBDEPILOG	KBDPEEK

_TEXT		ENDS
		END

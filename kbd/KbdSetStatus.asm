;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief KbdSetStatus DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:kbdsetstatus
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE KBD.INC
		INCLUDE ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@KBDPROLOG	KBDSETSTATUS
KBDHANDLE	DW	?		;KEYBOARD HANDLE
STATDATA	DD	?		;
		@KBDSTART	KBDSETSTATUS
	        MOV	AX, KI_KBDSETSTATUS
		PUSH	AX
		MOV	AX, WORD PTR KBDFUNCTIONMASK
		AND	AX, LOWWORD KR_KBDSETSTATUS
		CMP	AX, LOWWORD KR_KBDSETSTATUS
	        CALL    KBDROUTE
		@KBDEPILOG	KBDSETSTATUS

_TEXT		ENDS
		END

;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief KbdCharIn DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:kbdcharin
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE KBD.INC
		INCLUDE ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

EXTERN	PreKbdCharIn: PROC
EXTERN	PostKbdCharIn: PROC

		@KBDPROLOG	KBDCHARIN
KBDHANDLE	DW	?		;KEYBOARD HANDLE
IOWAIT		DW	?		;
CHARDATA	DD	?		;
		@KBDSTART	KBDCHARIN
		CALL	PreKbdCharIn
		MOV	AX, KI_KBDCHARIN
		PUSH	AX
		MOV	AX, WORD PTR KBDFUNCTIONMASK
		AND	AX, LOWWORD KR_KBDCHARIN
		CMP	AX, LOWWORD KR_KBDCHARIN
		CALL    KBDROUTE
		CALL	PostKbdCharIn
		@KBDEPILOG	KBDCHARIN

_TEXT		ENDS
		END

;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief KbdSetCustXt DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:kbdsetcustxt
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE KBD.INC
		INCLUDE ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

EXTERN	PreKbdSetCustXt: PROC
EXTERN	PostKbdSetCustXt: PROC

		@KBDPROLOG	KBDSETCUSTXT
KBDHANDLE	DW	?		;KEYBOARD HANDLE
XLATETABLE	DD	?		;
		@KBDSTART	KBDSETCUSTXT
		CALL	PreKbdSetCustXt
		MOV	AX, KI_KBDSETCUSTXT
		PUSH	AX
		MOV	AX, WORD PTR KBDFUNCTIONMASK
		AND	AX, LOWWORD KR_KBDSETCUSTXT
		CMP	AX, LOWWORD KR_KBDSETCUSTXT
		CALL    KBDROUTE
		CALL	PostKbdSetCustXt
		@KBDEPILOG	KBDSETCUSTXT

_TEXT		ENDS
		END

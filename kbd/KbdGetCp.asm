;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief KbdGetCp DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:kbdgetcp
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE KBD.INC
		INCLUDE ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

EXTERN	PreKbdGetCp: PROC
EXTERN	PostKbdGetCp: PROC

		@KBDPROLOG	KBDGETCP
KBDHANDLE	DW	?		;KEYBOARD HANDLE
CODEPAGEID	DD	?		;
RESERVED	DD	?		;
		@KBDSTART	KBDGETCP
		CALL	PreKbdGetCp
		MOV	AX, KI_KBDGETCP
		PUSH	AX
		MOV	AX, WORD PTR KBDFUNCTIONMASK
		AND	AX, LOWWORD KR_KBDGETCP
		CMP	AX, LOWWORD KR_KBDGETCP
		CALL    KBDROUTE
		CALL	PostKbdGetCp
		@KBDEPILOG	KBDGETCP

_TEXT		ENDS
		END

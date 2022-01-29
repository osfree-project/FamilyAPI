;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief KbdSetCp DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:kbdsetcp
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE KBD.INC
		INCLUDE ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

EXTERN	PreKbdSetCp: PROC
EXTERN	PostKbdSetCp: PROC

		@KBDPROLOG	KBDSETCP
KBDHANDLE	DW	?		;KEYBOARD HANDLE
CODEPAGEID	DD	?		;
RESERVED	DD	?		;
		@KBDSTART	KBDSETCP
		CALL	PreKbdSetCp
		@KBDROUTE	KBDSETCP
		CALL	PostKbdSetCp
		@KBDEPILOG	KBDSETCP

_TEXT		ENDS
		END

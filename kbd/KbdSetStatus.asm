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

EXTERN	PreKbdSetStatus: PROC
EXTERN	PostKbdSetStatus: PROC

		@KBDPROLOG	KBDSETSTATUS
KBDHANDLE	DW	?		;KEYBOARD HANDLE
STATDATA	DD	?		;
		@KBDSTART	KBDSETSTATUS
		CALL	PreKbdSetStatus
		@KBDROUTE	KBDSETSTATUS
		CALL	PostKbdSetStatus
		@KBDEPILOG	KBDSETSTATUS

_TEXT		ENDS
		END

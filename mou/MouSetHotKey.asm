;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouSetHotKey router
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS and OS/2
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:mousethotkey
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

EXTERN	PreMouSetHotKey: PROC
EXTERN	PostMouSetHotKey: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUSETHOTKEY
MOUHANDLE	DW	?		;MOUSE HANDLE
BUTTONMASK	DD	?		;
		@MOUSTART	MOUSETHOTKEY
		CALL	PreMouSetHotKey
		@MOUROUTE	MOUSETHOTKEY, 0
		CALL	PostMouSetHotKey
		@MOUEPILOG	MOUSETHOTKEY

_TEXT		ENDS
		END

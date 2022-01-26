;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouGetHotKey router
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS and OS/2
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:mougethotkey
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

EXTERN	PreMouGetHotKey: PROC
EXTERN	PostMouGetHotKey: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUGETHOTKEY
MOUHANDLE	DW	?		;MOUSE HANDLE
BUTTONMASK	DD	?		;
		@MOUSTART	MOUGETHOTKEY
		CALL	PreMouGetHotKey
		@MOUROUTE	MOUGETHOTKEY, 0
		CALL	PostMouGetHotKey
		@MOUEPILOG	MOUGETHOTKEY
_TEXT		ENDS
		END

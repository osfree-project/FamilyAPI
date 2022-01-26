;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouFree router
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS and OS/2
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

EXTERN	PreMouFree: PROC
EXTERN	PostMouFree: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUFREE
;MOUHANDLE	DW	?		;MOUSE HANDLE	; ??? Not known is it required or not?
		@MOUSTART	MOUFREE
		CALL	PreMouFree
		@MOUROUTE	MOUFREE, 2
		CALL	PostMouFree
		@MOUEPILOG	MOUFREE

_TEXT		ENDS
		END

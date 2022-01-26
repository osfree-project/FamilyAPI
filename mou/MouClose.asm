;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouClose router
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS and OS/2
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:mouclose
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

EXTERN	PreMouClose: PROC
EXTERN	PostMouClose: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUCLOSE
MOUHANDLE	DW	?		;MOUSE HANDLE
		@MOUSTART	MOUCLOSE
		CALL	PreMouClose
		@MOUROUTE	MOUCLOSE, 0
		CALL	PostMouClose
		@MOUEPILOG	MOUCLOSE

_TEXT		ENDS
		END

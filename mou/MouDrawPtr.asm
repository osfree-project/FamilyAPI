;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouDrawPtr router
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS and OS/2
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:moudrawptr
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

EXTERN	PreMouDrawPtr: PROC
EXTERN	PostMouDrawPtr: PROC


_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUDRAWPTR
MOUHANDLE	DW	?		;MOUSE HANDLE
		@MOUSTART	MOUDRAWPTR
		CALL	PreMouDrawPtr
		@MOUROUTE	MOUDRAWPTR, 0
		CALL	PostMouDrawPtr
		@MOUEPILOG	MOUDRAWPTR
_TEXT		ENDS
		END

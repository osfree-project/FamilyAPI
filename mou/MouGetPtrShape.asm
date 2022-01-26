;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouGetPtrShape router
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS and OS/2
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:mougetptrshape
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

EXTERN	PreMouGetPtrShape: PROC
EXTERN	PostMouGetPtrShape: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUGETPTRSHAPE
MOUHANDLE	DW	?		;MOUSE HANDLE
PTRDEFREC	DD	?		;
PTRBUFFER	DD	?		;
		@MOUSTART	MOUGETPTRSHAPE
		CALL	PreMouGetPtrShape
		@MOUROUTE	MOUGETPTRSHAPE, 0
		CALL	PostMouGetPtrShape
		@MOUEPILOG	MOUGETPTRSHAPE

_TEXT		ENDS
		END

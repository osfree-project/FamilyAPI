;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouSetPtrShape router
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS and OS/2
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:mousetptrshape
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

EXTERN	PreMouSetPtrShape: FAR
EXTERN	PostMouSetPtrShape: FAR

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUSETPTRSHAPE
MOUHANDLE	DW	?		;MOUSE HANDLE
PTRDEFREC	DD	?		;
PTRBUFFER	DD	?		;
		@MOUSTART	MOUSETPTRSHAPE
		CALL	PreMouSetPtrShape
		@MOUROUTE	MOUSETPTRSHAPE, 0
		CALL	PostMouSetPtrShape
		@MOUEPILOG	MOUSETPTRSHAPE

_TEXT		ENDS
		END

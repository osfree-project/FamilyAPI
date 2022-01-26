;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouGetEventMask router
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS and OS/2
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:mougeteventmask
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

EXTERN	PreMouGetEventMask: PROC
EXTERN	PostMouGetEventMask: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUGETEVENTMASK
MOUHANDLE	DW	?		;MOUSE HANDLE
EVENTMASK	DD	?		;
		@MOUSTART	MOUGETEVENTMASK
		CALL	PreMouGetEventMask
		@MOUROUTE	MOUGETEVENTMASK, 0
		CALL	PostMouGetEventMask
		@MOUEPILOG	MOUGETEVENTMASK
_TEXT		ENDS
		END

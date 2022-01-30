;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouSetPtrPos router
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS and OS/2
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:mousetptrpos
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

EXTERN	PreMouSetPtrPos: PROC
EXTERN	PostMouSetPtrPos: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

@MOUPROC	MOUSETPTRPOS, 2, MOUHANDLE DW ?, PTRPOS DD ?

_TEXT		ENDS
		END

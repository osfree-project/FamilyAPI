;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouGetDevStatus router
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS and OS/2
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:mougetdevstatus
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

EXTERN	PreMouGetDevStatus: PROC
EXTERN	PostMouGetDevStatus: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

@MOUPROC	MOUGETDEVSTATUS, 0, MOUHANDLE DW ?, DEVICSTATUS DD ?

_TEXT		ENDS
		END

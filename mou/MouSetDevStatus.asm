;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouSetDevStatus router
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS and OS/2
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:mousetdevstatus
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

EXTERN	PreMouSetDevStatus: PROC
EXTERN	PostMouSetDevStatus: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUSETDEVSTATUS
HANDLE		DW	?		;
DEVSTATUS	DD	?
		@MOUSTART	MOUSETDEVSTATUS
		CALL	PreMouSetDevStatus
		@MOUROUTE	MOUSETDEVSTATUS, 2
		CALL	PostMouSetDevStatus
		@MOUEPILOG	MOUSETDEVSTATUS

_TEXT		ENDS
		END

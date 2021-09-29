;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouSetDevStatus DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
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

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUSETDEVSTATUS
HANDLE		DW	?		;
DEVSTATUS	DD	?
		@MOUSTART	MOUSETDEVSTATUS
	        MOV	AX, MI_MOUSETDEVSTATUS
		PUSH	AX
		MOV	AX, WORD PTR MOUFUNCTIONMASK+2
		AND	AX, HIGHWORD MR_MOUSETDEVSTATUS
		CMP	AX, HIGHWORD MR_MOUSETDEVSTATUS
	        CALL    MOUROUTE
		@MOUEPILOG	MOUSETDEVSTATUS

_TEXT		ENDS
		END

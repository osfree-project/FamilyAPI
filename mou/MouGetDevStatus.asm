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

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUGETDEVSTATUS
MOUHANDLE	DW	?		;MOUSE HANDLE
DEVICSTATUS	DD	?		;STATUS OF DEVICE
		@MOUSTART	MOUGETDEVSTATUS
	        MOV	AX, MI_MOUGETDEVSTATUS
		PUSH	AX
		MOV	AX, WORD PTR MOUFUNCTIONMASK
		AND	AX, LOWWORD MR_MOUGETDEVSTATUS
		CMP	AX, LOWWORD MR_MOUGETDEVSTATUS
	        CALL    MOUROUTE
		@MOUEPILOG	MOUGETDEVSTATUS

_TEXT		ENDS
		END

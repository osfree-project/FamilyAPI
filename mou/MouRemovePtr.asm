;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouRemovePtr router
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS and OS/2
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:mouremoveptr
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUREMOVEPTR
MOUHANDLE	DW	?		;MOUSE HANDLE
PTRAREA		DD	?		;
		@MOUSTART	MOUREMOVEPTR
	        MOV	AX, MI_MOUREMOVEPTR
		PUSH	AX
		MOV	AX, WORD PTR MOUFUNCTIONMASK+2
		AND	AX, HIGHWORD MR_MOUREMOVEPTR
		CMP	AX, HIGHWORD MR_MOUREMOVEPTR
	        CALL    MOUROUTE
		@MOUEPILOG	MOUREMOVEPTR

_TEXT		ENDS
		END

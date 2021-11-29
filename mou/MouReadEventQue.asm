;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouReadEventQue router
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS and OS/2
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:moureadeventque
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUREADEVENTQUE
MOUHANDLE	DW	?		;MOUSE HANDLE
READTYPE	DD	?		;
BUFFER		DD	?		;
		@MOUSTART	MOUREADEVENTQUE
	        MOV	AX, MI_MOUREADEVENTQUE
		PUSH	AX
		MOV	AX, WORD PTR MOUFUNCTIONMASK
		AND	AX, LOWWORD MR_MOUREADEVENTQUE
		CMP	AX, LOWWORD MR_MOUREADEVENTQUE
	        CALL    MOUROUTE
		@MOUEPILOG	MOUREADEVENTQUE

_TEXT		ENDS
		END

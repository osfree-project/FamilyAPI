;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouGetEventMask DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
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

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUGETEVENTMASK
MOUHANDLE	DW	?		;MOUSE HANDLE
EVENTMASK	DD	?		;
		@MOUSTART	MOUGETEVENTMASK
	        MOV	AX, MI_MOUGETEVENTMASK
		PUSH	AX
		MOV	AX, WORD PTR MOUFUNCTIONMASK
		AND	AX, LOWWORD MR_MOUGETEVENTMASK
		CMP	AX, LOWWORD MR_MOUGETEVENTMASK
	        CALL    MOUROUTE
		@MOUEPILOG	MOUGETEVENTMASK

_TEXT		ENDS
		END

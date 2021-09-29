;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouSetScaleFact DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:mousetscalefact
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUSETSCALEFACT
MOUHANDLE	DW	?		;MOUSE HANDLE
SCALESTRUCT	DD	?		;
		@MOUSTART	MOUSETSCALEFACT
	        MOV	AX, MI_MOUSETSCALEFACT
		PUSH	AX
		MOV	AX, WORD PTR MOUFUNCTIONMASK
		AND	AX, LOWWORD MR_MOUSETSCALEFACT
		CMP	AX, LOWWORD MR_MOUSETSCALEFACT
	        CALL    MOUROUTE
		@MOUEPILOG	MOUSETSCALEFACT

_TEXT		ENDS
		END

;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouClose DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:mouclose
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUCLOSE
MOUHANDLE	DW	?		;MOUSE HANDLE
		@MOUSTART	MOUCLOSE
	        MOV	AX, MI_MOUCLOSE
		PUSH	AX
		MOV	AX, WORD PTR MOUFUNCTIONMASK
		AND	AX, LOWWORD MR_MOUCLOSE
		CMP	AX, LOWWORD MR_MOUCLOSE
	        CALL    MOUROUTE
		@MOUEPILOG	MOUCLOSE

_TEXT		ENDS
		END

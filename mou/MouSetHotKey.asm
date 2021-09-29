;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouSetHotKey DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:mousethotkey
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUSETHOTKEY
MOUHANDLE	DW	?		;MOUSE HANDLE
BUTTONMASK	DD	?		;
		@MOUSTART	MOUSETHOTKEY
	        MOV	AX, MI_MOUSETHOTKEY
		PUSH	AX
		MOV	AX, WORD PTR MOUFUNCTIONMASK
		AND	AX, LOWWORD MR_MOUSETHOTKEY
		CMP	AX, LOWWORD MR_MOUSETHOTKEY
	        CALL    MOUROUTE
		@MOUEPILOG	MOUSETHOTKEY

_TEXT		ENDS
		END

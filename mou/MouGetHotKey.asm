;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouGetHotKey DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:mougethotkey
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUGETHOTKEY
MOUHANDLE	DW	?		;MOUSE HANDLE
BUTTONMASK	DD	?		;
		@MOUSTART	MOUGETHOTKEY
	        MOV	AX, MI_MOUGETHOTKEY
		PUSH	AX
		MOV	AX, WORD PTR MOUFUNCTIONMASK
		AND	AX, LOWWORD MR_MOUGETHOTKEY
		CMP	AX, LOWWORD MR_MOUGETHOTKEY
	        CALL    MOUROUTE
		@MOUEPILOG	MOUGETHOTKEY

_TEXT		ENDS
		END

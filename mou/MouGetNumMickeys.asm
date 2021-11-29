;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouGetNumMickeys router
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS and OS/2
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:mougetnummickeys
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUGETNUMMICKEYS
MOUHANDLE	DW	?		;MOUSE HANDLE
NUMBEROFMICKEYS	DD	?		;NUMBER OF MICKEYS
		@MOUSTART	MOUGETNUMMICKEYS
	        MOV	AX, MI_MOUGETNUMMICKEYS
		PUSH	AX
		MOV	AX, WORD PTR MOUFUNCTIONMASK
		AND	AX, LOWWORD MR_MOUGETNUMMICKEYS
		CMP	AX, LOWWORD MR_MOUGETNUMMICKEYS
	        CALL    MOUROUTE
		@MOUEPILOG	MOUGETNUMMICKEYS

_TEXT		ENDS
		END

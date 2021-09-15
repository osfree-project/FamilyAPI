;/*!
;   @file
;
;   @brief BvsSetAnsi DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;  *0 NO_ERROR
;  *355 ERROR_VIO_MODE
;  *421 ERROR_VIO_INVALID_PARMS
;  *430 ERROR_VIO_ILLEGAL_DURING_POPUP
;  *436 ERROR_VIO_INVALID_HANDLE
;  *465 ERROR_VIO_DETACHED
;
; @todo: add indicator range check
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE DOS.INC
		INCLUDE BSEERR.INC
		INCLUDE BVSVARS.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BVSPROLOG	BVSSETANSI
VIOHANDLE	DW	?		;Video handle
INDICATOR	DW	?		;
		@BVSSTART	BVSSETANSI

		EXTERN	VIOCHECKHANDLE: PROC
		MOV     BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

		MOV     AX,[DS:BP].ARGS.INDICATOR
		PUSH    CS
		POP     DS
		MOV     ANSI_STATE,AX           ; SAVE IT AWAY

		XOR	AX, AX                   ; ALL OK

EXIT:
		@BVSEPILOG	BVSSETANSI
_TEXT	ENDS
	END

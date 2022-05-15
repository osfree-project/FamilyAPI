;/*!
;   @file
;
;   @brief BvsGetAnsi DOS wrapper
;
;   (c) osFree Project 2008-2022, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;  * 0   NO_ERROR
;  * 355 ERROR_VIO_MODE
;  * 421 ERROR_VIO_INVALID_PARMS
;  * 430 ERROR_VIO_ILLEGAL_DURING_POPUP
;  * 436 ERROR_VIO_INVALID_HANDLE
;  * 465 ERROR_VIO_DETACHED
;
;*/

.8086
		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc
		INCLUDE	BvsVars.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16


		@BVSPROLOG	BVSGETANSI
VIOHANDLE	DW	?		; Video handle
INDICATOR	DD	?		; Status indicator
		@BVSSTART	BVSGETANSI

		EXTERN	VIOCHECKHANDLE: PROC
		MOV	BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

		PUSH	DS
		PUSH	CS
		POP	DS
		MOV	AX,ANSI_STATE			; GET CURRENT ANSI STATE
		POP	DS
		LES	DI,[DS:BP].ARGS.INDICATOR	; GET POINTER FOR WHERE TO PUT IT
		STOSW					; MOV IT THERE

		XOR	AX,AX				; ALL IS OK

EXIT:
		@BVSEPILOG BVSGETANSI
_TEXT	ENDS
	END


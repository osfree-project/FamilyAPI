;/*!
;   @file
;
;   @brief BvsPrtSc DOS wrapper
;
;   (c) osFree Project 2002-2022, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   * 0   NO_ERROR
;   * 355 ERROR_VIO_MODE
;   * 402 ERROR_VIO_SMG_ONLY
;   * 436 ERROR_VIO_INVALID_HANDLE
;   * 465 ERROR_VIO_DETACHED
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE DOS.INC
		INCLUDE BSEERR.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16


		@BVSPROLOG	BVSPRTSC
VIOHANDLE	DW	?		;Video handle
		@BVSSTART	BVSPRTSC

		EXTERN	VIOCHECKHANDLE: PROC
		MOV     BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

		XOR     AX,AX                    ; ALL IS OK

EXIT:
		@BVSEPILOG	BVSPRTSC

_TEXT		ENDS
		END


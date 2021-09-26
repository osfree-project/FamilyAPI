;/*!
;   @file
;
;   @brief BvsPrtScToggle DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;* 0   NO_ERROR
;* 355 ERROR_VIO_MODE
;* 402 ERROR_VIO_SMG_ONLY
;* 430 ERROR_VIO_ILLEGAL_DURING_POPUP
;* 436 ERROR_VIO_INVALID_HANDLE
;* 465 ERROR_VIO_DETACHED
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE DOS.INC
		INCLUDE BSEERR.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16


		@BVSPROLOG	BVSPRTSCTOGGLE
VIOHANDLE	DW	?		;Video handle
		@BVSSTART	BVSPRTSCTOGGLE

		EXTERN	VIOCHECKHANDLE: PROC
		MOV     BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

		XOR     AX,AX                    ; ALL IS OK

EXIT:
		@BVSEPILOG	BVSPRTSCTOGGLE

_TEXT		ENDS
		END


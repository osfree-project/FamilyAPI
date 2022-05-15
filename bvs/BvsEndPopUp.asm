;/*!
;   @file
;
;   @brief BvsEndPopUp DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;*0 NO_ERROR
;*405 ERROR_VIO_NO_POPUP
;*436 ERROR_VIO_INVALID_HANDLE
;
;*/

.8086
		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16


		@BVSPROLOG	BVSENDPOPUP
VIOHANDLE	DW	?		;Video handle
		@BVSSTART	BVSENDPOPUP

		EXTERN	VIOCHECKHANDLE: PROC
		MOV     BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

		XOR     AX,AX                    ; ALL IS OK

EXIT:
		@BVSEPILOG	BVSENDPOPUP
_TEXT		ENDS
		END


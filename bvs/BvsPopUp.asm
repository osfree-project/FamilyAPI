;/*!
;   @file
;
;   @brief BvsPopUp DOS wrapper
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
;   * 405 ERROR_VIO_NO_POPUP
;   * 406 ERROR_VIO_EXISTING_POPUP
;   * 483 ERROR_VIO_TRANSPARENT_POPUP;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE	BIOS.INC
		INCLUDE BSEERR.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16


		@BVSPROLOG	BVSPOPUP
VIOHANDLE	DW	?		;Video handle
OPTIONS		DD	?		;
		@BVSSTART	BVSPOPUP

		EXTERN	VIOCHECKHANDLE: PROC
		MOV     BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

							; Save screen area
		@SetMode				; Set 80x25 color text mode
		@SetCurPos				; Set cursor to 0,0

		XOR     AX,AX                    ; ALL IS OK

EXIT:
		@BVSEPILOG	BVSPOPUP
_TEXT	ENDS
	END

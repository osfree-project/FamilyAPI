;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioPopUp DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viopopup
;
;*0 NO_ERROR
;*405 ERROR_VIO_NO_POPUP
;*406 ERROR_VIO_EXISTING_POPUP
;*483 ERROR_VIO_TRANSPARENT_POPUP;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16


		@VIOPROLOG	VIOPOPUP
VIOHANDLE	DW	?		;Video handle
OPTIONS		DD	?		;
		@VIOSTART	VIOPOPUP
	        MOV	AX, VI_VIOPOPUP
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK1+2
		AND	AX, HIGHWORD VR_VIOPOPUP
		CMP	AX, HIGHWORD VR_VIOPOPUP
	        CALL    VIOROUTE
		@VIOEPILOG	VIOPOPUP
_TEXT	ENDS
	END

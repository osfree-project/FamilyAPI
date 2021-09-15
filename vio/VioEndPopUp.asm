;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioEndPopUp DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:vioendpopup
;
;*0 NO_ERROR
;*405 ERROR_VIO_NO_POPUP
;*436 ERROR_VIO_INVALID_HANDLE
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16


		@VIOPROLOG	VIOENDPOPUP
VIOHANDLE	DW	?		;Video handle
		@VIOSTART	VIOENDPOPUP
	        MOV	AX, VI_VIOENDPOPUP
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK1+2
		AND	AX, HIGHWORD VR_VIOENDPOPUP
		CMP	AX, HIGHWORD VR_VIOENDPOPUP
	        CALL    VIOROUTE
		@VIOEPILOG	VIOENDPOPUP
_TEXT	ENDS
	END


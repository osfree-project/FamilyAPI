;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioSavRedrawWait DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viosavredrawwait
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16


		@VIOPROLOG	VIOSAVREDRAWWAIT
VIOHANDLE	DW	?		;Video handle
NOTIFYTYPE	DD	?		;
SAVREDRAWINDIC	DW	?		;
		@VIOSTART VIOSAVREDRAWWAIT
	        MOV	AX, VI_VIOSAVREDRAWWAIT
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK1+2
		AND	AX, HIGHWORD VR_VIOSAVREDRAWWAIT
		CMP	AX, HIGHWORD VR_VIOSAVREDRAWWAIT
	        CALL    VIOROUTE
		@VIOEPILOG VIOSAVREDRAWWAIT
_TEXT	ENDS
	END


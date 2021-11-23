;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioSetAnsi DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viosetansi
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC
		INCLUDE	ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOSETANSI
VIOHANDLE	DW	?		;Video handle
INDICATOR	DW	?		;
		@VIOSTART	VIOSETANSI
	        MOV	AX, VI_VIOSETANSI
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK1+2
		AND	AX, HIGHWORD VR_VIOSETANSI
		CMP	AX, HIGHWORD VR_VIOSETANSI
	        CALL    VIOROUTE
		@VIOEPILOG	VIOSETANSI
_TEXT		ENDS
		END


;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioGetAnsi DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viogetansi
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC
		INCLUDE	ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16


		@VIOPROLOG	VIOGETANSI
VIOHANDLE	DW	?		;Video handle
INDICATOR	DD	?		;
		@VIOSTART	VIOGETANSI
	        MOV	AX, VI_VIOGETANSI
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK1+2
		AND	AX, HIGHWORD VR_VIOGETANSI
		CMP	AX, HIGHWORD VR_VIOGETANSI
	        CALL    VIOROUTE
		@VIOEPILOG	VIOGETANSI
_TEXT		ENDS
		END

;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioSetCurType DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viosetcurtype
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC


_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOSETCURTYPE
VIOHANDLE	DW	?		;VIDEO HANDLE
CURINFO		DD	?		;
		@VIOSTART	VIOSETCURTYPE
	        MOV	AX, VI_VIOSETCURTYPE
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK1
		AND	AX, LOWWORD VR_VIOSETCURTYPE
		CMP	AX, LOWWORD VR_VIOSETCURTYPE
	        CALL    VIOROUTE
		@VIOEPILOG	VIOSETCURTYPE
_TEXT		ENDS
		END

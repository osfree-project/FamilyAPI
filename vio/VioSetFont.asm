;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioSetFont DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viosetfont
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOSETFONT
VIOHANDLE	DW	?		;Video handle
REQUESTBLOCK	DD	?		;
		@VIOSTART	VIOSETFONT
	        MOV	AX, VI_VIOSETFONT
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK2
		AND	AX, LOWWORD VR_VIOSETFONT
		CMP	AX, LOWWORD VR_VIOSETFONT
	        CALL    VIOROUTE
		@VIOEPILOG VIOSETFONT
_TEXT		ENDS
		END


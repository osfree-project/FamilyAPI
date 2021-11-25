;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioGetFont DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viogetfont
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC
		INCLUDE	ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOGETFONT
VIOHANDLE	DW	?		;Video handle
REQUESTBLOCK	DD	?		;
		@VIOSTART	VIOGETFONT
	        MOV	AX, VI_VIOGETFONT
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK2
		AND	AX, LOWWORD VR_VIOGETFONT
		CMP	AX, LOWWORD VR_VIOGETFONT
	        CALL    VIOROUTE
		@VIOEPILOG	VIOGETFONT
_TEXT	ENDS
	END


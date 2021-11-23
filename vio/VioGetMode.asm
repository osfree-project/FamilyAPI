;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioGetMode DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viowrtncell
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC
		INCLUDE	ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOGETMODE
VIOHANDLE	DW	?		;Video handle
MODEINFO	DD	?		;
		@VIOSTART	VIOGETMODE
	        MOV	AX, VI_VIOGETMODE
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK1
		AND	AX, LOWWORD VR_VIOGETMODE
		CMP	AX, LOWWORD VR_VIOGETMODE
	        CALL    VIOROUTE
		@VIOEPILOG	VIOGETMODE
_TEXT		ENDS
		END

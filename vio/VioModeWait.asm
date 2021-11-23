;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioModeWait DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viomodewait
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC
		INCLUDE	ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOMODEWAIT
RESERVED	DW	?		;
NOTIFYTYPE	DD	?		;
REQUESTTYPE	DW	?		;
		@VIOSTART VIOMODEWAIT
	        MOV	AX, VI_VIOMODEWAIT
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK2
		AND	AX, LOWWORD VR_VIOMODEWAIT
		CMP	AX, LOWWORD VR_VIOMODEWAIT
	        CALL    VIOROUTE
		@VIOEPILOG VIOMODEWAIT
_TEXT		ENDS
		END


;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioSetState DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viosetstate
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOSETSTATE
VIOHANDLE	DW	?		;Video handle
REQUESTBLOCK	DD	?		;
		@VIOSTART	VIOSETSTATE
	        MOV	AX, VI_VIOSETSTATE
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK2
		AND	AX, LOWWORD VR_VIOSETSTATE
		CMP	AX, LOWWORD VR_VIOSETSTATE
	        CALL    VIOROUTE
		@VIOEPILOG	VIOSETSTATE
_TEXT		ENDS
		END

;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioScrLock DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:vioscrlock
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOSCRLOCK
VIOHANDLE	DW	?
STATUS		DD	?
WAITFLAG	DW	?
		@VIOSTART	VIOSCRLOCK
	        MOV	AX, VI_VIOSCRLOCK
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK1+2
		AND	AX, HIGHWORD VR_VIOSCRLOCK
		CMP	AX, HIGHWORD VR_VIOSCRLOCK
	        CALL    VIOROUTE
		@VIOEPILOG	VIOSCRLOCK

_TEXT		ENDS

		END


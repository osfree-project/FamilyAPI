;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioScrUnLock DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:vioscrunlock
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC
		INCLUDE	ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOSCRUNLOCK
VIOHANDLE	DW	?
		@VIOSTART	VIOSCRUNLOCK
	        MOV	AX, VI_VIOSCRUNLOCK
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK1+2
		AND	AX, HIGHWORD VR_VIOSCRUNLOCK
		CMP	AX, HIGHWORD VR_VIOSCRUNLOCK
	        CALL    VIOROUTE
		@VIOEPILOG	VIOSCRUNLOCK

_TEXT		ENDS

		END

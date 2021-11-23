;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioSetCurPos DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viosetcurpos
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC
		INCLUDE	ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOSETCURPOS
VIOHANDLE	DW	?		;Video handle
COLUMN		DW	?		;Starting column position for output
ROW		DW	?		;Starting row position for output
		@VIOSTART	VIOSETCURPOS
	        MOV	AX, VI_VIOSETCURPOS
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK1
		AND	AX, LOWWORD VR_VIOSETCURPOS
		CMP	AX, LOWWORD VR_VIOSETCURPOS
	        CALL    VIOROUTE
		@VIOEPILOG	VIOSETCURPOS
_TEXT		ENDS
		END

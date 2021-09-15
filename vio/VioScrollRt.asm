;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioScrollRt DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:vioscrollrt
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOSCROLLRT
VIOHANDLE	DW	?
CELL		DD	?
LINES		DW	?
RIGHTCOL	DW	?
BOTROW		DW	?
LEFTCOL		DW	?
TOPROW		DW	?
		@VIOSTART	VIOSCROLLRT
	        MOV	AX, VI_VIOSCROLLRT
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK1+2
		AND	AX, HIGHWORD VR_VIOSCROLLRT
		CMP	AX, HIGHWORD VR_VIOSCROLLRT
	        CALL    VIOROUTE
		@VIOEPILOG	VIOSCROLLRT

_TEXT		ENDS

		END

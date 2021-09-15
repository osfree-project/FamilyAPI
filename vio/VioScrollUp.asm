;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioScrollUp DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:vioscrollup
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOSCROLLUP
VIOHANDLE	DW	?
CELL		DD	?
LINES		DW	?
RIGHTCOL	DW	?
BOTROW		DW	?
LEFTCOL		DW	?
TOPROW		DW	?
		@VIOSTART	VIOSCROLLUP
	        MOV	AX, VI_VIOSCROLLUP
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK1+2
		AND	AX, HIGHWORD VR_VIOSCROLLUP
		CMP	AX, HIGHWORD VR_VIOSCROLLUP
	        CALL    VIOROUTE
		@VIOEPILOG	VIOSCROLLUP

_TEXT		ENDS

		END

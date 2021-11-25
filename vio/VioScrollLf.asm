;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioScrollLf DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:vioscrolllf
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC
		INCLUDE	ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOSCROLLLF
VIOHANDLE	DW	?
CELL		DD	?
LINES		DW	?
RIGHTCOL	DW	?
BOTROW		DW	?
LEFTCOL		DW	?
TOPROW		DW	?
		@VIOSTART	VIOSCROLLLF
	        MOV	AX, VI_VIOSCROLLLF
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK1+2
		AND	AX, HIGHWORD VR_VIOSCROLLLF
		CMP	AX, HIGHWORD VR_VIOSCROLLLF
	        CALL    VIOROUTE
		@VIOEPILOG	VIOSCROLLLF

_TEXT		ENDS

		END

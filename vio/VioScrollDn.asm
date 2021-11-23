;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioScrollDn DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:vioscrolldn
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC
		INCLUDE	ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOSCROLLDN
VIOHANDLE	DW	?
CELL		DD	?
LINES		DW	?
RIGHTCOL	DW	?
BOTROW		DW	?
LEFTCOL		DW	?
TOPROW		DW	?
		@VIOSTART	VIOSCROLLDN
	        MOV	AX, VI_VIOSCROLLDN
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK1+2
		AND	AX, HIGHWORD VR_VIOSCROLLDN
		CMP	AX, HIGHWORD VR_VIOSCROLLDN
	        CALL    VIOROUTE
		@VIOEPILOG	VIOSCROLLDN

_TEXT		ENDS

		END

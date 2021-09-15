;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioSetCP DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viosetcp
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOSETCP
VIOHANDLE	DW	?		;Video handle
CODEPAGEID	DW	?		;
RESERVED	DW	?		;
		@VIOSTART	VIOSETCP
	        MOV	AX, VI_VIOSETCP
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK2
		AND	AX, LOWWORD VR_VIOSETCP
		CMP	AX, LOWWORD VR_VIOSETCP
	        CALL    VIOROUTE
		@VIOEPILOG	VIOSETCP
_TEXT		ENDS
		END

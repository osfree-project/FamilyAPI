;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioGetCP DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viogetcp
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16


		@VIOPROLOG	VIOGETCP
VIOHANDLE	DW	?		;Video handle
CODEPAGEID	DD	?		;
RESERVED	DW	?		;
		@VIOSTART	VIOGETCP
	        MOV	AX, VI_VIOGETCP
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK2
		AND	AX, LOWWORD VR_VIOGETCP
		CMP	AX, LOWWORD VR_VIOGETCP
	        CALL    VIOROUTE
		@VIOEPILOG	VIOGETCP
_TEXT		ENDS
		END


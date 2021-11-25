;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioGetConfig DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viogetconfig
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC
		INCLUDE	ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16


		@VIOPROLOG	VIOGETCONFIG
VIOHANDLE	DW	?		;VIDEO HANDLE
VIOCONFIG	DD	?		;
VIOCONFIGID	DW	?		;
		@VIOSTART	VIOGETCONFIG
	        MOV	AX, VI_VIOGETCONFIG
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK2
		AND	AX, LOWWORD VR_VIOGETCONFIG
		CMP	AX, LOWWORD VR_VIOGETCONFIG
	        CALL    VIOROUTE
		@VIOEPILOG	VIOGETCONFIG
_TEXT		ENDS

		END


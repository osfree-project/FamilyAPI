;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioPrtScToggle DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:vioprtsctoggle
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC
		INCLUDE	ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16


		@VIOPROLOG	VIOPRTSCTOGGLE
VIOHANDLE	DW	?		;Video handle
		@VIOSTART	VIOPRTSCTOGGLE
	        MOV	AX, VI_VIOPRTSCTOGGLE
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK1+2
		AND	AX, HIGHWORD VR_VIOPRTSCTOGGLE
		CMP	AX, HIGHWORD VR_VIOPRTSCTOGGLE
	        CALL    VIOROUTE
		@VIOEPILOG	VIOPRTSCTOGGLE

_TEXT	ENDS
	END


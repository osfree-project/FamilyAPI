;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioModeUndo DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viomodeundo
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC
		INCLUDE	ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOMODEUNDO
Reserved	DW	?	;Reserved (must be zero)		
KillIndic	DW	?	;Terminate indicator
OwnerIndic	DW	?	;Ownership indicator
		@VIOSTART	VIOMODEUNDO
	        MOV	AX, VI_VIOMODEUNDO
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK2
		AND	AX, LOWWORD VR_VIOMODEUNDO
		CMP	AX, LOWWORD VR_VIOMODEUNDO
	        CALL    VIOROUTE
		@VIOEPILOG	VIOMODEUNDO
_TEXT		ENDS
		END


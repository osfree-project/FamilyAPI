;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioWrtNCell DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viowrtncell
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOWRTNCELL
VIOHANDLE	DW	?		;Video handle
COLUMN		DW	?		;Starting column position for output
ROW		DW	?		;Starting row position for output
CTIMES		DW	?		;Repeat count
CELL		DD	?		;Character to be written
		@VIOSTART VIOWRTNCELL
	        MOV	AX, VI_VIOWRTNCELL
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK1
		AND	AX, LOWWORD VR_VIOWRTNCELL
		CMP	AX, LOWWORD VR_VIOWRTNCELL
	        CALL    VIOROUTE
		@VIOEPILOG VIOWRTNCELL
_TEXT	ends
	end
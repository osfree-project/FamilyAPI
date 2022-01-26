;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioSavRedrawUndo DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viosavredrawundo
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC
		INCLUDE	ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16


		@VIOPROLOG	VIOSAVREDRAWUNDO
VIOHANDLE	DW	?		;Video handle
KILLINDIC	DW	?		;
OWNERINDIC	DW	?		;
		@VIOSTART	VIOSAVREDRAWUNDO
		@VIOROUTE	VIOSAVREDRAWUNDO, 1, 2
		@VIOEPILOG	VIOSAVREDRAWUNDO
_TEXT	ENDS
	END


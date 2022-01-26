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
		INCLUDE	ROUTE.INC

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
		@VIOROUTE	VIOSCROLLUP, 1, 2
		@VIOEPILOG	VIOSCROLLUP

_TEXT		ENDS

		END

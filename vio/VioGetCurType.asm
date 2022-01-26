;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioGetCurType DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viogetcurtype
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC
		INCLUDE	ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOGETCURTYPE
VIOHANDLE	DW	?		;VIDEO HANDLE
CURINFO		DD	?		;
		@VIOSTART	VIOGETCURTYPE
		@VIOROUTE	VIOGETCURTYPE, 1, 0
		@VIOEPILOG	VIOGETCURTYPE
_TEXT		ENDS
		END

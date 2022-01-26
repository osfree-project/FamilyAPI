;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioGetState DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viogetstate
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC
		INCLUDE	ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOGETSTATE
VIOHANDLE	DW	?		;VIDEO HANDLE
RequestBlock	DD	?		;
		@VIOSTART	VIOGETSTATE
		@VIOROUTE	VIOGETSTATE, 2, 0
		@VIOEPILOG	VIOGETSTATE

_TEXT		ends
		end

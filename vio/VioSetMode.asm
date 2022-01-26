;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioSetMode DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viosetmode
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC
		INCLUDE	ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOSETMODE
VIOHANDLE	DW	?		;Video handle
MODEDATA	DD	?		;Vide mode info
		@VIOSTART	VIOSETMODE
		@VIOROUTE	VIOSETMODE, 1, 0
		@VIOEPILOG	VIOSETMODE
_TEXT		ENDS
		END

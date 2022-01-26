;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioWrtTTY DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viowrttty
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC
		INCLUDE	ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16
		@VIOPROLOG	VIOWRTTTY
VIOHANDLE	DW	?		;Video handle
SLENGTH		DW	?		;Length of string
CHARSTR		DD	?		;String to be written
		@VIOSTART	VIOWRTTTY
		@VIOROUTE	VIOWRTTTY, 1, 0
		@VIOEPILOG	VIOWRTTTY
        
_TEXT		ENDS

		END

;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioWrtNChar DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viowrtnchar
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC
		INCLUDE	ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOWRTNCHAR
VIOHANDLE	DW	?		;Video handle
COLUMN		DW	?		;Starting column position for output
ROW		DW	?		;Starting row position for output
CTIMES		DW	?		;Repeat count
CHAR		DD	?		;Character to be written
		@VIOSTART	VIOWRTNCHAR
		@VIOROUTE	VIOWRTNCHAR, 1, 0
		@VIOEPILOG	VIOWRTNCHAR
_TEXT		ENDS

		END

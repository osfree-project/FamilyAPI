;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioWrtCellStr DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viowrtcellstr
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC
		INCLUDE	ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOWRTCELLSTR
VIOHANDLE	DW	?		;Video handle
COLUMN		DW	?		;Starting column position for output
ROW		DW	?		;Starting row position for output
SLENGTH		DW	?		;String length
CELLSTR		DD	?		;String to be written
		@VIOSTART	VIOWRTCELLSTR
		@VIOROUTE	VIOSHOWBUF, 1, 2
		@VIOEPILOG	VIOWRTCELLSTR
_TEXT		ENDS

		END

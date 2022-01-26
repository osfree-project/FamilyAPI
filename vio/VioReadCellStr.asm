;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioReadCellStr DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:vioreadcellstr
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC
		INCLUDE	ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOREADCELLSTR
VIOHANDLE	DW	?		;Video handle
COLUMN		DW	?		;Starting column
ROW		DW	?		;Starting row
SLENGTH		DD	?
CELLSTR		DD	?
		@VIOSTART	VIOREADCELLSTR
		@VIOROUTE	VIOREADCELLSTR, 1, 0
		@VIOEPILOG	VIOREADCELLSTR

_TEXT		ENDS
		END

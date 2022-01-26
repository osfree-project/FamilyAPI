;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioShowBuf DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC
		INCLUDE	ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOSHOWBUF
VioHandle	DW	?
SLength		DW	?
SOffset		DW	?
		@VIOSTART	VIOSHOWBUF
		@VIOROUTE	VIOSHOWBUF, 1, 0
		@VIOEPILOG	VIOSHOWBUF

_TEXT		ENDS
		END

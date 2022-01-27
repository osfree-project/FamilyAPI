;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioWrtNAttr DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viowrtnattr
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC
		INCLUDE	ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

@VIOPROC	VIOWRTNATTR, 1, 0, VIOHANDLE DW ?, COLUMN DW ?, ROW DW ?, CTIMES DW ?, ATTR DD ?

_TEXT		ENDS

		END

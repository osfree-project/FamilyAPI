;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosSizeSeg DOS wrapper
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
		INCLUDE DOS.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOS16RSIZESEG
		@START	DOS16RSIZESEG
		XOR		AX,AX
EXIT:
		@EPILOG	DOS16RSIZESEG

_TEXT		ENDS

		END

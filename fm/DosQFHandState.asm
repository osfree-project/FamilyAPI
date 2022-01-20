;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosQFHandState DOS wrapper
;
;   (c) osFree Project 2022, <http://www.osFree.org>
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
		INCLUDE BSEERR.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG DOSQFHANDSTATE
		@START	DOSQFHANDSTATE
		XOR	AX,AX
EXIT:
		@EPILOG DOSQFHANDSTATE

_TEXT		ENDS

		END

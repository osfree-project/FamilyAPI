;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosFlagProcess DOS wrapper
;
;   (c) osFree Project 2022, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSFLAGPROCESS
		@START	DOSFLAGPROCESS

		XOR	AX, AX
EXIT:
		@EPILOG	DOSFLAGPROCESS

_TEXT		ENDS

		END

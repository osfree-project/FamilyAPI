;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosEditName
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
		INCLUDE GLOBALVARS.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSEDITNAME
		@START	DOSEDITNAME
		XOR	AX, AX
EXIT:
		@EPILOG	DOSEDITNAME

_TEXT		ENDS

		END




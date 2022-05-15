;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosOpen2
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
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc
		INCLUDE	GlobalVars.inc


_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSOPEN2
		@START	DOSOPEN2
		XOR		AX, AX
EXIT:
		@EPILOG DOSOPEN2

_TEXT		ENDS

		END

;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosWriteAsync DOS wrapper
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

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSWRITEASYNC
		@START	DOSWRITEASYNC
		XOR	AX,AX
EXIT:
		@EPILOG	DOSWRITEASYNC

_TEXT		ENDS

		END

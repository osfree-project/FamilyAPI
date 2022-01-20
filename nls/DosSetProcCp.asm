;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosSetProcCP DOS wrapper
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
		INCLUDE	bseerr.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSSETPROCCP
		@START	DOSSETPROCCP
		XOR	AX, AX
EXIT:
		@EPILOG	DOSSETPROCCP

_TEXT		ENDS

		END

;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosSendSignal DOS wrapper
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

		@PROLOG	DOSSENDSIGNAL
		@START	DOSSENDSIGNAL

		XOR	AX, AX
EXIT:
		@EPILOG	DOSSENDSIGNAL

_TEXT		ENDS

		END

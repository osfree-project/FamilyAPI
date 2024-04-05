;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosFreeModule
;
;   (c) osFree Project 2024, <http://www.osFree.org>
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
		INCLUDE	bsedos.inc
		INCLUDE	bseerr.inc
		INCLUDE	dos.inc
		INCLUDE	GlobalVars.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSFREEMODULE
MODULEHANDLE	DW	?	;Module handle
		@START	DOSFREEMODULE

		; code here

		XOR	AX, AX
EXIT:
		@EPILOG	DOSFREEMODULE

_TEXT		ENDS

		END

;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosLoadModule
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

		@PROLOG	DOSLOADMODULE
OBJNAMEBUF	DD	?	;Object name buffer (returned)
OBJNAMEBUFL	DW	?	;Length of object name buffer
MODULENAME	DD	?	;Module name string
MODULEHANDLE	DD	?	;Module handle (returned)
		@START	DOSLOADMODULE

		; code here

		XOR	AX, AX
EXIT:
		@EPILOG	DOSLOADMODULE

_TEXT		ENDS

		END

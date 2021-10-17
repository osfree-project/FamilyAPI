;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosGetInfoSeg DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:dosgetinfoseg
;
;  * 0 NO_ERROR
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.inc
		INCLUDE	BSEERR.inc
		INCLUDE	GLOBALVARS.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSGETINFOSEG
GLOBALSEG	DD	?	;Global segment selector (returned)
LOCALSEG	DD	?	;Local segment selector (returned)
		@START	DOSGETINFOSEG
		LES	SI, [DS:BP].ARGS.GLOBALSEG
		MOV	AX, _GINFOSEG
		MOV	[ES:SI], AX
		LES	SI, [DS:BP].ARGS.LOCALSEG
		MOV	AX, _LINFOSEG
		MOV	[ES:SI], AX
		XOR	AX, AX
		@EPILOG	DOSGETINFOSEG

_TEXT		ENDS

		END

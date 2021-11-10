;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosGetVersion wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:dosgetversion
;
;  * 0 NO_ERROR
;
; @todo Replace variables by local instead of global
; @todo Access GIS via structure fields
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE DOS.INC
		INCLUDE GLOBALVARS.INC

EXTERN	DOSGETINFOSEG: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16
GLOBALSEG	DW	?
LOCALSEG	DW	?
		@PROLOG	DOSGETVERSION
VERSIONWORD	DD	?
		@START	DOSGETVERSION
		PUSH	CS
		MOV	AX, OFFSET GLOBALSEG
		PUSH	AX
		PUSH	CS
		MOV	AX, OFFSET LOCALSEG
		PUSH	AX
		CALL	DOSGETINFOSEG
		MOV	AX, GLOBALSEG
		MOV	ES, AX
		MOV	AH, [ES:gis_uchMajorVersion]
		MOV	AL, [ES:gis_uchMinorVersion]
		LES	DI, [DS:BP].ARGS.VERSIONWORD
		MOV	[ES:DI], AX
		XOR	AX, AX
		@EPILOG	DOSGETVERSION

_TEXT		ENDS

		END
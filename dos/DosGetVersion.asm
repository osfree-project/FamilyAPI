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
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
		INCLUDE	GlobalVars.inc

EXTERN	DOSGETINFOSEG: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16
		@PROLOG	DOSGETVERSION
VERSIONWORD	DD	?
@LOCALW		GLOBALSEG
@LOCALW		LOCALSEG
		@START	DOSGETVERSION
		PUSH	SS
		LEA	AX, GLOBALSEG
		PUSH	AX
		PUSH	SS
		LEA	AX, LOCALSEG
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

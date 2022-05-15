;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosGetEnv DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
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
		INCLUDE	GlobalVars.inc

EXTERN	DOSGETINFOSEG: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSGETENV
CMDOFFSET	DD	?
ENVSEGMENT	DD	?
@LOCALW		GLOBALSEG
@LOCALW		LOCALSEG
		@START	DOSGETENV
		PUSH	SS
		LEA	AX, GLOBALSEG
		PUSH	AX
		PUSH	SS
		LEA	AX, LOCALSEG
		PUSH	AX
		CALL	DOSGETINFOSEG
		MOV	AX, LOCALSEG
		MOV	ES, AX
		MOV	CX, [ES:lis_selEnvironment]
		LES	BX,[DS:BP].ARGS.ENVSEGMENT
		MOV	[ES:BX], CX

		MOV	ES, AX
		MOV	CX, [ES:lis_offCmdLine]
		LES	BX,[DS:BP].ARGS.CMDOFFSET
		MOV	[ES:BX], CX

		XOR	AX,AX
		@EPILOG	DOSGETENV

_TEXT		ENDS

		END

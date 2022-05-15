;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosGetSTDA
;
;   (c) osFree Project 2021, <http://www.osFree.org>
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
		INCLUDE	sas.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSGETSTDA
SIZ		DW	?
OFF		DW	?
SEL		DW	?
		@START	DOSGETSTDA
		MOV	AX, [DS:BP].ARGS.SEL
		MOV	ES, AX
		MOV	DI, [DS:BP].ARGS.OFF
;		LDS	SI, SAS.SASRAS
		XOR	AX, AX
		@EPILOG	DOSGETSTDA
_TEXT		ENDS

		END

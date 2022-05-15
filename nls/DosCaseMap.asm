;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosCaseMap DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
; 0 NO_ERROR
; 396 ERROR_NLS_NO_COUNTRY_FILE
; 397 ERROR_NLS_OPEN_FAILED
; 398 ERROR_NO_COUNTRY_OR_CODEPAGE
; 399 ERROR_NLS_TABLE_TRUNCATED
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	bsedos.inc
		INCLUDE	bseerr.inc
		INCLUDE	dos.inc
		INCLUDE	GlobalVars.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSCASEMAP
WLENGTH		DW	?
STRUCTURE	DD	?
BINARYSTRING	DD	?
		@START	DOSCASEMAP
		CMP	DOS33API, 0FFFFH
		JZ	DOS33
		MOV	AX, ERROR_NLS_OPEN_FAILED
		JMP	EXIT
DOS33:
		LES	DI, [DS:BP].ARGS.STRUCTURE

		; это пока заглушка. Здесь надо предоставить буфер, потом в цикле по данным буфера обработать символы
		GET_UPPERCASE_TABLE	[ES:DI].COUNTRYCODE.COUNTRY, [ES:DI].COUNTRYCODE.CODEPAGE, [DS:BP].ARGS.BINARYSTRING, [DS:BP].ARGS.WLENGTH

		XOR	AX, AX
EXIT:
		@EPILOG	DOSCASEMAP

_TEXT		ENDS

		END

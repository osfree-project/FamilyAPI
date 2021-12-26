;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosQSysInfo DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:dosqsysinfo
;
;* 0 NO_ERROR 
;* 87 ERROR_INVALID_PARAMETER
;*111 ERROR_BUFFER_OVERFLOW
;
;@todo Seems support undocumented indexes from 32-bit world. Need to expand later.
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.inc
		INCLUDE	BSEERR.inc
		INCLUDE	GLOBALVARS.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSQSYSINFO
DATABUFLEN	DW	?	;Data buffer size
DATABUF		DD	?	;System information (returned)
INDEX		DW	?	;Which variable
		@START	DOSQSYSINFO
		MOV	AX, [DS:BP].ARGS.INDEX
		CMP	AX, 0
		JZ	@F
INVPARAM:
		MOV	AX, ERROR_INVALID_PARAMETER
		JMP	EXIT
@@:
		MOV	BX, [DS:BP].ARGS.DATABUFLEN
		CMP	BX, 2
		JZ	@F
		JA	INVPARAM

		MOV	AX, ERROR_BUFFER_OVERFLOW
		JMP	EXIT
@@:
		LES	DI, [DS:BP].ARGS.DATABUF
		MOV	AX, [MAXPATHLEN]
		MOV	[ES:DI], AX
		XOR	AX, AX
EXIT:
		@EPILOG	DOSQSYSINFO

_TEXT		ENDS

		END

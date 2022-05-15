;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosQFileMode DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   @todo add dos version check
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
		INCLUDE	GlobalVars.inc
		INCLUDE	bseerr.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSQFILEMODE
FILENAME		DD	?
CURRENTATTRIBUTE	DD	?
RESERVED		DD	?
		@START	DOSQFILEMODE
		MOV	AX,ERROR_INVALID_PARAMETER
		XOR	BX, BX
		CMP	BX, WORD PTR [DS:BP].ARGS.RESERVED
		JNZ	EXIT
		CMP	BX, WORD PTR [DS:BP].ARGS.RESERVED+2
		JNZ	EXIT

		CMP	LFNAPI, 0FFFFH
		JZ	LFN
		CHANGE_MODE [DS:BP].ARGS.FILENAME, 0, 0
		JMP	RESULT
LFN:
		LFN_CHANGE_MODE [DS:BP].ARGS.FILENAME, 0, 0
RESULT:
		LDS	SI,[DS:BP].ARGS.CURRENTATTRIBUTE
		MOV	WORD PTR [SI],CX
		JC	@1F
		XOR	AX,AX
		JMP	EXIT
@1F:
		GET_ERROR
EXIT:
		@EPILOG	DOSQFILEMODE

_TEXT		ENDS

		END


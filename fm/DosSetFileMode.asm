;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosSetFileMode DOS wrapper
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
		INCLUDE	dos.inc
		INCLUDE	GlobalVars.inc
		INCLUDE	bseerr.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG DOSSETFILEMODE
RESERVED	DD	?
NewAttribute	DW	?
FileName	DD	?
		@START DOSSETFILEMODE
		MOV	AX,ERROR_INVALID_PARAMETER

		MOV	BX, WORD PTR [DS:BP].ARGS.RESERVED
		OR	BX, WORD PTR [DS:BP].ARGS.RESERVED+2
		JNZ	EXIT

		CMP	LFNAPI, 0FFFFH
		JZ	LFN
		CHANGE_MODE [DS:BP].ARGS.FileName, 1, [DS:BP].ARGS.NewAttribute
		JMP	ERRCHK
LFN:
		LFN_CHANGE_MODE [DS:BP].ARGS.FileName, 1, [DS:BP].ARGS.NewAttribute
ERRCHK:		JC	EXIT
		XOR	AX, AX
EXIT:
		@EPILOG DOSSETFILEMODE

_TEXT		ENDS

		END

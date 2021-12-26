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
		INCLUDE HELPERS.INC
		INCLUDE DOS.INC
		INCLUDE GLOBALVARS.INC
		INCLUDE	BSEERR.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG DOSSETFILEMODE
FileName	DD	?
NewAttribute	DW	?
RESERVED	DD	?
		@START DOSSETFILEMODE
		MOV	AX,ERROR_INVALID_PARAMETER
		XOR	BX, BX
		CMP	BX, WORD PTR [DS:BP].ARGS.RESERVED
		JNZ	EXIT
		CMP	BX, WORD PTR [DS:BP].ARGS.RESERVED+2
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

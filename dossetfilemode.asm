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

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG DOSSETFILEMODE
FileName	DD	?
NewAttribute	DW	?
Reserved	DD	?
		@START DOSSETFILEMODE
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

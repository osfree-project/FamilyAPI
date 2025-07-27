;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosMove DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
; @todo 8.3 filename check
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc
		INCLUDE	GlobalVars.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSMOVE
RESERVED	DD	?	; [BP+6]
NEWPATHNAME	DD	?	; [BP+10]
OLDPATHNAME	DD	?	; [BP+14]
		@START	DOSMOVE
		MOV	AX,ERROR_INVALID_PARAMETER

		MOV	BX, WORD PTR [BP].ARGS.RESERVED
		OR	BX, WORD PTR [BP].ARGS.RESERVED+2
		JNZ	EXIT
		CMP	LFNAPI, 0FFFFH
		JZ	LFN
		RENAME_FILE	[BP].ARGS.OLDPATHNAME, [BP].ARGS.NEWPATHNAME
		JMP	ERRCHK
LFN:
		LFN_RENAME_FILE	[BP].ARGS.OLDPATHNAME, [BP].ARGS.NEWPATHNAME
ERRCHK:
		JB		EXIT
		XOR		AX,AX
EXIT:
		@EPILOG	DOSMOVE

_TEXT		ENDS

		END

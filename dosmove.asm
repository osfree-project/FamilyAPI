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
; @todo LFN support
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE DOS.INC
		INCLUDE BSEERR.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSMOVE
OLDPATHNAME	DD	?
NEWPATHNAME	DD	?
RESERVED	DD	?
		@START	DOSMOVE
		MOV	AX,ERROR_INVALID_PARAMETER
		XOR	BX, BX
		CMP	BX, WORD PTR [DS:BP].ARGS.RESERVED
		JNZ	EXIT
		CMP	BX, WORD PTR [DS:BP].ARGS.RESERVED+2
		JNZ	EXIT

		RENAME_FILE	[DS:BP].ARGS.OLDPATHNAME, [DS:BP].ARGS.NEWPATHNAME
		JB		EXIT
		XOR		AX,AX
EXIT:
		@EPILOG	DOSMOVE

_TEXT		ENDS

		END

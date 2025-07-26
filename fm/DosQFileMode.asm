;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosQFileMode DOS wrapper
;
;   (c) osFree Project 2018? 2025, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;    0 NO_ERROR
;    2 ERROR_FILE_NOT_FOUND
;    3 ERROR_PATH_NOT_FOUND
;    26 ERROR_NOT_DOS_DISK
;    87 ERROR_INVALID_PARAMETER
;    108 ERROR_DRIVE_LOCKED
;    206 ERROR_FILENAME_EXCED_RANGE
;
; Documentation: https://osfree.org/doku/en:docs:fapi:dosqfilemode
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
RESERVED			DD	?	; [BP+6]
CURRENTATTRIBUTE	DD	?	; [BP+10]
FILENAME			DD	?	; [BP+14]
		@START	DOSQFILEMODE
		MOV		AX,ERROR_INVALID_PARAMETER

		; Check is reserved = 0
		MOV		BX, WORD PTR [BP].ARGS.RESERVED
		OR		BX, WORD PTR [BP].ARGS.RESERVED+2
		JNZ		EXIT

		; Check filename
		LDS		SI,[BP].ARGS.FILENAME
		CALL	CHECK_8_3_FORMAT
		JC		EXIT
		
		@VdmChangeMode	[BP].ARGS.FILENAME, 0
		JC		@F

		LDS		SI,[BP].ARGS.CURRENTATTRIBUTE
		MOV		WORD PTR [SI],CX
		XOR		AX,AX
	 	JMP		EXIT
@@:
;		CALL CONVERT_DOS_ERROR           ; Map DOS error to OS/2 ErrorClass
EXIT:
		@EPILOG	DOSQFILEMODE

_TEXT		ENDS

		END


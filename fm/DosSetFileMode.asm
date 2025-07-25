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
NEWATTRIBUTE	DW	?
FILENAME	DD	?
		@START DOSSETFILEMODE
		MOV	AX,ERROR_INVALID_PARAMETER

		; Check reserved is 0
		MOV	BX, WORD PTR [DS:BP].ARGS.RESERVED
		OR	BX, WORD PTR [DS:BP].ARGS.RESERVED+2
		JNZ	EXIT
		
		; Check filename
		PUSH	DS
		LDS		SI,[DS:BP].ARGS.FILENAME
		CALL	CHECK_8_3_FORMAT
		POP		DS
		JC		EXIT		

		@VdmChangeMode [DS:BP].ARGS.FILENAME, 1, [DS:BP].ARGS.NEWATTRIBUTE
		JC	@F
		XOR	AX, AX
		JMP	EXIT
@@:
;		CALL CONVERT_DOS_ERROR           ; Map DOS error to OS/2 ErrorClass
EXIT:
		@EPILOG DOSSETFILEMODE

_TEXT		ENDS

		END

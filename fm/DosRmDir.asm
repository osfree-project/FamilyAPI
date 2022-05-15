;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosRmDir DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;
;--------D-213A-------------------------------
;INT 21 - DOS 2+ - "RMDIR" - REMOVE SUBDIRECTORY
;        AH = 3Ah
;        DS:DX -> ASCIZ pathname of directory to be removed
;Return: CF clear if successful
;            AX destroyed
;        CF set on error
;            AX = error code (03h,05h,06h,10h) (see #01680 at AH=59h/BX=0000h)
;Notes:  directory must be empty (contain only '.' and '..' entries)
;        under the FlashTek X-32 DOS extender, the pointer is in DS:EDX
;SeeAlso: AH=39h,AH=3Bh,AX=713Ah,AH=E2h/SF=0Bh,INT 2F/AX=1101h,INT 60/DI=0512h
;
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
		INCLUDE	GlobalVars.inc
		INCLUDE	bseerr.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSRMDIR
DIRNAME		DD	?
RESERVED	DD	?
		@START	DOSRMDIR
		MOV	AX,ERROR_INVALID_PARAMETER
		XOR	BX, BX
		CMP	BX, WORD PTR [DS:BP].ARGS.RESERVED
		JNZ	EXIT
		CMP	BX, WORD PTR [DS:BP].ARGS.RESERVED+2
		JNZ	EXIT

		CMP	LFNAPI, 0FFFFH
		JZ	LFN
		REM_DIR  [DS:BP].ARGS.DIRNAME
		JMP	ERRCHK
LFN:
		LFN_REM_DIR  [DS:BP].ARGS.DIRNAME
ERRCHK:
		JC	EXIT
		XOR	AX, AX
EXIT:
		@EPILOG	DOSRMDIR

_TEXT		ENDS

		END

;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosChDir DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
; Errors:
;  0 NO_ERROR
;  2 ERROR_FILE_NOT_FOUND
;  3 ERROR_PATH_NOT_FOUND
;  5 ERROR_ACCESS_DENIED
;  8 ERROR_NOT_ENOUGH_MEMORY
;  26 ERROR_NOT_DOS_DISK
;  87 ERROR_INVALID_PARAMETER
;  108 ERROR_DRIVE_LOCKED
;  206 ERROR_FILENAME_EXCED_RANGE
;
;--------D-213B-------------------------------
;INT 21 - DOS 2+ - "CHDIR" - SET CURRENT DIRECTORY
;        AH = 3Bh
;        DS:DX -> ASCIZ pathname to become current directory (max 64 bytes)
;Return: CF clear if successful
;            AX destroyed
;        CF set on error
;            AX = error code (03h) (see #01680 at AH=59h/BX=0000h)
;Notes:  if new directory name includes a drive letter, the default drive is
;          not changed, only the current directory on that drive
;        changing the current directory also changes the directory in which
;          FCB file calls operate
;        under the FlashTek X-32 DOS extender, the pointer is in DS:EDX
;SeeAlso: AH=47h,AX=713Bh,INT 2F/AX=1105h
;
;
;*/
;
; @todo Add 8.3 filename check
;
.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc
		INCLUDE	GlobalVars.inc

_TEXT	SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSCHDIR
RESERVED	DD	?		; [BP+6]
DIRNAME		DD	?		; [BP+10]
		@START	DOSCHDIR
		
		MOV		AX,ERROR_INVALID_PARAMETER

		; Check reserved is 0
		MOV		BX, WORD PTR [BP].ARGS.RESERVED
		OR		BX, WORD PTR [BP].ARGS.RESERVED+2
		JNZ		EXIT

		; Check path length
		LDS		SI, [BP].ARGS.DIRNAME
		CALL	CHECK_PATH_FORMAT
		JC		EXIT                           ; Jump if invalid format
	
		@VdmChDir	[BP].ARGS.DIRNAME
		JC		EXIT			; Error
		XOR		AX, AX
EXIT:
		@EPILOG	DOSCHDIR

_TEXT	ENDS

		END


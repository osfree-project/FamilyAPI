;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosDelete DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
; @todo add filename check
;
;--------D-2141-------------------------------
;INT 21 - DOS 2+ - "UNLINK" - DELETE FILE
;        AH = 41h
;        DS:DX -> ASCIZ filename (no wildcards, but see notes)
;        CL = attribute mask for deletion (server call only, see notes)
;Return: CF clear if successful
;            AX destroyed (DOS 3.3) AL seems to be drive of deleted file
;        CF set on error
;            AX = error code (02h,03h,05h) (see #01680 at AH=59h/BX=0000h)
;Notes:  (DOS 3.1+) wildcards are allowed if invoked via AX=5D00h, in which case
;          the filespec must be canonical (as returned by AH=60h), and only
;          files matching the attribute mask in CL are deleted
;        DR DOS 5.0-6.0 returns error code 03h if invoked via AX=5D00h; DR DOS
;          3.41 crashes if called via AX=5D00h with wildcards
;        DOS does not erase the file's data; it merely becomes inaccessible
;          because the FAT chain for the file is cleared
;        deleting a file which is currently open may lead to filesystem
;          corruption.  Unless SHARE is loaded, DOS does not close the handles
;          referencing the deleted file, thus allowing writes to a nonexistant
;          file.
;        under DR DOS and DR Multiuser DOS, this function will fail if the file
;          is currently open
;        under the FlashTek X-32 DOS extender, the pointer is in DS:EDX
;BUG:    DR DOS 3.41 crashes if called via AX=5D00h
;SeeAlso: AH=13h,AX=4301h,AX=4380h,AX=5D00h,AH=60h,AX=7141h,AX=F244h
;SeeAlso: INT 2F/AX=1113h
;
;INT 21 - Windows95 - LONG FILENAME - DELETE FILE
;
;	AX = 7141h
;	DS:DX -> ASCIZ long name of file to delete
;	SI = wildcard and attributes flag
;		0000h wildcards are not allowed, and search attributes are
;			ignored
;		0001h wildcards are allowed, and only files with matching
;			names and attributes are deleted
;	CL = search attributes
;	CH = must-match attributes
;Return: CF clear if successful
;	CF set on error
;	    AX = error code (see #01680)
;		7100h if function not supported
;Note:	for compatibility with DOS versions prior to v7.00, the carry flag
;	  should be set on call to ensure that it is set on exit
;SeeAlso: AH=41h
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc
		INCLUDE	GlobalVars.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSDELETE
RESERVED	DD	?	; [BP+6]
FILENAME	DD	?	; [BP+10]
		@START	DOSDELETE

		MOV	AX,ERROR_INVALID_PARAMETER

		MOV	BX, WORD PTR [BP].ARGS.RESERVED
		OR	BX, WORD PTR [BP].ARGS.RESERVED+2
		JNZ	EXIT

		CMP	LFNAPI, 0FFFFH
		JZ	LFN
		DELETE_ENTRY [BP].ARGS.FILENAME
		JMP	ERRCHECK
LFN:
		LFN_DELETE_ENTRY [BP].ARGS.FILENAME
ERRCHECK:
		JC	EXIT 
		XOR	AX, AX
EXIT:
		@EPILOG	DOSDELETE

_TEXT		ENDS

		END


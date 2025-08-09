;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosBufReset DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;  Documentation: 
;
; Errors:
; 2 ERROR_FILE_NOT_FOUND
; 5 ERROR_ACCESS_DENIED
; 6 ERROR_INVALID_HANDLE
;
; --------D-2168-------------------------------
;INT 21 - DOS 3.3+ - "FFLUSH" - COMMIT FILE
;        AH = 68h
;        BX = file handle
;Return: CF clear if successful
;            all data still in DOS disk buffers is written to disk immediately,
;              and the file's directory entry is updated
;        CF set on error
;            AX = error code (see #01680 at AH=59h/BX=0000h)
;SeeAlso: AX=5D01h,AH=6Ah,INT 2F/AX=1107h
;
;--------D-2130-------------------------------
;INT 21 - DOS 2+ - GET DOS VERSION
;        AH = 30h
;---DOS 5+ ---
;        AL = what to return in BH
;            00h OEM number (see #01394)
;            01h version flag
;Return: AL = major version number (00h if DOS 1.x)
;        AH = minor version number
;        BL:CX = 24-bit user serial number (most versions do not use this)
;---if DOS <5 or AL=00h---
;        BH = MS-DOS OEM number (see #01394)
;---if DOS 5+ and AL=01h---
;        BH = version flag
;            bit 3: DOS is in ROM
;            other: reserved (0)
;
;--------D-210D-------------------------------
;INT 21 - DOS 1+ - DISK RESET
;        AH = 0Dh
;Return: (DOS 6 only) CF clear (earlier versions preserve CF)
;Notes:  This function writes all modified disk buffers to disk, but does not
;          update the directory information (that is only done when files are
;          closed or a SYNC call is issued)
;SeeAlso: AX=5D01h,AX=710Dh,INT 13/AH=00h,INT 2F/AX=1120h
;
;--------D-2145-------------------------------
;INT 21 - DOS 2+ - "DUP" - DUPLICATE FILE HANDLE
;        AH = 45h
;        BX = file handle
;Return: CF clear if successful
;            AX = new handle
;        CF set on error
;            AX = error code (04h,06h) (see #01680 at AH=59h/BX=0000h)
;Notes:  moving file pointer for either handle will also move it for the other,
;          because both will refer to the same system file table
;        for DOS versions prior to 3.3, file writes may be forced to disk by
;          duplicating the file handle and closing the duplicate
;SeeAlso: AH=3Dh,AH=46h
;
;--------D-213E-------------------------------
;INT 21 - DOS 2+ - "CLOSE" - CLOSE FILE
;        AH = 3Eh
;        BX = file handle
;Return: CF clear if successful
;            AX destroyed
;        CF set on error
;            AX = error code (06h) (see #01680 at AH=59h/BX=0000h)
;Notes:  if the file was written to, any pending disk writes are performed, the
;          time and date stamps are set to the current time, and the directory
;          entry is updated
;        recent versions of DOS preserve AH because some versions of Multiplan
;          had a bug which depended on AH being preserved
;SeeAlso: AH=10h,AH=3Ch,AH=3Dh,INT 2F/AX=1106h,INT 2F/AX=1227h
;
;-------------------------------------------------------------------
;INT 21 - Windows95 - RESET DRIVE
;
;	AX = 710Dh
;	CX = action (see #01777)
;	DX = drive number
;Return: CF clear
;Note:	for compatibility with DOS versions prior to v7.00, the carry flag
;	  should be set on call to ensure that it is set on exit
;SeeAlso: AH=0Dh
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc

		INCLUDE	dos.inc
		INCLUDE	GlobalVars.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSBUFRESET
FILEHANDLE	DW	?	; [BP+6]
		@START	DOSBUFRESET

		MOV	BX, [BP].ARGS.FILEHANDLE	;HANDLE == 0FFFFH?

		INC	BX
		JE	DISKRESET			; YES, flush all files
		DEC	BX
		CMP	DOS33API, 0FFFFH
		JE	DOS33				; 3.3+ support flush directly
		CMP	DOS3API, 0FFFFH
		JE	DOS3
DISKRESET:
		@VdmResetDisk		; @todo Here is some question. LFN version resets current disk.

		;RESET_DISK		; @todo After this call we also need to close all files to flush directory entries
		;LFN_RESET_DISK disk	; @todo Here we need to process all disks

		JMP	DONE
DOS3:
		XDUP	[BP].ARGS.FILEHANDLE
		JB	DISKRESET
		CLOSE_HANDLE AX
		JMP	DONE
DOS33:					;DOS 3.3+
		FLUSH   [BP].ARGS.FILEHANDLE
		JC	EXIT		; error, error code is same as in os/2
DONE:
		XOR	AX,AX
EXIT:
		@EPILOG	DOSBUFRESET

_TEXT		ENDS

		END


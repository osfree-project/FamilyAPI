;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosQFSInfo DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;* 0          NO_ERROR 
;* 15         ERROR_INVALID_DRIVE 
;* 111        ERROR_BUFFER_OVERFLOW 
;* 124        ERROR_INVALID_LEVEL
;* 125        ERROR_NO_VOLUME_LABEL
;
;Input
;      AH = 36h
;      DL = drive number (00h = default, 01h = A:, etc)
;Return
;AX = FFFFh if invalid drive
;
;      else
;          AX = sectors per cluster
;          BX = number of free clusters
;          CX = bytes per sector
;          DX = total clusters on drive
;
;------------------------------------------------------------------------
;
;Input
;      AH = 1Ch
;      DL = drive (00h = default, 01h = A:, etc)
;Edit
;Return
;      AL = sectors per cluster (allocation unit), or FFh if invalid drive
;      CX = bytes per sector
;      DX = total number of clusters
;      DS:BX -> media ID byte (see #01356)
; FFh	floppy, double-sided, 8 sectors per track (320K)
; FEh	floppy, single-sided, 8 sectors per track (160K)
; FDh	floppy, double-sided, 9 sectors per track (360K)
; FCh	floppy, single-sided, 9 sectors per track (180K)
; FAh	HP 200LX D: ROM disk, 16 sectors per track (995K)
;	HP 200LX E: (Stacker host drive ???)
; F9h	floppy, double-sided, 15 sectors per track (1.2M)
;	floppy, double-sided, 9 sectors per track (720K,3.5")
; F8h	hard disk
; F0h	other media
;	(e.g. floppy, double-sized, 18 sectors per track -- 1.44M,3.5")
;
;---------------------------------------------------------------------------
;INT 21 - Windows95 - FAT32 - GET EXTENDED FREE SPACE ON DRIVE
;
;	AX = 7303h
;	DS:DX -> ASCIZ string for drive ("C:\" or "\\SERVER\Share")
;	ES:DI -> buffer for extended free space structure (see #01789)
;	CX = length of buffer for extended free space
;Return: CF clear if successful
;	    ES:DI buffer filled
;	CF set on error
;	    AX = error code
;Notes:	on DOS versions which do not support the FAT32 calls, this function
;	  returns CF clear/AL=00h (which is the DOS v1+ method for reporting
;	  unimplemented functions)
;	under DOS 7.x (i.e. "MSDOS Mode" under Windows95), the ASCIZ string
;	  pointed at by DS:DX *must* include the drive letter, or this function
;	  will return CF set/AX=0015h (invalid drive).	In a DOS box, omitting
;	  the drive letter (DS:DX -> "\") results in the free space for the
;	  current default drive, as expected
;BUG:	this function returns a maximum of 2GB free space even on an FAT32
;	  partition larger than 2GB under some versions of Win95 and Win98,
;	  apparently by limiting the number of reported free clusters to no
;	  more than 64K -- but only in a DOS window if a TSR has hooked INT 21h
;SeeAlso: AX=7302h,AX=7304h,AX=7305h,AH=36h
;
;
;------------------------------------------
;== 6. Determine the presence of the FAT32 API ==
;	 mov	ax,7302h	;extended get DPB
;	 mov	dl,0		;current drive
;	 mov	cx,3fh		;length of buffer
;	 mov	di,ofs truename_buf;buffer
;	 stc			;for pre-DOS7
;	 int	21h
;	 jnc	@@ext
; -On Win95 4.00.950, it always fails with AX=1
; -	 cmp	ax,7300h	;did it fail because there's no such call?
; -	 jne	@@ext		;no, it didn't like the drive
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc
		INCLUDE	GlobalVars.inc

FSINFO1		STRUC
FILESYSID	DD	?	;(ULONG) - FILE SYSTEM ID.
SECTORNUM	DD	?	;(ULONG) - NUMBER OF SECTORS PER ALLOCATION UNIT.
UNITNUM		DD	?	;(ULONG) - NUMBER OF ALLOCATION UNITS.
UNITAVAIL	DD	?	;(ULONG) - NUMBER OF ALLOCATION UNITS AVAILABLE.
BYTESNUM	DW	?	;(USHORT) - NUMBER OF BYTES PER SECTOR.
FSINFO1		ENDS

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSQFSINFO
FSINFOBUFSIZE	DW ?
FSINFOBUF	DD ?
FSINFOLEVEL	DW ?
DRIVENUMBER	DW ?
		@START DOSQFSINFO
		MOV	AX, [DS:BP].ARGS.FSINFOLEVEL
		CMP	AX, 1
		JZ	LVL1
		CMP	AX, 2
		JZ	LVL2
		MOV	AX, ERROR_INVALID_LEVEL
		JMP	EXIT

LVL1:		;@todo check is drive has FAT32 API support, if so, use it
		MOV	AH, 36H
		MOV	DX, [DS:BP].ARGS.DRIVENUMBER
		INT	21H
		CMP	AX, 0FFFFH
		JNZ	LVL1_1
		MOV	AX, ERROR_INVALID_DRIVE
		JMP	EXIT

LVL1_1:		LES	DI, [DS:BP].ARGS.FSINFOBUF

		MOV	WORD PTR [ES:DI].FSINFO1.SECTORNUM, AX
		XOR	AX, AX
		MOV	WORD PTR [ES:DI].FSINFO1.SECTORNUM+2, AX

		MOV	WORD PTR [ES:DI].FSINFO1.FILESYSID, AX
		MOV	WORD PTR [ES:DI].FSINFO1.FILESYSID+2, AX

		MOV	WORD PTR [ES:DI].FSINFO1.UNITNUM, DX
		MOV	WORD PTR [ES:DI].FSINFO1.UNITNUM+2, AX

		MOV	WORD PTR [ES:DI].FSINFO1.UNITAVAIL, BX
		MOV	WORD PTR [ES:DI].FSINFO1.UNITAVAIL+2, AX

		MOV	WORD PTR [ES:DI].FSINFO1.BYTESNUM, CX

		JMP	EXIT
LVL2:

EXIT:
		@EPILOG DOSQFSINFO

_TEXT		ENDS

		END

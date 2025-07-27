;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosChgFilePtr DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;0 NO_ERROR
;1 ERROR_INVALID_FUNCTION
;6 ERROR_INVALID_HANDLE
;
;--------D-2142-------------------------------
;INT 21 - DOS 2+ - "LSEEK" - SET CURRENT FILE POSITION
;        AH = 42h
;        AL = origin of move
;            00h start of file
;            01h current file position
;            02h end of file
;        BX = file handle
;        CX:DX = (signed) offset from origin of new file position
;Return: CF clear if successful
;            DX:AX = new file position in bytes from start of file
;        CF set on error
;            AX = error code (01h,06h) (see #01680 at AH=59h/BX=0000h)
;Notes:  for origins 01h and 02h, the pointer may be positioned before the
;          start of the file; no error is returned in that case (except under
;          Windows NT), but subsequent attempts at I/O will produce errors
;        if the new position is beyond the current end of file, the file will
;          be extended by the next write (see AH=40h); for FAT32 drives, the
;          file must have been opened with AX=6C00h with the "extended size"
;          flag in order to expand the file beyond 2GB
;BUG:    using this method to grow a file from zero bytes to a very large size
;          can corrupt the FAT in some versions of DOS; the file should first
;          be grown from zero to one byte and then to the desired large size
;SeeAlso: AH=24h,INT 2F/AX=1228h
;
; @todo because of various bugs need to add arguments checks
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSCHGFILEPTR
NEWPOINTER	DD	?	; [BP+6]
MOVETYPE	DW	?	; [BP+10]
DISTANCE	DD	?	; [BP+12]
FILEHANDLE	DW	?	; [BP+16]
		@START	DOSCHGFILEPTR

		MOV	AX, [BP].ARGS.MOVETYPE
		MOVE_PTR [BP].ARGS.FILEHANDLE, WORD PTR [BP].ARGS.DISTANCE+2, WORD PTR [BP].ARGS.DISTANCE, AL
		JB	EXIT
		LDS	BX,[BP].ARGS.NEWPOINTER
		MOV	[BX+0],AX
		MOV	[BX+2],DX
		XOR	AX,AX
EXIT:
		@EPILOG	DOSCHGFILEPTR

_TEXT		ENDS

		END

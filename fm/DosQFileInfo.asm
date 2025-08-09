;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosQFileInfo DOS wrapper
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
		INCLUDE	GlobalVars.inc
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc

LEVEL1 struct
filedate dw ?
filetime dw ?
fileaccdate dw ?
fileacctime dw ?
writaccdate dw ?
writacctime dw ?
filesize dd ?
filealloc dd ?
fileattrib dw ?
LEVEL1 ends

LEVEL2 struct
	LEVEL1 <>
cbList dw ?
LEVEL2 ends

LEVEL3 struct
       dw ?
LEVEL3 ends

_TEXT	segment	byte public 'CODE'

       @PROLOG  DOSQFILEINFO
BUFFERSIZE  DW  ?       ; [BP+14]
BUFFER      DD  ?       ; [BP+10]
INFOLEVEL   DW  ?       ; [BP+8]
HANDLE      DW  ?       ; [BP+6]
@LOCALD		DWOLDPOS
        @START  DOSQFILEINFO

		CMP		DOS1020API, 0FFFFH
		JB		OLDDOS

;INT 21 - OS/2 v1.1+ Family API - DosQFileInfo
;
;	AX = 5702h
;	BX = file handle
;	CX = size of buffer for information
;	DX = level of information
;	    0001h standard file information (see #01672)
;	    0002h Query EA Size (see #01672)
;	    0003h Query EAs from List (see #01673)
;	    0004h Query All EAs (see #01673)
;	ES:DI -> buffer for information (see #01672,#01673)
;Return: CF clear if successful
;	CF set on error
;	    AX = error code
;SeeAlso: AX=5702h/BX=FFFFh,AX=5703h"OS/2",AH=6Dh"OS/2"

		MOV		AX, 05702H
		MOV		BX, [BP].ARGS.HANDLE
		MOV		DX, [BP].ARGS.INFOLEVEL
		LES		DI, [BP].ARGS.BUFFER
		MOV		CX, [BP].ARGS.BUFFERSIZE
		INT		21H
		JC		DOS_ERROR
		XOR		AX, AX
		JMP		EXIT
		
OLDDOS:
		; Check infolevel
        MOV     AX, [BP].ARGS.INFOLEVEL
        CMP     AX, 1
        JNE     INVALID_LEVEL

        ; Validate buffer size (LEVEL1 = 22 bytes)
        CMP     [BP].ARGS.BUFFERSIZE, 22
        JB      BUFFER_TOO_SMALL
		
       ; Set buffer pointer
        LDS     SI, [BP].ARGS.BUFFER

        ; Get last write date/time
		GET_SET_DATE_TIME [BP].ARGS.HANDLE, 0, 0, 0
        JC      DOS_ERROR
        MOV     [SI].LEVEL1.WRITACCDATE, DX
        MOV     [SI].LEVEL1.WRITACCTIME, CX
		
        ; Get last access date/time (fallback to write time if unsupported)
        GET_SET_DATE_TIME [BP].ARGS.HANDLE, 4, 0, 0
        JC      USE_WRITE_TIME_ACCESS
        MOV     [SI].LEVEL1.FILEACCDATE, DX
        MOV     [SI].LEVEL1.FILEACCTIME, CX
        JMP     GET_CREATION_TIME
USE_WRITE_TIME_ACCESS:
        MOV     DX, [SI].LEVEL1.WRITACCDATE
        MOV     CX, [SI].LEVEL1.WRITACCTIME
        MOV     [SI].LEVEL1.FILEACCDATE, DX
        MOV     [SI].LEVEL1.FILEACCTIME, CX

GET_CREATION_TIME:
        ; Get creation date/time (fallback to write time if unsupported)
        GET_SET_DATE_TIME [BP].ARGS.HANDLE, 6, 0, 0
        JC      USE_WRITE_TIME_CREATION
        MOV     [SI].LEVEL1.FILEDATE, DX
        MOV     [SI].LEVEL1.FILETIME, CX
        JMP     GET_FILE_SIZE
USE_WRITE_TIME_CREATION:
        MOV     DX, [SI].LEVEL1.WRITACCDATE
        MOV     CX, [SI].LEVEL1.WRITACCTIME
        MOV     [SI].LEVEL1.FILEDATE, DX
        MOV     [SI].LEVEL1.FILETIME, CX
		
GET_FILE_SIZE:
        ; Save current file position
        MOVE_PTR [BP].ARGS.HANDLE, 0, 0, 1; SEEK_CUR
        JC      DOS_ERROR
        MOV     WORD PTR DWOLDPOS, AX
        MOV     WORD PTR DWOLDPOS+2, DX

        ; Get file size (move to end)
        MOVE_PTR [BP].ARGS.HANDLE, 0, 0, 2;SEEK_END
        JC      SIZE_ERROR
        MOV     WORD PTR [SI].LEVEL1.FILESIZE, AX
        MOV     WORD PTR [SI].LEVEL1.FILESIZE+2, DX
        MOV     WORD PTR [SI].LEVEL1.FILEALLOC, AX
        MOV     WORD PTR [SI].LEVEL1.FILEALLOC+2, DX

RESTORE_POS:
        ; Restore original file position
        MOVE_PTR [BP].ARGS.HANDLE, WORD PTR DWOLDPOS+2, WORD PTR DWOLDPOS, 0;SEEK_SET
        JC      DOS_ERROR

        ; Set default attributes (DOS handles don't provide this)
        MOV     [SI].LEVEL1.FILEATTRIB, 0
        XOR     AX, AX
        JMP     EXIT

SIZE_ERROR:
        ; Zero size on error and try to restore position
        MOV     WORD PTR [SI].LEVEL1.FILESIZE, 0
        MOV     WORD PTR [SI].LEVEL1.FILESIZE+2, 0
        MOV     WORD PTR [SI].LEVEL1.FILEALLOC, 0
        MOV     WORD PTR [SI].LEVEL1.FILEALLOC+2, 0
        JMP     RESTORE_POS
		
INVALID_LEVEL:
        MOV     AX, ERROR_INVALID_LEVEL
        JMP     EXIT

BUFFER_TOO_SMALL:
        MOV     AX, ERROR_BUFFER_OVERFLOW
        JMP     EXIT
		
DOS_ERROR:
        CALL    CONVERT_DOS_ERROR
EXIT:
    
		@EPILOG DOSQFILEINFO

_TEXT	ends

	end

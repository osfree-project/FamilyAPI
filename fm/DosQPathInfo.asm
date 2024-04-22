;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosQPathInfo DOS wrapper
;
;   (c) osFree Project 2022,2024, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:dosqpathinfo
;
; 0 NO_ERROR
; 3 ERROR_PATH_NOT_FOUND
; 32 ERROR_SHARING_VIOLATION
; 111 ERROR_BUFFER_OVERFLOW
; 124 ERROR_INVALID_LEVEL
; 206 ERROR_FILENAME_EXCED_RANGE
; 254 ERROR_INVALID_EA_NAME
; 255 ERROR_EA_LIST_INCONSISTENT
;
;
; @todo LFN support
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

FDATE   struc
  fdate_fs  dw  ?
FDATE   ends
 
FTIME   struc
  ftime_fs  dw  ?
FTIME   ends
 
FILESTATUS struc
  fsts_fdateCreation   dw (size FDATE)/2 dup (?) ;date of file creation
  fsts_ftimeCreation   dw (size FTIME)/2 dup (?) ;time of file creation
  fsts_fdateLastAccess dw (size FDATE)/2 dup (?) ;date of last access
  fsts_ftimeLastAccess dw (size FTIME)/2 dup (?) ;time of last access
  fsts_fdateLastWrite  dw (size FDATE)/2 dup (?) ;date of last write
  fsts_ftimeLastWrite  dw (size FTIME)/2 dup (?) ;time of last write
  fsts_cbFile          dd  ? ;file size (end of data)
  fsts_cbFileAlloc     dd  ? ;file allocated size
  fsts_attrFile        dw  ? ;attributes of the file
FILESTATUS ends

		@PROLOG	DOSQPATHINFO
RESERVED	DD	?	;Reserved (must be zero)
PATHNAME        DD	?	;File or directory path name string
PATHINFOLEVEL   DW	?	;Data required
PATHINFOBUF     DD	?	;Data buffer (returned)
PATHINFOBUFSIZE DW	?	;Data buffer size
		@START	DOSQPATHINFO
		
		; Get current DTA
		@GetDTA
		MOV	WORD PTR [OldBuffer], BX
		MOV	WORD PTR [OldBuffer+2], ES

		; Check Reserved = 0
		MOV	AX, ERROR_INVALID_PARAMETER
		XOR	BX,BX
		CMP	BX, WORD PTR [DS:BP].ARGS.RESERVED
		JNE	EXIT
		CMP	BX, WORD PTR [DS:BP].ARGS.RESERVED+2
		JNE	EXIT
		
		; Check InfoLevel = 1
		MOV	AX, ERROR_INVALID_LEVEL
		CMP	WORD PTR [DS:BP].ARGS.PATHINFOLEVEL, 1
		JNE	EXIT

		;Set our DTA
		@SetDTA	Buffer, CS

;AH = 4Eh
;AL = special flag for use by APPEND (refer to note below)
;CX = file attribute mask (see #01420 at AX=4301h) (bits 0 and 5 ignored)
;    0088h (Novell DOS 7) find first deleted file
;DS:DX -> ASCIZ file specification (may include path and wildcards)

		;Find path (readonly+hidden+system+directory+archive)
		LDS	DX, [DS:BP].ARGS.PATHNAME
		MOV	CX, 1+2+4+16+32
		@GetFirst
		MOV	AX, ERROR_PATH_NOT_FOUND
		JC	EXIT

		;Copy data
		; Buffer[15] - attributes
		LES	BX, [DS:BP].ARGS.PATHINFOBUF
		XOR	AX, AX
		MOV	AL, [Buffer+15]
		MOV	[ES:BX].FILESTATUS.fsts_attrFile, AX
		
		JMP	EXIT

OldBuffer	DD	?
Buffer		DB	43h DUP (?)

EXIT:
		;Restore DTA
		LES	BX, CS:[OldBuffer]
		@SetDTA
		
		@EPILOG	DOSQPATHINFO

_TEXT		ENDS

		END

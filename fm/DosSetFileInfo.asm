;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosSetFileInfo DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
; @todo check buffer size using Fileinfobuffersize
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc

LEVEL1 struct
FILEDATE DW ?
FILETIME DW ?
FILEACCDATE DW ?
FILEACCTIME DW ?
WRITACCDATE DW ?
WRITACCTIME DW ?
;FILESIZE DD ?
;FILEALLOC DD ?
;FILEATTRIB DW ?
LEVEL1 ends

LEVEL2 struct
	LEVEL1 <>
CBLIST DW ?
LEVEL2 ends

LEVEL3 struct
       DW ?
LEVEL3 ends

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSSETFILEINFO
FILEHANDLE	DW	?
FILEINFOLEVEL	DW	?
FILEINFOBUF	DD	?
FILEINFOBUFSIZE	DW	?
		@START	DOSSETFILEINFO
	MOV AX,[DS:BP].ARGS.FILEINFOLEVEL
	LDS SI,[DS:BP].ARGS.FILEINFOBUF
	CMP AX,1
	JZ LEV1
;	 CMP AX,2
;	 JZ LEV2
;	 CMP AX,3
;	 JZ LEV3
	MOV AX, ERROR_INVALID_LEVEL
	JMP EXIT
LEV1:
	GET_SET_DATE_TIME [DS:BP].ARGS.FILEHANDLE, 1, [SI].LEVEL1.WRITACCTIME, [SI].LEVEL1.WRITACCDATE
	JC EXIT
	GET_SET_DATE_TIME [DS:BP].ARGS.FILEHANDLE, 5, [SI].LEVEL1.FILEACCTIME, [SI].LEVEL1.FILEACCDATE
	PUSH SI
	MOV SI,100
	GET_SET_DATE_TIME [DS:BP].ARGS.FILEHANDLE, 7, [SI].LEVEL1.FILETIME, [SI].LEVEL1.FILEDATE
	POP SI
	XOR AX,AX
EXIT:
		@EPILOG	DOSSETFILEINFO

_TEXT		ENDS

		END

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
		INCLUDE	GlobalVars.inc
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc

LEVEL1 struct
    FILEDATE    dw ?    ;!< Дата создания файла (смещение 0)
    FILETIME    dw ?    ;!< Время создания файла (смещение 2)
    FILEACCDATE dw ?    ;!< Дата последнего доступа (смещение 4)
    FILEACCTIME dw ?    ;!< Время последнего доступа (смещение 6)
    WRITACCDATE dw ?    ;!< Дата последней записи (смещение 8)
    WRITACCTIME dw ?    ;!< Время последней записи (смещение 10)
    FILESIZE    dd ?    ;!< Фактический размер файла (смещение 12)
    FILEALLOC   dd ?    ;!< Выделенное пространство (смещение 16)
    FILEATTRIB  dw ?    ;!< Атрибуты файла (смещение 20)
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
FILEINFOBUFSIZE	DW	?	; [BP+6]
FILEINFOBUF	DD	?	; [BP+8]
FILEINFOLEVEL	DW	?	; [BP+12]
FILEHANDLE	DW	?	; [BP+14]
		@START	DOSSETFILEINFO

		CMP		DOS1020API, 0FFFFH
		JB		OLDDOS

;INT 21 - OS/2 v1.1+ Family API - DosSetFileInfo
;
;	AX = 5703h
;	BX = file handle
;	CX = size of information buffer
;	DX = level of information
;	ES:DI -> information buffer
;Return: CF clear if successful
;	CF set on error
;	    AX = error code
;SeeAlso: AX=5702h"OS/2",AX=5703h/BX=FFFFh
		MOV	DX, [BP].ARGS.FILEINFOLEVEL
		MOV	BX, [BP].ARGS.FILEHANDLE
		LES	DI, [BP].ARGS.FILEINFOBUF
		MOV	CX, [BP].ARGS.FILEINFOBUFSIZE
		INT	21H
		JC	DOS_ERROR
		JMP	EXIT

OLDDOS:
		MOV AX,[BP].ARGS.FILEINFOLEVEL
		LDS SI,[BP].ARGS.FILEINFOBUF
		CMP AX,1
		JZ LEV1
	;	 CMP AX,2
	;	 JZ LEV2
	;	 CMP AX,3
	;	 JZ LEV3
		MOV AX, ERROR_INVALID_LEVEL
		JMP EXIT
LEV1:
		; Проверка размера буфера (22 байта для LEVEL1)
		CMP	[BP].ARGS.FILEINFOBUFSIZE, SIZE LEVEL1
		MOV	AX, ERROR_INSUFFICIENT_BUFFER 
		JB      EXIT

		GET_SET_DATE_TIME [BP].ARGS.FILEHANDLE, 1, [SI].LEVEL1.WRITACCTIME, [SI].LEVEL1.WRITACCDATE
		JC EXIT
		GET_SET_DATE_TIME [BP].ARGS.FILEHANDLE, 5, [SI].LEVEL1.FILEACCTIME, [SI].LEVEL1.FILEACCDATE
		;PUSH SI
		;MOV SI,100
		GET_SET_DATE_TIME [BP].ARGS.FILEHANDLE, 7, [SI].LEVEL1.FILETIME, [SI].LEVEL1.FILEDATE
		;POP SI
		XOR AX,AX
		JMP	EXIT

DOS_ERROR:
		CALL    CONVERT_DOS_ERROR
EXIT:
		@EPILOG	DOSSETFILEINFO

_TEXT		ENDS

		END

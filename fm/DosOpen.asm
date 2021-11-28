;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosOpen DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
; @ todo arguments checking
;
;0 NO_ERROR
;2 ERROR_FILE_NOT_FOUND
;3 ERROR_PATH_NOT_FOUND
;4 ERROR_TOO_MANY_OPEN_FILES
;5 ERROR_ACCESS_DENIED
;12 ERROR_INVALID_ACCESS
;26 ERROR_NOT_DOS_DISK
;32 ERROR_SHARING_VIOLATION
;36 ERROR_SHARING_BUFFER_EXCEEDED
;82 ERROR_CANNOT_MAKE
;87 ERROR_INVALID_PARAMETER
;108 ERROR_DRIVE_LOCKED
;110 ERROR_OPEN_FAILED
;112 ERROR_DISK_FULL
;206 ERROR_FILENAME_EXCED_RANGE
;231 ERROR_PIPE_BUSY
;99 ERROR_DEVICE_IN_USE
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE DOS.INC
		INCLUDE BSEERR.INC
		INCLUDE GLOBALVARS.INC

_DATA		SEGMENT BYTE PUBLIC 'CODE' USE16
DEVS:
		DB	"CLOCK$",0	; Present in DOS
		DB	"CLOCK",0	; Present in DOS (some 2.x versions)
		DB	"KBD$",0	; New in OS/2
		DB	"SCREEN$",0	; New in OS/2
		DB	"POINTER$",0	; New in OS/2
		DB	"MOUSE$",0	; New in OS/2
		DB	"PRN",0
		DB	"LPT1",0	; Present in DOS
		DB	"LPT2",0	; Present in DOS
		DB	"LPT3",0	; Present in DOS
		DB	"AUX",0 
		DB	"COM1",0	; Present in DOS
		DB	"COM2",0	; Present in DOS
		DB	"COM3",0	; Present in DOS
		DB	0		; end of list
_DATA		ENDS

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSOPEN
RESERVED	DD	?		;Reserved (must be zero)
OPENMODE	DW	?		;Open mode of the file
OPENFLAG	DW	?		;Open function type
FILEATTRIBUTE	DW	?		;File Attribute
FILESIZE	DD	?		;File primary allocation
ACTIONTAKEN	DD 	?		;Action taken (returned)
FILEHANDLE	DD 	?		;File handle (returned)
FILENAME	DD 	?		;File path name string
		@START DOSOPEN

		MOV	AX, ERROR_INVALID_PARAMETER

		XOR	CX, CX				; Check Reserved is zero
		CMP	CX, WORD PTR [DS:BP].ARGS.RESERVED
		JNZ	ERROR
		CMP	CX, WORD PTR [DS:BP].ARGS.RESERVED+2
		JNZ	ERROR

;		CALL	ISDEVICE
;		JE	OPENDEVICE


		MOV	CX, [DS:BP].ARGS.FILEATTRIBUTE	; Check allowed attrs
		TEST	CX, 1111111111001000B
		JNZ	ERROR

		MOV	CX,[DS:BP].ARGS.OPENMODE	; Check allowed modes
		CMP	SHARE, 0FFFFH
		JNZ	NOSHARE
		TEST	CX, 0111100000001000B
		JMP	@F
NOSHARE:
		TEST	CX, 0111100001111111B
@@:
		JNZ	ERROR

		MOV	CX,[DS:BP].ARGS.OPENFLAG
		TEST	CX, 1111111100000000B
		JNZ	ERROR


		MOV	CX,[DS:BP].ARGS.OPENFLAG
		TEST	AL, 012H
		JNZ	@F
		CMP	AL,1
		JE	OPENFILE
		MOV	AX, ERROR_INVALID_ACCESS 
		JMP	EXIT2
@@:	
		CREATE_HANDLE [DS:BP].ARGS.FILENAME, 0
		JB	ERROR
		CLOSE_HANDLE AX
		JB	EXIT2
OPENFILE:
		MOV	AX,[DS:BP].ARGS.FILEATTRIBUTE
		AND	AL,077H
		OPEN_HANDLE  [DS:BP].ARGS.FILENAME, AL
		JB	ERROR
		LDS	BX,[DS:BP].ARGS.FILEHANDLE
		MOV	[BX],AX
		XOR	AX,AX
		JMP EXIT2
ERROR:		
		PUSH	SI
		PUSH	DI
		PUSH	ES
		PUSH	DS
		MOV	SI,CX
		MOV	AX,SI
		CMP	DOS3API,0FFFFH
		JB	@F
		XOR	BX,BX
		GET_ERROR
@@:	
		POP	DS
		POP	ES
		POP	DI
		POP	SI
EXIT2:	
		@EPILOG DOSOPEN

;----------------------------------------------------------------------
; @brief Check is filename are device name
;
;----------------------------------------------------------------------
ISDEVICE	PROC
		RET
ISDEVICE	ENDP

_TEXT		ENDS

		END

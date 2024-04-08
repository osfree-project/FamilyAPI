;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosGetMessage DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;    0 NO_ERROR
;    2 ERROR_FILE_NOT_FOUND
;    206 ERROR_FILENAME_EXCED_RANGE
;    316 ERROR_MR_MSG_TOO_LONG
;    317 ERROR_MR_MID_NOT_FOUND
;    318 ERROR_MR_UN_ACC_MSGF
;    319 ERROR_MR_INV_MSFG_FORMAT
;    320 ERROR_MR_INV_IVCOUNT
;    321 ERROR_MR_UN_PERFORM
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	bseerr.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSGETMESSAGE
IVTABLE		DD	?
IVCOUNT		DW	?
DATAAREA	DD	?
DATALENGTH	DW	?
MSGNUMBER	DW	?
FILENAME	DD	?
MSGLENGTH	DD	?
		@START	DOSGETMESSAGE
		
		; Check IVCOUNT value is less 9
		MOV	AX, ERROR_MR_INV_IVCOUNT
		CMP	WORD PTR [DS:BP].ARGS.IVCOUNT, 9
		JG	EXIT

		; Copy string and insert IVT items
		MOV	SI, OFFSET MSGBUF
		LES	DI, [DS:BP].ARGS.DATAAREA

		CMP	BYTE PTR [DS:SI], '%'
		JE	InsertIVItem
Continue:		
		CMP	BYTE PTR [DS:SI], 0
		MOVSB
		JE	EXIT

		JMP	Continue

InsertIVItem:	PUSH	SI
		INC	SI
		MOV	AL, BYTE PTR [DS:SI]
		SUB	AL, '1'
		XOR	AH, AH
		SHL	AX, 1
		LDS	SI, [DS:BP].ARGS.IVTABLE
		ADD	SI, AX
		
		; copy here
		
		POP	SI
		JMP	Continue
		
OKEXIT:		
		XOR	AX, AX
EXIT:		
		@EPILOG	DOSGETMESSAGE

MSGBUF		DB	'test', 10,13, 0

_TEXT		ENDS

		END

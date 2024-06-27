;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosGetMessage DOS wrapper
;
;   (c) osFree Project 2018, 2024 <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;
;    DosTrueGetMessage (IvTable, IvCount, DataArea, DataLength, MsgNumber, FileName, MsgLength, MsgSeg)
;
;    IvTable (PCHAR FAR *) - input : Address of a list of double-word pointers. Each pointer points to an ASCIIZ or null-terminated DBCS string (variable insertion text). 0 to 9 strings can be present.
;    IvCount (USHORT) - input:Count of variable insertion text strings is 0-9. If IvCount is 0, IvTable is ignored.
;    DataArea (PCHAR) - output:Address of the requested message. If the message is too long to fit in the caller's buffer, as much of the message text is returned as possible, with the appropriate error return code.
;    DataLength (USHORT) - input:Length, in bytes, of the user's storage area.
;    MsgNumber (USHORT) - input:Requested message number.
;    FileName (PSZ) - input:Address of the optional drive, path, and filename of the file where the message can be found. If messages are bound to the .EXE file using MSGBIND utility, then filename is the name of the message file from which the messages are extracted.
;    MsgLength (PUSHORT) - output:Address of the length, in bytes, of the message.
;    MsgSeg (VOID FAR *) - input: Pointer to binded Messages segment.
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
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		; External functions
EXTERN		Pascal	DosScanEnv: FAR
		
		; Extracted messages
EXTERN		_TXT_MSG_MR_CANT_FORMAT: FAR
EXTERN		_TXT_MSG_MR_NOT_FOUND: FAR
EXTERN		_TXT_MSG_MR_READ_ERROR: FAR
EXTERN		_TXT_MSG_MR_IVCOUNT_ERROR: FAR
EXTERN		_TXT_MSG_MR_UN_PERFORM: FAR

		@PROLOG	DOSTRUEGETMESSAGE
MSGSEG		DD	?
MSGLENGTH	DD	?
FILENAME	DD	?
MSGNUMBER	DW	?
DATALENGTH	DW	?
DATAAREA	DD	?
IVCOUNT		DW	?
IVTABLE		DD	?
@LOCALW		InstanceSeg		; Instance DS segment
		@START	DOSTRUEGETMESSAGE

		; Save instance segment
		MOV	CS:[InstanceSeg], DS
		; Set direction
		CLD

		;@DispCh '1'

		; **Parameters check block without error message copied to message buffer**
		
		; Check message buffer ponter
		MOV	AX,ERROR_INVALID_PARAMETER
		XOR	BX, BX

		CMP	BX, WORD PTR [DS:BP].ARGS.DATAAREA
		JNE	DATAAREAOK
		;@DispCh '2'
		CMP	BX, WORD PTR [DS:BP].ARGS.DATAAREA+2
		JE	EXIT
DATAAREAOK:

		;@DispCh '3'

		; Check buffer size
		CMP	BX, WORD PTR [DS:BP].ARGS.DATALENGTH
		JE	EXIT

		;@DispCh '4'

		; Check filename pointer
		CMP	BX, WORD PTR [DS:BP].ARGS.FILENAME
		JNE	FILENAMEOK
		@DispCh '5'
		CMP	BX, WORD PTR [DS:BP].ARGS.FILENAME+2
		JE	EXIT		; @todo Skip file, only segment search
FILENAMEOK:
		;@DispCh '6'

		; Parameters check block with error message copied to message buffer

		; Set destination buffer
		LES	DI, [DS:BP].ARGS.DATAAREA

		; @todo Search message segment

		; Search message file

		; First try default drive root directory
		;PUSH	DWORD EnvVarName    ; COMSPEC
		;PUSH	DWORD ResultPointer	; Value
		;CALL	DosScanEnv
		; Second open in current directory (APPEND allow search in anothe paths)
		
		MOV	CX, [DS:BP].ARGS.DATALENGTH

		; Check IVCOUNT value is less 9
		MOV	AX, ERROR_MR_INV_IVCOUNT
		CMP	WORD PTR [DS:BP].ARGS.IVCOUNT, 9
		JG	BADIVCOUNTEXIT

		; Copy string and insert IVT items

OutMsg:		
		; Output message size counter
		XOR	BX,BX

Continue:	
		INC	BX
		CMP	BX, CX			; ARGS.DATALENGTH
		JG	BUFOUTEXIT

		CMP	BYTE PTR [DS:SI], '%'
		JE	InsertIVItem


		push ax
		MOV	AL, BYTE PTR [DS:SI]
		@DispCh AL
		pop ax
		
		MOVSB

		CMP	BYTE PTR [DS:SI], 0
		JE	EXIT

		JMP	Continue

InsertIVItem:	
		push ax
		@DispCh 'X'
		pop ax
		; Check is IVT present
		CMP	[DS:BP].ARGS.IVCOUNT, 0
		JE	Continue

		; Substitute parameter
		PUSH	SI
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


		; Copy extracted messages to message buffer
BADMSGID:
		PUSH CS
		POP DS
		MOV	SI, OFFSET _TXT_MSG_MR_CANT_FORMAT
		JMP	OutMsg

BADMSGFORMAT:
		PUSH CS
		POP DS
		MOV	SI, OFFSET _TXT_MSG_MR_READ_ERROR
		JMP	OutMsg

BADIVCOUNTEXIT:
		PUSH CS
		POP DS
		MOV	SI, OFFSET _TXT_MSG_MR_IVCOUNT_ERROR
		JMP	OutMsg

BUFOUTEXIT:
		MOV	AX, ERROR_MR_MSG_TOO_LONG
		push ax
		@DispCh 'Y'
		pop ax
		JMP	EXIT

OKEXIT:		
		XOR	AX, AX
EXIT:		
		; Restore instance segment
		MOV	DS, CS:[InstanceSeg]
		@EPILOG	DOSTRUEGETMESSAGE


_TEXT		ENDS

_MKMSGSEG	SEGMENT BYTE PUBLIC 'CODE' USE16
		DB        0FFH, 'MKMSGSEG', 0, 1, 0, 0, 0, 0, 0


;    DosGetMessage (IvTable, IvCount, DataArea, DataLength, MsgNumber, FileName, MsgLength)
;
;    IvTable (PCHAR FAR *) - input : Address of a list of double-word pointers. Each pointer points to an ASCIIZ or null-terminated DBCS string (variable insertion text). 0 to 9 strings can be present.
;    IvCount (USHORT) - input:Count of variable insertion text strings is 0-9. If IvCount is 0, IvTable is ignored.
;    DataArea (PCHAR) - output:Address of the requested message. If the message is too long to fit in the caller's buffer, as much of the message text is returned as possible, with the appropriate error return code.
;    DataLength (USHORT) - input:Length, in bytes, of the user's storage area.
;    MsgNumber (USHORT) - input:Requested message number.
;    FileName (PSZ) - input:Address of the optional drive, path, and filename of the file where the message can be found. If messages are bound to the .EXE file using MSGBIND utility, then filename is the name of the message file from which the messages are extracted.
;    MsgLength (PUSHORT) - output:Address of the length, in bytes, of the message.
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

		PUBLIC	DOSGETMESSAGE
DOSGETMESSAGE:
		XOR       AX,AX			; Message segment
		PUSH      AX
		PUSH      CS
		PUSH      BP			; Exchange return address and Message segment
		MOV       BP,SP
		XCHG      AX,WORD PTR 6H[BP]
		XCHG      AX,WORD PTR 2H[BP]
		XCHG      AX,WORD PTR 8H[BP]
		MOV       WORD PTR 4H[BP],AX
		POP       BP
		JMP       FAR PTR DOSTRUEGETMESSAGE
MSGSEGDATA:
		DW        0
    
_MKMSGSEG	ENDS
	
		END

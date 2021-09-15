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
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE DOS.INC
		INCLUDE BSEERR.INC
		INCLUDE GLOBALVARS.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSOPEN
FILENAME	DD 	?		;File path name string
FILEHANDLE	DD 	?		;File handle (returned)
ACTIONTAKEN	DD 	?		;Action taken (returned)
FILESIZE	DD	?		;File primary allocation
FILEATTRIBUTE	DW	?		;File Attribute
OPENFLAG	DW	?		;Open function type
OPENMODE	DW	?		;Open mode of the file
RESERVED	DD	?		;Reserved (must be zero)
		@START DOSOPEN

		LDS	DX,[DS:BP].ARGS.FILENAME
		MOV	AX,[DS:BP].ARGS.OPENFLAG
		TEST	AL,012H
		JNE	@F
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

_TEXT		ends

	end

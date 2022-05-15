;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosWrite DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
; @todo Seems pointers need to be fixed to use another segment, not only current
; @todo check stdin/stdout/stderr
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSWRITE
BYTESWRITTEN	DD	?
BUFFERLENGTH	DW	?
BUFFERAREA	DD	?
FILEHANDLE	DW	?
		@START	DOSWRITE
		MOV	BX,[DS:BP].ARGS.FILEHANDLE
		LDS	DX,[DS:BP].ARGS.BUFFERAREA
		MOV	CX,[DS:BP].ARGS.BUFFERLENGTH
		CMP	BX,4		;PRINTER?
		JNE	NORMALFILE
		PUSH CX			;SAVE LENGTH TWICE
		PUSH CX
		MOV	AL,01AH		;CTRL-Z
		MOV	SI,DX
NEXTITEM:
		JCXZ DONE
		REPNE SCASB
		JNE	DONE
		POP	CX
		PUSH CX
		MOV	AH,040H
		INT	21H
		POP	CX
		SUB	CX,AX
		PRINT_CHAR 01AH
		DEC	CX
		PUSH CX
		MOV	DX,SI
		INC	DX
		JMP NEXTITEM
DONE:
		POP	CX
NORMALFILE:
		MOV	AH,040H
		INT	21H
		RCL	CX,1
		CMP	BX,4
		RCR	CX,1
		JNE	@F
		POP	AX		;IF PRINTER, GET LENGTH
@@:	
		LDS	BX,[DS:BP].ARGS.BYTESWRITTEN
		MOV	[BX],AX
		JB	@F
		XOR	AX,AX
@@:
		@EPILOG	DOSWRITE

_TEXT		ENDS

		END

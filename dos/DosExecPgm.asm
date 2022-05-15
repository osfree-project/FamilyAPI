;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosExecPgm DOS wrapper
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
		EXTERN	@INIT : NEAR
		EXTERN	@DONE : NEAR
		INCLUDE	dos.inc


_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		; API export
		PUBLIC	DOSEXECPGM

ObjNameBuf	EQU	[BP+26]
ObjNameBuf	EQU	[BP+24]
ExecFlags	EQU	[BP+22]
ArgPointer	EQU	[BP+18]
EnvPointer	EQU	[BP+14]
ReturnCodes	EQU	[BP+10]
PGMPOINTER	EQU	[BP+6]

DOSEXECPGM	PROC	FAR
		CALL	@INIT
		GET_PSP

		MOV     [BP+16H],BX

		MOV     WORD PTR [BP+6],05CH    ;FCB1
		MOV     [BP+8],BX
		MOV     WORD PTR [BP+0AH],06CH  ;FCB2
		MOV     [BP+0CH],BX

		XOR     AX,AX
		MOV     [BP+0],AX      ;ENVIRONMENT

		LES     DI,[BP+2AH]
		MOV		AX,ES
		AND		AX,AX
		JNZ		CMDLINEGIVEN
		XOR		DI,DI
		JMP		CMDLINE2
CMDLINEGIVEN:
		MOV     CX,040H
		REPNE   SCASB
		MOV     SI,DI
		MOV     CX,0100H
		REPNE   SCASB
		SUB     DI,SI		;SIZE OF CMDLINE
CMDLINE2:        
		MOV     CX,DI
		MOV     BX,CX
		ADD     BX,2		;ONE BYTE FOR CMDLINE LENGTH
		AND		BL,NOT 1	;MAKE SURE SP REMAINS EVEN
 
		SUB     SP,BX		;MAKE ROOM FOR THE CMDLINE
		MOV     AX,ES
		MOV     DS,AX
		MOV     AX,SS
		MOV     ES,AX
		MOV     DI,SP
		DEC     BX
		DEC     BX
		MOV     ES:[DI],BL
		MOV		[BP+2],DI
		MOV		[BP+4],ES
		INC     DI
		REP     MOVSB		;COPY CMDLINE TO OUR STACK COPY
		LDS     DX,[BP+1EH]
		MOV     AX,SS
		MOV     ES,AX
		MOV     BX,BP

		MOV     AX,04B00H
		INT     21H
		JB      @F
		RET_CODE
		LDS		SI,[BP+22H]
		MOV  	AH,00
		MOV		[SI+2],AX	;SET CODERESULT FIELD
		XOR     AX,AX
@@:
		LEA		SP,[BP-7*2]
		CALL	@DONE
		RET	24
DOSEXECPGM	ENDP

_TEXT		ENDS

		END

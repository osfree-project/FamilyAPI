;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosScanEnv DOS wrapper
;
;   (c) osFree Project 2022,2024 <http://www.osfree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;
; 0 NO_ERROR
; ERROR_INVALID_PARAMETER
; ERROR_ENVVAR_NOT_FOUND
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	bseerr.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		; External functions
EXTERN		Pascal DosGetEnv: FAR

		@PROLOG	DOSSCANENV
RESULTPOINTER	DD	?
ENVVARNAME		DD	?
@LOCALW			CMD
@LOCALW			ENV
		@START	DOSSCANENV

		; Check arguments not NULL
		MOV		AX, ERROR_INVALID_PARAMETER
		XOR		BX, BX

		CMP		BX, WORD PTR [DS:BP].ARGS.RESULTPOINTER
		JNE		RESULTPOINTEROK
		CMP		BX, WORD PTR [DS:BP].ARGS.RESULTPOINTER+2
		JE		EXIT
RESULTPOINTEROK:

		CMP		BX, WORD PTR [DS:BP].ARGS.ENVVARNAME
		JNE		ENVVARNAMEOK
		CMP		BX, WORD PTR [DS:BP].ARGS.ENVVARNAME+2
		JE		EXIT
ENVVARNAMEOK:

		; Get environment
		PUSH	SS
		LEA		AX, ENV
		PUSH	AX

		PUSH	SS
		LEA		AX, CMD
		PUSH	AX

		CALL	DosGetEnv

		; Exit if error
		OR		AX, AX
		JNZ		EXIT

		; Calc length of searched varname
		LES		DI, [DS:BP].ARGS.ENVVARNAME
		MOV		CX, 0FFFFH
		;XOR	AL, AL		; Zero here already
		REPNE	SCASB
		NOT		CX
		DEC		CX
		MOV		DX, CX

		; Exit if zero length
		MOV		AX, ERROR_ENVVAR_NOT_FOUND
		OR		CX, CX
		JZ		EXIT

		; ES:DI - environment
		MOV		ES, ENV
		XOR		DI, DI
		; DS:SI - searched environment variable
		LDS		SI, [DS:BP].ARGS.ENVVARNAME

SEARCH:
		MOV		SI, WORD PTR [DS:BP].ARGS.ENVVARNAME
		MOV		CX, DX
		REPE	CMPSB
		JNZ		NOTFOUND

		; Check is found
		CMP		BYTE PTR [ES:DI],'='
		JZ		FOUND

NOTFOUND:
		; Skip to next variable
		DEC		DI
		MOV		CX, 0FFFFH
		XOR		AL, AL
		REPNE	SCASB
		
		; Exit if end of environment
		MOV		AX, ERROR_ENVVAR_NOT_FOUND
		CMP		BYTE PTR ES:[DI],0
		JZ		EXIT
		JMP		SEARCH

		; Store result and exit
FOUND:
		INC		DI
		LDS		SI, [DS:BP].ARGS.RESULTPOINTER
		MOV		[SI], DI
		MOV		[SI + 2], ES
		XOR		AX, AX

EXIT:
		@EPILOG	DOSSCANENV

_TEXT		ENDS

		END

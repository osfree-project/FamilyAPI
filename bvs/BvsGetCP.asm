;/*!
;   @file
;
;   @brief BvsGetCP DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;* 0  NO_ERROR
;*355 ERROR_VIO_MODE
;*436 ERROR_VIO_INVALID_HANDLE
;*465 ERROR_VIO_DETACHED
;*468 ERROR_VIO_USER_FONT
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE DOS.INC
		INCLUDE BSEERR.INC
		INCLUDE BVSVARS.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16


		@BVSPROLOG	BVSGETCP
VIOHANDLE	DW	?		;Video handle
CODEPAGEID	DD	?		;
RESERVED	DW	?		;
		@BVSSTART	BVSGETCP

		EXTERN	VIOCHECKHANDLE: PROC
		MOV	AX,ERROR_INVALID_PARAMETER
		XOR	BX, BX
		CMP	BX, WORD PTR [DS:BP].ARGS.RESERVED
		JNZ	EXIT
		MOV     BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

		PUSH	DS
		PUSH    CS
		POP     DS
		MOV     AX,VIO_CP           ; GET CURRENT CODEPAGE ID
		POP	DS
		LES     DI,[DS:BP].ARGS.CODEPAGEID               ; GET POINTER FOR WHERE TO PUT IT
		STOSW                           ; MOV IT THERE

		XOR     AX,AX                    ; ALL IS OK

EXIT:
		@BVSEPILOG	BVSGETCP
_TEXT		ENDS
		END


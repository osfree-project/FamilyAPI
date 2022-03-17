;/*!
;   @file
;
;   @brief BvsSetCP DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   * 0   NO_ERROR
;   * 355 ERROR_VIO_MODE
;   * 436 ERROR_VIO_INVALID_HANDLE
;   * 465 ERROR_VIO_DETACHED
;   * 469 ERROR_VIO_BAD_CP
;   * 470 ERROR_VIO_NO_CP
;   * 471 ERROR_VIO_NA_CP;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE	DOS.INC
		INCLUDE	BSEERR.INC
		INCLUDE	BVSVARS.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BVSPROLOG	BVSSETCP
VIOHANDLE	DW	?		;Video handle
CODEPAGEID	DW	?		;
RESERVED	DW	?		;
		@BVSSTART	BVSSETCP
		MOV	AX,ERROR_INVALID_PARAMETER
		XOR	BX, BX
		CMP	BX, WORD PTR [DS:BP].ARGS.RESERVED
		JNZ	EXIT

		EXTERN	VIOCHECKHANDLE: PROC
		MOV	BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

		MOV	AX,[DS:BP].ARGS.CODEPAGEID
		PUSH	CS
		POP	DS
		MOV	VIO_CP,AX		; SAVE IT AWAY

		XOR	AX, AX			; ALL OK

EXIT:
		@BVSEPILOG	BVSSETCP
_TEXT		ENDS
		END


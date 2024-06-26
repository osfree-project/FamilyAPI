;/*!
;   @file
;
;   @brief BvsGetConfig DOS wrapper
;
;   (c) osFree Project 2008-2022, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;  * 0   NO_ERROR
;  * 421 ERROR_VIO_INVALID_PARMS
;  * 436 ERROR_VIO_INVALID_HANDLE
;  * 438 ERROR_VIO_INVALID_LENGTH
;  * 465 ERROR_VIO_DETACHED
;
; @todo add vioconfiginfo length check
;
;*/

.8086
		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
		INCLUDE	bios.inc
INCL_VIO	EQU	1
		INCLUDE	bseerr.inc
		INCLUDE	bsesub.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BVSPROLOG	BVSGETCONFIG
VIOHANDLE	DW	?		; VIDEO HANDLE
VIOCONFIG	DD	?		; Config structure
VIOCONFIGID	DW	?		; Configuration ID
		@BVSSTART	BVSGETCONFIG

		EXTERN	VIOCHECKHANDLE: PROC
		MOV	BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

		@GetMode		;GET MODE
		XOR	DX,DX
		CMP	AL,7		;80X25 MONO?
		JE	VGATEXT
		INC	DX
		CMP	AL,2		;80X25
		JE	VGATEXT
		CMP	AL,3		;80X25
		JE	VGATEXT
		MOV	DL,5
		CMP	AL,8		;
		JE	VGATEXT
		CMP	AL,0EH
		MOV	AX, ERROR_VIO_DETACHED
		JNE	EXIT
VGATEXT:
		XCHG	DH,DL
		@GetDisplay
		CMP	AL,01AH

		JNE	TRYEGA		; Not VGA adapter

		PUSH	BX		; Check adapter is not later EGA
		MOV	CX, 1
		@GetVideoState
		CMP	AL,01CH
		POP	BX
		JNE	TRYEGA		; Not VGA adapter

		CMP	BL,7
		JE	ISVGA
		CMP	BL,8
		JE	ISVGA
		CMP	BL,4
		JE	ISEGA
		CMP	BL,5
		JNE	ISMDACGA

ISEGA:					; EGA display
		MOV	DL,2
		JMP	SETRET
ISVGA:					; VGA display
		MOV	DL,3
		JMP	SETRET
TRYEGA:
		@GetEGAInfo
		CMP	BL,10H
		JNE	ISEGA
ISMDACGA:				; MDA/CGA display
		CMP	DH,1
		JNE	SETRET
		INC	DX
SETRET:
		LDS	BX,[DS:BP].ARGS.VIOCONFIG
		XOR	AH,AH
		MOV	AL,DL
		MOV	[DS:BX].VIOCONFIGINFO.VIOIN_ADAPTER,AX	;ADAPTER TYPE
		MOV	AL,DH
		MOV	[DS:BX].VIOCONFIGINFO.VIOIN_DISPLAY,AX	;DISPLAY TYPE
		XOR	AX,AX
EXIT:    
		@BVSEPILOG	BVSGETCONFIG
_TEXT		ENDS

		END


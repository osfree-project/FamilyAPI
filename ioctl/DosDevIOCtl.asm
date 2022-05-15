;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosDevIOCtl DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:dosdevioctl
;
; @todo May be install as INT 21H AX=44H handler for DOS IOCtl?
;
;0 NO_ERROR
;1 ERROR_INVALID_FUNCTION
;6 ERROR_INVALID_HANDLE
;15 ERROR_INVALID_DRIVE
;31 ERROR_GEN_FAILURE
;87 ERROR_INVALID_PARAMETER
;115 ERROR_PROTECTION_VIOLATION
;117 ERROR_INVALID_CATEGORY
;119 ERROR_BAD_DRIVER_LEVEL
;163 ERROR_UNCERTAIN_MEDIA
;165 ERROR_MONITORS_NOT_SUPPORTED
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	bseerr.inc
		INCLUDE	bsedos.inc
		INCL_SUB	EQU	1
		INCLUDE	bsesub.inc

_DATA		SEGMENT BYTE PUBLIC 'DATA' USE16

CATTABLE:
	DW	IOSERIAL	; Category 1 Serial Device Control
	DW	RESERVED	; Category 2 Reserved
	DW	RESERVED	; Category 3 Screen/Video control
	DW	IOKEYBOARD	; Category 4 Keyboard Control
	DW	IOPRINTER	; Category 5 Printer Control
	DW	RESERVED	; Category 6 Light Pen Control
	DW	IOMOUSE		; Category 7 Mouse Control
	DW	IODISK		; Category 8 Logical Disk Control
	DW	RESERVED	; Category 9 Physical Disk Control
	DW	RESERVED	; Category 10 Character Device Monitor Control
	DW	RESERVED	; Category 11 General Device Control


MAXCATEGORY	EQU	11

_DATA	ENDS

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSDEVIOCTL
DEVHANDLE	DW	?
CATEGORY	DW	?
FUNCTION	DW	?
PARMLIST	DD	?
DDATA		DD	?
		@START	DOSDEVIOCTL
		; @todo А как проверять хэндл? По идее, хэндл определяет конкретное устройство.
		MOV	SI, SEG _DATA
		MOV	ES, SI
		MOV	SI, [DS:BP].ARGS.CATEGORY
		MOV	AX, ERROR_INVALID_CATEGORY
		CMP	SI, 0
		JZ	EXIT
		CMP	SI, MAXCATEGORY
		JA	EXIT
		DEC	SI
		SHL	SI, 1
;		SHL	SI, 1
		MOV	AX, ERROR_INVALID_FUNCTION
		CALL	WORD PTR ES:CATTABLE[SI]
EXIT:
		@EPILOG	DOSDEVIOCTL

;--------------------------------------------------------
; Category/Function Reserved
;--------------------------------------------------------
; Category 5 Function 42H Reserved
; Category 5 Function 43H Reserved
; Category 5 Function 45H Reserved
; Category 5 Function 63H Reserved
; Category 5 Function 65H Reserved
; Category 4 Function 5BH Reserved
; Category 7 Function 55H Reserved
; Category 7 Function 69H Reserved
;--------------------------------------------------------

RESERVED	PROC NEAR
		RET
RESERVED	ENDP

_TEXT		ENDS

		INCLUDE	Cat01.asm
		INCLUDE	Cat02.asm
		INCLUDE	Cat03.asm
		INCLUDE	Cat04.asm
		INCLUDE	Cat05.asm
		INCLUDE	Cat06.asm
		INCLUDE	Cat07.asm
		INCLUDE	Cat08.asm
		INCLUDE	Cat09.asm
		INCLUDE	Cat10.asm
		INCLUDE	Cat11.asm

		END

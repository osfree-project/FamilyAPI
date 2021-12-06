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
		INCLUDE	HELPERS.INC
		INCLUDE	BSEERR.INC

_DATA		SEGMENT BYTE PUBLIC 'DATA' USE16

CATTABLE:
	DD	IOSERIAL	; Category 1 Serial Device Control
	DD	RESERVED	; Category 2 Reserved
	DD	RESERVED	; Category 3 Screen/Video control
	DD	IOKEYBOARD	; Category 4 Keyboard Control
	DD	IOPRINTER	; Category 5 Printer Control
	DD	RESERVED	; Category 6 Light Pen Control
	DD	IOMOUSE		; Category 7 Mouse Control
	DD	IODISK		; Category 8 Logical Disk Control
	DD	RESERVED	; Category 9 Physical Disk Control
	DD	RESERVED	; Category 10 Character Device Monitor Control
	DD	RESERVED	; Category 11 General Device Control

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
		; @todo � ��� ��������� �����? �� ����, ����� ���������� ���������� ����������.
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
		SHL	SI, 1
		MOV	AX, ERROR_INVALID_FUNCTION
		CALL	FAR PTR ES:CATTABLE[SI]
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

RESERVED	PROC FAR
		RET
RESERVED	ENDP

_TEXT		ENDS

		INCLUDE	CAT01.ASM
		INCLUDE	CAT02.ASM
		INCLUDE	CAT03.ASM
		INCLUDE	CAT04.ASM
		INCLUDE	CAT05.ASM
		INCLUDE	CAT06.ASM
		INCLUDE	CAT07.ASM
		INCLUDE	CAT08.ASM
		INCLUDE	CAT09.ASM
		INCLUDE	CAT10.ASM
		INCLUDE	CAT11.ASM

		END
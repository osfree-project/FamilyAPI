;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosDevIOCtl DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
; @todo May be install as INT 21H handler for DOS IOCtl?
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

_DATA		SEGMENT BYTE PUBLIC 'DATA' USE16

CATTABLE:
	DD	?		; 0
	DD	?		; 1
	DD	?		; 2
	DD	?		; 3
	DD	KEYBOARD	; Category 4 Keyboard Control
	DD	?		; 5
	DD	?		; 6
	DD	?		; 7
	DD	?		; 8
	DD	?		; 9
	DD	?		; 10
	DD	?		; 11


KEYTABLE1:
	DD	?		; Function 50H  Set code page
	DD	?		; 51H
	DD	?		; 52H
	DD	?		; 53H
	DD	?		; 54H
	DD	?		; 55H
	DD	?		; 56H
	DD	?		; 57H
	DD	?		; 58H
	DD	?		; 59H
	DD	?		; 5AH
	DD	?		; 5BH
	DD	?		; 5CH
	DD	?		; 5DH
	DD	?		; 5EH

KEYTABLE2:
	DD	?		; 71H
	DD	?		; 72H
	DD	?		; 73H
	DD	IOKREADCHAR	; Function 74H Read character data record(s)
	DD	?		; Function 75H Peek character data record
	DD	?		; 76H
	DD	?		; 77H
	DD	?		; 78H
	DD	?		; 79H
	DD	?		; 7AH
	DD	?		; 7BH
_DATA	ENDS



_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSDEVIOCTL
DevHandle	DW	?
Category	DW	?
Function	DW	?
ParmList	DD	?
DData		DD	?
		@START	DOSDEVIOCTL

		MOV	SI, SEG _DATA
		MOV	ES, SI
		MOV	SI, [DS:BP].ARGS.CATEGORY
		SHL	SI, 1
		SHL	SI, 1
		CALL	FAR PTR ES:CATTABLE[SI]

		@EPILOG	DOSDEVIOCTL

_TEXT		ENDS

KEYBOARD	PROC FAR
		MOV	SI, [DS:BP].ARGS.FUNCTION
		SUB	SI, 50H		; 50H
		SUB	SI, 21H		; 71H

		SHL	SI, 1
		SHL	SI, 1
		CALL	FAR PTR ES:KEYTABLE2[SI]
		RET
KEYBOARD	ENDS

		END

;--------------------------------------------------------
; Category 4 Function 74H Read character data record(s)
;--------------------------------------------------------
;
;
;

IOKREADCHAR	PROC	FAR
		RET
IOKREADCHAR	ENDS
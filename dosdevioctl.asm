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

_DATA		SEGMENT BYTE PUBLIC 'DATA' USE16

CATTABLE:
	DD	?		; 0
	DD	?		; Category 1 Serial Device Control
	DD	?		; Category 2 Reserved
	DD	?		; Category 3 Screen/Video control
	DD	IOKEYBOARD	; Category 4 Keyboard Control
	DD	?		; Category 5 Printer Control
	DD	?		; Category 6 Light Pen Control
	DD	?		; Category 7 Mouse Control
	DD	?		; Category 8 Logical Disk Control
	DD	?		; Category 9 Physical Disk Control
	DD	?		; Category 10 Character Device Monitor Control
	DD	?		; Category 11 General Device Control


KEYTABLE1:
	DD	IOKSETCP		; Function 50H Set code page
	DD	IOKSETINPUTMODE		; Function 51H Set Input Mode
	DD	IOKSETINTERIMFLAG	; Function 52H Set Interim Character Flags
	DD	IOKSETSHIFTSTATE	; Function 53H Set Shift State
	DD	IOKSETRATE		; Function 54H Set Typematic Rate and Delay
	DD	IOKNOTIFY		; Function 55H Notify of Change of Foreground Session
	DD	IOKSETHOTKEY		; Function 56H Set Session Manager Hot Key
	DD	IOKSETKCB		; Function 57H Set KCB
	DD	IOKSETCPID		; Function 58H Set codepage ID
	DD	IOKSETNOTIFY		; Function 59H Set Read/Peek notification
	DD	IOKSETSTATUS		; Function 5AH Set keyboard LEDs
	DD	IOKRESERVED		; Function 5BH Reserved
	DD	IOKSETCUSTXT		; Function 5DH Set NLS and Custom Codepage
	DD	IOKOPEN			; Function 5DH Create logical keyboard
	DD	IOCLOSE			; Function 5EH Destroy logical keyboard

KEYTABLE2:
	DD	IOKGETINPUTMODE		; Function 71H Get Input Mode
	DD	IOKGETINTEROMFLAG	; Function 72H Get Interim Flag
	DD	IOKGETSHIFTSTATE	; Function 73H Get Shift State
	DD	IOKCHARIN		; Function 74H Read character data record(s)
	DD	IOKPEEK			; Function 75H Peek character data record
	DD	IOKGETHOTKEY		; Function 76H Get Session Manager Hot Key
	DD	IOKGETKEYBOARDTYPE	; Function 77H Get Keyboard Type
	DD	IOKGETCP		; Function 78H Get Codepage ID
	DD	IOKTRANSLATE		; Function 79H Translate Scan Code To ASCII
	DD	IOKGETHWID		; Function 7AH Get Hardware ID
	DD	IOKGETCPINFO		; Function 7BH Get keyboard current CP info
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


IOKEYBOARD	PROC FAR
		MOV	SI, [DS:BP].ARGS.FUNCTION
		SUB	SI, 50H		; 50H
		SUB	SI, 21H		; 71H

		SHL	SI, 1
		SHL	SI, 1
		CALL	FAR PTR ES:KEYTABLE2[SI]
		RET
IOKEYBOARD	ENDP


;--------------------------------------------------------
; Category 4 Function 50H Set code page
;--------------------------------------------------------
;
;
;

IOKSETCP	PROC	FAR
		RET
IOKSETCP	ENDP

;--------------------------------------------------------
; Category 4 Function 51H Set Input Mode
;--------------------------------------------------------
;
;
;

IOKSETINPUTMODE	PROC	FAR
		RET
IOKSETINPUTMODE	ENDP

;--------------------------------------------------------
; Category 4 Function 52H Set Interim Character Flags
;--------------------------------------------------------
;
;
;

IOKSETINTERIMFLAG	PROC	FAR
			RET
IOKSETINTERIMFLAG	ENDP

;--------------------------------------------------------
; Category 4 Function 53H Set Shift State
;--------------------------------------------------------
;
;
;

IOKSETSHIFTSTATE	PROC	FAR
		RET
IOKSETSHIFTSTATE	ENDP

;--------------------------------------------------------
; Category 4 Function 54H Set Typematic Rate and Delay
;--------------------------------------------------------
;
;
;

IOKSETRATE	PROC	FAR
		RET
IOKSETRATE	ENDP

;--------------------------------------------------------
; Category 4 Function 55H Notify of Change of Foreground Session
;--------------------------------------------------------
;
;
;

IOKNOTIFY	PROC	FAR
		RET
IOKNOTIFY	ENDP

;--------------------------------------------------------
; Category 4 Function 56H Set Session Manager Hot Key
;--------------------------------------------------------
;
;
;

IOKSETHOTKEY	PROC	FAR
		RET
IOKSETHOTKEY	ENDP

;--------------------------------------------------------
; Category 4 Function 74H Function 57H Set KCB
;--------------------------------------------------------
;
;
;

IOKSETKCB	PROC	FAR
		RET
IOKSETKCB	ENDP

;--------------------------------------------------------
; Category 4 Function 58H Set codepage ID
;--------------------------------------------------------
;
;
;

IOKSETCPID	PROC	FAR
		RET
IOKSETCPID	ENDP

;--------------------------------------------------------
; Category 4 Function 59H Set Read/Peek notification
;--------------------------------------------------------
;
;
;

IOKSETNOTIFY	PROC	FAR
		RET
IOKSETNOTIFY	ENDP

;--------------------------------------------------------
; Category 4 Function 5AH Set keyboard LEDs
;--------------------------------------------------------
;
;
;

IOKSETSTATUS	PROC	FAR
		RET
IOKSETSTATUS	ENDP

;--------------------------------------------------------
; Category 4 Function 5BH Reserved
;--------------------------------------------------------
;
;
;

IOKRESERVED	PROC	FAR
		RET
IOKRESERVED	ENDP

;--------------------------------------------------------
; Category 4 Function 5DH Set NLS and Custom Codepage
;--------------------------------------------------------
;
;
;

IOKSETCUSTXT	PROC	FAR
		RET
IOKSETCUSTXT	ENDP

;--------------------------------------------------------
; Category 4 Function 5DH Create logical keyboard
;--------------------------------------------------------
;
;
;

IOKOPEN		PROC	FAR
		RET
IOKOPEN		ENDP

;--------------------------------------------------------
; Category 4 Function 5EH Destroy logical keyboard
;--------------------------------------------------------
;
;
;

IOCLOSE		PROC	FAR
		RET
IOCLOSE		ENDP

;--------------------------------------------------------
; Category 4 Function 71H Get Input Mode
;--------------------------------------------------------
;
;
;

IOKGETINPUTMODE	PROC	FAR
		RET
IOKGETINPUTMODE	ENDP

;--------------------------------------------------------
; Category 4 Function 72H Get Interim Flag
;--------------------------------------------------------
;
;
;

IOKGETINTEROMFLAG	PROC	FAR
			RET
IOKGETINTEROMFLAG	ENDP

;--------------------------------------------------------
; Category 4 Function 73H Get Shift State
;--------------------------------------------------------
;
;
;

IOKGETSHIFTSTATE	PROC	FAR
			RET
IOKGETSHIFTSTATE	ENDP

;--------------------------------------------------------
; Category 4 Function 76H Get Session Manager Hot Key
;--------------------------------------------------------
;
;
;

IOKGETHOTKEY	PROC	FAR
		RET
IOKGETHOTKEY	ENDP

;--------------------------------------------------------
; Category 4 Function 77H Get Keyboard Type
;--------------------------------------------------------
;
;
;

IOKGETKEYBOARDTYPE	PROC	FAR
			RET
IOKGETKEYBOARDTYPE	ENDP

;--------------------------------------------------------
; Category 4 Function 78H Get Codepage ID
;--------------------------------------------------------
;
;
;

IOKGETCP	PROC	FAR
		RET
IOKGETCP	ENDP

;--------------------------------------------------------
; Category 4 Function 79H Translate Scan Code To ASCII
;--------------------------------------------------------
;
;
;

IOKTRANSLATE	PROC	FAR
		RET
IOKTRANSLATE	ENDP

;--------------------------------------------------------
; Category 4 Function 7AH Get Hardware ID
;--------------------------------------------------------
;
;
;

IOKGETHWID	PROC	FAR
		RET
IOKGETHWID	ENDP

;--------------------------------------------------------
; Category 4 Function 7BH Get keyboard current CP info
;--------------------------------------------------------
;
;
;

IOKGETCPINFO	PROC	FAR
		RET
IOKGETCPINFO	ENDP

;--------------------------------------------------------
; Category 4 Function 74H Read character data record(s)
;--------------------------------------------------------
;
;
;

IOKCHARIN	PROC	FAR
		RET
IOKCHARIN	ENDP

;--------------------------------------------------------
; Category 4 Function 75H Peek character data record
;--------------------------------------------------------
;
;
;

IOKPEEK		PROC	FAR
		RET
IOKPEEK		ENDP

_TEXT		ENDS

		END

;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosDevIOCtl Category 4 Functions
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
;*/

_DATA		SEGMENT BYTE PUBLIC 'DATA' USE16

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
	DD	RESERVED		; Function 5BH Reserved
	DD	IOKSETCUSTXT		; Function 5CH Set NLS and Custom Codepage
	DD	IOKOPEN			; Function 5DH Create logical keyboard
	DD	IOCLOSE			; Function 5EH Destroy logical keyboard

KEYTABLE2:
	DD	IOKGETINPUTMODE		; Function 71H Get Input Mode
	DD	IOKGETINTERIMFLAG	; Function 72H Get Interim Flag
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

;--------------------------------------------------------
; Category 4 Handler
;--------------------------------------------------------

IOKEYBOARD	PROC FAR
		MOV	SI, [DS:BP].ARGS.FUNCTION
		SUB	SI, 50H		; 50H
		JB	EXIT
		CMP	SI, 0EH		; 5EH
		JBE	OK1
		SUB	SI, 21H		; 71H
		JB	EXIT
		CMP	SI, 0AH		; 7BH
		JA	EXIT
		JMP	OK2
OK1:
		SHL	SI, 1
		SHL	SI, 1
		CALL	FAR PTR ES:KEYTABLE1[SI]
		JMP	EXIT
OK2:
		SHL	SI, 1
		SHL	SI, 1
		CALL	FAR PTR ES:KEYTABLE2[SI]
EXIT:
		RET
IOKEYBOARD	ENDP

		INCLUDE	IokSetCp.asm
		INCLUDE	IokSetInputMode.asm
		INCLUDE	IokSetInterimFlag.asm
		INCLUDE	IokSetShiftState.asm
		INCLUDE	IokSetRate.asm
		INCLUDE	IokNotify.asm
		INCLUDE	IokSetHotKey.asm
		INCLUDE	IokSetKCB.asm
		INCLUDE	IokSetCPID.asm
		INCLUDE	IokSetNotify.asm
		INCLUDE	IokSetStatus.asm
		INCLUDE	IokSetCustXT.asm
		INCLUDE IokOpen.asm
		INCLUDE IokClose.asm
		INCLUDE	IokGetCp.asm
		INCLUDE	IokGetHWID.asm
		INCLUDE	IokGetInputMode.asm
		INCLUDE	IokGetInterimFlag.asm
		INCLUDE	IokGetShiftState.asm
		INCLUDE	IokGetHotKey.asm
		INCLUDE	IokGetKeyboardType.asm
		INCLUDE	IokTranslate.asm
		INCLUDE	IokGetCpInfo.asm
		INCLUDE	IokCharIn.asm
		INCLUDE	IokPeek.asm

_TEXT		ENDS

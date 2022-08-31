;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief BksCharIn DOS wrapper
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
		INCLUDE	helpers.inc
		; MacroLib
		INCLUDE bios.inc
		INCLUDE dos.inc
		; OS/2
		INCLUDE	bseerr.inc
		INCL_KBD	EQU	1
		INCLUDE	bsesub.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE'

		@BKSPROLOG	BKSCHARIN
KBDHANDLE	DW	?		;KEYBOARD HANDLE
IOWAIT		DW	?		;WAIT KEY FLAG
CHARDATA	DD	?		;
		@BKSSTART	BKSCHARIN

		XOR	BX, BX
		MOV	AX, ERROR_KBD_INVALID_HANDLE
		CMP	BX, WORD PTR [DS:BP].ARGS.KBDHANDLE
		JNZ	EXIT

		@GetROMConfig
		JC	NOENH
		TEST	BYTE PTR [ES:BX+6], 1000000b
		JZ	NOENH

;Bit(s)	Description
; 7	reserved
; 6	INT 16/AH=20h-22h supported (122-key keyboard support)
; 5	INT 16/AH=10h-12h supported (enhanced keyboard support)
; 4	INT 16/AH=0Ah supported
; 3	INT 16/AX=0306h supported
; 2	INT 16/AX=0305h supported
; 1	INT 16/AX=0304h supported
; 0	INT 16/AX=0300h supported

		@GetKbdFuncs
		TEST	AL, 100000b
		JZ	NOENH

		MOV	CX,[DS:BP].ARGS.IOWAIT
		JCXZ	@F
		@CharPeekEnh
		JNE	@F
		XOR	BX,BX
		@KbdStatus		;GET SHIFT KEY STATE
		MOV	CX, AX
		JMP	STORE
@@:
		@CharInEnh
		MOV	BX,40H
		JMP	STORE

NOENH:
		MOV	CX,[DS:BP].ARGS.IOWAIT
		JCXZ	@F
		@CharPeek
		JNE	@F
		XOR	BX,BX
		JMP	STORE
@@:
		@CharIn
		MOV	BX,40H

		@KbdStatus		;GET SHIFT KEY STATE
		MOV	CX, AX


STORE:
		PUSH	DS
		LDS	SI,[DS:BP].ARGS.CHARDATA
		MOV	[DS:SI].KBDKEYINFO.KBCI_CHCHAR,AL
		MOV	[DS:SI].KBDKEYINFO.KBCI_CHSCAN,AH
		MOV	[DS:SI].KBDKEYINFO.KBCI_FBSTATUS,BL
		MOV	[DS:SI].KBDKEYINFO.KBCI_FSSTATE,CX
		@GetTime
		MOV	WORD PTR [SI].KBDKEYINFO.KBCI_TIME,CX
		MOV	WORD PTR [SI].KBDKEYINFO.KBCI_TIME+2,DX
		POP	DS
		XOR	AX,AX
EXIT:
		@BKSEPILOG	BKSCHARIN

_TEXT		ENDS
		END

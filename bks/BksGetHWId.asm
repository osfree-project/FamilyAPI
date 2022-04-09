;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief BksGetHWId DOS wrapper
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
		INCLUDE	BSEERR.INC
		INCL_KBD	EQU	1
		INCLUDE	BSESUB.INC


_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BKSPROLOG	BKSGETHWID
KBDHANDLE	DW	?		;KEYBOARD HANDLE
KEYBOARDID	DD	?		;
RESERVED	DD	?		;
		@BKSSTART	BKSGETHWID
		MOV	AX,ERROR_KBD_PARAMETER
		XOR	BX, BX
		CMP	BX, WORD PTR [DS:BP].ARGS.RESERVED
		JNZ	EXIT
		CMP	BX, WORD PTR [DS:BP].ARGS.RESERVED+2
		JNZ	EXIT
		MOV	AX,ERROR_KBD_INVALID_HANDLE
		CMP	BX, WORD PTR [DS:BP].ARGS.KBDHANDLE
		JNZ	EXIT
		LDS	SI,[DS:BP].ARGS.KEYBOARDID
		CMP	WORD PTR [DS:SI].KBDHWID.KBD_CB, 6
		JB	EXIT

;Bitfields for feature byte 2:
;Bit(s)	Description
; 7	32-bit DMA supported
; 6	INT 16/AH=09h (keyboard functionality) supported (see #00585)
; 5	INT 15/AH=C6h (get POS data) supported
; 4	INT 15/AH=C7h (return memory map info) supported
; 3	INT 15/AH=C8h (en/disable CPU functions) supported
; 2	non-8042 keyboard controller
; 1	data streaming supported
; 0	reserved

		MOV	AX, 0C0H
		INT	15H
		JC	NOID
		TEST	BYTE PTR [ES:BX+6], 1000000b
		JZ	NOID

;Bit(s)	Description
; 7	reserved
; 6	INT 16/AH=20h-22h supported (122-key keyboard support)
; 5	INT 16/AH=10h-12h supported (enhanced keyboard support)
; 4	INT 16/AH=0Ah supported
; 3	INT 16/AX=0306h supported
; 2	INT 16/AX=0305h supported
; 1	INT 16/AX=0304h supported
; 0	INT 16/AX=0300h supported

		MOV	AX, 09H
		INT	16H
		TEST	AL, 10000b
		JZ	NOID
		
		MOV	AX, 0AH
		INT	16H
		MOV	[DS:SI].KBDHWID.KBD_ID, BX
		XOR	AX,AX
		JMP	EXIT

NOID:
		MOV	BX, 0
		MOV	AX, 40H
		MOV	ES,AX
		TEST	BYTE PTR [ES:96H], 10000b		; 101/102 keyboard installed
		MOV	[DS:SI].KBDHWID.KBD_ID, BX
		MOV	AX,NO_ERROR
		JZ	EXIT
		INC	BX
		MOV	[DS:SI].KBDHWID.KBD_ID, BX
EXIT:
		@BKSEPILOG	BKSGETHWID

_TEXT		ENDS
		END

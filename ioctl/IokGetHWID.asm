;--------------------------------------------------------
; Category 4 Function 7AH Get Hardware ID
;--------------------------------------------------------
;
;
;

IOKGETHWID	PROC	NEAR
if 0
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

		@GetROMConfig
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

		@GetKbdFuncs
		TEST	AL, 10000b
		JZ	NOID
		
		@GetKbdId
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

endif
		RET
IOKGETHWID	ENDP

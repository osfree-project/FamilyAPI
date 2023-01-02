
;--------------------------------------------------------
; Category 4 Function 73H Get Shift State
;--------------------------------------------------------
;
;
;

IOKGETSHIFTSTATE	PROC	NEAR
if 0
		@GetROMConfig
		JC	NENH
		TEST	BYTE PTR [ES:BX+6], 1000000b
		JZ	NENH

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
		JZ	NENH
		@KbdStatusEnh
		JMP	@F
NENH:
		@KbdStatus
@@:
endif
			RET
IOKGETSHIFTSTATE	ENDP

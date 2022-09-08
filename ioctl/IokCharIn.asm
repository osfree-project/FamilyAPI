
;--------------------------------------------------------
; Category 4 Function 74H Read character data record(s)
;--------------------------------------------------------
;
;Purpose
;Read Character Data Record(s)
;Parameter Packet Format
;Field
;Transfer Count
;Data· Packet Format
;Length
;WORD
;See "KbdCharln - Read Character, Scan Code" on page 3-2 for
;the CharData data structure.
;Where
;Transfer Count
;is a one word field containing the record transfer count. The sign
;bit of this word is set to request one of the following actions:
;0 Wait for the requested number of key strokes to become
;available. The device driver will block the requestor until all
;requested character data records are available and have
;been transferred to the caller.
;1 Do not wait for the requested number of key strokes to
;become available. In this case, all characters currently
;available will be transferred, up to the requested transfer
;count.
;Returns
;None
;Remarks
;This request is used to obtain one or more character data records
;from the keyboard input buffer (KIB) for the session of the currently
;active process. Note that if shift report is on then the CharData
;record may not contain a character but a shift state change in the
;shift status field.

IOKCHARIN	PROC	NEAR
		LES	SI,[DS:BP].ARGS.DDATA
		MOV	CX, [ES:SI]
		JCXZ	@F
		MOV	AH,11H
		INT	016H
		JNE	@F
		XOR	BX,BX
		JMP	STORE
@@:
		MOV	AH,10H
		INT	16H
		MOV	BX,40H
STORE:
		PUSH	DS
		LDS	SI,[DS:BP].ARGS.PARMLIST
		MOV	[DS:SI].KBDKEYINFO.KBCI_CHCHAR,AL
		MOV	[DS:SI].KBDKEYINFO.KBCI_CHSCAN,AH
		MOV	[DS:SI].KBDKEYINFO.KBCI_FBSTATUS,BL
		MOV	AH,12H		;GET SHIFT KEY STATE
		INT	16H
		MOV	[DS:SI].KBDKEYINFO.KBCI_FSSTATE,AX
		MOV	AH,2CH
		INT	21H
		MOV	WORD PTR [SI].KBDKEYINFO.KBCI_TIME,CX
		MOV	WORD PTR [SI].KBDKEYINFO.KBCI_TIME+2,DX
		POP	DS
		XOR	AX,AX
		RET
IOKCHARIN	ENDP
if 0
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
endif
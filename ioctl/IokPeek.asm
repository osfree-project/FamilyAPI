;--------------------------------------------------------
; Category 4 Function 75H Peek character data record
;--------------------------------------------------------
;
;Purpose
;Peek Character Data Record
;Parameter Packet Format
;I Fleld
;Status
;Data Packet Format
;Length
;WORD
;See "KbdCharln - Read Character, Scan Code" on page 3-2 for
;the CharData data structure.
;Where
;Status
;is a one word field which contains either Oto indicate no key
;stroke is available or 1 to indicate that a character data record is
;being returned. The sign bit is set to either 0 if the current input
;mode is ASCII or 1 if the input mode is BINARY.
;Returns
;None
;Remarks
;This request is used to obtain one character data record from the
;head of the keyboard input buffer (KIB) of the session for the currently
;active process. The character data record is not removed from the
;KIB. Note that if shift report is on then the CharData record may not
;contain a character but a shift state change in the shift status field.
;

IOKPEEK		PROC	FAR
		LES	SI,[DS:BP].ARGS.DDATA
		MOV	CX, [ES:SI]
		MOV	AH,011H
		INT	016H
		JNE	@F
		XOR	BL,BL
		JMP KP_1
@@:	
		MOV	BL,040H
KP_1:	
		PUSH DS
		LDS	SI,[DS:BP].ARGS.PARMLIST
		MOV	[DS:SI].KBDKEYINFO.KBCI_CHCHAR,AL
		MOV	[DS:SI].KBDKEYINFO.KBCI_CHSCAN,AH
		MOV	[DS:SI].KBDKEYINFO.KBCI_FBSTATUS,BL
		MOV	AH,12H
		INT	16H
		MOV	[DS:SI].KBDKEYINFO.KBCI_FSSTATE,AX
		MOV	AH,2CH
		INT	21H
		MOV	WORD PTR [DS:SI].KBDKEYINFO.KBCI_TIME,CX
		MOV	WORD PTR [DS:SI].KBDKEYINFO.KBCI_TIME+2,DX
		POP	DS
		XOR	AX,AX
		RET
IOKPEEK		ENDP

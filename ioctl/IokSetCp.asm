;--------------------------------------------------------
; Category 4 Function 50H Set code page
;--------------------------------------------------------
;
;
;

IOKSETCP	PROC	NEAR
if 0
		MOV	AX, 0AD80h
		INT	2FH
		CMP	AL, 0FFH
		MOV	AX, ERROR_KBD_INVALID_CODEPAGE
		JNE	EXIT

		MOV	BX, WORD PTR [DS:BP].ARGS.CODEPAGEID
		MOV	AX, 0AD81h
		INT	2FH
		JNC	OK
		MOV	AX, ERROR_KBD_INVALID_CODEPAGE
		JMP	EXIT
OK:
		XOR	AX, AX
endif
		RET
IOKSETCP	ENDP

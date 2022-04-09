
;--------------------------------------------------------
; Category 7 Function 57 Unmark collision area
;--------------------------------------------------------
;
;Purpose
;Frees the Mouse to Draw the Pointer anywhere on the Screen
;Parameter Packet Format
;None
;Data Packet Format
;None
;Returns
;None
;Remarks
;This function checks the pointer position, frees it if necessary, and
;allows it to draw anywhere on the screen.
;
;

IOMUNMARKCOLLISIONAREA	PROC	NEAR
			MOV	AX, ERROR_INVALID_PARAMETER
			XOR	BX, BX
			CMP	BX, WORD PTR [DS:BP].ARGS.DDATA
			JNZ	EXIT
			CMP	BX, WORD PTR [DS:BP].ARGS.DDATA+2
			JNZ	EXIT
			CMP	BX, WORD PTR [DS:BP].ARGS.PARMLIST
			JNZ	EXIT
			CMP	BX, WORD PTR [DS:BP].ARGS.PARMLIST+2
			JNZ	EXIT
			
			LES	BX, [DS:BP].ARGS.PARMLIST
			MOV	CX, [ES:BX]
			MOV	DX, [ES:BX+4]

			MOV	AX, 8H
			INT	33H

			MOV	CX, [ES:BX+2]
			MOV	DX, [ES:BX+6]

			MOV	AX, 7H
			INT	33H

			XOR	AX, AX
EXIT:
			RET
IOMUNMARKCOLLISIONAREA	ENDP

;--------------------------------------------------------
; Category 7 Function 53 Set scaling factors
;--------------------------------------------------------
;
;Purpose
;Reassigns the Current Mouse Scaling Factors
;Parameter Packet Format
;Fie Id
;Row Data
;Column Data
;Data Packet Format
;None
;Where
;Row Data
;Row coordinate scaling factor.
;Column Data
;Column coordinate scaling factor.
;Langth
;WORD
;WORD
;The scaling factor values are positive integers in the range of:
;0 < value < = (32K - 1)
;Returns
;None
;Remarks
;This function requires two 1-word caller-specified parameters.
;Scaling factors are ratio values that determine how much relative
;movement is necessary before the mouse device driver will report a
;mouse event.
;
;The ratios specify the number of mickeys per 8 pixels. The default
;ratio values are:
;Vertical/Row ratio - 16 mickeys per 8 pixels
;Horizontal/Column ratio - 8 mickeys per 8 pixels.
;
;--------------------------------------------------------------------
;
; INT 33 - MS MOUSE v1.0+ - DEFINE MICKEY/PIXEL RATIO
;
;	AX = 000Fh
;	CX = number of mickeys per 8 pixels horizontally (default 8)
;	DX = number of mickeys per 8 pixels vertically (default 16)
;SeeAlso: AX=0013h,AX=001Ah,INT 62/AX=0082h
;
IOMSETSCALEFACTORS	PROC	NEAR
			MOV	AX, ERROR_INVALID_PARAMETER
			XOR	BX, BX
			CMP	BX, WORD PTR [DS:BP].ARGS.DDATA
			JNZ	EXIT
			CMP	BX, WORD PTR [DS:BP].ARGS.DDATA+2
			JNZ	EXIT
			
			LES	BX, [DS:BP].ARGS.PARMLIST
			MOV	DX, [ES:BX]
			MOV	CX, [ES:BX+2]

			MOV	AX, 0FH
			INT	33H

			XOR	AX, AX
EXIT:
			RET
IOMSETSCALEFACTORS	ENDP

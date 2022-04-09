;--------------------------------------------------------
; Category 7 Function 59 Set pointer screen position
;--------------------------------------------------------
;
;Purpose
;Specifies/Replaces the Pointer Position
;Parameter Packet Format
;Fie Id
;Row Position
;Column Position
;Data Packet Format
;None
;Row Position
;Length
;WORD
;WORD
;The new row coordinate pointer screen position.
;Column Position
;The new column coordinate pointer screen position.
;The coordinate values are display mode dependent. Pixel values
;must be used if the display is in graphics mode. Character position
;values must be used if the display is in text mode.
;Returns
;None
;Remarks
;This function does not override functions 57H and 58H.
;If the pointer is directed into a restricted area, it remains invisible
;until moved out of the area or until the area is freed of restrictions.
;The parameter packet is a far pointer to a structure in application
;storage where the mouse device driver will read coordinate positions.
;
;------------------------------------------------------------------------
;
;INT 33 - MS MOUSE v1.0+ - POSITION MOUSE CURSOR
;
;	AX = 0004h
;	CX = column
;	DX = row
;Note:	the row and column are truncated to the next lower multiple of the cell
;	  size (typically 8x8 in text modes); however, some versions of the
;	  Microsoft documentation incorrectly state that the coordinates are
;	  rounded
;SeeAlso: AX=0003h,INT 62/AX=0081h,INT 6F/AH=10h"F_PUT_SPRITE"
;

IOMSETPTRPOS		PROC	NEAR
			MOV	AX, ERROR_INVALID_PARAMETER
			XOR	BX, BX
			CMP	BX, WORD PTR [DS:BP].ARGS.DDATA
			JNZ	EXIT
			CMP	BX, WORD PTR [DS:BP].ARGS.DDATA+2
			JNZ	EXIT
			
			LES	BX, [DS:BP].ARGS.PARMLIST
			MOV	DX, [ES:BX]
			MOV	CX, [ES:BX+2]

			MOV	AX, 04H
			INT	33H

			XOR	AX, AX
EXIT:
			RET
IOMSETPTRPOS		ENDP

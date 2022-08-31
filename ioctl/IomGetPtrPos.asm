;--------------------------------------------------------
; Category 7 Function 67 Get pointer screen position
;--------------------------------------------------------
;
;Indicates the Current Pointer Screen Position
;
;Parameter Packet Format
;None
;
;Data Packet Format
;Field			Length
;Row Position		WORD
;Column Position	WORD
;
;Where
;Row Position
;Row coordinate pointer screen position.
;Column Position
;Column coordinate pointer screen position.
;
;The coordinate values are display mode dependent. Pixel values
;are returned if the display is in graphics mode. Character position
;values are returned if the display is in text mode.
;
;Returns
;None
;
;Remarks
;This call does not require input parameters. The data packet is a far
;pointer to a structure in application storage where the mouse device
;driver will write coordinate positions.
;
;-----------------------------------------------------------------
;
;INT 33 - MS MOUSE v1.0+ - RETURN POSITION AND BUTTON STATUS
;
;	AX = 0003h
;Return: BX = button status (see #03168)
;	CX = column
;	DX = row
;Note:	in text modes, all coordinates are specified as multiples of the cell
;	  size, typically 8x8 pixels
;SeeAlso: AX=0004h,AX=000Bh,INT 2F/AX=D000h"ZWmous"
;
;

IOMGETPTRPOS		PROC	NEAR
			MOV	AX, ERROR_INVALID_PARAMETER
			XOR	BX, BX
			CMP	BX, WORD PTR [DS:BP].ARGS.PARMLIST
			JNZ	EXIT
			CMP	BX, WORD PTR [DS:BP].ARGS.PARMLIST+2
			JNZ	EXIT
			
			MOV	AX, 3
			INT	33H

			LES	BX, [DS:BP].ARGS.DDATA
			MOV	[ES:BX], DX
			MOV	[ES:BX+2], CX
			XOR	AX, AX
EXIT:
			RET
IOMGETPTRPOS		ENDP

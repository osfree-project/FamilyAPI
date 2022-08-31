;--------------------------------------------------------
; Category 7 Function 58 Mark collision area
;--------------------------------------------------------
;
;Purpose

;;Restricts the Mouse from Pointer Drawing in Specified Area(s) of the
;Screen
;
;Parameter Packet Format
;
;Field			Length
;Left Row Position	WORD
;Left Column Position	WORD
;Right Row Position	WORD
;Right Column Position	WORD
;
;Data Packet Format
;None
;
;Returns
;None
;
;Remarks
;
;This function requires one caller specified parameter. This parameter
;is an address pointing to a 8-byte structured buffer. This buffer
;defines the collision area that will be protected from being overwritten
;by system pointer draw operations.
;
;Values must be specified in either character or pixel values,
;depending on the current mode setting of the display.
;
;The data packet is a far pointer to an area in application storage
;where a collision area definition record will be read by the mouse
;device driver.
;
;If the entire screen is specified, this function disables pointer drawing
;for the session.
;
;-----------------------------------------------------------------------------
;
;	AX = 0010h
;	CX,DX = X,Y coordinates of upper left corner
;	SI,DI = X,Y coordinates of lower right corner
;Note:	mouse cursor is hidden in the specified region, and needs to be
;	  explicitly turned on again
;SeeAlso: AX=0001h,AX=0002h,AX=0007h,AX=0010h"Genius MOUSE",AX=0031h

IOMMARKCOLLISIONAREA	PROC	NEAR
			MOV	AX, ERROR_INVALID_PARAMETER
			XOR	BX, BX
			CMP	BX, WORD PTR [DS:BP].ARGS.DDATA
			JNZ	EXIT
			CMP	BX, WORD PTR [DS:BP].ARGS.DDATA+2
			JNZ	EXIT
			
			LES	BX, [DS:BP].ARGS.PARMLIST
			MOV	DX, [ES:BX]
			MOV	CX, [ES:BX+2]
			MOV	DI, [ES:BX+4]
			MOV	SI, [ES:BX+6]

			MOV	AX, 10H
			INT	33H

			XOR	AX, AX
EXIT:
			RET
IOMMARKCOLLISIONAREA	ENDP

;--------------------------------------------------------
; Category 7 Function 60 Get number of buttons
;--------------------------------------------------------
;
; Indicates Number of Buttons Supported by the Device Driver
;
; Parameter Packet Format
;
;   None
;
; Data Packet Format
;
; Field			Length
; Number Supported	WORD
;
; Where
; Number Supported
;  the data packet is a far pointer to word in application storage
;  where the mouse device driver will write a one-word return value.
;  Return values will be in the range of:
;   1 = one-button support
;   2 = two-button support
;   3 = three-button support
;
; Returns
; None
;
; Remarks
; This function requires a caller-specified address designating where
; the device driver can write a one-word return value.
;
; -----------------------------------------------------------------------
;INT 33 - MS MOUSE - RESET DRIVER AND READ STATUS
;
;	AX = 0000h
;Return: AX = status
;	    0000h hardware/driver not installed
;	    FFFFh hardware/driver installed
;	BX = number of buttons
;	    0000h other than two
;	    0002h two buttons (many drivers)
;	    0003h Mouse Systems/Logitech three-button mouse
;	    FFFFh two buttons
;Notes:	since INT 33 might be uninitialized on old machines, the caller
;	  should first check that INT 33 is neither 0000h:0000h nor points at
;	  an IRET instruction (BYTE CFh) before calling this API
;	to use mouse on a Hercules-compatible monographics card in graphics
;	  mode, you must first set 0040h:0049h to 6 for page 0 or 5 for page 1,
;	  and then call this function.	Logitech drivers v5.01 and v6.00
;	  reportedly do not correctly use Hercules graphics in dual-monitor
;	  systems, while version 4.10 does.
;	the Logitech mouse driver contains the signature string "LOGITECH"
;	  three bytes past the interrupt handler; many of the Logitech mouse
;	  utilities check for this signature.
;	Logitech MouseWare v6.30 reportedly does not support CGA video modes
;	  if no CGA is present when it is started and the video board is
;	  later switched into CGA emulation
;SeeAlso: AX=0011h,AX=0021h,AX=002Fh,INT 62/AX=007Ah,INT 74

IOMGETBUTTONCOUNT	PROC	NEAR
			MOV	AX, ERROR_INVALID_PARAMETER
			XOR	BX, BX
			CMP	BX, WORD PTR [DS:BP].ARGS.PARMLIST
			JNZ	EXIT
			CMP	BX, WORD PTR [DS:BP].ARGS.PARMLIST+2
			JNZ	EXIT
			
			MOV	AX, 0
			INT	33H

			MOV	AX, BX
			CMP	AX, 0FFFFH
			JNE	SKIP
			MOV	AX, 2
SKIP:
			LES	BX, [DS:BP].ARGS.DDATA
			MOV	[ES:BX], AX
			XOR	AX, AX
EXIT:
			RET
IOMGETBUTTONCOUNT	ENDP

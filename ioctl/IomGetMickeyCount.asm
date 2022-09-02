;--------------------------------------------------------
; Category 7 Function 61 Get number of mickeys/centimeter
;--------------------------------------------------------
;
;Purpose
;
;Indicates Mouse Setting for the Number of Mickeys/Centimeter
;
;Parameter Packet Format
;None
;
;Data Packet Format
;Field			Length
;Mickeys/Centimeter	WORD
;
;Where
;  Mickeys/Centimeter
;
;the data packet is a far pointer to a word in application storage
;where the mouse device driver will write a return value. Return
;values will be in the range of:
;0 < number of mickeys/centimeter < = (32K - 1)
;
;Returns
;None
;
;Remarks
;None
;
;----------------------------------------------------------------
;


IOMGETMICKEYCOUNT	PROC	NEAR
			RET
IOMGETMICKEYCOUNT	ENDP

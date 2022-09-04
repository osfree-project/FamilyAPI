;--------------------------------------------------------
; Category 7 Function 54 Set Event mask
;--------------------------------------------------------
;
; Brief
;
; Set event mask
;
; Parameter Packet
;
; Field			Length
; Event Mask		WORD
;
; Where
;  Event Mask is a bitfield
;
;  Bit	Meaning
; 7-15	Reserved, must be zero
;   6	Set if button 3 is down
;   5	Set if motion with button 3 down
;   4	Set if button 2 is down
;   3	Set if motion with button 2 down
;   2	Set if button 1 is down
;   1	Set if motion with button 1 down
;   0	Set if motion no buttons
;
; Returns
;
; None
;
; Remarks
;
; This is complement functon for Category 7, function 63H.
;

IOMSETEVENTMASK	PROC	NEAR
		RET
IOMSETEVENTMASK	ENDP

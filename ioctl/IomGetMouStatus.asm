;--------------------------------------------------------
; Category 7 Function 62 Get device status flags
;--------------------------------------------------------
;
; Brief
;
; Get the current mouse device driver status
;
; Parameter Packet
;
; None
;
; Data Packet
;
; Field		Length
; Status flags	WORD
;
; Where
;  Status flag is a bit field
;
; High byte
; Bit	Meaning
; 7-2	Reserved, must be zero
;  1	Set if mouse data returned in mickeys
;  0	Set if interrupt level pointer draw routine is not called
; Low byte
; Bit	Meaning
; 7-4	Reserved, must be zero
;  3	Set if pointer draw routine disabled by unsupported mode
;  2	Set if flush in progress
;  1	Set if block read in progress
;  0	Set if event queue busy with I/O
;
; Returns
; This function return to caller current mouse status flags
;
; This function is the complement to Category 7, function 5Ch
;

IOMGETMOUSTATUS	PROC	NEAR
		RET
IOMGETMOUSTATUS	ENDP

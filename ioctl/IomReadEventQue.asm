;--------------------------------------------------------
; Category 7 Function 63 Read event queue
;--------------------------------------------------------
;
; Brief
;
; Read Event Queue
;
; Parameter Packet 
;
; Field		Length
; Read Type	WORD
;
; Data Packet
;
; Field			Length
; Event Mask		WORD
; Time			DWORD
; Row Position		WORD
; Column Position	WORD
;
; Read Type = 0 - block process until event data is available
; Read Type = 1 - return NULL if event data is unavailable
;
; Returns
;
; Remarsk
;

IOMREADEVENTQUE	PROC	NEAR
		RET
IOMREADEVENTQUE	ENDP

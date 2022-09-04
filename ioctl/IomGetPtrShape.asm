;--------------------------------------------------------
; Category 7 Function 68 Get pointer shape image
;--------------------------------------------------------
;
; Brief
;
; Get Current pointer shape
;
; Parameter packet
;
; Field			Length
; Buffer Length		WORD
; Columns		WORD
; Rows			WORD
; Column Hot Spot	WORD
; Row Hot Spot		WORD
;
; Data Packet
;
; Field			Length
; Buffer Length		WORD
; Columns		WORD
; Rows			WORD
; Column Hot Spot	WORD
; Row Hot Spot		WORD
;
; Returns
;
; If buffer length is not enough then returns error and buffer length field will contain required size;
; If buffer is enough or larger then buffer length contains actual fille buffer size
; 
; Remarks
;
; Pointer shape buffer contains AND and OR masks
;

IOMGETPTRSHAPE	PROC	NEAR
		RET
IOMGETPTRSHAPE	ENDP


;--------------------------------------------------------
; Category 7 Function 64 Get event queue status
;--------------------------------------------------------
;
; Brief
;
; Get current event queue status
;
; Parameter Packet
;
; None
;
; Data Packet
;
; Field		Length
; Element Count	WORD
; Queue Size	WORD
;
;  Where Element Count is a current count elements in queue from 0 to Queue Size
;
; Remarks
;
; Queue size defined in CONFIG.SYS by QSIZE= keyword
;

IOMGETQUESTATUS	PROC	NEAR
		RET
IOMGETQUESTATUS	ENDP

;--------------------------------------------------------
; Category 7 Function 52 Screen switcher call
;--------------------------------------------------------
;
; Brief
;
; Notify about screen switch
;
; Parameter Packet
;
; Field				Length
; Session Number		WORD
; Switch Notification Type	WORD
;
; Data Packet
;
; None
;
; Session Number is a value in range 0-MaxNumberOfScreenGroup. MaxNumberOfScreenGroup defined in Global InfoSeg.
; Swith Notification Type:
;   -1 session in termination
;   >=0 Session is swithing
;
; Returns
;
; None
;
; Remarks
; 

IOMSCREENSWITCH	PROC	NEAR
		RET
IOMSCREENSWITCH	ENDP

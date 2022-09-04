;--------------------------------------------------------
; Category 7 Function 50 Allow ptr drawing after screen switch
;--------------------------------------------------------
;
; Brief
;
; Notification of session switch completion
;
; Parameter Packet
;
; None
;
; Data Packet
;
; None
;
; Returns
;
; None
;
; Remarks
;
; This function notifies the mouse device driver that a session
; switch has been completed and the pointer may now be drawn.
; It is intended to use by the session manager.
;
;
; @todo Think about Task Switcher API support here
;

IOMALLOWPTRDRAW	PROC	NEAR
		RET
IOMALLOWPTRDRAW	ENDP

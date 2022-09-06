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
!!! fix it !!!
		@MouStatus
		LES	SI, [DS:BP].ARGS.BUFFER
		MOV	[ES:SI].MOUEVENTINFO.mouev_row, DX
		MOV	[ES:SI].MOUEVENTINFO.mouev_col, CX
		MOV	[ES:SI].MOUEVENTINFO.mouev_fs, BX
		@GetTime
		mov	WORD PTR [ES:SI].MOUEVENTINFO.mouev_time,CX
		mov	WORD PTR [ES:SI].MOUEVENTINFO.mouev_time+2,DX
		RET
IOMREADEVENTQUE	ENDP

;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosDevIOCtl Category 7 Functions
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:dosdevioctl
;
;*/

_DATA		SEGMENT BYTE PUBLIC 'DATA' USE16

MOUTABLE1:
	DD	IOMALLOWPTRDRAW		; Function 50H Allow ptr drawing after screen switch
	DD	IOMUPDATEDISPLAYMODE	; Function 51H Update screen display mode
	DD	IOMSCREENSWITCH		; Function 52H Screen switcher call
	DD	IOMSETSCALEFACTORS	; Function 53H Set scaling factors
	DD	IOMSETEVENTMASK		; Function 54H Set Event mask
	DD	RESERVED		; Function 55H Reserved
	DD	IOMSETPTRSHAPE		; Function 56H Set pointer shape
	DD	IOMUNMARKCOLLISIONAREA	; Function 57H Unmark collision area
	DD	IOMMARKCOLLISIONAREA	; Function 58H Mark collision area
	DD	IOMSETPTRPOS		; Function 59H Set pointer screen position
	DD	IOMSETPROTDRAWADDRESS	; Function 5AH Set OS/2 mode pointer draw address
	DD	IOMSETREALDRAWADDRESS	; Function 5BH Set DOS mode pointer draw address
	DD	IOMSETMOUSTATUS		; Function 5CH Set device status flags
MOUTABLE2:
	DD	IOMGETBUTTONCOUNT	; Function 60H Get number of buttons
	DD	IOMGETMICKEYCOUNT	; Function 61H Get number of mickeys/centimeter
	DD	IOMGETMOUSTATUS		; Function 62H Get device status flags
	DD	IOMREADEVENTQUE		; Function 63H Read event queue
	DD	IOMGETQUESTATUS		; Function 64H Get event queue status
	DD	IOMGETEVENTMASK		; Function 65H Get event mask
	DD	IOMGETSCALEFACTORS	; Function 66H Get scaling factors
	DD	IOMGETPTRPOS		; Function 67H Get pointer screen position
	DD	IOMGETPTRSHAPE		; Function 68H Get pointer shape image
	DD	RESERVED		; Function 69H Reserved
	DD	IOMVER			; Function 6AH Return the mouse device driver level/version

_DATA	ENDS



_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

;--------------------------------------------------------
; Category 7 Handler
;--------------------------------------------------------

IOMOUSE	PROC FAR
		MOV	SI, [DS:BP].ARGS.FUNCTION
		SUB	SI, 50H		; 50H
		JB	EXIT
		CMP	SI, 0EH		; 5EH
		JBE	OK1
		SUB	SI, 10H		; 60H
		JB	EXIT
		CMP	SI, 0AH		; 6AH
		JMP	OK2
OK1:
		SHL	SI, 1
		SHL	SI, 1
		CALL	FAR PTR ES:MOUTABLE1[SI]
		JMP	EXIT
OK2:
		SHL	SI, 1
		SHL	SI, 1
		CALL	FAR PTR ES:MOUTABLE2[SI]
EXIT:
		RET
IOMOUSE	ENDP

;--------------------------------------------------------
; Category 7 Function 50 Allow ptr drawing after screen switch
;--------------------------------------------------------
;
;
;

IOMALLOWPTRDRAW	PROC	FAR
		RET
IOMALLOWPTRDRAW	ENDP

;--------------------------------------------------------
; Category 7 Function 51 Update screen display mode
;--------------------------------------------------------
;
;
;

IOMUPDATEDISPLAYMODE	PROC	FAR
			RET
IOMUPDATEDISPLAYMODE	ENDP

;--------------------------------------------------------
; Category 7 Function 52 Screen switcher call
;--------------------------------------------------------
;
;
;

IOMSCREENSWITCH	PROC	FAR
		RET
IOMSCREENSWITCH	ENDP

;--------------------------------------------------------
; Category 7 Function 53 Set scaling factors
;--------------------------------------------------------
;
;
;

IOMSETSCALEFACTORS	PROC	FAR
			RET
IOMSETSCALEFACTORS	ENDP

;--------------------------------------------------------
; Category 7 Function 54 Set Event mask
;--------------------------------------------------------
;
;
;

IOMSETEVENTMASK	PROC	FAR
		RET
IOMSETEVENTMASK	ENDP

;--------------------------------------------------------
; Category 7 Function 56 Set pointer shape
;--------------------------------------------------------
;
;
;

IOMSETPTRSHAPE	PROC	FAR
		RET
IOMSETPTRSHAPE	ENDP

;--------------------------------------------------------
; Category 7 Function 57 Unmark collision area
;--------------------------------------------------------
;
;
;

IOMUNMARKCOLLISIONAREA	PROC	FAR
			RET
IOMUNMARKCOLLISIONAREA	ENDP

;--------------------------------------------------------
; Category 7 Function 58 Mark collision area
;--------------------------------------------------------
;
;
;

IOMMARKCOLLISIONAREA	PROC	FAR
			RET
IOMMARKCOLLISIONAREA	ENDP

;--------------------------------------------------------
; Category 7 Function 59 Set pointer screen position
;--------------------------------------------------------
;
;
;

IOMSETPTRPOS	PROC	FAR
		RET
IOMSETPTRPOS	ENDP

;--------------------------------------------------------
; Category 7 Function 5A Set OS/2 mode pointer draw address
;--------------------------------------------------------
;
;
;

IOMSETPROTDRAWADDRESS	PROC	FAR
			RET
IOMSETPROTDRAWADDRESS	ENDP

;--------------------------------------------------------
; Category 7 Function 5B Set DOS mode pointer draw address
;--------------------------------------------------------
;
;
;

IOMSETREALDRAWADDRESS	PROC	FAR
			RET
IOMSETREALDRAWADDRESS	ENDP

;--------------------------------------------------------
; Category 7 Function 5C Set device status flags
;--------------------------------------------------------
;
;
;

IOMSETMOUSTATUS	PROC	FAR
		RET
IOMSETMOUSTATUS	ENDP

;--------------------------------------------------------
; Category 7 Function 60 Get number of buttons
;--------------------------------------------------------
;
;
;

IOMGETBUTTONCOUNT	PROC	FAR
			RET
IOMGETBUTTONCOUNT	ENDP

;--------------------------------------------------------
; Category 7 Function 61 Get number of mickeys/centimeter
;--------------------------------------------------------
;
;
;

IOMGETMICKEYCOUNT	PROC	FAR
			RET
IOMGETMICKEYCOUNT	ENDP

;--------------------------------------------------------
; Category 7 Function 62 Get device status flags
;--------------------------------------------------------
;
;
;

IOMGETMOUSTATUS	PROC	FAR
		RET
IOMGETMOUSTATUS	ENDP

;--------------------------------------------------------
; Category 7 Function 63 Read event queue
;--------------------------------------------------------
;
;
;

IOMREADEVENTQUE	PROC	FAR
		RET
IOMREADEVENTQUE	ENDP

;--------------------------------------------------------
; Category 7 Function 64 Get event queue status
;--------------------------------------------------------
;
;
;

IOMGETQUESTATUS	PROC	FAR
		RET
IOMGETQUESTATUS	ENDP

;--------------------------------------------------------
; Category 7 Function 65 Get event mask
;--------------------------------------------------------
;
;
;

IOMGETEVENTMASK	PROC	FAR
		RET
IOMGETEVENTMASK	ENDP

;--------------------------------------------------------
; Category 7 Function 66 Get scaling factors
;--------------------------------------------------------
;
;
;

IOMGETSCALEFACTORS	PROC	FAR
			RET
IOMGETSCALEFACTORS	ENDP

;--------------------------------------------------------
; Category 7 Function 67 Get pointer screen position
;--------------------------------------------------------
;
;
;

IOMGETPTRPOS	PROC	FAR
		RET
IOMGETPTRPOS	ENDP

;--------------------------------------------------------
; Category 7 Function 68 Get pointer shape image
;--------------------------------------------------------
;
;
;

IOMGETPTRSHAPE	PROC	FAR
		RET
IOMGETPTRSHAPE	ENDP

;--------------------------------------------------------
; Category 7 Function 6A Return the mouse device driver level/version
;--------------------------------------------------------
;
;
;

IOMVER		PROC	FAR
		RET
IOMVER		ENDP

_TEXT		ENDS

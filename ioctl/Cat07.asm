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
	DW	IOMALLOWPTRDRAW		; Function 50H Allow ptr drawing after screen switch
	DW	IOMUPDATEDISPLAYMODE	; Function 51H Update screen display mode
	DW	IOMSCREENSWITCH		; Function 52H Screen switcher call
	DW	IOMSETSCALEFACTORS	; Function 53H Set scaling factors
	DW	IOMSETEVENTMASK		; Function 54H Set Event mask
	DW	RESERVED		; Function 55H Reserved
	DW	IOMSETPTRSHAPE		; Function 56H Set pointer shape
	DW	IOMUNMARKCOLLISIONAREA	; Function 57H Unmark collision area
	DW	IOMMARKCOLLISIONAREA	; Function 58H Mark collision area
	DW	IOMSETPTRPOS		; Function 59H Set pointer screen position
	DW	IOMSETPROTDRAWADDRESS	; Function 5AH Set OS/2 mode pointer draw address
	DW	IOMSETREALDRAWADDRESS	; Function 5BH Set DOS mode pointer draw address
	DW	IOMSETMOUSTATUS		; Function 5CH Set device status flags
MOUTABLE2:
	DW	IOMGETBUTTONCOUNT	; Function 60H Get number of buttons
	DW	IOMGETMICKEYCOUNT	; Function 61H Get number of mickeys/centimeter
	DW	IOMGETMOUSTATUS		; Function 62H Get device status flags
	DW	IOMREADEVENTQUE		; Function 63H Read event queue
	DW	IOMGETQUESTATUS		; Function 64H Get event queue status
	DW	IOMGETEVENTMASK		; Function 65H Get event mask
	DW	IOMGETSCALEFACTORS	; Function 66H Get scaling factors
	DW	IOMGETPTRPOS		; Function 67H Get pointer screen position
	DW	IOMGETPTRSHAPE		; Function 68H Get pointer shape image
	DW	RESERVED		; Function 69H Reserved
	DW	IOMVER			; Function 6AH Return the mouse device driver level/version

_DATA	ENDS



_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

;--------------------------------------------------------
; Category 7 Handler
;--------------------------------------------------------

IOMOUSE		PROC NEAR
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
;		SHL	SI, 1
		CALL	WORD PTR ES:MOUTABLE1[SI]
		JMP	EXIT
OK2:
		SHL	SI, 1
;		SHL	SI, 1
		CALL	WORD PTR ES:MOUTABLE2[SI]
EXIT:
		RET
IOMOUSE		ENDP

		INCLUDE	IomAllowPtrDraw.asm
		INCLUDE	IomUpdateDisplayMode.asm
		INCLUDE	IomScreenSwitch.asm
		INCLUDE	IomSetScaleFactors.asm
		INCLUDE	IomSetEventMask.asm
		INCLUDE	IomSetPtrShape.asm
		INCLUDE	IomUnmarkCollisionArea.asm
		INCLUDE	IomMarkCollisionArea.asm
		INCLUDE	IomSetPtrPos.asm
		INCLUDE	IomSetProtDrawAddress.asm
		INCLUDE	IomSetRealDrawAddress.asm
		INCLUDE	IomSetMouStatus.asm
		INCLUDE	IomGetButtonCount.asm
		INCLUDE	IomGetMickeyCount.asm
		INCLUDE	IomGetMouStatus.asm
		INCLUDE	IomReadEventQue.asm
		INCLUDE	IomGetQueStatus.asm
		INCLUDE	IomGetEventMask.asm
		INCLUDE	IomGetScaleFactors.asm
		INCLUDE	IomGetPtrPos.asm
		INCLUDE	IomGetPtrShape.asm
		INCLUDE	IomVer.asm

_TEXT		ENDS

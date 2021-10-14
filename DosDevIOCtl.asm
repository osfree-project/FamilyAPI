;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosDevIOCtl DOS wrapper
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
; @todo May be install as INT 21H AX=44H handler for DOS IOCtl?
;
;0 NO_ERROR
;1 ERROR_INVALID_FUNCTION
;6 ERROR_INVALID_HANDLE
;15 ERROR_INVALID_DRIVE
;31 ERROR_GEN_FAILURE
;87 ERROR_INVALID_PARAMETER
;115 ERROR_PROTECTION_VIOLATION
;117 ERROR_INVALID_CATEGORY
;119 ERROR_BAD_DRIVER_LEVEL
;163 ERROR_UNCERTAIN_MEDIA
;165 ERROR_MONITORS_NOT_SUPPORTED
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE	BSEERR.INC

_DATA		SEGMENT BYTE PUBLIC 'DATA' USE16

CATTABLE:
	DD	IOSERIAL	; Category 1 Serial Device Control
	DD	RESERVED	; Category 2 Reserved
	DD	RESERVED	; Category 3 Screen/Video control
	DD	IOKEYBOARD	; Category 4 Keyboard Control
	DD	IOPRINTER	; Category 5 Printer Control
	DD	RESERVED	; Category 6 Light Pen Control
	DD	IOMOUSE		; Category 7 Mouse Control
	DD	IODISK		; Category 8 Logical Disk Control
	DD	RESERVED	; Category 9 Physical Disk Control
	DD	RESERVED	; Category 10 Character Device Monitor Control
	DD	RESERVED	; Category 11 General Device Control

MAXCATEGORY	EQU	11

SERTABLE1:
	DD	IOSSETBAUD		; Function 41H Set Baud Rate
	DD	IOSSETLINE		; Function 42H Set Line Control

KEYTABLE1:
	DD	IOKSETCP		; Function 50H Set code page
	DD	IOKSETINPUTMODE		; Function 51H Set Input Mode
	DD	IOKSETINTERIMFLAG	; Function 52H Set Interim Character Flags
	DD	IOKSETSHIFTSTATE	; Function 53H Set Shift State
	DD	IOKSETRATE		; Function 54H Set Typematic Rate and Delay
	DD	IOKNOTIFY		; Function 55H Notify of Change of Foreground Session
	DD	IOKSETHOTKEY		; Function 56H Set Session Manager Hot Key
	DD	IOKSETKCB		; Function 57H Set KCB
	DD	IOKSETCPID		; Function 58H Set codepage ID
	DD	IOKSETNOTIFY		; Function 59H Set Read/Peek notification
	DD	IOKSETSTATUS		; Function 5AH Set keyboard LEDs
	DD	RESERVED		; Function 5BH Reserved
	DD	IOKSETCUSTXT		; Function 5CH Set NLS and Custom Codepage
	DD	IOKOPEN			; Function 5DH Create logical keyboard
	DD	IOCLOSE			; Function 5EH Destroy logical keyboard

KEYTABLE2:
	DD	IOKGETINPUTMODE		; Function 71H Get Input Mode
	DD	IOKGETINTEROMFLAG	; Function 72H Get Interim Flag
	DD	IOKGETSHIFTSTATE	; Function 73H Get Shift State
	DD	IOKCHARIN		; Function 74H Read character data record(s)
	DD	IOKPEEK			; Function 75H Peek character data record
	DD	IOKGETHOTKEY		; Function 76H Get Session Manager Hot Key
	DD	IOKGETKEYBOARDTYPE	; Function 77H Get Keyboard Type
	DD	IOKGETCP		; Function 78H Get Codepage ID
	DD	IOKTRANSLATE		; Function 79H Translate Scan Code To ASCII
	DD	IOKGETHWID		; Function 7AH Get Hardware ID
	DD	IOKGETCPINFO		; Function 7BH Get keyboard current CP info

PRNTABLE1:
	DD	IOPSETFRAME		; Function 41H Set Frame control
	DD	RESERVED		; Function 42H Reserved
	DD	RESERVED		; Function 43H Reserved
	DD	IOPSETRETRY		; Function 44H Set Infinite Retry
	DD	RESERVED		; Function 45H Reserved
	DD	IOPINIT			; Function 46H Initialize printer

PRNTABLE2:
	DD	IOPGETFRAME		; Function 62H Get Frame Control
	DD	RESERVED		; Function 63H Reserved
	DD	IOPGETRETRY		; Function 64H Get Infinite Retry
	DD	RESERVED		; Function 65H Reserved
	DD	IOPGETSTATUS		; Function 66H Get Printer Status

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

DSKTABLE1:
	DD	IODLOCK			; Function 00H Lock Drive - not supported for versions below DOS 3.2
	DD	IODUNLOCK		; Function 01H Unlock Drive - not supported for versions below DOS 3.2
	DD	IODREDETERMINE		; Function 02H Redetermine Media - not supported for versions below DOS 3.2
	DD	IODSETMAP		; Function 03H Set Logical Map - not supported for versions below DOS 3.2
DSKTABLE2:
	DD	IODBLOCKREMOVABLE	; Function 20H Block Removable - not supported for versions below DOS 3.2
	DD	IODGETMAP		; Function 21H Get Logical Map - not supported for versions below DOS 3.2
DSKTABLE3:
	DD	IODSETPARAM		; Function 43H Set Device Parameters - not supported for DOS 2.X and DOS 3.X
	DD	IODWRITETRACK		; Function 44H Write Track - not supported for DOS 2.X and DOS 3.X
	DD	IODFORMATTRACK		; Function 45H Format Track - not supported for DOS 2.X and DOS 3.X
DSKTABLE4:
	DD	IODGETPARAM		; Function 63H Get Device Parameters - not supported for DOS 2.X and DOS 3.X
	DD	IODREADTACK		; Function 64H Read Track - not supported for DOS 2.X and DOS 3.X
	DD	IODVERIFYTRACK		; Function 65H Verify Track - not supported for DOS 2.X and DOS 3.X.
_DATA	ENDS



_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSDEVIOCTL
DEVHANDLE	DW	?
CATEGORY	DW	?
FUNCTION	DW	?
PARMLIST	DD	?
DDATA		DD	?
		@START	DOSDEVIOCTL
		; @todo А как проверять хэндл? По идее, хэндл определяет конкретное устройство.
		MOV	SI, SEG _DATA
		MOV	ES, SI
		MOV	SI, [DS:BP].ARGS.CATEGORY
		MOV	AX, ERROR_INVALID_CATEGORY
		CMP	SI, 0
		JZ	EXIT
		CMP	SI, MAXCATEGORY
		JA	EXIT
		DEC	SI
		SHL	SI, 1
		SHL	SI, 1
		MOV	AX, ERROR_INVALID_FUNCTION
		CALL	FAR PTR ES:CATTABLE[SI]
EXIT:
		@EPILOG	DOSDEVIOCTL

;--------------------------------------------------------
; Category/Function Reserved
;--------------------------------------------------------
; Category 5 Function 42H Reserved
; Category 5 Function 43H Reserved
; Category 5 Function 45H Reserved
; Category 5 Function 63H Reserved
; Category 5 Function 65H Reserved
; Category 4 Function 5BH Reserved
; Category 7 Function 55H Reserved
; Category 7 Function 69H Reserved
;--------------------------------------------------------

RESERVED	PROC FAR
		RET
RESERVED	ENDP

;--------------------------------------------------------
; Category 1 Handler Serial Device Control
;--------------------------------------------------------

IOSERIAL	PROC FAR
		MOV	SI, [DS:BP].ARGS.FUNCTION
		SUB	SI, 41H		; 41H
		JB	EXIT
		CMP	SI, 1H		; 42H
		JA	EXIT
		SHL	SI, 1
		SHL	SI, 1
		CALL	FAR PTR ES:SERTABLE1[SI]
EXIT:
		RET
IOSERIAL	ENDP

;--------------------------------------------------------
; Category 4 Handler
;--------------------------------------------------------

IOKEYBOARD	PROC FAR
		MOV	SI, [DS:BP].ARGS.FUNCTION
		SUB	SI, 50H		; 50H
		JB	EXIT
		CMP	SI, 0EH		; 5EH
		JBE	OK1
		SUB	SI, 21H		; 71H
		JB	EXIT
		CMP	SI, 0AH		; 7BH
		JA	EXIT
		JMP	OK2
OK1:
		SHL	SI, 1
		SHL	SI, 1
		CALL	FAR PTR ES:KEYTABLE1[SI]
		JMP	EXIT
OK2:
		SHL	SI, 1
		SHL	SI, 1
		CALL	FAR PTR ES:KEYTABLE2[SI]
EXIT:
		RET
IOKEYBOARD	ENDP

;--------------------------------------------------------
; Category 5 Handler
;--------------------------------------------------------

IOPRINTER	PROC FAR
		MOV	SI, [DS:BP].ARGS.FUNCTION
		SUB	SI, 41H		; 41H
		JB	EXIT
		CMP	SI, 05H		; 46H
		JBE	OK1
		SUB	SI, 20H		; 61H
		JB	EXIT
		CMP	SI, 05H		; 66H
		JA	EXIT
		JMP	OK2
OK1:
		SHL	SI, 1
		SHL	SI, 1
		CALL	FAR PTR ES:PRNTABLE1[SI]
		JMP	EXIT
OK2:
		SHL	SI, 1
		SHL	SI, 1
		CALL	FAR PTR ES:PRNTABLE2[SI]
EXIT:
		RET
IOPRINTER	ENDP

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
; Category 8 Handler
;--------------------------------------------------------

IODISK	PROC FAR
		MOV	SI, [DS:BP].ARGS.FUNCTION
		CMP	SI, 00H		; 00H
		JB	EXIT
		CMP	SI, 03H		; 03H
		JB	OK1
		SUB	SI, 20H		; 20H
		JB	EXIT
		CMP	SI, 01H		; 21H
		JBE	OK2
		SUB	SI, 23H		; 43H
		JB	EXIT
		CMP	SI, 02H		; 45H
		JBE	OK3
		SUB	SI, 20H		; 63H
		JB	EXIT
		CMP	SI, 02H		; 65H
		JBE	OK4
OK1:
		SHL	SI, 1
		SHL	SI, 1
		CALL	FAR PTR ES:DSKTABLE1[SI]
		JMP	EXIT
OK2:
		SHL	SI, 1
		SHL	SI, 1
		CALL	FAR PTR ES:DSKTABLE2[SI]
		JMP	EXIT
OK3:
		SHL	SI, 1
		SHL	SI, 1
		CALL	FAR PTR ES:DSKTABLE3[SI]
		JMP	EXIT
OK4:
		SHL	SI, 1
		SHL	SI, 1
		CALL	FAR PTR ES:DSKTABLE4[SI]
EXIT:
		RET
IODISK	ENDP

;--------------------------------------------------------
; Category 1 Function 41H Set Baud Rate
;--------------------------------------------------------
;
;
PP	STRUCT
	BAUD	DW	?
PP	ENDS

IOSSETBAUD	PROC	FAR
		RET
IOSSETBAUD	ENDP

;--------------------------------------------------------
; Category 1 Function 42H Set Line Control
;--------------------------------------------------------
;
;
;

IOSSETLINE	PROC	FAR
		RET
IOSSETLINE	ENDP

;--------------------------------------------------------
; Category 4 Function 50H Set code page
;--------------------------------------------------------
;
;
;

IOKSETCP	PROC	FAR
		RET
IOKSETCP	ENDP

;--------------------------------------------------------
; Category 4 Function 51H Set Input Mode
;--------------------------------------------------------
;
;
;

IOKSETINPUTMODE	PROC	FAR
		RET
IOKSETINPUTMODE	ENDP

;--------------------------------------------------------
; Category 4 Function 52H Set Interim Character Flags
;--------------------------------------------------------
;
;
;

IOKSETINTERIMFLAG	PROC	FAR
			RET
IOKSETINTERIMFLAG	ENDP

;--------------------------------------------------------
; Category 4 Function 53H Set Shift State
;--------------------------------------------------------
;
;
;

IOKSETSHIFTSTATE	PROC	FAR
		RET
IOKSETSHIFTSTATE	ENDP

;--------------------------------------------------------
; Category 4 Function 54H Set Typematic Rate and Delay
;--------------------------------------------------------
;
;
;

IOKSETRATE	PROC	FAR
		RET
IOKSETRATE	ENDP

;--------------------------------------------------------
; Category 4 Function 55H Notify of Change of Foreground Session
;--------------------------------------------------------
;
;
;

IOKNOTIFY	PROC	FAR
		RET
IOKNOTIFY	ENDP

;--------------------------------------------------------
; Category 4 Function 56H Set Session Manager Hot Key
;--------------------------------------------------------
;
;
;

IOKSETHOTKEY	PROC	FAR
		RET
IOKSETHOTKEY	ENDP

;--------------------------------------------------------
; Category 4 Function 74H Function 57H Set KCB
;--------------------------------------------------------
;
;
;

IOKSETKCB	PROC	FAR
		RET
IOKSETKCB	ENDP

;--------------------------------------------------------
; Category 4 Function 58H Set codepage ID
;--------------------------------------------------------
;
;
;

IOKSETCPID	PROC	FAR
		RET
IOKSETCPID	ENDP

;--------------------------------------------------------
; Category 4 Function 59H Set Read/Peek notification
;--------------------------------------------------------
;
;
;

IOKSETNOTIFY	PROC	FAR
		RET
IOKSETNOTIFY	ENDP

;--------------------------------------------------------
; Category 4 Function 5AH Set keyboard LEDs
;--------------------------------------------------------
;
;
;

IOKSETSTATUS	PROC	FAR
		RET
IOKSETSTATUS	ENDP


;--------------------------------------------------------
; Category 4 Function 5DH Set NLS and Custom Codepage
;--------------------------------------------------------
;
;
;

IOKSETCUSTXT	PROC	FAR
		RET
IOKSETCUSTXT	ENDP

;--------------------------------------------------------
; Category 4 Function 5DH Create logical keyboard
;--------------------------------------------------------
;
;
;

IOKOPEN		PROC	FAR
		RET
IOKOPEN		ENDP

;--------------------------------------------------------
; Category 4 Function 5EH Destroy logical keyboard
;--------------------------------------------------------
;
;
;

IOCLOSE		PROC	FAR
		RET
IOCLOSE		ENDP

;--------------------------------------------------------
; Category 4 Function 71H Get Input Mode
;--------------------------------------------------------
;
;
;

IOKGETINPUTMODE	PROC	FAR
		RET
IOKGETINPUTMODE	ENDP

;--------------------------------------------------------
; Category 4 Function 72H Get Interim Flag
;--------------------------------------------------------
;
;
;

IOKGETINTEROMFLAG	PROC	FAR
			RET
IOKGETINTEROMFLAG	ENDP

;--------------------------------------------------------
; Category 4 Function 73H Get Shift State
;--------------------------------------------------------
;
;
;

IOKGETSHIFTSTATE	PROC	FAR
			RET
IOKGETSHIFTSTATE	ENDP

;--------------------------------------------------------
; Category 4 Function 76H Get Session Manager Hot Key
;--------------------------------------------------------
;
;
;

IOKGETHOTKEY	PROC	FAR
		RET
IOKGETHOTKEY	ENDP

;--------------------------------------------------------
; Category 4 Function 77H Get Keyboard Type
;--------------------------------------------------------
;
;
;

IOKGETKEYBOARDTYPE	PROC	FAR
			RET
IOKGETKEYBOARDTYPE	ENDP

;--------------------------------------------------------
; Category 4 Function 78H Get Codepage ID
;--------------------------------------------------------
;
;
;

IOKGETCP	PROC	FAR
		RET
IOKGETCP	ENDP

;--------------------------------------------------------
; Category 4 Function 79H Translate Scan Code To ASCII
;--------------------------------------------------------
;
;
;

IOKTRANSLATE	PROC	FAR
		RET
IOKTRANSLATE	ENDP

;--------------------------------------------------------
; Category 4 Function 7AH Get Hardware ID
;--------------------------------------------------------
;
;
;

IOKGETHWID	PROC	FAR
		RET
IOKGETHWID	ENDP

;--------------------------------------------------------
; Category 4 Function 7BH Get keyboard current CP info
;--------------------------------------------------------
;
;
;

IOKGETCPINFO	PROC	FAR
		RET
IOKGETCPINFO	ENDP

;--------------------------------------------------------
; Category 4 Function 74H Read character data record(s)
;--------------------------------------------------------
;
;
;

IOKCHARIN	PROC	FAR
		RET
IOKCHARIN	ENDP

;--------------------------------------------------------
; Category 4 Function 75H Peek character data record
;--------------------------------------------------------
;
;
;

IOKPEEK		PROC	FAR
		RET
IOKPEEK		ENDP

;--------------------------------------------------------
; Category 5 Function 41H Set Frame control
;--------------------------------------------------------
;
;
;

IOPSETFRAME	PROC	FAR
		RET
IOPSETFRAME	ENDP

;--------------------------------------------------------
; Category 5 Function 44H Set Infinite Retry
;--------------------------------------------------------
;
;
;

IOPSETRETRY	PROC	FAR
		RET
IOPSETRETRY	ENDP


;--------------------------------------------------------
; Category 5 Function 46H Initialize printer
;--------------------------------------------------------
;
;
;

IOPINIT		PROC	FAR
		RET
IOPINIT		ENDP

;--------------------------------------------------------
; Category 5 Function 62H Get Frame Control
;--------------------------------------------------------
;
;
;

IOPGETFRAME	PROC	FAR
		RET
IOPGETFRAME	ENDP


;--------------------------------------------------------
; Category 5 Function 64H Get Infinite Retry
;--------------------------------------------------------
;
;
;

IOPGETRETRY	PROC	FAR
		RET
IOPGETRETRY	ENDP


;--------------------------------------------------------
; Category 5 Function 66H Get Printer Status
;--------------------------------------------------------
;
;
;

IOPGETSTATUS	PROC	FAR
		RET
IOPGETSTATUS	ENDP

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

;--------------------------------------------------------
; Category 8 Function 00H Lock Drive - not supported for versions below DOS 3.2
;--------------------------------------------------------
;
;
;

IODLOCK		PROC	FAR
		RET
IODLOCK		ENDP

;--------------------------------------------------------
; Category 8 Function 01H Unlock Drive - not supported for versions below DOS 3.2
;--------------------------------------------------------
;
;
;

IODUNLOCK	PROC	FAR
		RET
IODUNLOCK	ENDP

;--------------------------------------------------------
; Category 8 Function 02H Redetermine Media - not supported for versions below DOS 3.2
;--------------------------------------------------------
;
;
;

IODREDETERMINE	PROC	FAR
		RET
IODREDETERMINE	ENDP

;--------------------------------------------------------
; Category 8 Function 03H Set Logical Map - not supported for versions below DOS 3.2
;--------------------------------------------------------
;
;
;

IODSETMAP	PROC	FAR
		RET
IODSETMAP	ENDP

;--------------------------------------------------------
; Category 8 Function 20H Block Removable - not supported for versions below DOS 3.2
;--------------------------------------------------------
;
;
;

IODBLOCKREMOVABLE	PROC	FAR
			RET
IODBLOCKREMOVABLE	ENDP

;--------------------------------------------------------
; Category 8 Function 21H Get Logical Map - not supported for versions below DOS 3.2
;--------------------------------------------------------
;
;
;

IODGETMAP	PROC	FAR
		RET
IODGETMAP	ENDP

;--------------------------------------------------------
; Category 8 Function 43H Set Device Parameters - not supported for DOS 2.X and DOS 3.X
;--------------------------------------------------------
;
;
;

IODSETPARAM	PROC	FAR
		RET
IODSETPARAM	ENDP

;--------------------------------------------------------
; Category 8 Function 44H Write Track - not supported for DOS 2.X and DOS 3.X
;--------------------------------------------------------
;
;
;

IODWRITETRACK	PROC	FAR
		RET
IODWRITETRACK	ENDP

;--------------------------------------------------------
; Category 8 Function 45H Format Track - not supported for DOS 2.X and DOS 3.X
;--------------------------------------------------------
;
;
;

IODFORMATTRACK	PROC	FAR
		RET
IODFORMATTRACK	ENDP

;--------------------------------------------------------
; Category 8 Function 63H Get Device Parameters - not supported for DOS 2.X and DOS 3.X
;--------------------------------------------------------
;
;
;

IODGETPARAM	PROC	FAR
		RET
IODGETPARAM	ENDP

;--------------------------------------------------------
; Category 8 Function 64H Read Track - not supported for DOS 2.X and DOS 3.X
;--------------------------------------------------------
;
;
;

IODREADTACK	PROC	FAR
		RET
IODREADTACK	ENDP

;--------------------------------------------------------
; Category 8 Function 65H Verify Track - not supported for DOS 2.X and DOS 3.X.
;--------------------------------------------------------
;
;
;

IODVERIFYTRACK	PROC	FAR
		RET
IODVERIFYTRACK	ENDP


_TEXT		ENDS

		END

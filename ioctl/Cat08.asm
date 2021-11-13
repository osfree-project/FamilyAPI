;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosDevIOCtl Category 8 Functions
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

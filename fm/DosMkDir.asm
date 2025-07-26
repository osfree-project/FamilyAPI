;/*! 
; @file 
; 
; @ingroup fapi 
; 
; @copyright (c) osFree Project 2018-2025, <http://www.osFree.org>
; for licence see licence.txt in root directory, or project website
;
; @brief OS/2 API Implementation - DosMkDir
; 
; @details 
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API. Creates a new directory with enhanced error checking and
;          support for different environments including:
;          - Standard DOS (8.3 filename format)
;          - Long File Name (LFN) environments
;          - OS/2 VDM
; 
; @note    Features:
;          - Comprehensive parameter validation
;          - Filename format checking (8.3 and LFN)
;          - Error code mapping from DOS to OS/2
;          - Environment detection (DOS, Windows VDM)
; 
; @todo
;   - Add network path validation
;   - Add DosMkDir2 call, move most of code to DosMkDir2
; 
; @see
;   - Ralf Brown's Interrupt List (http://www.ctyme.com/intr/int-21.htm)
;   - IBM OS/2 Control Program Reference
;   - Microsoft DOS Programmer's Reference
;   - osFree project documentation (http://www.osfree.org)
; 
; @author Yuri Prokushev (yuri.prokushev@gmail.com)
; 
; @version 2.0.0
; 
; @history
;   2018-01-01  Yuri Prokushev  Initial version
;   2025-07-03  Yuri Prokushev  Major rewrite with environment detection,
;                               error mapping, and 8.3/LFN support
; 
;*/
 .8086
		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc
		INCLUDE	GlobalVars.inc

EXTERN		DOSMKDIR2: FAR
;-----------------------------------------------------------------------
; Code segment
;-----------------------------------------------------------------------
_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

;*************************************************************************
;
; @fn         DOSMKDIR
;
; @brief      Creates a new directory
;
; @details    This function creates a new directory with comprehensive
;             validation and support for multiple environments including
;             DOS, Windows VDM compatibility modes. It handles
;             both standard 8.3 filenames and Long File Names (LFN).
;
; @param[in]  pszDirName   Pointer to null-terminated directory path
; @param[in]  reserved     Reserved parameter (must be 0)
;
; @return     AX = 0 on success, error code on failure
;
; @retval     ERROR_INVALID_PARAMETER  - Invalid parameter value
; @retval     ERROR_INVALID_NAME       - Invalid directory name format
; @retval     ERROR_PATH_NOT_FOUND     - Path not found
; @retval     ERROR_ACCESS_DENIED      - Access denied
; @retval     ERROR_ALREADY_EXISTS     - Directory already exists
; @retval     ERROR_NOT_SUPPORTED      - Function not supported
;
; @note       Environment-specific behavior:
;             - In DOS: Uses 8.3 filename format with validation
;             - In Windows VDM: Supports LFN if available
;
;*************************************************************************
		@PROLOG	DOSMKDIR
RESERVED	DD	?    ; Reserved parameter (must be 0)
DIRNAME		DD	?    ; Pointer to directory path
@LOCALW         TmpBP
@LOCALW		TmpCS
@LOCALW		TmpIP
		@START	DOSMKDIR

		;---------------------------------------------------------------
		; Parameter validation
		;---------------------------------------------------------------
		MOV	AX,ERROR_INVALID_PARAMETER    ; Default error code
    
		; Check reserved parameter == 0
		MOV	BX, WORD PTR [BP].ARGS.RESERVED
		OR	BX, WORD PTR [BP].ARGS.RESERVED+2
		JNZ	EXIT                    ; Jump if not zero

		POP	TmpBP                  ; Pop from stack frame
		POP	TmpCS
		POP	TmpIP
		PUSH	BX			; Add Reserved=0. EA=0 becase DOSMKDIR is NULL
		PUSH	BX
		CALL	FAR PTR DOSMKDIR2       ; Call DosMkDir2

		PUSH	TmpIP                  ; Restore stack frame
		PUSH	TmpCS
		MOV	BP,TmpBP

EXIT:
		@EPILOG	DOSMKDIR                 ; Function epilogue

_TEXT		ENDS
		END

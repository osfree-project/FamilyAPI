;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosMkDir2
;
;   (c) osFree Project 2022, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc
		INCLUDE	GlobalVars.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSMKDIR2
DIRNAME		DD	?    ; Pointer to directory path
EABUF		DD	?    ; Pointer to extended attributes
RESERVED	DD	?    ; Reserved parameter (must be 0)
		@START	DOSMKDIR2
		;---------------------------------------------------------------
		; Parameter validation
		;---------------------------------------------------------------
		MOV	AX,ERROR_INVALID_PARAMETER    ; Default error code
    
		; Check reserved parameter == 0
		MOV	BX, WORD PTR [DS:BP].ARGS.RESERVED
		OR	BX, WORD PTR [DS:BP].ARGS.RESERVED+2
		JNZ	EXIT                          ; Jump if not zero

		; Check directory name pointer validity
		MOV	BX, WORD PTR [DS:BP].ARGS.DIRNAME
		MOV	SI, WORD PTR [DS:BP].ARGS.DIRNAME+2
		OR	BX, SI                        ; Check for NULL pointer
		JZ	EXIT                          ; Exit if NULL
    
		CMP	LFNAPI, 0FFFFH			; Check LFN support
		JNE	@F				; Use standard if no LFN
    
		; Check path length
		PUSH DS
		; DS:SI = path
		MOV	DS, BX
		CALL	CHECK_PATH_LENGTH
		POP	DS
		JNE	INVNAME                      ; Error if null not found

		; Use LFN version if available
		LFN_MAKE_DIR [DS:BP].ARGS.DIRNAME
		JMP	ERROR_CHECK

@@:		; @todo RBIL says this function works under Win98 realmode MS-DOS (7.20)
		; but I don't know nothing about 7.20. Need to check.
		MOV	AX, 43FFh
		PUSH	BP
		MOV	BP, 5053h
		MOV	CL, 39h
		LDS	DX, [BP].ARGS.DIRNAME
		INT	21h
		POP	BP
		JNC	ERROR_CHECK

		; Validate 8.3 filename format
		PUSH	ES
		POP	DS                           ; DS:SI = directory path
		CALL	CHECK_8_3_FORMAT            ; Validate filename format
		JC	INVNAME                           ; Jump if invalid format
    
		MAKE_DIR [DS:BP].ARGS.DIRNAME    ; Create directory
		JMP	ERROR_CHECK

;*************************************************************************
;
; Common error handling
;
;*************************************************************************
ERROR_CHECK:
		JC	ERROR_HANDLING               ; Jump on error
		JMP	SUCCESS                      ; Jump on success

ERROR_HANDLING:
		CALL CONVERT_DOS_ERROR           ; Map DOS error to OS/2 code
		JMP	EXIT

INVNAME:
		MOV	AX, ERROR_INVALID_NAME       ; Invalid name error
		JMP	EXIT

SUCCESS:
		XOR	AX, AX                       ; Return success (0)

EXIT:
		@EPILOG	DOSMKDIR2


_TEXT		ENDS

		END




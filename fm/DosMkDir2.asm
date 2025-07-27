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


;INT 21 - OS/2 v1.1+ Family API - DosSetPathInfo
;
;	AX = 5703h
;	BX = FFFFh
;	CX = size of information buffer
;	DX = level of information
;	DS:SI -> filename
;	ES:DI -> information buffer
;Return: CF clear if successful
;	CF set on error
;	    AX = error code
;SeeAlso: AX=5702h/BX=FFFFh,AX=5703h"OS/2"

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc
		INCLUDE	GlobalVars.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSMKDIR2
RESERVED	DD	?    ; Reserved parameter (must be 0)
EABUF		DD	?    ; Pointer to extended attributes
DIRNAME		DD	?    ; Pointer to directory path
		@START	DOSMKDIR2
		;---------------------------------------------------------------
		; Parameter validation
		;---------------------------------------------------------------
		MOV	AX,ERROR_INVALID_PARAMETER    ; Default error code
    
		; Check reserved parameter == 0
		MOV	BX, WORD PTR [BP].ARGS.RESERVED
		OR	BX, WORD PTR [BP].ARGS.RESERVED+2
		JNZ	ERROR                          ; Jump if not zero

		; Check directory name pointer validity
		MOV	BX, WORD PTR [BP].ARGS.DIRNAME
		MOV	SI, WORD PTR [BP].ARGS.DIRNAME+2
		OR	BX, SI                        ; Check for NULL pointer
		JZ	ERROR                         ; Exit if NULL
    
		LDS	SI, [BP].ARGS.DIRNAME
		CALL	CHECK_PATH_FORMAT
		JC	ERROR                      ; Error if null not found

		@VdmMkDir [BP].ARGS.DIRNAME
		JC	ERROR

		if 0
		; @todo RBIL says this function works under Win98 realmode MS-DOS (7.20)
		; but I don't know nothing about 7.20. Need to check.
		MOV	AX, 43FFh
		PUSH	BP
		MOV	BP, 5053h
		MOV	CL, 39h
		LDS	DX, [BP].ARGS.DIRNAME
		INT	21h
		POP	BP
		JNC	ERROR_CHECK
		endif

ERROR:
		CALL	CONVERT_DOS_ERROR           ; Map DOS error to OS/2 ErrorClass
		JMP	EXIT

SUCCESS:
		XOR	AX, AX                       ; Return success (0)

EXIT:
		@EPILOG	DOSMKDIR2


_TEXT		ENDS

		END




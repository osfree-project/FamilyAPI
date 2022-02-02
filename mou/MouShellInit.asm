;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouShellInit
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS and OS/2
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE	BSEDOS.INC
		INCLUDE	BSESUB.INC
		INCLUDE	BSEERR.INC

		;
		INCLUDE	GLOBALVARS.INC

; Global Data
_DATA		SEGMENT BYTE PUBLIC 'DATA' USE16

MOUSEFLAG	DW	0					; Is mouse device driver presented
MOUSEDD		DB	'MOUSE$', 0			; Mouse device driver name

SHELL_PID	DW	?					; PID of session manager/shell. Used by MouFree to prevent non-sesmgs call.

;-- move to stack --
MOUSEH		DW	?					; Mouse device driver handle
MOUSEA		DW	?					; ActionTaken on mouse device driver open
GBL		DW	?
LCL		DW	?
;-- move to stack --


_DATA		ENDS

EXTERN	PreMOUSHELLINIT: PROC
EXTERN	PostMOUSHELLINIT: PROC
EXTERN	PreMOUFREE: PROC
EXTERN	PostMOUFREE: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		PUBLIC	MOUSHELLINIT
MOUSHELLINIT	PROC FAR
		call		PreMOUSHELLINIT
		PUSH		ES
		PUSH		DS
		@DosOpen	MOUSEDD, MOUSEH, MOUSEA, 0, 0, 1, 42h, 0
		CMP		AX, 0
		MOV		AX, ERROR_MOUSE_NO_DEVICE
		JNE		BAD
		MOV		AX, SEG _DATA
		MOV		ES, AX
		@DosClose	ES:MOUSEH
		MOV		ES:MOUSEFLAG, 1
		@DosGetInfoSeg	GBL, LCL
		MOV		DS, ES:LCL
		MOV		AX, lis_pidCurrent
		MOV		ES:SHELL_PID, AX
		XOR		AX, AX
BAD:
		POP		DS
		POP		ES
		call		PostMOUSHELLINIT
		RETF
MOUSHELLINIT	ENDP

		PUBLIC	MOUFREE
MouFree		proc far
		CALL		PreMOUFREE
		PUSH		ES
		PUSH		DS
		MOV		AX, _DATA
		MOV		ES, AX
		@DosGetInfoSeg	GBL, LCL
		MOV		DS, ES:LCL
		MOV		AX, lis_pidCurrent
		CMP		ES:SHELL_PID, AX
		MOV		AX, ERROR_MOUSE_SMG_ONLY
		JNE		EXIT
		XOR		AX, AX
EXIT:
		POP		DS
		POP		ES
		CALL		PostMOUFREE
		RETF
MouFree		endp

_TEXT		ENDS
		END

_TEXT		ENDS
		END

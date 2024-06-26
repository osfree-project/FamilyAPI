;/*!
;   @file
;
;   @brief Shared code of VIO API DOS wrappers
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;*/

.8086
		INCLUDE	bios.inc
		INCLUDE	bseerr.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

PUBLIC VIOCHECKHANDLE
PUBLIC VIOCHECKXYH
PUBLIC VIOGOTOXYH

VIOGOTOXYH	PROC	NEAR
		CALL	VIOCHECKXYH
		JNZ	EXIT

		@SetCurPos DL, CL
		XOR     AX,AX				; SUCCESSFUL RETURN
EXIT:
		RET
VIOGOTOXYH	ENDP

VIOCHECKXYH	PROC	NEAR
		CALL	VIOCHECKHANDLE			; CHECK HANDLE FIRST
		JNZ	EXIT				; EXIT IF BAD
		; AX = 0 HERE
		CMP     CX,AX				; IS IT LESS THAN 0
		JB	ERRORROW			; GET OUT IF BAD
F19_2:
		CMP     CX,24				; IS IT GREATER THAN 24
		JBE     F19_3				; OK SO FAR
ERRORROW:
		MOV     AX,ERROR_VIO_ROW		; BAD ROW
		JMP     EXIT				; GET OUT
F19_3:
		CMP     DX,AX				; IS IT LESS THAN 0
		JB	ERRORCOL			; GET OUT IF BAD

		CMP     DX,79				; IS IT GREATER THAN 79
		JBE     EXIT				; OK SO FAR
ERRORCOL:	MOV     AX,ERROR_VIO_COL		; BAD COLUMN
EXIT:
		RET
VIOCHECKXYH	ENDP

VIOCHECKHANDLE 	PROC 	NEAR
		XOR     AX,AX				; GOOD HANDLE
		CMP	AX,BX				; IS IT ZERO
		JZ	OK				; IT IS OK
		MOV     AX,ERROR_VIO_INVALID_HANDLE	; BAD HANDLE
OK:		RET
VIOCHECKHANDLE	ENDP


_TEXT		ENDS

		END

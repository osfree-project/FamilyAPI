;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosQFileInfo DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
; @todo Rework to use common init/done code
; @todo Check for DOS 7+ because uses specific API
; @todo Add OS/2 MVDM API for extended info
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE DOS.INC
		INCLUDE BSEERR.INC

LEVEL1 struct
filedate dw ?
filetime dw ?
fileaccdate dw ?
fileacctime dw ?
writaccdate dw ?
writacctime dw ?
filesize dd ?
filealloc dd ?
fileattrib dw ?
LEVEL1 ends

LEVEL2 struct
	LEVEL1 <>
cbList dw ?
LEVEL2 ends

LEVEL3 struct
       dw ?
LEVEL3 ends

_TEXT	segment	byte public 'CODE'

DOSQFILEINFO proc far pascal uses ds bx cx dx si handle:word, infolevel:word, buffer:far ptr, buffersize:word

local dwOldPos:dword

	MOV AX,INFOLEVEL
	LDS SI,BUFFER
	CMP AX,1
	JZ LEV1
	CMP AX,2
	JZ LEV2
	CMP AX,3
	JZ LEV3
	MOV AX,124
	JMP EXIT
LEV1:
	GET_SET_DATE_TIME HANDLE, 0, 0, 0
	JC EXIT
	MOV [SI].LEVEL1.WRITACCDATE,DX
	MOV [SI].LEVEL1.WRITACCTIME,CX
	GET_SET_DATE_TIME HANDLE, 4, 0, 0
	JC @F
	MOV [SI].LEVEL1.FILEACCDATE,DX
	MOV [SI].LEVEL1.FILEACCTIME,CX
@@:    
	PUSH SI
	GET_SET_DATE_TIME HANDLE, 6, 0, 0
	POP SI
	JC @F
	MOV [SI].LEVEL1.FILEDATE,DX
	MOV [SI].LEVEL1.FILETIME,CX
@@:
	CALL GETFSIZE
	MOV WORD PTR [SI].LEVEL1.FILESIZE+0,AX
	MOV WORD PTR [SI].LEVEL1.FILESIZE+2,DX
	MOV WORD PTR [SI].LEVEL1.FILEALLOC+0,AX
	MOV WORD PTR [SI].LEVEL1.FILEALLOC+2,DX

	MOV [SI].LEVEL1.FILEATTRIB, 0

	XOR AX,AX
	JMP EXIT
LEV2:
	MOV AX,5
	JMP EXIT
LEV3:
	MOV AX,5
EXIT:
	RET
    
GETFSIZE:
	MOVE_PTR HANDLE, 0, 0, 1
	MOV WORD PTR DWOLDPOS+2,DX
	MOV WORD PTR DWOLDPOS+0,AX
	MOVE_PTR HANDLE, 0, 0, 2
	PUSH DX
	PUSH AX
	MOVE_PTR HANDLE, WORD PTR DWOLDPOS+2, WORD PTR DWOLDPOS+0, 0
	POP AX
	POP DX
	RETN

DOSQFILEINFO endp

_TEXT	ends

	end

;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief Shared code of API DOS wrappers
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;INT 21 - Windows95 - LONG FILENAME - GET FILE INFO BY HANDLE
;
;	AX = 71A6h
;	BX = file handle
;	DS:DX -> buffer for file information (see #01784)
;	CF set
;Return: CF clear if successful
;	    file information record filled
;	CF set on error
;	    AX = error code
;		7100h if function not supported
;SeeAlso: AX=71A7h/BL=00h
;
;*/

.8086
		INCLUDE DOS.INC
		INCLUDE	BSEERR.INC
		INCLUDE	GLOBALVARS.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

MS_DOS_Name_String db "MS-DOS", 0

GLOBALINIT	PROC NEAR
		CMP	[API_INITED], 0FFFFH
		JZ	EXIT

		MOV	[API_INITED], 0FFFFH
		
		GET_VERSION
		XCHG	AH, AL
		MOV	[DOS_VERSION],AX
		MOV	BX, AX
		MOV	AX, 0FFFFH
		CMP	BX, 0A14H	; >=10.20 OS/2 1.2+
		JAE	DOS10
		CMP	BX, 0A00H	; >=10.00 OS/2 1.0+
		JAE	DOS10
		CMP	BX, 0700H	; >=07.00 Windows 95+
		JAE	DOS7
		CMP	BX, 0303H	; >=03.03 MS-DOS 3.3+
		JAE	DOS33
		CMP	BX, 0300H	; >=03.00 MS-DOS 3.0+
		JAE	DOS3
		CMP	BX, 0200H	; >=02.00 MS-DOS 2.0+
		JAE	DOS2
		JMP	LFNCHECK
; TODO ERROR AND EXIT

DOS1020:	MOV	[DOS1020API], AX
DOS10:		MOV	[DOS10API], AX
		JMP	DOS33
DOS7:
		MOV	[DOS7API], AX
DOS33:
		MOV	[DOS33API], AX
DOS3:
		MOV	[DOS3API], AX
DOS2:
		MOV	[DOS2API], AX
		; Because LFN API can be supported by side drivers check it
LFNCHECK:
		MOV     BX, -1
		MOV     DX, OFFSET MAIN_BUFFER

		STC
		MOV	AX, 71A6H
		INT	21H
		JNC     LFNOK
		CMP     AX, 7100H
		JZ	DPMICHECK
LFNOK:
		MOV	LFNAPI, 0FFFFH

		; SHARE.EXE test; @todo Because Lock API can be without SHARE - need another detection method
SHARECHECK:
		MOV	AX, 1000H
		INT	21H
		CMP	AL, 0FFH
		JNZ	DPMICHECK
		MOV	SHARE, 0FFFFH

DPMICHECK:
if 0
		MOV	AX, 1687H
		INT	2FH
		CMP	AX, 0
		JNZ	EXIT		; No DPMI found
DPMIOK:
		MOV	AX, 0400H
		INT	31H
		TEST	BX, 1
		JNZ	EXIT		; We need only 16-bit DPMI host for now (sure??? May be 32-bit host also ok?)

		MOV	DPMI, 0FFFFH


;
;       Note:  This assumes that the program has
;       already called the DPMI real to protected
;       mode switch entry point and is now running
;       in protected mode
;
Test_For_MS_DOS_Ext_Code:                                                                                                        
        mov     ax, 168Ah              !!!!!!!!!!! Здесь мы уже должны быть в защищенном режиме, поэтому другой API
        mov     si, OFFSET MS_DOS_Name_String
        int     2Fh
        cmp     al, 8Ah
        jne     Have_MS_DOS_Extensions

;
;       Check for presence of Enhanced Windows 3.00
;
        mov     ax, 1600h
        int     2Fh
        test    al, 7Fh
        jnz     Have_MS_DOS_Extensions_But_No_Call_Back
endif

		
EXIT:
		RET
GLOBALINIT	ENDP

_TEXT		ENDS
		END

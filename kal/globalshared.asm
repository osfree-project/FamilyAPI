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
;   GlobalInit function initializes global structures and resources of
;   FamilyAPI. It fills GInfoSeg and LInfoSeg structures for future uses
;   in CPI functions.
;
;   GInfoSeg handled in follow logic:
;
;  gis_time                dd  ? ;time in seconds
;  gis_msecs               dd  ? ;milliseconds
;  gis_hour                db  ? ;hours
;  gis_minutes             db  ? ;minutes
;  gis_seconds             db  ? ;seconds
;  gis_hundredths          db  ? ;hundredths
;  gis_timezone            dw  ? ;minutes from UTC
;  gis_cusecTimerInterval  dw  ? ;timer interval (units = 0.0001 seconds)
;  gis_day                 db  ? ;day
;  gis_month               db  ? ;month
;  gis_year                dw  ? ;year
;  gis_weekday             db  ? ;day of week
;
;   Above fields updated using Int 08H handler (except timezone)
;
;  gis_uchMajorVersion     db  ? ;major version number
;  gis_uchMinorVersion     db  ? ;minor version number
;  gis_chRevisionLetter    db  ? ;revision letter
;
;   Above fileds filled once at startup to DOS versions
;
;  gis_sgCurrent           db  1 ;current foreground session
;  gis_sgMax               db  1 ;maximum number of sessions
;
;    Above fields filled with 1 and 1 because FamilyAPI support only 1 session
;
;  gis_cHugeShift          db  12 ;shift count for huge elements 
;
;    Above field is predefined for real mode DOS and filled via DPMI api for protected mode DOS
;
;  gis_fProtectModeOnly    db  0 ;protect mode only indicator
;
;  gis_pidForeground       dw  ? ;pid of last process in foreground session
;  gis_fDynamicSched       db  ? ;dynamic variation flag
;
;
;
;  gis_csecMaxWait         db  ? ;max wait in seconds
;  gis_cmsecMinSlice       dw  ? ;minimum timeslice (milliseconds)
;  gis_cmsecMaxSlice       dw  ? ;maximum timeslice (milliseconds)
;
;  gis_bootdrive           dw  ? ;drive from which the system was booted
;
;    Above filed contains boot drive
;
;  gis_amecRAS             db  32 dup (?) ;system trace major code flag bits
;
;    Above field is used to turn on or off trace faculty. By default all traces is off.
;
;  gis_csgWindowableVioMax db  0 ;maximum number of VIO windowable sessions
;  gis_csgPMMax            db  0 ;maximum number of pres. services sessions
;
;   Above fields always 0 because no Presentation Manager support in Family API.
;
;  Used interrupts:
;
;---------------------------------------
;INT 21 - DOS 2+ - GET DOS VERSION
;        AH = 30h
;---DOS 5+ ---
;        AL = what to return in BH
;            00h OEM number (see #01394)
;            01h version flag
;Return: AL = major version number (00h if DOS 1.x)
;        AH = minor version number
;        BL:CX = 24-bit user serial number (most versions do not use this)
;---if DOS <5 or AL=00h---
;        BH = MS-DOS OEM number (see #01394)
;---if DOS 5+ and AL=01h---
;        BH = version flag
;            bit 3: DOS is in ROM
;            other: reserved (0)
;
;---------------------------------------
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
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc
		INCLUDE	GlobalVars.inc

_GINFOSEG SEGMENT PARA PUBLIC 'GDATA' USE16
EXTERN gis_uchMajorVersion: BYTE
EXTERN gis_uchMinorVersion: BYTE
EXTERN gis_chRevisionLetter: BYTE
EXTERN gis_bootdrive: WORD
_GINFOSEG ENDS

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

MS_DOS_Name_String db "MS-DOS", 0

GLOBALINIT	PROC NEAR
		CMP	[API_INITED], 0FFFFH
		JZ	EXIT

		MOV	[API_INITED], 0FFFFH

		MOV	AX, _GINFOSEG
		MOV	ES, AX
		
		GET_VERSION
		XCHG	AH, AL
		MOV	[ES:gis_uchMajorVersion],AH
		MOV	[ES:gis_uchMinorVersion],AL
		MOV	BX, AX
		MOV	AX, 0FFFFH
		CMP	BX, 141EH	; >=20.30 OS/2 Warp 3+
		JAE	DOS2030
		CMP	BX, 0A14H	; >=10.20 OS/2 1.2+
		JAE	DOS1020
		CMP	BX, 0A00H	; >=10.00 OS/2 1.0+
		JAE	DOS10
		CMP	BX, 0700H	; >=07.00 Windows 95+
		JAE	DOS7
		CMP	BX, 0400H	; >=04.00 MS-DOS 4.0+
		JAE	DOS4
		CMP	BX, 0303H	; >=03.03 MS-DOS 3.3+
		JAE	DOS33
		CMP	BX, 0300H	; >=03.00 MS-DOS 3.0+
		JAE	DOS3
		CMP	BX, 0200H	; >=02.00 MS-DOS 2.0+
		JAE	DOS2
		JMP	LFNCHECK
; TODO ERROR AND EXIT

DOS2030:	MOV	[DOS2030API], AX
		MOV	[DOS1020API], AX
		MOV	[DOS10API], AX
		JMP	DOS4

DOS1020:	MOV	[DOS1020API], AX
DOS10:		MOV	[DOS10API], AX
		JMP	DOS33
DOS7:
		MOV	[DOS7API], AX
DOS4:
		MOV	[DOS4API], AX
DOS33:
		MOV	[DOS33API], AX
DOS3:
		MOV	[DOS3API], AX
DOS2:
		MOV	[DOS2API], AX

; Boot drive
		CMP	DOS4API, 0FFFFH
		JNZ	NOTBOOTAPI
		CMP	DOS2030API, 0FFFFH
		JNZ	NOTBOOTAPI
		MOV	AX, 3305H
		INT	21H
		XOR	DH,DH
		MOV	[ES:gis_bootdrive],DX
NOTBOOTAPI:

; Environment & cmdline
		GET_PSP
		MOV	ES,BX
		MOV	CX,BX
		MOV	ES,ES:[02CH]
		XOR	DI,DI
		XOR	AL,AL
		MOV	CX,0FFFFH
NEXTLINE:		
		REPNE SCASB
		SCASB
		JNE	NEXTLINE
		MOV	BX, ES
		MOV	AX, _LINFOSEG
		MOV	ES, AX
		MOV	[ES:lis_selEnvironment],BX
		ADD	DI,2
		MOV	[ES:lis_offCmdLine],DI

		MOV	[ES:lis_pidCurrent],CX
		MOV	[ES:lis_pidParent],0
		MOV	[ES:lis_tidCurrent],0

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
	mov	ax,1687h		; get address of DPMI host's
	int	2fh			; mode switch entry point
	or	ax,ax			; exit if no DPMI host
	jnz	EXIT
	mov	word ptr modesw,di	; save far pointer to host's
	mov	word ptr modesw+2,es	; mode switch entry point
	or	si,si			; check private data area size
	jz	@@1			; jump if no private data area

	mov	bx,si			; allocate DPMI private area
	mov	ah,48h			; allocate memory
	int	21h			; transfer to DOS
	jc	EXIT			; jump, allocation failed
	mov	es,ax			; let ES=segment of data area

@@1:	mov	ax,0			; bit 0=0 indicates 16-bit app
	call	modesw			; switch to protected mode
	jc	EXIT			; jump if mode switch failed
					; else we're in prot. mode now

DPMIOK:
		MOV	AX, 0400H
		INT	31H
		TEST	BX, 1
		JNZ	EXIT		; We need only 16-bit DPMI host for now (sure??? May be 32-bit host also ok?)

		MOV	DPMI, 0FFFFH

if 0

;
;       Note:  This assumes that the program has
;       already called the DPMI real to protected
;       mode switch entry point and is now running
;       in protected mode
;
Test_For_MS_DOS_Ext_Code:                                                                                                        
        mov     ax, 168Ah              !!!!!!!!!!! ����� �� ��� ������ ���� � ���������� ������, ������� ������ API
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
if 0
	    0Dh reset drive (see AX=710Dh)
	    39h create directory (see AX=7139h)
	    3Ah remove directory (see AX=713Ah)
	    3Bh set current directory (see AX=713Bh)
	    41h delete file (see AX=7141h)
	    43h get/set file attributes (see AX=7143h)
	    47h get current directory (see AX=7147h)
	    4Eh find first file (see AX=714Eh)
	    4Fh find next file (see AX=714Fh)
	    56h move (rename) file (see AX=7156h)
	    60h truename (see AX=7160h/CL=00h,AX=7160h/CL=02h)
	    6Ch create/open file (see AX=716Ch)
	    A0h get volume information (see AX=71A0h)
	    A1h terminate FindFirst/FindNext (see AX=71A1h)
	    A6h get file information (see AX=71A6h)
	    A7h time conversion (see AX=71A7h/BL=00h,AX=71A7h/BL=01h)
	    A8h generate short filename (see AX=71A8h)
	    A9h server create/open file (see AX=71A9h)
	    AAh create/terminate SUBST (see AX=71AAh/BH=00h,AX=71AAh/BH=02h)
endif

if 0
            6C01h open
	    6D OS/2 v1.x FAPI - "DosMkDir2"
            6E INT 21 U - OS/2 v1.x FAPI - "DosEnumAttrib"
            6F00 INT 21 U - OS/2 v1.x FAPI - "DosQMaxEASize" - GET MAXIMUM SIZE OF EXTENDED ATTR

endif


HOOKINT08:	PROC
		;MOV AX,CS
		;MOV DS,AX ;initialize ds using cs value

		MOV AH,35H ;function 31 of int 21h
		MOV AL,08H ;store cs:ip for int8h
		INT 21H  ;es:bx=cs:ip

		MOV [OLD_CS],ES
		MOV [OLD_IP],BX

		LEA DX,INT08H ;load effective address for INT 08H handler
  
		MOV AH,25H ;function 25 of int21h
		MOV AL,08H ;store new cs:ip for int 8h
		INT 21H  ;new cs:ip=ds:dx

HOOKINT08:	ENDP

INT08H: PROC

PUSH AX  ;push all the registers into stack
PUSH BX
PUSH CX
PUSH DX
PUSH SI
PUSH DI
PUSH ES
                                        
	push	ds		; Preserve data segment
	pushf			; Keep interrupt flag
	xor	ax,ax		; Zero
	mov	ds,ax		; Address BIOS data area
	cli			; Don't want a tick to interrupt us
	mov	ax,ds:[46Ch]	; Get loword of count
	mov	dx,ds:[46Eh]	; Get hiword of count
	popf			; Restore interrupt flag as provided
	pop	ds		; Restore data segment

POP ES  ;pop in LIFO fashion
POP DI
POP SI
POP DX
POP CX
POP BX
POP AX

JMP DWORD PTR CS:OLD_IP ;jump to old cs:ip

OLD_IP DW 00 ;will be used to store the location of the orginal 
OLD_CS DW 00 ;address of interrupt vector

HOOK08H:	ENDP

		END



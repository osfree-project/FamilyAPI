;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief BksGetStatus DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		; MacroLib
		INCLUDE bios.inc
		INCLUDE dos.inc
		; OS/2
		INCLUDE	bseerr.inc
		INCL_KBD	EQU	1
		INCLUDE	bsesub.inc

_TEXT	segment byte public 'CODE'

		@BKSPROLOG	BKSGETSTATUS
KBDHANDLE	DW	?		;KEYBOARD HANDLE
STATDATA	DD	?		;
		@LOCALW		B 
		@LOCALW		A
		@BKSSTART	BKSGETSTATUS
		MOV	AX, A
		MOV	AX, B
		MOV	AX, ERROR_KBD_INVALID_LENGTH
		LDS	SI,[DS:BP].ARGS.STATDATA
		CMP	WORD PTR [DS:SI].KBDINFO.KBST_CB,10
		JNE	@F
		XOR	BX, BX
		MOV	AX, ERROR_KBD_INVALID_HANDLE
		CMP	BX, WORD PTR [DS:BP].ARGS.KBDHANDLE
		JNZ	@F

IF		1
		@GetROMConfig
		JC	NOENH
		TEST	BYTE PTR [ES:BX+6], 1000000b
		JZ	NOENH

;Bit(s)	Description
; 7	reserved
; 6	INT 16/AH=20h-22h supported (122-key keyboard support)
; 5	INT 16/AH=10h-12h supported (enhanced keyboard support)
; 4	INT 16/AH=0Ah supported
; 3	INT 16/AX=0306h supported
; 2	INT 16/AX=0305h supported
; 1	INT 16/AX=0304h supported
; 0	INT 16/AX=0300h supported

		@GetKbdFuncs
		TEST	AL, 100000b
		JZ	NOENH
		@KbdStatusEnh
		JMP	@F
NOENH:
		@KbdStatusEnh
@@:
ELSE
; pseudo code here. Subject to write full code
		DB	"KBD$"
		CALL	DOSOPEN
		MOV	AX, IOCTL_KEYBOARD
		PUSH	AX
		MOV	AX, KBD_GETINPUTMODE
		PUSH	AX
		CALL	DOSDEVIOCTL
		MOV	AX, KBD_GETINTERIMFLAG
		PUSH	AX
		CALL	DOSDEVIOCTL
		MOV	AX, KBD_GETSHIFTSTATE
		PUSH	AX
		CALL	DOSDEVIOCTL
		CALL	DOSCLOSE
ENDIF
		MOV	[DS:SI].KBDINFO.KBST_FSSTATE ,AX
		XOR	AX,AX
@@:
		@BKSEPILOG	BKSGETSTATUS

_TEXT		ENDS

		END

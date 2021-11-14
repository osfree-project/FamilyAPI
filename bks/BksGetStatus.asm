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
		INCLUDE	bseerr.inc
		INCLUDE	kbd.inc

        
_TEXT	segment byte public 'CODE'

		@BKSPROLOG	BKSGETSTATUS
KBDHANDLE	DW	?		;KEYBOARD HANDLE
STATDATA	DD	?		;
		@BKSSTART	BKSGETSTATUS
		MOV	AX, ERROR_KBD_INVALID_LENGTH
		LDS	SI,[DS:BP].ARGS.STATDATA
		CMP	WORD PTR [DS:SI].KBDINFO.KBST_CB,10
		JNE	@F

IF		1
		MOV	AH,012H
		INT	016H
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
		MOV	[SI].KBDINFO.KBST_FSSTATE ,AX
		XOR	AX,AX
@@:
		@BKSEPILOG	BKSGETSTATUS

_TEXT		ENDS

		END

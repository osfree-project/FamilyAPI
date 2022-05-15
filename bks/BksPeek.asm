;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief BksCharIn DOS wrapper
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
		INCL_KBD	EQU	1
		INCLUDE	bsesub.inc

_TEXT	SEGMENT BYTE PUBLIC 'CODE'

		@BKSPROLOG	BKSPEEK
KBDHANDLE	DW	?		;KEYBOARD HANDLE
CHARDATA	DD	?		;
		@BKSSTART	BKSPEEK

		MOV	AH,011H
		INT	016H
		JNE	@F
		XOR	BL,BL
		JMP KP_1
@@:	
		MOV	BL,040H
KP_1:	
		PUSH DS
		LDS	SI,[DS:BP].ARGS.CHARDATA
		MOV	[DS:SI].KBDKEYINFO.KBCI_CHCHAR,AL
		MOV	[DS:SI].KBDKEYINFO.KBCI_CHSCAN,AH
		MOV	[DS:SI].KBDKEYINFO.KBCI_FBSTATUS,BL
		MOV	AH,12H
		INT	16H
		MOV	[DS:SI].KBDKEYINFO.KBCI_FSSTATE,AX
		MOV	AH,2CH
		INT	21H
		MOV	WORD PTR [DS:SI].KBDKEYINFO.KBCI_TIME,CX
		MOV	WORD PTR [DS:SI].KBDKEYINFO.KBCI_TIME+2,DX
		POP	DS
		XOR	AX,AX

		@BKSEPILOG	BKSPEEK
_TEXT	ENDS

	END

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
		INCLUDE	HELPERS.INC
		INCLUDE	BSEERR.INC
		INCLUDE	BSESUB.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE'

		@BKSPROLOG	BKSCHARIN
KBDHANDLE	DW	?		;KEYBOARD HANDLE
IOWAIT		DW	?		;
CHARDATA	DD	?		;
		@BKSSTART	BKSCHARIN
		MOV	CX,[DS:BP].ARGS.IOWAIT
		JCXZ	@F
		MOV	AH,11H
		INT	016H
		JNE	@F
		XOR	BX,BX
		JMP	STORE
@@:
		MOV	AH,10H
		INT	16H
		MOV	BX,40H
STORE:
		PUSH	DS
		LDS	SI,[DS:BP].ARGS.CHARDATA
		MOV	[DS:SI].KBDKEYINFO.KBCI_CHCHAR,AL
		MOV	[DS:SI].KBDKEYINFO.KBCI_CHSCAN,AH
		MOV	[DS:SI].KBDKEYINFO.KBCI_FBSTATUS,BL
		MOV	AH,12H		;GET SHIFT KEY STATE
		INT	16H
		MOV	[DS:SI].KBDKEYINFO.KBCI_FSSTATE,AX
		MOV	AH,2CH
		INT	21H
		MOV	WORD PTR [SI].KBDKEYINFO.KBCI_TIME,CX
		MOV	WORD PTR [SI].KBDKEYINFO.KBCI_TIME+2,DX
		POP	DS
		XOR	AX,AX

		@BKSEPILOG	BKSCHARIN

_TEXT		ENDS
		END

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
		INCLUDE	..\bseerr.inc

_TEXT	segment byte public 'CODE'
KBDKEYINFO struc
  kbci_chChar    db  ? ;ASCII character code
  kbci_chScan    db  ? ;Scan Code
  kbci_fbStatus  db  ? ;State of the character
  kbci_bNlsShift db  ? ;Reserved (set to zero)
  kbci_fsState   dw  ? ;state of the shift keys
  kbci_time      dd  ? ;time stamp of keystroke (ms since ipl)
KBDKEYINFO ends

		@BKSPROLOG	BKSPEEK
KBDHANDLE	DW	?		;KEYBOARD HANDLE
CHARDATA	DD	?		;
		@BKSSTART	BKSPEEK

		mov	AH,011h
		int	016h
		jne	@F
		xor	BL,BL
		jmp kp_1
@@:	
		mov	BL,040h
kp_1:	
		push DS
		lds	SI,[DS:BP].ARGS.CHARDATA
		mov	[SI].KBDKEYINFO.kbci_chChar,AL
		mov	[SI].KBDKEYINFO.kbci_chScan,AH
		mov	[SI].KBDKEYINFO.kbci_fbStatus,BL
		mov	AH,12h
		int	16h
		mov	[SI].KBDKEYINFO.kbci_fsState,AX
		xor	CX,CX
		xor	DX,DX
		mov	WORD PTR [SI].KBDKEYINFO.kbci_time,CX
		mov	WORD PTR [SI].KBDKEYINFO.kbci_time+2,DX
		pop	DS
		xor	AX,AX

		@BKSEPILOG	BKSPEEK
_TEXT	ends

	end

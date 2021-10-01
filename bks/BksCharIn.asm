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

		@BKSPROLOG	BKSCHARIN
KBDHANDLE	DW	?		;KEYBOARD HANDLE
IOWAIT		DW	?		;
CHARDATA	DD	?		;
		@BKSSTART	BKSCHARIN
		mov	CX,[DS:BP].ARGS.IOWAIT
		jcxz @F
		mov	AH,11h
		int	016h
		jne	@F
		xor	BX,BX
		jmp store
@@:
		mov	AH,10h
		int	16h
		mov	BX,40h
store:	
		push DS
		lds	SI,[DS:BP].ARGS.CHARDATA
		mov	[SI].KBDKEYINFO.kbci_chChar,AL
		mov	[SI].KBDKEYINFO.kbci_chScan,AH
		mov	[SI].KBDKEYINFO.kbci_fbStatus,BL
		mov	AH,12h		;get shift key state
		int	16h
		mov	[SI].KBDKEYINFO.kbci_fsState,AX
		mov	AH,2Ch		;get time (possibly better to get it with int 1A)
		int	21h
		mov	WORD PTR [SI].KBDKEYINFO.kbci_time,CX
		mov	WORD PTR [SI].KBDKEYINFO.kbci_time+2,DX
		pop	DS
		xor	AX,AX

		@BKSEPILOG	BKSCHARIN
_TEXT	ends

	end

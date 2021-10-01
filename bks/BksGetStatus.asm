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
		INCLUDE	..\bseerr.inc

KBDINFO struc
  kbst_cb           dw  ? ;length in bytes of this structure
  kbst_fsMask       dw  ? ;bit mask of functions to be altered
  kbst_chTurnAround dw  ? ;define TurnAround character
  kbst_fsInterim    dw  ? ;interim character flags
  kbst_fsState      dw  ? ;shift states
KBDINFO ends
        
_TEXT	segment byte public 'CODE'

		@BKSPROLOG	BKSGETSTATUS
KBDHANDLE	DW	?		;KEYBOARD HANDLE
STATDATA	DD	?		;
		@BKSSTART	BKSGETSTATUS
		mov	AX, ERROR_KBD_INVALID_LENGTH
		lds	SI,[DS:BP].ARGS.STATDATA
		cmp	word ptr [SI],000Ah
		jb	@F
		mov	AH,012h
		int	016h
		mov	[SI].KBDINFO.kbst_fsState ,AX
		xor	AX,AX
@@:

		@BKSEPILOG	BKSGETSTATUS

_TEXT	ends

	end

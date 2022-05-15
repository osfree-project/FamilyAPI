;/*!
;   @file
;
;   @brief BvsGetState DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;
; @todo add params checks
;
;*/

.8086
		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc
INCL_SUB	EQU	1
		INCLUDE	bsesub.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16


		@BVSPROLOG	BVSGETSTATE
VIOHANDLE	DW	?		;VIDEO HANDLE
RequestBlock	DD	?		;
		@BVSSTART	BVSGETSTATE

		EXTERN	VIOCHECKHANDLE: PROC
		MOV     BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

		XOR	AX,AX
EXIT:
		@BVSEPILOG	BVSGETSTATE

_TEXT		ends
		end

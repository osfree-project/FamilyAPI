;/*!
;   @file
;
;   @brief BvsSetState DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
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
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BVSPROLOG	BVSSETSTATE
VIOHANDLE	DW	?		;Video handle
REQUESTBLOCK	DD	?		;
		@BVSSTART	BVSSETSTATE

		EXTERN	VIOCHECKHANDLE: PROC
		MOV     BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

		XOR	AX, AX                   ; ALL OK

EXIT:
		@BVSEPILOG	BVSSETSTATE
_TEXT		ENDS
		END

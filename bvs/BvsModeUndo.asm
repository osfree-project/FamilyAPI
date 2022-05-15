;/*!
;   @file
;
;   @brief BvsModeUndo DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;* 0  NO_ERROR
;*421 ERROR_VIO_INVALID_PARMS
;*422 ERROR_VIO_FUNCTION_OWNED
;*423 ERROR_VIO_RETURN
;*424 ERROR_SCS_INVALID_FUNCTION
;*428 ERROR_VIO_NO_SAVE_RESTORE_THD
;*430 ERROR_VIO_ILLEGAL_DURING_POPUP
;*465 ERROR_VIO_DETACHED
;*494 ERROR_VIO_EXTENDED_SG
;
; @todo: add indicator range check
;
;*/

.8086
		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BVSPROLOG	BVSMODEUNDO
Reserved	DW	?	;Reserved (must be zero)		
KillIndic	DW	?	;Terminate indicator
OwnerIndic	DW	?	;Ownership indicator
		@BVSSTART	BVSMODEUNDO
		MOV	AX,ERROR_INVALID_PARAMETER
		XOR	BX, BX
		CMP	BX, WORD PTR [DS:BP].ARGS.RESERVED
		JNZ	EXIT

		XOR	AX, AX                   ; ALL OK

EXIT:
		@BVSEPILOG	BVSMODEUNDO
_TEXT		ENDS
		END


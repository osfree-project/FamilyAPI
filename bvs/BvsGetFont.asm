;/*!
;   @file
;
;   @brief BvsGetFont DOS wrapper
;
;   (c) osFree Project 2008-2022, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   * 0   NO_ERROR
;   * 355 ERROR_VIO_MODE
;   * 421 ERROR_VIO_INVALID_PARMS
;   * 438 ERROR_VIO_INVALID_LENGTH
;   * 465 ERROR_VIO_DETACHED
;   * 467 ERROR_VIO_FONT
;   * 494 ERROR_VIO_EXTENDED_SG
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE DOS.INC
INCL_SUB	EQU	1
		INCLUDE BSEERR.INC
		INCLUDE	BSESUB.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BVSPROLOG	BVSGETFONT
VIOHANDLE	DW	?		;Video handle
REQUESTBLOCK	DD	?		;
		@BVSSTART	BVSGETFONT

		EXTERN	VIOCHECKHANDLE: PROC
		MOV     BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

		;ASK BIOS TO RETURN VGA BITMAP FONTS
		MOV	AX, 1130H
		MOV	BH, 6			; @TODO SELECT TABLE DEPENDING ON CXCELL CYCELL
		INT	10H

		XOR	AX,AX			; ALL IS OK

EXIT:
		@BVSEPILOG	BVSGETFONT
_TEXT		ENDS
		END


;/*!
;   @file
;
;   @brief BvsGetFont DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;*0 NO_ERROR
;*355 ERROR_VIO_MODE
;*421 ERROR_VIO_INVALID_PARMS
;*438 ERROR_VIO_INVALID_LENGTH
;*465 ERROR_VIO_DETACHED
;*467 ERROR_VIO_FONT
;*494 ERROR_VIO_EXTENDED_SG
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE DOS.INC
		INCLUDE BSEERR.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

VIOFONTINFO struc
  viofi_cb      dw  ? ;length of this structure
  viofi_type    dw  ? ;request type
  viofi_cxCell  dw  ? ;pel columns in character cell
  viofi_cyCell  dw  ? ;pel rows in character cell
  viofi_pbData  dd  ? ;requested font table (returned)
  viofi_cbData  dw  ? ;length of caller supplied data area (in bytes)
VIOFONTINFO ends

		@BVSPROLOG	BVSGETFONT
VIOHANDLE	DW	?		;Video handle
REQUESTBLOCK	DD	?		;
		@BVSSTART	BVSGETFONT

		EXTERN	VIOCHECKHANDLE: PROC
		MOV     BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

;		PUSH	DS
;		PUSH    CS
;		POP     DS
;		MOV     AX,ANSI_STATE           ; GET CURRENT ANSI STATE
;		POP	DS
;		LES     DI,[DS:BP].ARGS.INDICATOR               ; GET POINTER FOR WHERE TO PUT IT
;		STOSW                           ; MOV IT THERE

		XOR     AX,AX                    ; ALL IS OK

EXIT:
		@BVSEPILOG	BVSGETFONT
_TEXT		ENDS
		END


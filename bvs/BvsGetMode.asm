;/*!
;   @file
;
;   @brief BvsGetMode DOS wrapper
;
;   (c) osFree Project 2008-2022, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
; *0  NO_ERROR
; *436 ERROR_VIO_INVALID_HANDLE
; *438 ERROR_VIO_INVALID_LENGTH
; *465 ERROR_VIO_DETACHED
; *494 ERROR_VIO_EXTENDED_SG
;
; @todo add check for structure length
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE BIOS.INC
INCL_SUB	EQU	1
		INCLUDE BSEERR.INC
		INCLUDE	BSESUB.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BVSPROLOG	BVSGETMODE
VIOHANDLE	DW	?		;Video handle
MODEINFO	DD	?		;
		@BVSSTART	BVSGETMODE

		EXTERN	VIOCHECKHANDLE: PROC
		MOV	BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

		LDS	SI, [DS:BP].ARGS.MODEINFO
		MOV	CX, [DS:SI].VIOMODEINFO.VIOMI_CB
		CMP	CX, 2
		MOV	AX, ERROR_VIO_INVALID_LENGTH
		JBE	EXIT

		@GetMode
		MOV	BX, AX

		; Frame buffer type
		MOV	AL,1
		MOV	[DS:SI].VIOMODEINFO.VIOMI_FBTYPE, AL	; TYPE: 1=TEXT MODE/3=GRAPH MODE

		CMP	CX, 3
		JBE	OK_EXIT

		; Number of Colors
		MOV	AL,4
		MOV	[DS:SI].VIOMODEINFO.VIOMI_COLOR, AL	; COLOR: 16 COLORS

		CMP	CX, 4
		JBE	OK_EXIT

		; Number of Columns
		MOV	AL, BH
		XOR	AH, AH
		MOV	[DS:SI].VIOMODEINFO.VIOMI_COL, AX	; Columns

		CMP	CX, 6
		JBE	OK_EXIT

		; Number of Rows
		MOV	AX, 40H
		MOV	ES, AX
		MOV	AX, [ES:84H]				; Number of rows for EGA and higher
		CMP	AX, 0
		JZ	OK_ROWS
		MOV	AX, 24
OK_ROWS:
		INC	AX
		MOV	[DS:SI].VIOMODEINFO.VIOMI_ROW, AX	; Rows

		CMP	CX, 8
		JBE	OK_EXIT

		; Hres

		; Vres

		; fmt_id

		; attrib

		; buf_addr

		; buf_length

		; full_length

		; partail_length

		; ext_data_addr

		MOV	AX, ERROR_VIO_INVALID_LENGTH
		JMP	EXIT

OK_EXIT:
		XOR	AX,AX
EXIT:
		@BVSEPILOG	BVSGETMODE
_TEXT		ENDS
		END


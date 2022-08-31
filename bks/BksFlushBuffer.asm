;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief BksFlushBuffer DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		; MacroLib
		INCLUDE bios.inc
		INCLUDE dos.inc
		; OS/2
		INCLUDE	bseerr.inc
		INCL_KBD	EQU	1
		INCLUDE	bsesub.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BKSPROLOG	BKSFLUSHBUFFER
KBDHANDLE	DW	?
		@BKSSTART	BKSFLUSHBUFFER
		XOR	BX, BX
		MOV	AX, ERROR_KBD_INVALID_HANDLE
		CMP	BX, WORD PTR [DS:BP].ARGS.KBDHANDLE
		JNZ	EXIT
		FLUSH_AND_READ_KBD	0
		XOR     AX,AX
EXIT:
		@BKSEPILOG	BKSFLUSHBUFFER

_TEXT		ENDS

		END

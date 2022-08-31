;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief BksGetCp DOS wrapper
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
		; MacroLib
		INCLUDE bios.inc
		INCLUDE dos.inc
		; OS/2
		INCLUDE	bseerr.inc
		INCL_KBD	EQU	1
		INCLUDE	bsesub.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BKSPROLOG	BKSGETCP
KBDHANDLE	DW	?		;KEYBOARD HANDLE
CODEPAGEID	DD	?		;
RESERVED	DD	?		;
		@BKSSTART	BKSGETCP
		MOV	AX,ERROR_KBD_PARAMETER
		XOR	BX, BX
		CMP	BX, WORD PTR [DS:BP].ARGS.RESERVED
		JNZ	EXIT
		CMP	BX, WORD PTR [DS:BP].ARGS.RESERVED+2
		JNZ	EXIT
		MOV	AX, ERROR_KBD_INVALID_HANDLE
		CMP	BX, WORD PTR [DS:BP].ARGS.KBDHANDLE
		JNZ	EXIT
;code here
EXIT:
		@BKSEPILOG	BKSGETCP

_TEXT		ENDS
		END

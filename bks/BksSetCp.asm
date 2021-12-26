;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief BksSetCp DOS wrapper
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
		INCLUDE	BSEERR.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BKSPROLOG	BKSSETCP
KBDHANDLE	DW	?		;KEYBOARD HANDLE
CODEPAGEID	DD	?		;
RESERVED	DD	?		;
		@BKSSTART	BKSSETCP
		MOV	AX,ERROR_KBD_PARAMETER
		XOR	BX, BX
		CMP	BX, WORD PTR [DS:BP].ARGS.RESERVED
		JNZ	EXIT
		CMP	BX, WORD PTR [DS:BP].ARGS.RESERVED+2
		JNZ	EXIT
; code here
EXIT:
		@BKSEPILOG	BKSSETCP

_TEXT		ENDS
		END

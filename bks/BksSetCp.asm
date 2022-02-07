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
;INT 2F - DOS 3.3+ KEYB.COM - SET KEYBOARD CODE PAGE
;
;	AX = AD81h
;	BX = code page (see #01757 at INT 21/AX=6601h)
;Return: CF set on error
;	    AX = 0001h (code page not available)
;	CF clear if successful
;Notes:	called by DISPLAY.SYS
;	this function was undocumented prior to the release of DOS 5.0
;SeeAlso: AX=AD80h,AX=AD82h
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	BSEERR.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BKSPROLOG	BKSSETCP
KBDHANDLE	DW	?		;KEYBOARD HANDLE
CODEPAGEID	DW	?		;
RESERVED	DD	?		;
		@BKSSTART	BKSSETCP
		MOV	AX,ERROR_KBD_PARAMETER
		XOR	BX, BX
		CMP	BX, WORD PTR [DS:BP].ARGS.RESERVED
		JNZ	EXIT
		CMP	BX, WORD PTR [DS:BP].ARGS.RESERVED+2
		JNZ	EXIT

		MOV	BX, WORD PTR [DS:BP].ARGS.CODEPAGEID
		MOV	AX, 0AD81h
		INT	2FH
EXIT:
		@BKSEPILOG	BKSSETCP

_TEXT		ENDS
		END

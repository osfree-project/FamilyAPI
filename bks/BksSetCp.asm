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
;INT 2F - MS-DOS 3.3+ KEYB.COM internal - INSTALLATION CHECK
;
;	AX = AD80h
;Return: AL = FFh if installed
;	    BX = version number (BH = major, BL = minor)
;	    ES:DI -> internal data (see #02972)
;	    AH destroyed (set to FFh by some implementations/versions)
;Notes:	MS-DOS 3.30, PC-DOS 4.01, MS-DOS 5.00, and MS-DOS 6.22 all report
;	  version 1.00.
;	this function was undocumented prior to the release of DOS 5.0
;	most versions of KEYB completely replace the BIOS INT 09 handler, but
;	  Novell DOS's KEYB partially uses the BIOS code and thus continues
;	  to chain to the original INT 09 at times
;	some utilities check for AX=FFFFh on return
;SeeAlso: AX=AD80h"Novell",AX=AD81h,AX=AD82h,AX=AD83h
;--------------------------------------
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
		INCLUDE	HELPERS.INC
		INCLUDE	DOS.INC
		INCLUDE	BSEERR.INC
		INCL_KBD	EQU	1
		INCLUDE	BSESUB.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BKSPROLOG	BKSSETCP
KBDHANDLE	DW	?		;KEYBOARD HANDLE
CODEPAGEID	DW	?		;
RESERVED	DD	?		;
		@BKSSTART	BKSSETCP
		MOV	AX, ERROR_KBD_PARAMETER
		XOR	BX, BX
		CMP	BX, WORD PTR [DS:BP].ARGS.RESERVED
		JNZ	EXIT
		CMP	BX, WORD PTR [DS:BP].ARGS.RESERVED+2
		JNZ	EXIT
		MOV	AX, ERROR_KBD_INVALID_HANDLE
		CMP	BX, WORD PTR [DS:BP].ARGS.KBDHANDLE
		JNZ	EXIT

		MOV	AX, 0AD80h
		INT	2FH
		CMP	AL, 0FFH
		MOV	AX, ERROR_KBD_INVALID_CODEPAGE
		JNE	EXIT

		MOV	BX, WORD PTR [DS:BP].ARGS.CODEPAGEID
		MOV	AX, 0AD81h
		INT	2FH
		JNC	OK
		MOV	AX, ERROR_KBD_INVALID_CODEPAGE
OK:
		XOR	AX, AX
EXIT:
		@BKSEPILOG	BKSSETCP

_TEXT		ENDS
		END

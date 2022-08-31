;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief BmsGetNumButtons DOS wrapper
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
		INCLUDE	mouse.inc
		; OS/2
		INCLUDE bseerr.inc
		INCLUDE bsedos.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BMSPROLOG	BMSGETNUMBUTTONS
MOUHANDLE	DW	?		;MOUSE HANDLE
NUMBEROFBUTTONS	DD	?		;NUMBER OF MOUSE BUTTONS
		@BMSSTART	BMSGETNUMBUTTONS
		XOR	BX, BX
		MOV	AX, ERROR_MOUSE_INVALID_HANDLE
		CMP	BX, WORD PTR [DS:BP].ARGS.MOUHANDLE
		JNZ	EXIT

		@DosDevIOCtl	[DS:BP].ARGS.NUMBEROFBUTTONS, , MOU_GETBUTTONCOUNT, IOCTL_POINTINGDEVICE, [DS:BP].ARGS.MOUHANDLE

EXIT:
		@BMSEPILOG	BMSGETNUMBUTTONS

_TEXT		ENDS

		END

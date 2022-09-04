;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief BmsSetPtrShape DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
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
		; OS/2
		INCLUDE bseerr.inc
		INCLUDE bsedos.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BMSPROLOG	BMSSETPTRSHAPE
MOUHANDLE	DW	?		;MOUSE HANDLE
PTRDEFREC	DD	?		;
PTRBUFFER	DD	?		;
		@BMSSTART	BMSSETPTRSHAPE
		XOR	BX, BX
		MOV	AX, ERROR_MOUSE_INVALID_HANDLE
		CMP	BX, WORD PTR [DS:BP].ARGS.MOUHANDLE
		JNZ	EXIT

		@DosDevIOCtl	[DS:BP].ARGS.PTRBUFFER, [DS:BP].ARGS.PTRDEFREC, MOU_SETPTRSHAPE, IOCTL_POINTINGDEVICE, [DS:BP].ARGS.MOUHANDLE

EXIT:
		@BMSEPILOG	BMSSETPTRSHAPE

_TEXT		ENDS

		END

;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief BmsRemovePtr DOS wrapper
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

NOPTRRECT struc
 mourt_row  dw  ? ;upper left row coordinates
 mourt_col  dw  ? ;upper left column coordinates
 mourt_cRow dw  ?
 mourt_cCol dw  ?
NOPTRRECT ends

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BMSPROLOG	BMSREMOVEPTR
MOUHANDLE	DW	?		;MOUSE HANDLE
PTRAREA		DD	?		;EXCLUDE REGION
		@BMSSTART	BMSREMOVEPTR
		MOV	AX, ERROR_MOUSE_INVALID_HANDLE
		CMP	WORD PTR [DS:BP].ARGS.MOUHANDLE, 0
		JNZ	EXIT

		@DosDevIOCtl	, [DS:BP].ARGS.PTRAREA, MOU_MARKCOLLISIONAREA, IOCTL_POINTINGDEVICE, [DS:BP].ARGS.MOUHANDLE

EXIT:
		@BMSEPILOG	BMSREMOVEPTR

_TEXT		ENDS
		END

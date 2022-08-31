;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief BmsDrawPtr DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;INT 33 - MS MOUSE v1.0+ - SHOW MOUSE CURSOR
;
;	AX = 0001h
;SeeAlso: AX=0002h,INT 16/AX=FFFEh,INT 62/AX=007Bh,INT 6F/AH=06h"F_TRACK_ON"
;
; @todo mouse presence check
;
;0 NO_ERROR
;385 ERROR_MOUSE_NO_DEVICE
;466 ERROR_MOU_DETACHED
;501 ERROR_MOUSE_NO_CONSOLE
;505 ERROR_MOU_EXTENDED_SG;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		; MacroLib
		INCLUDE	mouse.inc
		; OS/2
		INCLUDE bseerr.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BMSPROLOG	BMSDRAWPTR
MOUHANDLE	DW	?		;MOUSE HANDLE
		@BMSSTART	BMSDRAWPTR
		XOR	BX, BX
		MOV	AX, ERROR_MOUSE_INVALID_HANDLE
		CMP	BX, WORD PTR [DS:BP].ARGS.MOUHANDLE
		JNZ	EXIT
		@MouShowPointer
EXIT:
		@BMSEPILOG	BMSDRAWPTR

_TEXT		ENDS
		END

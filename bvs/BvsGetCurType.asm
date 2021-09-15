;/*!
;   @file
;
;   @brief BvsGetCurType DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;* 0         NO_ERROR 
;*355        ERROR_VIO_MODE 
;*436        ERROR_VIO_INVALID_HANDLE 
;*465        ERROR_VIO_DETACHED
;
; @todo add params checks
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE DOS.INC
		INCLUDE BSEERR.INC


_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

VIOCURSORINFO STRUC
VIOCI_YSTART DW  ? ;CURSOR START LINE
VIOCI_CEND   DW  ? ;CURSOR END LINE
VIOCI_CX     DW  ? ;CURSOR WIDTH
VIOCI_ATTR   DW  ? ;-1=HIDDEN CURSOR, ANY OTHER=NORMAL CURSOR
VIOCURSORINFO ENDS

		@BVSPROLOG	BVSGETCURTYPE
VIOHANDLE	DW	?		;VIDEO HANDLE
CURINFO		DD	?		;
		@BVSSTART	BVSGETCURTYPE

		EXTERN	VIOCHECKHANDLE: PROC
		MOV     BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

		lds	SI,[DS:BP].ARGS.CURINFO
		mov	AH,3
		xor	BH,BH
		int	10h
		xor	AH,AH
		mov	AL,CH
		and	AL,01Fh
		mov	[DS:SI].VIOCURSORINFO.VIOCI_YSTART,AX
		mov	AL,CL
		and	AL,01Fh
		mov	[DS:SI].VIOCURSORINFO.VIOCI_CEND,AX
		xor	AX,AX
		mov	[DS:SI].VIOCURSORINFO.VIOCI_CX,AX
		mov	[DS:SI].VIOCURSORINFO.VIOCI_ATTR,AX

		XOR	AX, AX
EXIT:
		@BVSEPILOG	BVSGETCURTYPE
_TEXT		ENDS
		END

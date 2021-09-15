;/*!
;   @file
;
;   @brief BvsGetCurPos DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viogetcurpos
;
;* 0          NO_ERROR 
;* 355        ERROR_VIO_MODE 
;* 436        ERROR_VIO_INVALID_HANDLE 
;* 465        ERROR_VIO_DETACHED
;
;--------------------------------------------------------------------------------
;INT 10 - VIDEO - GET CURSOR POSITION AND SIZE
;
;	AH = 03h
;	BH = page number
;	    0-3 in modes 2&3
;	    0-7 in modes 0&1
;	    0 in graphics modes
;Return: AX = 0000h (Phoenix BIOS)
;	CH = start scan line
;	CL = end scan line
;	DH = row (00h is top)
;	DL = column (00h is left)
;Notes:	a separate cursor is maintained for each of up to 8 display pages
;	many ROM BIOSes incorrectly return the default size for a color display
;	  (start 06h, end 07h) when a monochrome display is attached
;	With PhysTechSoft's PTS ROM-DOS the BH value is ignored on entry.
;SeeAlso: AH=01h,AH=02h,AH=12h/BL=34h,MEM 0040h:0050h,MEM 0040h:0060h
;--------------------------------------------------------------------------------
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE BSEERR.INC

EXTERN	VIOROUTE: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BVSPROLOG	BVSGETCURPOS
VIOHANDLE	DW	?		;Video handle
COLUMN		DD	?		;Starting column position for output
ROW		DD	?		;Starting row position for output
		@BVSSTART BVSGETCURPOS

		EXTERN	VIOCHECKHANDLE: PROC
		MOV     BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

		MOV	AH, 03H
		MOV	BH, 0
		INT	10H
		MOV	AH,0
		MOV	AL, DL
		LDS	SI,[DS:BP].ARGS.COLUMN
		MOV	[DS:SI],AX

		MOV	AL,DH
		LDS	SI,[DS:BP].ARGS.ROW
		MOV	[DS:SI],AX
		XOR	AX,AX
EXIT:
		@BVSEPILOG BVSGETCURPOS

_TEXT		ENDS
		END

;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief BmsReadEventQue DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;INT 33 - MS MOUSE v1.0+ - RETURN POSITION AND BUTTON STATUS
;
;	AX = 0003h
;Return: BX = button status (see #03168)
;	CX = column
;	DX = row
;Note:	in text modes, all coordinates are specified as multiples of the cell
;	  size, typically 8x8 pixels
;SeeAlso: AX=0004h,AX=000Bh,INT 2F/AX=D000h"ZWmous"
;
; @todo check mouse is present 
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc

MOUEVENTINFO struc
  mouev_fs   dw  ?  ;State of mouse at time event was reported
  mouev_time dd  ?  ;time since boot in milliseconds
  mouev_row  dw  ?  ;absolute/relative row position
  mouev_col  dw  ?  ;absolute/relative column position
MOUEVENTINFO ends

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BMSPROLOG	BMSREADEVENTQUE
MOUHANDLE	DW	?		;MOUSE HANDLE
READTYPE	DD	?		;
BUFFER		DD	?		;
		@BMSSTART	BMSREADEVENTQUE
		MOV	AX, 0002H
		INT	33H
		LES	SI, [DS:BP].ARGS.BUFFER
		MOV	[ES:SI].MOUEVENTINFO.mouev_row, DX
		MOV	[ES:SI].MOUEVENTINFO.mouev_col, CX
		MOV	[ES:SI].MOUEVENTINFO.mouev_fs, BX
		mov	AH,2Ch		;get time (possibly better to get it with int 1A)
		int	21h
		mov	WORD PTR [ES:SI].MOUEVENTINFO.mouev_time,CX
		mov	WORD PTR [ES:SI].MOUEVENTINFO.mouev_time+2,DX
		@BMSEPILOG	BMSREADEVENTQUE

_TEXT		ENDS

		END

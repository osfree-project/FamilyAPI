;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief BmsOpen DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
; 0 NO_ERROR
; 385 ERROR_MOUSE_NO_DEVICE
; 390 ERROR_MOUSE_INV_MODULE_PT
; 466 ERROR_MOU_DETACHED
; 501 ERROR_MOUSE_NO_CONSOLE
; 505 ERROR_MOU_EXTENDED_SG
;
;INT 33 - MS MOUSE - RESET DRIVER AND READ STATUS
;
;	AX = 0000h
;Return: AX = status
;	    0000h hardware/driver not installed
;	    FFFFh hardware/driver installed
;	BX = number of buttons
;	    0000h other than two
;	    0002h two buttons (many drivers)
;	    0003h Mouse Systems/Logitech three-button mouse
;	    FFFFh two buttons
;Notes:	since INT 33 might be uninitialized on old machines, the caller
;	  should first check that INT 33 is neither 0000h:0000h nor points at
;	  an IRET instruction (BYTE CFh) before calling this API
;	to use mouse on a Hercules-compatible monographics card in graphics
;	  mode, you must first set 0040h:0049h to 6 for page 0 or 5 for page 1,
;	  and then call this function.	Logitech drivers v5.01 and v6.00
;	  reportedly do not correctly use Hercules graphics in dual-monitor
;	  systems, while version 4.10 does.
;	the Logitech mouse driver contains the signature string "LOGITECH"
;	  three bytes past the interrupt handler; many of the Logitech mouse
;	  utilities check for this signature.
;	Logitech MouseWare v6.30 reportedly does not support CGA video modes
;	  if no CGA is present when it is started and the video board is
;	  later switched into CGA emulation
;SeeAlso: AX=0011h,AX=0021h,AX=002Fh,INT 62/AX=007Ah,INT 74
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	bseerr.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BMSPROLOG	BMSOPEN
MOUHANDLE	DW	?		;MOUSE HANDLE
DRIVERNAME	DD	?		;
		@BMSSTART	BMSOPEN
		XOR	AX, AX
		INT	33H
		CMP	AX, 0FFFFH
		MOV	AX, ERROR_MOUSE_NO_DEVICE
		JNZ	@f
		XOR	AX,AX
@@:		
		@BMSEPILOG	BMSOPEN

_TEXT		ENDS

		END

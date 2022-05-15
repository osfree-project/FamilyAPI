;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosMemAvail DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:dosmemavail
;
;INT 21 - AH = 48h DOS 2+ - ALLOCATE MEMORY
;BX = number of 16-byte paragraphs desired
;Return: CF set on error
; AX = error code
; BX = maximum available
;CF clear if successful
; AX = segment of allocated memory block
;
; @todo add panic because impossible memory size
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOS16RMEMAVAIL
MAXAVAIL	DD	?
		@START	DOS16RMEMAVAIL
		MOV	BX,0FFFFH		; Impossible thing because maximun number of 64kb segments is 16 (1024kb memory in real mode)
		MOV	AH, 48H
		INT	21H
		LES	DI, [DS:BP].ARGS.MAXAVAIL
		XOR	AX, AX
		CLC
		RCL	BX, 1		; BX*16
		RCL	AX, 1
		RCL	BX, 1
		RCL	AX, 1
		RCL	BX, 1
		RCL	AX, 1
		RCL	BX, 1
		RCL	AX, 1
		MOV	WORD PTR [ES:DI]+2, AX
		MOV	WORD PTR [ES:DI], BX
		XOR	AX, AX
		@EPILOG DOS16RMEMAVAIL

_TEXT		ENDS
		END

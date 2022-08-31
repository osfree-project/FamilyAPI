;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief BksStringIn DOS wrapper
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
		INCLUDE bios.inc
		INCLUDE dos.inc
		; OS/2
		INCLUDE	bseerr.inc
		INCL_KBD	EQU	1
		INCLUDE	bsesub.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BKSPROLOG	BKSSTRINGIN
KBDHANDLE	DW	?
IOWAIT		DW	?
BLENGTH		DD	?
CHARBUFFER	DD	?
		@BKSSTART	BKSSTRINGIN
		XOR	BX, BX
		MOV	AX, ERROR_KBD_INVALID_HANDLE
		CMP	BX, WORD PTR [DS:BP].ARGS.KBDHANDLE
		JNZ	EXIT

;buff        db  26        ;MAX NUMBER OF CHARACTERS ALLOWED (25).
;            db  ?         ;NUMBER OF CHARACTERS ENTERED BY USER.
;            db  26 dup(0) ;CHARACTERS ENTERED BY USER.

		; Prepare Buffer
		;CAPTURE STRING FROM KEYBOARD.                                    
;		MOV AH, 0AH
;		MOV DX, OFFSET BUFF
;		INT 21H                 
EXIT:

		@BKSEPILOG	BKSSTRINGIN

_TEXT		ENDS

		END

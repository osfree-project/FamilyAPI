;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief BksFlushBuffer DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;

;*/

.8086

		; Helpers
		INCLUDE	helpers.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BKSPROLOG	BKSFLUSHBUFFER
KBDHANDLE	DW	?
		@BKSSTART	BKSFLUSHBUFFER
		MOV     AX,0C00H
		INT     21H    
		XOR     AX,AX  
		@BKSEPILOG	BKSFLUSHBUFFER

_TEXT		ENDS

		END

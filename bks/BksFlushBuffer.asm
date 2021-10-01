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
KbdHandle	DW	?
		@BKSSTART	BKSFLUSHBUFFER
		mov     ax,0C00H
		int     21h    
		xor     ax,ax  
		@BKSEPILOG	BKSFLUSHBUFFER

_TEXT		ENDS

		END

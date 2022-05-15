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
		INCLUDE	dos.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BKSPROLOG	BKSFLUSHBUFFER
KBDHANDLE	DW	?
		@BKSSTART	BKSFLUSHBUFFER
		FLUSH_AND_READ_KBD	0
		XOR     AX,AX  
		@BKSEPILOG	BKSFLUSHBUFFER

_TEXT		ENDS

		END

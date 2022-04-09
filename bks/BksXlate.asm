;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief BksXlate DOS wrapper
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
		INCLUDE	BSEERR.INC
		INCL_KBD	EQU	1
		INCLUDE	BSESUB.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BKSPROLOG	BKSXLATE
KBDHANDLE	DW	?		;KEYBOARD HANDLE
XLATERECORD	DD	?		;
		@BKSSTART	BKSXLATE
; code here
		@BKSEPILOG	BKSXLATE

_TEXT		ENDS
		END

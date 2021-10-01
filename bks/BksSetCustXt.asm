;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief BksSetCustXt DOS wrapper
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

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BKSPROLOG	BKSSETCUSTXT
KBDHANDLE	DW	?		;KEYBOARD HANDLE
XLATETABLE	DD	?		;
		@BKSSTART	BKSSETCUSTXT
; code here
		@BKSEPILOG	BKSSETCUSTXT

_TEXT		ENDS
		END

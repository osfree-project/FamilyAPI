;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief BksSetCp DOS wrapper
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

		@BKSPROLOG	BKSSETCP
KBDHANDLE	DW	?		;KEYBOARD HANDLE
CODEPAGEID	DD	?		;
RESERVED	DD	?		;
		@BKSSTART	BKSSETCP
; code here
		@BKSEPILOG	BKSSETCP

_TEXT		ENDS
		END

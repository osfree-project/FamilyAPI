;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief BmsGetHotKey DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
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

		@BMSPROLOG	BMSGETHOTKET
MOUHANDLE	DW	?		;MOUSE HANDLE
BUTTONMASK	DD	?		;
		@BMSSTART	BMSGETHOTKET
; code here
		@BMSEPILOG	BMSGETHOTKET

_TEXT		ENDS

		END
;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief BmsSetHotKey DOS wrapper
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

		@BMSPROLOG	BMSSETHOTKEY
MOUHANDLE	DW	?		;MOUSE HANDLE
BUTTONMASK	DD	?		;
		@BMSSTART	BMSSETHOTKEY
; code here
		@BMSEPILOG	BMSSETHOTKEY

_TEXT		ENDS

		END

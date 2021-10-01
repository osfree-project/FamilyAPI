;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief BmsGetNumQueEl DOS wrapper
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

		@BMSPROLOG	BMSGETNUMQUEEL
MOUHANDLE	DW	?		;MOUSE HANDLE
QUEDATARECORD	DD	?		;
		@BMSSTART	BMSGETNUMQUEEL
; code here
		@BMSEPILOG	BMSGETNUMQUEEL

_TEXT		ENDS

		END

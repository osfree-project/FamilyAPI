;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief BmsGetDevStatus DOS wrapper
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

		@BMSPROLOG	BMSGETDEVSTATUS
MOUHANDLE	DW	?		;MOUSE HANDLE
DEVICESTATUS	DD	?		;STATUS OF DEVICE
		@BMSSTART	BMSGETDEVSTATUS
; code here
		@BMSEPILOG	BMSGETDEVSTATUS

_TEXT		ENDS

		END

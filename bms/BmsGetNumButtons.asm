;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief BmsGetNumButtons DOS wrapper
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
		INCLUDE	bseerr.inc
		INCL_MOU	EQU	1
		INCLUDE	bsesub.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BMSPROLOG	BMSGETNUMBUTTONS
MOUHANDLE	DW	?		;MOUSE HANDLE
NUMBEROFBUTTONS	DD	?		;NUMBER OF MOUSE BUTTONS
		@BMSSTART	BMSGETNUMBUTTONS
;		@DosDevIOCtl
		@BMSEPILOG	BMSGETNUMBUTTONS

_TEXT		ENDS

		END

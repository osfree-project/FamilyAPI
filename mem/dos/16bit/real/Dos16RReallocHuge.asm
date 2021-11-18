;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosReallocHuge DOS wrapper
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

_TEXT		SEGMENT DWORD PUBLIC 'CODE' USE16

		@PROLOG	DOS16RREALLOCHUGE
NumSeg		DW	?
Size		DW	?
Selector	DW	?
		@START	DOS16RREALLOCHUGE
; code here
		@EPILOG	DOS16RREALLOCHUGE

_TEXT		ENDS

		END

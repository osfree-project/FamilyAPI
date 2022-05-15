;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosMemAvail DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:dosmemavail
;
;*/

.8086

		INCLUDE	GlobalVars.inc

EXTERN		DOS16PMEMAVAIL: PROC
EXTERN		DOS16RMEMAVAIL: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

DOSMEMAVAIL	PROC
		CMP	DPMI, 0FFFFH
		JZ	DOS16PMEMAVAIL
		JMP	DOS16RMEMAVAIL
DOSMEMAVAIL	ENDP

_TEXT		ENDS
		END

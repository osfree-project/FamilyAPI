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

		INCLUDE	GLOBALVARS.INC

EXTERN		DOS16PREALLOCSEG: PROC
EXTERN		DOS16RREALLOCSEG: PROC

_TEXT  segment byte public 'CODE'

DOSREALLOCSEG	PROC
		CMP	DPMI, 0FFFFH
		JZ	DOS16PREALLOCSEG
		JMP	DOS16RREALLOCSEG
DOSREALLOCSEG	ENDP

_TEXT ends

		end

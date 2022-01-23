;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosReallocHuge DOS wrapper
;
;   (c) osFree Project 2022, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:dosreallochuge
;
;*/

		.8086

		INCLUDE	GLOBALVARS.INC

EXTERN		DOS16PREALLOCHUGE: PROC
EXTERN		DOS16RREALLOCHUGE: PROC

_TEXT  segment byte public 'CODE'

DOSREALLOCHUGE	PROC
		CMP	DPMI, 0FFFFH
		JZ	DOS16PREALLOCHUGE
		JMP	DOS16RREALLOCHUGE
DOSREALLOCHUGE	ENDP

_TEXT ends

		end

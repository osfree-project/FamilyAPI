;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosAllocHuge router
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:dosallochuge
;
;*/

.8086

		; Helpers
		INCLUDE	GlobalVars.inc

EXTERN		DOS16PALLOCHUGE: PROC
EXTERN		DOS16RALLOCHUGE: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

DOSALLOCHUGE	PROC
		CMP	DPMI, 0FFFFH
		JZ	DOS16PALLOCHUGE
		JMP	DOS16RALLOCHUGE
DOSALLOCHUGE	ENDP

_TEXT		ENDS

		END

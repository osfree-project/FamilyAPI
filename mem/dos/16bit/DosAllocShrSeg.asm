;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosAllocShrSeg DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:dosallocshrseg
;
;*/

.8086

		INCLUDE	GLOBALVARS.INC

EXTERN		DOS16PALLOCSHRSEG: PROC
EXTERN		DOS16RALLOCSHRSEG: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

DOSALLOCSHRSEG	PROC
		CMP	DPMI, 0FFFFH
		JZ	DOS16PALLOCSHRSEG
		JMP	DOS16RALLOCSHRSEG
DOSALLOCSHRSEG	ENDP

_TEXT		ENDS
		END

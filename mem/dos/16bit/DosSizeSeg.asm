;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosAllocSeg DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:dosallocseg
;
;*/

.8086
		INCLUDE	GlobalVars.inc

EXTERN		DOS16PSIZESEG: PROC
EXTERN		DOS16RSIZESEG: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

DOSSIZESEG	PROC
		CMP	DPMI, 0FFFFH
		JZ	DOS16PSIZESEG
		JMP	DOS16RSIZESEG
DOSSIZESEG	ENDP

_TEXT		ENDS

		END

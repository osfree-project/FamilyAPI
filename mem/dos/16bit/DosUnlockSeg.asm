;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosUnlockSeg DOS wrapper
;
;   (c) osFree Project 2022, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:dosunlockseg
;
;*/

.8086

		INCLUDE	GlobalVars.inc

EXTERN		DOS16PUNLOCKSEG: PROC
EXTERN		DOS16RUNLOCKSEG: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

DOSUNLOCKSEG	PROC
		CMP	DPMI, 0FFFFH
		JZ	DOS16PUNLOCKSEG
		JMP	DOS16RUNLOCKSEG
DOSUNLOCKSEG	ENDP

_TEXT		ENDS

		END


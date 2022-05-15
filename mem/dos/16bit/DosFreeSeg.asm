;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosFreeSeg DOS wrapper
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

		INCLUDE	GlobalVars.inc

EXTERN		DOS16PFREESEG: PROC
EXTERN		DOS16RFREESEG: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

DOSFREESEG	PROC
		CMP	DPMI, 0FFFFH
		JZ	DOS16PFREESEG
		JMP	DOS16RFREESEG
DOSFREESEG	ENDP

_TEXT		ENDS

		END

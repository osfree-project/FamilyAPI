;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosGetShrSeg DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:dosgetshrseg
;
;*/

.8086

		INCLUDE	GlobalVars.inc

EXTERN		DOS16PGETSHRSEG: PROC
EXTERN		DOS16RGETSHRSEG: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

DOSGETSHRSEG	PROC
		CMP	DPMI, 0FFFFH
		JZ	DOS16PGETSHRSEG
		JMP	DOS16RGETSHRSEG
DOSGETSHRSEG	ENDP

_TEXT		ENDS

		END


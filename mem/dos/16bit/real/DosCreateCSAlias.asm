;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosCreateCSAlias DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
; @todo In protected mode use DPMI function?
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSCREATECSALIAS
DATASELECTOR	DW	?
CODESELECTOR	DD	?
		@START	DOSCREATECSALIAS
		LDS     BX, [DS:BP].ARGS.CODESELECTOR
		MOV     AX, [DS:BP].ARGS.DATASELECTOR
		MOV     DS:[BX], AX
		XOR     AX, AX
		@EPILOG	DOSCREATECSALIAS

_TEXT		ENDS

		END

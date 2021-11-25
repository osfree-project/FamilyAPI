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
;@todo need to support up to 256 named segments
;@todo if size = 0 then allocate max
;@todo name arg support
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:dosallocshrseg
;
;0 NO_ERROR
;8 ERROR_NOT_ENOUGH_MEMORY
;123 ERROR_INVALID_NAME
;183 ERROR_ALREADY_EXISTS
;
;*/

.8086

		INCLUDE	HELPERS.INC
		INCLUDE	BSEERR.INC

PUBLIC	SHRSEG
_DATA		SEGMENT BYTE PUBLIC 'DATA'
SHRSEG		DW 0
_DATA		ENDS

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOS16RALLOCSHRSEG
SELECTOR	DD	?
SNAME		DD	?
WSIZE		DW	?
		@START	DOS16RALLOCSHRSEG

		MOV     AX,_DATA
		MOV     DS,AX
		ASSUME  DS:_DATA
		CMP     WORD PTR SHRSEG,0
		JZ      @F
		MOV     AX,ERROR_ALREADY_EXISTS
		JMP     EXIT
@@:
		MOV     BX,[DS:BP].ARGS.WSIZE
		SHR     BX,1
		SHR     BX,1
		SHR     BX,1
		SHR     BX,1
		INC     BX
		MOV     AH,48H
		INT     21H
		MOV     BX,AX
		MOV     AX,ERROR_NOT_ENOUGH_MEMORY
		JC      EXIT
		MOV     AX,_DATA
		MOV     DS,AX
		MOV     SHRSEG,BX
		LES     DI,[DS:BP].ARGS.SELECTOR
		MOV     [ES:DI],BX
		XOR     AX,AX
EXIT:
		@EPILOG	DOS16RALLOCSHRSEG

_TEXT		ENDS
		END

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
;@todo check filename (need to implement in dosallocshrseg first)
;
;*0 NO_ERROR 
;*2 ERROR_FILE_NOT_FOUND 
;*4 ERROR_TOO_MANY_OPEN_FILES 
;*123 ERROR_INVALID_NAME
;@todo if size = 0 then allocate max
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		; OS/2
		INCLUDE	bseerr.inc


_DATA		SEGMENT BYTE PUBLIC 'DATA'
EXTERN		SHRSEG: WORD
_DATA		ENDS

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOS16RGETSHRSEG
SELECTOR	DD	?
WNAME		DD	?
		@START	DOS16RGETSHRSEG

		MOV     AX,_DATA
		MOV     DS,AX
		ASSUME  DS:_DATA
		MOV     BX,[SHRSEG]
		MOV     AX,ERROR_FILE_NOT_FOUND 
		AND     BX,BX
		JZ      @F
		LDS     DI,[DS:BP].ARGS.SELECTOR
		MOV     [DI],BX
		XOR     AX,AX
@@:
		@EPILOG	DOS16RGETSHRSEG
_TEXT		ENDS

		END


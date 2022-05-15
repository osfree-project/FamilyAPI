;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosReallocSeg DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:dosreallocseg
;
;0 NO_ERROR
;8 ERROR_NOT_ENOUGH_MEMORY
;87 ERROR_INVALID_PARAMETER
;@todo if size = 0 then allocate max
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	bseerr.inc
		INCLUDE	dos.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOS16RREALLOCSEG
SELECTOR	DD	?
WSIZE		DW	?
		@START	DOS16RREALLOCSEG
		MOV	BX,[DS:BP].ARGS.WSIZE
		ADD	BX,0FH
		SHR	BX,1
		SHR	BX,1
		SHR	BX,1
		SHR	BX,1
		OR	BX,BX
		JNE	@F
		MOV	BX,01000H
@@:	
		MOV	AH,04AH
		INT	21H
		JB	EXIT
		LES	BX,[DS:BP].ARGS.SELECTOR
		MOV	[ES:BX],AX
		XOR	AX,AX
EXIT:	
		@EPILOG	DOS16RREALLOCSEG

_TEXT		ENDS

		END

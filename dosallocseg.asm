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
;@todo if size = 0 then allocate max
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSALLOCSEG
WSIZE		DW	?
SELECTOR	DD	?
ALLOCFLAGS	DW	?
		@START	DOSALLOCSEG
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
		MOV	AH,048H
		INT	21H
		JB	EXIT
		PUSH DS
		LDS	BX,[DS:BP].ARGS.SELECTOR
		MOV	[BX],AX
		POP	DS
		XOR	AX,AX
EXIT:	
		@EPILOG	DOSALLOCSEG

_TEXT		ENDS

		END

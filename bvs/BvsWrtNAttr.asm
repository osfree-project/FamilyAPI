;/*!
;   @file
;
;   @brief BvsWrtNAttr DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   * 0   NO_ERROR
;   * 355 ERROR_VIO_MODE
;   * 358 ERROR_VIO_ROW
;   * 359 ERROR_VIO_COL
;   * 436 ERROR_VIO_INVALID_HANDLE
;   * 465 ERROR_VIO_DETACHED
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE DOS.INC
		INCLUDE BSEERR.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BVSPROLOG	BVSWRTNATTR
VIOHANDLE	DW	?		;Video handle
COLUMN		DW	?		;Starting column position for output
ROW		DW	?		;Starting row position for output
CTIMES		DW	?		;Repeat count
ATTR		DD	?		;Character to be written
		@BVSSTART	BVSWRTNATTR
		MOV	CX,0040H
		push	CX
		pop	ES
		mov	AX,[BP+0Ah]
		mov	CL,ES:[04Ah]
		shl	CL,1
		mul	CL
		mov	DI,[BP+8]
		add	DI,DI
		add	DI,AX
		mov	AX,08000h
		cmp	word ptr ES:[063h],03B4h
		jne	@F
		xor	AX,AX
@@:	
		add	AX,ES:[04Eh]	;add video page offset
		add	DI,AX
		mov	cx, 0b800h
		push	cx
		pop	ES
		lds	SI,[BP+0Eh]
		mov	AL,[SI]			;get attribute to write
		mov	CX,[BP+0Ch]
        jcxz done
@@:
		inc	DI
		stosb
		loop @B
done:        
		@BVSEPILOG	BVSWRTNATTR

_TEXT		ENDS

		END

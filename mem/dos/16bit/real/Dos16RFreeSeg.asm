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

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOS16RFREESEG
SELECTOR	DW	?
		@START	DOS16RFREESEG
		MOV		AX,DS
		MOV		DX,[DS:BP].ARGS.SELECTOR
		CMP		AX,DX		;DONT FREE DS SEGMENT
		JZ		DONE

		FREE_MEMORY	[DS:BP].ARGS.SELECTOR
		MOV		AX,6
		JB		EXIT
DONE:
		XOR		AX,AX
EXIT:
		@EPILOG	DOS16RFREESEG

_TEXT		ENDS

		END

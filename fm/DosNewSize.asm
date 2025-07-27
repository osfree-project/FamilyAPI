;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosNewSize DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
; @ todo arguments checking
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSNEWSIZE
FILESIZE	DD	?	; [BP+6]
FILEHANDLE	DW	?	; [BP+10]
		@START	DOSNEWSIZE
		MOVE_PTR [BP].ARGS.FILEHANDLE, WORD PTR [BP].ARGS.FILESIZE+2, WORD PTR [BP].ARGS.FILESIZE, 0
		JB	EXIT
		WRITE_HANDLE [BP].ARGS.FILEHANDLE, [BP].ARGS.FILESIZE, 0  ;WRITE 0 BYTES
		JB	EXIT
		XOR	AX,AX
EXIT:
		@EPILOG	DOSNEWSIZE

_TEXT		ENDS

		END

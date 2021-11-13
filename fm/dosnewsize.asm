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
		INCLUDE	HELPERS.INC
		INCLUDE DOS.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSNEWSIZE
FILEHANDLE	DW	?
FILESIZE	DD	?
		@START	DOSNEWSIZE
		MOVE_PTR [DS:BP].ARGS.FILEHANDLE, WORD PTR [DS:BP].ARGS.FILESIZE+2, WORD PTR [DS:BP].ARGS.FILESIZE, 0
		JB	EXIT
		WRITE_HANDLE [DS:BP].ARGS.FILEHANDLE, [DS:BP].ARGS.FILESIZE, 0  ;WRITE 0 BYTES
		JB	EXIT
		XOR	AX,AX
EXIT:
		@EPILOG	DOSNEWSIZE

_TEXT		ENDS

		END

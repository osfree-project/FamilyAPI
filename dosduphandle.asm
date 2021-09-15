;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosDupHandle DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;
;
;--------D-2145-------------------------------
;INT 21 - DOS 2+ - "DUP" - DUPLICATE FILE HANDLE
;        AH = 45h
;        BX = file handle
;Return: CF clear if successful
;            AX = new handle
;        CF set on error
;            AX = error code (04h,06h) (see #01680 at AH=59h/BX=0000h)
;Notes:  moving file pointer for either handle will also move it for the other,
;          because both will refer to the same system file table
;        for DOS versions prior to 3.3, file writes may be forced to disk by
;          duplicating the file handle and closing the duplicate
;SeeAlso: AH=3Dh,AH=46h
;--------D-2146-------------------------------
;INT 21 - DOS 2+ - "DUP2", "FORCEDUP" - FORCE DUPLICATE FILE HANDLE
;        AH = 46h
;        BX = file handle
;        CX = file handle to become duplicate of first handle
;Return: CF clear if successful
;        CF set on error
;            AX = error code (04h,06h) (see #01680 at AH=59h/BX=0000h)
;Notes:  closes file with handle CX if it is still open
;        DOS 3.30 hangs if BX=CX on entry
;        moving file pointer for either handle will also move it for the other,
;          because both will refer to the same system file table
;SeeAlso: AH=3Dh,AH=45h
;
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE	DOS.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSDUPHANDLE
OLDFILEHANDLE	DW	?
NEWFILEHANDLE	DD	?
		@START	DOSDUPHANDLE
		MOV	BX, [DS:BP].ARGS.OLDFILEHANDLE
		LDS	BP, [DS:BP].ARGS.NEWFILEHANDLE
		MOV	CX, [DS:BP]
		CMP	CX, 0FFFFH
		JE	NEWHANDLE
		XDUP2	[DS:BP].ARGS.OLDFILEHANDLE, CX
		JMP	SKIP
NEWHANDLE:	
		XDUP	[DS:BP].ARGS.OLDFILEHANDLE
SKIP:
		JC	EXIT
		XOR	AX, AX
EXIT:
		@EPILOG	DOSDUPHANDLE

_TEXT		ENDS

		END

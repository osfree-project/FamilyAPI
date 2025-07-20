;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosGetDBCSEv DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
; --- int 21h, ax=6300h returns DBCS ptr in DS:SI
; http://www.os2museum.com/wp/is-it-so-hard-to-document-things/
; "So how to get the DBCS lead byte table without complicated DOS version checks
; and guesswork? It’s actually easy. The DS:SI registers should be set to 0:0
; before calling the API. If a valid DBCS lead byte table is returned, the DS:SI
; registers will be modified (the table can’t possibly be stored at 0:0). If DS:SI
; are still 0:0, the API is not implemented, the DOS is not a Far East version, and
; hence there are no double-byte characters and no lead byte table."
;
; 
;    NO_ERROR
;    396 ERROR_NLS_NO_COUNTRY_FILE
;    397 ERROR_NLS_OPEN_FAILED
;    398 ERROR_NO_COUNTRY_OR_CODEPAGE
;    399 ERROR_NLS_TABLE_TRUNCATED
;
; @todo extend to support also ah=65h to get info not for current country/codepage
; Format of DBCS lead byte table:
; Offset	Size	Description	)
; 00h	WORD	length of table in ranges
; 02h 2N BYTEs	start/end for N lead byte ranges
;	WORD	0000h	(end of table)
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	bseerr.inc

_TEXT	SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSGETDBCSEV
SLENGTH			DW	?
STRUCTURE		DD	?
MEMORYBUFFER	DD	?
		@START	DOSGETDBCSEV

		MOV		AX,ERROR_INVALID_PARAMETER

		; Check is buffer length are word aligned
		TEST	[DS:BP].ARGS.SLENGTH,01H
		JNZ		EXIT

		; Check is buffer length nonzero
		CMP		[DS:BP].ARGS.SLENGTH,0H
		JZ		EXIT

		; Check buffer pointer not null
		MOV		CX, WORD PTR [DS:BP].ARGS.MEMORYBUFFER
		OR		CX, WORD PTR [DS:BP].ARGS.MEMORYBUFFER+2
		JZ		EXIT

		; Zero DS:SI
		XOR		AX,AX
		MOV		DS,AX
		MOV		SI,AX

		; Get DBCS table
		MOV		AX,06300H
		INT		21H
        
		; Load destionation
		LES		DI,[DS:BP].ARGS.MEMORYBUFFER

		; If DS:SI still zero then no DBCS table
		MOV		CX,DS
		OR		CX,SI
		MOV		AX, ERROR_NLS_OPEN_FAILED
		JZ		BADEXIT
        
		; Calc size in words
		MOV		CX, [DS:BP].ARGS.SLENGTH
		SHR		CX,1
		; Set direction
		CLD
		
		; Copy until 0,0 or SLENGTH=0
@@:     
		LODSW
		STOSW
        AND		AX, AX
		JZ		EXIT	; End of table
		DEC		CX
		JNZ		@B

		; Buffer end, so revert on step back and fill end-of-table mark
		DEC		DI
		DEC		DI
		MOV		AX, ERROR_NLS_TABLE_TRUNCATED

BADEXIT:
		MOV		WORD PTR ES:[DI],0	;a pair of 0,0 marks end of DBCS table

EXIT:
		@EPILOG	DOSGETDBCSEV

_TEXT	ENDS

		END


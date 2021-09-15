;/*!
;   @file
;
;   @brief BvsWrtTTY DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viowrttty
;
;-----------------------------------------------------------------------------------
;INT 29 - DOS 2+ - FAST CONSOLE OUTPUT
;
;	AL = character to display
;Return: nothing
;	BX may be destroyed by some versions of DOS 3.3
;Notes:	automatically called when writing to a device with bit 4 of its device
;	  driver header set (see also INT 21/AH=52h)
;	COMMAND.COM v3.2 and v3.3 compare the INT 29 vector against the INT 20
;	  vector and assume that ANSI.SYS is installed if the segment is larger
;	the default handler under DOS 2.x and 3.x simply calls INT 10/AH=0Eh
;	the default handler under DESQview 2.2 understands the <Esc>[2J
;	  screen-clearing sequence, calls INT 10/AH=0Eh for all others
;SeeAlso: INT 21/AH=52h,INT 2F/AX=0802h,INT 79"AVATAR.SYS"
;-----------------------------------------------------------------------------------
;   0 NO_ERROR
;   355 ERROR_VIO_MODE
;   436 ERROR_VIO_INVALID_HANDLE
;   465 ERROR_VIO_DETACHED
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE DOS.INC
		INCLUDE BSEERR.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16
		@BVSPROLOG	BVSWRTTTY
VIOHANDLE	DW	?		;Video handle
SLENGTH		DW	?		;Length of string
CHARSTR		DD	?		;String to be written
		@BVSSTART	BVSWRTTTY

		EXTERN	VIOCHECKHANDLE: PROC
		MOV     BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

		MOV	CX,[DS:BP].ARGS.SLENGTH
		LDS	SI,[DS:BP].ARGS.CHARSTR
		JCXZ	DONE
NEXTITEM:
		LODSB
		INT	29H
		LOOP	NEXTITEM
DONE:		
		XOR	AX,AX
EXIT:
		@BVSEPILOG	BVSWRTTTY
        
_TEXT		ENDS

		END

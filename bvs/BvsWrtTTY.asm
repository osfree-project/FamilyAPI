;/*!
;   @file
;
;   @brief BvsWrtTTY DOS wrapper
;
;   (c) osFree Project 2008-2022, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viowrttty
;
;   0   NO_ERROR
;   355 ERROR_VIO_MODE
;   436 ERROR_VIO_INVALID_HANDLE
;   465 ERROR_VIO_DETACHED
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	bios.inc
		INCLUDE	bseerr.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16
		@BVSPROLOG	BVSWRTTTY
VIOHANDLE	DW	?		;Video handle
SLENGTH		DW	?		;Length of string
CHARSTR		DD	?		;String to be written
		@BVSSTART	BVSWRTTTY

		EXTERN	VIOCHECKHANDLE: PROC
		MOV	BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

		MOV	CX,[DS:BP].ARGS.SLENGTH
		LDS	SI,[DS:BP].ARGS.CHARSTR
		JCXZ	DONE
NEXTITEM:
		LODSB
		@WrtTTY	AL
		LOOP	NEXTITEM
DONE:		
		XOR	AX,AX
EXIT:
		@BVSEPILOG	BVSWRTTTY
        
_TEXT		ENDS

		END

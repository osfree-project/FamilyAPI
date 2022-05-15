;/*!
;   @file
;
;   @brief BvsShowBuf DOS wrapper
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
		INCLUDE	bseerr.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BVSPROLOG	BVSSHOWBUF
VioHandle	DW	?
SLength		DW	?
SOffset		DW	?
		@BVSSTART	BVSSHOWBUF

		EXTERN	VIOCHECKHANDLE: PROC
		MOV     BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

		XOR	AX, AX                   ; ALL OK

EXIT:
		@BVSEPILOG	BVSSHOWBUF

_TEXT		ENDS

		END

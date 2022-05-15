;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosQHandType DOS wrapper
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

		@PROLOG DOSQHANDTYPE
FILEHANDLE      DW	?		;FILE HANDLE TO Q
HANDTYPE        DD	?		;RETURN WORD
FLAGWORD        DD	?		;DEVICE DRIVER'S ATTRIBUTE
		@START DOSQHANDTYPE
		LES	DI,[DS:BP].ARGS.HANDTYPE
		IOCTL_DATA 0, [DS:BP].ARGS.FILEHANDLE
		MOV	AX,1		;???
		JB	EXIT
		TEST DL,080H	;DEVICE OR FILE?
		JNE	@F
		DEC	AX
@@:
		STOSB
		XOR	AX,AX
EXIT:
		@EPILOG DOSQHANDTYPE

_TEXT		ENDS

		END

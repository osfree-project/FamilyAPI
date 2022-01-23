;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosDevIOCtl2 DOS wrapper
;
;   (c) osFree Project 2022, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:dosdevioctl2
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE	BSEERR.INC


_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSDEVIOCTL2
		@START	DOSDEVIOCTL2
		XOR	AX,AX
EXIT:
		@EPILOG	DOSDEVIOCTL2

_TEXT		ENDS

		END

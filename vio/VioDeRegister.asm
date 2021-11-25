;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioDeRegister DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:vioderegister
;
;    0         NO_ERROR
;    404       ERROR_VIO_DEREGISTER
;    430       ERROR_VIO_ILLEGAL_DURING_POPUP
;    465       ERROR_VIO_DETACHED
;    494       ERROR_VIO_EXTENDED_SG
;
;*/

.8086

		INCLUDE	VIO.INC
		INCLUDE	ROUTE.INC
EXTERN	DOSFREEMODULE: FAR
_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		PUBLIC	VIODEREGISTER
VIODEREGISTER	PROC	FAR
		MOV	AX, AVSHANDLE		;Module handle
		PUSH	AX
		CALL	DOSFREEMODULE
		MOV	AX, 404
		JNZ	@F
		XOR	AX, AX
		MOV	WORD PTR VIOFUNCTIONMASK1, AX
		MOV	WORD PTR VIOFUNCTIONMASK1+2, AX
		MOV	WORD PTR VIOFUNCTIONMASK2, AX
		MOV	WORD PTR VIOFUNCTIONMASK2+2, AX
@@:
		RETF
VIODEREGISTER	ENDP

_TEXT		ENDS
		END

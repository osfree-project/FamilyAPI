;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief Family API implementation helpers
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


;------------------------------------------------------------
@VIOPROLOG	MACRO	NAME

;		INCLUDE	GLOBALSHARED.INC

		PUBLIC	NAME

VIOARGS		STRUC
		ENDM

;----------------------------------------------------------------------

@VIOSTART	MACRO	NAME
VIOARGS		ENDS

VIO_ARG_SIZE	EQU	(SIZE VIOARGS)

NAME		PROC	FAR
;		CALL	GLOBALINIT

		ENDM

;------------------------------------------------------------

@VIOEPILOG		MACRO	NAME
		RET	VIO_ARG_SIZE
NAME		ENDP
		ENDM

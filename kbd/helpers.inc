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
@KBDPROLOG	MACRO	NAME


		PUBLIC	NAME

KBDARGS		STRUC
		ENDM

;----------------------------------------------------------------------

@KBDSTART	MACRO	NAME
KBDARGS		ENDS

KBD_ARG_SIZE	EQU	(SIZE KBDARGS)

NAME		PROC	FAR

		ENDM

;------------------------------------------------------------

@KBDEPILOG		MACRO	NAME
		RET	KBD_ARG_SIZE
NAME		ENDP
		ENDM

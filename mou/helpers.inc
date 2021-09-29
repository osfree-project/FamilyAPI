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
@MOUPROLOG	MACRO	NAME


		PUBLIC	NAME

MOUARGS		STRUC
		ENDM

;----------------------------------------------------------------------

@MOUSTART	MACRO	NAME
MOUARGS		ENDS

MOU_ARG_SIZE	EQU	(SIZE MOUARGS)

NAME		PROC	FAR

		ENDM

;------------------------------------------------------------

@MOUEPILOG		MACRO	NAME
		RET	MOU_ARG_SIZE
NAME		ENDP
		ENDM

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

@PROLOG		MACRO	NAME

		EXTERN	@INIT : NEAR
		EXTERN	@INIT_STACK : NEAR
		EXTERN	@DONE : NEAR
		INCLUDE	GLOBALSHARED.INC

		PUBLIC	NAME

ARGS		STRUC
OLDBP		DW	?
RETADDR		DD	?
		ENDM

;----------------------------------------------------------------------

@START		MACRO	NAME, LSIZE
ARGS		ENDS

ARG_SIZE	EQU	(SIZE ARGS - 6)
IFB <LSIZE>
LOCSIZE		EQU	0
ELSE
LOCSIZE		EQU	LSIZE
ENDIF

NAME		PROC	FAR
		IFB	<LSIZE>
		CALL	@INIT
		ELSE
		MOV	AX, LSIZE
		CALL	@INIT_STACK
		ENDIF
		CALL	GLOBALINIT

		ENDM

;------------------------------------------------------------

@EPILOG		MACRO	NAME
@NAME@_EXIT:
		CALL	@DONE
		RET	ARG_SIZE+LOCSIZE
NAME		ENDP
		ENDM

;------------------------------------------------------------
@VIOPROLOG	MACRO	NAME

		INCLUDE	GLOBALSHARED.INC

		PUBLIC	NAME

VIOARGS		STRUC
		ENDM

;----------------------------------------------------------------------

@VIOSTART	MACRO	NAME
VIOARGS		ENDS

VIO_ARG_SIZE	EQU	(SIZE VIOARGS)

NAME		PROC	FAR
		CALL	GLOBALINIT

		ENDM

;------------------------------------------------------------

@VIOEPILOG		MACRO	NAME
		RET	VIO_ARG_SIZE
NAME		ENDP
		ENDM

;---------------------------------------------------------------BVS
@BVSPROLOG	MACRO	NAME

		EXTERN	@INIT : NEAR
		EXTERN	@INIT_STACK : NEAR
		EXTERN	@DONE : NEAR
		INCLUDE	GLOBALSHARED.INC

		PUBLIC	NAME

ARGS		STRUC
oldes		dw	?
oldsi		dw	?
OLDBP		DW	?		;tmp BP storage
RETADDR		DD	?		;BVSMAIN FAR Return address 
XOLDBP		DW	?		;tmp BP storage
VIOROUTIP       DW      ?               ;VIOROUT RETURN OFFSET
VIOROUTCS       DW      ?               ;VIOROUT RETURN SELECTOR
VIOROUTDS       DW      ?               ;VIOROUT DATA SELECTOR
VIOIP           DW      ?               ;VIOXXX RETURN OFFSET
VIOFUNC         DW      ?               ;VIOXXX FUNCTION CODE
USERIP          DW      ?               ;USER RETURN OFFSET
USERCS          DW      ?               ;USER RETURN SEGMENT
		ENDM

;----------------------------------------------------------------------

@BVSSTART	MACRO	NAME, LSIZE
ARGS		ENDS

ARG_SIZE	EQU	(SIZE ARGS - 26)
IFB <LSIZE>
LOCSIZE		EQU	0
ELSE
LOCSIZE		EQU	LSIZE
ENDIF

NAME		PROC	FAR
		IFB	<LSIZE>
		CALL	@INIT
		ELSE
		MOV	AX, LSIZE
		CALL	@INIT_STACK
		ENDIF
		CALL	GLOBALINIT

		ENDM

;------------------------------------------------------------

@BVSEPILOG	MACRO	NAME
		CALL	@DONE
		RET	ARG_SIZE+LOCSIZE
NAME		ENDP
		ENDM


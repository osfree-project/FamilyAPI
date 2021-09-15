;/*!
;   @file
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

;---------------------------------------------------------------BVS
@BVSPROLOG	MACRO	NAME

		EXTERN	@INIT : NEAR
		EXTERN	@INIT_STACK : NEAR
		EXTERN	@DONE : NEAR

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

		ENDM

;------------------------------------------------------------

@BVSEPILOG	MACRO	NAME
		CALL	@DONE
		RET	ARG_SIZE+LOCSIZE
NAME		ENDP
		ENDM


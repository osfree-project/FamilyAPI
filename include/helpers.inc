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

		INCL_VIO	EQU	1
include	bsesub.inc

; Local byte
@LOCALB		MACRO	NAME
DELTA		=	DELTA+1
NAME		CATSTR	<[BP->,%DELTA,<]>
		ENDM

; Local word
@LOCALW		MACRO	NAME
DELTA		=	DELTA+2
NAME		CATSTR	<[BP->,%DELTA,<]>
		ENDM

; Local dowble word
@LOCALD		MACRO	NAME
DELTA		=	DELTA+4
NAME		CATSTR	<[BP->,%DELTA,<]>
		ENDM

; Local structure
@LOCALS		MACRO	NAME, STRCT
DELTA		=	DELTA+SIZE STRCT
NAME		CATSTR	<[BP->,%DELTA,<]>
		ENDM

; Local byte array
@LOCALA		MACRO	NAME, SIZ
DELTA		=	DELTA+SIZ
NAME		CATSTR	<[BP->,%DELTA,<]>
		ENDM

@PROLOG		MACRO	NAME

		EXTERN	@INIT : NEAR
		EXTERN	@INIT_STACK : NEAR
		EXTERN	@DONE : NEAR
		INCLUDE	GlobalShared.inc

		PUBLIC	NAME

DELTA		=	0

ARGS		STRUC
OLDBP		DW	?
RETADDR		DD	?
		ENDM

;----------------------------------------------------------------------

@START		MACRO	NAME, LSIZE
ARGS		ENDS

ARG_SIZE	EQU	(SIZE ARGS - 6)
IFB <LSIZE>
LOCSIZE		EQU	DELTA
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

@EPILOG		MACRO	NAME
@NAME@_EXIT:
		CALL	@DONE
		RET	ARG_SIZE+LOCSIZE
NAME		ENDP
		ENDM

;------------------------------------------------------------VIO
@VIOPROLOG	MACRO	NAME

;		INCLUDE	GLOBALSHARED.INC

		PUBLIC	NAME

DELTA		=	0

@CATSTR(NAME,VIOARGS)		STRUC
		ENDM

;----------------------------------------------------------------------

@VIOSTART	MACRO	NAME
@CATSTR(NAME,VIOARGS)		ENDS
argsize=SIZE @CATSTR(NAME,VIOARGS)
@CATSTR(NAME,VIO_ARG_SIZE)	EQU	argsize

NAME		PROC	FAR
;		CALL	GLOBALINIT

		ENDM

;------------------------------------------------------------

@VIOEPILOG		MACRO	NAME
		RET	@CATSTR(NAME,VIO_ARG_SIZE)
NAME		ENDP
		ENDM


;---------------------------------------------------------------BVS
@BVSPROLOG	MACRO	NAME

		EXTERN	@INIT : NEAR
		EXTERN	@INIT_STACK : NEAR
		EXTERN	@DONE : NEAR

		PUBLIC	NAME

DELTA		=	0

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
LOCSIZE		EQU	DELTA
ELSE
LOCSIZE		EQU	LSIZE
ENDIF

NAME		PROC	NEAR
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


;-------------------------------------------------------------
@PUSHA	MACRO
		PUSH	AX
		PUSH	CX
		PUSH	DX
		PUSH	BX
		PUSH	BP
		PUSH	SI
		PUSH	DI
		PUSH	DS
		ENDM

@POPA	MACRO
		POP	DS
		POP	DI
		POP	SI
		POP	BP
		POP	BX
		POP	DX
		POP	CX
		POP	AX
		ENDM
;----------------------------------------------------------------


@TRACE	MACRO Name
		PUSHF
		@PUSHA
		@VioWrtTTY	@CATSTR(NAME, Msg), @CATSTR(NAME, MsgSize), 0
		@POPA
		POPF
		ENDM

;----------------------------------------------------------------

@tracemsg	macro	event
@CATSTR(event, Msg)			DB	@CATSTR( <!'>, event, <!'>), 0dh, 0ah
eventmsg=$-@CATSTR(event, Msg)
@CATSTR(event, MsgSize)		EQU	eventmsg
			endm

;----------------------------------------------------------------

@tracemsg2	macro	event
@tracemsg	@CATSTR(Pre, event)
@tracemsg	@CATSTR(Post, event)
			endm

;----------------------------------------------------------------

@tracecall	macro	event
event		proc
			@TRACE	event
			ret
event		endp
		endm

;----------------------------------------------------------------

@tracecall2	macro	event
@tracecall	@CATSTR(Pre, event)
@tracecall	@CATSTR(Post, event)
			endm

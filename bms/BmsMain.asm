;/*!
;   @file
;
;   @brief BmsMain entry point wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
; @todo add params checks
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		; OS/2
		INCLUDE bseerr.inc
INCL_MOU	EQU	1
		INCLUDE bsesub.inc


EXTERN	BMSGETNUMBUTTONS: PROC
EXTERN	BMSGETNUMMICKEYS: PROC
EXTERN	BMSGETDEVSTATUS	: PROC
EXTERN	BMSGETNUMQUEEL	: PROC
EXTERN	BMSREADEVENTQUE	: PROC
EXTERN	BMSGETSCALEFACT	: PROC
EXTERN	BMSGETEVENTMASK	: PROC
EXTERN	BMSSETSCALEFACT	: PROC
EXTERN	BMSSETEVENTMASK	: PROC
EXTERN	BMSGETHOTKEY	: PROC
EXTERN	BMSSETHOTKEY	: PROC
EXTERN	BMSOPEN		: PROC
EXTERN	BMSCLOSE	: PROC
EXTERN	BMSGETPTRSHAPE	: PROC
EXTERN	BMSSETPTRSHAPE	: PROC
EXTERN	BMSDRAWPTR	: PROC
EXTERN	BMSREMOVEPTR	: PROC
EXTERN	BMSGETPTRPOS	: PROC
EXTERN	BMSSETPTRPOS	: PROC
EXTERN	BMSINITREAL	: PROC
EXTERN	BMSFLUSHQUE	: PROC
EXTERN	BMSSETDEVSTATUS	: PROC


_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

bmstable:
	DW	BmsGetNumButtons	;00H
	DW	BmsGetNumMickeys	;01H
	DW	BmsGetDevStatus		;02H
	DW	BmsGetNumQueEl		;03H
	DW	BmsReadEventQue		;04H
	DW	BmsGetScaleFact		;05H
	DW	BmsGetEventMask		;06H
	DW	BmsSetScaleFact		;07H
	DW	BmsSetEventMask		;08H
	DW	BmsGetHotKey		;09H
	DW	BmsSetHotKey		;0AH
	DW	BmsOpen			;0BH
	DW	BmsClose		;0CH
	DW	BmsGetPtrShape		;0DH
	DW	BmsSetPtrShape		;0EH
	DW	BmsDrawPtr		;0FH
	DW	BmsRemovePtr		;10H
	DW	BmsGetPtrPos		;11H
	DW	BmsSetPtrPos		;12H
	DW	BmsInitReal		;13H
	DW	BmsFlushQue		;14H
	DW	BmsSetDevStatus		;15H

; This structure must be in sync with BMSPROLOG macro in helpers.inc
stackframe      STRUC                   ;Parameter Stack Area
oldes		dw	?
oldsi		dw	?
oldbp		dw	?
mouroutip       dw      ?               ;MOUROUTE return offset
mouroutcs       dw      ?               ;MOUROUTE return selector
mouroutds       dw      ?               ;MOUROUTE data selector
mouip           dw      ?               ;MOUxxx return offset
moufunc         dw      ?               ;MOUxxx Function code
userip          dw      ?               ;User return offset
usercs          dw      ?               ;User return segment
stackframe      ENDS

BMSMAIN		PROC FAR
		PUSH	BP
		PUSH	SI
		PUSH	ES
		MOV	BP, SP
		MOV	BX, [DS:BP].stackframe.moufunc
		CMP	BX, FC_MOUOPEN
		JE	SWITCH
		CMP	BX, FC_MOUCLOSE
		JE	SWITCH
		CMP	BX, FC_MOUINITREAL
		JE	SWITCH
		@MouSynch 1
SWITCH:
		SHL	BX, 1
		CALL	WORD PTR CS:bmstable[BX]
		MOV	SP,BP
		POP	ES
		POP	SI
		POP	BP
		RETF
BMSMAIN		ENDP

_TEXT		ENDS
		END

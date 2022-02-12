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


_DATA		SEGMENT BYTE PUBLIC 'DATA' USE16

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
_DATA	ENDS

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

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
		MOV	SI, SEG _DATA
		MOV	ES, SI
		MOV	SI, [DS:BP].stackframe.moufunc
		SHL	SI, 1
		CALL	WORD PTR es:bmstable[SI]
		MOV	SP,BP
		POP	ES
		POP	SI
		POP	BP
		RETF
BMSMAIN		ENDP

_TEXT		ENDS
		END

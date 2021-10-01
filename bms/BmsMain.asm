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
	DD	BmsGetNumButtons	;00H
	DD	BmsGetNumMickeys	;01H
	DD	BmsGetDevStatus		;02H
	DD	BmsGetNumQueEl		;03H
	DD	BmsReadEventQue		;04H
	DD	BmsGetScaleFact		;05H
	DD	BmsGetEventMask		;06H
	DD	BmsSetScaleFact		;07H
	DD	BmsSetEventMask		;08H
	DD	BmsGetHotKey		;09H
	DD	BmsSetHotKey		;0AH
	DD	BmsOpen			;0BH
	DD	BmsClose		;0CH
	DD	BmsGetPtrShape		;0DH
	DD	BmsSetPtrShape		;0EH
	DD	BmsDrawPtr		;0FH
	DD	BmsRemovePtr		;10H
	DD	BmsGetPtrPos		;11H
	DD	BmsSetPtrPos		;12H
	DD	BmsInitReal		;13H
	DD	BmsFlushQue		;14H
	DD	BmsSetDevStatus		;15H
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
		SHL	SI, 1
		CALL	FAR PTR es:bmstable[SI]
		MOV	SP,BP
		POP	ES
		POP	SI
		POP	BP
		RETF
BMSMAIN		ENDP

_TEXT		ENDS
		END

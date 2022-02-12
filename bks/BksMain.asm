;/*!
;   @file
;
;   @brief BksMain entry point wrapper
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

EXTERN	BKSCHARIN: PROC
EXTERN	BKSPEEK: PROC
EXTERN	BKSFLUSHBUFFER: PROC
EXTERN	BKSGETSTATUS: PROC
EXTERN	BKSSETSTATUS: PROC
EXTERN	BKSSTRINGIN: PROC
EXTERN	BKSOPEN: PROC
EXTERN	BKSCLOSE: PROC
EXTERN	BKSGETFOCUS: PROC
EXTERN	BKSFREEFOCUS: PROC
EXTERN	BKSGETCP: PROC
EXTERN	BKSSETCP: PROC
EXTERN	BKSXLATE: PROC
EXTERN	BKSSETCUSTXT: PROC
EXTERN	BKSGETHWID: PROC


_DATA		SEGMENT BYTE PUBLIC 'DATA' USE16

bkstable:
	DW	BKSCharIn		; 0
	DW	BKSPeek			; 1
	DW	BKSFlushBuffer		; 2
	DW	BKSGetStatus		; 3
	DW	BKSSetStatus		; 4
	DW	BKSStringIn		; 5
	DW	BKSOpen			; 6
	DW	BKSClose		; 7
	DW	BKSGetFocus		; 8
	DW	BKSFreeFocus		; 9
	DW	BKSGetCp		; 10
	DW	BKSSetCp		; 11
	DW	BKSXlate		; 12
	DW	BKSSetCustXt		; 13
	DW	BKSGetHWId		; 14
_DATA	ENDS

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

; This structure must be in sync with BVSPROLOG macro in helpers.inc
stackframe      STRUC                   ;Parameter Stack Area
oldes		dw	?
oldsi		dw	?
oldbp		dw	?
kbdroutip       dw      ?               ;KBDROUTE return offset
kbdroutcs       dw      ?               ;KBDROUTE return selector
kbdroutds       dw      ?               ;KBDROUTE data selector
kbdip           dw      ?               ;KBDxxx return offset
kbdfunc         dw      ?               ;KBDxxx Function code
userip          dw      ?               ;User return offset
usercs          dw      ?               ;User return segment
stackframe      ENDS

BKSMAIN		PROC FAR
		PUSH	BP
		PUSH	SI
		PUSH	ES
		MOV	BP, SP
		MOV	SI, SEG _DATA
		MOV	ES, SI
		MOV	SI, [DS:BP].stackframe.kbdfunc
		SHL	SI, 1
		CALL	WORD PTR es:bkstable[SI]
		MOV	SP,BP
		POP	ES
		POP	SI
		POP	BP
		RETF
BKSMAIN		ENDP

_TEXT		ENDS
		END

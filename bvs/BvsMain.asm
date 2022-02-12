;/*!
;   @file
;
;   @brief BvsMain entry point wrapper
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

EXTERN	BVSGETPHYSBUF: PROC
EXTERN	BVSGETBUF: PROC
EXTERN	BVSSHOWBUF: PROC
EXTERN	BVSGETCURPOS: PROC
EXTERN	BVSGETCURTYPE: PROC
EXTERN	BVSGETMODE: PROC
EXTERN	BVSSETCURPOS: PROC
EXTERN	BVSSETCURTYPE: PROC
EXTERN	BVSSETMODE: PROC
EXTERN	BVSREADCHARSTR: PROC
EXTERN	BVSREADCELLSTR: PROC
EXTERN	BVSWRTNCHAR: PROC
EXTERN	BVSWRTNATTR: PROC
EXTERN	BVSWRTNCELL: PROC
EXTERN	BVSWRTCHARSTR: PROC
EXTERN	BVSWRTCHARSTRATT: PROC
EXTERN	BVSWRTCELLSTR: PROC
EXTERN	BVSWRTTTY: PROC
EXTERN	BVSSCROLLUP: PROC
EXTERN	BVSSCROLLDN: PROC
EXTERN	BVSSCROLLLF: PROC
EXTERN	BVSSCROLLRT: PROC
EXTERN	BVSSETANSI: PROC
EXTERN	BVSGETANSI: PROC
EXTERN	BVSPRTSC: PROC
EXTERN	BVSSCRLOCK: PROC
EXTERN	BVSSCRUNLOCK: PROC
EXTERN	BVSSAVREDRAWWAIT: PROC
EXTERN	BVSSAVREDRAWUNDO: PROC
EXTERN	BVSPOPUP: PROC
EXTERN	BVSENDPOPUP: PROC
EXTERN	BVSPRTSCTOGGLE: PROC
EXTERN	BVSMODEWAIT: PROC
EXTERN	BVSMODEUNDO: PROC
EXTERN	BVSGETFONT: PROC
EXTERN	BVSGETCONFIG: PROC
EXTERN	BVSSETCP: PROC
EXTERN	BVSGETCP: PROC
EXTERN	BVSSETFONT: PROC
EXTERN	BVSGETSTATE: PROC
EXTERN	BVSSETSTATE: PROC

_DATA		SEGMENT BYTE PUBLIC 'DATA' USE16

bvstable:
	DW	BVSGetPhysBuf		; 0
	DW	BVSGetBuf		; 1
	DW	BVSShowBuf		; 2
	DW	BVSGetCurPos		; 3
	DW	BVSGetCurType		; 4
	DW	BVSGetMode		; 5
	DW	BVSSetCurPos		; 6
	DW	BVSSetCurType		; 7
	DW	BVSSetMode		; 8
	DW	BVSReadCharStr		; 9
	DW	BVSReadCellStr		; 10
	DW	BVSWrtNChar		; 11
	DW	BVSWrtNAttr		; 12
	DW	BVSWrtNCell		; 13
	DW	BVSWrtCharStr		; 14
	DW	BVSWrtCharStrAtt	; 15
	DW	BVSWrtCellStr		; 16
	DW	BVSWrtTTY		; 17
	DW	BVSScrollUp		; 18
	DW	BVSScrollDn		; 19
	DW	BVSScrollLf		; 20
	DW	BVSScrollRt		; 21
	DW	BVSSetAnsi		; 22
	DW	BVSGetAnsi		; 23
	DW	BVSPrtSc		; 24
	DW	BVSScrLock		; 25
	DW	BVSScrUnLock		; 26
	DW	BVSSavRedrawWait	; 27
	DW	BVSSavRedrawUndo	; 28
	DW	BVSPopUp		; 29
	DW	BVSEndPopUp		; 30
	DW	BVSPrtScToggle		; 31
	DW	BVSModeWait		; 32
	DW	BVSModeUndo		; 33
	DW	BVSGetFont		; 34
	DW	BVSGetConfig		; 35
	DW	BVSSetCp		; 36
	DW	BVSGetCp		; 37
	DW	BVSSetFont		; 38
	DW	BVSGetState		; 39
	DW	BVSSetState		; 40
_DATA	ENDS

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

; This structure must be in sync with BVSPROLOG macro in helpers.inc
stackframe      STRUC                   ;Parameter Stack Area
oldes		dw	?
oldsi		dw	?
oldbp		dw	?
vioroutip       dw      ?               ;VIOROUT return offset
vioroutcs       dw      ?               ;VIOROUT return selector
vioroutds       dw      ?               ;VIOROUT data selector
vioip           dw      ?               ;VIOxxx return offset
viofunc         dw      ?               ;VIOxxx Function code
userip          dw      ?               ;User return offset
usercs          dw      ?               ;User return segment
stackframe      ENDS

BVSMAIN		PROC FAR
		PUSH	BP
		PUSH	SI
		PUSH	ES
		MOV	BP, SP
		MOV	SI, SEG _DATA
		MOV	ES, SI
		MOV	SI, [DS:BP].stackframe.viofunc
		SHL	SI, 1
		CALL	WORD PTR es:bvstable[SI]
		MOV	SP,BP
		POP	ES
		POP	SI
		POP	BP
		RETF
BVSMAIN		ENDP

_TEXT		ENDS
		END

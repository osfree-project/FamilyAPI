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
	DD	BVSGetPhysBuf		; 0
	DD	BVSGetBuf		; 1
	DD	BVSShowBuf		; 2
	DD	BVSGetCurPos		; 3
	DD	BVSGetCurType		; 4
	DD	BVSGetMode		; 5
	DD	BVSSetCurPos		; 6
	DD	BVSSetCurType		; 7
	DD	BVSSetMode		; 8
	DD	BVSReadCharStr		; 9
	DD	BVSReadCellStr		; 10
	DD	BVSWrtNChar		; 11
	DD	BVSWrtNAttr		; 12
	DD	BVSWrtNCell		; 13
	DD	BVSWrtCharStr		; 14
	DD	BVSWrtCharStrAtt	; 15
	DD	BVSWrtCellStr		; 16
	DD	BVSWrtTTY		; 17
	DD	BVSScrollUp		; 18
	DD	BVSScrollDn		; 19
	DD	BVSScrollLf		; 20
	DD	BVSScrollRt		; 21
	DD	BVSSetAnsi		; 22
	DD	BVSGetAnsi		; 23
	DD	BVSPrtSc		; 24
	DD	BVSScrLock		; 25
	DD	BVSScrUnLock		; 26
	DD	BVSSavRedrawWait	; 27
	DD	BVSSavRedrawUndo	; 28
	DD	BVSPopUp		; 29
	DD	BVSEndPopUp		; 30
	DD	BVSPrtScToggle		; 31
	DD	BVSModeWait		; 32
	DD	BVSModeUndo		; 33
	DD	BVSGetFont		; 34
	DD	BVSGetConfig		; 35
	DD	BVSSetCp		; 36
	DD	BVSGetCp		; 37
	DD	BVSSetFont		; 38
	DD	BVSGetState		; 39
	DD	BVSSetState		; 40
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
		SHL	SI, 1
		CALL	FAR PTR es:bvstable[SI]
		MOV	SP,BP
		POP	ES
		POP	SI
		POP	BP
		RETF
BVSMAIN		ENDP

_TEXT		ENDS
		END

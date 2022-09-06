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

; BMSMAIN expects in AX function code
;
BMSMAIN		PROC FAR
		PUSH	BP
		MOV	BP, SP
		@PUSHA
		MOV	BX, AX
		CMP	BX, FC_MOUOPEN
		JE	SWITCH
		CMP	BX, FC_MOUCLOSE
		JE	SWITCH
		CMP	BX, FC_MOUINITREAL
		JE	SWITCH
		@MouSynch 1
SWITCH:
		SHL	BX, 1
		JMP	WORD PTR CS:bmstable[BX]

BmsGetNumButtons:
		@DosDevIOCtl	[DS:BP].ARGS.NUMBEROFBUTTONS, , MOU_GETBUTTONCOUNT, IOCTL_POINTINGDEVICE, [DS:BP-4]
		JMP	EXIT

BmsGetNumMickeys:
		@DosDevIOCtl	[DS:BP].ARGS.NUMBEROFMICKEYS, , MOU_GETMICKEYCOUNT, IOCTL_POINTINGDEVICE, [DS:BP-4]
		JMP	EXIT

BmsGetDevStatus:
		@DosDevIOCtl	[DS:BP].ARGS.DEVICESTATUS, , MOU_GETMOUSTATUS, IOCTL_POINTINGDEVICE, [DS:BP-4]
		JMP	EXIT


BmsGetNumQueEl:
		@DosDevIOCtl	[DS:BP].ARGS.QUEDATARECORD, , MOU_GETQUESTATUS, IOCTL_POINTINGDEVICE, [DS:BP-4]
		JMP	EXIT


BmsReadEventQue:
!!! move to dosdevioctl !!!
		@MouStatus
		LES	SI, [DS:BP].ARGS.BUFFER
		MOV	[ES:SI].MOUEVENTINFO.mouev_row, DX
		MOV	[ES:SI].MOUEVENTINFO.mouev_col, CX
		MOV	[ES:SI].MOUEVENTINFO.mouev_fs, BX
		@GetTime
		mov	WORD PTR [ES:SI].MOUEVENTINFO.mouev_time,CX
		mov	WORD PTR [ES:SI].MOUEVENTINFO.mouev_time+2,DX
		JMP	EXIT


BmsGetScaleFact:
		@DosDevIOCtl	[DS:BP].ARGS.SCALESTRUCT, , MOU_GETSCALEFACTORS, IOCTL_POINTINGDEVICE, [DS:BP-4]
		JMP	EXIT


BmsGetEventMask:
		@DosDevIOCtl	[DS:BP].ARGS.EVENTMASK, , MOU_GETEVENTMASK, IOCTL_POINTINGDEVICE, [DS:BP-4]
		JMP	EXIT


BmsSetScaleFact:
		@DosDevIOCtl	, [DS:BP].ARGS.SCALESTRUCT, MOU_SETSCALEFACTORS, IOCTL_POINTINGDEVICE, [DS:BP-4]
		JMP	EXIT


BmsSetEventMask:
		@DosDevIOCtl	, [DS:BP].ARGS.EVENTMASK, MOU_SETEVENTMASK, IOCTL_POINTINGDEVICE, [DS:BP-4]
		JMP	EXIT


BmsGetHotKey:
		@DosDevIOCtl	[DS:BP].ARGS.BUTTONMASK, , MOU_GETHOTKEYBUTTON, IOCTL_POINTINGDEVICE, [DS:BP-4]
		JMP	EXIT


BmsSetHotKey:
		@DosDevIOCtl	, [DS:BP].ARGS.BUTTONMASK, MOU_SETHOTKEYBUTTON, IOCTL_POINTINGDEVICE, [DS:BP-4]
		JMP	EXIT


BmsOpen:
!!! Fix it !!!
		@MouInit
		CMP	AX, 0FFFFH
		MOV	AX, ERROR_MOUSE_NO_DEVICE
		JNZ	EXIT
		XOR	AX,AX
		JMP	EXIT


BmsClose:
		JMP	EXIT


BmsGetPtrShape:
		@DosDevIOCtl	[DS:BP].ARGS.PTRBUFFER, [DS:BP].ARGS.PTRDEFREC, MOU_GETPTRSHAPE, IOCTL_POINTINGDEVICE, [DS:BP-4]
		JMP	EXIT


BmsSetPtrShape:
		@DosDevIOCtl	[DS:BP].ARGS.PTRBUFFER, [DS:BP].ARGS.PTRDEFREC, MOU_SETPTRSHAPE, IOCTL_POINTINGDEVICE, [DS:BP-4]
		JMP	EXIT


BmsDrawPtr:
		@DosDevIOCtl	, , MOU_DRAWPTR, IOCTL_POINTINGDEVICE, [DS:BP].ARGS.MOUHANDLE
		JMP	EXIT


BmsRemovePtr:
		@DosDevIOCtl	, [DS:BP].ARGS.PTRAREA, MOU_MARKCOLLISIONAREA, IOCTL_POINTINGDEVICE, [DS:BP-4]
		JMP	EXIT


BmsGetPtrPos:
		@DosDevIOCtl	[DS:BP].ARGS.PTRPOS, , MOU_GETPTRPOS, IOCTL_POINTINGDEVICE, [DS:BP-4]
		JMP	EXIT


BmsSetPtrPos:
		@DosDevIOCtl	, [DS:BP].ARGS.PTRPOS, MOU_MARKCOLLISIONAREA, IOCTL_POINTINGDEVICE, [DS:BP-4]
		JMP	EXIT


BmsInitReal:
		JMP	EXIT


BmsFlushQue:
		JMP	EXIT


BmsSetDevStatus:
		@DosDevIOCtl	, [DS:BP].ARGS.DEVICESTATUS, MOU_SETMOUSTATUS, IOCTL_POINTINGDEVICE, [DS:BP-4]

EXIT:
		@POPA
		MOV	SP,BP
		POP	BP
		RETF
BMSMAIN		ENDP

;---------------------------------------------------------------BMS
@BMSPROLOG	MACRO	NAME

		EXTERN	@INIT : NEAR
		EXTERN	@INIT_STACK : NEAR
		EXTERN	@DONE : NEAR

		PUBLIC	NAME

DELTA		=	0

ARGS		STRUC
oldes		dw	?
oldsi		dw	?
OLDBP		DW	?		;tmp BP storage
RETADDR		DD	?		;BMSMAIN FAR Return address 
XOLDBP		DW	?		;tmp BP storage
MOUROUTIP       DW      ?               ;MOUROUTE RETURN OFFSET
MOUROUTCS       DW      ?               ;MOUROUTE RETURN SELECTOR
MOUROUTDS       DW      ?               ;MOUROUTE DATA SELECTOR
MOUIP           DW      ?               ;MOUXXX RETURN OFFSET
MOUFUNC         DW      ?               ;MOUXXX FUNCTION CODE
USERIP          DW      ?               ;USER RETURN OFFSET
USERCS          DW      ?               ;USER RETURN SEGMENT
		ENDM

;----------------------------------------------------------------------

@BMSSTART	MACRO	NAME, LSIZE
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

@BMSEPILOG	MACRO	NAME
		CALL	@DONE
		RET	ARG_SIZE+LOCSIZE
NAME		ENDP
		ENDM


_TEXT		ENDS
		END

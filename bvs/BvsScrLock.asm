;/*!
;   @file
;
;   @brief BvsScrLock DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;  * 0          NO_ERROR 
;  * 366        ERROR_VIO_WAIT_FLAG 
;  * 430        ERROR_VIO_ILLEGAL_DURING_POPUP 
;  * 434        ERROR_VIO_LOCK 
;  * 436        ERROR_VIO_INVALID_HANDLE 
;  * 465        ERROR_VIO_DETACHED 
;  * 494        ERROR_VIO_EXTENDED_SG
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BVSPROLOG	BVSSCRLOCK
VIOHANDLE	DW	?
STATUS		DD	?
WAITFLAG	DW	?
		@BVSSTART	BVSSCRLOCK

		EXTERN	VIOCHECKHANDLE: PROC
		MOV     BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

;		SUB     AX,AX				; Zero already
		LES     DI,DWORD PTR [DS:BP].ARGS.STATUS
		STOSB
EXIT:
		@BVSEPILOG	BVSSCRLOCK

_TEXT		ENDS

		END


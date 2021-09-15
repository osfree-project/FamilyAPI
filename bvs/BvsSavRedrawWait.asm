;/*!
;   @file
;
;   @brief BvsSavRedrawWait DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE DOS.INC
		INCLUDE BSEERR.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16


		@BVSPROLOG	BVSSAVREDRAWWAIT
VIOHANDLE	DW	?		;Video handle
NOTIFYTYPE	DD	?		;
SAVREDRAWINDIC	DW	?		;
		@BVSSTART	BVSSAVREDRAWWAIT

		EXTERN	VIOCHECKHANDLE: PROC
		MOV     BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

		XOR     AX,AX                    ; ALL IS OK

EXIT:
		@BVSEPILOG	BVSSAVREDRAWWAIT
_TEXT	ENDS
	END


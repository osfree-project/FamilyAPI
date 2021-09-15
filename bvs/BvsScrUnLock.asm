;/*!
;   @file
;
;   @brief BvsScrUnLock DOS wrapper
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

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE BSEERR.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BVSPROLOG	BVSSCRUNLOCK
VIOHANDLE	DW	?
		@BVSSTART	BVSSCRUNLOCK

		EXTERN	VIOCHECKHANDLE: PROC
		MOV     BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

;	        XOR	AX, AX				;zero alredy Good return code
EXIT:
		@BVSEPILOG	BVSSCRUNLOCK

_TEXT		ENDS

		END

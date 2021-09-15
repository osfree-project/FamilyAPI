;/*!
;   @file
;
;   @brief BvsReadCharStr DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE DOS.INC
		INCLUDE BSEERR.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BVSPROLOG	BVSREADCHARSTR
VIOHANDLE	DW	?		;Video handle
COLUMN		DW	?		;Starting column
ROW		DW	?		;Starting row
SLENGTH		DD	?
CHARSTR		DD	?
		@BVSSTART	BVSREADCHARSTR

EXTERN		VIOGOTOXYH: PROC
		MOV     BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		MOV     CX,[DS:BP].ARGS.ROW		; GET ROW
		MOV     DX,[DS:BP].ARGS.COLUMN		; GET COLUMN
		CALL	VIOGOTOXYH
		JNZ	EXIT

		MOV     AX,0B800H               ; OFFSET FOR COLOR CARD
		MOV     SI,DI                   ; GET THE ADDRESS AS SOURCE INDEX???
		MOV     DS,AX                   ; DS:SI IS NOW SET UP

		LES     DI,[DS:BP].ARGS.SLENGTH              ; GET LENGTH POINTER
		MOV     CX,ES:[DI]              ; GET LENGTH
		LES     DI,[DS:BP].ARGS.CHARSTR              ; GET THE POINTER IN ES:DI

F13_100:
		MOVSB                           ; MOVE A BYTE
		INC     DI                      ; GET PAST ATTRIBUTE
		LOOP    F13_100                 ; DO THE NEXT ONE

		XOR     AX,AX                    ; SUCCESSFUL RETURN
EXIT:
		@BVSEPILOG	BVSREADCHARSTR

_TEXT		ENDS
		END


;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioReadCharStr DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:vioreadcharstr
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOREADCHARSTR
VIOHANDLE	DW	?		;Video handle
COLUMN		DW	?		;Starting column
ROW		DW	?		;Starting row
SLENGTH		DD	?
CHARSTR		DD	?
		@VIOSTART	VIOREADCHARSTR
	        MOV	AX, VI_VIOREADCHARSTR
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK1
		AND	AX, LOWWORD VR_VIOREADCHARSTR
		CMP	AX, LOWWORD VR_VIOREADCHARSTR
	        CALL    VIOROUTE
		@VIOEPILOG	VIOREADCHARSTR

_TEXT		ENDS
		END

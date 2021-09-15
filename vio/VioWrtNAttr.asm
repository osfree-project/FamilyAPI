;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioWrtNAttr DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viowrtnattr
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOWRTNATTR
VIOHANDLE	DW	?		;Video handle
COLUMN		DW	?		;Starting column position for output
ROW		DW	?		;Starting row position for output
CTIMES		DW	?		;Repeat count
ATTR		DD	?		;Character to be written
		@VIOSTART	VIOWRTNATTR
	        MOV	AX, VI_VIOWRTNATTR
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK1
		AND	AX, LOWWORD VR_VIOWRTNATTR
		CMP	AX, LOWWORD VR_VIOWRTNATTR
	        CALL    VIOROUTE
		@VIOEPILOG	VIOWRTNATTR
_TEXT		ENDS

		END

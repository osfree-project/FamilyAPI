;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioGetPhysBuf DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viogetphysbuf
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16


		@VIOPROLOG	VIOGETPHYSBUF
RESERVED	DW	?		;
DISPLAYBUF	DD	?		;
		@VIOSTART	VIOGETPHYSBUF
	        MOV	AX, VI_VIOGETPHYSBUF
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK1
		AND	AX, LOWWORD VR_VIOGETPHYSBUF
		CMP	AX, LOWWORD VR_VIOGETPHYSBUF
	        CALL    VIOROUTE
		@VIOEPILOG	VIOGETPHYSBUF
_TEXT		ENDS
		END

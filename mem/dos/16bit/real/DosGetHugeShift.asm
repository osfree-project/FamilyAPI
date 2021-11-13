;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosGetHugeShift DOS wrapper
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
		INCLUDE	helpers.inc
_GINFOSEG	SEGMENT BYTE PUBLIC 'DATA' USE16
EXTERN gis_cHugeShift:BYTE
_GINFOSEG	ENDS

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSGETHUGESHIFT
SHIFTCOUNT	DD	?
		@START	DOSGETHUGESHIFT
		MOV		AX, _GINFOSEG
		MOV		ES,AX
		XOR		AX, AX
		MOV		AL,[ES:gis_cHugeShift]
		LDS		BX,[DS:BP].ARGS.SHIFTCOUNT
		MOV		[BX],AX
		XOR		AX,AX
		@EPILOG	DOSGETHUGESHIFT

_TEXT		ENDS

		END

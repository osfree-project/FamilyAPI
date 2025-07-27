;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosQVerify DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;--------D-2154-------------------------------
;INT 21 - DOS 2+ - GET VERIFY FLAG
;        AH = 54h
;Return: AL = verify flag
;            00h off
;            01h on (all disk writes verified after writing)
;SeeAlso: AH=2Eh
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSQVERIFY
VERIFYSETTING	DD	?	; pointer to USHORT
		@START	DOSQVERIFY
		GET_VERIFY
		LDS	BP, [BP].ARGS.VERIFYSETTING
		XOR	AH, AH
		MOV	[BP], AX
		XOR	AL, AL
		@EPILOG	DOSQVERIFY

_TEXT		ENDS

		END

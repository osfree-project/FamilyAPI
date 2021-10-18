;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosGetEnv DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
; --------D-2162-------------------------------
;INT 21 - DOS 3.0+ - GET CURRENT PSP ADDRESS
;        AH = 62h
;Return: BX = segment of PSP for current process
;Notes:  this function does not use any of the DOS-internal stacks and may
;          thus be called at any time, even during another INT 21h call
;        the current PSP is not necessarily the caller's PSP
;        identical to the undocumented AH=51h
;SeeAlso: AH=50h,AH=51h
;
; @todo add DOS 2.0 support
;
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE DOS.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSGETENV
CMDOFFSET	DD	?
ENVSEGMENT	DD	?
		@START	DOSGETENV
		GET_PSP
		MOV	ES,BX
		MOV	ES,ES:[02CH]
		XOR	DI,DI
		XOR	AL,AL
		MOV	CX,0FFFFH
NEXTLINE:		
		REPNE SCASB
		SCASB
		JNE	NEXTLINE
		MOV	AX, ES
		LES	BX,[DS:BP].ARGS.ENVSEGMENT
		MOV	[ES:BX],AX
		LES	BX,[DS:BP].ARGS.CMDOFFSET
		ADD	DI,2
		MOV	[ES:BX],DI
		XOR	AX,AX
		@EPILOG	DOSGETENV

_TEXT		ENDS

		END

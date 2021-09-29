;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosBeep DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:dosbeep
;
;0 NO_ERROR
;395 ERROR_INVALID_FREQUENCY
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC

		; Error codes
		INCLUDE	BSEERR.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG		DOSBEEP
DURATION	DW	?
FREQUENCY	DW	?
		@START		DOSBEEP
		
		MOV		AX, ERROR_INVALID_FREQUENCY
		MOV		CX,[DS:BP].ARGS.FREQUENCY
		CMP		CX, 37
		JB		EXIT_ERROR
		CMP		CX, 32767
		JA		EXIT_ERROR
		MOV		DX,[DS:BP].ARGS.DURATION
		CMP		DX, 0
		JE		EXIT_OK
		CLI
		IN		AL,061H
		PUSH		AX
OUTERLOOP:
		AND		AL,0FCH
		OUT		061H,AL
		PUSH		CX
		SHR		CX,1
		SHR		CX,1
		SHR		CX,1
		SHR		CX,1
INNERLOOP1:
		IN		AL,61H
		AND		AL,10H
		CMP		AL,AH
		MOV		AH,AL
		JZ		INNERLOOP1
		LOOP		INNERLOOP1
		POP		CX
		OR		AL,2
		OUT		061H,AL
		PUSH		CX
		SHR		CX,1
		SHR		CX,1
		SHR		CX,1
		SHR		CX,1
INNERLOOP2:    
		IN		AL,61H
		AND		AL,10H
		CMP		AL,AH
		MOV		AH,AL
		JZ		INNERLOOP2
		LOOP		INNERLOOP2
		POP		CX
		DEC		DX
		JNE		OUTERLOOP
		POP		AX
		OUT		061H,AL
		STI
EXIT_OK:		
		XOR		AX,AX
EXIT_ERROR:		
		@EPILOG		DOSBEEP

_TEXT		ENDS

		END

;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosSleep DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;
;INT 15 - BIOS - WAIT (AT,PS)
;
;	AH = 86h
;	CX:DX = interval in microseconds
;Return: CF clear if successful (wait interval elapsed)
;	CF set on error or AH=83h wait already in progress
;	    AH = status (see #00496)
;Note:	the resolution of the wait period is 977 microseconds on many systems
;	  because many BIOSes use the 1/1024 second fast interrupt from the AT
;	  real-time clock chip which is available on INT 70; because newer
;	  BIOSes may have much more precise timers available, it is not
;	  possible to use this function accurately for very short delays unless
;	  the precise behavior of the BIOS is known (or found through testing)
;SeeAlso: AH=41h,AH=83h,INT 1A/AX=FF01h,INT 70
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE DOS.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSSLEEP
TIMEINTERVAL	DD	?
		@START	DOSSLEEP

		MOV CX,WORD PTR [DS:BP].ARGS.TIMEINTERVAL
		MOV DX,WORD PTR [DS:BP].ARGS.TIMEINTERVAL+2
;		MOV AX,CX
;		OR AX,DX
;		JNZ @F
;		MOV AX,1680H
;		INT 2FH
;		JMP EXIT
@@:
		MOV AX,CX
		MOV CX,1000	;INT 15H EXPECTS MICROSECONDS IN CX:DX
		MUL CX
		MOV CX,AX
		XCHG CX,DX
		MOV AH,86H
		INT 15H
EXIT:
		XOR AX,AX
		
		@EPILOG	DOSSLEEP

_TEXT		ENDS

		END

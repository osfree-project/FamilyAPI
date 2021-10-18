
		.8086

		public	DOSEXIT

		include dos.inc

_TEXT	segment byte public 'CODE' use16

DOSEXIT:
		mov	BP,SP
		mov	AX,[BP+4]
		or	AH,AH
		je	@F
		mov	AL,0FFh
@@:
		END_PROCESS AL
        
_TEXT	ends

	end

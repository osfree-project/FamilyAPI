
		.8086

		public	DOSEXIT

_TEXT	segment byte public 'CODE' use16

DOSEXIT:
		mov	BP,SP
		mov	AX,[BP+4]
		or	AH,AH
		je	@F
		mov	AL,0FFh
@@:
		mov	AH,04Ch
		int	21h
        
_TEXT	ends

	end

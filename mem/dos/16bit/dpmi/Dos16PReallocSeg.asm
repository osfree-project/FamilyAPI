
		.286

		PUBLIC	DOS16PREALLOCSEG
_TEXT  segment byte public 'CODE'

;--- DosReallocSeg reallocs only until 64 kB

GlobalReAlloc proto far pascal :WORD, :DWORD, :WORD

DOS16PREALLOCSEG proc far pascal public wSize:WORD, wSel:WORD

		pusha
		push es
		xor dx,dx
		mov ax,wSize
		cmp ax,1			;convert size 0 to size 64 kb
		adc dx,dx
		invoke	GlobalReAlloc, wSel, dx::ax,0
		.if (ax)
			xor ax,ax
		.else
;			mov ax,-1
			mov ax,0008		;ERROR_NOT_ENOUGH_MEMORY
		.endif
		mov [bp-2],ax	;set AX in POPA on stack
		pop es
		popa
		ret
DOS16PREALLOCSEG endp

_TEXT ends

		end

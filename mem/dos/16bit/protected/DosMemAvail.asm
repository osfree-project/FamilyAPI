
		.286

		public DOSMEMAVAIL
        
_TEXT  segment byte public 'CODE'

DOS16PMEMAVAIL proc far pascal public pShift:far16 ptr WORD
		push	ds
        push	bx
		mov		ax,3
        lds		bx,pShift
        mov		[bx],ax
        xor		ax,ax
        pop		bx
		pop		ds        
        ret
DOS16PMEMAVAIL endp

_TEXT  ends

end


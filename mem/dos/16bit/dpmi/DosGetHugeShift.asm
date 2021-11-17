
		.286

		public DOSHUGESHIFT, DOSHUGEINCR, DOS16PGETHUGESHIFT
        
DOSHUGESHIFT equ 0003
DOSHUGEINCR  equ 0008
        
_TEXT  segment byte public 'CODE'

DOS16PGETHUGESHIFT proc far pascal public pShift:far16 ptr WORD
		push	ds
        push	bx
		mov		ax,3
        lds		bx,pShift
        mov		[bx],ax
        xor		ax,ax
        pop		bx
		pop		ds        
        ret
DOS16PGETHUGESHIFT endp

_TEXT  ends

end


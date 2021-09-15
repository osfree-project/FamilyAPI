
		.8086

        public  DOSSETMAXFH

_TEXT  segment byte public 'CODE'

DOSSETMAXFH:
        push    BP
        mov     BP,SP
        push    BX
        push    CX
        push    DX
        push    DI
        push    SI
        mov     BX,[BP+6]
        mov     ax,6700h
        int     21h
        xor     ax,ax
        pop     SI
        pop     DI
        pop     DX
        pop     CX
        pop     BX
        pop     BP
        retf    2
_TEXT  ends

	end

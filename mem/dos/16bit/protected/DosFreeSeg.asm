
		.286

        public  DOS16PFREESEG

_TEXT  segment byte public 'CODE'

DOS16PFREESEG:
        push    BP
        mov     BP,SP
        push    ES
        push    DX
        mov     AX,DS
        mov		DX,[BP+6]
        cmp     AX,DX		;dont free DS segment
        jz      done
        mov     ES,DX
        mov     AH,049h
        int     21h
        mov		AX,6
        jb      exit
done:
        xor     AX,AX
exit:
		pop     DX
        pop     ES
        pop     BP
        retf    2

_TEXT  ends

end


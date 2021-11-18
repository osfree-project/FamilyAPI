
        .286

        public  DOS16PALLOCSHRSEG

_data   segment byte public 'DATA'
shrseg dw 0
_data   ends

_TEXT  segment byte public 'CODE'

        assume cs:_TEXT

DOS16PALLOCSHRSEG:
        push    BP
        mov     BP,SP
        push    DS
        push    DI
        push    bx
        mov     AX,_data
        mov     ds,ax
        assume  ds:_data
        cmp     word ptr shrseg,0
        jz      @F
        mov     ax,00B7h
        jmp     sm1
@@:
        mov     bx,[bp+14]
        shr     bx,4
        inc     bx
        mov     ah,48h
        int     21h
        mov     bx,ax
        mov     ax,8
        jc      sm1
        mov     ax,_data
        mov     ds,ax
        mov     shrseg,bx
        lds     DI,[BP+6]
        mov     [DI],bx
        xor     AX,AX
sm1:
        pop     bx
        pop     DI
        pop     DS
        pop     BP
        retf    0Ah


_TEXT  ends

end


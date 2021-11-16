
        .286

        public  DOSGETSHRSEG

_data   segment byte public 'DATA'
shrseg dw 0
_data   ends

_TEXT  segment byte public 'CODE'

        assume cs:_TEXT



DOS16PGETSHRSEG PROC FAR

        push    BP
        mov     BP,SP
        push    DS
        push    DI
        push    bx
        mov     AX,_data
        mov     ds,ax
        assume  ds:_data
        mov     bx,[shrseg]
        mov     ax,0002h
        and     bx,bx
        jz      @F
        lds     DI,[BP+6]
        mov     [DI],BX
        xor     AX,AX
@@:
        pop     bx
        pop     DI
        pop     DS
        pop     BP
        retf    8

DOS16PGETSHRSEG    ENDP

_TEXT  ends

end



;*** free a NE module

		.8086
        
        externdef FREELIBRARY:far

        public  DOSFREEMODULE
        
_TEXT  segment byte public 'CODE'

DOSFREEMODULE:

if 0
        mov     AX,SS
        mov     DS,AX
        mov     ES,AX
endif

        push    BP
        mov     BP,SP
        push    BX
        push    CX
        push    DX
        push    ES
        push    [BP+6]
        call    FREELIBRARY	;FreeLibrary has no documented return value
        xor     AX,AX
        pop     ES
        pop     DX
        pop     CX
        pop     BX
        pop     BP
        retf    2
_TEXT  ends

		end
        

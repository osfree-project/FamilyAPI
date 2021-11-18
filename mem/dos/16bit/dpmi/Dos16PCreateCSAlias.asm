		.286

		public DOS16PCREATECSALIAS

_TEXT  segment byte public 'CODE'
        
DOS16PCREATECSALIAS proc

        mov     bx,cs
        mov     ax,000Ah
        int     31h
        jc      @F
        push    ds
        mov     ds,ax
        assume  ds:_TEXT
;        mov     ds:[__csalias],ax
        pop     ds
@@:
		ret
DOS16PCREATECSALIAS endp

_TEXT  ends
	
    end

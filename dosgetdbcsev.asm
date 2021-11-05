;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosGetDBCSEv DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSGETDBCSEV
SLength		DW	?
Structure	DD	?
MemoryBuffer	DD	?
		@START	DOSGETDBCSEV
;--- int 21h, ax=6300h returns DBCS ptr in DS:SI
;--- so save these values before call
;--- and then check if they have been modified.
;--- Carry Flag is not an indicator for success/failure for this function

		mov		BX,DS
        mov		CX,SI

        mov     AX,06300h
        int     21h
        
        les     DI,[BP+6]
        
        mov     DX,DS
        cmp     BX,DX
        je      nosupp
        cmp     CX,SI
        je      nosupp
        
        mov     CX,[BP+0Eh]
        shr		cx,1
        jcxz	done
@@:     
        lodsw
        stosw
        and		ax,ax
        loopnz  @B
        jmp		done
nosupp:
        mov     CX,[BP+0Eh]
        cmp     CX,2
        jb      done
        mov     word ptr es:[DI],0	;a pair of 00,00 marks end of DBCS table

done:
        xor     AX,AX
		@EPILOG	DOSGETDBCSEV

_TEXT		ENDS

		END


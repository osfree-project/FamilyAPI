;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosSetCtryCode DOS wrapper
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

		@PROLOG	DOSSETCTRYCODE
CNTRYCODE	DD	?
		@START	DOSSETCTRYCODE
            lds      si,[bp].ARGS.CNTRYCODE
            mov      ax,word ptr [si]      ; get country code
            mov      cx,255
            cmp      ax,cx                 ; check for country code >= 255
            jl       okay                  ; branch if less

            mov      bx,ax                 ; if so, load into bx
            mov      al,cl                 ; and set flag
okay:       mov      dx,0ffffh             ; Set DX

            mov      ah,38h                ; DOS INT function code
            int      21h                   ; set country information
            jc       exit                  ; branch if error

            sub      ax,ax                 ; set good return
exit:
		@EPILOG	DOSSETCTRYCODE

_TEXT		ENDS

		END

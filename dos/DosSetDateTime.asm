;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosSetDateTime DOS wrapper
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
		INCLUDE	dos.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

error_ts_datetime equ 0002h

		@PROLOG	DOSSETDATETIME
DateTime	DD	?
		@START	DOSSETDATETIME

		LDS	SI, [DS:BP].ARGS.DateTime
		SET_DATE WORD PTR [DS:SI+6],  BYTE PTR [DS:SI+5], BYTE PTR [DS:SI+4]
		PUSH	AX
		SET_TIME BYTE PTR [DS:SI], BYTE PTR [DS:SI+1], BYTE PTR [DS:SI+2], BYTE PTR [DS:SI+3]
	    pop      bx
	    mov      cl,0
	    cmp      bl,cl		   ; return code from time set
	    jnz      error
	    cmp      al,0		   ; return code from date set
	    jz	     exit

error:	    mov      ax,error_ts_datetime  ; set error code
	    jmp      short exit1

exit:	    sub      ax,ax		   ; set good return code
exit1:
		@EPILOG	DOSSETDATETIME

_TEXT		ENDS

		END

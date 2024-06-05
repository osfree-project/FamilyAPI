;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosQCurDisk DOS wrapper
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

defdrive	db	?	; Save area for default drive -->RW

	    extrn    DOSDEVCONFIG:far

buffer	segment word public 'buffer'
drive	dw	?	      ; driver number
buffr	db	20 dup(?)     ; buffer
bufflng dw	20	      ; buffer length
map	dw	2 dup(?)      ; map area
dsket	db	?	      ;
buffer	ends

		@PROLOG	DOSQCURDISK
DRVMAP		DD	?
DRIVENUMBER	DD	?
		@START	DOSQCURDISK

		CURRENT_DISK
		CBW
		INC	AX
		LDS	SI,[DS:BP].ARGS.DRIVENUMBER
		MOV	[SI],AX
	    mov      ax,buffer		 ; prepare data segment
	    mov      ds,ax		 ; register for calls

	    assume   ds:buffer

	    lea      di,dsket		 ; diskette address
	    push     ds
	    push     di
	    mov      ax,2		 ; request diskette count
	    push     ax
	    sub      ax,ax		 ; reserved parm
	    push     ax

	    call     DOSDEVCONFIG	 ; get number of drives

	    cmp      dsket,0		 ; if none, jump
	    je	     nodisk
	    stc 			 ; else set flag
	    jmp      short dskbits

nodisk:     clc 			 ; clear flag

dskbits:    mov      map+2,0		 ; clear output areas
	    mov      map,0
	    pushf			 ; save carry status, then
	    rcr      map+2,1		 ; set flags for devices
	    popf			 ; A and B
	    rcr      map+2,1

	    mov      drive,2		 ; start at C  -->RW --> Changed 3 to 2
	    mov      di,2		 ; start with low-order
loopx:
	mov	ah,0eh			; DOS Select Disk -->RW
	mov	dx,drive		; Drive number in DL -->RW
	int	021h			;  -->RW

	mov	ah,019h 		; DOS Get Current Disk -->RW
	int	021h			;  -->RW
	xor	ah,ah			; Clear AH -->RW
	cmp	ax,drive		; Drive now in AX -->RW

	    je	     driveok		 ; drive at this number
	    clc 			 ; else drive no good
	    jmp      short rotate

driveok:    stc

rotate:     rcr      map[di],1		 ; shift bit in
	    inc      drive
	    cmp      drive,17		 ; finished first word?
	    jl	     loopx		  ; if no, jump
	    mov      di,0		 ; if so, switch to high
	    cmp      drive,26		 ; order word, and check
	    jle      loopx		  ; for last drive.
				;restore current drive
	mov	ah,0eh			; DOS Select Disk -->RW
	mov	dl,defdrive		; Drive number in DL -->RW
	int	021h			;  -->RW

	    mov      cl,6		 ; only ten bits used
	    shr      map,cl		 ; in high-order word.
	    mov      ax,map		 ; Now put in registers
	    mov      bx,map+2		 ; for shift into output
	    push     cs 		 ; area.
	    pop      ds
	    lds      si,[bp].ARGS.DRVMAP	 ;
	    mov      [si],ax
	    mov      [si]+2,bx		 ;
					 ; Set good return code -->RW
		XOR	AX,AX
EXIT:
		@EPILOG	DOSQCURDISK

_TEXT		ENDS

		END

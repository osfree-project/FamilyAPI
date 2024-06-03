;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosPutMessage DOS wrapper
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

_TEXT		SEGMENT DWORD PUBLIC 'CODE' USE16

		@PROLOG	DOSPUTMESSAGE
MessageBuffer	DD	?
MessageLength	DW	?
FileHandle	DW	?
		@START	DOSPUTMESSAGE
	mov	bx,[bp].ARGS.FileHandle		      ; get handle
	mov	cx,[bp].ARGS.MessageLength	      ; get message length
	lds	dx,[bp].ARGS.MessageBuffer	      ; setup message buffer

	mov	ah,40h			      ; load opcode
	int	21h			      ; display message
	jc	ErrorExit		      ; jump if error

	xor	ax,ax			      ; else set good return code

ErrorExit:
		@EPILOG	DOSPUTMESSAGE

_TEXT		ENDS

		END

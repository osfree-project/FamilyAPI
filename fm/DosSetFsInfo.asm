;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosSetFsInfo DOS wrapper
;
;   (c) osFree Project 2022, <http://www.osFree.org>
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
		INCLUDE	bseerr.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

;-----------------------------------------------
;---	Extended FCB, used to delete Volume Labels.
;-----------------------------------------------
Ext_FCB 	db	0FFh			;Indicates extended FCB
		db	0,0,0,0,0		;Reserved
FCB_Attr	db	08			;Attribute for vol label
FCBDrive	db	0			;Drive number
VLabel		db	"???????????"           ;Match any vol name found
		db	25 dup (0)		;Rest of the opened FCB

		@PROLOG DOSSETFSINFO
sbufsize dw	?	; info buffer size
sbuffoff dw	?	; info buffer offset
sbuffseg dw	?	; info buffer segment
slevel	dw	?	; info level
sdrive	dw	?	; drive number
		@START	DOSSETFSINFO
	mov	ax,[bp].ARGS.sdrive	; Get drive number
	mov	FCBDrive,al	; Place it in the extended FCB
;--------------------------
;-- FCB Delete old volume label
;--------------------------
	mov	ah,013h 	; FCB Delete
	push	cs
	pop	ds
	mov	dx,offset Ext_FCB
	int	021h		; Call DOS to delete volume label
;---------------------------------
;-- Handle_Create new Volume label
;---------------------------------
	mov	cx,08h		; Volume label attribute
	mov	ah,03ch 	; Handle create new volume label
	mov	dx,[bp].ARGS.sbuffoff
	push	[bp].ARGS.sbuffseg
	pop	ds
	int	021h		; Do it
	jc	retrn		; Oops, there was an error. Not surprised...
;--------------------------
;-- Close the Volume Label
;--------------------------
	mov	bx,ax		; Place handle in BX
	mov	ah,03eh 	; Close the volume label
	int	021h		; Do IT!


deleted:
	sub	ax,ax		   ; set good return code
retrn:
		@EPILOG DOSSETFSINFO

_TEXT		ENDS

		END

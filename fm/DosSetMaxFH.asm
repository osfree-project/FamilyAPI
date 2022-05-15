;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosSetMaxFH DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
; @todo: for future new DosOpen need to reallocate FAPI handle table

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSSETMAXFH
NUMBERHANDLES	DW	?
		@START	DOSSETMAXFH
	        mov     BX,[DS:BP].ARGS.NUMBERHANDLES
	        mov     ax,6700h
	        int     21h
	        xor     ax,ax
		@EPILOG	DOSSETMAXFH

_TEXT		ENDS
		END
